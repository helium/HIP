# HIP XX: MOBILE Hex Coverage Limit

- Author: @HeatedLime
- Start Date: 5/12/2023
- Category: Technical & Economic
- Original HIP PR: #652
- Tracking Issue: 
- Voting Requirements: veMOBILE

## Summary:
This Helium Improvement Proposal (HIP) suggests adding a hex multiplier score to the MOBILE Proof-of-Coverage (PoC) Modeled Coverage points based on whether other coverage from Helium 5G deployments exist within that res12 hex. 

## Motivation:
HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighed all coverage within each res12 hex equally, even if multiple radios were already providing coverage within that res12 hex. This means deployers could point 5 outdoor radios in the same direction, and still be awarded full Modeled Coverage points for each res12 hex. 

This proposal aims to improve the value of Mobile network coverage by incentivizing users to deploy radios that minimize overlapping coverage, and encourage deployments in new areas. 

## Stakeholders:
All Mobile Radio deployers/ Mobile Hotspot Owners. 
 
## Detailed Explanation:
Currently, any redundant and overlapping network coverage is still rewarded the same as non-overlapping coverage. This discourages the buildout of coverage to new areas. To prevent overcrowding and overlapping of coverage in hexes, this HIP proposes to limit the amount of modeled coverage points radios for redundant coverage in res12 hexes. 

To ensure that only the best setups are rewarded, only the top four (4) radio signals in each res12 hex will be awarded modeled coverage points, with a decaying multiplier based on the radio score noted below. Any radios not scored within the top four (4) will be graded as “Fail”, and receive no modeled coverage points for that res12 hex. 


| Score/Grade  |Multiplier|  
|--------------|----------|
|      1       |   1X     |
|      2       |  .75X    |
|      3       |  .5X     |
|      4       |  .25X    |
|    Fail      |   0X     |


All outdoor radios that provide coverage to any res12 hex will be given a score for each res12 hex they provide coverage in based on the following potential attributes (note, this score is only for a single res12 hex and not the entire radio):

•Mapped Signal Strenght (Once mapping is impelemented)*
•Modeled Signal Strength 
•Date of CPI approval (only used as a tiebreaker if tie for attribute 1)

*Until Mapping is impelemented, the only attributes used will be Modeled Signal Strenght and date of CPI approval. See the end of this section for how Mapping is to be implemented for this HIP.

Scoring attribute 2 (CPI approval date) will only be used when there is a tie for two or more radios for the proceeding attribute. 

Please note, that the multiplier table above only affects the modeled coverage points that are given to each radio, and does not affect rewards distributed for the transfer of data. 

To see the example below of how this HIP would affect a deployment of five (5) radios that provide modeled coverage to the same res12 hex, see the below example:


| Radio |Signal Strenght| CPI Approval Date | Score | Coverage Points Per HIP 74| New Coverage Points|  
|-------|---------------|-------------------|-------|---------------------------|--------------------|
|   A   |   -77.33 dBm  |05/01/2023 23:24:25| 1     | 16 (16 * 1)               | 16 (16 * 1)        |
|   B   |   -88.75 dBm  |12/01/2022 01:01:01| 2     | 16 (16 * 1)               | 12 (16 * .75)      |
|   C   |   -88.75 dBm  |12/02/2022 12:11:01| 3     | 16 (16 * 1)               | 8 (16 * .5)        |
|   D   |   -93.60 dBm  |12/05/2022 11:51:01| 4     | 16 (16 * 1)               | 4 (16 * .25)       |
|   E   |   -94.69 dBm  |08/01/2022 05:01:59| Fail  | 16 (16 * 1)               | 0 (16 * 0)         |



Since Radio A has the highest signal strength in that hex, it will be granted a 1X multiplier, which will award it with the full 16 (16 x 1) modeled coverage points for that epoch. 

However, since radios, B, C, D and E have a lower signal strength than radio A, and are providing redundant coverage, they will not earn the full modeled coverage points. Instead, they will only earn a fraction of that amount depending on their score. 

Since radios B and C tied in Signal Strength, the CPI approval date is used to determine which radio is scored next. For this example, radio B was CPI approved on 12/01/2022 01:01:01 and radio C was CPI approved on 12/02/2022 12:11:01. Therefore, radio B was CPI approved first, and will thus have a score of 2, while radio C having a score of 3. 

Since radio E had the lowest signal strength out of all five (5) radios, and only the top four (4) radios will earn rewards, radio E will not earn any modeled coverage points.

**Modeled Mapping**
Once the mapping of the network and mapping of signal strenghts is released, there will be a more accurate method to track and document the hexes with the highest signal strenght. The following attributes will be used to determine the score: 

•Mapped Signal Strenght 
•Modeled Signal Strength (only used as a tiebreaker if tie for attribute 2)
•Date of CPI approval (only used as a tiebreaker if tie for attribute 2)

As noted in HIP 79, the Mobile PoC Working Group has discussed and documented a potential path to adjust MOBILE Hotspot rewards using the data collected by Mappers that would utilize the concept of the confidence score. The Mobile PoC Working Group has decided to postpone the final decision regarding the specific algorithm to the second stage of Mapper reward implementation. This approach would create Hotspot rewards adjustment algorithms based on the actual data from mapping activity vs. speculating regarding variables and weights. Therefore, this HIP will not define the exact metrics of how mapped signal strength is rewarded, and how it factors into the radio score, and will allow that HIP to define how it works.

## Drawbacks:
The implementation of this proposal could increase the complexity of the Mobile network, and modeled coverage scores. 

Further, radio deployers may lose out on awarded coverage points in instances where multiple radios are set up in the same hex.


## Rationale and Alternatives:
An alternative would be to allow radios and hexes to keep earning the defined amount of modeled coverage points as described in HIP 74, which may prevent or stagnate the growth of the network because this method does encourage the strategic placement of radios to minimize overlapping coverage. 

## Unresolved Question:
None

## Deployment Impact:
Outdoor radio deployers will now need to be cognizant of where they are placing their radios in order to maximize modeled coverage point. Additionally, there’s a large amount of overlapping coverage. Deployers may have to find new locations for some or all of their radios in order for them to continue to earn modeled coverage points. 

## Success Metrics:
The primary success metric will be greater coverage on the modeled coverage map and less redundant coverage. 
