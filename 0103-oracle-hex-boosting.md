# HIP 103: MOBILE Oracle Hex Boosting

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) & [@zer0tweets](https://github.com/zer0tweets) & [Jeremy Mahrle](https://github.com/jaym2518)
- Contributor: [Gateholder](https://github.com/gateholder) & [Max Gold](https://github.com/maxgold91) & BZ
- Start Date: 2023-12-18
- Category: Economic, Technical
- Original HIP PR: [#822](https://github.com/helium/HIP/pull/822)
- Tracking Issue: [#836](https://github.com/helium/HIP/issues/836)
- Vote Requirements: veMOBILE Holders

## Summary:

This Helium Improvement Proposal (HIP) discusses how Oracle Boosting rewards are calculated and creates three (3) new Oracles:

- Footfall Oracle - incentives deployments in areas that have heavy footfall traffic
- Land Type Oracle - discourages deployments that cover empty fields and bodies of water
- Urbanization Oracle - encourages deployments in urbanized areas

## Prior Related HIPs

- [HIP-74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage.
- [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.
- [HIP-85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) introduced penalties for overlapping CBRS coverage.
- [HIP-93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points.

## Motivation:

HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighs all hexes equally, even if there's a low probability of actual coverage being needed in that area. This proposal aims to improve the value of the network coverage by incentivizing users to deploy CBRS and Wi-Fi in areas where Oracles have determined coverage is most likely needed.

## Stakeholders:

The stakeholders of this proposal are:

- **Service Providers & Subscribers** will benefit from increased radio/wi-fi coverage in more useful places
- **Radio/Wi-Fi Deployers** can benefit from increased rewards for providing coverage in areas where coverage is needed

## Detailed Explanation:

MOBILE Boosting Oracles (refer herewith as “Oracles”) are data sources used to estimate how useful mobile coverage will be in a specific area. This HIP proposes allowing Oracles to be established to help guide deployments in areas that need more coverage. Oracles will be used to give applicable hexes boosts (increasing or decreasing) based on the area they are deployed in.

The data from each Oracle will be divided into categories and assigned a letter, beginning with A as the highest value and proceeding through the alphabet from there (B is the second highest value, C is the third highest value, etc.) based on the different types of locations that are delineated in the data.

The categories from each Oracle will then be combined to identify areas of overlap to create combination values. For example:
If Footfall Oracle is A, Land Type Oracle is B, and Urbanization Oracle is A, then the hex will be assigned the combination value of ABA.

Once all combinations are accounted for, each combination value will be assigned an Oracle Multiplier as outlined here:


![Screen Shot 2024-01-19 at 2 19 05 PM](https://github.com/helium/HIP/assets/104723888/95674006-9542-46ac-b7ef-e344848f97a5)


Further, the HIP authors acknowledge that areas that Service Providers boost through hex boosting are areas where coverage is needed the most. Therefore, if a res12 hex is boosted by a Service Provider of ≥1, the Oracle Multiplier will automatically be 1.00X, regardless of what combination value it is assigned. 

Once the Oracle Multiplier is calculated, this will be multiplied by Service Provider Hex boosts (from HIP 84), and then multiplied by the radio/wifi hex limit multiplier identified within HIP 85 and 105. The whole calculation is as followed:

Oracle Multiplier X HIP 84 Service Provider Hex Boost Multiplier X HIP 85/105 Multiplier X Modeled Coverage Points from HIP 74/93.

### Footfall Oracle

This HIP will use data from third parties [Veraset](https://www.veraset.com/) and [SafeGraph](https://www.safegraph.com/), which identifies the level of footfall traffic in an area, and uses the method described [here](https://www.safegraph.com/guides/visit-attribution-white-paper) to determine areas that should have a higher multiplier based on their level of footfall. This data can be visualized on a map [here](https://shdw-drive.genesysgo.net/5RgAheef6auTTu8DVMfAXSYtq4RrzK1jeW4tGCPrAhqX/index.html?filter_name=visitors&filter_value=0). Nova Labs has agreed to pay for the API to this data, and refresh this data at least once a quarter (every three months).

The HIP authors believe footfall traffic to be the most important Oracle, and therefore, any hexes with footfall traffic ≥1 will automatically be given the max Oracle Multiplier of 1.00X.

Further, from review of the footfall data, it's acknowledged by the HIP authors that some Point of Interests, such as schools, hospitals, etc. may not be included within the footfall data API purchased from Veraset due to U.S. Privacy Laws. Therefore, this HIP grants authority to any subDAO approved Service Provider to add the following areas to the footfall oracle as a POI ≥1 that are not correctly represented in the data:

- Any schools and or college campuses/Universities
- Any sports arenas or stadiums
- Any Hospitals
- Any Parks

A process for the community to recommend additions will be implemented in a future HIP. 


### Land Type Oracle

This HIP will use the data from the European Space Agency’s [WorldCover project](https://esa-worldcover.org/), as visualized [here](https://viewer.esa-worldcover.org/worldcover/?language=en&bbox=-255.05859374999997,-78.6991059255054,255.05859374999997,78.69910592550542&overlay=false&bgLayer=OSM&date=2023-12-25&layer=WORLDCOVER_2021_MAP), to identify the type of land, and provide multipliers based on land type. New data from this source will be incorporated into the Oracle as it becomes available. This Land Type Oracle will also be smoothed out to the res10 level like the Footfall Oracle above. When this source publishes new data, the data for this Oracle will be refreshed within 6 calendar months. 

### Urbanization Oracle
This HIP will use the data from the United States Census Bureau's urban-rural classification, as defined [here](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html) and visualized [here](https://www.arcgis.com/apps/mapviewer/index.html?layers=10551da8fcd24062b1857473252b3df8), to provide multipliers based on if they are, or are not urbanized. New data from this source will be incorporated into the Oracle as it becomes available. This Urbanization Oracle will also be smoothed out to the res10 level like the Footfall Oracle above. When this source publishes new data, the data for this Oracle will be refreshed within 6 calendar months. 

### Smoothing and Refinement of Data
As data from Oracles stem from third parties, the HIP authors recognize that there may be gaps or errors within the map and data used. Therefore, data from Oracles will be represented at a res10 hex level, and all res12 hexes within each res10 hex will have the same value. 


## Deployment Impact and Implementation
Nova Labs has agreed to undertake the work to implement this HIP shall it pass. These Oracles will be implemented one-by-one to have a faster roll out. Nova Labs has estimated that it will take 30 days to implement each Oracle, for a total of 90 days for full HIP implementation. Please note, these are estimates, and not guaranteed. Specific Oracles may take longer, or shorter to fully implement. Nova Labs will provide a three (3) epoch notice prior to the implementation/go live of each of these Oracles. The order of implementation, and assigned multipliers will be as followed:


1. Urbanization Oracle - Estimated Implementation Date - 30 Days after HIP passing

![Screen Shot 2024-01-19 at 3 29 35 PM](https://github.com/helium/HIP/assets/104723888/b018f102-f1d9-448e-8cae-5ed6e91d7f2e)

2. Urbanization Oracle and Footfall Oracle - Estimated Implementation Date - 60 Days after HIP passing

![Screen Shot 2024-01-19 at 3 29 50 PM](https://github.com/helium/HIP/assets/104723888/edb2fd84-18ff-4a41-be8b-d88029977274)

3. All Three (3) Oracles  - Estimated Implementation Date - 90 Days after HIP passing
   
![Screen Shot 2024-01-19 at 2 19 05 PM](https://github.com/helium/HIP/assets/104723888/95674006-9542-46ac-b7ef-e344848f97a5)

Any questions on implementation that are not clear from this HIP shall be directed to the HIP authors for clarification.

## Drawbacks:

The implementation of this proposal could increase the complexity of the Helium Mobile network, and modeled coverage scores. There may be concerns about the accuracy of the population data provided, or the need to update the data regularly.

## Alternatives

One alternative would be to use subscriber discovery mapping data to identify areas in which there are multiple Helium Mobile subscribers; however, this method is easily gamed and would be heavily exploited.


## Success Metrics

The primary success metric will be greater coverage on the modeled coverage map in areas where top carriers have already identified as areas that need data.
