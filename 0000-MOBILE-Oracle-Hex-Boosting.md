Author: [Andy Zyvoloski](https://github.com/heatedlime)

Start Date: 6/6/2023

Category: Technical & Economic

Original HIP PR: #

Tracking Issue: #

Voting Requirements: veMOBILE


## Summary:
This Helium Improvement Proposal (HIP) proposes creating MOBILE Boosting Oracles to add multipliers to the MOBILE Proof of Coverage (PoC) modeled coverage points (MCP), by using external data sources (aka Oracles) for the purpose of identifying areas in which coverage is more likely to be used by Service Providers.

Further, this HIP proposes adding the first Oracle, the Carrier Coverage Oracle, which incentives deployments in areas in which T-Mobile has pre-existing coverage. 
 

## Motivation:
HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighs all hexes equally, even if there's a low probability of actual coverage being needed in that area. This proposal aims to improve the value of the network coverage by incentivizing users to deploy radios in areas where Oracles have determined Service Providers are more likely to need coverage.
 
## Stakeholders:
The stakeholders of this proposal are Service Providers, radio deployers, and network users. Radio deployers can benefit from increased rewards for providing coverage in areas where coverage is needed. 
 
## Detailed Explanation:
MOBILE Boosting Oracles (refer herewith as “Oracles”) are data sources which are used to estimate how useful mobile coverage will be in a specific area. This HIP proposes allowing Oracles to be established to help guide deployments in areas that need more coverage. Oracles will be used to give applicable hexes boosts (increasing or decreasing) based on the area they are deployed in. Any Oracle multiplier within a single res12 hex will stack onto one another. Oracle boosting shall also stack with any other Mobile boosts, such as the Service Provider boosts defined in HIP 84 (assuming HIP 84 passes). 

The ranking system established in HIP 85 (assuming HIP 85 passes) will serve as a baseline multiplier. This means that once all boosts are aggregated, they will be multiplied against the MCP after the baseline multiplier defined in HIP 85 is applied. For example, if the MCP after HIP 85 calculations are 0, the total boosts that aggregate to 5X does not grant any additional MCP, and it will be 0, as 0 X 5 = 0. 
Examples of how this works can be found below within the Carrier Coverage Oracle section.

The data sources from Oracles are to be updated no less than once per year. The Oracle updates are to be reviewed by a MOBILE Governance Group (or MOBILE Working Group if no Governance Group exists) prior to implementation to ensure and confirm the Oracle data was updated correctly. 

### Changes to Oracle Boosts
As the MOBILE network matures, Oracle boosts may need to be fine tuned or changed. Therefore, the boosts and data type for each boost shall be implemented as chain variables. In order for these chain variables to be modified, or deleted, a MOBILE Governance Group (or MOBILE Working Group if no Governance Group exists) must create an Oracle Change Proposal. The proposal will then be presented and discussed by the Group, in which a general consensus must be reached (consensus defined by the Group). Once consensus is reached, the proposal will be put to a vote by the community, with the voting requirement being veMOBILE.

The proposal must be announced within the Official Helium Community Discord Server under the “Governance-Announcement” channel (or similar channel if the “Governance-Announcement” channel is removed), at least five (5) calendar days prior to the start of voting. Voting shall remain open for seven (7) calendar days. A 66.67% vote in favor of the change(s) must be reached in order for the vote to pass.

A new vote with the same or modified change(s) to that Oracle may be put to vote by the community again with Group consensus no earlier than 60 calendar days after the last voting has ended.


### Carrier Coverage Oracle  
Coverage areas that are already covered by the top mobile carriers, such as T-Mobile, have already been identified as areas in which there’s a documented supply and demand for data. Therefore, this HIP proposes creating the first MOBILE Boosting Oracle, the Carrier Coverage Oracle that utilizes the existing T-Mobile coverage map (https://www.t-mobile.com/coverage/coverage-map) to add a boost to PoC Modeled Coverage Points defined in HIP 74 based on the type of coverage T-Mobile offers in that res12 hex. This HIP covers both indoor and outdoor CBRS radios. 

From reviewing the T-Mobile coverage map below of Minneapolis Minnesota and its surrounding suburbs, as well as other large cities within the US, it can be noted that T-Mobile coverage primarily consists of 5G Ultra Capacity and 5G Extended Range in populated cities. These are areas in which T-Mobile have deployed capital and infrastructure to increase and enhance coverage. Thus, one can assume data use in these areas are higher than data use in 4G LTE, 3G/2G areas. 

![](https://github.com/helium/HIP/commit/9e95944bc0e8c31cd332120888782a25127afe4b#commitcomment-116813063)


The below boosts will be awarded to modeled coverage points for each radio and each res12 hex: 

| T-Mobile Coverage Type | Boost | 
|------------------------|-------|
|5G Ultra Capacity       | 1.25X |
|5G Extended Range       | 1X    |
|4G LTE                  | .5X   |
|3G/2G/Partner           | .25X  |
|No Coverage             | .1X   |


See the examples below of boosts in a single res12 hex. Note, the Baseline Hex Coverage Limit Multiplier is from HIP 85, assuming HIP 85 passes) 

Carrier Coverage Oracle Boost: 1.25X
Made Up Oracle Boost: 3X
Service Provider Boost: 5X
Aggregate Boosts: 9.25X 
Potential Signal Level: High
MCP assigned per HIP 74: 16
Baseline Hex Coverage Limit Multiplier: 0X
MCP assigned per HIP 85: 0
Total MCP per res12 hex: 0 

Carrier Coverage Oracle Boost: 1.25X
Made Up Oracle Boost: 3X
Service Provider Boost: 5X
Aggregate Boosts: 9.25X 
Potential Signal Level: High
MCP assigned per HIP 74: 16
Baseline Hex Coverage Limit Multiplier: 1X
MCP assigned per HIP 85: 16
Total MCP per res12 hex: 148

Carrier Coverage Oracle Boost: 1.25X
Made Up Oracle Boost: 3X
Service Provider Boost: None
Aggregate Boosts: 4.5X 
Potential Signal Level: High
MCP assigned per HIP 74: 16
Baseline Hex Coverage Limit Multiplier: .75X
MCP assigned per HIP 85: 12
Total MCP per res12 hex: 54 

Carrier Coverage Oracle Boost: 1X
Made Up Oracle Boost: 1X
Service Provider Boost: None
Aggregate Boosts: 2X 
Potential Signal Level: High
MCP assigned per HIP 74: 16
Baseline Hex Coverage Limit Multiplier: 1X
MCP assigned per HIP 85: 16
Total MCP per res12 hex: 32 

Carrier Coverage Oracle Boost: .25X
Made Up Oracle Boost: .5X
Service Provider Boost: None
Aggregate Boosts: .75X 
Potential Signal Level: High
MCP assigned per HIP 74: 16
Baseline Hex Coverage Limit Multiplier .25X
MCP assigned per HIP 85: 4
Total MCP per res12 hex: 3

Drawbacks:
The implementation of this proposal could increase the complexity of the Helium Mobile network, and modeled coverage scores. There may be concerns about the accuracy of the population data provided, or the need to update the data regularly. 

Further, there may be areas in which T-Mobile does not provide coverage although there is a need for coverage. However, in these cases, Service Provider Boosts will be able to adjust the boosts as needed.

Alternatives
An alternative would be allowing radios and hexes to keep earning the defined amount of modeled coverage points as described in HIP 74. However, this may prevent or stagnate the network's growth because HIP 74 does not incentivize deployment of Hotspots to specific areas or regions. 

Unresolved Question
1. Can bodies of water be extracted from the T-Mobile Map and provide a .1X multiplier for coverage over water?
2. Are the current boosts prescribed in this HIP adequate? 

Deployment Impact
Radio deployers will now need to be cognizant of where they are placing their radios in order to maximize modeled coverage point.

Success Metrics
The primary success metric will be greater coverage on the modeled coverage map in areas where top carriers have already identified as areas that need data. 
