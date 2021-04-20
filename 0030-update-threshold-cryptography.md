# HIP 30: Switch to BLS12-381 for Threshold Cryptography

- Author(s): [@vihu](http://github.com/vihu) - Helium Engineer, [@Vagabond](https://github.com/vagabond/) - Helium VP of Engineering
- Start Date: 2021-04-19
- Category: Technical
- Original HIP PR: [#155](https://github.com/helium/HIP/pull/155)
- Tracking Issue: TBD

# Summary
[summary]: #summary

Helium [Distributed Key Generation](https://github.com/helium/erlang-dkg) and [Honeybadger Consensus Protocol](https://github.com/helium/erlang-hbbft) both rely on curve SS512 for pairing based cryptography.

Curve SS512 is a very old curve and is not commonly used anymore. In addition the library we used to do pairing based cryptography, Ben Lynn's [pbc library](https://crypto.stanford.edu/pbc/thesis.html), has not seen major maintenance since 2013.
This HIP proposes switching to an industry standard curve BLS12-381 for doing threshold cryptography.
The underlying implementation for BLS12-381 is security audited, faster and more secure than curve SS512.
We present a complete and functional implementation of a system to switch the fundamental threshold cryptography library that has been tested and has been in use on the validator testnet for several weeks.
# Motivation
[motivation]: #motivation

There are several good reasons to switch to curve BLS12-381 from existing curve SS512:

- BLS12-381 targets 128 bits of security, however actual security level of the curve is estimated between 117-120 bits, this is still significantly higher than the 80 bits that SS512 provides. 
- Notably faster than SS512 when doing polynomial multiplications.
- Provides primitives for exotic cryptography functions such as digital threshold signatures and aggregate signatures.
- Potential to increase the number of consensus group and DKG members.
- Several existing protocols like Zcash, Ethereum 2.0, Skale, Algorand, Dfinity, Chia etc use BLS12-381 to perform digital signatures and threshold cryptography.

# Stakeholders
[stakeholders]: #stakeholders

This change should not affect any current Hotspot owners or HNT holders as it
is a purely backend change to the network.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

The explanation of curve BLS12-381 itself is beyond the scope of this HIP. However, [hackmd](https://hackmd.io/@benjaminion/bls12-381) provides an excellent explanation of the working of the curve.

An outline of the changes required to make BLS12-381 work with the existing network looks like the following:

- Add support for understanding BLS12-381 curve in erlang

    The team has been building a compatibility layer [erlang-tc]() to use in erlang for [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) which provides bindings to BLS12-381 curve functions. The rust code has been security audited.

- Add support for BLS12-381 based threshold cryptography to DKG

    In parallel the team has been working on adding BLS12-381 compatibility to [erlang-dkg](https://github.com/helium/erlang-dkg). This work has been done in [erlang-dkg#36](https://github.com/helium/erlang-dkg/pull/36).

- Add support for BLS12-381 based threshold cryptography to HBBFT

    Simultaneously the team has been working on adding BLS12-381 compatibility to [erlang-hbbft](). The progress of this work is available in [hbbft#66](https://github.com/helium/erlang-hbbft/pull/66).

- Update miner to use new HBBFT and DKG

    In order to make the switch to BLS12-381, the team has implemented a miner compatibility layer, the progress of which can be followed in [miner#733](https://github.com/helium/miner/pull/733).

# Drawbacks
[drawbacks]: #drawbacks

We don't believe there are any drawbacks to this approach. In fact, we believe that this work is absolutely critical to ensure that Helium follows the latest industry security standards to remain competitive.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

In attempting to grow the size of the consensus group on the testnet we were unable to exceed 40 nodes as elections would fail after that point.

Alternatives include simply doing nothing and continuing to use our existing code, implementing a new library ourselves from scratch or finding an alternative library.

We believe this library to be the best choice as it's already been written and has been audited.

On the testnet, with these changes, we were able to exceed a group size of 60 and are able to run stably with a group size in the mid 50s. Since these protocols do not scale linearly (it's more like cubic scaling), this is a more significant improvement than it would appear.

# Unresolved Questions
[unresolved]: #unresolved-questions

None

# Deployment Impact
[deployment-impact]: #deployment-impact

We've written a compatibility layer that allows hbbft to handle either kind of key. The network will continue to use the current SS512 key during an upgrade to BLS12-381. Once all nodes are updated with the new DKG elections will start producing BLS12-381 keys and hbbft will seamlessly switch over to using them instead.

Thus we do not expect any deployment impact beyond a potentially long election epoch as the network upgrades.

# Success Metrics
[success-metrics]: #success-metrics

This will be a successful upgrade to entire network security essentially increasing our security many folds over while also allowing us to scale further as the network continues to grow.
