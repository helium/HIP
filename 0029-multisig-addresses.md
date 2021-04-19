# HIP 29: Multisig transactions

- Author(s): @xandkar, Helium Team; @Vagabond, Helium Team.
- Start Date: 2021-04-19
- Category: economic, technical
- Original HIP PR:
- Tracking Issue:

# Summary
[summary]: #summary

Add  a new type of public key and a new type of signature, which are composites
of the scalar public keys and signatures combined with a specification for the
minimal subset of signatures required to make a transaction.

# Motivation
[motivation]: #motivation

New ways and interesting ways to organize asset ownership, such as:
- joint account
- backup in case of key loss
- additional security via multi-factor verification
- ...

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
