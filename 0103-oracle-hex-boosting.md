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

* [HIP-74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage.
* [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.
* [HIP-85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) introduced penalties for overlapping CBRS coverage.
* [HIP-93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points. 

## Motivation:
HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighs all hexes equally, even if there's a low probability of actual coverage being needed in that area. This proposal aims to improve the value of the network coverage by incentivizing users to deploy CBRS and Wi-Fi in areas where Oracles have determined coverage is most likely needed. 

## Stakeholders:
The stakeholders of this proposal are:

- **Service Providers & Subscribers** will benefit from increased radio/wi-fi coverage in more useful places
- **Radio/Wi-Fi Deployers** can benefit from increased rewards for providing coverage in areas where coverage is needed

## Detailed Explanation:
MOBILE Boosting Oracles (refer herewith as “Oracles”) are data sources used to estimate how useful mobile coverage will be in a specific area. This HIP proposes allowing Oracles to be established to help guide deployments in areas that need more coverage. Oracles will be used to give applicable hexes boosts (increasing or decreasing) based on the area they are deployed in.

The data from each Oracle will be divided into categories and assigned a letter, beginning with A as the highest value and proceeding through the alphabet from there (B is the second highest value, C is the third highest value, etc.) based on the different types of locations that are delineated in the data. To avoid over complication, an Oracle shall not exceed X categories. 

The categories from each Oracle will then be combined to identify areas of overlap to create a set of subcategories. For example:
If Footfall Oracle is A, Land Type Oracle is B, and Urbanization Oracle is A, then the hex will be assigned the tag ABA.

Once all variations are accounted for, each tag will be assigned a value as outlined here:



![Screen Shot 2024-01-10 at 4 30 21 PM](https://github.com/helium/HIP/assets/104723888/25f4993a-61d3-4415-92ce-67ddef621810)



Before the Final Multiplier equation is run, the calculations will check to see whether or not that res12 hex is boosted by a Service Provider greater than 1x. If not, then the assigned value will be maintained. If yes, then the Final Multiplier will automatically be 1X. 

Once the Final Multiplier is calculated, this will be multiplied by any Service Provider Hex boosts, and then multiplied by the radio/wifi hex limit multiplier identified within HIP 85 and 105. The whole calculation is as followed:

Final Multiplier X Service Provider Hex Boost Multiplier X HIP 85/105 Multiplier X Modeled Coverage Points from HIP 74/93.

### Footfall Oracle 
This HIP recommends using data from third parties [Veraset](https://www.veraset.com/) and [SafeGraph](https://www.safegraph.com/), which identifies the level of footfall traffic in an area, and uses the method described [here](https://www.safegraph.com/guides/visit-attribution-white-paper) to determine areas that should have a higher multiplier based on their level of footfall. This data can be visualized on a map [here](https://shdw-drive.genesysgo.net/GANQ5D1hQVswq42Fk3vA3EYDddbNLLp1G2VmodQdprrF/index.html). This data is to be refreshed at least once per calendar year, but may be refreshed more frequently as new data from this source becomes available. Further, Nova Labs is able to add, but  A process for suggesting changes to the data (e.g., increasing the level for a location like a hospital or school, or reducing a residential or farm area) will be considered in a subsequent HIP. 

### Land Type Oracle  
This HIP recommends using data from the European Space Agency’s [WorldCover project](https://esa-worldcover.org/), as visualized [here](https://viewer.esa-worldcover.org/worldcover/?language=en&bbox=-255.05859374999997,-78.6991059255054,255.05859374999997,78.69910592550542&overlay=false&bgLayer=OSM&date=2023-12-25&layer=WORLDCOVER_2021_MAP), to identify the type of land, and provide multipliers based on land type. New data from this source will be incorporated into the Oracle as it becomes available. This Land Type Oracle will also be smoothed out to the res10 level like the Footfall Oracle above.

### Urbanization Oracle  
This HIP recommends using data from the United States Census Bureau's urban-rural classification, as defined [here](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html) and visualized [here](https://www.arcgis.com/apps/mapviewer/index.html?layers=10551da8fcd24062b1857473252b3df8), to provide multipliers based on if they are, or are not urbanized. New data from this source will be incorporated into the Oracle as it becomes available. This Urbanization Oracle will also be smoothed out to the res10 level like the Footfall Oracle above.


### Smoothing of Data
As data from Oracles stem from third parties, the HIP authors recognize that there may be gaps or errors within the map and data used. Therefore, data from Oracles will be represented at a res10 hex level, and all res12 hexes within each res10 hex will have the same, highest value. For example, if one res12 hex within the res10 hex has a footfall range higher than 1.00, and all other res12 hexes within that res10 hex have 0, all res12 hexes within that res10 hex will be awarded for having footfall traffic of 1.00+

## Deployment Impact
Nova Labs has agreed to undertake the work to implement this HIP shall it pass. 

## Drawbacks:
The implementation of this proposal could increase the complexity of the Helium Mobile network, and modeled coverage scores. There may be concerns about the accuracy of the population data provided, or the need to update the data regularly. 

## Alternatives
Alternative methods of how Oracles interact and calculated were explored during the community discussion phase of this HIP, but ultimately, having Oracle's multiply, add, or be weighted didn't allow for the fine tuning of the Oracles to mirror real world scenarios. 

## Success Metrics
The primary success metric will be greater coverage on the modeled coverage map in areas where top carriers have already identified as areas that need data.
