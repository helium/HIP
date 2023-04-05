# HIP-xxxx IOT Proof-of-Coverage, Version 12

- Author(s): @jerm
- Start Date: 2023-03-30
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

In this HIP we propose a new Proof-of-Coverage scheme for the Helium IOT network that:

- Rewards Hotspot operators only for dependable, high-quality coverage,
- Encourages continuous improvements to the same,
- Makes rewards easier to understand and predict, and
- Removes the threat of having a quality installation ruined by invasive density.

Under this proposal, IOT PoC rewards will be given _only_ to a maximum of four _qualified_ Hotspots in any given region bounded by an H3 hexagon at resolution 8.

# Motivation

The Proof-of-Coverage algorithm (PoC) is what makes the Helium Network unique. PoC has fueled Helium's phenomenal
growth and allowed it to achieve its original goal of providing a ubiquitous, low-cost, world-wide network
powered by the collective efforts of ordinary people.

As the Network transitions out of this phase of explosive growth it must now transition to a phase of
increasing quality. When properly installed, a Hotspot can provide useful coverage for a large area,
but when installed haphazardly without thought and care, a Hotspot contributes very little to the
network; or even worse, begins to degrade it.

For the Network to become truly valuable it must reach and demonstrate a level of quality that
gains the trust and business of _users_ of the Network. The reward scheme in this proposal
introduces a framework that acts like a _Service Level Agreement_ between Hotspot operators
and Network users, aligning their collective interests.

In exchange for binding to the agreement, Hotspot operators will receive exclusive PoC rewards for a hex, which
will not dilluted or reduced by newcomers until the newcomers demonstrate a higher quality of service than the
incumbents.

## Supported Use Cases

- Quality installations that remain undisturbed by random, unqualified assertions.
- Consistent reward scheme that does not require calculating HIP-17 densities.
- Objective service level measurements consumable by Network users.
- Framework for future improvements.

## Problems Solved

The Helium IoT Network has too many Hotspots in some areas and not enough Hotspots in others. In the areas where
there are too many Hotspots, there are _very_ many Hotspots. In such areas there is no incentive for any one
Hotspot operator to provide high quality service to the Network. Any appreciable effort they make to improve coverage, uptime, or latency of their setups is dwarfed by the sheer number of neighbors with which they must share rewards. In addition to this punitive effect on Hotspots, the Network itself suffers from a useless increase in noise on the
LoRaWAN spectrum as each of the redundant Hotspots in an area sends a Beacon.

While the Helium community had the foresight to adopt HIP 17 (Hex Density Based Reward Scaling) in anticipation of the
threat of over-dense deployments, it has not done enough to discourage them. In addition, HIP 17 has proven very difficult
for Hotspot owners to understand and visualize, which further exacerbates needless deployments.

This proposal fixes all of these issues by reworking the Proof-of-Coverage reward scheme so that Hotspot owners must engage
attentively with the Network in order to receive rewards, giving high quality deployments a dependable source of rewards
while removing the threat of low-quality neighbors dilluting them, and by removing the difficult calculations involved
with HIP 17 density scaling.

## Expected Outcome

- Network is viewed as high-quality, commercially acceptable.
- Increased trust yields more roaming, network use, long-term commitments.
- Rewards consistently meet requirements to sustain deployments.

# Stakeholders

- Who is affected by this HIP? A stakeholder is any individual, group, or party such as network
  users, Hotspot hosts, or token holders.

- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIP repository or even directly active in the Helium Community chat channels.

# Detailed Explanation

In the scheme being proposed, IOT PoC rewards will be given _only_ to the four _most qualified_
Hotspots in any given region bounded by an H3 hexagon at resolution 8 ("hex"). A qualified Hotspot is one
that has offered a _stake_ in the hex and has won a selection spot based on its demonstrated Service
Level. At a weekly interval, the Network will evaluate the Service Levels of all Hotspots in a hex,
selected or not, and perform a new qualification round. If the Network finds that the qualification
round results in a change to the most-qualified list, Hotspots loosing their qualification will
be swapped out of their selection spots and new entrants will replace them.

## H3 System, Resolution 8 Hex

## The Service Level Metric
-- Metrics are gathered for all participants, not just those selected.

## Hex States: Warming-up or Staked
- State reward changes: in staked hexes, only selected hotspots receive PoC rewards

## Staking Procedure
- Describe staking procedure, requirements
-- Minimum stake amount, timing

## Qualification Rounds

- Describe selection procedure, hex limits
-- Combined score = overstake amount + metrics
- Slot occupation term ("Epoch") is 1 week

## Future advancements:
- Hex limit adjusts by network load
- Hex bounties
- Slashing
- Example scenarios

# Drawbacks

Q: Disgruntled Hotspot operators flee?
Q: What if on-line Hotspot numbers decrease?

## Rationale and Alternatives

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?

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

What metrics can be used to measure the success of this design? Are any new ETL reports needed to
measure the success?

- What should we measure to prove a performance increase?
- What should we measure to prove an improvement in stability?
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by its users?
