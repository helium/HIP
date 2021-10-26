# HIP 41: Governance by Token Lock V2
- Authors: @tushar
- Start Date: September 17, 2021
- Category: Governance
- Status: In Discussion
- Original HIP PR: N/A
- Tracking Issue: N/A

Discord Channel:

In direct response to [“Rewrite HIP31 with Token Lock rather than Token Burn mechanism”](https://github.com/helium/HIP/pull/252)


# Summary

This proposal suggests a governance mechanism for on-chain voting for chain variables and protocol upgrades.


# Motivation

On-chain governance helps make governance decisions transparent and allows permissionless influence of governance decisions. The intention of on-chain voting is to give functional control of the Helium protocol to members of the community.

Traditionally, on-chain governance has meant one token, one vote. This governance methodology is vulnerable to a number of problems, including individuals borrowing tokens to vote with them. With the low voter turnout seen in most other protocols, this attack vector is fairly easy to execute and would allow individuals with significant resources to push through proposals that are not in the interests of the Helium community as a whole.

One token, one vote also concentrates voting power in the hands of whales and early miners. This can lead to smaller holders becoming disenfranchised and disengaging themselves from governance - which would lead to a stagnant protocol operating primarily in the interests of large/early holders.

This proposal creates a system that imposes enough of a cost on voting that only committed participants would vote to influence the direction of the network, while large holders may be disincentivized to participate. Simultaneously, our methodology ensures that the barrier to entry is low enough for all small holders to participate should they choose.




# Stakeholders

All Helium Network stakeholders are affected by this HIP because on-chain governance impacts key parameters in the network.


# Detailed Explanation

**Vote Power by Lock**

Under this governance structure, anyone can call a Helium governance proposal to a vote with a minimum of 100,000 HNT voting power (defined below). This is a variable that can be adjusted by governance. This minimum vote threshold is necessary to protect against spam proposals. The voting power used to call a vote will also be eligible to vote on the proposal.

The voting process in this structure lasts for 7 days. The reveal period—which we explain in detail below—lasts 1 day.

During voting, HNT holders lock up tokens in a “voting contract”. The minimum lockup period is 250,000 blocks and the maximum lockup period is 2,500,000 blocks. Both the minimum and maximum time thresholds can be decided by HNT governance. These tokens must be staked in order to participate, either directly with a validator or through an off-chain managed staking pool. While tokens are locked in a voting contract, the validator owner cannot unstake the tokens but they can be transferred to another validator.

A holder’s voting power in a particular proposal is determined by 1) the amount of HNT they vote with, and 2) the amount of time they commit to locking up their tokens.

The structure applies a linear multiplier of time to the amount of HNT locked up in the voting contract. For the maximum amount of 2,500,000 blocks, users receive 50x the voting power. For the minimum amount of a 250,000 block lockup, users receive 1x the voting power.

As a simple example, let’s imagine Alice, Bob, and Charlie all have 100 HNT:

1. Alice chooses to lock up her tokens for 250,000 blocks, and thus her voting power is 100
2. Bob commits to locking up his tokens for 1,375,000 blocks, and thus his voting power is 25 \* 100 = 2,500
3. Charlie commits to locking up his tokens for 2,500,000 blocks, and thus his voting power is 50 \* 100 = 5,000

As the lockup burns down, so does the voting power. For example, if Charlie locked up his 100 tokens for 2,500,000 blocks and 1,125,000 blocks have passed then Charlie would have 2,500 vote power.

At the time of a vote, the voting contract looks at how many tokens a holder has locked up and how long they are locked for. Voting holders can always extend their lockup period just prior to voting. Locked tokens can be used to vote on as many proposals as the holder wants, and there is no change for the holder in earnings from staking.

**Commit-and-Reveal**

One of the challenges with the locking mechanism proposed here is that most participants will wait until the last minute to vote. This is because there is a cost—namely, giving up liquidity—to vote. As such, if a vote is going someone’s way, they may not want to participate and lock up tokens.

In order to incentivize honest voting and maximal participation, we propose that Helium governance adopt a commit-and-reveal scheme. With this feature, votes would be submitted as concealed. Upon the completion of the voting period, we propose a 3 day reveal period in which voters can review the results of the vote, including who voted.

Commit-and-reveal can be implemented by having voters hash together their address, vote, and salt. Once the reveal period begins, voters can reveal their votes by publishing the unhashed data. If voters don’t reveal their vote before the reveal period, their vote is not counted.

The result of this should be maximal participation for important decisions because voters won’t know whether their vote will matter or not.

**Voting Mechanics**

In this structure, the minimum threshold to win a vote is 66%. We believe that chain variables in networks should only change when there is broad consensus amongst stakeholders and seek to avoid giving too much power to narrow majorities. There are three classes of variables going forward:

- **Network Controlled Variables**: These, typically economic or social variables, are controlled by this HIP. This is the default class for most chain variables.
- **Operational Variables**: These variables are issued dynamically by the core developers and primarily control chain performance.
- **Long-term Operational Variables**: These variables are potentially hard-coded and height activated for non-economic protocol evolution. For example, activating a new transaction type.

Voting by token lock has meaningful implications, thus the results should be binding and easily implemented. It's further proposed that HIPs must have code in order to be eligible for a token lock vote. HIPs without code can employ an alternative non-binding voting system (e.g. one token = one vote) as a means to signal community sentiment. 


# Drawbacks

1. **High barrier to entry:**Network participants must part with liquidity to vote, so the barrier to entry is higher than one-token, one-vote systems  
     

2. **Incentives:** For a holder to vote against a proposal, the expected cost of the passed proposal must exceed their cost of voting, and they must have conviction that their votes will lead to the proposal failing  
     

3. **Change inertia:** We assume all voters prioritize winning a proposal over their HNT staked in voting. This may limit the development of the protocol as minor changes may be contentious, and therefore expensive and unlikely to be proposed in the first place  
     

4. **Payoff ambiguity:** It is difficult to calculate the payoff for participation in any given vote.


# Rationale

1. **Incentivizes consensus:**In this structure, having a contentious vote is expensive (in terms of lost liquidity) if a network participant is on the losing side, so it is worth building consensus on a proposal  
     

2. **Fights concentration of governance power via concentration of economic power:** This structure is much less oligarchic than one token, one vote, partially preventing whales from de facto control of governance proposals because votes are private and one side cannot take the lead publicly thereby dissuading the other side from voting


# Alternatives

1. Governance by token burn:<https://docs.google.com/document/d/1aTla9U4JLPTQ-mRyUB28VPOHkm4USK36uafOig6IJ_w/edit#>


# Deployment Impact and Timeline

The Helium core team will have to prepare a complete product and engineering roadmap to put this proposal into action. Timeline is to be determined.

  
