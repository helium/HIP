# HIP ####: Reward MOBILE Carrier beta hotspots

- Author(s): [jhella](https://github.com/jhella)
- Start Date: 2024-09-22
- Category: Economic, Technical
- Original HIP PR: [TBD)
- Tracking Issue: [TBD)
- Vote Requirements: veMOBILE Holders

---

## Summary

This proposal outlines measures to reward and incentivize Helium Mobile hotspots for adding utility to the MOBILE network through participation in the MOBILE Carrier beta.

## Related Prior HIPs

- [HIP 131](https://github.com/helium/HIP/blob/main/0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md) created  Bridging Gap Between Verification Mappers and Anti-Gaming Measures.
- [HIP 103](https://github.com/helium/HIP/blob/main/0103-oracle-hex-boosting.md) created MOBILE Oracle Hex Boosting.
- [HIP 118](https://github.com/helium/HIP/blob/main/0118-verification-mapping.md) created Verification Mapping for MOBILE Network.

## Motivation

Helium Mobile, the first Service Provider on the MOBILE network, is currently in active beta trials with Tier-1 mobile network operators (MNOs) to provide carrier Wi-Fi offload services.

Currently, >1,000 hotspots are participating in the beta transferring >2 terabytes per day across >8,000 subscribers per day.  A significant amount of the data transferred is paid data resulting in HNT token burn.

Although these hotspots are providing significant utility to the network, they aren’t necessarily fully rewarded due to requirements from previously approved HIPs such as HIP 131, 103, 118, and 84.

This HIP aims to commensurately reward those hotspots for the utility they are providing the Helium ecosystem.  As a side benefit, this HIP may increase the incentives to deploy Helium Mobile hotspots in the MOBILE Carrier beta.

This HIP does not intend to drastically alter the current rewards frameworks for the MOBILE network.  This will likely be addressed in future HIPs where proof of coverage (PoC) rewards shift from modeled coverage to a more utility based model. 

## Stakeholders

Deployers: This rewards and increases the incentives to deploy hotspots into high value locations that add utility to the MOBILE network

Service Providers: This increases the coverage for the carriers participating in the MOBILE Carrier beta

## Detailed Explanation

Proposed Incentives for Hotspot Deployers

This HIP proposes two incentives for hotspot deployers if they meet the requirements detailed further below:

1. **Qualified hotspots** earn full Proof-of-Coverage (PoC) rewards regardless of whether they have a call detail record (CDR) or verification mapping event from a discovery mapper.  For example, a qualified hotspot would not have to meet the requirements of HIP 131 to earn full PoC.

2. **Qualified indoor hotspots** will automatically have an Oracle Multiplier of 1.00X regardless of its original multiplier.  

**Note:** Outdoor hotspots are out of scope for #2 because they generally earn more PoC than indoor hotspots.

Hotspots meeting the requirements below will be considered qualified for the purposes of this HIP:

- Hotspot has been selected for the MOBILE Carrier beta

- A hotspot serving >25 unique connections and >500MB per day on a seven day rolling average

## Drawbacks

Some hotspots may not be selected for MOBILE Carrier beta.  However, there are other ways to qualify for PoC rewards as described in HIPs such as 131 and 118.

## Rationale and Alternatives

This is intended to be a simple HIP that does not drastically alter the current rewards frameworks for the MOBILE network.

The number of unique connections and data transfer requirements could be scaled higher over time as higher performing hotspots participate in the MOBILE Carrier beta.

A Oracle Multiplier of 1.00X could be applied to outdoor hotspots versus limiting this benefit to indoor hotspots.

## Deployment Impact

Mobile Oracles will report tagging of hotspots as qualified so they earn full PoC.  This data will be shared in a way that community applications can allow a deployer to understand they met the requirements of this HIP.

This change may require code changes.  The scope of these code changes should be discussed with relevant parties, such as Nova Labs and Helium Foundation, through forums such as, Discord and Mobile Working Group (MWG) meetings, prior to HIP going for vote.

This section will be updated prior to vote once the implementation details have been aligned with the relevant parties.

## Success Metrics

This HIP will be considered a success if deployers adding utility earn full PoC rewards.

In addition, this HIP aims to incentivize a 50% increase in the amount of paid data across the network 6 months after implementation.
