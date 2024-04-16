- Author(s): BFGNeil
- Start Date: 2024-04-16
- Category: Economic, Governance
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT

## Summary

This HIP aims to improve utility of IOT and increase voter turnout by providing staking rewards for locking IOT.

## Motivation

We wish to increase utility of the IOT token and increase participation in voting. Currently most users have no reason or desire to hold IOT or lock it leading to low voter turnout.

## Stakeholders

- All current and future veIOT holders as well as IOT holders.


## Detailed Explanation

1. **Current veIOT unlock:**
   - Upon implementation, all IOT currently locked in veIOT at the time of implementation will be able to unlock their tokens without any cool down period for the first 7 epochs after implementation. Any legacy veIOT will instantly reduce to a 1x on the implementation date and be treated like all other veIOT, aside from the 7 epoch amnesty period described above.

2. **Emissions Apportionment:**
   - Allocate 4% of total IOT emissions to veIOT stakers, creating a direct and proportional reward system for participants.

3. **Reduced Staking Minimums:**
   - Establish a minimum stake duration of 1 day with a 1x vote power multiplier.
   - Implement a daily multiplier increment of 0.0025 for every day a stake remains active. This progressive approach aligns with sustained commitment, rewarding long-term participants.

4. **Unlocking Mechanism:**
   - Stakers can unlock at any time and will be subject to a 14 epoch (approximately equal to 14 days) cool down period. During the cool down period, the tokens that were locked for veIOT will remain locked, but the veIOT will not have any voting power or receive any emissions. Stakers can elect to unlock all or some portion of their stake at any time.

5. **Voting Power Increase:**
    - A future HIP can introduce an additional multiplier increase of for every vote cast by veIOT holders in the governance process. This HIP will include the development work to make that possible; however, it will be implemented with an increase set at 0.00 unless another HIP is proposed and passed before implementation. It is the expectation of the authors that the other HIP will be discussed in parallel with or shortly after the passage of this HIP.

## Drawbacks

Unlock of existing IOT may lead to less locks if the incentive is not high enough to lock

## Rationale and Alternatives

### Strengthening Network Security

- The dynamic staking mechanism should create an incentive for more veIOT to be locked, reducing the risk of network attacks and enhancing overall security.

### Fostering Long-Term Commitment

- The daily multiplier increment encourages veIOT holders to commit to longer staking periods, aligning interests and promoting sustained engagement.

### Enhancing Governance Participation

- By rewarding veIOT holders with an additional multiplier for casting votes, this proposal aims to increase participation in the governance process, fortifying the network against potential governance attacks.

### Improving Liquidity Management For Stakers

- The unlocking mechanism provides a balanced approach to liquidity management, allowing veIOT holders access to their tokens without long term commitments of up to 4 years in the current system. We believe a more dynamic approach to lock ups will make reduce the barrier for people looking to lock up their tokens. Additionally, we feel, given the current data for veIOT locks as well as other veHNT/veDNT tokens that people often lock fewer tokens for longer durations under the current system. The network prefers more tokens locked than fewer.

## Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?
- Are there dependencies, milestones, or dates that need to be met for this HIP to succeed?

## Deployment Impact

Describe how this design will be deployed and any potential impact it may have on current users of
this project.

- How will current users be impacted?
- How will existing documentation/knowledge base need to be supported? Any content to change at
  <http://docs.helium.com>?
- Is this backwards compatible? Can this HIP be undone?
  - If not, what is the procedure to migrate?

## Success Metrics

- This HIP will be considered successful if more IOT tokens are locked under this new system as opposed to the current system.
- If a significant number of new participants choose to stake their IOT tokens and vote in future HIPs.
