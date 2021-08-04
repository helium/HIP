# HIP 31: Governance by Token Lock

- Authors: [Tushar Jain](https://github.com/@tjmcc), Shayon Sengupta
- Start Date: November 14, 2020
- Category: Governance
- Original HIP PR: https://github.com/helium/HIP/pull/182
- Tracking Issue: https://github.com/helium/HIP/issues/183
- Status: In Discussion

# Summary
[summary]: #summary

This proposal suggests on-chain governance voting for implementations of chain variables and protocol upgrades.


# Motivation
[motivation]: #motivation

On-chain governance helps make governing decisions open and transparent. It is intended to support decentralization of the protocol governance to the community as the Helium protocol continues its journey toward complete decentralization.

Traditionally, on-chain governance had the following features:

1. Equal weight -- “One Token One Vote”
2. Limited skin in the game -- no cost to vote (price, lock ups, etc.).

This approach is vulnerable to people borrowing tokens to vote. With the low voter turnout seen with governance votes in many other protocols, this attack vector is fairly easy to execute. We anticipate a higher signal in the voting process when voters have to own the consequences of their votes.

“One token one vote” also commonly concentrates voting power in the hands of whales and early miners and adaptors. This can lead to smaller holders becoming disenfranchised and disengaged from governance. Large holders can also manipulate the voting process by concentrating their votes at the end of a voting period.

We propose a governance implementation where voters that win the vote must**lock up their HNT** for a predetermined amount of time. Lock up time is proportional to how contentious a vote is (a 51%-49% win would require a longer lockup than a 75%-25% win). This system encourages consensus building as contentious votes become more expensive to voters than landslides. It also imposes a significant cost on any large holder who tries to control governance.

We also propose having declining weight per token in the voting process to encourage timely voting and reduce last minute manipulations.


# Stakeholders
[stakeholders]: #stakeholders

All Helium Network stakeholders are affected by this HIP.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Vote Initiation and Weighting

Anyone can bring a HIP to a vote by posting a bond of**100,000 HNT**. This will be a chain variable that can be adjusted by governance. This bond is necessary to protect against spam HIPs. This bond will be locked up until the end of the vote and will not be eligible to vote.

Only staked HNT is eligible to vote. Votes are done through a new transaction type which will be detailed in a further revision of this HIP.

We recommend a 7 day period between HIP submission (defined as the posting of the bond) and the start of the voting process. This waiting period prevents HIP authors from having an undue advantage on the voting process considering the decaying voting strength introduced in the next paragraph. After the waiting period, the voting process lasts for 21 days (1008 epochs).

In this proposal, HNT corresponds to a certain number of “vote credits”. Network participants who participate earlier in the process get a higher weight in order to disincentivize adversarial last minute shifts in balance. For the first 7 days of voting (14 days since proposal submission), each HNT will have equal voting weight, but the voting power decays linearly after that. The “decay” of vote strength should be a chain variable. The initially proposed value of this chain variable is 3.3333% per day – meaning that 1 HNT deposited until the seventh day since the voting starts counts as 1 vote credit but if it is deposited at the last second of the voting process on the 21st day, it has only 0.3 vote credits.

![](https://lh4.googleusercontent.com/PuwNiLI82brcIcWHTJNMMhVx3aNV6wmQ1g43Akd19Wr1ykRifYmrSOi6LXbnMnNwFeU2iSTLMsC1kqfNLxc0OOudrMvioJY7WXC81JUMJ9Wh3hDupfywW_5b36_OZKL6t3aI_28)


## Lockup Amount and Mechanism

At the end of the voting epoch, suppose the vote credits are distributed as x% for the losing address and (100 - x)% for the winning address.

There is no lock up if votes are passed with greater than or equal to 80% majority (x&lt;=20%). If x>20%, we define the lockup period for the HNT contained in the winning address as per the following formula (in days):
  
![](https://lh5.googleusercontent.com/cljWpx5-WOPvC8fLKV3pNpvMOgX5jTsokMfJX94ePDZihjjw3Tgzr3qBqfp1wmBqjZLj37hhv8Rpw9SWHWmDYvhdi_wpz2UyUCVM4x1trH2U-ad5-68x8UN_IhIw8ttwM__Yjxo)  

The shape of the curve is as follows:

![](https://lh6.googleusercontent.com/WQ9Rpir-AE-zinmrDrZT5Nx066RwhCx2RwS-XpSO_ebr1rzz5uuz9Nu43CPKlCrnAFbBzIZehNmBXOEDuVxLX3I3FL1ggJRr9PF4Ic74ZtLJMb2cMbm2W67ADRVVdvmk5BAWu7k)

The intention is that the lockup period increases exponentially with the contentiousness of the vote. This should encourage consensus building off-chain because contentious votes impose a large liquidity cost. If a vote still ends up being contentious, we believe that it must be an extremely important parameter that the community cares about and hence winners should bear the consequences of their choices.

Note: The lockup period imposed by governance is incremental to the unbonding period for validators.


**Validator Rewards and Consensus**

Tokens locked due to governance continue to accrue validator rewards and those rewards are not subject to lock-up.

Tokens locked due to governance can vote on future HIPs; future victories add to the lock-up period.


## List of Chain Variables

We need to decide which are the exact chain variables we are governed by this system. The authors intend to work with the community and the core developers to build this list.

[Attached](https://helium.plus/chain-vars)


# Benefits
[benefits]: #benefits

1. Consequences to voting, so less risk of low conviction votes
2. Having a contentious vote is extremely expensive, so it is worth building consensus on a proposal prior to voting.
3. Locking via vote creates scarcity on the circulating market supply of HNT for all network participants.
4. Much less oligarchic than one token one vote, partially preventing whales from de facto control of governance proposals. In governance by lock, whales who try to control contentious governance decisions start locking up tokens and bearing the cost.


# Drawbacks
[drawbacks]: #drawbacks

1. It is difficult to calculate the lockup time for participation in any given vote. The uncertainty might lower voter participation.


# Rationale
[rationale]: #rationale

1. Weighted voting attaches a cost to proposing and participating in contentious protocol changes, forcing the winners of the vote to be locked into the system and bear the consequences of their decision.
2. The token lock means only long term network participants will vote on network direction.
3. Allowing staked tokens to vote aligns incentives with holders who believe in a project. Decred is one of the long standing examples of this system.
4. Time-weighted votes allow for fairer markets that disincentivize last minute swings in votes.


# Open Questions For The Community
[openquestions]: #openquestions

1. Should we have a maximum cap for lockup across votes?
   - One idea from the authors is to have a max cap on the lock-up period of 2 years across all votes. How likely is it that someone wants to break the network after locking a meaningful amount of tokens for 2 years? The total lack of a cap could discourage high signal participation because of personal liquidity profiles. The function could also be modified such that it would require several contentious votes to reach the proposed cap.
2. Should bond amount be a function of chain variables? What specific set of variables, if they are changed, would pose an existential threat to the network?
3. Should we have governance boosters for holders who stake for long periods of time? E.g. - sqrt (n\*t) boosters?
4. Should we grant core devs with veto rights (as a failsafe) as we kickstart this process?
