# HIP 85: MOBILE Hex Coverage Limit

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 5/12/2023
- Category: Technical & Economic
- Original HIP PR: #654
- Tracking Issue: 
- Voting Requirements: veMOBILE

## Summary:
This Helium Improvement Proposal (HIP) suggests adding a hex multiplier score to the MOBILE Proof-of-Coverage (PoC) Modeled Coverage Points based on whether other coverage from Helium 5G deployments exist within that res12 hex. This HIP only applies to outdoor radios, and no changes to the reward structure of indoor mobile radios is being made with this HIP.

## Motivation:
HIP 74 was passed to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighed all coverage within each res12 hex equally, even if multiple radios were already providing coverage within that res12 hex. This means deployers could point 5 outdoor radios in the same direction, and still be awarded full Modeled Coverage points for each res12 hex. This results in the dilution of MOBILE and reduced MOBILE rewards to deployments that are strategically placed to minimize overlap in coverage. 

This proposal aims to improve the value of Mobile network coverage by incentivizing users to deploy radios that minimize overlapping coverage, and encourage deployments in new areas. 

## Stakeholders:
All Mobile Radio deployers/ Mobile Hotspot Owners. 
 
## Detailed Explanation:
Currently, any redundant and overlapping network coverage is still rewarded the same as non-overlapping coverage. This discourages the buildout of coverage to new areas. To prevent overcrowding and overlapping of coverage in hexes, this HIP proposes to limit the amount of modeled coverage points radios receive for redundant coverage in res12 hexes. 

To ensure that only the best setups are rewarded, only the top two (2) ranked radio signals in each res12 hex will be awarded modeled coverage points, with a decaying multiplier based on the radio rank noted below. Any radios not ranked within the top two (2) will be ranked as “Fail”, and receive no modeled coverage points for that res12 hex. 

| Rank         |Multiplier|  
|--------------|----------|
|      1       |   1X     |
|      2       |  .75X    |
|    Fail      |   0X     |

Please note, that the multiplier table above only affects the modeled coverage points that are given to each outdoor radio, and does not affect rewards distributed for the transfer of data. 

### Radio Ranking & Criteria

All outdoor radios that provide coverage to any res12 hex will be given a rank for each res12 hex they provide coverage in based on the following potential attributes (note, this rank is only for a single res12 hex and not the entire radio):

- Modeled Signal Strength 

- Heartbeat Steak - The Heartbeat Streak is the length of time that has elapsed since the first heartbeat of that radio at its current location, that has had at least 1 heartbeat every 72 hours. If a radio does not produce at least one (1) heartbeat over 72 consecutive hours, the streak is reset. This attribute is only used as a tiebreaker in instances where two or more radios tie for Modeled Signal Strength. If somehow, two or more radios tie both Modeled Signal Strength and Heartbeat Streak, the radio to be ranked will be randomly selected every epoch.

### Modeling Radio Ranking

See the example below of how ranking based on a hex multiplier would affect a deployment of five (5) outdoor radios if they are providing modeled coverage to the same res12 hex:

| Radio |Signal Strength| Heartbeat Streak Start Date | Rank  | Coverage Points Per HIP 74| New Coverage Points|  
|-------|---------------|-----------------------------|-------|---------------------------|--------------------|
|   A   |   -77.33 dBm  |05/01/2023 23:24:25          | 1     | 16 (16 * 1)               | 16  (16 * 1)       |
|   B   |   -88.75 dBm  |12/01/2022 01:01:01          | 2     | 16 (16 * 1)               | 12  (16 * .75)     |
|   C   |   -88.75 dBm  |12/02/2022 12:11:01          | Fail  | 16 (16 * 1)               | 0   (16 * 0)       |
|   D   |   -93.60 dBm  |12/05/2022 11:51:01          | Fail  | 16 (16 * 1)               | 0   (16 * 0)       |
|   E   |   -94.69 dBm  |08/01/2022 05:01:59          | Fail  | 16 (16 * 1)               | 0   (16 * 0)       |

**Table Key:**
- **Radio:** Example radio name.
- **Signal Strength:** The Signal Strength of the res12 hex from the modeled coverage explorer.
- **Heartbeat:** The date/time that the Heartbeat Streak started.
- **Rank:** The assigned rank based on which radio has the strongest Signal Strength (or Heartbeat Streak if tied for Signal Strength).
- **Coverage Points Per HIP 74:** The amount of modeled coverage points currently awarded under HIP 74.
- **New Coverage Points:** The amount of modeled coverage points that would be awarded under this HIP.

**Table Explanation:**

Since Radio A has the highest signal strength in that hex, it will be ranked as "1", and granted a 1X multiplier, which will award it with the full 16 (16 x 1) modeled coverage points for that epoch.

Since radios B and C tied in Signal Strength, the Heartbeat Streak date is used to determine which radio is ranked next. For this example, radio B had its Heartbeat Streak start on 12/01/2022 01:01:01 while radio C had a its HeartBeat streak start on 12/02/2022 12:11:01. Therefore, since radio B has an earlier Heartbeat Streak, it will be ranked "2", while radio C having a rank of "Fail".

Since radio C, D and E had the lowest signal strength out of all five (5) radios, and only the top two (2) radios will earn PoC rewards, radios C, D and E will not earn any modeled coverage points, and are ranked as "Fail".

As noted in the example above, outdoor radio deployers will now need to be cognizant of where they are placing their radios in order to maximize modeled coverage point. 

## Drawbacks:
The implementation of this proposal could increase the complexity of modeled coverage scores due to adding additional variables used to calculate total MOBILE rewards.

Additionally, radio deployers may lose out on awarded coverage points in instances where multiple radios are set up in the same hex.

## Rationale and Alternatives:
An alternative would be to allow radios and hexes to keep earning the defined amount of modeled coverage points as described in HIP 74. This may prevent or stagnate the growth of the network because this method does encourage the strategic placement of radios to minimize overlapping coverage. 

## Unresolved Question:
1. Should MOBILE Mapping Signal Strength be used in combination with Modeled Signal Strength?

## Deployment Impact:
HIP 85 affects only Outdoor radios, and coverage from indoor radios will continue to earn Modeled Coverage Points based on HIP 74. New fields will need to be added into the Modeled Coverage Explorer to make visible Radio Hex Ranks, as well as Heartbeat Streaks.

Further, a large amount of overlapping coverage exists within the MOBILE network. Deployers may have to find new locations for some or all of their radios in order for them to continue to earn modeled coverage points. 

## Success Metrics: 
This HIP is successful if:
1. There is more broad coverage extended to new locations on the modeled coverage map 
2. and less redundant coverage in areas of saturation
