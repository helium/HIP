HIP-xxx - Pause SP Hex Boosting Rewards for Indoor Wi-Fi

- Author(s): [@mrfizzy99](https://github.com/mrfizzy99) (Fizzy99 - Fiz-Tech.net)
- Contributor(s): [@0lav](https://github.com/0lav) (SaintOlav), [@capjbadger007](https://github.com/capjbadger007) (ElonTusk) , [@bigbuffer](https://github.com/bigbuffer) (JD - Moken) , [Max Gold](https://github.com/GoldHawksAssociates) (Max - GoldHawksAssociates) , [@Gateholder](https://github.com/Gateholder) (Gateholder Worthington Networks)
- Start Date: 2024/02/13
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

- Currently, the Helium MOBILE network has a security flaw that allows indoor Wi-Fi AP to be placed without a high degree of certainty that the AP is actually in its asserted location.  This HIP aims to pause Hex Boosting that was passed in HIP-84 for indoor Wi-Fi APs until a rework can be completed in a future HIP.  Future provisions can include more verification mapping, more robust hardware, or reworking the economic model to remove any hex boosting arbitrages.


## Prior Related HIPs

- HIP-84 created Service Provider Hex Boosting.


## Motivation

- Current implementation of HIP-84 calls for Network to reward boosted hexes out of the networks PoC bucket. However, multiple issues and concerns for this model have risen that makes this detrimental to the core of the network.
  The biggest issue is the unchecked verification of locations for Indoor hotspots within boosted hexes that were released in December of 2023.  Prior to this, CBRS CPI verification and a consistent GPS lock masked this flaw.
  While the current proposals of "HIP 107: Preventing Gaming Through Verification Fees" and "HIP 108: Mobile Hotspot Suspension Framework" (not yet voted on) could correct this issue, this power and insight into gatekeeping which hotspots are not eligible for receiving MOBILE directly from the network is solely placed in the consistent diligence of the service provider.

- This HIP solves the problem of incorrectly rewarding areas that only the service provider deems as high traffic areas, when no indoor Wi-Fi AP actually covers the boosted hexes.

  

## Stakeholders

- All Indoor Wi-Fi hotspots.  


## Detailed Explanation

- Hex Boosting from HIP-84 for indoor Wi-Fi APs will be temporarily put on pause until a future act of governance allows them to be eligible for boosted hex rewards.

- If a service provider wishes to pay those deploying in boosted hexes as has been done in the past, this is considered outside of network emissions and outside of the governance process.  The service providers can still "recommend" hexes and incentivize deployment to indoor Wi-Fi APs outside of emissions.


## Drawbacks

- Less new deployments within current boosted hexes, which will revert to "Recommended" hexes.
  
- Hotspots re-asserting outside of the boosted hexes, which will change to "Recommended" hexes, that the current Service Provider has dictated as 'high-traffic' areas without actual service provider footfall data to actually back this up.


## Rationale and Alternatives

- There are many alternatives that can be and are being discussed, however, these would take time to hash out and reimplement.   This could take from weeks to months while the Hex Boosting continues to be exploited at the detriment to nationwide deployment within the HIP-103 Mobile-Oracle-Hex-Boosting layers.  


## Unresolved Questions

- None


## Deployment Impact

- This HIP will remove all current hex boosting that was implemented through HIP-84, and affect all hotspots currently deployed in boosted hexes. These hexes will then be rewarded with standard non-boosted rewards based on Modeled Coverage, without the boosted rewards as defined in HIP-84.
  
- HIP-109: Hex Boosting by Deployment - which has not yet been voted on, aims to directly change HIP-84 to allow Service Providers to specify which Hotspot type (cbrs vs Wi-Fi) are eligible to earn boosted MOBILE on newly boosted hexes.  However, HIP-109 does not change current hexes boosted through HIP-84. If HIP-109 goes to vote and passes, and then this HIP passes, this HIP negate the effects of HIP-109 for Indoor Wi-Fi.  Boosting Indoor Wi-Fi will continue to be paused even if the Service Provider specifies Indoor Wi-Fi. 

- A future HIP can bring back Hex Boosting, reworked to better attribute to the current dynamics of the network. The current code will be disabled until further refinements are made in a possible future HIP.


## Success Metrics

- Rewards in all other locations will see a boost in rewards once the Indoor Wi-Fi within Service Provider Hex Boosting are paused from draining the PoC pool form the network.
