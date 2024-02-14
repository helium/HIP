# HIP 105: Modification of MOBILE subDAO Hex Limits

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Contributors: Hans & JD
- Start Date: 12/7/2023
- Category: Technical & Economic
- Original HIP PR: [#821](https://github.com/helium/HIP/pull/821)
- Tracking Issue: [#840](https://github.com/helium/HIP/issues/840)
- Voting Requirements: veMOBILE Holders

## Summary:

This Helium Improvement Proposal (HIP) is an amendment of [HIP 85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) to create separate Hex Limits for both Outdoor Wi-Fi and Outdoor CBRS. Each signal (Wi-Fi or CBRS) will have its own limits, meaning adding a CBRS signal to a res12 hex with pre-established Wi-Fi coverage will not negatively impact rewards.

The information within this HIP will supersede HIP 85 upon passing, thus creating one centralized HIP that documents Hex Limits for both Wi-Fi and CBRS deployments.

## Related Previous HIPs

- [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage for the MOBILE subDAO.
- [HIP 85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) implemented CBRS Hex limits.
- [HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced the addition of Wi-Fi access points and certain limitations.

## Motivation:

The intentions of [HIP 85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) was to limit Modeled Coverage Points (MCP) to the top 3 radio signals from CBRS radios; however, since HIP 85 only states "radio signals", and does not specify wether those signals come from CBRS or Wi-Fi, the HIP was implemented to only count the top 3 radio signals, regardless of source (CBRS or Wi-Fi) within each res12 hex. This HIP proposes to fix that, and allow up to three (3) CBRS radio signals and (3) Wi-Fi signals to earn MCP in each res12 hex.

## Stakeholders:

Deployers - This HIP will make it more fair for deployers who are able to deploy a more optimal Wi-Fi AP and CBRS setup than current existing setups.

Subscribers - Subscribers may see more coverage of Wi-Fi access as this HIP will encourage Wi-Fi deployments to not be bunched together.

Service Providers - If better Wi-Fi coverage is added due to this HIP, Service Providers will see an increased amount of data being offloaded onto the Helium 5G network.

## Hex Limits

Please note, the passing of this HIP will supersede the 5 radio limit proposed in [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) and the 2 Wi-Fi limit in [HIP 101](https://github.com/helium/HIP/blob/main/0101-equalizing-poc-rewards-across-wifi-and-cbrs.md) (assuming HIP 101 passes).

### Indoor Wi-Fi

[HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) established a limit of one (1) indoor Wi-Fi AP per res12 hex will be eligible for PoC rewards. This will remain the limit for Indoor Wi-Fi APs.

### Outdoor Wi-Fi

To ensure that only the best outdoor Wi-Fi setups are rewarded, only the top three (3) ranked signals of Outdoor Wi-Fi APs in each res12 hex will be awarded MCP, with a decaying multiplier based on the AP rank noted below. Any AP not ranked within the top three (3) will be ranked as “Fail”, and receive no MCP for that res12 hex. Please note, these ranks below are only assigned to Wi-Fi APs signals. Therefore, adding one (1) CBRS radio to this equation will not result in less rewards for Wi-Fi.

| Wi-F Rank | Multiplier |
| --------- | ---------- |
| 1         | 1.00X      |
| 2         | 0.50X      |
| 3         | 0.25X      |
| Fail      | 0.00X      |

Please note that the multiplier table above only affects the MCP that are given to each Outdoor Wi-Fi AP and does not affect rewards distributed for the transfer of data.

### Indoor CBRS Limits

This HIP proposes implementing a similar res12 hex limit established in [HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) to CBRS Radios, whereas this HIP limits the amount of indoor CBRS radios per res12 hex to 1. Further, Coverage Claim Time (noted in the "Ranking & Criteria" below) will be used to determine which indoor CBRS radio will be rewarded PoC.

### Outdoor CBRS Limits

To ensure that only the best outdoor CBRS setups are rewarded, only the top three (3) ranked signals of Outdoor CBRS in each res12 hex will be awarded MCP, with a decaying multiplier based on the AP rank noted below. Any AP not ranked within the top three (3) will be ranked as “Fail”, and receive no MCP for that res12 hex. Please note, these ranks below are only assigned to CBRS radio signals. Therefore, adding one (1) Wi-Fi AP to this equation will not result in less rewards for Wi-Fi.

| CBRS Rank | Multiplier |
| --------- | ---------- |
| 1         | 1.00X      |
| 2         | 0.50X      |
| 3         | 0.25X      |
| Fail      | 0.00X      |

Please note that the multiplier table above only affects the MCP that are given to each Outdoor Wi-Fi AP and does not affect rewards distributed for the transfer of data.

#### Ranking & Criteria

All Outdoor Wi-Fi APs and Outdoor CBRS radios that provide coverage to a single res12 hex will be given a Wi-Fi Rank and or CBRS Rank for each res12 hex they provide coverage in based on the following potential attributes (note, this rank is only for a single res12 hex and not the entire AP or radio):

- Modeled Signal Strength
- Coverage Claim Time (Only used as a tiebreaker for Modeled Single Strength)

If there are more than 1 Outdoor Wi-Fi AP with the same signal strength level, the `coverage_claim_time` value will be used to rank the top 3 oldest installations where `coverage_claim_time` is the timestamp when the Wi-Fi AP was asserted in that hex. The oldest Wi-Fi AP will receive the higher rank, while the newest will receive the lowest rank. To prevent rewarding "dead" Wi-Fi APs, we propose to reset `coverage_claim_time` if the Wi-Fi AP was not generating a Heartbeat for more than 72 hours and use the time of the last Heartbeat as the new `coverage_claim_time`.

Note: As the Wi-Fi Rank and CBRS Rank are independent, adding CBRS coverage within a res12 hex that already has coverage from Wi-Fi will not impact earnings of the Wi-Fi signals.

#### Modeling Wi-Fi AP Ranking

See the example below of how ranking based on a hex multiplier would affect deployment of five (5) Outdoor Wi-Fi APs and five (5) Outdoor CBRS radios if they are providing modeled coverage to the same res12 hex:

| Wi-Fi | Signal Strength | Coverage Claim Start Date | Wi-Fi Rank | MCP per HIP 93 | New MCP |
| ----- | --------------- | ------------------------- | ---------- | -------------- | ------- |
| A     | -63.33 dBm      | 01/01/2024 01:01:01       | 1          | 16             | 16      |
| B     | -66.75 dBm      | 01/01/2024 01:01:01       | 2          | 8              | 4       |
| C     | -66.75 dBm      | 02/12/2024 18:06:05       | 3          | 8              | 2       |
| D     | -75.60 dBm      | 01/02/2024 01:01:01       | Fail       | 4              | 0       |

| Radio | Signal Strength | Coverage Claim Start Date | CBRS Rank | MCP Per HIP 74 | New MCP |
| ----- | --------------- | ------------------------- | --------- | -------------- | ------- |
| A     | -77.33 dBm      | 05/01/2023 23:24:25       | 1         | 16             | 16      |
| B     | -98.75 dBm      | 12/01/2022 01:01:01       | 2         | 8              | 4       |
| C     | -98.75 dBm      | 12/02/2022 12:11:01       | 3         | 8              | 2       |
| D     | -105.60 dBm     | 12/05/2022 11:51:01       | Fail      | 4              | 0       |

**Table Key:**

- **Wi-Fi/CBRS:** Example Wi-Fi AP / radio name.
- **Signal Strength:** The Signal Strength of the res12 hex from the modeled coverage explorer.
- **Coverage Claim:** The date/time that the Coverage Claim period started.
- **Wi-Fi/CBRS Rank:** The assigned rank based on which Wi-Fi AP and CBRS Radio has the strongest Signal Strength (or Coverage Claim if tied for Signal Strength).
- **Coverage Points Per HIP 93:** The amount of MCP currently awarded under HIP 93.
- **New Coverage Points:** The amount of MCP that would be awarded under this HIP.

**Table Explanation:**

Since Wi-Fi AP / Radio A has the highest signal strength in that hex, it will be ranked as "1", and granted a 1.00X multiplier to the modeled coverage score of 16, which will award it with the full 16 (16 x 1) MCP for that epoch.

Since Wi-Fi AP and Radio B and C tied in Signal Strength, the Coverage Claim date is used to determine which radio is ranked next. For this example, radio B had its Coverage Claim date start on 01/01/2024 01:01:01 while radio C had its Coverage Claim date start on 02/12/2024 18:06:05. Therefore, since Wi-Fi AP B has an earlier Coverage Claim date, it will be ranked "2", while Wi-Fi AP C has a rank of "3".

Since Wi-Fi AP and Radio D had the lowest signal strength out of all four (4) Wi-Fi AP, and only the top three (3) Wi-Fi AP will earn PoC rewards, Wi-Fi AP D will not earn any MCP for this res12 hex, and are ranked as "Fail".

## Drawbacks:

Implementing this proposal will increase the complexity of modeled coverage scores due to adding additional variables used to calculate total MOBILE rewards.

## Rationale and Alternatives:

An alternative would be only allow the top three (3) radio signals between CBRS and Wi-Fi receive MCP per res12 hex; however, this may discourage the roll out of new outdoor Wi-Fi AP's

## Deployment Impact:

As [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) has already been deployed by Nova Labs, Nova Labs is able to change the chain variables to implement this HIP.

## Success Metrics:

This HIP is successful if: General consensus is that the coverage ratio between CBRS and WiFi AP is “fair” and that multilayered coverage is achieved in an efficient manner.
