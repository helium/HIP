# HIP 134: Reward MOBILE Carrier Beta Hotspots

- Author(s): [jhella](https://github.com/jhella)
- Start Date: 2024-10-07
- Category: Economic, Technical
- Original HIP PR: [#1091](https://github.com/helium/HIP/pull/1091)
- Tracking Issue: [#1098](https://github.com/helium/HIP/issues/1098)
- Voting Requirements: veMOBILE Holders

---

## Summary

This proposal outlines measures to reward and incentivize Hotspots for adding utility to the MOBILE network through participation in the MOBILE Carrier Beta.

## Related Prior HIPs

- [HIP 131](./0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md): Created anti-gaming measures for the MOBILE network
- [HIP 103](./0103-oracle-hex-boosting.md): Created MOBILE Oracle Hex Boosting.
- [HIP 118](./0118-verification-mapping.md): Created Verification Mapping for MOBILE Network.

## Motivation

Helium Mobile, the first Service Provider on the MOBILE network, is currently in active beta trials with Tier-1 mobile network operators (MNOs) to provide Carrier Wi-Fi offload services.

Currently, >1,000 Hotspots are participating in the beta transferring >2 terabytes per day across >8,000 subscribers per day.  A significant amount of the data transferred is paid data resulting in HNT token burn.

Although these Hotspots are providing significant utility to the network, they aren’t necessarily fully rewarded due to requirements from previously approved HIPs such as HIP 131, 103, 118, and 84.

This HIP aims to commensurately reward those Hotspots for the utility they are providing the Helium ecosystem.  As a side benefit, this HIP may increase the incentives to deploy Hotspots in the MOBILE Carrier beta.

This HIP does not intend to drastically alter the current rewards frameworks for the MOBILE network.  This will likely be addressed in future HIPs where Proof-of-Coverage (PoC) rewards shift from modeled coverage to a more utility based model.

## Stakeholders

* Deployers: This rewards and increases the incentives to deploy Hotspots into high value locations that add utility to the MOBILE network
* Service Providers: This increases the coverage for the carriers participating in the MOBILE Carrier beta

## Detailed Explanation

Proposed Incentives for Hotspot Deployers

This HIP proposes two incentives for Hotspot deployers if they meet the requirements detailed further below:

1. **Qualified Hotspots** earn full Proof-of-Coverage (PoC) rewards regardless of whether they have a call detail record (CDR) or verification mapping event from a discovery mapper.  For example, a qualified Hotspot would not have to meet the requirements of HIP 131 (or similiar CDR based HIPs) to earn full PoC.  Applies to outdoor and indoor wifi hotspots.

2. **Qualified Hotspots** will automatically have an Oracle Multiplier of 1.00X regardless of its original multiplier.  Applies to outdoor and indoor wifi hotspots.

Hotspots meeting the requirements below will be considered qualified for the purposes of this HIP:

- Hotspot has been selected for the MOBILE Carrier beta
- A Hotspot serving >25 unique connections and >500MB on a seven-day rolling average

Note: 50% of participating hotspots would meet the 25 unique connection requirements according to Nova Labs during the October 3, 2024 Mobile Working Group (MWG) call.

## Drawbacks

Some Hotspots may not be selected for MOBILE Carrier beta.  However, there are other ways to qualify for PoC rewards as described in HIPs such as 131 and 118.

## Rationale and Alternatives

This is intended to be a simple HIP that does not drastically alter the current rewards frameworks for the MOBILE network.

The number of unique connections and data transfer requirements could be scaled higher over time as higher performing Hotspots participate in the MOBILE Carrier beta.

An Oracle Multiplier of 1.00X could be applied to outdoor Hotspots versus limiting this benefit to indoor Hotspots.

## Deployment Impact

MOBILE Oracles will report tagging of Hotspots as qualified so they earn full PoC.  This data will be shared in a way that community applications can allow a deployer to understand they met the requirements of this HIP.

This change may require code changes.  The scope of these code changes should be discussed with relevant parties, such as Nova Labs and Helium Foundation, through forums such as, Discord and Mobile Working Group (MWG) meetings, prior to HIP going for vote.

This section will be updated prior to vote once the implementation details have been aligned with the relevant parties.

## Success Metrics

This HIP will be considered a success if deployers adding utility earn full PoC rewards.

In addition, this HIP aims to incentivize a 50% increase in the amount of paid data across the network 6 months after implementation.
