# HIP 113: Reward CBRS As Experimental

- Author(s): [@rawrmaan](https://github.com/rawrmaan)
- Start Date: 2024-02-29
- Category: Economic
- Original HIP PR: [#924](https://github.com/helium/HIP/pull/924)
- Tracking Issue: [#934](https://github.com/helium/HIP/issues/934)
- Vote Requirements: veMOBILE Holders

---

## Summary

This Helium Improvement Proposal (HIP) suggests adjusting Proof-of-Coverage (PoC) rewards for CBRS radios to reflect their limited utility and experimental status on the network.

## Related Prior HIPs

- [HIP 74](0074-mobile-poc-modeled-coverage-rewards.md) established modeled coverage for the MOBILE subDAO.
- [HIP 85](0085-mobile-hex-coverage-limit.md) changed the limit of outdoor radios eligible for PoC rewards from 5 to 3, and introduced ranking multiplier.
- [HIP 93](0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced the addition of Wi-Fi Access Points and certain limitations.
- [HIP 101](0101-equalizing-poc-rewards-across-wifi-and-cbrs.md) proposed increasing Wi-Fi coverage points by 1.5x (indoor) and 2.5x (outdoor), but failed to pass a vote.

**Disclosure**: Please note that this HIP is written by a Board Member of the [Helium Foundation](https://helium.foundation) solely in a personal capacity. The Foundation was not involved in the drafting of the proposal and has taken no formal position for or against the HIP as of the date of drafting.

## Motivation

CBRS gateways and radios have been the main way to deploy coverage since the beginning of the Helium 5G network. However, as the network has matured, CBRS has proven to be impractical in a number of technical and operational categories, thus offering limited utility to the network.

[HIP 93](0093-addition-of-wifi-aps-to-mobile-subdao.md) introduced Wi-Fi Access Points (APs), which provide a more seamless mode of connectivity, solving almost all of the problems that CBRS suffered from. Wi-Fi offers excellent utility and is production ready today.

The table below offers a comparative evaluation of each technology's current status and utility on the Helium network.

|                               | CBRS           | Wi-Fi                       |
| ----------------------------- | ---------------- | ---------------------------- |
| **Deployment Scenarios** | ✅ Indoor & Outdoor | ✅ Indoor & Outdoor |
| **Potential Signal Level**      | ✅ High | 🌕 Medium |
| **Handoff Performance**    | 🌕 Mixed (Experimental)             | ✅ Excellent                       |
| **Bandwidth Capacity** | 🌕 Medium               | ✅ Excellent                           |
| **Phone Compatibility** | 🌕 CBRS Band Required | ✅ All Devices |
| **Tablet & Laptop Compatibility** | 🌕 eSIM + CBRS Band Required | ✅ All Devices |
| **Production Readiness Timeline** | 🌕 Uncertain (2-3 yrs?) | ✅ Today
| **Anti-Gaming Defenses** | 🌕 Signed GPS | ✅ Signed GPS + Wi-Fi Scanning |
| **Deployment Difficulty** | 🌕 Medium | ✅ Easy |
| **Manufacturing Status** | 🌕 Uncertain | ✅ Active |
| **M(V)NO Integration** | ❌ Highly Complex | ✅ Straightforward |
| **SAS Requirement** | ❌ Required | ✅ None |
| **Proxy Requirement** | ❌ Required | ✅ None |
| **Phone 2nd SIM Requirement** | ❌ Required | ✅ None |
| **Region Compatibility** | ❌ USA Only | ✅ Global |
| **Addressable Subscribers** | ❌ Low (Beta/Power Users Only) | ✅ All Subscribers |
| **Guest Network Functionality** | ❌ None | ✅ Public Wi-Fi Possible |
| **Overall Status** | 🌕 **Experimental** | ✅ **Production Ready** |

Nearly 18 months after the Helium 5G network's launch, **CBRS continues to receive first-class Proof of Coverage rewards despite still being an experimental technology** with many user experience drawbacks and unsolved integration challenges.

CBRS radio and gateway sales have been discontinued by FreedomFi, the main manufacturer, with no publicly stated plans for continuation. Network participants with existing CBRS radios and gateways are taking advantage of their hardware to reap large rewards while offering minimal utility to the network.

As of 03/13/2024, CBRS radios receive **75.5% of the MOBILE Proof of Coverage rewards** while accounting for only **53.2% of the radios** on the network.

| Cell Maker             | Technology |   Count  | Total Rewards    | % of Total Rewards  | Avg Reward   |
|------------------------|-----------:|---------:|-----------------:|--------------------:|-------------:|
| Baicells Nova430i      | CBRS       | 4,420    | 16,422,337.101   | 33.74%              | 3,715.46     |
| Baicells Nova436H      | CBRS       | 641      | 15,857,479.585   | 32.58%              | 24,738.66    |
| MosoLabs Indoor        | CBRS       | 2,662    | 4,119,811.545    | 8.46%               | 1,547.64     |
| MosoLabs Outdoor       | CBRS       | 185      | 356,600.729      | 0.73%               | 1,927.57     |
| Nova Wifi Indoor       | Wi-Fi      | 4,664    | 5,641,842.608    | 11.59%              | 1,209.66     |
| Nova Wifi Outdoor      | Wi-Fi      | 2,305    | 6,274,377.116    | 12.89%              | 2,722.07     |
| **Total (CBRS)**       |            | 7,908    | 36,756,228.96    | 75.52%              | 4,647.98     |
| **Total (Wi-Fi)**      |            | 6,969    | 11,916,219.724   | 24.48%              | 1,709.89     |
| **Total (All)**        |            | 14,877   | 48,672,448.684   | 100%                |              |

_Source: https://explorer.moken.io/network-stats/detailed_

Wi-Fi, in contrast, is disadvantaged in the Modeled Coverage reward points algorithm despite having extremely high utility to the network and being actively in production. This results in unfairly lower PoC rewards for Wi-Fi hotspot deployers, who comprise the majority of new participants in the network. 

For the Helium Mobile Network to succeed, it is important to accelerate deployment of Wi-Fi Hotspots, which currently have the best capability to enable real data usage on the Network for the reasons described above.

Simultaneously, while currently inferior, CBRS has the potential for high utility to the Network in the long term. **CBRS radios should continue to receive a reduced incentive to stay online in order to maintain a minimal diverse fleet of experimental deployments** that can be used by network participants working on CBRS technology to continue their research and development. 

Data Transfer rewards for CBRS radios **are not** proposed to change.

## Stakeholders

- Deployers - This HIP will increase fairness for deployers who choose a more optimal Wi-Fi AP setup as opposed to an experimental CBRS setup.
- Subscribers - Subscribers may see more coverage of Wi-Fi access, which every subscriber will be able to connect to, as opposed to CBRS radios which require a compatible device and a second SIM.
- Service Providers - Service Providers may see a reduction in the amount of CBRS radios on the network.

## Detailed Explanation

Based on the low utility of CBRS explained in the motivation section above, this proposal seeks to make the following changes to PoC reward points for CBRS radios:

### Changes to Modeled Coverage Points for Outdoor CBRS Radios

Since outdoor CBRS radios cover many hexes, a large reduction in coverage points is warranted to account for the fact that utility is very low regardless of how many hexes are covered.

|                                          | Tier 1        | Tier 2                     | Tier 3                      | Tier 4           |
| ---------------------------------------- | ------------- | -------------------------- | --------------------------- | ---------------- |
| **Potential Signal Power**               | $P > -95 dBm$ | $-95 dBm \ge P > -105 dBm$ | $-105 dBm \ge P > -115 dBm$ | $P \le -115 dBm$ |
| **Potential Signal Level**               | High          | Medium                     | Low                         | None             |
| **Estimated coverage points (current)**  | 16            | 8                          | 4                           | 0                |
| **Estimated coverage points (proposed)** | **4**         | **2**                      | **1**                       | **0**            |

### Changes to Modeled Coverage Points for Indoor CBRS Radios

|                                          | Tier 1     | Tier 2             |
| ---------------------------------------- | ---------- | ------------------ |
| **Location**                             | Inside hex | All adjacent hexes |
| **Potential Signal Level**               | High       | Low                |
| **Estimated coverage points (current)**  | 400        | 100                |
| **Estimated coverage points (proposed)** | **100**     | **25**             |

### Examples of Specific Radios Before & After

| Gateway                                                                                     | Radio Type             | Modeled Coverage Points (current) | Modeled Coverage Points (proposed) | Reduction |
| ------------------------------------------------------------------------------------------- | ---------------------- | --------------------------------- | ---------------------------------- | --------- |
| [Rare Amber Beetle](https://planner.hellohelium.com/hex/08c44a1b9431e1ff/radio/1711546)     | Baicells 436H Outdoor  | 32,584 MCP                        | 8,146 MCP                          | 75.0%     |
| [Little Grey Porpoise](https://planner.hellohelium.com/hex/08c29a56d066e7ff/radio/5190)     | Baicells 436H Outdoor  | 8,908 MCP                         | 2,227 MCP                          | 75.0%     |
| [Beautiful Caramel Ferret](https://planner.hellohelium.com/hex/08c2a100d87263ff/radio/1536) | Baicells 430i Outdoor  | 844 MCP                           | 211 MCP                            | 75.0%     |
| [Cool Ocean Mole](https://planner.hellohelium.com/hex/08c2830828a505ff/radio/2162886)       | Sercomm Indoor         | 1,000 MCP                         | 250 MCP                            | 75.0%     |

## Estimated Rewards Impact

Although Coverage Points for CBRS radios are proposed to be reduced by 75%, the impact on each radio's overall rewards is currently less than that due to how Modeled Coverage Points are calculated.

Using a snapshot of coverage metrics as of 03/13/2024, the estimated average reward impact is **-42.3%** for CBRS radios and **+130.6%** for Wi-Fi hotspots as detailed below. This will continue to change over time as Coverage Points fluctuate.

Due to the lack of a public Modeled Coverage API, these Coverage Points estimates were made based on the rewards ratios on 03/13/2024 listed in the Motivation section above.

### Current Rewards

|               | Coverage Points (current) | MOBILE Rewards (current)   | % Total Rewards |
| ------------- | ------------------------- | -------------------------- | --------------- |
| CBRS          | 26,199,967                | 36,756,229                 | 75.5%           |
| Wi-Fi         | 8,492,786                 | 11,916,220                 | 24.5%           |
| Total         | 34,692,753                | 48,672,449                 | 100.0%          |

### Proposed Rewards (estimated)

|               | Coverage Points (estimated) | MOBILE Rewards (estimated) | % Total Rewards | MOBILE Rewards Change   |
| ------------- | --------------------------- | -------------------------- | --------------- | ----------------------- |
| CBRS          | 6,549,992                   | 21,193,170                 | 43.5%           | **-42.3%**              |
| Wi-Fi         | 8,492,786                   | 27,479,279                 | 56.5%           | **+130.6%**             |
| Total         | 15,042,778                  | 48,672,449                 | 100%            |                         |

### Estimates of Specific Radio Rewards

These estimates are derived from the estimated Modeled Coverage Points proposed in the Detailed Explanation above.

| Gateway                                                                                     | Radio Type             | MOBILE Rewards (current)          | MOBILE Rewards (estimated)         | Reduction |
| ------------------------------------------------------------------------------------------- | ---------------------- | --------------------------------- | ---------------------------------- | --------- |
| [Rare Amber Beetle](https://planner.hellohelium.com/hex/08c44a1b9431e1ff/radio/1711546)     | Baicells 436H Outdoor  | 47,847.56                         | 26,357.22                          | 44.9%     |
| [Little Grey Porpoise](https://planner.hellohelium.com/hex/08c29a56d066e7ff/radio/5190)     | Baicells 436H Outdoor  | 13,158.37                         | 7,205.69                           | 45.2%     |
| [Beautiful Caramel Ferret](https://planner.hellohelium.com/hex/08c2a100d87263ff/radio/1536) | Baicells 430i Outdoor  | 1,243.75                          | 682.71                             | 45.1%     |
| [Cool Ocean Mole](https://planner.hellohelium.com/hex/08c2830828a505ff/radio/2162886)       | Sercomm Indoor         | 1,477.14                          | 808.9                              | 45.2%     |


## Partial Reversal Option

While CBRS faces many technical and integration challenges, it’s important to acknowledge that **a) poor handoff performance to/from macro networks** and **b) the 2nd SIM requirement** are the main factors limiting the technology’s adoption, and that if both of these problems are solved, the utility of CBRS to the Network will drastically increase.

In the future, either **a) the community's rough consensus as determined by the Helium Foundation** or **b) a formal request from the Mobile Working Group** may compel the Helium Foundation launch a veMOBILE vote called “HIP 113 Partial Reversal” if all of the following conditions are met:

- A Service Provider representing at least 25% of active Subscriber NFTs on the Network is able to develop a single SIM/eSIM solution that enables subscriber devices to handoff from a macro network to CBRS radios and vice versa

- The SIM/eSIM is offered to all of the Service Provider’s US subscribers as part of its main Service offering

- The user experience of handing off to/from CBRS is indistinguishable to that of normal macro tower handoffs

Any disagreements or ambiguity regarding the criteria above shall be resolved by the outcome of the vote.

If the vote passes the standard voting threshold of 67%, the following Mobile Oracle Modeled Coverage Point changes should be enacted by the Helium Foundation, with assistance from Nova Labs, no later than 1 week after the vote concludes:

### Partial Reversal Changes to Modeled Coverage Points for Outdoor CBRS Radios

|                                          | Tier 1        | Tier 2                     | Tier 3                      | Tier 4           |
| ---------------------------------------- | ------------- | -------------------------- | --------------------------- | ---------------- |
| **Potential Signal Power**               | $P > -95 dBm$ | $-95 dBm \ge P > -105 dBm$ | $-105 dBm \ge P > -115 dBm$ | $P \le -115 dBm$ |
| **Potential Signal Level**               | High          | Medium                     | Low                         | None             |
| **Estimated coverage points (HIP 113)**  | 4            | 2                          | 1                           | 0                |
| **Estimated coverage points (HIP 113 Partial Reversal)** | **8**         | **4**                      | **2**                       | **0**            |

### Partial Reversal Changes to Modeled Coverage Points for Indoor CBRS Radios

|                                          | Tier 1     | Tier 2             |
| ---------------------------------------- | ---------- | ------------------ |
| **Location**                             | Inside hex | All adjacent hexes |
| **Potential Signal Level**               | High       | Low                |
| **Estimated coverage points (HIP 113)**  | 100        | 25                |
| **Estimated coverage points (HIP 113 Partial Reversal)** | **200**     | **50**             |

## Drawbacks

CBRS hotspot deployers will experience a substantial reduction in rewards. They may be unsatisfied with the change and may react in any number of ways, including turning off their radios.

## Rationale and Alternatives

As CBRS research and development progresses, it is likely that many of the technical and UX-related friction points will be solved in an incremental fashion. This process is likely to take years.

If the Network is successful in attracting large data usage via Wi-Fi coverage AND the addressable subscriber ratio of CBRS improves, CBRS radio deployers will be increasingly incentivized to deploy wide coverage in strategic locations in order to capture Data Transfer rewards.

If the utility of CBRS as measured by the parameters in this HIP increases drastically, a further HIP of similar nature should be considered in order to boost CBRS Proof of Coverage rewards.

### Alternative #1: Reduce CBRS Coverage Points by 50%

This alternative is not good because it perpetuates severely outsized rewards for CBRS given its low utility as described above.

### Alternative #2: Eliminate CBRS PoC Rewards

This alternative is not good because entirely removing potential rewards from CBRS radios will likely mean that the deployed fleet will shrink drastically, impairing the ability for Network participants to pursue research & development on a diverse fleet of radios in the wild.

### Alternative #3: Other Strategies to Improve Reward Distribution Efficacy

Other strategies such as HIP 103 (modifying PoC rewards based on urbanization, footfall and land type) are not true alternatives to this HIP, but rather complementary.

It's crucial for other strategies to be implemented alongside this HIP in order for Proof of Coverage rewards to be distributed in a way that's beneficial to growth of the Network's utility.

## Unresolved Questions

None.

## Deployment Impact

Implementation of this HIP is simple and will involve updating a few variables in the Mobile Oracle to calculate CBRS PoC rewards using the updated Modeled Coverage Points described above.

If this HIP passes, the Mobile Oracle shall be updated **30 epochs (30 days) after the vote ends**. Nova Labs will complete the implementation and deployment of this HIP, collaborating with Helium Foundation as required.

## Success Metrics

This HIP is successful if the number of Wi-Fi Hotspots being activated on the Network continues to outpace that of CBRS radios.
