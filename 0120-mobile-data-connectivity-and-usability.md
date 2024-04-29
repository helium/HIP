# HIP 120: MOBILE Data Connectivity and Usability

- Author(s): [Fizzy99](https://github.com/mrfizzy99)
- Start Date: 2024-04-11
- Category: Economic, Technical
- Original HIP PR: [#986](https://github.com/helium/HIP/pull/986)
- Tracking Issue: [#994](https://github.com/helium/HIP/issues/994)
- Vote Requirements: veMOBILE Holders

---

## Summary

This Helium Improvement Proposal (HIP) introduces Data Connectivity and Usability requirements for MOBILE CBRS Radios and Wi-Fi Access Points in which units must be rewarded 1 data credit over a 14 epochs (days) in order to receive 1.0x multiplier for mobile coverage points. Units that do not pass this metric will receive 0.5x multiplier for mobile coverage points.

## Related HIPs

[HIP-111 - MOBILE Data Utility Benchmark - 10x Reward Boost](https://github.com/helium/HIP/blob/main/0111-mobile-data-utility-benchmark.md)
[HIP-118 - Verification Mapping for MOBILE Network](https://github.com/helium/HIP/blob/main/0118-verification-mapping.md)


## Motivation

This HIP was written to ensure that hotspots have a working and operational connection to the internet.


## Stakeholders

- MOBILE Holders.
- MOBILE Hotspots.


## Detailed Explanation
The Data Connectivity and Usability benchmark will be calculated at the end of each epoch. Units must have received at least 1 data credit through the unit within a rolling 14 epoch window to be eligible to receive a full 1.0x multiplier on coverage points. If a unit has not been rewarded 1 data credit over the rolling 14 epochs, they will receive a 0.5x multiplier on coverage points.

If a particular technology (Wi-Fi or CBRS) is unable to pass data, it will be exempt from the reward reduction. This will be calculated if all active units for that technology do not receive 1 data credit over the rolling 14 epochs.
Example: Currently, all CBRS radios are unable and have not received 1 data credit at the time of writing this HIP, so they would be exempt from the reward reduction until a method is in place to allow users to pass rewardable data.


## Rationale
1 data credit was chosen as it is low enough to simulate a single mobile webpage loading on a device that is connected.


## Implementation

These changes will require updates to the MOBILE Oracles and overall rewards mechanism.


## Unresolved Questions

None so far.


## Drawbacks

Unrewarded data does not count as data credit.
Subscribers that have gone over their rewardable data allocation or Free Wi-Fi access will not be counted as data credit.


## Success Metrics:
More than 50% of online and active deployments show 1 data credit every 14 epochs. 
