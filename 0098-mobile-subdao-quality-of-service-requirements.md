# HIP 98: MOBILE SubDAO Quality of Service Requirements

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2023-10-21
- Category: Economic, Technical
- Original HIP PR: [#794](https://github.com/helium/HIP/pull/794)
- Tracking Issue: [#797](https://github.com/helium/HIP/issues/797)
- Vote Requirements: veMOBILE Holders

## Related Prior HIPs:

[HIP 53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) - Established the concept of the MOBILE SubDAO

[HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) - Established modeled proof of coverage, and modeled coverage points.

[HIP 85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) - Established limits to how many radios are rewarded proof of coverage rewards per res12 hex based on overlapping coverage.

[HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) - Established Wi-Fi Access Points to be onboarded and rewarded to the Helium 5G network.

## Summary

This Helium Improvement Proposal (HIP) sets quality of service (QOS) requirements that were noted within this [blog post](https://docs.helium.com/mobile/proof-of-coverage/).

## Motivation

Previous QOS requirements were implemented for the MOBILE network without community input and vote. As these requirements were previously implemented without a HIP, a HIP is being created to memorialize these QOS requirements.

## Stakeholders

MOBILE Deployers - MOBILE Deployers will be affected, as they will have to continue to meet speedtest and heartbeat requirements in order to earn rewards for Proof of Coverage (PoC).

Service Providers and Subscribers - Service Providers and Subscribers will benefit from this HIP, as it encourages MOBILE Deployers to have appropriate backhaul for their deployments, allowing for faster and smoother connections to the network.

## Detailed Explanation

These QOS requirements only impact MOBILE Rewards for PoC, and do not affect rewards for the transfer of data.

### Uptime Heartbeats

A "heartbeat" is data sent by the Wi-Fi Access point and or 5G Hotspot indicating that a connected Radio is authorized to transmit 5G coverage.

Heartbeats occur every 60 seconds and transmit authorizations are valid for 240 seconds. This rolling overlap ensures that a Small Cell Radio can broadcast on an ongoing basis while allowing for brief interruptions.

To encourage reliable signal availability, 5G Hotspots and connected CBRS Small Cell Radios and Wi-Fi Access Points must generate at least one valid heartbeat per hour in 12 unique hours of the 24-hour Reward Period to earn Proof of Coverage (PoC) rewards.

#### Heartbeat Reward Tiers

Each Radio and Access Point is given a heartbeat multiplier of either 0 or 1. This multiplier only affects Proof of Coverage rewards.

Each Radio and Access Point is awarded 1 point for a valid heartbeat in each hour, with a maximum of 24 points in the Reward Period. All Radios and Access Points with at least 12 points in the 24-hour Reward Period are given a heartbeat multiplier of 1 and will be eligible to earn PoC MOBILE Rewards.

### Speed Test Reward Tiers

Many locations where connectivity is being deployed, including some rural areas, do not always have the high-speed Internet connectivity needed to meet the acceptable Internet requirements for Genesis rewards consistently. Note, the tiering and multipliers proposed below are only applicable to PoC rewards, MOBILE Rewards for data transfers are not affected.

Often these areas do not have good cellular coverage either. That's why it is essential to incentivize Helium deployments in less well-connected areas.

Speed Test results are categorized into one of four Tiers - Good, Acceptable, Degraded, Poor, and Fail. Please note, this HIP proposes changing the name of the 1X speedtest multiplier to "Good", and adding a new 0.75X multiplier for "Acceptable". Please see the table below.

| Speed Test Tier | Speedtest Multiplier | Requirement (speeds in Mbps, latency in ms)    |
| --------------- | -------------------- | ---------------------------------------------- |
| Good            | 1.00X                | 100+ Download, AND 10+ Upload, AND <50 Latency |
| Acceptable      | 0.75X                | 75+ Download, AND 8+ Upload, AND <60 Latency   |
| Degraded        | 0.50X                | 50+ Download, AND 5+ Upload, AND <75 Latency   |
| Poor            | 0.25X                | 30+ Download, AND 2+ Upload, AND <100 Latency  |
| Fail            | 0.00X                | <30 Download, OR <2 Upload, OR >100 Latency    |


Tiered Speed Test values are used as a multiplier in Rewards calculations as follows:
Speed Test Results are put into Tiers based on the minimum value of each Download, Upload, and Latency (logical AND).
Speed Test results that do not meet the minimum requirements for any Download, Upload, or Latency are considered to have Failed and are not eligible for PoC Rewards until the Speed Test Average is improved (logical OR).

#### Multiplier Effect

Upon implementation of [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md), this multiplier will be applied the total modeled coverage points received by that radio/access point. The multipliers will be used within the following order:

Heartbeat Multiplier
Speed Test Multiplier
Any other multipliers, such as the ones approved in [HIP 85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) (Upon implementation of [HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md), this multiplier will be applied the total modeled coverage points received by that radio/access point.)

See the table below for examples of how the multipliers will affect modeled coverage points (MCP):

| Device | Initial MCP | Heartbeat Multiplier | Speed Test Multiplier | HIP 85 Multiplier | Total MCP |
| ------ | ----------- | -------------------- | --------------------- | ----------------- | --------- |
| A      | 1,000       | 1.00X                | 1.00X                 | 1.00X             | 1,000.00  |
| B      | 1,000       | 1.00X                | 0.75X                 | 0.75X             | 562.50    |
| C      | 1,000       | 1.00X                | 0.50X                 | 1.00X             | 500.00    |
| D      | 1,000       | 1.00X                | 0.00X                 | 1.00X             | 0.00      |
| E      | 1,000       | 0.00X                | 1.00X                 | 1.00X             | 0.00      |

### Radio Health Metrics

In order for CBRS Radios to earn rewards for the epoch, the radio must but authorized by SAS and on-air. If these metrics are not met for 12 or more heartbeats during an epoch, that radio will not earn PoC rewards for that epoch.

### Location Trust Score

As per [HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md), after an initial assertion of its location during Wi-Fi access point onboarding, the system will periodically verify the access point's location. This is to prevent situations in which the Wi-Fi access point is onboarded in one location and then moved to a different location. In the current implementation the Location Validation service performs this verification twice per day. The timestamp of the last verification and the last derived lat/lng are subsequently included in the heartbeats submitted by the Wi-Fi access point to the Oracles.

The Mobile Verifier oracle, as part of validating each heartbeat, will validate the verified location and compare the provided lat/lng to the onchain asserted location and as per the rules defined in [HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md), calculate a location trust score. In the current implementation, as the verified location can potentially change from one heartbeat to the next, the score is calculated and assigned on a per heartbeat basis. Then at the time of rewards calculation the Mobile Verifier oracle will take an average of the location trust scores assigned to the verified heartbeats and this averaged score will form the location trust score multiplier for the Wi-Fi access point for that epoch.

Example Heartbeats
The example below illustrates the location trust score calculated for 24 heartbeats received from an access point over the course of one epoch.

heartbeat_number assigned location trust score

| heartbeat_number | assigned location trust score |
| ---------------- | ----------------------------- |
| 1                | 0.25                          |
| 2                | 0.25                          |
| 3                | 0.25                          |
| 4                | 0.25                          |
| 5                | 0.25                          |
| 6                | 0.25                          |
| 7                | 0.25                          |
| 8                | 0.25                          |
| 9                | 0.25                          |
| 10               | 0.25                          |
| 11               | 1.00                          |
| 12               | 1.00                          |
| 13               | 1.00                          |
| 14               | 1.00                          |
| 15               | 1.00                          |
| 16               | 1.00                          |
| 17               | 1.00                          |
| 18               | 1.00                          |
| 19               | 1.00                          |
| 20               | 1.00                          |
| 21               | 1.00                          |
| 22               | 1.00                          |
| 23               | 1.00                          |
| 24               | 1.00                          |

In the example above, the average would be 0.6875, and wojld be utilized during rewards.

## Rationale

As the Helium 5G network matures, it’s vitally important that the quality of the network and deployments provide usable and consistent coverage.

## Deployment Impact
Protocol engineers will have to change the speedtest requirements to incorporate the new "Acceptable" multiplier of 0.75X upon passing.

## Success Metrics

As most of what is written in this HIP has already been previously implemented, this HIP will be considered successful if it is passed. If this HIP does not pass, any quality of service metrics already previously established outside of a HIP process, such as speed test and heartbeat requirements must immediately be removed from the Helium 5G network.
