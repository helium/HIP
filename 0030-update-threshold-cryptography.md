# HIP 30: Switch to BLS12-381 for Threshold Cryptography

- Author(s): [@vihu](http://github.com/vihu), [@Vagabond](https://github.com/vagabond/), Helium Systems, Inc. team
- Start Date: 2021-04-19
- Category: Technical
- Original HIP PR: [#155](https://github.com/helium/HIP/pull/155)
- Tracking Issue: [#158](https://github.com/helium/HIP/issues/158)
- Status: Deployed (2021-05-04)

# Summary
[summary]: #summary

Helium [Distributed Key Generation](https://github.com/helium/erlang-dkg) and [Honeybadger Consensus Protocol](https://github.com/helium/erlang-hbbft) both rely on curve SS512 for pairing-based cryptography. Curve SS512 is considered a very old curve and is not commonly used. In addition, the library we use for pairing-based cryptography, Ben Lynn's [pbc library](https://crypto.stanford.edu/pbc/thesis.html), has not seen major maintenance since 2013.

This HIP proposes switching to an industry standard curve BLS12-381 for doing threshold cryptography. The underlying implementation for BLS12-381 is security-audited, faster, and more secure than curve SS512.

We have been testing a new threshold cryptography library that has been in use on the Validator Testnet for several weeks and believe it is ready for Mainnet.

# Motivation
[motivation]: #motivation

There are several good reasons to switch to curve BLS12-381 from the existing curve SS512:

- BLS12-381 targets 128 bits of security, however actual security level of the curve is estimated between 117-120 bits. This is still significantly higher than the 80 bits that SS512 provides.
- BLS12-381 is notably faster than SS512 at polynomial multiplication.
- BLS12-381 provides primitives for exotic cryptography functions such as digital threshold signatures and aggregate signatures.
- Implementing BLS12-381 creates a potential to increase the number of Consensus Group and DKG members.
- Several existing protocols like Zcash, Ethereum 2.0, Skale, Algorand, Dfinity, Chia, etc use BLS12-381 to perform digital signatures and threshold cryptography.

# Stakeholders
[stakeholders]: #stakeholders

This change should not affect any current Hotspot owners or HNT holders as it is a purely backend change to the network.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

The explanation of curve BLS12-381 itself is beyond the scope of this HIP. However, [Ben Edgington](https://hackmd.io/@benjaminion/bls12-381) provides an excellent explanation of how the curve works.

An outline of the changes required to make BLS12-381 work with the Helium network looks like the following:

- **Add support for understanding BLS12-381 curve in Erlang**

    The team has been building a compatibility layer [erlang-tc](https://github.com/helium/erlang-tc) to use in Erlang for [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) which provides bindings to BLS12-381 curve functions. The Rust code has been security audited.

- **Add support for BLS12-381 based threshold cryptography to DKG**

    In parallel, the team has been working on adding BLS12-381 compatibility to [erlang-dkg](https://github.com/helium/erlang-dkg). This work has been done in [erlang-dkg#36](https://github.com/helium/erlang-dkg/pull/36).

- **Add support for BLS12-381 based threshold cryptography to HBBFT**

    The team has also been working on adding BLS12-381 compatibility to [erlang-hbbft](https://github.com/helium/erlang-hbbft). The progress of this work is available in [hbbft#66](https://github.com/helium/erlang-hbbft/pull/66).

- **Update miner to use new HBBFT and DKG**

    In order to make the switch to BLS12-381, the team has implemented a miner compatibility layer, the progress of which can be followed in [miner#733](https://github.com/helium/miner/pull/733).

# Drawbacks
[drawbacks]: #drawbacks

We don't believe there are any drawbacks to this approach. In fact, we believe that this work is absolutely critical to ensure that the Helium network follows the latest industry security standards to remain competitive.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

We were unable to expand the Testnet Consensus Group past 40 nodes as elections would begin to fail around that group size. We found that the existing DKG with curve SS512 is the primary culprit here. This becomes a greater risk to network security as the network grows to 100s of thousands of nodes and more users expect network stability and security.

On the Testnet, with these changes, we were able to exceed a group size of 60 and are able to run stably with a group size in the mid 50s. Since these protocols do not scale linearly (it's more like cubic scaling), this is a significant improvement.

We don't believe that the alternative of doing nothing makes sense either. We also would like to avoid creating a new library ourselves and haven't been successful in finding an an acceptable alternative that meets all of our criteria.

We believe this library and this implementation is the best choice for the Helium network as it has already been written and has passed a security audit.

# Unresolved Questions
[unresolved]: #unresolved-questions

None

# Deployment Impact
[deployment-impact]: #deployment-impact

We've written a compatibility layer that allows HBBFT to handle either kind of key. The network will continue to use the current SS512 key during an upgrade to BLS12-381. Once all nodes are updated with the new DKG, elections will start producing BLS12-381 keys and HBBFT will seamlessly switch over to using them instead.

Thus, we do not expect any deployment impact beyond a potentially long election epoch as the network upgrades.

# Success Metrics
[success-metrics]: #success-metrics

The upgrade will be considered successful if it continues to support the number of Hotspots coming online in the coming months and years. It will also be successful if we are able to increase the Mainnet Consensus Group size and improve network security.
