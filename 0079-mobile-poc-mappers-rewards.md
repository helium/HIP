# HIP 79: Mobile PoC - Mappers Rewards

- Author(s): Mobile PoC Working Group ([@gateholder](https://github.com/gateholder), [@jhella](https://github.com/jhella), [@Maxgold91](https://github.com/Maxgold91), [@modern-memories](https://github.com/modern-memories), [@zer0tweets](https://github.com/zer0tweets))
- Start Date: 2023-03-19
- Category: Economic, Technical
- Original HIP PR: #590
- Tracking Issue: #592

## Summary

This HIP proposes revising the rewards for Service Providers and Mappers as outlined in [HIP-53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md), reducing the MOBILE reward bucket for Service Providers from 20% to 10% and increasing the reward bucket for Mappers to 20% from 10%.

This HIP additionally describes a framework for providing rewards for various types of mapping activity on the Mobile Network.

## Motivation

HIP-53 described the Mobile subDAO and proposed several reward buckets to be activated over time. Following the initial Mobile Network launch, the Mobile PoC Working Group has discovered adjustments to be made to the reward buckets to realign incentive models with the current state of the Mobile Network.

1. Initially set to 20%, the Service Provider reward bucket assumed that Service Providers on the Network could use this pool to incentivize Subscribers to sign-up, share data, or exhibit various other types of valuable behavior for Network development. However, ongoing discussions with offload partners have revealed a reluctance to use MOBILE tokens to incentivize Subscribers, as it may result in compliance and regulatory risk.
2. Initially set to 10%, the Mappers reward bucket assumed that Mappers would be the only and primary way of aligning Hotspot Operator rewards with coverage goals. Coupling Mappers with modeled coverage is a better approach to arriving at a complete coverage map.
3. The initial assumption was that mapping would be limited to Network Participants verifying existing coverage with dedicated mapping devices. Network Subscribers and mapping devices should additionally share areas where carrier offloading is most likely.

In light of these discoveries, this HIP proposes adjusting the reward buckets presented in HIP-53 and a new, more flexible framework for providing rewards for work performed on the Network by various types of mapping activity as follows:

- The Service Provider reward bucket is reduced from 20% to 10% as these rewards can not be re-distributed to Subscribers
- The Mapper reward bucket is increased from 10% to 20% to account for the additional mapping activity types.

This HIP additionally introduces a framework of reward points and tasks that Mappers can perform for verifying existing coverage (verification mapping) and helping discover coverage opportunities (discovery mapping).

## Stakeholders

- Service Providers joining the Mobile Network will be eligible for 10% of emitted MOBILE rewards for facilitating Network usage as described in [HIP-53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview).
- Dedicated mapping device operators and Subscribers to the Mobile Network will be eligible for 20% of emitted MOBILE rewards for Network mapping.

## Detailed Explanation

### Reward Points Framework for Mappers

This HIP proposes proportionally distributing MOBILE rewards from the Mappers reward bucket to all Mapper devices accumulating rewards points for contributing to any of a set of mapping tasks over a 24-hour period.

### Discovery Mapping Rewards

Placing and rewarding MOBILE Hotspots in locations with a concentration of Subscribers using non-MOBILE Hotspots is critical to the neutral host focus and the objective to bring the maximum amount of data to the Mobile Network. Thereby updating the broad guidance of "locations with a lot of slow-moving people" to more specific "locations where there is the highest probability of data offload happening."

Achieving this is possible by having some critical mass of Subscribers voluntarily share this information with the Network, which, in turn, can boost PoC rewards in most areas.

To help identify coverage opportunities, users must be Subscribers on the Network and opt-in through the Helium Mobile app (or any other carrier app provided by an approved Service Provider on the Network). Similar to Google Maps or other location-dependent apps, the Helium Mobile app will intermittently query the GPS of the mobile device and share the device location with the Network.

Identifying coverage opportunities is designed to rely on Subscribers' natural location activity and data usage.

To combat participant influence due to particular or atypical behaviors, this HIP proposes attributing 30 reward points to each Subscriber who has consistently shared their mobile location during the 24 reward period.

To earn Discovery Mapping Rewards, a participant must:
Be a Subscriber on the Network, going about their daily routine
Voluntarily opt-in to share location for the betterment of the Network.

### Using Discovery Mapping Data to Boost Hexes

Hex Boosting, the act of increasing rewards for mapping coverage within a given area, is at Service Providers' discretion.

As a neutral host network, allowing Service Providers to assign different values to coverage in specific areas aligned with their coverage goals is advantageous. For example, a Service Provider is likely to boost hexes following the concentration of their Subscribers.

Rather than the Network automatically deciding which hexes to boost, this HIP proposes that Service Providers act as Oracles on the Network and can access discovery mapping data and boost hexes of interest by staking MOBILE to the hexes in relevant areas.

This HIP addresses only the mechanics for rewarding Mappers, and a separate, subsequent HIP to establish the mechanisms for Service Provider hex boosting will be needed.

### Verification Mapping Rewards

Following [HIP-74](https://github.com/helium/HIP/blob/main/0074-mobile-poc-modeled-coverage-rewards.md) approval, the purpose of mapping is to verify or invalidate modeled coverage.

Mappers accomplish this by measuring the Radio signal strength within a given res12 hex at a specific time and reporting this data to the MOBILE rewards Oracle. The MOBILE rewards Oracle will then use this information to adjust Coverage rewards for the mapped Radios.

The MOBILE rewards Oracle's objective is to gather up-to-date measurements across a random distribution of Radios from Mappers such that a given Radio's signal aligns with the modeled coverage with reasonable confidence.

For example, a single Mapper on a desk next to a Radio, consistently reporting the same signal for the same Radio in the same hex, produces much less value for the Network than a Mapper reporting measurements across various res12 hexes for many unique Radios.

The reward point system for Mappers should incentivize the following behavior:

Report readings across more than one res12 hex for each Radio.
Not re-verify a given Radio within a specific interval.
Validate as many unique Radios as possible during a reward period rather than a single Radio every reward period.

Given the above, this HIP proposes the following framework for Discovery Mapping reward points:

- Each modeled coverage res12 hex "charges up" by accumulating one reward point per hour to a maximum of 168 hours (7 days).
- A Mapper completes verification by attempting to connect to a Radio inside a mapped hex and reporting success/failure with a timestamp and GPS location.
- Verification of a hex awards the accumulated reward points to the verifying Mapper
- Verification of a hex resets, or "discharges," the hex to zero reward points and reduces the reward points of all adjacent hexes by 50%.
- A maximum of 672 points can be earned by a single Mapper to verify the same Radio during any 7-day period.

### Example Reward Calculations for Mappers

Use [this spreadsheet](https://docs.google.com/spreadsheets/d/1nDYbj4APWg_XEeGEsLdR17CW8q2EiuEqoLKs_I6T1Dc/edit#gid=1971124829) to experiment with values.

| Item                                              |       Rewards |
| :------------------------------------------------ | ------------: |
| Total MOBILE Tokens Minted Monthly                | 5,000,000,000 |
| Total MOBILE Tokens Minted in 24 Hours            |   164,383,561 |
| Total MOBILE Token Pool for Mappers (20%)         |    32,876,712 |
| Fixed 24 hour Reward Points for Discovery Mapping |            30 |
| Average 24 hour Reward Points for Mapper\*        |           168 |
| Active Discovery Mappers (Subscribers/Phones)     |        10,000 |
| Active Verification Mappers                       |         2,000 |
| Total Reward Points Earned by All Mappers         |       636,000 |
| MOBILE Earned per Discovery Mapper                |     **1,572** |
| MOBILE Earned per Verification Mapper             |     **8,805** |

\*Assume it mapped 2 semi-charged hexes

### Adjusting Hotspot Rewards Based on Mapper Input

The Mobile PoC Working Group has discussed and documented a potential path to adjust MOBILE Hotspot rewards using the data collected by Mappers that would utilize the concept of the confidence score. A detailed description of the current thinking and community comments are available [here](files/0079/adjusting_hotspot_rewards_based_on_mapper_input.pdf).

The Mobile PoC Working Group has decided to postpone the final decision regarding the specific algorithm to the second stage of Mapper reward implementation. This approach would create Hotspot rewards adjustment algorithms based on the actual data from mapping activity vs. speculating regarding variables and weights.

### Mapper subDAO

The Mobile PoC Working Group has also agreed to initiate work on a Mapper subDAO. The Mapper subDAO would enable Mappers to provide usable data across various networks - IoT, MOBILE, Wi-Fi, and others - and receive incentives for mapping macro operator coverage. After implementing a Mapper subDAO, Mobile subDAO will become one of the first “customers” of Mapper subDAO.

### Location Sharing Details

#### Subscribers

Subscribers will share detailed location information with their Service Providers, allowing them to define which hexes to boost. Service Providers voted to participate in Helium Mobile subDAO are required to keep exact subscriber mobile location data confidential. The specific confidentiality terms are subject to the service agreement between each particular service provider and the subscribers.

Subscribers will share binary information about whether location sharing event has occurred and the timestamp of the event to the Mobile Oracle for reward eligibility determination. Service Providers will verify the information Subscribers share before it is sent to the Mobile Oracle to prevent gaming.

#### Mappers

Mappers will share the location of res12 hex where the attach event occurred with the Mobile Oracle for reward eligibility determination and use by other services like Modeled Coverage Planner.

## Drawbacks

There are no obvious drawbacks.

## Rationale and Alternatives

No viable alternatives exist, as the alternative to not use Mappers and continue relying on individual self-certification of Radios is prone to gaming.

## Unresolved Questions

This HIP proposes moving forward with mapping rewards without creating a final algorithm for adjusting Radio coverage rewards. Instead, the Mobile PoC Working Group has decided that such an adjustment will follow the review of data collected by mapping.

For discovery mapping, this HIP proposes the approach for uncovering hexes with likely high concentrations of Network users. However, it does not outline how this information can incentivize coverage at such locations over any other. The Mobile PoC Working Group will make a separate proposal that describes how Service Providers on the network can boost locations with a high likelihood of traffic usage by staking MOBILE in a separate HIP.

## Deployment Impact

The deployment will kickstart the emission of MOBILE Mappers reward at an increased 20% and rewarding of Subscribers and Mappers once they join the network and start mapping activities.

It will also reduce the emissions of the MOBILE rewards to 10% for Service Providers once they join the Mobile Network.

Deployment of this HIP will require the following:

- Onboarding Mappers and Subscribers to the Solana blockchain with NFTs, similar to onboarding Hotspots.
- Adjusting the Mappers rewards bucket to 20% of emitted MOBILE.
- Integration of the discovery mapping data from the Subscriber app and verification mapping data from Mappers with Mobile rewards Oracle.
- Implementation of the hex recharge algorithm on the Mobile rewards Oracle.
- Implement the rewarding algorithm on the Mobile rewards Oracle that determines Mapper and Subscriber rewards for specific mapping activities.
- Visualization of the mapped hexes with a tool similar to Modeled Coverage Explorer.
- Updates to [documentation](https://docs.helium.com/).

## Success Metrics

For verification mapping, the critical success metric is the number of modeled coverage hexes that have been validated or invalidated by mapping activity.

For discovery mapping, the critical success metric is the number of Subscribers that opted in to share data usage and location with the network and, as a byproduct, whether or not this information uncovers sufficient concentration of data usage in certain areas, such that it is useful for making Hotspot deployment decisions.
