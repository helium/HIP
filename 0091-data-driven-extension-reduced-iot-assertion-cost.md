# HIP 91: Data-Driven Extension: Continuation of Reduced IOT Location Assertion Cost

- Author(s): [@maxgold91](https://github.com/maxgold91), [@bfgneil](https://github.com/bfgneil), [@mawdegroot](https://github.com/mawdegroot), Fizzy, [@AndrewsMD](https://github.com/andrewsMD)
- Start Date: 2023-07-09
- Category: Economic
- Original HIP PR: [#738](https://github.com/helium/HIP/pull/738)
- Tracking Issue: [#743](https://github.com/helium/HIP/issues/743)
- Vote Requirements: veIOT Holders

## Summary

This HIP proposes an extension of the reduced Hotspot location assertion fees on the network. Currently, the fees for IOT hotspots were halved as per HIP-69 since the Solana migration. However, this adjustment is set to expire on July 20th, 2023, UTC, after which the fee will increase back to $10 in Data Credits. This proposal suggests maintaining the reduced fee for an additional 6 months to incentivize hotspot relocation and gather more data on the impact of a $5 versus a $10 reassert fee.

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

The proposal aims to extend the duration of the reduced location assertion fees introduced by HIP 69 with 6 months. The extension will be used to further study the effect of reduced location assertion fees as initially set out by HIP 69. In the months following the migration to Solana, there were several issues with hotspot location assertion and as such it is believed that the initial 3 month period does not provide adequate data for determining the success of HIP 69.

The Helium Foundation has committed to provide the community with location assertion data 1.5 month before the 6 month extension expires. The data will be used to identify if the reduced location assertion fees have the intended effect. Several key metrics will be used to determine the effectiveness of a reduced location assertion fee.

1. **The amount of (legitimate) hotspot relocations**: if the amount of hotspot relocations increases this indicates that the reduced fees had a positive effect on building out the network.

2. **Percentage of legitimate hotspot relocations**: if the percentage of illegitimate hotspot relocations increases it is an indicator that the hotspot assertion fee is no longer providing an adequate deterrent against malicious actors.

We use the following criteria to determine if a hotspot relocation is legitimate:

1. **Time between hotspot relocations**: a known indicator of illegitimate hotspot relocations is the time between hotspot relocations. Several bad actors have used repeated hotspot relocations as a way to avoid detection.

2. **Distance of the hotspot relocation**: a hotspot that relocates over a significant distance is likely truly relocating to a new area where it provides more value for the network. A hotspot that relocates over a very short distance is more likely to engage in what is often called "TS optimization". The goal of this proposal is to encourage relocating to a new location that is more valuable to the network and we will thus disregard small relocations.

## Drawbacks

The primary drawback of this proposal is a lower overall DC burn for the network. However, the potential benefits gained from increased hotspot relocation and improved network coverage can offset this drawback. It is important to evaluate if the potential benefits to the network are achieved by reducing the assertion fees to avoid reducing the DC burn without benefits.

## Rationale and Alternatives

The rationale behind this proposal is to obtain more data to reach a conclusion. The hotspot assertion issues following the migration to Solana have created a biased data set and it is therefore difficult to determine whether the reduced assertion fees of HIP 69 had the intended effect. It is important to provide hotspot owners with a way to move hotspots to more valuable locations and the assertion fee should not be the limiting factor. At the same time it is important to recognize that location assertion fees provide revenue for the network and that reducing the location assertion fee without changing hotspot owner behavior is a net-negative for the network.

The alternative to this proposal is to simply revert the location assertion fee to $10 but we believe the extension can provide the data that is needed to come to a data driven conclusion.

## Unresolved Questions

Several unresolved questions remain that can be better evaluated with the data gathered during the 6 month extension. The main question is to what extent the assertion fee is a deciding factor in relocating a hotspot.

## Deployment Impact

The Helium Foundation has committed to providing the community with the hotspot assertion data 1.5 months before the 6 month extension ends. There is no action required from the remaining actors of the network (e.g. hotspot owners, makers) because this proposal extends the (temporary) status quo set out by HIP 69.

## Success Metrics

This proposal is deemed successful if it provides the data necessary to determine whether a more permanent reduction of the assertion fee is warranted. The assertion fee reduction has the intended effect if the data can show that the amount of hotspot relocations increase while not increasing the amount of illegitimate hotspot relocations.
