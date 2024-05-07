# HIP 87: Proportional Service Provider Rewards

- Author(s): [@KeithRettig](https://github.com/KeithRettig), [@zer0tweets](https://github.com/zer0tweets), [@meowshka](https://github.com/meowshka)
- Start Date: 2023-05-15
- Category: Economic, Technical
- Original HIP PR: [#699](https://github.com/helium/HIP/pull/699)
- Tracking Issue: [#704](https://github.com/helium/HIP/issues/704)
- Voting Requirements: veMOBILE Holders

## Summary

This HIP proposes to make specific how Service Providers are eligible for rewards from the HIP-53 specified Service Provider MOBILE Reward bucket. The proposal suggests a usage-based approach to calculate rewards for Service Providers based on the amount of Data Credits burned. Service Providers would be rewarded in MOBILE tokens at a 1:1 ratio for the burned Data Credits with proportional distribution if the total exceeds the reward bucket value.

## Motivation

The primary motivation is clarify how Service Provider Rewards are calculated. There is also a motivation to prevent a scenario in which a Service Provider is rewarded the full MOBILE reward bucket while burning little to no Data Credits. The content of this HIP was originally written within HIP-82. However, since the concept applies to all Service Providers in the Helium 5G Network and not to the specific Service Provider of HIP-82, it is more appropriate to have this as its own HIP.

## Stakeholders

Any and all Service Providers of the Helium MOBILE Network.

## Detailed Explanation

HIP-53 specifies an overall rewards bucket for Service Providers but does not go into specifics of how rewards should be calculated based on the amount of data being offloaded. To prevent a scenario in which a Service Provider is rewarded the full MOBILE Service Provider Reward Bucket while burning little to no Data Credits (DC), we propose to follow a similar usage-based approach as outlined in HIP-10 for the IoT Network.
We propose that Service Providers are rewarded up to 1:1 in MOBILE tokens for the amount of DC burned during a reward period, similar to the approach in HIP-10. If the Service Providers collectively burn more DC than the equivalent amount of MOBILE tokens in the Service Provider reward bucket, each Service Provider will be rewarded proportionally to its share of DC burn. If the Service Providers collectively burn less DC than the equivalent amount of MOBILE tokens, the remainder of the Service Provider bucket will not be minted.

To illustrate, here are two scenarios where the value of DC burned is **less than or exceeds** the rewards bucket:

1. Value of DCs burned for data traffic **is less than** the Service Provider Reward Bucket (10% of MOBILE emissions):

| Item                     |            Rewards |
| :----------------------- | -----------------: |
| DCs burned by SP         |        100,000,000 |
| Price of DC              |           $0.00001 |
| Price of MOBILE\*        |            $0.0001 |
| DCs burned in MOBILE\*\* |         10,000,000 |
| 10% SP bucket            | 500,000,000 MOBILE |
| SP rewards               |  10,000,000 MOBILE |

2. Value of DCs burned for data traffic **exceeds** the Service Provider Reward Bucket (10% of MOBILE emissions):

| Item                     |            Rewards |
| :----------------------- | -----------------: |
| DCs burned by SP         |    100,000,000,000 |
| Price of DC              |           $0.00001 |
| Price of MOBILE\*        |            $0.0001 |
| DCs burned in MOBILE\*\* |     10,000,000,000 |
| 10% SP bucket            | 500,000,000 MOBILE |
| SP rewards               | 500,000,000 MOBILE |

\* The price chosen is an example, not the actual price. The actual price will be determined by the Price Oracle on the Solana blockchain during the rewards calculation time. \*_ Amount of MOBILE tokens with the same value as the value of the DCs burned by SP: (10,000 DC _ $0.00001 (fixed price of DC) / $0.0001 (example price of MOBILE))

While approval of this approach is not necessary for Helium Mobile to start offloading data to the Helium Mobile Network, it does modify a policy that is important to Helium Mobile as it determines the amount of its expected rewards from the MOBILE Service Provider Reward Bucket.

## Implementation

We leave the implementation of the smart contract components, verifiability, and Service Provider compliance up to the Helium Core Developers to determine.

## Drawbacks

As Helium 5G Network's first and only Service Provider, Helium Mobile, suggested the ideas within this HIP, there are no perceived drawbacks; there are no other Service Providers to be affected by this HIP.

## Dependencies

Nova Labs has done most of the work necessary to launch the Helium Mobile carrier on the data offloading, customer tooling, and support flows side. Launch of staking, Hotspot rewards, and other blockchain related functionality is dependent on the successful implementation of these features by Helium Core Developers.

## Deployment Impact

Service Providers will be able to offload data traffic to the Helium Mobile Network and receive Service Provider rewards.

## Success Metrics

The main success metric would be Service Providers receiving their proportionate rewards from the MOBILE Reward bucket.
