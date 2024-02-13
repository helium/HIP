HIP-xxx - Repeal-SP-Hex-Boosting-Rewards

- Author(s): @mrfizzy99, @JD, @Gateholder, @Bobbin
- Start Date: 2024/02/13
- Category: Economic and Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: <!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary

This HIP aims to repeal and remove Hex Boosting that was passed in HIP-84. 

<!-- Read the content requests in all sections before starting to write any section. -->

## Prior Related HIPs
HIP-84 created Service Provider Hex Boosting.


## Motivation

- Current implementation of HIP-84 calls for Network to reward boosted hexes out of the networks PoC bucket. However, multiple issues and concerns for this model have risen that makes this detrimental to the core of the network.
- The biggest issue is the unchecked verification of locations for Indoor hotspots within boosted hexes that were released in December of 2023.  Prior to this, CBRS CPI verification and a consistent GPS lock masked this flaw.
- While HIP-107/108 could correct this issue, this power and insight into gatekeeping which hotspots are not eligible for receiving MOBILE directly from the network is solely placed in the consistent diligence of the service provider.

- This HIP solves the problem of needless rewarding for areas that only the service provider deems as high traffic areas, prior to actual service provider footfall data, which is now being solved through HIP-103.
- Through HIP-103 Mobile-Oracle-Hex-Boosting, layers that can be defined, and a future layer of active Service Provider high traffic areas can be applied.  

- While most of the concern comes from Indoor Wifi, current CBRS deployments within boosted hexes that are getting rewarded these boosted hexes currently have no ability to offload onto the Service Provider.
- As of January when the service provider switched from offering dual SIMs a Voice/Text + Data, to work on a single SIM solution. So CBRS departments, as of now, they add little value in boosted hexes, when they can't be utilized by the Service Provider.  
  

## Stakeholders

- All MOBILE Hotspots, CBRS and WiFi, within boosted hexes.  


## Detailed Explanation

- Repealing Hex Bossting from HIP-84 is as simple of a detailed explanation as we can get. All current hexboosting hexes from HIP-84 will be removed, and all further rewards will be halted once this HIP passes.
- The service provider can still "Recommend" hexes at their leisure. 


## Drawbacks

- Less deployments within current boosted hexes.
- Hotspots moving outside of the boosted hexes that the current Service Provider has dictated as 'high-traffic' areas. 


## Rationale and Alternatives

- There are many alternatives that can be and are being discussed, however, these would take time to hash out and reimplement.   This could take from weeks to months while the Hex Bossting continues to be exploited. 


## Unresolved Questions

- None.

## Deployment Impact

- This HIP will impact all current hex boosting that was implemented through HIP-84, and all hotspots currently deployed in boosted hexes.
 

## Success Metrics

- Rewards in all other locations within the USA will see a boost in rewards once the Boosted Hexes are removed from draining the PoC pool form the network.
   
