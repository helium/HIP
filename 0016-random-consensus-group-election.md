# HIP16: Remove Score from Consensus Group (CG) Election

- Author(s): [@PaulVMo](https://github.com/PaulVMo) (@PaulM on Discord)
- Start Date: 2020-10-14
- Category: Economic, Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/54>
- Tracking Issue: <https://github.com/helium/HIP/issues/55>
- Status: Deployed ([audit](https://github.com/helium/miner/blob/master/audit/var-48.md) /
  [txn](https://explorer.helium.com/txns/DywtCExrXhTxv8VoDZl_hJDjQ2PUcov_AYrW98ZPpcg))

# Summary

Changes to the election process for Consensus Group (CG) members to make all active Hotspots equally
likely to be selected to the CG instead of the current functionality that favors Hotspots with a
higher Hotspot PoC-based score.

# Motivation

Increase fairness in the selection of Hotspots to be members of the Consensus Group and the
allocation of associated rewards for CG membership. As noted throughout the community, the current
approach of using Hotspot score does not align with the spirit of CG selection:

- Hotspot score is currently a poor indication of coverage provided. This is well documented in the
  community and by members of the Helium, Inc. team. The current guidance on Discord and other
  outlets is that score should be ignored as a metric of how well a Hotspot is performing regarding
  Proof of Coverage.
- Furthermore, Hotspot score is easily gamed. Members of the community and Helium Inc suspect that
  many of the Hotspots with the highest score (e.g., >0.98) are in fact gaming the system by
  asserting false locations or otherwise faking PoC data. Yet, these Hotspots are the most likely to
  be elected to CG.

# Stakeholders

All current Hotspots will be affected by this change:

- Currently high-scoring Hotspots will be less likely to be elected to CG and, as a result, will see
  a small decrease in CG rewards.
- Currently low-scoring Hotspots will be more likely to be elected to CG than currently and, as a
  result, will see a small increase in CG rewards.

Feedback is being solicited through Discord, and additionally, propose pushing a notification
through the Helium mobile app to provide broader awareness of this HIP.

# Detailed Explanation

Currently, Consensus Group election are based on two major factors: score and geography. Hotspots
with with higher scores are more likely to be selected. Geography is used to prevent multiple
Hotspots from the same H3 hex from participating in the same CG.

This HIP proposes the following changes to the CG election process:

- Score will no longer be considered.
- Active Hotspots will be randomized and score will not be taken into account for potential election
  into the Consensus Group.
- Current members of the Consensus Group will be randomly deselected as well.
- Geography will continue to be used to prevent Hotspots in the same area to be elected to the
  Consensus Group (no changes).

Due to the fact that CG selection will be randomly assigned, there is no need to expose it to users
of the Helium app or Explorer. We will consider removing score from the app and Explorer pending a
full rework of the mechanism.

# Drawbacks

Randomized selection of CG members may lead to unexpected consequences and impact performance of the
CG.

- Randomized selection may result in more CG members who perform poorly. Hotspots with high scores
  are the ones most likely to be elected to CG. And Hotspots with high score likely have those high
  scores because the owner has taken deliberate steps to optimize their setup (or even game the
  network). It is reasonable to assume that deliberate attention to the Hotspot setup results in
  better performance of CG members. If too many poor performing CG members are randomly elected
  under this proposal, it may stall the blockchain or otherwise hurt block times.
- This proposal provides more incentive to run Hotspots without providing meaningful coverage. For
  example, "lone wolf" Hotspots (a Hotspot with no others in range) will, on average, see higher
  rewards. This may have undesirable effects on the growth of the network.

# Rationale and Alternatives

There are a few alternatives to solving the core issue identified in this HIP: the disconnect
between current Hotspot score and CG performance. This HIP attempts to balance simplicity of
implementation with fairness and providing for a path to a more comprehensive solution. Several
alternatives are outlined below.

By not taking up this proposal, CG rewards will continue to add incentive for Hotspots to game PoC.
Falsely asserting location and other gaming of PoC hurts the quality of the network and hurts honest
Hotspot owners. While this does not eliminate this gaming, it makes it slightly less profitable and
starts to pave the way for a more robust CG approach.

Additionally, it should be noted that PoC and CG have distinct portions of the HNT reward pool. As
such, there should be a distinct mechanism for rewarding these. However the current scoring
mechanism, if functioning properly, tightly couples these rewards: better PoC performance => higher
score => greater chance to CG membership => more CG reward.

### Alternative: Create new metric for Hotspot CG score

As noted above, CG performance is dictated by factors such as connectivity and CPU/memory
performance. For that reason, the score could be computed based on these factors or past CG
membership performance. For expediency of gaining alignment and adoption, this HIP proposes randomly
assigning score and deferring a metric-based score for a later HIP. By taking the changes in
multiple steps, it enables CG rewards to move toward greater fairness more quickly while preserving
the option to implement a more sophisticated metric.

# Unresolved Questions

- This HIP does not provide a mechanism to exclude Hotspots or allow them to opt-out of CG. Some
  Hotspots, especially with the introduction of DIY Hotspots, may not have the capability (e.g.,
  insufficient CPU or memory capacity) and/or desire to participate in CG. This needs to be
  considered by the community as there are other ideas about increasing the CG size which requires
  more CPU/memory as well as the potential to add complexity to PoC validation as part of ongoing
  efforts to prevent gaming.
- Whether Hotspot score should be eliminated is not addressed. Since it is not a fair representation
  of PoC performance and upon removing it from use in CG elections, one could argue that Hotspot
  score is not needed. For simplicity in implementation and community agreement, this HIP does not
  address changing Hotspot score and instead leaves that for consideration of a separate HIP, if at
  all.

# Deployment Impact

Due to the introduction of a new selection criteria for Consensus Group election, this change will
need to be deployed with the help of a chain variable (i.e. deploy blockchain changes and then later
set the `election_version` chain variable to enable it).

Once active, the new election process should apply to new CG members only. Existing members at the
time of the implementation will remain in the CG and be removed over time as per the existing logic
which targets to keep 12 of 16 members and remove the rest. The replacement members from the time of
the implementation of this HIP would then be elected as per this proposal.

Existing documentation describing the Hotspot score should be removed.

# Success Metrics

- More equally distributed CG rewards
- Equally reliable CG performance
