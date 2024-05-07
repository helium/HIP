# HIP 90: Indefinitely Reduce IOT Location Assertion Cost

- Author(s): [@nosmaster89](https://github.com/nosmaster89)
- Start Date: 2023-06-22
- Category: Economic
- Original HIP PR: [#722](https://github.com/helium/HIP/pull/722)
- Tracking Issue: [#735](https://github.com/helium/HIP/issues/735)
- Vote Requirements: veIOT Holders

## Summary

This HIP proposes an adjustment to the Hotspot location assertion fees on the network. Currently, as per [HIP-69](https://github.com/helium/HIP/blob/main/0069-reassertion-fee-reduction.md) and since the Solana migration, the fees for IOT hotspots were halved. However, this adjustment is set to expire on July 20th, 2023, UTC, after which the fee will increase back to $10 in Data Credits. This proposal suggests maintaining the reduced fee to encourage hotspot relocation and support future HIPs aiming to distribute hotspots in densely populated areas.

## Motivation

The key motivations behind this proposal are as follows:

- Lowering the cost for hosts to relocate their hotspots going forward, facilitating better network coverage and decentralization.
- Establishing a minimum fee that reflects the network's expectations for hotspot relocation, ensuring a longer-term commitment from hotspot owners.

## Stakeholders

IOT Hotspot Makers, who will not have to pay the increased 1M DC ($10) Location assert fee on the first location reassertions.
IOT Hotspot owners, who will not have to pay the increased 1M DC ($10) Location assert fee on subsequent location reassertions.
And this proposal impacts the entire network as it affects the amount of DC burned, which influences the economics of all networks.

## Detailed Explanation

The proposal aims to extend the duration of the reduced asset fees for hotspot relocation that HIP 69 introduced indefinitely. By maintaining the lowered fee,
it becomes more attractive for hotspot owners to relocate their hotspots, increasing the likelihood of achieving better network coverage
in various locations. Additionally, this change supports future HIPss that aim to distribute hotspots in densely populated areas.

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

To implement this proposal, IOT Hotspot makers need to ensure that Maker Apps display and use the correct requirement of 500K DC/$5 for hotspot relocation.

## Success Metrics

The success of this HIP can be measured by monitoring the burn for asset fees after its implementation. A successful outcome would be the retention or increase of the level of assert location DC burn, indicating active hotspot relocation and continued network growth.
