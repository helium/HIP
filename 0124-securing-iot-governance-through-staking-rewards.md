# HIP 124: Securing IOT Governance Through Staking Rewards

- Authors: [BFGNeil](https://github.com/BFGNeil), [Siegfried-B](https://github.com/Siegfried-B)
- Start Date: 2024-05-13
- Category: Economic, Governance
- Original HIP PR: [#1011](https://github.com/helium/HIP/pull/1011)
- Tracking Issue: [#1013](https://github.com/helium/HIP/issues/1013)
- Vote Requirements: veIOT

---

## Summary

This HIP aims to improve the utility of the IOT token and increase voter turnout by providing staking rewards for locking IOT.

## Motivation

We wish to increase utility of the IOT token and increase participation in voting. Currently most users have no reason or desire to hold IOT or lock it leading to low voter turnout.

Rewarding users for locking up tokens will create an incentive for more veIOT to be locked, reducing the risk of network attacks via controlling voting when there is low voter turnout.


## Stakeholders

- All current and future veIOT holders as well as IOT holders.

## Detailed Explanation

1. **Emissions Apportionment:**
    - Allocate 4% of IOT emissions to staking rewards for veIOT, to be taken from the reward bucket assigned to Oracles in HIP-52, which is currently not emitted.
    - Once decentralized Oracles are implemented, this allocation shall revert to Oracle rewards, which will give veIOT holders the opportunity to earn rewards by staking to Oracles as specified in HIP-52.

2. **Existing lockups:**
    - All existing lockups stay as is. Functions for unlocking, locking, choosing decaying/constant, vote weight and unlocking remain the same.
    -
## Drawbacks

- Whilst increasing the amount of locked IOT, IOT holders are not required to vote, this hip could lead to more locked, but no increase of voting.

- Rewards daily emitted to veIOT holders will increase dilution of IOT supply. We believe that the advantages of increased voting participation will outweigh the disadvantages of increased IOT supply, though. IOT holders may lock to earn rewards, but not use their veIOT in a significant amount for voting. We believe the likelihood of this happening is low, though.

## Rationale and Alternatives

No Alternatives proposed.

## Unresolved Questions

None at this time

## Deployment Impact
Total daily IOT emissions will increase by the amount of rewards emitted to veIOT holders.

### Existing veIOT Stakers
Current veIOT stakers will start to receive rewards for their lockups, and can decay/unlock their positions as normal.

### Documentation Updates
Documentation regarding staking with Helium Vote will need to be updated to reflect that staking IOT now earns rewards.

https://docs.helium.com/governance/staking-with-helium-vote/

### User Impact
users who choose to stake IOT will now earn rewards from it

## Success Metrics

- This HIP will be considered successful if more IOT tokens are locked and used for voting. 
