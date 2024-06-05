# HIP 119: Closing Gaming Loopholes Within the MOBILE Network

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2024-04-25
- Category: Economic, Technical
- Original HIP PR: [#969](https://github.com/helium/HIP/pull/969)
- Tracking Issue: [#989](https://github.com/helium/HIP/issues/989)
- Vote Requirements: veMOBILE Holders

---

## Summary
This Helium Improvement Proposal (HIP) proposes closing gaming loopholes to help prevent gaming within the MOBILE network.

## Motivation
[HIP 107](https://github.com/helium/HIP/blob/main/0107-preventing-gaming-within-the-mobile-network.md) was intended to prevent gaming, and close gaming loopholes within the MOBILE network; however, the community voted against the HIP, which is believed to be due to the power it gave Service Providers to ban devices. However, multiple gaming loopholes and venues to cheat are still present within the MOBILE network.

## Stakeholders
The stakeholders of this proposal are:

- **All Deployers** - Deployers will now have more stringent trust score thresholds that they need to meet in order to obtain a higher trust score.


## Detailed Explanation
The HIP author has tested various methods in which deployers can game and cheat the MOBILE network, and proposes the below action to be taken to close gaming loopholes. Please note, the methods in which gaming can be conducted will not be described in this HIP for the safety of the network.


### Maximum Asserted Distance Difference
This HIP proposes changing the maximum asserted distance difference for indoor and outdoor Wi-Fi Access Points to the following:

#### Indoor Access Points
In instances where external sources, such as Skyhook, states the asserted distance is 201-300 meters away, the trust score will be set to `0.25`. In instances where external sources, such as Skyhook, states the asserted distance is 301 meters or greater meters away, the trust score will be set to `0.00`. Refer to the table below:

| Difference in Distance Asserted | Trust Score |
|---------------------------------|-------------|
| 0-200 Meters                    | `1.00`      |
| 201-300 Meters                  | `0.25`      |
| 301 Meters or Greater           | `0.00`      |

#### Outdoor Access Points
As the Outdoor Access Points contain GPS, they are able to obtain much accurate location readings than the indoor Wi-Fi. As such, the difference in distance is set to be more strict. In instances where GPS and or external sources, such as Skyhook, states the asserted distance 75-100 meters away, the trust score will be set to `0.25`. In instances where external sources, such as Skyhook, states the asserted distance is 100 or greater meters away, the trust score will be set to `0.00`. Refer to the table below:

| Difference in Distance Asserted | Trust Score |
|---------------------------------|-------------|
| 0-75 Meters                     | `1.00`      |
| 76-100 Meters                   | `0.25`      |
| 101 Meters or Greater           | `0.00`      |

### Maximum Asserted Distance for Boosted Hexes
Further, in order for access points to be eligible for boosted Service Provider rewards defined in HIP-84, the asserted distances must be 50 meters or less than the reported location from external services for both indoor and outdoor Access Points. In instances where the difference is greater than 50 meters, the access point will still be eligible for PoC rewards, but not boosted rewards.


## Drawbacks
Deployers who deploy devices in unpopulated areas or areas with a low amount of external Wi-Fi signals may suffer with a lower trust score, as Skyhook is less accurate in locations such as these.

## Rationale and Alternatives
One alternative was already explored via HIP 107; however, the community voted against that.

## Implementation Phases

### Phase 1
Nova Labs will complete the following:
* Update the Hotspot trust score for Wi-Fi indoor Hotspots to `0.25` if the asserted location is 201-300 meters or more from external data sources like Skyhook, and `0.00` if the asserted location is 301 meters or more away.
* Update the Hotspot trust score for Wi-Fi Outdoor Hotspots to `0.25` if the asserted location is 75-100 meters or more from external data sources like Skyhook and or skyhook, and to `0.00` if 101 or more meters away.

### Phase 2
Helium Foundation will complete the following:
* Update and backfill the protocol to add Height and Azimuth to on chain data of MOBILE hotspots.
* Update the Helium Wallet app to allow location assertions within the app by capturing height and azimuth.

## Success Metrics
This HIP is successful if the amount of access points that are incorrectly asserted or that are abusing the network decrease.
