# HIP 103: MOBILE Oracle Hex Boosting

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) & [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2023-12-18
- Category: Economic, Technical
- Original HIP PR: [#822](https://github.com/helium/HIP/pull/822)
- Tracking Issue: [#836](https://github.com/helium/HIP/issues/836)
- Vote Requirements: veMOBILE Holders

## Summary:
This Helium Improvement Proposal (HIP) discusses how Oracle Boosting rewards are calculated and creates a new Footfall Oracle, which incentives deployments in areas that have heavy footfall traffic. 

## Prior Related HIPs

* [HIP-74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage.
* [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.
* [HIP-85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) introduced penalties for overlapping CBRS coverage.
* [HIP-93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points. 

## Motivation:
HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighs all hexes equally, even if there's a low probability of actual coverage being needed in that area. This proposal aims to improve the value of the network coverage by incentivizing users to deploy radios in areas where Oracles have determined the highest footfall traffic occurs. 

## Stakeholders:
The stakeholders of this proposal are Service Providers, and radio/wi-fi deployers. Radio/wi-fi deployers can benefit from increased rewards for providing coverage in areas where coverage is needed, while network users can benefit as this HIP should result in more deployments in areas with more footfall traffic. 

## Detailed Explanation:
MOBILE Boosting Oracles (refer herewith as “Oracles”) are data sources which are defined in each HIP which are used to estimate how useful mobile coverage will be in a specific area. This HIP proposes allowing Oracles to be established to help guide deployments in areas that need more coverage. Oracles will be used to give applicable hexes boosts (increasing or decreasing) based on the area they are deployed in. Any Oracle multiplier within a single res12 hex will be multiply by one another to get the Final Boost Multiplier. Oracle boosting shall also be multiplied with any other Mobile boosts, such as the Service Provider boosts defined in [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md). 

The maximum boost that can be applied is 100X. In any instances where the Final Boost Multiplier is over 100X, only 100X will be awarded.

### Footfall Oracle  

The below boosts will be applied for each indoor and outdoor CBRS Radio and Wi-Fi Access Point for each res12 hex: 


### Indoor CBRS/Wifi
|Range       | Multiplier |
|------------|------------|
| 0 (No Data)| 0.25X      |
| 0.001-1.00 | 3.00X      |
| 1.01+      | 6.00X      |

### Outdoor CBRS/Wifi
|Range       | Multiplier |
|------------|------------|
| 0 (No Data)| 0.25X      |
| 0.001-1.00 | 1.00X      |
| 1.01+      | 2.00X      |



See the examples below of boosts in a single res12 hex. Note, the scenarios below assume all hexes are assigned 16 Modeled Coverage Points (MCP) per hex based off of [HIP-74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md). Further, any hexes that have not been boosted by a Service Provider are automatically assigned a 1.00X multiplier.

### Example 1
|Example                                                |               |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 1.00X         |
|Urbanization Oracle Boost (not real, just an example)  | 1.00X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 1.00X         |
|Total MCP per Res12 Hex                                | 16            |

### Example 2
|Example                                                |               |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 0.75X         |
|Footfall Oracle Boost                                  | 1.00X         |
|Urbanization Oracle Boost (not real, just an example)  | 1.00X         |
|Service Provider Boost                                 | 5.00X         |
|Final Boost Multiplier                                 | 3.75X         |
|Total MCP per res12 hex                                | 60            |


### Example 3
|Example                                                |               |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 0.25X         |
|Footfall Oracle Boost                                  | 0.25X         |
|Urbanization Oracle Boost (not real, just an example)  | 0.25X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 0.016X        |
|Total MCP per Res12 Hex                                | 0.25          |


### Example 4
|Example                                                |               |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 2.00X         |
|Urbanization Oracle Boost (not real, just an example)  | 1.00X         |
|Service Provider Boost                                 | 1.00X         |
|Final Boost Multiplier                                 | 2.00X         |
|Total MCP per Res12 Hex                                | 32            |


### Example 5
|Example                                                |               |
|-------------------------------------------------------|---------------|
|Hex Coverage Limit Multiplier from HIP 85/105          | 1.00X         |
|Footfall Oracle Boost                                  | 6.00X         |
|Urbanization Oracle Boost (not real, just an example)  | 1.00X         |
|Service Provider Boost                                 | 100.00X       |
|Final Boost Multiplier                                 | 100.00X       |
|Total MCP per Res12 Hex                                | 1,600         |



## Deployment Impact
Nova has agreed to undertake the work to implement this HIP shall it pass. 

## Drawbacks:
The implementation of this proposal could increase the complexity of the Helium Mobile network, and modeled coverage scores. There may be concerns about the accuracy of the population data provided, or the need to update the data regularly. 


## Alternatives
An alternative would be allowing radios and hexes to keep earning the defined amount of modeled coverage points as described in HIP 74. However, this may prevent or stagnate the network's growth because HIP 74 does not incentivize deployment of Hotspots to specific areas or regions. 


## Deployment Impact
Radio deployers will now need to be cognizant of where they are placing their radios in order to maximize modeled coverage point.

## Success Metrics
The primary success metric will be greater coverage on the modeled coverage map in areas where top carriers have already identified as areas that need data. 



