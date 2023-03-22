# HIP 79: Mobile PoC - Mappers Rewards

- Author(s): Mobile PoC Working Group ([@gateholder](https://github.com/gateholder), [@jhella](https://github.com/jhella), [@Maxgold91](https://github.com/Maxgold91), [@modern-memories](https://github.com/modern-memories), [@zer0tweets](https://github.com/zer0tweets))
- Start Date: 2023-03-19
- Category: Economic, Technical
- Original HIP PR: #590
- Tracking Issue: #592

## Summary

This HIP proposes to adjust the MOBILE reward bucket for Service Providers in the Mobile SubDAO to 10%, and to 20% for the Mappers. Additionally, this HIP describes a framework for providing rewards for various types of mapping activity on the Mobile Network.

## Motivation

HIP53 described Mobile subDAO and proposed a number of reward buckets to be activated over time, such as Hotspot operator rewards (20-60%), Mapper rewards, Service Provider rewards etc. Since initially introducing these buckets, we discovered some new stuff:

- Service Provider (SP) bucket was initially set to 20%, assuming that Service Providers on the network will be able to use this pool to incentivize Subscribers to sign-up, share data or exhibit various other types of behavior useful for network development. Our ongoing discussions with offload partners have revealed that they would be reluctant to use tokens to incentivize Subscribers, as it may result in compliance and regulatory risk.
- We initially set a 10% bucket for Mappers, because at the time of writing HIP53, we assumed that Mappers will be the only and primary way of aligning Hotspot operator rewards with coverage. Since then, we have come to the conclusion that using modeled coverage, coupled with Mappers as a means to verify modeled coverage is a better approach to arrive at a complete coverage map.
- We initially assumed that mapping is limited to network participants verifying existing coverage using dedicated mapping devices. We have since expanded our thinking and believe that mapping should also include helping reveal hexes where offload is most likely to happen, by having network Subscribers share locations where most TMO data is being used.

In light of these discoveries, we’d like to propose an adjustment to the reward buckets proposed in HIP53 and a new, more flexible framework for providing rewards for work performed on the network by various types of mapping activity.  

- Since SP rewards can’t be re-distributed to Subscribers, we propose to reduce Service Provider rewards bucket from 20% to 10% and expand mappers bucket from 10% to 20% to account for the additional types of mapping activity.
- Introduce a framework of reward points and tasks that can be performed by Mappers for verifying existing coverage (verification mapping), as well as, helping discover coverage opportunities (discovery mapping).

## Stakeholders

- Service Providers joining the Mobile SubDAO will have a decreased pool of MOBILE rewards from 20% to 10%.
- Mappers who operate dedicated mapping devices (Spot) and Subscribers to the Mobile Network will earn rewards for network mapping from the 20% pool of emitted MOBILE.

## Detailed Explanation

### Reward Points Framework for Mappers  

Similar to various Radios earning various amounts of reward points, depending on the coverage they provide across res12 hexes, we propose a series of tasks and associated reward points for mapping activity. Mappers to accumulate rewards points over a 24 hour period and total MOBILE minted for the period that is attributable to the mappers bucket will be ratably distributed based on reward points.

#### Discovery Mapping Rewards  

Today people deploy Mobile Hotspots at all kinds of random locations and we provide little guidance on placement, aside from broad statements to the tune of “locations with a lot of slow moving people.” Given Helium 5G neutral host focus and our objective to bring maximum amount of data to the Network, it is critical that the Hotspots are placed and rewarded in very specific locations - those where there is a concentration of Helium Mobile (and, later, other Service Providers) Subscribers using a lot of non-Helium 5G data while stationary or moving slowly. I.e. locations where there is the highest probability of data offload happening.

Achieving this is possible by having some critical mass of Subscribers that belong to roaming operators voluntarily share this information with the network, which, in turn, can boost PoC rewards in most relevant hexes.

To help identify coverage opportunities people will be required to be a Subscriber on the Network and opt-in through the Helium Mobile app (or any other carrier app provided by an approved Service Provider on the Network). Similar to Google Maps or other, location dependent apps, Helium Mobile app will intermittently query the GPS of the mobile device and share the device location with the Network every so often.

We propose that 30 reward points be attributed to each Subscriber who has consistently shared their mobile location during the 24 reward period. Identifying coverage opportunities is, by design, a passive activity. I.e. we don’t want Subscribers to be exhibiting any special, unnatural activity in terms of where they go or how much data they use. Therefore, there is no way a participant can influence the rewards by doing something in particular. There are just two requirements for earning these rewards: 1) be a Subscriber on the Network, going about your daily routine; 2) voluntarily opt-in to share your location for the betterment of the Network.   

##### Using Discovery Mapping Data to Boost Hexes

We believe that the decision regarding which hexes should be boosted as a result of discovery mapping data is a Service Provider specific decision. Since Helium 5G is a neutral host network with, over time, multiple Service Providers joining and offloading, we expect that different Service Providers are likely to assign different values to coverage. For example, Helium Mobile will focus on Miami, Las Vegas and LA as key regions for its marketing spend and, as such, will likely have higher concentration of Subscribers (and consequently assign higher value) to those locations. At the same time, Dish Wireless, which has multiple MVNO assets (like Boost) with their own geographic footprint (and economics around roaming deals with TMO and AT&T) would likely consider a different set of hexes valuable.

Therefore, instead of the Network automatically making decisions about which hexes to boost, we propose that Service Providers act as Oracles on the Network and have the ability to access discovery mapping data and then boosting hexes that are of interest to them by staking MOBILE to hexes in their relevant areas.

Current HIP, however, is aimed to deal with mechanics for rewarding Mappers (vs. Service Providers and hex boosting). As such, we suggest that mechanisms for Service Provider hex boosting are deferred to a separate, subsequent HIP.

#### Verification Mapping Rewards

Following HIP74 approval, the task of mapping is to verify (or invalidate) modeled coverage. Mappers accomplish this by measuring the actual signal strength radiated by a Radio within a given res12 hex at a certain point in time and reporting this data back to MOBILE rewards Oracle. MOBILE rewards Oracle will then use this information to figure out how to adjust rewards for the Radios.

From the perspective of MOBILE rewards Oracle, the objective is to gather sufficient data from the Mappers, such that it can deduce, with a reasonable degree of confidence, whether a particular Radio’s signal is aligned with its modeled coverage. As such, MOBILE rewards Oracle wants to see a set of up to date signal measurements across a random distribution for each Radio. I.e. A single Mapper, laying on a desk next to the Radio, consistently reporting the same signal for the same Radio in the same hex is producing a lot less value for the network than a Mapper that is reporting measurements across a variety of res12 hexes for each of many unique Radios. Therefore, the reward point system for Mappers, should be constructed to incentivize the following behavior:

- For each Radio, ideally, we want the Mapper to report readings across more than just one res12 hex, to enable MOBILE rewards Oracle to more precisely correlate those readings with modeled coverage.
- We want to verify those Radios that haven’t already been verified within some period of time.
- We want Mappers to validate as many unique Radios as possible during a reward period (vs. just a single Radio every time).

Given the above, we propose to use the following framework for discovery mapping reward points:

- Each modeled coverage res12 hex gradually charges up to 168 points over 168 hours (7 days).
- We suggest keeping the rate of charge linear in 1 hour increments. I.e. Every hour the hex charges up 1 point.
- A Mapper completes verification by attempting to connect to the Radio inside of a mapped hex and reporting success/failure, along with a timestamp and GPS location of a Mapper at the time of the attempt. When verification happens the hex discharges back to zero points.
- Furthermore, all adjacent hexes discharge by 50%.
- There is a maximum number of 672 points that can be earned by a single Mapper for verifying the same Radio during any given 7 day period.

#### Example Reward Calculations for Mappers  

A sheet to play with: https://docs.google.com/spreadsheets/d/1nDYbj4APWg_XEeGEsLdR17CW8q2EiuEqoLKs_I6T1Dc/edit#gid=1971124829

|                                               |               |
| --------------------------------------------- | ------------- |
| Total Tokens Minted Monthly                   | 5,000,000,000 |
| Total Tokens Minted in 24 Hours               |   166,666,667 |
| Total Token Pool for Mappers (20%)            |    33,333,333 |
| Fixed 24 hour reward for discovery mappers    |            30 |
| Average 24 hour reward for Spot*              |           168 |
| Active Discovery Mappers (Subscribers/Phones) |        10,000 |
| Active Verification Mappers (Spot)            |         2,000 |
| Total Points Earned by All Mappers            |       636,000 |
| Mobile Earned per Discovery Mapper            |     **1,572** |
| Mobile Earned per Verification Mapper         |     **8,805** |

*Assume it mapped 2 semi-charged hexes


### Adjusting Hotspot Rewards Based on Mapper Input

The Mobile PoC Working Group has discussed and documented a potential path to adjust MOBILE Hotspot rewards using the data collected by Mappers that would utilize the concept of the confidence score. Detailed description of the current thinking along with community comments is available here.

It has been decided by the Mobile PoC Working Group to postpone the final decision regarding the specific algorithm to the second stage of Mapper reward implementation. This approach would make it possible to create Hotspot rewards adjustment algorithms based on the actual data from mapping activity vs. speculating regarding variables and weights.

### Mapper subDAO  

The Mobile PoC Working Group has also agreed to initiate work on Mapper subDAO. Mapper subDAO would make it possible for mapper devices to provide data that can be used across various types of networks - IoT, MOBILE, Wi-Fi etc - as well as receive incentives for mapping macro operator coverage. It has been decided that, following the implementation of Mapper subDAO, Mobile subDAO will become one of the first “customers” of Mapper subDAO.

## Drawbacks

There are no obvious drawbacks.

## Rationale and Alternatives

None of the alternatives are really viable.
One alternative is not to use Mappers and continue relying on individual self-certification of radios, which is prone to gaming.

## Unresolved Questions

This HIP proposes to move forward with mapping rewards without creating a final algorithm for how Hotspot rewards will be adjusted. For the full effect of Mappers to take place, that part needs to be addressed. It has been decided that it is best addressed following actual data that will be collected by mapping.

For discovery mapping, this HIP proposes the approach for uncovering hexes with likely high concentration of Helium 5G network users, but it doesn’t lay out the path for how this information can be used to incentivize coverage at such locations over any other. The Mobile PoC Working Group has discussed this at a high level and will make a separate proposal that describes how Service Providers on the network can boost locations with high likelihood of traffic usage by staking MOBILE in a separate HIP.

## Deployment Impact

The deployment will kickstart the emission of MOBILE Mappers reward at an increased 20% and rewarding of Subscribers and Mappers once they join the network and start mapping activities.
It will also reduce the emissions of the MOBILE rewards to 10% for Service Providers once they join the Mobile Network.

Deployment of this HIP will require the following:
- Onboarding of Mappers and Subscribers to the Solana blockchain with NFTs, in a similar approach to onboarding of Hotspot.
- Emissions of an additional 20% MOBILE dedicated to Mappers rewards bucket on the Solana.
- Integration of the discovery mapping data from the Subscribers app and verification mapping data from Spot device with Mobile Oracle.
- Implementation of the hex recharge algorithm on the Mobile Oracle.
- Implementation of the rewarding algorithm on the Mobile Oracle that determines how much each Mapper and Subscriber gets rewards for specific mapping activities.
- Visualization of the mapped hexes with a tool similar to Modeled Coverage Explorer.
- Updates to [dev docs](https://docs.helium.com/).

## Success Metrics

For verification mapping the key success metrics is the number of modeled coverage hexes that have been validated or invalidated by mapping activity.

For discovery mapping the key success metric is the number of subscribers that opted in to help share their data usage and location with the network and, as a byproduct of it, whether or not this information uncovers sufficient concentration of usage in certain areas, such that it is useful for making Hotspot deployment decisions.
