# HIP XX: subDAO Onboarding Fees

- Author(s): @ferebee
- Start Date: 2023-03-10
- Category: Economic, Technical
- Original HIP PR: #XX
- Tracking Issue: #XX

# Summary

Since HIP-51 and HIP-53 were passed, thousands of Helium 5G radios have come online.

[HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) specifies the DAO Utility Score, which determines the distribution of HNT between all Helium subDAOs. The hotspots of each subDAO count towards its Utility Score based on the onboarding fee set by that subDAO.

However, current 5G hotspots, as introduced by FreedomFi, contain both a LoRa and a 5G hotspot. While HIP-53 specifies that 5G hotspots should  burn a $40 onboarding fee, just like LoRa hotspots, the existing implementation only onboarded the LoRa component. All active 5G hotspots have been onboarded to LoRa, but no separate onboarding process for 5G was ever implemented.

As a result, no onboarding fees have yet been burned towards the 5G subDAO.

This prevents the tokenomics based on DAO Utility Score, as defined in HIP-51, from working as designed.

HIP-XX solves this problem by requiring that hotspots participating in a particular Helium subDAO must burn an onboarding fee towards that subDAO. Specific fee schedules will be determined by subDAO governance. A mechanism is specified whereby the existing 5G hotspots may be onboarded retroactively.

# Motivation

The current situation impairs the growth of the Helium 5G subDAO by artificially suppressing its DAO Utility Score, limiting the HNT emitted to the 5G treasury, the value of the MOBILE tokens earned by 5G hotspots, and thereby the incentive to grow the Helium 5G network.

On the other hand, the LoRa subDAO would benefit if the 5G hotspots, including those which are already online, pay appropriate onboarding fees for the privilege of joining the Helium DAO, rather than being counted despite not paying any fee, as is the case under the current implementation. The HNT burn from their fees will contribute additional value to the entire HNT/DNT ecosystem, including the LoRa subDAO. 

As the Helium DAO grows, new devices may be introduced that participate in multiple current and future subDAOs at once. Both the LoRa and the 5G subDAOs will benefit if appropriate onboarding fees are paid to all subDAOs involved.

# Stakeholders

This proposal is relevant to:

- Existing and future LoRa and 5G hotspot owners, who are affected by the clarification of fees and the 5G DAO Utility Score.
- 5G hotspot manufacturers, who may need to budget for onboarding fees as decided by the 5G subDAO.
- Anyone designing a future subDAO.

# Detailed Explanation

HIP-51 introduces the [DAO Utility Score](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model), which determines the proportion of HNT emissions distributed to each subDAO.

HIP-53 describes a [$40 onboarding fee](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview) and $10 location assertion fee, analogous to LoRa hotspots. However, the gateways developed by FreedomFi and used to launch the Helium 5G network, as well as models introduced by other manufacturers, include both LoRa and 5G hotspot functions, which  operate independently. In the existing implementation, the LoRa component is onboarded in the same way as all other Helium LoRa hotspots, with a $40 onboarding fee and optionally a $10 location assert. The 5G component itself currently performs no onboarding operation of its own, but it is treated as if it were onboarded nonetheless.

As a result, no onboarding fee has ever been burned towards the 5G subDAO. The [DAO Utility Score](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) is defined in HIP-51 as

$\text{DAO Utility Score} = V \times D \times A$

where

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

As a result, the A component is currently 1 for the 5G subDAO, as no onboarding fees (a. k. a. Activation Fees) have yet been burned.

With the implementation of HIP-70, a separate rewardable entity will be created for each subDAO a hotspot takes part in, and the onboarded components of each hotspot will be counted separately towards the DAO Utility Score. Maker apps onboarding hotspots after transition will allow the hotspot owner to select which subDAO(s) to onboard to, and burn a fee to each subDAO accordingly.

In the future, devices may be introduced that participate in many different subDAOs simultaneously, such as LoRa, 5G, future networks such as Wi-Fi, and other services such as dVPN or storage networks. In some cases, it may become possible to onboard existing hotspots to new subDAOs, through software or hardware upgrades.

To ensure that all participating hotspots contribute appropriately to the various DAO Utility Scores, we propose the following provisions.

# Provisions

### Independent Onboarding

If a hotspot participates in one or more Helium subDAOs, it must be onboarded to each subDAO individually, and the onboarding fee in DC as set by each subDAO must be accordingly burned separately towards that subDAO.

### DAO Utility Score

As specified in HIP-51, each hotspot contributes to the DAO Utility Score of its subDAO according to its onboarding fee. For the purposes of this calculation, hotspots which participate in multiple subDAOs shall be considered as multiple independent hotspots, one for each subDAO, and each shall contribute separately to the DAO Utility Score of its subDAO with the onboarding fee burned towards that subDAO. No onboarding fee shall be double-counted towards multiple subDAOs.

### Fees Are Decided By subDAOs

Each subDAO may set a schedule of onboarding fees for its participating hotspots through subDAO governance. All onboarding fees must be paid in DC burn from HNT according to procedures specified by the Helium DAO.

Subject to change through subDAO governance by the 5G subDAO, the onboarding fee per Helium 5G hotspot to the 5G subDAO is $40 as defined in HIP-53, independent of other subDAO onboarding fees paid by the same hotspot, such as the $40 LoRa onboarding fee that has been paid by the LoRa component of existing 5G hotspots under the current implementation. 

### Paying the Missing 5G Onboarding Fees

In cooperation with hotspot manufacturers, Helium Foundation may perform one or several one-time burn operations which cover, in total, the $40 onboarding fee for each 5G hotspot which has been onboarded to LoRa under the existing implementation, and thus neglected to pay for onboarding to the 5G subDAO. Once these fees are paid, a corresponding number of 5G hotspots shall be considered, for the purpose of the DAO Utility Score, to be onboarded to the 5G subDAO.

# Drawbacks

This proposal may require hotspot manufacturers and therefore, indirectly, hotspot owners, to pay additional fees towards the Helium DAO. These fees have not been assessed to date, although they are specified by existing HIPs.

# Benefits

- Under this proposal, all subDAOs will contribute onboarding fees to the Helium DAO, and in return will obtain a DAO Utility Score as proposed in HIP-51. Rules for hotspots participating in multiple subDAOs are clarified, including subDAOs which may be introduced in the future as upgrades to existing hotspot hardware.
- Onboarded 5G hotspots will be counted towards the 5G DAO Utility Score as intended by HIP-53.

# Deployment Impact

Implementation will be simplified if the fees for existing 5G hotspots can be paid retroactively, as that will remove the requirement to distinguish between hotspots that have or have not paid an onboarding fee. The design currently being implemented already supports all necessary features.

# Clarification

To resolve any ambiguity in HIP-51, the distribution of HNT to subDAOs is clarified as follows. The Helium DAO HNT emissions contract distributes HNT to HST holders as specified in HIP-20. All remaining HNT is distributed between all subDAOs in proportion to their relative DAO Utility Scores. Rewards to individual hotspots for PoC and Data Transfer are issued in DNT according to the reward schedules defined for each subDAO, which may be modified through subDAO governance.




