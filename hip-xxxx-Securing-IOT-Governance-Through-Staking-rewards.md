- Author(s): BFGNeil, Siegfried
- Start Date: 2024-04-16
- Category: Economic, Governance
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veIOT

## Summary

This HIP aims to improve the utility of the IOT token and increase voter turnout by providing staking rewards for locking IOT.

## Motivation

We wish to increase utility of the IOT token and increase participation in voting. Currently most users have no reason or desire to hold IOT or lock it leading to low voter turnout. 

Rewarding users for locking up tokens will create an incentive for more veIOT to be locked, reducing the risk of network attacks via controlling voting when there is low voter turnout.


## Stakeholders

- All current and future veIOT holders as well as IOT holders.

## Detailed Explanation

1. **Emissions Apportionment:**
   - Allocate 4% of total IOT emissions from the currently unused Oracle Bucket to veIOT staking, creating a reward system for locking IOT.
   - When oracles are ready to be deployed, this hip can be qualified by its success metrics to say if we should keep this staking method and allocate more to the oracle bucket, or to replace it as it has failed.

2. **Existing lockups:**
   - All existing lockups stay as is. Functions for unlocking, locking, chosing cliff/constant, vote weight and unlocking remain the same.
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
Current veIOT stakers will start to recieve rewards for their lockups, and can decay/unlock their positions as normal.

### Documentation Updates
Documentation regarding staking with Helium Vote will need to be updated to reflect that staking IOT now earns rewards.

https://docs.helium.com/governance/staking-with-helium-vote/

### User Impact
users who choose to stake IOT will now earn rewards from it

## Success Metrics

- This HIP will be considered successful if more IOT tokens are locked and used for voting. 
