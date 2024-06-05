# HIP 124: Securing IOT Governance Through Staking Rewards

- Authors: [BFGNeil](https://github.com/BFGNeil), [Siegfried-B](https://github.com/Siegfried-B), [Ferebee](https://github.com/ferebee)
- Start Date: 2024-05-13
- Category: Economic, Governance
- Original HIP PR: [#1011](https://github.com/helium/HIP/pull/1011)
- Tracking Issue: [#1013](https://github.com/helium/HIP/issues/1013)
- Vote Requirements: veIOT

---

## Summary

This Helium Improvement Proposal (HIP) aims to increase voting turnout. It suggests to achieve this goal indirectly by paying rewards for locking IOT, thus reducing the cost of acquiring voting power (veIOT).

## Motivation

People who want to vote on HIPs concerning the IOT network need to acquire voting power in the form of veIOT. To acquire veIOT, potential voters need to lock IOT tokens.
IOT that is locked cannot be moved or sold. This can be seen as a cost of voting that disincentivizes potential voters from HIP voting and lowers voting turnout.

HIP 52 specified a reward bucket of 7% of total IOT emissions to rewarded Oracles to be shared with veIOT that is delegated to these Oracles. As rewarded Oracles aren't live yet, this bucket is unused (the tokens are instantly burned instead).

Once decentralized Oracles are live and reward veIOT delegated to them, the cost of locking IOT will be offset to a significant degree for all veIOT that is delegated to Oracles. The current disincentive for participation in HIP votes will then be significantly reduced or even completely disappear.

Until then, we suggest to reduce the costs of acquiring veIOT voting power by paying rewards for locked IOT tokens. This way, we aim to encourage more individuals to actively participate in governance as they have (bigger) locked positions to vote with, thereby strenghtening the network's resilience against potential attacks during periods of low participation.

## Stakeholders

All current and future veIOT holders, as well as IOT holders, are stakeholders in this proposal. By incentivizing staking, the proposal benefits those who lock IOT while also promoting the long-term health and stability of the network.

## Detailed Explanation

1. **Emissions Apportionment:**
    - Allocate 4% of IOT emissions to staking rewards for veIOT. This allocation will be sourced from the reward bucket assigned to Oracles in HIP-52, which is currently not utilised.
    - Post the implementation of decentralized Oracles, this allocation will revert to Oracle rewards, providing veIOT holders with the opportunity to earn rewards by staking to Oracles as specified in HIP-52.

2. **Existing lockups:**
    - All existing lockups stay as is. Functions for unlocking, locking, choosing decaying/constant, vote weight and unlocking remain the same.

## Drawbacks

- Although this proposal aims to increase the amount of locked IOT, there's a risk that IOT holders may lock tokens solely to earn rewards without actively participating in the voting process. This could potentially lead to an increase in locked tokens without a corresponding rise in voting activity.
- Rewards emitted daily to veIOT holders will contribute to the dilution of the IOT supply. While this may pose a challenge, the benefits of increased voting participation are anticipated to outweigh the disadvantages of increased supply.

## Rationale and Alternatives

No Alternatives proposed.

## Unresolved Questions

None at this time.

## Deployment Impact

Total daily IOT emissions will increase by the amount of rewards emitted to veIOT holders.

### Existing veIOT Stakers

Current veIOT stakers will start to receive rewards for their lockups, and can decay/unlock their positions as normal.

### Documentation Updates

Documentation regarding staking with Helium Vote will need to be updated to reflect that staking IOT now earns rewards.

https://docs.helium.com/governance/staking-with-helium-vote/

### User Impact

Users who choose to stake IOT will now have the opportunity to earn rewards from their staked tokens. 

## Success Metrics

- This HIP will be considered successful if VeIOT used for voting increases by at least 200% on average over the next 6 months.
