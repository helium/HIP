# HIP ??: Data-Driven Extension: Continuation of Reduced IOT Location Assertion Cost

- Author(s): [@maxgold91](https://github.com/maxgold91), [@bfgneil](https://github.com/bfgneil), [@mawdegroot](https://github.com/mawdegroot), Fizzy, [@AndrewsMD](@github.com/andrewsMD)
- Start Date: 2023-07-09
- Category: Economic 
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veIOT Holders

## Summary

This HIP proposes an extension of the reduced Hotspot location assertion fees on the network. Currently, the fees for IOT hotspots were halved as per HIP-69 since the Solana migration. However, this adjustment is set to expire on July 20th, 2023, UTC, after which the fee will increase back to $10 in Data Credits. This proposal suggests maintaining the reduced fee for an additional 3 months to incentivize hotspot relocation and gather more data on the impact of a $5 versus a $10 reassert fee.

## Motivation

The key motivations behind this proposal are as follows:

- Facilitating better network coverage and decentralization by reducing the cost for hosts to relocate their hotspots.
- Ensuring a longer-term commitment from hotspot owners by establishing a minimum fee that aligns with the network's expectations for hotspot relocation.
- Gathering additional data before permanently implementing this change.
- Due to issues with the migration to Solana, more time is needed to collect data on reassert transactions, which was supposed to be done after the passage of HIP-69.

## Stakeholders

- IOT Hotspot Makers: They will not have to pay the increased 1M DC ($10) Location assert fee on the first location reassertions.
- IOT Hotspot Owners: They will not have to pay the increased 1M DC ($10) Location assert fee on subsequent location reassertions.
- This proposal impacts the entire network as it affects the amount of DC burned, influencing the economics of all networks.

## Detailed Explanation

The proposal aims to indefinitely extend the duration of the reduced asset fees for hotspot relocation introduced by HIP 69. By maintaining the lowered fee, hotspot owners are more likely to relocate their hotspots, leading to improved network coverage in various locations. This change also supports future HIPs that aim to distribute hotspots in densely populated areas. After 3 months, the chain variable for location asserts will revert to $10, unless a new HIP is passed to keep the assert fee at $5 or any other value as decided by the community.


## Drawbacks

The primary drawback of this proposal is a lower overall DC burn for the network. However, the potential benefits gained from increased hotspot relocation and improved network coverage can offset this drawback.

## Rationale and Alternatives

The rationale behind this proposal is that the current reduced asset fee represents a reasonable minimum fee for the expected lifespan of a hotspot at a new location. By keeping the fee reduced, hotspot owners are more likely to commit to longer-term hotspot operation, thus supporting network stability and coverage. An alternative could be to maintain the original asset fee of $10, but this may discourage hotspot relocation and hinder efforts to optimize hotspot distribution.

## Unresolved Questions

- To what extent is the asset cost a deciding factor for hotspot owners when considering hotspot relocation?
- How does the overall DC burn affect the economics of the network?

## Deployment Impact

To implement this proposal, IOT Hotspot makers need to ensure that Maker Apps display and use the correct requirement of 500K DC/$5 for hotspot relocation.

## Success Metrics

The success of this HIP can be measured by monitoring the burn for asset fees after its implementation. A successful outcome would be the retention or increase of the level of assert location DC burn, indicating active hotspot relocation and continued network growth.

