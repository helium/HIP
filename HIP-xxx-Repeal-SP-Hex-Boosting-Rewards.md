HIP-xxx - Repeal-SP-Hex-Boosting-Rewards

- Author(s): @mrfizzy99 (Fizzy99 - Fiz-Tech.net)
- Contributor(s): @0lav (SaintOlav), @capjbadger007 (ElonTusk) , @bigbuffer (JD - Moken)
- Start Date: 2024/02/13
- Category: Economic and Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

This HIP aims to repeal and remove Hex Boosting that was passed in HIP-84. 


## Prior Related HIPs
HIP-84 created Service Provider Hex Boosting.


## Motivation

- Current implementation of HIP-84 calls for Network to reward boosted hexes out of the networks PoC bucket. However, multiple issues and concerns for this model have risen that makes this detrimental to the core of the network.
  The biggest issue is the unchecked verification of locations for Indoor hotspots within boosted hexes that were released in December of 2023.  Prior to this, CBRS CPI verification and a consistent GPS lock masked this flaw.
  While the current proposals of "HIP 107: Preventing Gaming Through Verification Fees" and "HIP 108: Mobile Hotspot Suspension Framework" (not yet voted on) could correct this issue, this power and insight into gatekeeping which hotspots are not eligible for receiving MOBILE directly from the network is solely placed in the consistent diligence of the service provider.

- This HIP solves the problem of needless rewarding for areas that only the service provider deems as high traffic areas, prior to actual service provider footfall data, which is now being solved through "HIP-103 Mobile-Oracle-Hex-Boosting".
  Through HIP-103, layers can be defined, and a future layer of active Service Provider high traffic areas can be applied.  

- While most of the concern comes from Indoor Wifi, current CBRS deployments within boosted hexes that are getting rewarded these boosted hexes currently have no ability to offload onto the Service Provider.
  As of January when the service provider switched from offering dual SIMs a Voice/Text + Data, to work on a single SIM solution. So CBRS departments, as of now, add little value in boosted hexes, when they can't be utilized by the Service Provider.  
  

## Stakeholders

- All MOBILE Hotspots, CBRS and WiFi, within boosted hexes.  


## Detailed Explanation

- Repealing Hex Boosting from HIP-84 is as simple of a detailed explanation as we can get. All current hexboosting hexes from HIP-84 will be removed, and all further rewards will be halted once this HIP passes.
- The service provider can still "Recommend" hexes at their leisure. 


## Drawbacks

- Less new deployments within current boosted hexes, which will revert to "Recommended" hexes. 
- Hotspots re-asserting outside of the boosted hexes, which will change to "Recommended" hexes, that the current Service Provider has dictated as 'high-traffic' areas without actual service provider footfall data to actually back this up.
- Current Mexico Boosted Hexes will no longer have an ability of getting PoC at all. However as of to date, the current service provider has not utilized these. They can remain "Recommended" hexes as the service provider already intends to gatehold certified hotspots for Mexico to be given to authorized deployers with the intent to deploy in those locations anyway. 


## Rationale and Alternatives

- There are many alternatives that can be and are being discussed, however, these would take time to hash out and reimplement.   This could take from weeks to months while the Hex Boosting continues to be exploited at the detriment to nationwide deployment within the HIP-103 Mobile-Oracle-Hex-Boosting layers.  


## Unresolved Questions

- If the current service provider has already burned MOBILE into the hexes, what happens?  This could be an IOU to the service provider from the network, that could be credited to that Service Provider the next time a mechanism requires a service provider to burn, such a future reworked Service Provider Hex Boosting. 


## Deployment Impact

- This HIP will remove all current hex boosting that was implemented through HIP-84, and affect all hotspots currently deployed in boosted hexes. These hexes will then be rewarded with standard non-boosted rewards based on Modeled Coverage, without the boosted rewards as defined in HIP-84.
  
- HIP-109: Hex Boosting by Deployment - which has not yet been voted on, aims to directly change HIP-84 to allow Service Providers to specify which Hotspot type (cbrs vs wifi) are eligible to earn boosted MOBILE on newly boosted hexes.  However, HIP-109 does not change current hexes boosted through HIP-84. If HIP-109 goes to vote and passes, and then this HIP passes, it will negate the effects of HIP-109 entirely as it is linked to HIP-84. 

- A future HIP can bring back Hex Boosting, reworked to better attribute to the current dynamics of the network. The current code will be disabled until further refinements are made in a possible future HIP.


## Success Metrics

- Rewards in all other locations within the USA will see a boost in rewards once the Boosted Hexes are removed from draining the PoC pool form the network.
