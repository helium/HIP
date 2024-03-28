# HIP 118: Verification Mapping for MOBILE Network

- Author: [@zer0tweets](https://github.com/zer0tweets), [@jpad](https://github.com/jpad)
- Start Date: 2024-03-28
- Category: Technical, Economic
- Original HIP PR: [#950](https://github.com/helium/HIP/pull/950)
- Tracking Issue: [#966](https://github.com/helium/HIP/issues/966)
- Voting Requirements: veMOBILE

---

## Summary

This Helium Improvement Proposal (HIP) lays out the approach to validate locations of Wi-Fi and CBRS hotspots using cell phones that belong to subscribers using the Helium network.

## Related Previous HIPs  

* [HIP 79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md) established general framework of discovery and verification mapping and related MOBILE reward pools
* [HIP 84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) established the framework for service providers to boost hexes by burning MOBILE
* [HIP 103](https://github.com/helium/HIP/blob/main/0103-oracle-hex-boosting.md) established the framework for automated boosting of certain hexes based on oracle data, such as urbanization and footfall

## Motivation

After implementation of HIP-84 and HIP-103, the rewards for hotspots on the Helium network can vary, depending on the location. This creates an incentive for hotspot deployers to misrepresent their locations to earn larger rewards. While there are a number of measures already in-place to verify asserted hotspot locations, such as Skyhook and GPS validation, those are potentially spoofable.

## Stakeholders
  
-   Deployers - deployers will be unable to collect rewards in locations boosted by HIP-84 or HIP-103, unless their location has been verified by a verification mapper
-   Subscribers - Subscribers will have the opportunity to earn extra rewards for performing verification mapping tasks
-   Service providers - will need to designate verification mappers and/or provide additional oracle data to the network, such as location of their macro towers and a subset of call data records
   
## Detailed Explanation

To perform verification mapping activities one must be a subscriber on the network. I.e. run an app on the phone with a subscriber NFT in it. There are three ways that the subscriber NFT can earn “verification mapper” status.

-   *Manual Designation:* Non-scalable approach designed to bootstrap new locations / geographies (such as Mexico) where there is not yet a pool of existing discovery mappers. A trusted mapper is designated by a service provider to complete physical verification of coverage at a given location, following a prescribed list of instructions, requiring such an individual to visit the location and attempt to complete a connection to a radio (Wi-Fi or CBRS). These types of trusted mappers are compensated for the work by the service providers and are not rewarded by the MOBILE emissions.
    
-   *Auto Designation:* An automated scalable approach for geographies with existing service providers (such as US with Helium Mobile) and an existing pool of discovery mappers. A discovery mapper gets automatically upgraded to verification mapper, should he/she meet certain criteria (described below). Auto designated verification mappers are able to earn additional MOBILE rewards for performing verification mapping work.
  
### Auto Designation Criteria

Any network subscriber, who opted-in to discovery map, will automatically become upgraded/downgraded to/from verification mapping status on a per epoch basis, depending on them meeting the following criteria during the trailing 7 days:  

-   Discovery mapper has received discovery rewards for the last 4 of the 7 days
-   GPS event stream shared with the network by the discovery mapper phone has been successfully correlated with service provider tower locations (T-Mobile towers in case of Helium Mobile in the US)

Service providers on the network (such as Helium Mobile in the US) have access to call data records (aka CDRs). CDRs specify time, cell ID and other important records about subscriber’s usage of the macro network infrastructure, which makes it possible to determine what physical cell towers any particular subscriber has connected to during any given moment in time. Cell tower locations are known to the service providers and are next to impossible to alter by a bad actor. I.e. by looking at the history of cell tower locations that any subscriber has connected to, it is possible to approximate the physical location of their phone. We can then correlate subscriber location derived from macro tower connections with the GPS event stream on the phone. If the two location streams didn’t “disagree” during the trailing 7 day period, we can reasonably assume that the GPS on the phone is functioning properly and has not been tampered with.

In some instances verification mapping may be performed using specialized user equipment with custom security that makes it impossible to spoof location services (i.e. Saga 2 and, later, other phones) with subscriber NFT stored in a secure element of the phone. Such subscribers will not require correlating GPS event stream with service provider tower locations to complete verification mapping tasks. 

### Verification Mappers Rewards

Subscribers that have been auto designated as verification mappers will earn rewards from the mapper pool. It is proposed that the rewards are calculated using a slightly modified approach vs. [what’s approved in HIP79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md#verification-mapping-rewards) . Specifically:

-   Each radio charges up to 168 reward points over 168 hours (7 days)  
-   A verification mapper completes the verification event by successfully connecting to the radio (Wi-Fi or CBRS) and reporting a timestamp and GPS location (and if possible on android a skyhook beacon)
    

No action is required by a mapper to connect to the radio and perform verification; this happens automatically using installed wi-fi cert and/or CBRS sim whenever a verification mapper is within broadcast proximity of the radio.


### Reward Adjustments for the Radios

It is proposed that absent a verification mapping event during the trailing 7 days, maximum reward multiplier for any radio be 0.5x. I.e receiving boosted rewards of 0.7 per HIP 103 or higher and/or any service provider boosted rewards required for the radio to be verified at least once during the trailing 7 day period.  
  

## Drawbacks

-   This approach may introduce limitations to international expansion of the Helium Network as it adds an additional burden on the service providers and requires an existing pool of discovery mappers to be present for the network to scale in a given geography. Cell tower location data may be considered proprietary by some service providers and maybe not be available as “oracle data” in all geographies.    
-   Currently 100% of mapper rewards go to discovery mappers and discovery mapping rewards have been an important driver of the continued growth of subscribers on the Helium Network. Verification mappers, if successfully deployed, will claim a considerable chunk of rewards from the discovery mapper pool, thus making discovery mapping less attractive and potentially negatively impacting subscriber growth velocity.   
-   Some small number of legitimately placed radios may not get verified due to still relatively low density of discovery mappers on the network.
    

## Rationale and Alternatives

 Since asserted location has become an important influencer of rewards, it is critical to have several layers of security to ensure asserted locations are accurate.

An alternative to the proposed approach could be to use the physical, specialized devices for verification mapping, akin to Spot that was initially contemplated. Downside of “spot approach” is scalability and cost.

Another alternative is to completely do away with user equipment (UE) based verification mapping and double down on more robust methods of trust location identification using the hotspot itself. I.e. various probabilistic filtering and averaging of skyhook and GPS data. These methods are inherently unverifiable, as they rely on passive reporting of the observed RF environment.

  ## Unresolved Questions
  
Most critical open question is what happens in the event of a confirmed negative correlation between the hotspot asserted location and a location reported to by the verification mapper. I.e. if the verification mapper has connected to a hotspot and reported that its location is different from the asserted location?

One option is to implement a method for punishing hotspots for negative correlation events by reducing their rewards. It is suggested, however, that we consider this as step 2, once we’ve gathered sufficient data.

## Deployment Impact

It is proposed that the implementation of this HIP will be done by Nova Labs. Implementation will require changes to all service provider apps (i.e. Helium Mobile app), as well as the rewards of Oracle. It is estimated that the work to implement this will take roughly 3 months, following the approval of this HIP and provided there are no substantial changes to scope as a result of community discussions.

## Success Metrics

This HIP will be considered successful if at least 30% of all discovery mappers are auto-designated as verification mappers and at least at least 50% of all radios on the network are verified using this mechanism following 3 months after deployment.
