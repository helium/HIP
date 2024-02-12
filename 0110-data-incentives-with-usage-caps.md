
# Data Incentives with Usage Caps

-   Author(s): @zer0tweets
-   Start Date: 02/12/2024
-   Category: Economic 
-   Original HIP PR:
-   Tracking Issue:
-   Vote Requirements: veMOBILE; 67% to pass
    

## Summary
This HIP proposes a mechanism for service providers to offer select hotspot owners special incentive programs in the form of limited, capped payments to compensate said hotspot owners for voluntarily allowing data usage that would, otherwise, be unpaid or disallowed.

## Motivation
This mechanism would compensate hotspot for voluntarily enabling new use cases on the network and empower service providers to deploy bespoke, strategic incentives to enhance data usage on the network.

## Stakeholders
-   Hotspot owners
-   Service providers
- Mobile Hotspot Vendors
    

## Detailed Explanation
There are a number of instances where service providers on the Helium Network may want to offer special data incentives to hotpots that the current mechanism of purchasing and accounting for data on the network doesn’t allow:

**Example 1:** Per HIP 82, Helium Mobile unlimited plans are capped for data offload rewards to the retail price of the plan, while hotspot owners have the ability to opt-in/opt-out of serving any unrewarded data. As the service provider, Helium Mobile wants to be able to provide a special incentive to hotspots in strategic locations, whereby hotspots that stayed opted-in for unrewarded data for 30 days will be compensated by Helium Mobile up to 10GBb of unrewarded traffic.

**Example 2:** A service provider wants to sponsor hotspot owners in busy locations to voluntarily turn on free public wi-fi service with service provider branding and unlimited usage, but throttled down to 10Mbps per hotspot. Service provider offers to compensate up to 20Gb of public wi-fi traffic to any such hotspot, that had public wi-fi service activated and was meeting throttling and location requirements.

We, therefore, propose to implement a mechanism of special data incentives and compensation. Such a mechanism must always provide hotspot owners with the ability to opt-in/opt-out at any time and have a default opt-out setting. Special data incentives mechanism will allow service providers to:

-   Define per hotspot eligibility criteria for such incentives i.e.:
-   	CBRS vs. Wi-Fi
-  		Indoor vs. outdoor
-   	Location (i.e., only in downtown XYZ etc.)
-   	Hotspot track record (i.e., not a gamer, passing data, meeting heartbeat and speed test requirements, etc.    

-   Trigger conditions (i.e., unrewarded data turned on for the last 30 days with minimum 10MBps throttle speed)
-   Define data incentive program specifications (i.e. data cap of 20GB per month or 1GB per day, etc.)
    
Service providers will publish the eligibility criteria and the incentive details on their support channels for each of the incentive programs.

Service providers will also share the list of Wi-Fi and CBRS vendors that are supporting each incentive program.

Service providers will pay the Helium Network for such data by burning HNT into DC using the approved network wide rate ($0.5/GB) and any hotspots eligible for such rewards will receive MOBILE rewards for passing special incentive data following the existing rules established by MOBILE subDAO per HIP53.

## Drawbacks

This proposal introduces an additional layer of complexity to the data reward mechanism in the form of special incentives and per hotspot reward caps, making it harder for a hotspot owner to assess how much data was rewarded for what. Moreover, some of the hotspot owners less involved in the intricate nuances of how Helium works may be confused by what and why they are receiving rewards.

It may also be perceived that allowing service providers the freedom to define incentives that apply to only a subset of hotspots could be divisive to the network and somewhat go against the principles of decentralization.

Lastly, implementing such incentives to work reliably will require a tight interlock between service providers and hotspot manufacturers since some of the features (e.g., default opt-in/opt-out, reward cap tracking, incentive calculations, etc.) will require hotspot vendors to support said features in their hotspots.

## Rationale and Alternatives

The need for this proposal and the service provider use cases explained in the examples illustrate certain deficiencies that come with the rigidity of Helium Network’s “pay fixed price per gig” setup. One could argue that the proposed solution is a hack to fix a hole, whereas the proper solution should be a more holistic revisit of pay-per-gig economics of the Helium network.

## Unresolved Questions

There will likely be multiple Wi-Fi hotspot vendors and there are already multiple CBRS gateway and radio vendors on the network. Any collaboration required between service providers and hotspot manufacturers to enable required functionality in the hotspot firmware to support special data incentives are outside the scope of this HIP.

## Deployment Impact

Initial deployment will involve modifying [settlement service](https://github.com/magma/grants/issues/14) to allow per hotspot data caps and writing an interaction between settlement service and rewards oracles to validate that the conditions outlined by the service providers for a particular hotspot have been met, thus triggering DC burn in the service provider wallet and distribution of MOBILE to subDAO participants.

## Success Metrics

This HIP would be considered successful if at least one service provider has launched at least one special data reward incentive within 3 months of the approval of this HIP resulting in at least 6TB/day in additional data burn on the Helium Network from special data incentives.
