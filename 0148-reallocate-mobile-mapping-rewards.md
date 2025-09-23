# HIP 148: Reallocate Mobile Mapping Rewards

- Author: [@madninja](https://github.com/madninja)
- Start Date: 2025-09-23
- Category: Economic, Technical
- Original HIP PR: [#1186](https://github.com/helium/HIP/pull/1186)
- Tracking Issue: [#1187](https://github.com/helium/HIP/issues/1187)
- Voting Requirement: veHNT Holders

---

## Summary

Currently, a total of 20% of the HNT emissions to the Mobile network are reserved for Mobile Mapping rewards, with 10% allocated in defined in [HIP-53][hip-53] and an additional 10% moved from Service Provider Rewards in [HIP-79][hip-79] and a more detailed breakdown for Verification Mapping in [HIP-118][hip-118].

Since the launch of Helium Mobile the number of mobile mappers has grown significantly, but it has struggled to provide the impact the original HIP intended to achieve. This HIP proposes to move the 10% reservation of emissions for Mobile Mapping back Service Provider Rewards and the original 10% into the Data Rewards Pool.

For completeness, [HIP-79][hip-79], and [HIP-118] are effectively repealed with this HIP with [HIP-53][hip-53] adjusted to move the 10% reservation for Mobile Mapping to Data Rewards.

Since subscriber rewards are no longer focused on crypto rewards the crypto based user incentive programs which got allocations out of the Service Provider Rewards Pool in [HIP-114][hip-114] will also be repealed.

## Motivation

The issues with Mobile Mapping include:

1. The complexity of maintaining software that shares location regularly on highly variable handsets. Battery, memory, CPU impact with slow feedback to end users have plagued the system from the start.
2. The ongoing sophistication of the mapping gaming techniques to maximize mapping rewards by gaming location data. This has polluted the mapping data set substantially, which has caused more work to clean up the data.
3. Verification mapping, where an active Helium Mobile mapper connects to a Helium Mobile Hotspot has only been observed in under 5% of all mapping data. This number is even lower if the forced hotspot CDR verification methods required for PoC rewards is excluded.
4. The number of Helium Mobile subscribers turning off mapping is quite high given the impact on battery and the lack of clear benefit to the end user once the focus shifted to normal, non crypto subscribers.
5. While the mapping data set has been used in an "observed demand" layer on Helium World, it has not been very useful in guiding deployers to locations to deploy at. This is partially due to polluted data sets, but mostly because carrier offload locations are a much higher quality signal of where to deploy than mapping data.

## Stakeholders

This proposal affects:

- Legacy Crypto Mappers which would lose their mapping rewards. The upside is they retain a competitive cell phone plan.
- Helium Mobile would see the rewards shift from per subscriber mapping rewards to a simpler Service Provider rewards model.
- Subscriber Referral Programs which will be terminated as part of this HIP.

## Detailed Explanation

Under this proposal, 10% reservation of HNT emissions for Mobile Mapping would move back to the Service Provider Rewards Pool. The other 10% would be moved to the Data Rewards Pool.

The Incentive Escrow Fund would be terminated but this would not affect existing Service Provider Rewards, and simplifies on chain accounting and behavior.

### Repeal of HIP-79, HIP-118, and HIP-114

[HIP-79][hip-79] defined the increase of the Mobile Mapping Rewards by allocating an additional 10% of emissions from Service Provider Rewards to Mobile Mapping rewards. [HIP-118][hip-118] defined a more granular breakdown of the Mobile Mapping rewards to include Verification Mapping behavior. [HIP-114][hip-114] defined a mechanism for Service Providers to allocate portions of Service Provider Rewards to Referral like programs.

This HIP will remove the need for these three HIPs. Future systems for Verification Mapping like behavior will be defined as needed and could be achieved without a rewards system.

### Adjustment to HIP-53

[HIP-53][hip-53] defined the original 10% reservation of HNT emissions to Mobile Mapping rewards. This HIP will adjust the reservation to move the 10% to the Data Rewards Pool.

## Drawbacks

- User Demand data for Helium Mobile will not be available in the same form. This is mitigated by getting a much larger volume of high quality tower based data to infer both valid subscriber activity and approximate demand areas.

## Unresolved Questions

## Deployment Impact

Core developers will complete the implementation of this HIP on approval.

[hip-53]: https://github.com/helium/HIP/blob/main/0053-mobile-dao.md
[hip-79]: https://github.com/helium/HIP/blob/main/0079-increase-mobile-mapping-rewards.md
[hip-118]: https://github.com/helium/HIP/blob/main/0118-mobile-verification-mapping.md
[hip-114]: https://github.com/helium/HIP/blob/main/0114-mobile-referral-programs.md
