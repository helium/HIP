# HIP16: Random Consensus Group (CG) Election

- Author(s): [@PaulVMo](https://github.com/PaulVMo) (@PaulM on Discord)
- Start Date: 2020-10-14
- Category: Economic
- Original HIP PR: https://github.com/helium/HIP/pull/54
- Tracking Issue: https://github.com/helium/HIP/issues/55

# Summary
[summary]: #summary

Changes to the election process for Consensus Group (CG) members to make all active hotspots equally likely to be selected to the CG instead of the current functionality that favors hotspots with a higher hotspot score.

# Motivation
[motivation]: #motivation

Increase fairness in the selection of hotspots to be members of the Consensus Group and the allocation of associated rewards for CG membership. As noted throughout the community, the current approach of using hotspot score does not align with the spirit of CG selection:
- Hotspot score is a poor indication of coverage provided. This is well documented in the community and by members of the Helium Inc team. The current guidance on Discord and other outlets is that score should be ignored as a metric of how well a hotspot is performing regarding Proof of Coverage.
- Furthermore, hotspot score is easily gamed. Members of the community and Helium Inc suspect that many of the hotspots with the highest score (e.g., >0.98) are in fact gaming the system by asserting false locations or otherwise faking PoC data. Yet, these hotspots are the most likely to be elected to CG.
- Lastly, hotspot score is intended to measure PoC performance which is separate and distinct from a hotspot's ability and performance to engage in Consensus Group activities. For example, factors such as reachability on public Internet (vs. relaying through P2P network), Internet connection speed and reliability, and processing power and memory impact a hotspot's ability to perform CG. However, these are not currently measured by hotspot score.

# Stakeholders
[stakeholders]: #stakeholders

All current hotspots will be affected by this change:
- Currently high-scoring hotspots will be less likely to be elected to CG and, as a result, will see a decrease in CG rewards.
- Currently low-scoring hotspots will be more likely to be elected to CG than currently and, as a result, will see an increase in CG rewards.

Feedback is being solicited through Discord, and additionally, propose pushing a notification through the Helium mobile app to provide broader awareness of this HIP.


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Currently, Consensus Group election are based on two major factors: score and geography. Hotspots with a score equal or greater than the min_score chain variable (currently 0.15) are eligible for CG, and hotspots with higher scores are more likely to be selected. Geography is used to prevent multiple hotspots from the same H3 hex from participating in the same CG.

This HIP proposes the following changes to the CG election process:
- New “CG score” attribute will be created for hotspots
- A value between 0.0 and 1.0 will be randomly assigned for CG score once per CG election to each hotspot
- “CG score” will replace the use of the current score in the CG election for filtering and weighting hotspots

No other changes to how score and geography is used in elections are to be made as part of this HIP. 

Due to the fact that CG score will be randomly assigned, there is no need to expose at his point to users of the Helium app or Explorer.

# Drawbacks
[drawbacks]: #drawbacks
Randomized selection of CG members may lead to unexpected consequences and impact performance of the CG.
- Randomized selection may result in more CG members who perform poorly. Hotspots with high scores  are the ones most likely to be elected to CG. And hotspots with high score likely have those high scores because the owner has taken deliberate steps to optimize their setup (or even game the network). It is reasonable to assume that deliberate attention to the hotspot setup results in better performance of CG members. If too many poor performing CG members are randomly elected under this proposal, it make stall the blockchain or otherwise hurt performance.
- This proposal provides more incentive to run hotspots without providing meaningful coverage. For example, "lone wolf" hotspots (a hotspot with no others in range) will, on average, see higher rewards. This may have undesirable effects on the growth of the network.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

There are several alternatives to solving the core issue identified in this HIP: the disconnect between current hotspot score and CG performance. This HIP attempts to balance simplicity of implementation with fairness and providing for a path to a more comprehensive solution. Several alternatives are outlined below.

By not taking up this proposal, CG rewards will continue to add incentive for hotspots to game PoC. Falsely asserting location and other gaming of PoC hurts the quality of the network and hurts honest hotspot owners. While this does not eliminate this gaming, it makes it slightly less profitable and starts to pave the way for a more robust CG approach.

Additionally, it should be noted that PoC and CG have distinct portions of the HNT reward pool. As such, there should be a distinct mechanism for rewarding these. However the current scoring mechanism, if functioning properly, tightly couples these rewards: better PoC performance => higher score =>  greater chance to CG membership => more CG reward.

### Alternative: Randomly assign hotspot score
Equivalent functionality could be achieved by randomly assigning a value to the existing hotspot score. This approach would be simpler to implement than introducing a new CG score attribute. However, this HIP favors introducing a new CG score over modifying the existing hotspot score for a couple reasons. First, it introduces and emphasizes the concept of CG performance being separate and distinct from PoC performance. This will likely be an important concept as the CG is evolved overtime. Second, to the extent that the current hotspot score is useful for hotspots owners who do use it to help optimize their setup (hotspot placement, antenna, etc.), the proposed approach will avoid any impact to them.

### Alternative: Remove score from CG election protocol entirely
Removing score from the election process entirely could also be used to achieve similar results. Without score to rank hotspots, hotspots would need to be randomly voted on. However, this approach of removing score entirely is contradictory to the goal of creating a path to a CG election protocol that is more representative of CG performance. Additionally, it is possible that the changes to the blockchain required for this alternative are more complex/impactful and thus risky to make than the proposal.

### Alternative: Create new metric for hotspot CG score
As noted above, CG performance is dictated by factors such as connectivity and CPU/memory performance. For that reason, the score could be computed based on these factors or past CG membership performance. For expediency of gaining alignment and adoption, this HIP proposes randomly assigning score and deferring a metric-based score for a later HIP. By taking the changes in multiple steps, it enables CG rewards to move toward greater fairness more quickly while preserving the option to implement a more sophisticated metric.


# Unresolved Questions
[unresolved]: #unresolved-questions

- What constitutes an "active" hotspot is not defined in this HIP. There needs to be some basic filtering of hotspots eligible for selection to CG. For example, an offline or unreachable hotspot should not be included in CG selection. This can be an addressed as an implementation detail if not part of existing functionality.
- Apart from basic criteria of being active, this HIP does not outline a metric specifically for CG eligibility/selection or create a penalty for poor performance once elected to CG. These items, unless believed otherwise by the community, should be addressed as a separate HIP following this one.
- This HIP does not provide a mechanism to exclude hotspots or allow them to opt-out of CG. Some hotspots, especially with the introduction of DIY hotspots, may not have the capability (e.g., insufficient CPU or memory capacity) and/or desire to participate in CG. This needs to be considered by the community as there are other ideas about increasing the CG size which requires more CPU/memory as well as the potential to add complexity to PoC validation as part of ongoing efforts to prevent gaming.
- Whether hotspot score should be eliminated is not addressed. Since it is not a fair representation of PoC performance and upon removing it from use in CG elections, one could argue that hotspot score is not needed. For simplicity in implementation and community agreement, this HIP does not address changing hotspot score and instead leaves that for consideration of a separate HIP, if at all.


# Deployment Impact
[deployment-impact]: #deployment-impact

Due to the introduction of a new attribute, CG score, this change may need to be deployed with the help of a chain variable (i.e. deploy blockchain changes and then later set chain variable to enable it). This can be left to an implementation detail.

Once effective, the new election process should apply to new CG members only. Existing members at the time of the implementation should remain in the CG and be removed overtime per the existing logic which targets to keep 12 of 16 members and remove the rest. The replacement members from the time of the implementation of this HIP would then be elected per this proposal.

Existing documentation describing the hotspot score should be updated to reflect the addition of CG score and how it is used in CG group election.
# Success Metrics
[success-metrics]: #success-metrics
- More equally distributed CG rewards
- Equally reliable CG performance
