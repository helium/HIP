## MOBILE Oracle Hex Boosting
Authors: [Andy Zyvoloski](https://github.com/heatedlime) & [@zer0tweets](https://github.com/zer0tweets)

Start Date: 

Category: Technical & Economic

Original HIP PR: #

Tracking Issue: #

Voting Requirements: veMOBILE

## Prior Related HIPs

[HIP-74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage.

[HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.

[HIP-85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) introduced penalties for overlapping CBRS coverage.

[HIP-93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points. 

## Summary:
This Helium Improvement Proposal (HIP) discusses how Oracle Boosting rewards are calculated and creates a new Footfall Oracle, which incentives deployments in areas that have heavy footfall traffic. 


## Motivation:
HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighs all hexes equally, even if there's a low probability of actual coverage being needed in that area. This proposal aims to improve the value of the network coverage by incentivizing users to deploy radios in areas where Oracles have determined the highest footfall traffic occurs. 

## Stakeholders:
The stakeholders of this proposal are Service Providers, and radio/wi-fi deployers. Radio/wi-fi deployers can benefit from increased rewards for providing coverage in areas where coverage is needed, while network users can benefit as this HIP should result in more deployments in areas with more footfall traffic. 

## Detailed Explanation:
MOBILE Boosting Oracles (refer herewith as “Oracles”) are data sources which are defined in each HIP which are used to estimate how useful mobile coverage will be in a specific area. This HIP proposes allowing Oracles to be established to help guide deployments in areas that need more coverage. Oracles will be used to give applicable hexes boosts (increasing or decreasing) based on the area they are deployed in. Any Oracle multiplier within a single res12 hex will stack onto one another. Oracle boosting shall also stack with any other Mobile boosts, such as the Service Provider boosts defined in HIP 84. 

The ranking system established in HIP 85 and any future ranking systems will serve as a baseline multiplier. This means that once all boosts are aggregated, they will be multiplied against the MCP after the baseline multiplier defined in HIP 85 is applied. For example, if the MCP after HIP 85 calculations are 0, the total boosts that aggregate to 5X does not grant any additional MCP, and it will be 0, as 0 X 5 = 0. 
Examples of how this works can be found below within the Footfall Oracle section.

### Footfall Oracle  

The below boosts will be applied for each indoor and outdoor CBRS Radio and Wi-Fi Access Point for each res12 hex: 


|Range       | Multiplier |
|------------|------------|
| 0 (No Data)| 0.25X      |
| 0.001-1.00 | 1.00X      |
| 1.01+      | 3.00X      |


See the examples below of boosts in a single res12 hex. Note, the Baseline Hex Coverage Limit Multiplier is from HIP 85. The scenarios below assume all hexes are assigned 16 modeled coverage points per hex based off of HIP 74.

### Example 1
Baseline Hex Coverage Limit Multiplier: 0.75X

MCP assigned per HIP 85: (16 x 0.75=)12

Footfall Oracle Boost: 1.00X

Made Up Oracle Boost: 1.00X

Service Provider Boost: 5.00X

Aggregate Boosts: 7.00X 

Total MCP per res12 hex: 84


### Example 2
Baseline Hex Coverage Limit Multiplier: 1X

MCP assigned per HIP 85: (16x1=) 16

Footfall Oracle Boost: 1.00X

Made Up Oracle Boost: 0.00X

Service Provider Boost: 0.00X

Aggregate Boosts: 1.00X 

Total MCP per res12 hex: 16


### Example 3
Baseline Hex Coverage Limit Multiplier: 1X

MCP assigned per HIP 85: (16x1=) 16

Footfall Oracle Boost: 3.00X

Made Up Oracle Boost: 0.00X

Service Provider Boost: 100.00X

Aggregate Boosts: 103X 

Total MCP per res12 hex: 1,648 


### Example 4
Baseline Hex Coverage Limit Multiplier: 0.25X

MCP assigned per HIP 85: (16x0.25=) 4

Footfall Oracle Boost: 0.25X

Made Up Oracle Boost: 0.00X

Service Provider Boost: 0.00X

Aggregate Boosts: 0.25X 

Total MCP per res12 hex: 1


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



