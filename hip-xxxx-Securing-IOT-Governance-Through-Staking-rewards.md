- Author(s): BFGNeil, IOT Working Group
- Start Date: 2024-04-16
- Category: Economic, Governance
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veIOT

## Summary

This HIP aims to improve the utility of IOT token and increase voter turnout by providing staking rewards for locking IOT.

## Motivation

We wish to increase utility of the IOT token and increase participation in voting. Currently most users have no reason or desire to hold IOT or lock it leading to low voter turnout. 

Rewarding users for locking up tokens will create an incentive for more veIOT to be locked, reducing the risk of network attacks via controlling voting on votes with low voter turnout.


## Stakeholders

- All current and future veIOT holders as well as IOT holders.

## Detailed Explanation

1. **Emissions Apportionment:**
   - Allocate 4% of total IOT emissions (4% deducted from PoC) to veIOT stakers, creating a reward system for locking IOT.

2. **Existing lockups:**
   - All existing lockups stay as is. Functions for unlocking, locking, chosing cliff/constant, vote weight and unlocking remain the same.
   - 
## Drawbacks

Without forcing users to vote, simply locking and staking IOT will not automatically mean that voting numbers increases. 

## Rationale and Alternatives

No Alternatives proposed.

## Unresolved Questions

None at this time

## Deployment Impact

### Existing veIOT Stakers
Current veIOT stakers will start to recieve rewards for their lockups, and can decay/unlock their positions as normal.

### Documentation Updates
Documentation regarding staking with Helium Vote will need to be updated to reflect that staking IOT now earns rewards.

https://docs.helium.com/governance/staking-with-helium-vote/

### User Impact
users who choose to stake IOT will now earn rewards from it

## Success Metrics

- This HIP will be considered successful if more IOT tokens are locked under this new system as opposed to the current system.
- veIOT used for voting increases.
