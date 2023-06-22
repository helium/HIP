# HIP X: Extend hip-69 indefinitely

- Author(s): @nosmaster89
- Start Date: 2023-06-22
- Category: Economic 
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT Holders

## Summary

this proposes an adjustment to the hotspot relocation fees on the network. Currently, as per the migration hip-69, the asset fees for IoT hotspots
have been halved. However, this adjustment is set to expire on July 20th, 2023, UTC, after which the asset fee will increase back to $10. This
proposal suggests maintaining the reduced fee to encourage hotspot relocation and support future hips aiming to distribute hotspots in densely 
populated areas.

## Motivation
The key motivations behind this proposal are as follows:

- Lowering the cost for hosts to relocate their hotspots going forward, facilitating better network coverage and decentralization.
- Establishing a minimum fee that reflects the network's expectations for hotspot relocation, ensuring a longer-term commitment from hotspot owners.

## Stakeholders

This proposal impacts the entire network as it affects the amount of DC burned, which influences the economics of all subdaos.

## Detailed Explanation
The proposal aims to extend the duration of the reduced asset fees for hotspot relocation indefinitely. By maintaining the lowered fee,
it becomes more attractive for hotspot owners to relocate their hotspots, increasing the likelihood of achieving better network coverage
in various locations. Additionally, this change supports future hips that aim to distribute hotspots in densely populated areas.


## Drawbacks
The primary drawback of this proposal is a lower overall DC burn for the network.
However, this can be balanced by the potential benefits gained from increased hotspot relocation and improved network coverage.

## Rationale and Alternatives

The rationale behind this proposal is that the current lowered asset fee represents a reasonable minimum fee for the expected lifespan of a hotspot at a new location. By keeping the fee reduced, hotspot owners are more likely to commit to longer-term hotspot operation, thus supporting network stability and coverage.
An alternative could be to maintain the original asset fee of $10, but this may discourage hotspot relocation and hinder efforts to optimize hotspot distribution.

## Unresolved Questions

- Is the asset cost a deciding factor for hotspot owners when considering hotspot relocation?
- How does the overall DC burn affect the economics of the network?

## Deployment Impact

To implement this proposal, makers need to ensure that applications display the correct requirement of 500k DC for hotspot relocation.

## Success Metrics

The success of this HIP can be measured by monitoring the burn for asset fees after its implementation. A successful outcome would be the retention of a reasonable level of burn, indicating active hotspot relocation and continued network growth.
