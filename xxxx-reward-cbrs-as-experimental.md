# HIP XXX: Reward CBRS As Experimental

- Author(s): @rawrmaan
- Start Date: 2024-01-27
- Category: Economic, Technical
- Original HIP PR: XXX
- Tracking Issue: XXX
- Vote Requirements: veMOBILE Holders

## Summary

This Helium Improvement Proposal (HIP) suggests adjusting Proof-of-Coverage (PoC) rewards for CBRS radios to reflect their limited utility and experimental status on the network.

## Related Prior HIPs

- [HIP 74](0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage for the MOBILE subDAO.

- [HIP 85](0085-mobile-hex-coverage-limit.md) changed the limit of outdoor radios eligible for PoC rewards from 5 to 3, and introduced ranking multiplier.

- [HIP 93](0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced the addition of Wi-Fi Access Points and certain limitations.
  
- [HIP 101](0101-equalizing-poc-rewards-across-wifi-and-cbrs.md) proposed increasing Wi-Fi coverage points by 1.5x (indoor) and 2.5x (outdoor), but failed to pass a vote.

## Motivation

CBRS gateways and radios have been the main way to deploy coverage since the beginning of the Helium 5G network. However, as the network has matured, CBRS has proven to be infeasible in a number of technical and operational categories, thus offering limited utility to the network.

[HIP 93](0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points (APs), which provide a more seamless mode of connectivity, solving almost all of the problems that CBRS suffered from. Wi-Fi offers excellent utility and is production ready today.

The table below offers a comparative evaluation of each technology's current status and utility on the Helium network.

|                               | CBRS           | Wi-Fi                       |
| ----------------------------- | ---------------- | ---------------------------- |
| **Deployment Scenarios** | ✅ Indoor & Outdoor | ✅ Indoor & Outdoor |
| **Potential Signal Level**      | ✅ High | 🌕 Medium |
| **Handoff Performance**    | 🌕 Mixed (Experimental)             | ✅ Excellent                       |
| **Bandwidth Capacity** | 🌕 Medium               | ✅ Excellent                           |
| **Device Compatibility** | 🌕 CBRS Band Required | ✅ 100% |
| **Production Readiness Timeline** | 🌕 Uncertain (2-3 yrs?) | ✅ Today
| **Anti-Gaming Defenses** | 🌕 Signed GPS Coordinates | ✅ Signed GPS + Wi-Fi Scanning |
| **Deployment Difficulty** | 🌕 Medium | ✅ Easy |
| **M(V)NO Integration** | ❌ Highly Complex | ✅ Straightforward |
| **SAS & Proxy Requirement** | ❌ Required | ✅ None |
| **2nd SIM Requirement** | ❌ Required | ✅ None |
| **Region Compatibility** | ❌ USA Only | ✅ Global |
| **Subscriber Penetration** | ❌ Low (Beta/Power Users Only) | ✅ 100% |
| **Guest Network Functionality** | ❌ None | ✅ Public Wi-Fi Possible |
| **Manufacturing Status** | ❌ No New Devices | ✅ Active |
| **Overall Status** | 🌕 **Experimental** | ✅ **Production Ready** |

Nearly 18 months after the Helium 5G network's launch, **CBRS continues to receive first-class Proof of Coverage rewards despite still being an experimental technology** with many user experience drawbacks and unsolved integration challenges.

Wi-Fi, in contrast, is disadvantaged in the Modeled Coverage reward points algrithm, despite having extremely high utility to the network. This results in unfairly lower PoC rewards for Wi-Fi hotspot deployers.

For the Helium Mobile Network to succeed, it is important to accelerate deployment of Wi-Fi Hotspots, which currently provide higher likelihood of real data usage on the Network for the reasons described above.

## Stakeholders

- Deployers - This HIP will make it more fair for deployers who are able to deploy a more optimal Wi-Fi AP setup than CBRS setups.
- Subscribers - Subscribers may see more coverage of Wi-Fi access, which every subscriber will be able to connect to, as opposed to CBRS radios which require a compatiable device and a second SIM.
- Service Providers - If better Wi-Fi coverage is added due to this HIP, Service Providers will see an increased amount of data being offloaded onto the Helium Mobile Network.

## Detailed Explanation

Based on the benefits of Wi-Fi over CBRS explained in the motivation section above, this proposal seeks to adjust PoC reward points for CBRS radios as follows:

# TODO: Determine how modeled & template coverage work for indoor vs. outdoor

### Changes to HIP 74 Points for CBRS Radios

|                               | Tier 1        | Tier 2                     | Tier 3                      | Tier 4           |
| ----------------------------- | ------------- | -------------------------- | --------------------------- | ---------------- |
| **Potential Signal Power**    | $P > -95 dBm$ | $-95 dBm \ge P > -105 dBm$ | $-105 dBm \ge P > -115 dBm$ | $P \le -115 dBm$ |
| **Potential Signal Level**    | High          | Medium                     | Low                         | None             |
| **Estimated coverage points** | 16            | 8                          | 4                           | 0                |

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
