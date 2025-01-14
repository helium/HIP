# HIP XXXX: Single-Token Governance and Helium Release Proposals

- Authors: Helium Protocol Developers, [@ChewingGlass](https://github.com/ChewingGlass), [@abhay](https://github.com/abhay)
- Start Date: 2025-01-14
- Category: Economic, Technical, Governance
- Original HIP PR: [#####](https://github.com/helium/HIP/pull/####)
- Tracking Issue: [#####](https://github.com/helium/HIP/issues/####)
- Voting Requirements: veHNT Holders

---

## Summary and Motivation

If approved and implemented, this proposal would:

* Establish a Roadmap driven process for future Helium protocol upgrades driven by the core development team, Nova Labs.  
* Simplify protocol governance by establishing a veHNT only system and HNT rewards for active governance participants.  
* Unlock existing veIOT and veMOBILE positions to allow for these holders to be able to convert to HNT using network treasuries.

### The Problem

The existing system, with separate voting mechanisms and a complicated DAO Utility Score, is difficult to explain, and difficult to understand. It creates multiple interlocking and conflicting incentives, and unnecessarily divides the community. Additionally, the current system creates an environment where protocol developers and community members are at odds with being able to succinctly and predictably forecast the direction of the Helium protocol. This negatively impacts deployers and other participants who are evaluating joining the Helium network.

### Make It Simpler

When [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md) is implemented, HNT will return as the single economic focus of the Helium ecosystem, and holders of IOT and MOBILE can exchange their tokens for HNT. Therefore, veHNT becomes a natural expression of all governance. It’s important to note that no other changes to veHNT are being proposed, specifically no changes to existing land rush positions, lockups, etc.

Through this proposal, the protocol developers of the Helium ecosystem, Nova Labs, assert that governance of the Helium protocol must be driven through veHNT alone, and will establish a Proxy Account in Helium Governance to allow other participants to vote with the protocol developers. We will publish a detailed roadmap that defines our intentions to upgrade the protocol over the coming months. We also intend to continue to update this roadmap through an open process including ongoing community calls and will take feedback through participation in the IoT and Mobile Working Groups. 

### Votes with Code

Finally, we propose that the Helium Community votes on a periodic basis (initially monthly) to approve upcoming protocol upgrades proposed by the Nova Labs team. This is an evolution of the HIP process and may be characterized as a Helium Release Process. An important key update here is that all changes come with audited and deployable code. Each of these release votes will be kicked off using the existing Helium Monthly Community Call and cover the full release across the Helium network. There may be emergency or security related deployments that are necessary for protocol safety or bug fixes but these will be announced and ratified on subsequent releases. Participants may vote directly using their veHNT positions or by assigning their vote power to the Nova Labs Proxy Account or any other Proxy Account.

## Stakeholders

All Helium ecosystem participants are affected by this proposal.

## Detailed Explanation

Nova Labs is establishing a Roadmap that will be voted on alongside this proposal in order to provide clarity and predictability for all network participants. We, along with the community, have learned that governance of the network requires more clarity and governance risks need to be better mitigated in order to serve the needs of the wider community. As one of the largest decentralized networks with stakeholders of multiple types across two wireless protocols, it’s important that core protocol developers (the ones writing and deploying protocol changes) have an aligned roadmap with builders and token holders in the ecosystem.

### January 2025 Release

This can be considered the first proposal under the new Helium Release Process. Sometime after this proposal is approved and the relevant protocol and app upgrades are audited, the protocol developers will release the following before February 1, 2025\.

* Full release of HIP-138  
  * Returning rewards to HNT  
  * Halting IOT and MOBILE emissions  
  * Halting HST rewards and redirecting rewards to other participants  
* Simplify the DAO Utility Score to use veHNT delegation alone (V Score)  
* Remove delegation rewards from subnetworks and establish a 6% HNT rewards pool  
* Establish activity thresholds for veHNT participants to be eligible for HNT rewards  
* Allow direct or indirect (via Proxy Account) participation in governance using veHNT

We believe that the combination of this implementation of HIP-138, and subsequent changes described more in detail below, will fully transition Helium into a more straightforward protocol for all participants. Future releases are described in a subsequent section of this proposal.

### Completing HIP-138

[HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md) intentionally left governance untouched pending a future proposal. This proposal intends to resolve the governance questions in the simplest way possible.

### Migrating to a V Score Only Utility Score

The current DAO Utility Score, if HIP-138 is implemented without any changes, would dramatically affect the relationship between the IoT and Mobile networks as rational veHNT participants would chase HNT yield rather than make a market driven decision based on their actual interest in the future of one or the other network.

#### V Score Component

Under the current Utility Score, veHNT holders are economically motivated to delegate based solely on what delivers the highest return in terms of HNT, and not on what is best for the network. Depending on other factors, it can become economically infeasible to express support for IOT based on a long-term value thesis, or support for MOBILE despite its lower number of deployments.

Instead, under the current Score, the incentive becomes to maximize yield based on mathematical properties of the Utility Score, and the `V` factor does not reflect veHNT holders’ rational evaluation of the merits of the different subnetworks.

#### A and D Score Component

Active device count and Data Credit burn are backwards-looking and present-time metrics which reflect no forward-looking sentiment. For example, the IOT subnetwork is considering a change to its fee structure that could greatly increase DC burn. It also has an existing, global network ready for use. veHNT delegators should be able to weigh these factors when deciding the rewards (and therefore deployment incentives) that go to the subnetwork. It is the authors’ belief that a market driven approach, detached from the circular self-fulfilling financial incentives of the existing Utility Score, will better decide the rewards split than the legacy model.

#### Predictability of V Score Impact

We propose to smooth the split between subnetworks over a 30-day period. This allows deployers to better predict their near-term earnings, by reducing the volatility of delegation percentages. It also gives governance participants time to dedicate assets towards delegation as needed.

#### New Utility Score

The new Utility Score is determined by the share of veHNT delegated to each subnetwork, and is expressed as the subnetwork’s percentage of total subnetwork emissions. Due to the smoothing function, the network will transition gradually from the [HIP-51](./0051-helium-dao.md) Utility Score to the new Score.

- $S_{IOT}(t)$ is defined as the percentage Score of the IOT network on day $t$.
- $V_{IOT}(t)$ is defined as the veHNT delegation percentage of the IOT network on day $t$.

- $S_{IOT}(0)$ is the percentage Score of the IOT network on the day of transition, as defined by the DAO Utility Score of HIP-51.
- For $t>0$, let $S_{IOT}(t) = \frac{29}{30} S_{IOT}(t-1) + \frac{1}{30} V_{IOT}(t).$
- Thus, today’s Score is always $\frac{29}{30}$ of yesterday’s Score plus $\frac{1}{30}$ of today’s veHNT delegation percentage.

The Score $S_{MOBILE}(t)$ of the MOBILE subnetwork is calculated in the same way.

In this way, large swings in veHNT delegation will slowly lead to eventual change in emissions allocation. It is notable that a 30-day smoothing function provides convergence towards a score on a 90-day interval.

HNT is distributed among subnetworks similarly to the current Utility Score, based on their Utility Score divided by the Total Utility Score. This gives a percentage share of the rewards, which is then smoothed against yesterday’s percentage share.

Importantly, this formula takes into account the previous day’s percentage, such that the split of rewards prior to [HIP-138](./0138-return-to-hnt.md) will serve as a starting point. This will allow rewards to progress smoothly, rather than in a volatile way, towards their eventual equilibrium point. This will also give delegators time to respond to the changes from this HIP.

### Removal of Delegation Rewards

Under this proposal, veHNT holders would receive the same rewards no matter which subnetwork they delegate to, so delegation becomes a pure signal of their support for a particular subnetwork, based on their assessment of its current and future potential. Changing delegations within an epoch will not change HNT rewards for governance participants.

### Voting and Delegation Rewards

With the simplification of the DAO Utility Score, and the removal of extraneous economic incentives to delegate to a particular subnetwork, delegation becomes a way in which veHNT holders help decide the future of the network.

As this proposal removes independent voting with veIOT, [HIP-124](https://github.com/helium/HIP/blob/main/0124-securing-iot-governance-through-voting-rewards.md) would be repealed. Rewards from IOT subnetwork emissions, which were allocated by [HIP-124](https://github.com/helium/HIP/blob/main/0124-securing-iot-governance-through-voting-rewards.md) to voters in IOT elections, would return to their previous assignment to the Oracle reward pool, which may be allocated as needed by a future HIP. 

Under this proposal, and inspired by the IoT community, the HIP-124 requirements of voting on 2 of 4 proposals will be moved up to veHNT. In order to simplify implementation, the following changes are being made:

1. Rewards from positions that are ineligible (because they have not voted) are burned when the position claims their rewards. These burned rewards will count towards Net Emissions, and thus re-emitted if below the Net Emissions threshold.  
   1. The original implementation of Net Emissions had a pool that smoothed Net Emissions over a 1-week period. This was lost in the migration to Solana. In a later release, it will be added back to ensure burned rewards claims are smoothed.   
2. Removal of the Abstain vote. It is the authors’ belief that all incentivized stake must be useful, if any position is abstaining from more than 50% of the votes, that stake is not useful. Therefore, abstain is better implemented by choosing not to vote on particular proposals.

### Stale Delegations

Under this system, there is a risk that delegations become stale. In order to prevent this, delegation choices will follow the same schedule as defined in [HIP-110](https://github.com/helium/HIP/blob/main/0110-proxy-voting.md). This requires the participant to be active at least once a year to retain the delegation, and keeps the `V` score from being weighted down by stale delegations from lost or forgotten wallets.

### Releasing all veIOT and veMOBILE positions

We propose that all veIOT and veMOBILE positions are immediately released (including those currently in cooldown) such that individual wallet holders can redeem their IOT or MOBILE tokens.

At the time of writing, 1.5% of IOT supply and 0.35% of MOBILE supply are locked in total with a lockup duration greater than zero, so the effects of these unlocks should be immaterial.

With the introduction of Proxy Accounts, network participants can now assign their vote to someone who is able to spend more time researching each Helium Release entails, and generally aligns with their social and economic interests, while voting independently whenever they choose.

As independent subnetwork tokens are now being phased out through [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md), while all decisions ultimately influence the economic future of the entire network, and Proxy Accounts remove the necessity for every voter to evaluate every Helium protocol change, the three separate voting systems have become less relevant, and can be combined into one simpler one.

### Rewards Flow

If this proposal is approved and implemented, the distribution of HNT emissions will remain effectively unchanged among subnetwork participants, except as influenced by the definition of the new, simpler Utility Score, and the new voting requirement for veHNT positions to be eligible for delegation rewards.

The proposal intends that 6% of total HNT emissions be distributed pro rata among all eligible participants, who have delegated to a subnetwork.

For clarity, should a future release  modify subnetwork emission schedules or the DAO Utility Score, all schedules shall be adjusted to maintain the 6% equal distribution of delegation rewards among all eligible veHNT positions, unless this provision is explicitly modified.

### Development Time

This proposal would greatly simplify the entire governance and reward distribution system of Helium, and would reduce the complexity of implementing [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md). Development cycles could be better spent on improving deployment and demand incentives by implementing future proposals as decided by the community, and reducing the complexity of the reward system also reduces the cost for development audits, as well as the attack surface for bad actors.

### Future Releases

As discussed earlier in this HIP, we propose, at most, a monthly release schedule that reduces the amount of governance fatigue for network participants. At each Helium Community Call, a new Helium Release Proposal would be opened by the Nova Labs team for the subsequent month, if one does not exist already. Each of these proposals will be an expected changelog for the next release of the protocol. Protocol developers and community members may open Pull Requests against this proposal during the month as ideas and code is developed through Working Groups and general community discussion. Pull Requests will not be merged without audited and ready to deploy code in relevant protocol or oracle repositories.

To provide some examples of potential future release candidates, the team has compiled a list of (not prioritized) protocol upgrades. These will be formally proposed through the Helium Release Proposal process after this HIP is approved.

* Cross protocol  
  * Migrate IOT and MOBILE token specific stakes/locks/fees to HNT (post HIP-138, e.g. Service Provider stakes, Hex Boosting fees, etc.)  
  * Fractional rewards delegation for Hotspots or Subscribers  
  * Improve reliability of automated epoch calculations using incentivized system (i.e., “tuk tuk”)  
  * Enable automation of reward claims / periodic reward claims  
  * Remove Onboarding server  
  * Simplify Initial onboard / assert location transaction into one combined action to reduce partial failures  
  * Upgrade Solana programs to use Anchor 0.30+  
* Mobile  
  * Mapping rewards adjustments based on “factor” to incentivize particular kinds of mapping  
  * Implement Verification Mapping to create coverage map of Hotspots for Carrier planning  
  * Expanding Mapping outside of Helium Mobile subscribers  
  * Ability to change the price for data transfer based on geographies and carriers.  
  * Move away from asserted / checked location towards a connectivity driven “template bonus”  
* IoT  
  * Move denylist classifiers into open, community managed process  
  * HIP-136 like improvements to IoT PoC  
  * Change data pricing model for IoT based on community discussion

Please note that these are all examples of potential improvements that will have an open comment period, an implementation period, and finally an approval through the Release Proposal process.

## Implementation

The specific changes to veHNT and governance reduces the smart contract complexity of Helium, and thus simplifies the implementation of [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md). It is simpler than implementing subnetwork delegation with HNT rewards under the existing DAO Utility Score, and substantially simpler than implementing a new form of subnetwork governance. Core developers have estimated that the combined implementation of [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md) and this proposal will require less work than the implementation of [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md) alone.

### Voting

Although this proposal intends both to change the scope of veHNT governance and to remove the utility of veIOT and veMOBILE governance, this HIP will only be presented to the veHNT voting base that created the subnetwork voting systems.

That said, we believe that we should go through an open discussion process starting with the individual Working Groups as they were voted in by the IoT and Mobile communities, respectively.

It’s important to note that the DAO Utility Score has always been subject to veHNT governance, and therefore we believe that veHNT is the ultimate authority on the primary changes in this proposal.

## Alternatives

Other methods of subnetwork governance have been discussed, including the suggestion given in [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md), that would give voting power proportional to the time a veHNT delegation would be locked towards a particular subnetwork. It is the authors’ opinion that these methods would increase the complexity of the Helium ecosystem, thereby dampening voter turnout and wasting development resources.

It has also been proposed to remove the `V` score and leave everything else untouched. This would remove the ability of veHNT positions to signal their preference for a particular subnetwork, contrary to their original purpose as defined in [HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md).

## Drawbacks

This proposal removes the specific voting bodies currently defined by locked subnetwork tokens. One might argue that the veHNT voting body is not as well-equipped to handle subnetwork decisions as the subnetworks themselves.

However, subnetwork voting participation has represented a small percentage of the eligible population, and Proxy Voting now provides a way for individual voters to choose which proposals they wish to focus on.

## Unresolved Questions

None

## Deployment Impact

This proposal will be implemented by Helium core developers. This proposal should be decided on prior to the implementation of [HIP-138](https://github.com/helium/HIP/blob/main/0138-return-to-hnt.md).

Documentation on these changes will be updated on [https://docs.helium.com](https://docs.helium.com) by Nova Labs and Helium Foundation employees if a grant applicant to do this technical writing task is not received.

## Success Metrics

This proposal will be successful if it increases total governance participation, and aligns HNT emissions to the subnetworks with the degree veHNT holders wish to support them.  