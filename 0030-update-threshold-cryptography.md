# HIP 30: Switch to BLS12-381 for Threshold Cryptography

- Author(s): [@vihu](http://github.com/vihu), [@Vagabond](https://github.com/vagabond/)
- Start Date: 2021-04-19
- Category: Technical
- Original HIP PR: TBD
- Tracking Issue: TBD

# Summary
[summary]: #summary

Helium [Distributed Key Generation](https://github.com/helium/erlang-dkg) and [Honeybadger Consensus Protocol](https://github.com/helium/erlang-hbbft) both rely on curve SS512 for pairing based cryptography.
This HIP proposes switching to an industry standard curve BLS12-381 for doing threshold cryptography.
The underlying implementation for BLS12-381 is security audited, faster and more secure than curve SS512.

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

    In parallel the team has been working on adding BLS12-381 compatibility to [erlang-dkg](https://github.com/helium/erlang-dkg). Most of this work is already being done in [erlang-dkg#36](https://github.com/helium/erlang-dkg/pull/36).

- Add support for BLS12-381 based threshold cryptography to HBBFT

    Simultaneously the team has been working on adding BLS12-381 compatibility to [erlang-hbbft](). The progress of this work is available in [hbbft#66](https://github.com/helium/erlang-hbbft/pull/66).

- Update miner to use new HBBFT and DKG

    In order to actually make the switch to BLS12-381 actually work the team has begun working on miner compatibility layer, the progress can be followed in [miner#733](https://github.com/helium/miner/pull/733).

# Drawbacks
[drawbacks]: #drawbacks

We don't believe there are any drawbacks to this approach. In fact, we believe that this work is absolutely critical to ensure that Helium follows the latest industry security standards to remain competitive.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

None

# Unresolved Questions
[unresolved]: #unresolved-questions

None

# Deployment Impact
[deployment-impact]: #deployment-impact

TBD

# Success Metrics
[success-metrics]: #success-metrics

This will be a successful upgrade to entire network security essentially increasing our security many folds over while also allowing us to scale further as the network continues to grow.
