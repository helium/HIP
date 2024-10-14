# HIP 133: Bridging Gap for Anti-Gaming Measures Phase 2

* Authors: [Fizzy99](https://github.com/mrfizzy99), [Rendell](https://github.com/RendellD85)
* Start Date: 2024-09-05
* Category: Economic, Technical
* Original HIP PR: [#1087](https://github.com/helium/HIP/pull/1087)
* Tracking Issue: [#1096](https://github.com/helium/HIP/issues/1096)
* Voting Requirements: veMOBILE Holders

---

## Summary

This proposal aims to be a further refinement of HIP-131, and will further extend its scope to cover all remaining areas that were not previously included (such as C** areas), along with other tweaks and changes.

## Related Prior HIPs
* [HIP 103: MOBILE Oracle Hex Boosting](./0103-oracle-hex-boosting.md)
* [HIP 118: Verification Mapping for MOBILE Network](./0118-verification-mapping.md)
* [HIP 125: Temporary Anti-Gaming Measures For Boosted Hexes](./0125-temporary-anti-gaming-measures-for-boosted-hexes.md)
* [HIP 131: Bridging Gap Between Verification Mappers and Anti-Gaming Measures](./0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md)

## Motivation

While the community thought that 'C' footfall areas would be less utilized for gaming activities, this was wrong, in practice. Gamers have found refuge in C footfall areas as the first phase of HIP-131 was implemented. Eventually, making a CDR requirement to activate Proof-of-Coverage rewards should become the norm for all location assertion but this HIP does not propose to make this change.

## Stakeholders

* Deployers: This preserves POI boosted rewards for legitimate and active coverage builders.
* Service Providers: This provides a temporary tool to prevent abuse of POI boosted hexes, helping ensure these strategic regions have legitimate coverage and further improve implementation of HIP-118.

## Detailed Explanation

This HIP would enact the following:
- Extend the valid CDR requirement to apply to all areas (A**, B**, and C**) instead of just HIP-131 defined areas (A**, B**).
- Adjust the valid CDR requirement to be once every 42 epochs.
- Require a valid CDR every 7 epochs for Boosted areas. If an invalid CDR is registered, it will invalidate the valid CDR. The Service Provider will be the final determination of qualifying events.
- Extend the implementation period of HIP-131 until both phases of HIP-118 are fully implemented and active (from 150 epochs).
- Allow Verification Mapping (HIP-118) to utilize CDR information for all areas, including Boosted areas.

## Drawbacks

Having a 42 epoch renewal may be viewed as counterintuitive, but this allows the network to filter out non-utilized hotspots from earning PoC for extended periods of time throughout the Hotspot's or Radio's lifetime.

## Unresolved Questions

None.

## Implementation

Nova Labs / Helium Mobile has agreed to the implementation of this proposal, which will begin immediately after a passing vote. A specific timeline on completion has not been communicated.

Mobile Oracles will report tagging of the Hotspots for suspicious activity by the Service Providers.  This off-chain data will record both tagging and untagging activities for the relevant Hotspots. This data will be publicly accessible with other oracle data.

Nova Labs has indicated they will use their existing support ticket system to manage deployers that feel they have been mistakenly identified as malicious, including an internal escalation procedure to help mitigate support tickets being left unaddressed indefinitely.

## Success Metrics

The desired outcome of this proposal is that Boosted areas are deployed with Hotspots that provide high quality, usable cellular coverage for customers of the MOBILE network and attract potential SPs.

Measuring the success of this proposal will require ongoing collaboration with the Service Providers to understand how many Hotspots are potentially flagged as malicious through community forums such as the Mobile Working Group.

Success of this proposal will be measured by the amount of discouragement of illegitimate deployments, and an increase of CDR data in legitimate Hotspots.
