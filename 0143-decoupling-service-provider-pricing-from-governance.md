# HIP 143: Decoupling Service Provider Pricing from Governance

- Author: [inversioncapital](https://github.com/inversioncapital), [zer0tweets](https://github.com/zer0tweets), [Nova Labs](http://nova.xyz), [ferebee](https://github.com/ferebee)
- Start Date: 2025-01-29
- Category: Economic, Technical
- Original HIP PR: [#1153](https://github.com/helium/HIP/pull/1153)
- Tracking Issue: [#1155](https://github.com/helium/HIP/issues/1155)
- Voting Requirements: veHNT holders

---

## Summary

This HIP authorizes Nova Labs to negotiate the total cost of Data Transfer paid to the Helium Network by Nova offload partners, and by independent Service Providers, without involving Helium governance.

The nominal cost of data remains at $0.50/GB as defined in [HIP-53][hip-53], but Nova Labs may adjust the proportion of Rewarded vs. Unrewarded Data as needed as defined in [HIP 129][hip-129].

The provisions of this HIP will remain in effect initially for 1 year from implementation.

## Motivation

The Helium Network is currently used by multiple network operators in the U.S. and one in Mexico, with more expected to join. Each network operator has its own pricing model for Wi-Fi data. Some pay per gigabyte (GB), others pay a flat rate per month, and some set limits on a per-user or per-plan basis.

Meanwhile, the Helium Network pays Hotspots a fixed rate of $0.50 per GB of Data Transfer. Creating separate pricing models for each provider through governance votes would be complex and time-consuming.

This proposal allows Nova Labs to negotiate agreements with network operators independently, while paying for usage of the Helium Network at $0.50 per GB, as outlined in [HIP-27][hip-27] and [HIP-53][hip-53]), and applying Rewardable Data rules as introduced with [HIP-82][hip-82]).

The pricing of mobile offload agreements is complex and often confidential. If Nova Labs would be able to move quickly and aligned with overall network goals, without involving Helium governance, the authors of this HIP anticipate that the total Data Transfer of the Helium network will rise. Nova and the Helium community benefit equally from increased Data Transfer.

## Stakeholders

This HIP affects:
- International mobile users seeking affordable cellular services
- Hotspot owners globally who will benefit from increased network usage
- Holders of HNT tokens through increased utility and adoption
- The Helium Mobile Network through expanded global presence

## Detailed Explanation

Nova Labs already manages contracts with several U.S. network operators, who pay varying rates and apply different data caps based on their internal policies. Nova Labs then converts dollar payments into HNT that is burned for Data Credits, ensuring the Helium Network is paid $0.50 per GB of Rewardable Data. Nova Labs also manages subscriber Rewardable Data caps to align with [HIP-82][hip-82] and [HIP 129][hip-129] rules. 

This proposal would extend this established process to Mexico and other countries. It would adapt the existing Rewardable Data framework, allowing Nova Labs to manage total data cost for each network operator and Service Provider in alignment with negotiated terms.

The authority given by this HIP to Nova Labs will remain in effect for one year from implementation, and will be extended for one additional year if no HIP is passed by Helium governance that determines otherwise. 

## Implementation

We leave the implementation of the smart contract components, verifiability, and network operator compliance up to the Helium Core Developers to determine.

## Success Metrics

The success metric for this HIP is cellular data being offloaded to the Helium Mobile Network by network operators outside of the U.S., creating increased utility for HNT.

[hip-27]: ./0027-cbrs-5g-support.md
[hip-53]: ./0053-mobile-dao.md
[hip-82]: ./0082-helium-mobile-service-provider.md
[hip-129]: ./0129-mobile-carrier-beta.md
