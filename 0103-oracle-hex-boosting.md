# HIP 103: MOBILE Oracle Hex Boosting

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) & [@zer0tweets](https://github.com/zer0tweets)
- Contributor: [Gateholder](https://github.com/gateholder) & [Max Gold](https://github.com/maxgold91)
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
MOBILE Boosting Oracles (refer herewith as “Oracles”) are data sources used to estimate how useful mobile coverage will be in a specific area. This HIP proposes allowing Oracles to be established to help guide deployments in areas that need more coverage. Oracles will be used to give applicable hexes boosts (increasing or decreasing) based on the area they are deployed in. Any Oracle multiplier within a single res12 hex will be multiplied by one another to get the Final Boost Multiplier. Oracle boosting shall also be multiplied with any other Mobile boosts, such as the Service Provider boosts defined in [HIP-84](0084-service-provider-hex-boosting.md). 

### Footfall Oracle  
This HIP recommends using data from a third party [site](https://shdw-drive.genesysgo.net/GANQ5D1hQVswq42Fk3vA3EYDddbNLLp1G2VmodQdprrF/index.html) which identifies areas of higher footfall traffic, to provide those areas a higher multiplier. This data is to be refreshed at least once per calendar year, but may be refreshed more frequently.

As the data above relies on a third party to aggregate and identify footfall data, the HIP authors recognize that there may be gaps or errors within the map. Therefore, a res10 hex will be used to determine that footfall data for all the res12 hexes within that one res12 hex. For example, if one res12 hex within the res10 hex has a footfall range higher than 1.00, and all other res12 hexes within that res10 hex have 0, all res12 hexes within that res10 hex will be awarded for having footfall traffic of 1.01+

The below boosts will be applied for each indoor and outdoor CBRS Radio and Wi-Fi Access Point for each res12 hex: 

### CBRS/Wifi
|Footfall    | Multiplier |
|------------|------------|
| 0 (No Data)| 1.00X      |
| 0.001-1.00 | 2.00X      |
| 1.01+      | 4.00X      |


### Land Type Oracle  
This HIP recommends using data from a third party [site](https://viewer.esa-worldcover.org/worldcover/?language=en&bbox=-255.05859374999997,-78.6991059255054,255.05859374999997,78.69910592550542&overlay=false&bgLayer=OSM&date=2023-12-25&layer=WORLDCOVER_2021_MAP) to identify the type of land, and proved multipliers based on land type. 

The below boosts will be applied for each indoor and outdoor CBRS Radio and Wi-Fi Access Point for each res12 hex: 

|Land Type                      | Multiplier |
|-------------------------------|------------|
| Built-up                      | 1.50X      |
| Tree Cover                    | 1.00X      |
| Shrubland                     | 1.00X      |
| Grassland                     | 1.00X      |
| Bare/Sparse                   | 1.00X      |
| Cropland                      | 0.10X      |
| Snow & Ice                    | 0.10X      |
| Bodies of Water               | 0.10X      |
| Wetland                       | 0.10X      |
| Mangroves                     | 0.10X      |
| Moss & Lichen                 | 0.10X      |
| Any area outside of the U.S.A | 0.00X      |


### Urbanization Oracle  
This HIP recommends using data from a third party [site](https://www.arcgis.com/apps/mapviewer/index.html?layers=10551da8fcd24062b1857473252b3df8) to identify areas in which the US Census has identified as "Urban Areas", and provide multipliers based on if they are, or are not urbanized.

The below boosts will be applied for each indoor and outdoor CBRS Radio and Wi-Fi Access Point for each res12 hex: 

| Type            | Multiplier |
|-----------------|------------|
| Urbanized       | 1.00X      |
| Non-Urbanized   | 0.25X      |

See the examples below of boosts in a single res12 hex. Note, the scenarios below assume all hexes are assigned 16 Modeled Coverage Points (MCP) per hex based off of [HIP-74](0074-mobile-poc-modeled-coverage-rewards.md). Further, any hexes that have not been boosted by a Service Provider are automatically assigned a 1.00X multiplier.

### Example 1 - Outdoor CBRS & Wi-Fi
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 1.00X         |
|Land Type Oracle Boost                                 | 1.00X         |
|Urbanization Oracle Boost                              | 1.00X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 1.00X         |
|Total MCP per Res12 Hex                                | 16            |

### Example 2 - Outdoor CBRS & Wi-Fi
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 0.75X         |
|Footfall Oracle Boost                                  | 1.00X         |
|Land Type Oracle Boost                                 | 1.50X         |
|Urbanization Oracle Boost                              | 1.00X         |
|Service Provider Boost                                 | 5.00X         |
|Final Boost Multiplier                                 | 5.625X        |
|Total MCP per res12 hex                                | 90            |


### Example 3 - Outdoor CBRS & Wi-Fi
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 0.25X         |
|Footfall Oracle Boost                                  | 0.25X         |
|Land Type Oracle Boost                                 | 1.00X         |
|Urbanization Oracle Boost                              | 0.25X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 0.016X        |
|Total MCP per Res12 Hex                                | 0.25          |


### Example 4 - Outdoor CBRS & Wi-Fi
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 4.00X         |
|Land Type Oracle Boost                                 | 0.10X         |
|Urbanization Oracle Boost                              | 1.00X         |
|Service Provider Boost                                 | 100.00X       |
|Final Boost Multiplier                                 | 400.00X       |
|Total MCP per Res12 Hex                                | 6,400         |

### Example 5 - Outdoor Wi-Fi (Temporary Boost)
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 4.00X         |
|Land Type Oracle Boost                                 | 1.00X         |
|Urbanization Oracle Boost                              | 1.00X         |
|Service Provider Boost                                 | 1.00X         |
|Wi-Fi Only Temporary Boost Proposed in HIP 101         | 2.50X         |
|Final Boost Multiplier                                 | 10.00X        |
|Total MCP per Res12 Hex                                | 160           |

### Example 6 - Indoor Wi-Fi
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Modeled Coverage Points per hex per HIP 93             | 400           |
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 4.00X         |
|Land Type Oracle Boost                                 | 1.00X         |
|Urbanization Oracle Boost                              | 1.00X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 4.00X         |
|Total MCP per Res12 Hex                                | 1,600         |

### Example 7 - Indoor CBRS (Center Hex)
|Example                                                | Multiplier    |
|-------------------------------------------------------|---------------|
|Modeled Coverage Points per hex per HIP 93             | 600           |
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 4.00X         |
|Land Type Oracle Boost                                 | 1.00X         |
|Urbanization Oracle Boost                              | 1.00X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 4.00X         |
|Total MCP per Res12 Hex                                | 2,400         |


## Deployment Impact
Nova has agreed to undertake the work to implement this HIP shall it pass. These Oracles may be implemented in any order, and do not need to be implemented all at once. Further, specific categories within each Oracle may be implemented one by one. For example, if it's easiest to implement the "Bodies of Water" Land Type within the Land Type Oracle without implementing the other categories, this may be done first, while the other categories are added to the Oracle at a later time once developed. 

## Drawbacks:
The implementation of this proposal could increase the complexity of the Helium Mobile network, and modeled coverage scores. There may be concerns about the accuracy of the population data provided, or the need to update the data regularly. 

## Alternatives
An alternative would be allowing radios and hexes to keep earning the defined amount of modeled coverage points as described in HIP 74. However, this may prevent or stagnate the network's growth because HIP 74 does not incentivize deployment of Hotspots to specific areas or regions. 

## Success Metrics
The primary success metric will be greater coverage on the modeled coverage map in areas where top carriers have already identified as areas that need data. 



