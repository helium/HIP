# HIP-xxx: Bridging Gap Between Verification Mappers and Anti-Gaming Measures

- Author(s): @Fizzy99
- Start Date: 2024-08-10
- Category: Economic, Technical
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veMOBILE Holders


## Related Prior HIPs:
[HIP 103: MOBILE Oracle Hex Boosting](https://github.com/helium/HIP/blob/main/0103-oracle-hex-boosting.md)

[HIP 118: Verification Mapping for MOBILE Network](https://github.com/helium/HIP/blob/main/0118-verification-mapping.md)

[HIP 125: Temporary Anti-Gaming Measures For Boosted Hexes](https://github.com/helium/HIP/blob/main/0125-temporary-anti-gaming-measures-for-boosted-hexes.md)


## Summary
This proposal amends HIP-125 (Temporary Anti-Gaming Measures For Boosted Hexes) to be extended to “Oracle Hex Boosts” (HIP-103 - MOBILE Oracle Hex Boosting) and further the expectations of HIP-118 (Verification Mapping for MOBILE Network). 
This extension (of HIP-125) when implemented in this HIP will be limited to Oracle Hex Boosts within POI areas, designated as A** and B** areas. Rewards for mobile hotspots that engage in malicious activity to earn the higher multiplier rewards of Oracle Hex Boosts or hotspots that have no CDR data will be reduced to a Oracle Hex Boost multiplier of 0.00x. Only one qualifing and/or accurate CDR is required to qualify for full rewards once again. 



## Motivation
Due to the ongoing and successful effort of HIP-125 to prevent gaming in SP Boosted Hexes until HIP-118 is fully implemented, malicious actors have moved their activities to areas outside SP Boosted areas but within the highest Oracle Hex Boosted areas that are unrealistic deployment locations. Normally with a 1.0x multiplier with little or no obstacle data to maximize rewards. 



## Stakeholders

Deployers: This preserves POI hex rewards for legitimate and active coverage builders.  
Service Providers: This provides a temporary tool to prevent abuse of POI hexes helping ensure these strategic regions have legitimate coverage and further improve implementation of HIP-118.



## Detailed Explanation

In order to combat new malicious activity and further bridge the gap between HIP-125 and the full implementation of HIP-118, this HIP will allow Service Providers to start cracking down outside of SP Boosted hexes but only within the highest earning areas of HIP-103 using the same CDR data and automations they have been using thus far for HIP-125 in preparation of the full implementation of HIP-118.
Unlike HIP-125 which only targets SP Boosted Hexes, this will target Oracle Hex Boost areas with Point of Interests (POI) areas within A** and B** areas.
Only *ONE* accurate CDR report is required to earn full PoC for the duration of the time that this HIP is active.

This HIP extends the scope of HIP-125 as follows:
- Network will be given 7 days for communication after passing on what EXACTLY they need to do in order to receive a qualifing and accurate CDR on their hotspots and/or radios. 
- PoC rewards of affected hotspots will be reduced to a Oracle Hex Boost multiplier of 0.00x on all hexes covered by that hotspot or radio if there is no qualifing and/or accurate CDR. 
- This HIP serves as a starting point for how rewards can be affected by the implementation of HIP-118, but less strict as only one qualifing and/or accurate CDR is required until HIP-118 phase-2 is implemented. 
- SPs can reduce the Oracle Hex Boosting multiplier of a hotspot or radios if they have reasonable evidence the POI hexes are being taken advantage of by a malicious actor (such as inaccurate an CDR).
- Although a network operator may have its Oracle Hex Boost multiplier reduced, it can still earn rewards by way of data transfer.  Hotspots or radios are not banned.
- Once a qualifing and/or accurate CDR is produiced, the hotspot/radio will return to its orginal Oracle Hex Boost multiplier after 1 epoch. 
- Deployers will open a support ticket with the SP if they feel they have been mistakenly identified as malicious. This may involve, but not limited to, the SP attempting a physical verification of coverage at a given location, which would involve a connection to a radio (Wi-Fi or CBRS) to verify its existence. 
- This HIP expires after 150 epochs (approximately 5 months) starting from formal HIP implementation. This gives the network time to implement a programmatic solution such as HIP-118.  However, the community can choose to extend this timeframe with a new vote if it feels sufficient progress has not been made on programmatic solutions.  It's suggested the community review the need for a vote several weeks ahead of expiration to provide time for deliberation and the general voting process.  Note that implementation of a programmatic solution would not reduce the 150 epoch duration.



## Drawbacks

This proposal assumes that the SP is trustworthy and can exercise reasonable judgment to invalidate malicious actors. To mitigate this potential abuse, the HIP is limited to 5 months.  Also, an SP is required to stake 500m MOBILE when it joins the network, which can be slashed if the community believes an SP has acted in bad faith.
This HIP will not be able to address every edge case, but aims to mitigate the most egregious bad actors and prepare for the effects of HIP-118.



## Unresolved Questions

None.



## Implementation

Mobile Oracles will report tagging of the hotspots for suspicious activity by the SPs.  This off-chain data will record both tagging and untagging activities for the concerned hotspots. This data will be shared in a way that community applications can allow a deployer to understand concerned hotspots have been flagged.
Current SP has indicated they will use their existing support ticket system to manage deployers that feel they have been mistakenly identified as malicious, including an internal escalation procedure to help mitigate support tickets being left unaddressed indefinitely.



## Success Metrics

The desired outcome of this HIP is that Oracle Hex Boosted areas are deployed with mobile hotspots that provide high quality, usable cellular coverage for customers of the MOBILE network and attract potential SPs.
Measuring the success of this HIP will require ongoing collaboration with the SP to understand how many mobile hotspots are potentially flagged as malicious through community forums such as the mobile working group community.
Success of this HIP will be measured by the amount of discouragement of illegitimate deployments, and an increase of CDR data in legitimate hotspots.

