# HIP 125: Temporary Anti-Gaming Measures For Boosted Hexes

- Author(s): [jhella](https://github.com/jhella) & [jaym2518](https://github.com/jaym2518)
- Start Date: 2024-05-20
- Category: Economic, Technical
- Original HIP PR: [#1017](https://github.com/helium/HIP/pull/1017)
- Tracking Issue: [#1022](https://github.com/helium/HIP/issues/1022)
- Vote Requirements: veMOBILE Holders

---

## Summary

This proposal outlines measures to invalidate boosted hex rewards for mobile hotspots that engage in malicious activity to earn boosted hex rewards on the MOBILE network.

## Related Prior HIPs

- [HIP 84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.

## Motivation

The Helium Community and Service Provider (SP) have identified hotspot operators that are engaging in malicious activity in order to earn boosted hex rewards without providing legitimate coverage to those hexes.

Although there are proposals and initiatives to programmatically identify and deter this malicious behavior, such as HIP 118, it is likely to take several months to reach consensus on these measures, complete a community vote, and execute implementation of the approved plan.

In the meantime, these malicious network operators eliminate the economic incentive for legitimate deployers to provide coverage in these highly strategic boosted hexes.  Additionally, they divert emissions from legitimate network operators, slowing the overall growth of the network.   

## Stakeholders

Deployers: This preserves boosted hex rewards for legitimate coverage builders.  In addition, prevents diversion of emissions from non-boosted hex deployers who are helping grow the network.

Service Providers: This provides a temporary tool to prevent abuse of SP boosted hexes helping ensure these strategic regions have legitimate coverage.  

## Detailed Explanation

HIP 84 created a framework for SPs to influence the growth of the Network in locations where data offload is most likely to happen.  This primarily involves SPs burning mobile to increase PoC rewards in resolution 12 hexes.  A hotspot operator earns rewards by providing mobile network coverage in these hexes.

HIP 84 has been largely successful given the rapid growth of coverage in regions such as Mexico and Miami, placing the MOBILE Network in a position to attract new service providers (e.g., Telefonica Movistar) and explore new business models (e.g., use of third party aggregators for Wi-Fi offloading).  However, the strong economic incentives that were required for this success attracts malicious actors to spoof or lie about their location to earn these rewards without providing legitimate coverage. 

This HIP provides a very narrow and simple scope:
- SPs can invalidate boosted rewards of a hotspot or radios if they have reasonable evidence the hexes they boosted are being taken advantage of by a malicious actor.
- An SP can only invalidate boosted rewards for hotspots in hexes they burned MOBILE to boost.  An SP can not invalidate another SP’s boosted hex rewards.  Note the invalidation is specific to the suspicious hotspot and not the hex.  Non-suspicious hotspots can still earn boosted rewards from said hex.
- Although a network operator may have its boosted rewards invalidated, it can still earn rewards for other PoC activities and data transfer.  Hotspots or radios are not banned.
- Deployers will open a support ticket with the SP if they feel they have been mistakenly identified as malicious.  This may involve, but not limited to, the SP attempting a physical verification of coverage at a given location which would involve a connection to a radio (Wi-Fi or CBRS) to verify its existence.  An SP that is willing to burn MOBILE to boost a hex is highly motivated to verify legitimate coverage is being provided to current and future customers.
- This HIP expires after 182 epochs (approximately 6 months) starting from formal HIP implementation. This gives the network time to implement a programmatic solution such as HIP 118.  However, the community can choose to extend this timeframe with a new vote if it feels sufficient progress has not been made on programmatic solutions.  It's suggested the community review the need for a vote several weeks ahead of expiration to provide time for deliberation and the general voting process.  Note that implementation of a programmatic solution would not reduce the 182 epoch duration. 

## Drawbacks

This proposal assumes that the SP is trustworthy and can exercise reasonable judgment to invalidate malicious actors. To mitigate this potential abuse, the HIP is limited to 6 months.  Also, an SP is required to stake 500m MOBILE when it joins the network, which can be slashed if the community believes an SP has acted in bad faith.

A hotspot operator could be mis-identified as a malicious actor.  This is mitigated by allowing the hotspot operator to appeal to the SP for a physical verification.  In addition, the hotspot will still be eligible for other PoC and data transfer rewards.

This HIP will not be able to address every edge case, but aims to mitigate the most egregious bad actors.

## Rationale and Alternatives

This HIP is meant as an interim measure while a permanent solution is implemented such as HIP 118.

The HIP was purposely designed to be as simple as possible with the narrowest possible scope since it's meant to be a quick, temporary solution to adapt to the ever evasive malicious actors.

## Unresolved Questions

None.

## Implementation

Mobile Oracles will report tagging of the hotspots for suspicious activity by the SPs.  This off-chain data will record both tagging and untagging activities for the concerned hotspots. This data will be shared in a way that community applications can allow a deployer to understand concerned hotspots have been flagged.

Current SP has indicated they will use their existing support ticket system to manage deployers that feel they have been mistakenly identified as malicious including an internal escalation procedure to help mitigate support tickets being left unaddressed indefinitely.

## Success Metrics

The desired outcome of this HIP is that boosted hexes are deployed with mobile hotspots that provide high quality, usable cellular coverage for customers of the MOBILE network and attract potential SPs.

Measuring success of this HIP will require ongoing collaboration with the SP to understand how many mobile hotspots are potentially flagged as malicious through community forums such as the mobile working group community.  Success could mean 50% of the mobile hotspots identified by the SP as malicious are invalidated.
