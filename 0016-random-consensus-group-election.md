# HIP

- Author(s): realPaulM
- Start Date: 2020-10-14
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

Changes to the election process for Consensus Group (CG) members to accomplish the following goals:

1) Introduce HNT staking to improve consensus safety
2) Make hotspots who have staked the required number of HNT equally likely to be selected to the CG instead of the current functionality that favors hotspots with a higher hotspot score

# Motivation
[motivation]: #motivation

First, as we allow third party menufactured hotspots and DIY hotspots onto the network we must ensure consensus safety. One proven way to increase consensus safety is to require proof of stake for consensus members – this means that consensus members have skin in the game and an incentive to be honest. In the future, we can also use slashing conditions to punish dishonest consensus members who double sign blocks or to punish consensus members who consistently miss consensus timelines.

Second, we want to increase transparency in the selection of hotspots to be members of the Consensus Group and the allocation of associated rewards for CG membership. As noted throughout the community, the current approach of using hotspot score does not align with the spirit of CG selection:

1. Hotspot score is a poor indication of coverage provided. This is well documented in the community and by members of the Helium Inc team. The current guidance on Discord and other outlets is that score should be ignored as a metric of how well a hotspot is performing regarding Proof of Coverage.
2. Furthermore, hotspot score is easily gamed. Members of the community and Helium Inc suspect that many of the hotspots with the highest score (e.g., >0.98) are in fact gaming the system by asserting false locations or otherwise faking PoC data. Yet, these hotspots are the most likely to be elected to CG.
3. Lastly, hotspot score is intended to measure PoC performance which is separate and distinct from a hotspot's ability and performance to engage in Consensus Group activities. For example, factors such as reachability on public Internet (vs. relaying through P2P network), Internet connection speed and reliability, and processing power and memory impact a hotspot's ability to perform CG. However, these are not currently measured by hotspot score.

Third, we want to improve the performance of the CG and target more consistent block times.

# Stakeholders
[stakeholders]: #stakeholders

All current hotspots will be affected by this change because they would need to stake HNT to be eligible for Consensus rewards.

Feedback is being solicited through Discord, and additionally, propose pushing a notification through the Helium mobile app to provide broader awareness of this HIP.


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Currently, Consensus Group election are based on two major factors: score and geography. Hotspots with a score equal or greater than the min_score chain variable (currently 0.15) are eligible for CG, and hotspots with higher scores are more likely to be selected. Geography is used to prevent multiple hotspots from the same H3 hex from participating in the same CG.

This HIP proposes the following changes to the CG election process:
1. New "CG stake" attribute will be created for hotspots. Only hotspots with CG stake > 10,000 HNT will be eligible to be considered for Consensus.
2. New “CG score” attribute will be created for hotspots
3. A value between 0.0 and 1.0 will be randomly assigned for CG score once per CG election to each hotspot
4. “CG score” will replace the use of the current score in the CG election for filtering and weighting hotspots
5. There will be a 180 day "unbonding period" to withdraw your HNT staked for consensus. This is to ensure that only long term committed people participate in securing consensus. During the unbonding period a hotspot is ineligible for consensus.
6. Allow (but do not force) hotspots to delegate their "consensus eligibility" to another server. This server can be a local machine with more processing power and better connectivity or it can be a cloud machine. Multiple hotspots cannot delegate to the same server.

No other changes to how score and geography is used in elections are to be made as part of this HIP. 

Due to the fact that CG score will be randomly assigned, there is no need to expose at his point to users of the Helium app or Explorer.

In the future we can propose a HIP to affect CG score based on CG performance but we do not need this today.

# Drawbacks
[drawbacks]: #drawbacks

1. Requiring stake to participate in CG might reduce the number of hotspots who participate in CG. 
2. Staking might lock up a significant amount of HNT reduce and the circulating supply of HNT available to trade. 
3. Allowing hotspots to delegate consensus work to a cloud server might cause more of the consensus execution to happen in data centers and in an extreme scenario reduce the censorship resistance attribute of the Helium Blockchain. 


# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

By not taking up this proposal, CG rewards will continue to add incentive for hotspots to game PoC. Falsely asserting location and other gaming of PoC hurts the quality of the network and hurts honest hotspot owners. This proposal ends the ability to game your way into CG and the associated CG rewards.

Additionally, it should be noted that PoC and CG have distinct portions of the HNT reward pool. As such, there should be a distinct mechanism for rewarding these. However the current scoring mechanism, if functioning properly, tightly couples these rewards: better PoC performance => higher score =>  greater chance to CG membership => more CG reward.

We must secure consesus safety before allowing more 3rd party hotspots and DIY hotspots on the network. If we lose consensus safety then would be an existential risk for the Helium Blockchain. Staking will solve this problem.

There has been significant variability of block times due to hotspots joining consensus with poor internet connections. This proposal forces hotspots to explicitly opt into being elgibile for consensus and offers an option for hotspots with poor internet connections to delegate their consensus eligibilty to another machine and improve performance. This proposal also creates the "CG Score" attribute which can be used in the future to grade hotspots by CG performance.

# Unresolved Questions
[unresolved]: #unresolved-questions

- What constitutes an "active" hotspot is not defined in this HIP. There needs to be some basic filtering of hotspots eligible for selection to CG. For example, an offline or unreachable hotspot should not be included in CG selection. This can be an addressed as an implementation detail if not part of existing functionality.
- Apart from basic criteria of being active, this HIP does not outline a metric specifically for CG eligibility/selection or create a penalty for poor performance once elected to CG. These items, unless believed otherwise by the community, should be addressed as a separate HIP following this one.
- Whether hotspot score should be eliminated is not addressed. Since it is not a fair representation of PoC performance and upon removing it from use in CG elections, one could argue that hotspot score is not needed. For simplicity in implementation and community agreement, this HIP does not address changing hotspot score and instead leaves that for consideration of a separate HIP, if at all.


# Deployment Impact
[deployment-impact]: #deployment-impact

Due to the introduction of new attributes, CG score and CG stake, this change may need to be deployed with the help of a chain variable (i.e. deploy blockchain changes and then later set chain variable to enable it). This can be left to an implementation detail.

Once effective, the network should require a minimum of 1000 hotspots to have the required CG Stake before the new consensus selection mechanism becomes active.


Existing documentation describing the hotspot score should be updated to reflect the addition of CG score and how it is used in CG group election.

# Success Metrics
[success-metrics]: #success-metrics
1. Number of HNT locked up
2. Number of CG eligible hotspots
3. More reliable CG performance
