# HIP 101: Equalizing POC Rewards Across Wi-Fi and CBRS

- Author(s): [@zer0tweets](https://github.com/zer0tweets) (Nova Labs, Inc.)
- Start Date: 2023-12-09
- Category: Economic, Technical
- Original HIP PR: [#823](https://github.com/helium/HIP/pull/823)
- Tracking Issue: [#825](https://github.com/helium/HIP/issues/825)
- Vote Requirements: veMOBILE Holders

## Summary

This Helium Improvement Proposal (HIP) suggests equalizing Proof-of-Coverage (PoC) rewards for Wi-Fi Indoor and Outdoor Hotspots with that of CBRS hotspots.

## Related Prior HIPs

- [HIP 74](0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage for the MOBILE subDAO.

- [HIP 85](0085-mobile-hex-coverage-limit.md) changed the limit of outdoor radios eligible for PoC rewards from 5 to 3, and introduced ranking multiplier.

- [HIP 93](0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced the addition of Wi-Fi Access Points and certain limitations.

## Motivation

[HIP 93](0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points (APs) as a new way to stay connected to the Helium Mobile Network and proposed a PoC algorithm for Wi-Fi Hotspots, largely mirroring the reward weights of CBRS radios. However, CBRS radios currently provide less utility on the network. Specifically:

- There is no immediate solution for Android phones to seamlessly hand-off data sessions between macro network like T-Mobile and CBRS;
- There is a way to do this for iOS17 devices, but, so far, this only works on iPhones 13+ and requires an install of a geo-fencing profile by the end user;
- CBRS radios have no ability to provide guest / public Wi-Fi service and will always require an installation of additional, second CBRS sim on a client device to be accessible.

Wi-Fi Hotspots solve all of the above, thereby providing more utility for the Helium Mobile Network, yet are currently compensated for PoC based on modeled coverage, which calculates rewards purely in terms of geographic coverage and gives no consideration to greater overall utility of Wi-Fi. This, in turn, results in unfairly lower PoC rewards for the Wi-Fi hotspot deployers since Wi-Fi hotspots are less capable than CBRS at covering large number of res12 hexes.

For the Helium Mobile Network to succeed, it is important to accelerate deployment of Wi-Fi Hotspots, which currently provide higher likelihood of real data usage on the Network for the reasons described above.

## Stakeholders

- Deployers - this HIP will make it more fair for deployers who are able to deploy a more optimal Wi-Fi AP setup than current existing setups.
- Subscribers - Subscribers may see more coverage of Wi-Fi access as this HIP will encourage Wi-Fi deployments to not be bunched together.
- Service Providers - if better Wi-Fi coverage is added due to this HIP, Service Providers will see an increased amount of data being offloaded onto the Helium Mobile Network.

## Detailed Explanation

Based on the benefits of Wi-Fi over CBRS explained in the motivation section above, we propose to equalize POC for CBRS and Wi-Fi by increasing Wi-Fi PoC reward points for 180 days after implementation as follows:

- 1.5x for Indoor Wi-Fi. I.e. 600 rewards points for Wi-Fi AP vs. current 400 reward points;
- 2.5x for Outdoor Wi-Fi AP per each covered hex. I.e. 1250 (instead of 500) points for templated coverage and the following points per modeled coverage hex

|                               | Tier 1           | Tier 2                       | Tier 3                       | Tier 4             |
| ----------------------------- | ---------------- | ---------------------------- | ---------------------------- | ------------------ |
| **Potential RSSI**            | $RSSI > -65 dBm$ | $-65 dBm \ge RSSI > -75 dBm$ | $-75 dBm \ge RSSI > -85 dBm$ | $RSSI \le -85 dBm$ |
| **Potential Signal Level**    | High             | Medium                       | Low                          | None               |
| **Estimated Coverage Points** | 40               | 20                           | 10                           | 0                  |

## Outdoor Coverage Limit

To prevent the stacking of outdoor Wi-Fi AP's, this HIP limits modeled coverage rewards to the top two (2) outdoor Wi-Fi signals per res12 hex. If there is a tie, coverage claim time (explained below) is used to determine which top two will be rewarded.

If there are more than 2 Outdoor Wi-Fi AP signals within the same res12 hex with the same signal strength, the `coverage_claim_time` value will be used as a tiebreaker where `coverage_claim_time` is the timestamp when the Wi-Fi AP was asserted in that hex. To prevent rewarding "dead" Wi-Fi APs, we propose to reset `coverage_claim_time` if the Wi-Fi AP was not generating a Heartbeat for more than 72 hours and use the time of the last Heartbeat as the new `coverage_claim_time`.

## Drawbacks

Implementing this proposal will decrease long term PoC rewards for CBRS Hotspot deployers.

## Rationale and Alternatives

An alternative would be to introduce a temporary multiplier to the PoC rewards based on radio type, which can be quickly adjusted, within some limits, by voting of a Mobile Working Group.

The issue with CBRS handovers is on its way of being solved and phone manufacturers are moving towards improving CBRS UX across the board, therefore future similar adjustments to rewards based on the quality of the UX for a particular radio technology may be needed. Doing such adjustments through Mobile Working Group voting vs. a dedicated HIP every time could be a viable alternative.

## Unresolved Questions

None.

## Deployment Impact

Implementation of this HIP is extremely simple and will involve updating a few variables in the Mobile Oracle to calculate Wi-Fi PoC rewards using the new reward points scheme, described above. If voted, it passed, it is expected that implementation of this HIP should not take longer than 1 week. Upon approval by community vote Nova Labs will complete the implementation and deployment of this HIP, collaborating with Helium Foundation as required.

## Success Metrics

This HIP is successful if we see the number of Wi-Fi Hotspots being actived on the Network continue to outpace that of CBRS radios, resulting in higher paid data usage and more HNT emitted into MOBILE subDAO treasury.
