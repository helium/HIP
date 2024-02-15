# HIP-xxx - Pause HIP-86 SP Hex Boosting Rewards For All Radios

- Author(s): [@mrfizzy99](https://github.com/mrfizzy99) (Fizzy99 - Fiz-Tech.net)
- Contributor(s): [@0lav](https://github.com/0lav) (SaintOlav), [@capjbadger007](https://github.com/capjbadger007) (ElonTusk) , [@bigbuffer](https://github.com/bigbuffer) (JD - Moken) , [Max Gold](https://github.com/GoldHawksAssociates) (Max - GoldHawksAssociates) , [@Gateholder](https://github.com/Gateholder) (Gateholder Worthington Networks)
- Start Date: 2024/02/13
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

This HIP aims to pause and remove Service Provider Hex Boosting that was passed in HIP-84, to be completely reworked with current available equipment that was not available previously in mind and new economics to better scale nationwide and beyond.

## Prior Related HIPs

HIP-84 created Service Provider Hex Boosting.


## Motivation

- As of 02/14/2024, when the Nova Dev team announced that HIP-84 implementation is now complete, it was not correctly done so and omitted the specified requirements of "at least three unique phones with discovery mapping enabled have successfully connected and passed at least 1MB of data at the location of coverage (as evidenced by the Mobile Oracle)."

- Current implementation of HIP-84 also calls for the network to reward boosted hexes out of the networks PoC bucket. However, multiple issues and concerns about this model have arisen that make it detrimental to the core of the network.
In other words, the economics of HIP-84 is disproportionately skewed, as the it only takes a small amount of MOBILE to be burned by the Service Provider to boost a hex, and it emits many more multiples of the MOBILE for that hex. While already being inherently unfair to the network as a whole, this also leaves the mechanism open for a dishonest Service Provider to boost hexes for their own gain. 

- The biggest issue is the unchecked verification of locations for Indoor hotspots within boosted hexes that were released in December of 2023.  Prior to this, CBRS CPI verification and a consistent GPS lock masked this flaw.
  While the current proposals of "HIP 107: Preventing Gaming Through Verification Fees" and "HIP 108: Mobile Hotspot Suspension Framework" (not yet voted on) could correct this issue, this power and insight into gatekeeping which hotspots are not eligible for receiving MOBILE directly from the network is solely placed in the consistent diligence of the service provider.
  This issue can also be addressed with another proposed HIP "HIP-xxx - Remove SP Hex Boosting for Indoor Wi-Fi".

- While most of the concern comes from Indoor Wifi, current CBRS deployments within boosted hexes that are getting rewarded currently have no ability to offload onto the Service Provider.
  As of January when the service provider switched from offering dual SIMs a Voice/Text + Data, to work on a single SIM solution. So CBRS departments, as of now, add little value in boosted hexes, when they can't be utilized by the Service Provider.  

- Overall, in this author's option, pausing HIP-84 is the best thing for the network, as there are many things that have changed in the ecosystem over the past 10 months since the original idea was conceived and have not been implemented correctly or should have been implemented in the way it has. 
  

## Stakeholders

- The MOBILE Subdao


## Detailed Explanation

- Pausing Hex Boosting from HIP-84 is as simple of a detailed explanation as we can get. All current hexboosting hexes from HIP-84 will be removed, and all further rewards will be halted once this HIP passes.
  
- The service provider can still "Recommend" hexes at their leisure until a future rework of HIP-84 has been completed and coded. 


## Drawbacks

- Less new deployments within current boosted hexes, which will revert to "Recommended" hexes.
  
- Hotspots re-asserting outside of the boosted hexes, which will change to "Recommended" hexes.
  
- Current Mexico Boosted Hexes will no longer have an ability of getting PoC at all.


## Rationale and Alternatives

- There are many alternatives that can be and are being discussed, however, these would take time to hash out and reimplement. This could take from weeks to months while the Hex Boosting continues to be exploited at the detriment to nationwide deployment within the HIP-103 Mobile-Oracle-Hex-Boosting layers.  

- They can remain "Recommended" hexes as the service provider already intends to gatehold certified hotspots for Mexico to be given to authorized deployers with the intent to deploy in those locations anyway.
  The deal that the current service provider has been given in Mexico was also not thought about within the confines of HIP-84. A new revision of HIP-84 that could be made should take into consideration Boosting Hexes outside of the USA. 

## Unresolved Questions

- If the current service provider has already burned MOBILE into the hexes, what happens?
  This could be an IOU to the service provider from the network, that could be credited to that Service Provider the next time a mechanism requires a service provider to burn, such as future reworked Service Provider Hex Boosting. 


## Deployment Impact

- This HIP will remove all current hex boosting that was implemented through HIP-84, and affect all hotspots currently deployed in boosted hexes. These hexes will then be rewarded with standard non-boosted rewards based on Modeled Coverage, without the boosted rewards as defined in HIP-84.
  
- HIP-109: Hex Boosting by Deployment - which has not yet been voted on, aims to directly change HIP-84 to allow Service Providers to specify which Hotspot type (cbrs vs wifi) is eligible to earn boosted MOBILE on newly boosted hexes.  However, HIP-109 does not change current hexes boosted through HIP-84. If HIP-109 goes to vote and passes, and then this HIP passes, it will negate the effects of HIP-109 entirely as it is linked to HIP-84. 

- A future HIP can bring back Hex Boosting, reworked to better attribute to the current dynamics of the network. The current code will be disabled until further refinements are made in a possible future HIP.


## Success Metrics

- Rewards will stabilize and be slightly boosted once the Boosted Hexes are removed from draining the PoC pool form the network.
