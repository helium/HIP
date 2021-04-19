# HIP 29: Multi-signature Keys

- Author(s): @xandkar, Helium Team; @Vagabond, Helium Team.
- Start Date: 2021-04-19
- Category: technical
- Original HIP PR: [#154](https://github.com/helium/HIP/pull/154)
- Tracking Issue:  <!-- TODO -->

# Summary
[summary]: #summary

Helium Hotspot owners and HNT holders have different ways to organize assets.
This HIP proposes a multi-signature key whihch can be used to authorize a
transaction on the Helium blockchain. This key is a composite of the scalar
keys which can be combined to generate a minimal subset of signatures required
to make a valid transaction.

# Motivation
[motivation]: #motivation

We have already seen that Hotspot owners are already engaging in interesting
ways to own their Hotspots off-chain. This HIP proposes a way to allow for the
following:

- Dividing up the responsiblity of Hotspots, OUIs, and HNT across multiple
  participants. This enables joint accounts and shared custody.
- Making it substantially more difficult for a compromise of an entire wallet
  due to a single key. This improves security via multi-owner verification.
- Creating a M of N backup where a loss of a single key does not cause a loss
  of the entire wallet.

Multi-signature keys are seen in many other blockchains and enable security
applications not listed above.

# Stakeholders
[stakeholders]: #stakeholders


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Currently an address is a single public key owned my a single private key.
The single owner is required to sign a transaction involving the address.

We propose:

1. address scheme composed of a multihash digest of `N` public keys and a
   specification of the number of signatures required to approve a transaction:
   `M` such that `0 < M <= N`;
2. signature scheme composed of `N` public keys and `M` corresponding signatures;
3. algorithm for verification of the above composite signature, given the above
   composite public key.

### format
Roughly, the schemes are:
1. Multi-pub-key: `| net-type | key-type | m | n | multihash-digest-of-n-pub-keys |`;
2. Multi-signature: `| pub-key[0]..pub-key[n-1] | isig[1]..isig[m] |`.

More-precisely, given a sequence N public keys: `pub-key[0]..pub-key[n-1]`,
a `multihash-digest-of-n-pub-keys` is its multihash digest and `isig[1]..isig[m]`
is a sequence of triples: `i | len | sig` where `i` is the index into the
preceding sequence of public keys, `len` is the length of the following
signature (in bytes) and `sig` is the signature.

#### Illustration:

##### Multi-pub-key

      net type   key type   M        N        multihash-digest-of-N-pub-keys
    +----------+----------+--------+--------+--------------------------------+
    | 4 bits   | 4 bits   | 8 bits | 8 bits | variable length                |
    +----------+----------+--------+--------+--------------------------------+

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

### verification

After parsing the scalar components of the multi-pub-key and multi-signature,
we consider the signature to be valid if all of the following is true:
1. we have at least M scalar signatures within the composite multi-signature;
2. _all_ of the provided signatures _uniquely_ point to a public key within 0..N-1;
3. at least M of the scalar signatures pass verification.

# Drawbacks
[drawbacks]: #drawbacks


# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives


# Unresolved Questions
[unresolved]: #unresolved-questions


# Deployment Impact
[deployment-impact]: #deployment-impact


# Success Metrics
[success-metrics]: #success-metrics
