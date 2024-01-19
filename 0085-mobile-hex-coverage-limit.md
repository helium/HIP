# HIP 85: MOBILE Hex Coverage Limit

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 5/12/2023
- Category: Technical & Economic
- Original HIP PR: #654
- Tracking Issue: #673
- Voting Requirements: veMOBILE

## Summary:

This Helium Improvement Proposal (HIP) suggests adding a baseline hex multiplier score to the MOBILE Proof-of-Coverage (PoC) Modeled Coverage Points based on whether other coverage from Helium 5G deployments exists within that res12 hex. This HIP only applies to outdoor radios, and no changes to the reward structure of indoor mobile radios are being made with this HIP.

## Motivation:

The Helium Community passed [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) to incorporate obstruction data and radio signal power into the PoC reward model; however, it weighed all coverage within each res12 hex equally, even if multiple radios already provided coverage within that res12 hex. This means deployers could point five (5) outdoor radios in the same direction and still be awarded total Modeled Coverage points for each res12 hex. This results in the dilution of MOBILE and reduced MOBILE rewards to deployments that are strategically placed to minimize overlap in coverage.

This proposal aims to improve the value of Mobile network coverage by incentivizing users to deploy radios that minimize overlapping coverage and encourage deployments in new areas.

## Stakeholders:

All Mobile Radio Deployers / Mobile Hotspot Owners.

## Detailed Explanation:

Currently, any redundant and overlapping network coverage is still rewarded the same as non-overlapping coverage under HIP 74. This discourages the buildout of coverage to new areas. To prevent overcrowding and overlapping of coverage in hexes, this HIP proposes to limit the amount of modeled coverage points radios receive for redundant coverage in res12 hexes.

To ensure that only the best setups are rewarded, only the top three (3) ranked radio signals in each res12 hex will be awarded modeled coverage points, with a decaying multiplier based on the radio rank noted below. Any radios not ranked within the top three (3) will be ranked as “Fail”, and receive no modeled coverage points for that res12 hex.

| Rank | Multiplier |
| ---- | ---------- |
| 1    | 1X         |
| 2    | .75X       |
| 3    | .25X       |
| Fail | 0X         |

Please note that the multiplier table above only affects the modeled coverage points that are given to each outdoor radio and does not affect rewards distributed for the transfer of data or PoC rewards for indoor radios.

### Radio Ranking & Criteria

All outdoor radios that provide coverage to any res12 hex will be given a rank for each res12 hex they provide coverage in based on the following potential attributes (note, this rank is only for a single res12 hex and not the entire radio):

- Modeled Signal Strength

- Coverage Claim Time (Only used as a tiebreaker for Modeled Single Strenght)

If there are more than 1 Radio with the same signal strength level, use the `coverage_claim_time` value to rank the top 3 oldest installations where `coverage_claim_time` is the timestamp when the Radio received the spectrum access grant for the first time. The oldest Radio will receive the higher rank, while newest radio will receive the lowest rank. To prevent rewarding "dead" Radios, we propose to reset `coverage_claim_time` if the Radio was not generating a Heartbeat for more than 72 hours and use the time of the last Heartbeat as the new `coverage_claim_time`.

### Modeling Radio Ranking

See the example below of how ranking based on a hex multiplier would affect deployment of five (5) outdoor radios if they are providing modeled coverage to the same res12 hex:

| Radio | Signal Strength | Coverage Claim Start Date | Rank | Coverage Points Per HIP 74 | New Coverage Points |
| ----- | --------------- | ------------------------- | ---- | -------------------------- | ------------------- |
| A     | -77.33 dBm      | 05/01/2023 23:24:25       | 1    | 16 (16 \* 1)               | 16 (16 \* 1)        |
| B     | -88.75 dBm      | 12/01/2022 01:01:01       | 2    | 16 (16 \* 1)               | 12 (16 \* .75)      |
| C     | -88.75 dBm      | 12/02/2022 12:11:01       | 3    | 16 (16 \* 1)               | 4 (16 \* .25)       |
| D     | -93.60 dBm      | 12/05/2022 11:51:01       | Fail | 16 (16 \* 1)               | 0 (16 \* 0)         |
| E     | -94.69 dBm      | 08/01/2022 05:01:59       | Fail | 16 (16 \* 1)               | 0 (16 \* 0)         |

**Table Key:**

- **Radio:** Example radio name.
- **Signal Strength:** The Signal Strength of the res12 hex from the modeled coverage explorer.
- **Coverage Claim:** The date/time that the Coverage Claim period started.
- **Rank:** The assigned rank based on which radio has the strongest Signal Strength (or Coverage Claim if tied for Signal Strength).
- **Coverage Points Per HIP 74:** The amount of modeled coverage points currently awarded under HIP 74.
- **New Coverage Points:** The amount of modeled coverage points that would be awarded under this HIP.

**Table Explanation:**

Since Radio A has the highest signal strength in that hex, it will be ranked as "1", and granted a 1X multiplier to the modeled coverage score of 16, which will award it with the full 16 (16 x 1) modeled coverage points for that epoch.

Since radios B and C tied in Signal Strength, the Coverage Claim date is used to determine which radio is ranked next. For this example, radio B had its Coverage Claim date start on 12/01/2022 01:01:01 while radio C had a its Coverage Claim date starts on 12/02/2022 12:11:01. Therefore, since radio B has an earlier Coverage Claim date, it will be ranked "2", while radio C having a rank of "3".

Since radios D and E had the lowest signal strength out of all five (5) radios, and only the top three (3) radios will earn PoC rewards, radios D and E will not earn any modeled coverage points for this res12 hex, and are ranked as "Fail".

As noted in the example above, outdoor radio deployers will now need to be cognizant of where they are placing their radios in order to maximize modeled coverage point.

### Changes to Multipliers and Ranks

As the MOBILE network matures, these multiplier scores may need to be fine tuned or changed. Therefore, the multipliers and ranks presented in this HIP shall be implemented as chain variables. In order for these chain variables to be modified, or deleted, one of two things must happen:

1. A new HIP is proposed modifying the multipliers and or ranks; or
2. A Governance or Working Group (herewithin reffered to as "the group") for the MOBILE Network must create a MOBILE PoC Change Proposal. The proposal will then be discussed by the group, in which a general consensus must be reached (consensus defined by the group). Once consensus is reached, the proposal will be put to a vote by the community, with the voting requirement being veMOBILE.

The proposal must be announced within the Official Helium Community Discord Server under the “Governance-Announcement” channel (or similar channel if the “Governance-Announcement” channel is removed), at least five (5) calendar days prior to the start of voting. Voting shall remain open for seven (7) calendar days. A 66.67% vote in favor of the change(s) must be reached in order for the vote to pass.

A new vote with the same or modified change(s) to that multiplier and or rank may be put to vote by the community again with the groups consensus no earlier than 60 calendar days after the last voting has ended.

## Drawbacks:

Implementing this proposal could increase the complexity of modeled coverage scores due to adding additional variables used to calculate total MOBILE rewards.

Additionally, radio deployers may lose out on awarded coverage points in instances where multiple radios are set up in the same hex.

## Rationale and Alternatives:

An alternative would be allowing radios and hexes to keep earning the defined amount of modeled coverage points as described in HIP 74.

However, this may prevent or stagnate the network's growth because HIP 74 does not incentivize deployment of Hotspots to minimize overlapping coverage.

## Unresolved Question:

None

## Deployment Impact:

HIP 85 affects only Outdoor radios, and coverage from indoor radios will continue to earn Modeled Coverage Points based on HIP 74.

Nova Labs will need to add new fields into the Modeled Coverage Explorer to make Radio Hex Ranks and Coverage Claim date visible.

Further, a large amount of overlapping coverage exists within the MOBILE network. Deployers may have to find new locations for some or all of their radios in order for them to continue to earn modeled coverage points.

This HIP leaves the implementation open to interpretation by Helium Core Developers who will implement this change on behalf of the community.

## Success Metrics:

This HIP is successful if:

1. There is more broad coverage extended to new locations on the modeled coverage map
2. and less redundant coverage in areas of saturation
