# HIP 29: Multi-signature Keys

- Author(s): [@xandkar](http://github.com/xandkar), [@Vagabond](http://github.com/Vagabond), Helium Systems, Inc. team
- Start Date: 2021-04-19
- Category: Technical
- Original HIP PR: [#154](https://github.com/helium/HIP/pull/154)
- Tracking Issue:  [#157](https://github.com/helium/HIP/issues/157)
- Status: Deployed (2021-05-04)

# Summary
[summary]: #summary

Hotspot owners, HNT holders, and other Helium participants, have different ways
to organize assets. This HIP proposes a multi-signature key which can be used
to authorize a transaction on the Helium blockchain. This key is a composite of
the scalar keys which can be combined to generate a minimal subset of
signatures required to make a valid transaction.

# Motivation
[motivation]: #motivation

We have already seen that Hotspot owners are already engaging in interesting
ways to own their Hotspots off-chain. This HIP proposes a way to allow for the
following:

- Dividing up the responsibility of various assets (Hotspots, Validators, OUIs,
  HST, HNT, etc.) across multiple participants. This enables joint accounts and
  shared custody.
- Making it substantially more difficult for a compromise of an entire wallet
  due to a single key. This improves security via multi-owner verification.
- Creating a M of N backup where a loss of a single key does not cause a loss
  of the entire wallet.

Multi-signature keys are seen in many other blockchains and enable security
applications not listed above.

# Stakeholders
[stakeholders]: #stakeholders

This change should not affect any current asset owners as it is a purely
additive change to existing key types.

We believe that this feature will enable new ownership organization of assets
like Hotspots, Validators, OUIs, HNT, HST, etc.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Currently, a wallet address is derived from a single public key owned by a
single private key. This private key is required to sign any transaction
involving the address.

We propose:

1. an address scheme composed of a multihash digest of `N` public keys and a
   specification of the number of signatures required to approve a transaction:
   `M` such that `0 < M <= N`;
2. a signature scheme composed of `N` public keys and `M` corresponding
   signatures;
3. conditions for verification of the above composite signature, given the
   above composite public key;
4. an implementation of all of the above.

### Format

Roughly, the schemes are:
1. Multi-signature public key: `| net-type | key-type | m | n | multihash-digest-of-n-public-keys |`;
2. Multi-signature: `| public-key[0]..public-key[n-1] | isig[1]..isig[m] |`.

More precisely, given a sequence of `n` public keys:
`public-key[0]..public-key[n-1]`, a `multihash-digest-of-n-public-keys` is its
multihash digest and `isig[1]..isig[m]` is a sequence of triples: `i | len |
sig` where `i` is the index into the preceding sequence of public keys, `len`
is the length of the following signature (in bytes) and `sig` is the signature.

#### Illustration:

##### Multi-signature public key

      net-type   key-type   m        n        multihash-digest-of-n-public-keys
    +----------+----------+--------+--------+-----------------------------------+
    | 4 bits   | 4 bits   | 8 bits | 8 bits | variable length                   |
    +----------+----------+--------+--------+-----------------------------------+

##### Multi-signature

      pub keys          isigs
    +-----------------+------------------+
    | variable length | variable length  |
    +-----------------+------------------+

Due to variable lengths of the components, parsing of the multi-signature
requires knowledge of:
1. `N` from the corresponding multi-pub-key;
2. length of each scalar key type (type itself is encoded, but the length
   corresponding to type is not, so must be known in advance).

### Verification

After parsing the scalar components of the multi-pub-key and multi-signature,
we consider the multi-signature to be valid if _all_ of the following
conditions are true:
1. we have at least `M` scalar signatures within the composite multi-signature;
2. _all_ of the provided scalar signature triples _uniquely_ point to a public
   key within `0..N-1` range (i.e. any isig containing an-already-seen index -
   invalidates the multi-signature);
3. at least `M` of the scalar signatures pass verification.

# Drawbacks
[drawbacks]: #drawbacks

We don't believe there are any drawbacks to this approach. In fact, it is an
in-place upgrade to the existing supported key types.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

An alternative that was considered, but rejected, was to have separate on-chain
multisignature transactions as we do for the `vars_v1` transaction. This
approach to multisignature keys makes that approach unnecessary. We do not, at
this time, intend to update `vars_v1` but may do so at a later date.

# Unresolved Questions
[unresolved]: #unresolved-questions

# Deployment Impact
[deployment-impact]: #deployment-impact

We don't believe there is any deployment impact as this approach is additive
to existing key types.

# Success Metrics
[success-metrics]: #success-metrics

This will be a successful feature if we see applications of multi-signature
keys on chain.
