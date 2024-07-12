# HIP 124: Securing IOT Governance Through Staking Rewards

- Authors: [BFGNeil](https://github.com/BFGNeil), [Siegfried-B](https://github.com/Siegfried-B), [ferebee](https://github.com/ferebee)
- Start Date: 2024-05-13
- Category: Economic, Governance
- Original HIP PR: [#1011](https://github.com/helium/HIP/pull/1011)
- Tracking Issue: [#1013](https://github.com/helium/HIP/issues/1013)
- Vote Requirements: veIOT

---

## Declaration

The authors of this HIP hold active VEIOT positions.

## Summary

This Helium Improvement Proposal (HIP) aims to increase voting turnout. It suggests to achieve this goal indirectly by paying rewards for locking IOT, thus reducing the cost of acquiring voting power (veIOT). The payments will discontinue once rewarded veIOT staking to decentralized Orcacles is implemented.

## Motivation

People who want to vote on HIPs concerning the IOT network need to acquire voting power in the form of veIOT. To acquire veIOT, potential voters need to lock IOT tokens.
IOT that is locked cannot be moved or sold. This can be seen as a cost of voting that disincentivizes potential voters from HIP voting and lowers voting turnout.

[HIP-52][hip-52] specified an Oracle bucket of 7% of total IOT emissions, to be shared between decentralized Oracles and the veIOT delegated to these Oracles. As specified in [HIP-70][hip-70], this bucket is currently unused, and the tokens are instantly burned instead. (The Oracles currently run by Nova Labs on behalf of Helium Foundation are unrewarded.)

Once decentralized Oracles are implemented and pay IOT rewards to the veIOT holders who delegate to them, the cost of locking IOT will be offset by these delegation rewards, mitigating the current disincentive for participating in HIP votes.

Until then, we propose to reduce the opportunity cost of acquiring veIOT voting power by paying rewards to locked IOT positions. This will encourage more individuals to participate in IOT governance using (larger) locked IOT positions, thereby strengthening the network's resilience against potential governance attacks during periods of low participation.

## Stakeholders

All current and future holders of IOT and veIOT are stakeholders in this proposal. Participants who lock IOT benefit from rewards, and all IOT holders benefit from long-term health and stability of the network promoted by greater governance participation.

## Detailed Explanation

1. **Emissions Apportionment:**
    - Implement a sliding scale for emissions allocation to lockup rewards for veIOT based on the total amount of veIOT locked:
        - **1%** of emissions if the **total veIOT locked** is at least **1.5 billion**.
        - **2%** of emissions if the **total veIOT locked** is at least **2.5 billion**.
        - **3%** of emissions if the **total veIOT locked** is at least **4 billion**.
        - **4%** of emissions if the **total veIOT locked** is at least **6 billion**.
    - Post the implementation of decentralized Oracles, this allocation will revert to Oracle rewards, providing veIOT holders with the opportunity to earn rewards by staking to Oracles.

2. **Existing lockups:**
    - All existing lockups stay as is. Functions for unlocking, locking, choosing decaying/constant, vote weight and unlocking remain the same.

## Drawbacks

- Although this proposal aims to increase the amount of locked IOT, there's a risk that IOT holders may lock tokens solely to earn rewards without actively participating in the voting process. This could potentially lead to an increase in locked tokens without a corresponding rise in voting activity.
- Rewards emitted daily to veIOT holders will contribute to the dilution of the IOT supply. While this may pose a challenge to holders of unlocked IOT, the benefits of increased voting participation are anticipated to outweigh the disadvantages of increased supply.

## Rationale and Alternatives

No Alternatives proposed.

## Unresolved Questions

None at this time.

## Deployment Impact

Total daily IOT emissions will increase by the amount of rewards emitted to veIOT holders.

The Helium foundation have confirmed that they will develop and implement the code required by this HIP.

### Existing veIOT Stakers

Current veIOT stakers will start to receive rewards for their lockups, and can decay/unlock their positions as normal.

### Documentation Updates

Documentation regarding staking with Helium Vote will need to be updated to reflect that staking IOT now earns rewards.

https://docs.helium.com/governance/staking-with-helium-vote/

### User Impact

Users who choose to stake IOT will now have the opportunity to earn rewards from their staked tokens. 

## Success Metrics

This HIP will be considered successful if veIOT used for voting increases by at least 200% on average over the next 6 months after implementation.

[hip-52]: https://github.com/helium/HIP/blob/main/0052-iot-dao.md
[hip-70]: https://github.com/helium/HIP/blob/main/0070-scaling-helium.md

