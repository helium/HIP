# HIP-131: Bridging Gap Between Verification Mappers and Anti-Gaming Measures

- Author(s): [Fizzy99](https://github.com/mrfizzy99), [JD](https://github.com/bigbuffer), [Rendell](https://github.com/RendellD85)
- Start Date: 2024-08-15
- Category: Economic, Technical
- Original HIP PR: [#1070](https://github.com/helium/HIP/pull/1070)
- Tracking Issue: [#1072](https://github.com/helium/HIP/issues/1072)
- Voting Requirements: veMOBILE Holders

---

## Summary

This proposal amends the measures in HIP-125 (Temporary Anti-Gaming Measures For Boosted Hexes) to be extended to “Oracle Hex Boosts” (HIP-103 - MOBILE Oracle Hex Boosting) and furthers the expectations of HIP-118 (Verification Mapping for MOBILE Network). 

This extension (of HIP-125) when implemented, will be limited to Oracle Hex Boosts within Point of Interests (POI) areas that are currently designated as A** and B** areas. Rewards for MOBILE Hotspots that engage in malicious activity to earn the higher multiplier rewards of Oracle Hex Boosts or Hotspots that have no Call Detail Records (CDR data is classified as calls, texts, messages and data transfer), will be reduced to a Oracle Hex Boost multiplier of 0.00x. Only one qualifing and/or accurate CDR is required to qualify for full rewards again.

## Related Prior HIPs

* [HIP 103: MOBILE Oracle Hex Boosting](https://github.com/helium/HIP/blob/main/0103-oracle-hex-boosting.md)
* [HIP 118: Verification Mapping for MOBILE Network](https://github.com/helium/HIP/blob/main/0118-verification-mapping.md))
* [HIP 125: Temporary Anti-Gaming Measures For Boosted Hexes](https://github.com/helium/HIP/blob/main/0125-temporary-anti-gaming-measures-for-boosted-hexes.md)

## Motivation

Due to the ongoing and successful effort of HIP-125 to prevent gaming in Service Provider Boosted Hexes and as HIP-118 is not yet implemented, malicious actors have moved their activities to areas outside Service Provider Boosted areas but within the highest Oracle Hex Boosted areas that are unrealistic deployment locations. These locations are normally with a 1.0x multiplier with little or no obstacle data to maximize rewards. 

## Stakeholders

* Deployers: This preserves Point of Interests (POI) hex rewards for legitimate and active coverage builders.
* Discovery mappers: Who can enable CDR activity on affected hotspots.
* Service Providers: This provides a temporary tool to prevent abuse of Point of Interests (POI) hexes helping ensure these strategic regions have legitimate coverage and further improve implementation of HIP-118.

## Detailed Explanation

In order to combat new malicious activity and further bridge the gap between HIP-125 and the full implementation of HIP-118, this HIP will allow Service Providers to start affecting gaming outside of Service Provider Boosted hexes but only within the highest earning areas of HIP-103 using the same Call Detail Record (CDR) data and automations they have been using thus far for HIP-125, in preparation of the full implementation of HIP-118.

Unlike HIP-125 which only targets Service Provider Boosted Hexes, this will target Oracle Hex Boost areas with [Point of Interests (POI) areas that are currently designated as A** and B** areas.](https://github.com/helium/HIP/blob/main/0103-oracle-hex-boosting.md#detailed-explanation) 

Only *ONE* accurate CDR report after the most recent location assertion is required to earn full PoC rewards for the duration of the time that this HIP is active.

This HIP extends the scope of HIP-125 as follows:
- Deployers and Discovery Mappers will be given 7 days advance notice of HIP-131 deployment by Nova/Helium Mobile via Discord Announcements and Push Notifications to both Helium Mobile and Helium Builder apps; informing on how critical deployers and mappers roles are to this new form of mapping and PoC together, and what actions to take in order to receive or give a qualifing and accurate Call Detail Record (CDR) on theirs or other deployers Hotspots/radios.
- CBRS Radios are given an extra 21 epochs after the first initial advance notice of HIP-131 from Helium Mobile and Nova, to allow more time for deployers and potential mappers to install the CBRS Beta SIM in order to create a CDR for CBRS radios. 
- PoC rewards of affected Hotspots will be reduced to by a Oracle Hex Boost multiplier of 0.00x on all hexes covered by that Hotspot or radio if there is no qualifing and/or accurate CDR. 
- This HIP serves as a starting point for how rewards can be affected by the implementation of HIP-118, but less strict as only one qualifing and/or accurate CDR is required until HIP-118 phase-2 is implemented. 
- Although a network operator's Hotspot may have its Oracle Hex Boost multiplier reduced, it can still earn rewards by way of data transfer.  Hotspots or radios are not banned or denied.
- Once a qualifing and/or accurate CDR is produced, the Hotspot/radio will return to its original Oracle Hex Boost multiplier after 1 epoch.
- Reasserting a Hotspot/radio will reset the CDR, and another qualifing and/or accurate CDR will be required for the new location.
- SPs can reduce the Oracle Hex Boosting multiplier of a Hotspot or radios if they have reasonable evidence the POI hexes are being taken advantage of by a malicious actor (such as an inaccurate CDR).
- Deployers can open a support ticket with the SP if they feel they have been mistakenly identified as malicious. This may involve, but not be limited to, the SP attempting a physical verification of coverage at a given location, which would involve a connection to a radio (Wi-Fi or CBRS) to verify its existence. 
- This HIP expires after 150 epochs (approximately 5 months) starting from the community HIP implementation notification. This gives the network time to implement a programmatic solution such as HIP-118.  However, the community can choose to extend this timeframe with an additional HIP-131 extension vote if it feels sufficient progress has not been made on programmatic solutions.  It's suggested the community review the need for a vote several weeks ahead of expiration to provide time for deliberation and the general voting process.  Note that implementation of a programmatic solution would not reduce the 150 epoch duration.

## Drawbacks

This proposal assumes that the Service Provider is trustworthy and can exercise reasonable judgment to invalidate malicious actors. To mitigate this potential abuse, the HIP is limited to 5 months.  Also, an SP is required to stake 500m MOBILE when it joins the network, which can be slashed if the community believes an SP has acted in bad faith.

This HIP will not be able to address every edge case, but aims to mitigate the most egregious bad actors and prepare for the effects of HIP-118.

## Unresolved Questions

None.

## Implementation

Nova Labs and Helium Mobile have agreed to the implementation of this proposal but have not indicated a timeline. 

Mobile Oracles will report tagging of the hotspots for suspicious activity by the SPs.  This off-chain data will record both tagging and untagging activities for the concerned hotspots. This data will be shared in a way that community applications can allow a deployer to understand concerned hotspots have been flagged.

The current SP has indicated they will use their existing support ticket system to manage deployers that feel they have been mistakenly identified as malicious, including an internal escalation procedure to help mitigate support tickets being left unaddressed indefinitely.

## Success Metrics

The desired outcome of this HIP is that Oracle Hex Boosted areas are deployed with mobile hotspots that provide high quality, usable cellular coverage for customers of the MOBILE network and attract potential SPs.

Measuring the success of this HIP will require ongoing collaboration with the SP to understand how many mobile hotspots are potentially flagged as malicious through community forums such as the mobile working group community.

Success of this HIP will be measured by the amount of discouragement of illegitimate deployments, and an increase of CDR data in legitimate hotspots.
