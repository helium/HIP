# HIP 105: Modification of MOBILE subDAO Hex Limits

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Contributors Hans, JD, & [@italiandude](https://github.com/mario-novalabs)
- Start Date: 12/7/2023
- Category: Technical & Economic
- Original HIP PR: [#821](https://github.com/pull/821)
- Tracking Issue: [#840](https://github.com/issues/840)
- Voting Requirements: veMOBILE Holders

## Summary:
This Helium Improvement Proposal (HIP) suggests modifying how Modeled Coverage Points (MCP) are calculated for Wi-Fi Access Points (APs) and CBRS Radios that provide overlapping coverage.

## Related Previous HIPs

* [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage for the MOBILE subDAO.
* [HIP 85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) implemented CBRS Hex limits.
* [HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced the addition of Wi-Fi access points and certain limitations.

## Motivation:
[HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi APs as a new way to stay connected to the Helium MOBILE network; however, the HIP did not cover all gaming concerns, and introduced new vectors for farming MOBILE. This HIP proposes limiting the amount of Modeled Coverage Points issued for redundant coverage between Wi-Fi and CBRS. 


## Stakeholders:
Deployers - This HIP will make it more fair for deployers who are able to deploy a more optimal Wi-Fi AP setup than current existing setups. 

Subscribers - Subscribers may see more coverage of Wi-Fi access as this HIP will encourage Wi-Fi deployments to not be bunched together. 

Service Providers - If better Wi-Fi coverage is added due to this HIP, Service Providers will see an increased amount of data being offloaded onto the Helium 5G network.

## Detailed Explanation:
### Outdoor Wi-Fi APs
Currently, any redundant and overlapping Outdoor Wi-Fi coverage is still rewarded the same as non-overlapping coverage under HIP 93. This discourages the buildout of coverage to new areas. To prevent overcrowding and overlapping of coverage in hexes, this HIP proposes to limit the amount of Modeled Coverage Points (MCP) Outdoor Wi-Fi APs receive for redundant coverage in res12 hexes. 

To ensure that only the best setups are rewarded, only the top three (3) ranked signals of Outdoor Wi-Fi APs in each res12 hex will be awarded MCP, with a decaying multiplier based on the AP rank noted below. Any AP not ranked within the top three (3) will be ranked as “Fail”, and receive no MCP for that res12 hex. 

| Rank         |Multiplier   |  
|--------------|-------------|
|      1       |   1X        |
|      2       |  .75X       |
|      3       |  .25X       |
|    Fail      |   0X        |

Please note that the multiplier table above only affects the MCP that are given to each Outdoor Wi-Fi AP and does not affect rewards distributed for the transfer of data or PoC rewards for indoor Wi-Fi APs. 

#### Wi-Fi AP Ranking & Criteria

All Outdoor Wi-Fi APs that provide coverage to any res12 hex will be given a rank for each res12 hex they provide coverage in based on the following potential attributes (note, this rank is only for a single res12 hex and not the entire radio):

- Modeled Signal Strength 
- Coverage Claim Time (Only used as a tiebreaker for Modeled Single Strength)

If there are more than 1 Outdoor Wi-Fi AP with the same signal strength level, the `coverage_claim_time` value will be used to rank the top 3 oldest installations where `coverage_claim_time` is the timestamp when the Wi-Fi AP was asserted in that hex. The oldest Wi-Fi AP will receive the higher rank, while the newest will receive the lowest rank. To prevent rewarding "dead" Wi-Fi APs, we propose to reset `coverage_claim_time` if the Wi-Fi AP was not generating a Heartbeat for more than 72 hours and use the time of the last Heartbeat as the new `coverage_claim_time`.


#### Modeling Wi-Fi AP Ranking

See the example below of how ranking based on a hex multiplier would affect deployment of five (5) Outdoor Wi-Fi APs if they are providing modeled coverage to the same res12 hex:

| Wi-Fi AP | Signal Strength | Coverage Claim Start Date | Rank | MCP per HIP 93 | New MCP |
|----------|-----------------|---------------------------|------|----------------|---------|
| A        | -63.33 dBm      | 01/01/2024 01:01:01       | 1    | 16             | 16      |
| B        | -66.75 dBm      | 01/01/2024 01:01:01       | 2    | 8              |  6      |
| C        | -66.75 dBm      | 02/12/2024 18:06:05       | 3    | 8              |  2      |
| D        | -75.60 dBm      | 01/02/2024 01:01:01       | Fail | 4              |  0      |
| E        | -88.55 dBm      | 01/01/2024 01:01:01       | Fail | 0              |  0      |

**Table Key:**
- **Wi-Fi AP:** Example Wi-Fi AP name.
- **Signal Strength:** The Signal Strength of the res12 hex from the modeled coverage explorer.
- **Coverage Claim:** The date/time that the Coverage Claim period started.
- **Rank:** The assigned rank based on which Wi-Fi AP has the strongest Signal Strength (or Coverage Claim if tied for Signal Strength).
- **Coverage Points Per HIP 93:** The amount of MCP currently awarded under HIP 93.
- **New Coverage Points:** The amount of MCP that would be awarded under this HIP.

**Table Explanation:**

Since Wi-Fi AP A has the highest signal strength in that hex, it will be ranked as "1", and granted a 1X multiplier to the modeled coverage score of 16, which will award it with the full 16 (16 x 1) MCP for that epoch.

Since Wi-Fi AP B and C tied in Signal Strength, the Coverage Claim date is used to determine which radio is ranked next. For this example, radio B had its Coverage Claim date start on 01/01/2024 01:01:01 while radio C had its Coverage Claim date start on 02/12/2024 18:06:05. Therefore, since Wi-Fi AP B has an earlier Coverage Claim date, it will be ranked "2", while Wi-Fi AP C has a rank of "3".

Since Wi-Fi AP D and E had the lowest signal strength out of all five (5) Wi-Fi AP, and only the top three (3) Wi-Fi AP will earn PoC rewards, Wi-Fi AP D and E will not earn any MCP for this res12 hex, and are ranked as "Fail".


### Indoor CBRS Limits
This HIP also proposes implementing a similar limit established in [HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) to CBRS Radios, whereas this HIP limits the amount of indoor CBRS radios per res12 hex to 1. Further, Coverage Claim Time will be used to determine which indoor CBRS radio will be rewarded PoC. 

### CBRS Gateway Limitations
This HIP also proposes limiting the amount of outdoor CBRS radios that can be plugged into a single 5G Gateway to three (3). Any outdoor radios connected beyond the 3 limit will not earn PoC rewards.

## Drawbacks:
Implementing this proposal will increase the complexity of modeled coverage scores due to adding additional variables used to calculate total MOBILE rewards.

Additionally, Wi-Fi AP deployers may lose out on awarded coverage points in instances where multiple Wi-Fi APs  are set up in the same hex.

## Rationale and Alternatives:
An alternative would be allowing Wi-Fi APs to keep earning the defined amount of MCP as described in HIP 93. 

However, this may prevent or stagnate the network's growth because HIP 93 does not incentivize deployment of Wi-Fi AP to minimize overlapping coverage. 

## Deployment Impact:
As [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) has already been deployed by Nova Labs, Nova Labs is able to change the chain variables to implement this HIP.

## Success Metrics: 
This HIP is successful if: General consensus is that the coverage ratio between CBRS and WiFi AP is “fair” and that multilayered coverage is achieved in an efficient manner.


