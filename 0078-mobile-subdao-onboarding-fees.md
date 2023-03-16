# HIP 78: MOBILE subDAO Onboarding Fees

- Author: @ferebee
- Start Date: 2023-03-10
- Category: Economic, Technical
- Original HIP PR: #580
- Tracking Issue: #582

# Summary

[HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) specifies the DAO Utility Score, which determines the distribution of HNT between all Helium subDAOs. The Hotspots of each subDAO count towards its Utility Score based on the onboarding fee set by that subDAO.

However, current MOBILE Hotspots, as introduced by FreedomFi, contain both an IOT Hotspot and a MOBILE Hotspot. While HIP-53 specifies that MOBILE Hotspots should burn a $40 onboarding fee, just like IOT Hotspots, the existing implementation only onboarded the IOT network component. All active MOBILE Hotspots have been onboarded to the IOT network, but no separate onboarding process for the MOBILE network was ever implemented.

As a result, no onboarding fees have yet been burned towards the MOBILE subDAO.

This prevents the tokenomics based on DAO Utility Score, as defined in HIP-51, from working as designed.

HIP-78 solves this problem by requiring that Hotspots participating in a particular Helium subDAO must burn an onboarding fee towards that subDAO. The MOBILE subDAO onboarding fee has been set at $40 by HIP-53. In the future, fee schedules will be determined by subDAO governance.

A mechanism is specified whereby the existing MOBILE Hotspots may be onboarded retroactively.

Location assertion fees, if any, are determined by subDAO governance.

# Motivation

The current situation impairs the growth of the Helium MOBILE subDAO by artificially suppressing its DAO Utility Score, limiting the HNT emitted to the MOBILE subDAO treasury, the value of the MOBILE tokens earned by MOBILE Hotspots, and thereby the incentive to grow the MOBILE network.

On the other hand, the IOT subDAO would benefit if the MOBILE Hotspots, including those which are already online, pay appropriate onboarding fees for the privilege of joining the Helium DAO, rather than being counted despite not paying any fee, as is the case under the current implementation. The HNT burn from their fees will contribute additional value to the entire HNT/DNT ecosystem, including the IOT subDAO.

As the Helium DAO grows, new devices may be introduced that participate in multiple current and future subDAOs at once. Both the IOT and the MOBILE subDAOs will benefit if appropriate onboarding fees are paid to all subDAOs involved.

# Stakeholders

This proposal is relevant to:

- Existing and future IOT and MOBILE Hotspot owners, who are affected by the clarification of fees and the MOBILE DAO Utility Score.
- MOBILE Hotspot manufacturers, who may need to budget for onboarding fees as decided by the MOBILE subDAO.
- Anyone contributing to the design of the MOBILE subDAO or a future subDAO.

# Detailed Explanation

## Utility Score

HIP-51 introduces the [DAO Utility Score](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model), which determines the proportion of HNT emissions distributed to each subDAO.

HIP-53 describes a [$40 onboarding fee](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview) and $10 location assertion fee, analogous to IOT Hotspots. However, the gateways developed by FreedomFi and used to launch the MOBILE network, as well as models introduced by other manufacturers, include both IOT and MOBILE Hotspot functions, which operate independently. In the existing implementation, the IOT Hotspot component is onboarded in the same way as all other Helium IOT Hotspots, with a $40 onboarding fee and optionally a $10 location assert. The MOBILE Hotspot component itself currently performs no onboarding operation of its own, but it is treated as if it were onboarded nonetheless.

As a result, no onboarding fee has ever been burned towards the MOBILE subDAO. The [DAO Utility Score](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) is defined in HIP-51 as

$\text{DAO Utility Score} = V \times D \times A$

where

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

As a result, the A component is currently 1 for the MOBILE subDAO, as no onboarding fees (a. k. a. Activation Fees) have yet been burned.

With the implementation of HIP-70, a separate rewardable entity will be created for each subDAO a Hotspot takes part in, and the onboarded components of each Hotspot will be counted separately towards the DAO Utility Score. Maker apps onboarding Hotspots after transition will allow the Hotspot operator to select which subDAO(s) to onboard to, and burn a fee to each subDAO accordingly.

In the future, devices may be introduced that participate in many different subDAOs simultaneously, such as IOT, MOBILE, future networks such as Wi-Fi, and other services such as dVPN or storage networks. In some cases, it may become possible to onboard existing Hotspots to new subDAOs, through software or hardware upgrades.

## Location Assertion Fees

Most, but not all, MOBILE Hotspots have burned location assertion fees, which are required by the IOT subDAO before a Hotspot may receive rewards. The existing implementation supports a single location fee per physical Hotspot.

With the implementation of HIP-70, the separate rewardable entities that may be contained within a single physical Hotspot will each support a separate location assertion fee, so that subDAOs may define their location assertion fees independently.

While the location assertion fee serves an important function in the IOT subDAO, as it prevents arbitrary relocation of Hotspots, which would interfere with IOT PoC, the MOBILE subDAO does not have the same need for a location assertion fee, as the location of a MOBILE Hotspot is asserted in other ways, such as through registration with the SAS. In the existing implementation, no separate assertion fee has been burned by MOBILE Hotspots towards the MOBILE subDAO.

# Provisions

To ensure that all participating Hotspots contribute appropriately to the Helium DAO, we propose the following provisions.

## Independent Onboarding

If a Hotspot participates in one or more Helium subDAOs, it must be onboarded to each subDAO individually, and the onboarding fee in DC as set by each subDAO must be accordingly burned separately towards that subDAO.

## DAO Utility Score

As specified in HIP-51, each Hotspot contributes to the DAO Utility Score of its subDAO according to its onboarding fee. For the purposes of this calculation, Hotspots which participate in multiple subDAOs shall be considered as multiple independent Hotspots, one for each subDAO, and each shall contribute separately to the DAO Utility Score of its subDAO with the onboarding fee burned towards that subDAO. No onboarding fee shall be double-counted towards multiple subDAOs.

## Fees Are Decided By subDAOs

Each subDAO may set a schedule of onboarding and location assertion fees for its participating Hotspots through subDAO governance. All fees must be paid in DC burn from HNT according to procedures specified by the Helium DAO.

Subject to change through subDAO governance by the MOBILE subDAO, the onboarding fee per MOBILE Hotspot to the MOBILE subDAO is $40 as defined in HIP-53, independent of other subDAO onboarding fees paid by the same Hotspot, such as the $40 IOT network onboarding fee that has been paid by the IOT component of existing MOBILE Hotspots under the current implementation.

## Location Assertion

In the HIP-70 implementation, Hotspots must pay a location assertion fee towards each subDAO in order to participate in rewards in that subDAO. The fee is set through subDAO governance, and may be $0.

HIP-78 does not change the location assertion fee for IOT subDAO Hotspots as defined at the launch of the Helium network and modified by HIP-69. It may be modified in the future through IOT subDAO governance.

The separate location assertion fee for MOBILE Hotspots, which must be paid per Hotspot onboarded under HIP-70, but was never assessed under the existing implementation, shall be deemed to have been defined by the MOBILE subDAO as $0 until defined otherwise through MOBILE subDAO governance.

## Paying the Missing MOBILE Onboarding Fees

In cooperation with Hotspot manufacturers, Helium Foundation may perform one or several one-time burn operations which cover, in total, the $40 onboarding fee for each MOBILE Hotspot which has been onboarded to the IOT network under the existing implementation, and thus neglected to pay for onboarding to the MOBILE subDAO. Once these fees are paid, a corresponding number of MOBILE Hotspots shall be considered, for the purpose of the DAO Utility Score, to be onboarded to the MOBILE network.

# Drawbacks

This proposal may require Hotspot manufacturers and therefore, indirectly, Hotspot owners, to pay additional fees towards the Helium DAO. These fees have not been assessed to date, although they are specified by existing HIPs.

# Benefits

- Under this proposal, all subDAOs will contribute onboarding fees to the Helium DAO, and in return will obtain a DAO Utility Score as defined by HIP-51. Rules for Hotspots participating in multiple subDAOs are clarified, including subDAOs which may be introduced in the future as upgrades to existing Hotspot hardware.
- Onboarded MOBILE Hotspots will be counted towards the MOBILE DAO Utility Score as specified in HIP-53, provided manufacturers and/or other parties successfully coordinate with Helium Foundation to pay the outstanding fees.

# Deployment Impact

Implementation will be simplified if the fees for existing MOBILE Hotspots can be paid retroactively, as that will remove the requirement to distinguish between Hotspots that have or have not paid an onboarding fee. The design currently being implemented already supports all necessary features.

# Clarification

To resolve any ambiguity in HIP-51, the distribution of HNT to subDAOs is clarified as follows.

- The Helium DAO HNT emissions contract distributes HNT to HST holders as specified in HIP-20.
- All remaining HNT is distributed between all subDAOs in proportion to their relative DAO Utility Scores.
- Rewards to individual Hotspots for PoC and Data Transfer are issued in DNT according to the reward schedules defined for each subDAO, which may be modified through subDAO governance.
