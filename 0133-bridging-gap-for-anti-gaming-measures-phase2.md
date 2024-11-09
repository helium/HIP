# HIP 133: Bridging Gap for Anti-Gaming Measures Phase 2

* Authors: [Fizzy99](https://github.com/mrfizzy99), [Rendell](https://github.com/RendellD85)
* Start Date: 2024-09-05
* Category: Economic, Technical
* Original HIP PR: [#1087](https://github.com/helium/HIP/pull/1087)
* Tracking Issue: [#1087](https://github.com/helium/HIP/issues/1087)
* Voting Requirements: veMOBILE Holders

---

## Summary

This proposal aims to be a further refinement of HIP-131, and will further extend its scope to cover all areas that were not previously included (such as C** areas), along with other tweaks and changes.

## Related Prior HIPs
* [HIP 103: MOBILE Oracle Hex Boosting](./0103-oracle-hex-boosting.md)
* [HIP 118: Verification Mapping for MOBILE Network](./0118-verification-mapping.md)
* [HIP 125: Temporary Anti-Gaming Measures For Boosted Hexes](./0125-temporary-anti-gaming-measures-for-boosted-hexes.md)
* [HIP 131: Bridging Gap Between Verification Mappers and Anti-Gaming Measures](./0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md)

## Motivation

While the community thought that 'C' footfall areas would be less utilized for gaming activities, this was wrong, in practice. Gamers have found refuge in C footfall areas as the first phase of HIP-131 was implemented. Eventually, making a CDR requirement to activate Proof-of-Coverage rewards should become the norm for all location assertion but this HIP does not propose to make this change.

## Stakeholders

* Deployers: This preserves POI boosted rewards for legitimate and active coverage builders.
* Discovery Mappers: Who can enable CDR activity on affected hotspots.
* Service Providers: This provides a temporary tool to prevent abuse of POI boosted hexes, helping ensure these strategic regions have legitimate coverage and further improve implementation of HIP-118.

## Detailed Explanation

This HIP would enact the following:
- Extend the valid CDR requirement to apply to all areas (A**, B**, and C**) instead of just HIP-131 defined areas (A**, B**).
- Extend the implementation period of HIP-131 and this HIP until both phases of HIP-118 are fully implemented and active or for 150 epochs, which ever comes first.
- Allow "Verification Mapping" (HIP-118) to bypass the CDR requirement, including Boosted areas. This stipulation will be up to the Nova / Helium Mobile to implement and verify if Verification Mapping is a sufficient was to verify a hotspots general location. It is in no way a guarantee that any hotspot that is Verification Mapped will be able to bypass CDR requirements. However, this could help out rural areas that lack T-Mobile towers to create a CDR in the first place.
- Allow "Reward MOBILE Carrier Beta Hotspots" (HIP-134) to bypass the CDR requirement, including Boosted areas.

  How to generate a CDR:

  WiFi:
    - A phone must have a Helium Mobile service plan.
    - That same phone must have a Wi-Fi certificate corresponding to their account installed for that service plan, allowing the phone to connect to Helium Wi-Fi hotspots over Passpoint 2.0.
    - While in range and connected to both a Helium Hotspot Wi-Fi and a T-Mobile cell tower (having cellular connectivity), the phone must complete a few activities on the cellular side of the service. This includes texting and voice calls.
        - It should be noted that you must have Wi-Fi calling disabled and texts must not be iMessages, as both use the DATA line, which will inherently be the Wi-Fi connection at the time.
        - Preforming multiple activities is strongly recommended, and having a voice call go longer than 5 minutes is strongly advised to increase the chances of a successful CDR creation.

  CBRS:
    - A phone must have a Helium Mobile service plan.
    - That same phone must have a CBRS Beta eSIM corresponding to their account installed as the secondary line for data.
        - The CBRS Beta eSIM MUST be set in the "Cellular" settings as the line for Data, with "Cellular Switching" disabled to ensure that the regular Helium Mobile service plan does not override the CBRS connection for data.
        - The regular Helium Mobile service plan MUST be set as the default voice plan. This will allow the phone to connect to the T-Mobile towers for cellular activities.
    - While in range and connected to both a CBRS radio and a T-Mobile cell tower (having cellular connectivity), the phone must complete a few activities on the cellular side of the service. This includes texting and voice calls.
        - It should be noted that you must have Wi-Fi connection disabled, as the phone must be connected to the CBRS radio for data connection. Texts must not be iMessages as these go through as data, and not through the cellular towers.
        - Preforming multiple activities is strongly recommended, and having a voice call go longer than 5 minutes is strongly advised to increase the chances of a successful CDR creation.


## Drawbacks

No T-Mobile towers in rural (C**) footfall areas could cause issues with obtaining a CDR, however this is counteracted with the inclusion that Discovery Mapping will bring to

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
