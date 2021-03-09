# Fix Long Epoch Consensus Rewards

- Author(s): @PaulVMo (@PaulM on Discord)
- Start Date: 2021-03-08
- Category: economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

This proposal updates the way that consensus rewards are calculated to eliminate the under rewarding of consensus that occurs when epochs exceed the target length. Currently, consensus rewards are calculated assuming that each epoch has 30 blocks which is often not the case. However, PoC and Securities rewards are calculated based on actual duration of an epoch, resulting in consensus receiving a smaller share of rewards than the 6% target.

This was a deliberate design decision as rewarding based on length of epoch (like with PoC and Securities) incentivizes consensus group members to delay elections to increase rewards. 

However, there is a better way. I propose that the consensus rewards calculation use a rolling average of epoch length to adjust for the effect of variable epoch length on rewards while minimizing the potential incentive to cheat.

# Motivation
[motivation]: #motivation

The motivation behind this proposal is simple – to correct the under rewarding of consensus members relative to the target of 6% of total earnings. Long epochs can result for several reasons including the poor performance of one or more CG members, a software bug, or external factors such as reliability of Internet connections. There should be penalties for poor performance of consensus group members. However, the current rewards calculation unfairly penalizes the entire consensus group/pool. 

For example, in February 2021, consensus group members received only 4.7% of all rewards – nearly 25% less rewards than expected:
| Reward Type | Feb 2021 Total (HNT) | Percentage |
| -- | ----- | ------ |
|securities|1,557,743.05|34.5%|
|poc_witnesses|2,123,097.89|47.0%|
|data_credits|125.74|0.0%|
|consensus|212,291.67|4.7%|
|poc_challengers|94,959.66|2.1%|
|poc_challengees|530,774.47|11.7%|
|**Total**|**4,518,992.48**|**100.0%**|

While these metrics are likely to improve with the move to validators (see [HIP25](https://github.com/helium/HIP/blob/master/0025-validators.md) for more rationale behind validators and the expect improvements to block times and elections), it will not entirely correct for or ensure full consensus rewards. Epoch duration is determined by the time it takes to elect a new consensus group. A new election is attempted after 30 blocks. Elections take time. Even successful elections may take more than a single block to complete, leading to greater than 30 block epochs. And, if an election fails for any reason, it is reattempted only after 5 blocks.

Even with validators, consensus elections can and will fail, leading to an average epoch duration of greater than 30 blocks. Even if successful on the first attempt, it often takes a block or more to conclude, again leading to epochs of >30 blocks.

With high investments required to become a validator, it will become more critical for the Helium Network to reward consensus accurately and fully.

Lastly, there is precedent for this sort of adjustment or smoothing in the Helium blockchain. For example, Block Times are continuous adjusted to make up for slow blocks to help ensure that monthly reward targets are met.
# Stakeholders
[stakeholders]: #stakeholders

As an economic change, this proposal has far reaching impacts: 
- Consensus group members will see an increase in rewards, both absolute and as a percentage of total rewards.	
- Hotspot owners will see a decrease in percentage of total rewards (absolute PoC rewards are unaffected; however, percentage of total rewards will decline due to increased consensus rewards)
- Securities holders will see a decrease in percentage of total rewards (absolute securities rewards are unaffected; however, percentage of total rewards will decline due to increased consensus rewards)

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

**DRAFT – this is based on rudimentary understanding of what is possible on the blockchain; there may be more elegant ways to “smooth out” the consensus rewards so they average out to 6% over time.**

Currently, consensus rewards per epoch are calculated using the Election Interval (a fixed target of 30 blocks) to determine what fraction of monthly rewards should be allocated to the current epoch. The following formula show how this works, in a simplified manner:

>Epoch Consensus Rewards = (Monthly Rewards x Consensus Percentage) x (Election Interval x Block Time / Seconds in a month)
Election Interval is defined in blocks and Block Time is defined in Seconds.

You will note in this formula, the Consensus Rewards do not change when the epoch length varies. As such, consensus rewards will be below their monthly target whenever there are fewer Epochs in a monthly due to long epoch durations. 

Instead, this proposal changes the epoch consensus reward calculation by including an adjustment factor, Average Epoch Length Factor. Average Epoch Length Factor is computed each epoch as the ratio of actual epoch length to target epoch length over the last N blocks. I proposed N to be the expected number of blocks in one month as it aligns with the period used in target rewards and is sufficiently large to avoid the potential for gaming.

The revised calculation for consensus rewards will work as follows:
>Epoch Consensus Rewards = (Monthly Rewards x Consensus Percentage) x (Election Interval x Average Epoch Length Factor x Block Time / Seconds in a month)


# Drawbacks
[drawbacks]: #drawbacks

There are a couple drawbacks to the proposal however none so significant as to outweigh the benefits:
1. With the inclusion of an everchanging rolling average as a factor, consensus rewards may become more difficult to understand. Rewards will not vary in sync with current epoch times nor remain fixed. This can be mitigated through providing appropriate visibility into total and average consensus rewards over a period (e.g., monthly).
2. This proposal may add processing complexity to rewards transactions as well as potentially require additional information to be maintain in the blockchain and/or ledger leading to some bloat. With the change to validators, I believe this will be less significant and thus worth the additional resources.
3. Any change to rewards / token economics can be challenging from an adoption perspective. People do not like change. However, given that this proposal aims to correct rewards which most of the community already believe to be at 6%, I am confident in support of this proposal.

# Alternatives
[alternatives]: #alternatives

Several alternatives were considered but ruled out in favor of this proposal:

### Do nothing / no change
Consensus rewards will continue to be short of 6% any time that epochs exceed 30 blocks. This will lead to under-rewarded validators, skewed ROI calculations on stakes, and, in the worst case, a deterrent to potential validators. With consensus on hotspots, this under allocation of rewards has been long overlooked as the impact to a single hotspot owner was insignificant. However, with the large investment required to become a validator, fully rewarding validators will be critical.

### Use actual epoch duration
It is possible to adjust rewards based on the actual duration of an epoch. This is what is done for PoC and Securities rewards. However, this creates an undesired incentive for existing consensus group members to delay election of the next consensus group. Delaying an election would increase the rewards for current consensus members but hurting the security and performance of the network. This rationale is documented in the existing blockchain rewards transaction code and supported by me.

### Don’t Adjust PoC and Securities Rewards
Another alternative is to change PoC and securities rewards to no longer adjust them based on epoch duration. Instead, they would be calculated much like consensus rewards today, assuming that an epoch is always 30 blocks. This would have significant impacts to the token economics of HNT as it would alter the month mining totals as well as the max supply. And, for these reasons, I do not a recommend this as an option.

### Reallocate slashed stakes to other consensus members
An ideal solution to consensus rewards both protects the 6% consensus reward pool while also penalizing poor consensus performers. It may be possible to design a reward structure that slashes poor performers and reallocates the slashed amount to the validator pool such that it compensates for long epoch times. However, as mentioned above, there are factors beyond any individual consensus members performance that could impact epoch duration. This means that slashing rewards alone may not be able to fully compensate under rewarding. Additionally, slashings will likely be a complex topic that will only be brought up after validators go live. Given the criticality of fairly rewarding validators, I believe that this proposal shall be implemented irrespective of slashing.  


# Unresolved Questions
[unresolved]: #unresolved-questions

I seek input from the community on several open questions:
1. Technical feasibility of the proposal and any alternatives to achieve the same result based on what information is available on chain to adjust for long epoch times.
2. Interval of time (# of blocks) to average adjust rewards over; I propose 30 days (approximately 43,000 blocks) as a starting point.

# Deployment Impact
[deployment-impact]: #deployment-impact

This proposal will require a new version of the blockchain rewards transaction as the proposal is not compatible with the existing transaction. Enabling this new rewards transaction will need to be controlled behind a blockchain variable.
Given the impact of this on validators, I propose timing the implementation to coincide with or preceded the switch from hotspots as consensus members to validators as consensus members.

# Success Metrics
[success-metrics]: #success-metrics

Success of this proposal will be consistent achievement of 6% of net rewards allocated to consensus monthly.
