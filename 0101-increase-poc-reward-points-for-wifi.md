# HIP 101: Increase PoC Reward Points for Wi-Fi Access Points

- Author(s): [@zer0tweets](https://github.com/zer0tweets) (Nova Labs, Inc.)
- Start Date: 2023-12-09
- Category: Economic, Technical
- Original HIP PR: [#823](https://github.com/helium/HIP/pull/823)
- Tracking Issue: [#825](https://github.com/helium/HIP/issues/825)
- Vote Requirements: veMOBILE Holders

## Related Prior HIPs

[HIP 74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage for the MOBILE subDAO.

[HIP85](https://github.com/helium/HIP/blob/main/0085-mobile-hex-coverage-limit.md) changed the limit of outdoor radios eligible for PoC rewards from 5 to 3, and introduced ranking multiplier.

[HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced the addition of Wi-Fi Access Points and certain limitations.

## Summary

This Helium Improvement Proposal (HIP) suggests increasing Proof-of-Coverage (PoC) rewards for Wi-Fi Indoor and Outdoor Hotspots to accelerate rollout of Wi-Fi. 

## Motivation

[HIP 93](https://github.com/helium/HIP/blob/main/0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points (APs) as a new way to stay connected to the Helium Mobile Network and proposed a PoC algorithm for Wi-Fi Hotspots, largely mirroring the reward weights of CBRS radios. However, CBRS radios currently provide a lot less utility on the network. Specifically:
- There is no immediate solution for Android phones to seamlessly hand-off data sessions between macro network like T-Mobile and CBRS; 
- There is a way to do this for iOS17 devices, but, so far, this only works on iPhones 13+ and requires an install of a geo-fencing profile by the end user;
- CBRS radios have no ability to provide guest / public Wi-Fi service and will always require an installation of additional, second CBRS sim on a client device to be accessible.

Wi-Fi Hotspots solve all of the above, thereby providing more utility for the Helium Mobile Network, yet are currently compensated for PoC purely based on modeled coverage, which results in lower PoC rewards for the Wi-Fi hotspot deployers.

For the Helium Mobile Network to succeed, it is important to accelerate deployment of Wi-Fi Hotspots, which currently provide higher likelihood of real data usage on the Network for the reasons described above. 


## Stakeholders

- Deployers - this HIP will make it more fair for deployers who are able to deploy a more optimal Wi-Fi AP setup than current existing setups. 
- Subscribers - Subscribers may see more coverage of Wi-Fi access as this HIP will encourage Wi-Fi deployments to not be bunched together. 
- Service Providers - if better Wi-Fi coverage is added due to this HIP, Service Providers will see an increased amount of data being offloaded onto the Helium Mobile Network.

## Detailed Explanation

[Based on the current hardware market prices and existing PoC for Wi-Fi and CBRS](./XXXX-increase-poc-reward-points-for-wifi/WiFi-CBRS-ROI-Estimate.pdf) we can derive that:

- Indoor CBRS and Indoor Wi-Fi yield roughly the same ROI,
- Outdoor CBRS 430 offers 3x ROI over Outdoor Wi-Fi.

Based on the above analysis and the current status quo with “work-in-progress” CBRS handovers, we propose to increase Wi-Fi PoC as follows:


|                               | Tier 1           | Tier 2                        | Tier 3                       | Tier 4              |
| ----------------------------- | ---------------- | ----------------------------- | ---------------------------- | ------------------- |
| **Potential RSSI**            | $RSSI > -65 dBm$ | $-65 dBm \ge RSSI > -75 dBm$  | $-75 dBm \ge RSSI > -85 dBm$ | $RSSI \le -85 dBm$  |
| **Potential Signal Level**    | High             | Medium                        | Low                          | None                |
| **Estimated Coverage Points** | 48               | 24                             | 12                            | 0                   |

## Drawbacks

Implementing this proposal will decrease long term PoC rewards for CBRS Hotspot deployers.

## Rationale and Alternatives

An alternative would be to introduce a temporary multiplier to the PoC rewards based on radio type, which can be quickly adjusted, within some limits, by voting of a Mobile Working Group. 

The issue with CBRS handovers is on its way of being solved and phone manufacturers are moving towards improving CBRS UX across the board, therefore future similar adjustments to rewards based on the quality of the UX for a particular radio technology may be needed. Doing such adjustments through Mobile Working Group voting vs. a dedicated HIP every time could be a viable alternative.

## Unresolved Questions

TBD

## Deployment Impact

Implementation of this HIP is extremely simple and will involve updating a few variables in the Mobile Oracle to calculate Wi-Fi PoC rewards using the new reward points scheme, described above. If voted, it passed, it is expected that implementation of this HIP should not take longer than 1 week.

## Success Metrics

This HIP is successful if we see the number of Wi-Fi Hotspots active on the Network become higher than the number of CBRS radios.
