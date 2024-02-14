HIP-xxx - Pause-SP-Hex-Boosting-Rewards-for-Indoor-WiFi

- Author(s): @mrfizzy99 (Fizzy99 - Fiz-Tech.net)
- Contributor(s): @0lav (SaintOlav), @capjbadger007 (ElonTusk) , @bigbuffer (JD - Moken) , Max Gold (GoldHawksAssociates)
- Start Date: 2024/02/13
- Category: Economic and Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

- Currently, the Helium MOBILE network has a security flaw that allows indoor wifi AP to be placed without a high degree of certainty that the AP is actually in its stated location.  This HIP aims to pause Hex Boosting that was passed in HIP-84 for indoor wifi APs until a rework can be completed in a future HIP.  Future provisions can include more verification mapping, more robust hardware, or reworking the economic model to remove any hex boosting arbitrages.


## Prior Related HIPs

- HIP-84 created Service Provider Hex Boosting.


## Motivation

- Current implementation of HIP-84 calls for Network to reward boosted hexes out of the networks PoC bucket. However, multiple issues and concerns for this model have risen that makes this detrimental to the core of the network.
  The biggest issue is the unchecked verification of locations for Indoor hotspots within boosted hexes that were released in December of 2023.  Prior to this, CBRS CPI verification and a consistent GPS lock masked this flaw.
  While the current proposals of "HIP 107: Preventing Gaming Through Verification Fees" and "HIP 108: Mobile Hotspot Suspension Framework" (not yet voted on) could correct this issue, this power and insight into gatekeeping which hotspots are not eligible for receiving MOBILE directly from the network is solely placed in the consistent diligence of the service provider.

- This HIP solves the problem of incorrectly rewarding areas that only the service provider deems as high traffic areas, when no indoor wifi AP actually covers the boosted hexes.

  

## Stakeholders

- All MOBILE Hotspots, CBRS and WiFi, within boosted hexes.  


## Detailed Explanation

- Hex Boosting from HIP-84 for indoor wifi APs will be temporarily put on pause until a future act of governance allows them to be eligible for boosted hex rewards.

- If a service provider wishes to pay those deploying in boosted hexes as has been done in the past, this is considered outside of network emissions and outside of the governance process.  The service providers can still "recommend" hexes and incentivize deployment to indoor wifi APs outside of emissions.


## Drawbacks

- Less new deployments within current boosted hexes, which will revert to "Recommended" hexes.
  
- Hotspots re-asserting outside of the boosted hexes, which will change to "Recommended" hexes, that the current Service Provider has dictated as 'high-traffic' areas without actual service provider footfall data to actually back this up.
  
- Current Mexico Boosted Hexes will no longer have an ability of getting PoC at all. However as of to date, the current service provider has not utilized these. They can remain "Recommended" hexes as the service provider already intends to gatehold certified hotspots for Mexico to be given to authorized deployers with the intent to deploy in those locations anyway. 


## Rationale and Alternatives

- There are many alternatives that can be and are being discussed, however, these would take time to hash out and reimplement.   This could take from weeks to months while the Hex Boosting continues to be exploited at the detriment to nationwide deployment within the HIP-103 Mobile-Oracle-Hex-Boosting layers.  


## Unresolved Questions

- None


## Deployment Impact

- This HIP will remove all current hex boosting that was implemented through HIP-84, and affect all hotspots currently deployed in boosted hexes. These hexes will then be rewarded with standard non-boosted rewards based on Modeled Coverage, without the boosted rewards as defined in HIP-84.
  
- HIP-109: Hex Boosting by Deployment - which has not yet been voted on, aims to directly change HIP-84 to allow Service Providers to specify which Hotspot type (cbrs vs wifi) are eligible to earn boosted MOBILE on newly boosted hexes.  However, HIP-109 does not change current hexes boosted through HIP-84. If HIP-109 goes to vote and passes, and then this HIP passes, it will negate the effects of HIP-109 entirely as it is linked to HIP-84. 

- A future HIP can bring back Hex Boosting, reworked to better attribute to the current dynamics of the network. The current code will be disabled until further refinements are made in a possible future HIP.


## Success Metrics

- Rewards in all other locations within the USA will see a boost in rewards once the Boosted Hexes are removed from draining the PoC pool form the network.
