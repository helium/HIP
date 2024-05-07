# HIP 82: Add Helium Mobile as a Service Provider to the Helium Mobile subDAO

- Author(s): [@zer0tweets](https://github.com/zer0tweets), [@meowshka](https://github.com/meowshka) (Nova Labs, Inc.), [@Max Gold](https://github.com/Maxgold91), [@KeithRettig](https://github.com/Rettig)
- Start Date: 2023-03-15
- Category: Economic, Technical
- Original HIP PR: #581
- Tracking Issue: #628
- Voting Requirements: veMOBILE Holders

## Summary

This HIP proposes to introduce Helium Mobile as a Service Provider (as defined in [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview)) on the Mobile Network. The main goal is to bring usage to the Network and pave the way for other Service Providers to join. The HIP describes integration with the Helium Mobile Network, an anti-gaming mechanism, and overall impact on the Network.

## Motivation

The Community has gone a long way in building the Helium Mobile Network. Now is the perfect time to bring usage and utility to it.

As a Service Provider member of the Helium Mobile subDAO, Helium Mobile will actively offload its subscriber traffic onto the Helium Mobile Network. The launch of the Helium Mobile carrier will help pave the way for other Service Providers coming to the Helium Mobile Network by ironing out any undiscovered issues and creating a smooth onboarding process. In addition, the increased traffic on the network as a result of the launch will have a commensurate increase in HNT burn and data rewards for Hotspot operators.

## Stakeholders

This HIP affects:

- Subscribers interested in using a crypto-carrier for cellular services - will benefit by having inexpensive, private cellular Service and being enabled to get rewards for improving the Network.
- Mobile carrier partners of Helium Mobile - will have an economic opportunity to increase revenue by sharing their mobile infrastructure.
- Owners of Hotspots with active Radios - will be rewarded for providing data access to Subscribers.
- Helium Mobile - will have an opportunity to provide cellular Service to Subscribers and earn rewards.
- Holders of HNT and MOBILE tokens - we anticipate an increase in utility of both HNT and MOBILE.

## Detailed Explanation

The staking amount, rewards, and responsibilities of Helium Mobile as a Service Provider will follow those outlined in [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md).

### Onboarding to the Helium Mobile Network

In compliance with HIP53 staking requirements for Service Providers, Helium Mobile will stake 500M MOBILE for the right to operate as a Service Provider on the Helium Mobile Network.

Once the required amount is staked, the Helium Mobile Service Provider will be minted as an NFT by the ‘Helium entity manager’ smart contract on the Solana blockchain and will become a rewardable entity.

This stake will need to remain locked and will not earn any staking rewards, as long as the Service Provider remains as part of the MOBILE subDAO. In lieu of staking rewards, the Service Provider has the right to claim up to 10% of MOBILE rewards (provided [HIP79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md) passes) in the Service Provider bucket.

This HIP requires a cooldown period of 90-days after a public announcement by the Service Provider of its intention to cease data offloading on Helium's mobile network before it can stop such data offloading. An additional 90-day cooldown period will be required before the Service Provider can claim the tokens they staked for the right to operate as a Service Provider on Helium's mobile network.

### Data Offloading to the Helium Mobile Network

Helium Mobile will operate as a roaming partner on Helium's mobile network using Data Credits (DC) to pay for data transfer at a minimum price of $0.50 per 1 GB as specified in HIP53. Any changes to the minimum price for data transfer anywhere on Helium's mobile network must be approved by MOBILE subDAO vote. More specific regional or individual radio pricing options above the minimum price can be set by Helium Mobile but are subject to approval by MOBILE subDAO vote.

Where Helium Mobile Network coverage is unavailable, Helium Mobile will rely on the additional coverage provided by their current Mobile Network Operator (MNO), T-Mobile. The partnership of Nova Labs with their MNO allows Helium Mobile subscribers to access both nationwide 5G coverage by the MNO and the growing Helium Mobile Network, which, due to its people-driven nature, is available in places that are hard to reach and acquire by traditional service providers.

More details about Nova Labs and T-Mobile partnership can be found in the [press release](https://www.webwire.com/ViewPressRel.asp?aId=294475).

### Governance

HIP53 specifies two conditions which a Service Provider needs to meet to be allowed to operate on the Mobile Network:

- Stake a minimum of 500M MOBILE,
- Obtain MOBILE subDAO governance approval.

Once voted in as a Service Provider, the operation of Helium Mobile on the Mobile Network should be governed with subsequent HIPs, until a new process of governance is created.

### Data Reward Limits for Hotspot Owners and Gaming Prevention for Unlimited Plans

Helium Mobile specifically plans to launch an Unlimited Plan offering to the market as part of its line-up and is faced with solving a potential gaming problem. Helium Mobile rewards Hotspots for data on a per GB basis. This creates a potential gaming loophole whereby a person can purchase an unlimited plan for a fixed price and then stream movies and shows from a streaming service 24/7 through their own hotspots to rake up massive rewards.

We propose a basic anti-gaming mechanism for unlimited plans that is Helium Mobile-specific. This means that other carriers planning to join the Helium Mobile Network can propose their own algorithms or none.

For Helium Mobile unlimited plans we propose to set the limit on rewardable data that each Subscriber can send to the Helium MOBILE subDAO during the 30-day billing cycle. We propose that this limit is expressed in terms of gigabytes and equal to $COST_of_Subscription / $0.50 (price per GB set by MOBILE subDAO). For instance, if a subscriber purchases a Helium Mobile unlimited subscription for $20, the maximum number of rewardable gigabytes to be sent to the Helium network is $20/$0.50 = 40. 40 Gb will be the rewardable limit to the network for this subscriber. As such, the total value of MOBILE rewards received by all hotspots for servicing any unique unlimited plan cannot exceed the price for which the plan was purchased; thus decreasing the incentive to game.

The rewardable limit will reset at the start of a new 30-day billing cycle for each Subscriber with an unlimited data plan. The data traffic cap is not limited to a particular Hotspot. It is applicable to all Hotspots that provide data for a specific Subscriber.

It’s important to note that Helium Mobile offers an unlimited plan without data caps for Subscribers. This means that the data offloading will still continue after the maximal rewardable limit is reached, however Hotspot Owners won’t earn MOBILE rewards for providing data traffic to such Subscribers. Additionally, DCs won’t be burned from the Helium Mobile Carrier account for the data traffic routing after the data caps are reached for Subscribers.

Additionally, we propose a 6 calendar month grace period to allow for unrewarded traffic over rewardable limit on the Hotspots. Nova Labs will implement an option to opt-in for unrewarded data traffic in a Cloud Dashboard or similar tool no later than the expiration of the grace period. 6 month countdown will start on the day this HIP is approved. The default setting will be for radios to opt-out of allowing unrewarded traffic; it will require operators to manually opt-in before unrewarded traffic can be transferred on their radios.

If Nova Labs fails to implement the opt-in feature past the expiration of the grace period, the reward cap is to be completely removed on the day of the expiration of the grace period and will remain so until Nova Labs has implemented the opt-in feature.

Helium Mobile shall provide a subscriber usage report to the MOBILE subDAO on a minimum of a yearly basis, on the 1st of August, if not on a continual basis, such as a dashboard. The report will present information about how much data traffic has been transferred; indicating the amount of rewarded traffic and unrewarded traffic by subscriber plan.

Approval of this approach is necessary for Helium Mobile to start offloading data to the Helium Mobile Network.

## Implementation

We leave the implementation of the smart contract components, verifiability, and Service Provider compliance up to the Helium Core Developers to determine.
We note that staking MOBILE to become a Service Provider locks up MOBILE independently of veMOBILE, meaning that a Service Provider does not get governance rights in addition to Service Provider rights.

## Drawbacks

The only drawback of this proposal is related to the anti-gaming mechanism. In rare cases a Hotspot Owner might not get rewarded for the data traffic they provide if the Subscriber of the unlimited plan uses all the rewardable data per a 30-day billing cycle.

## Unresolved Questions

Staking mechanics for Service Providers on the Solana blockchain.

## Dependencies

Nova Labs has done most of the work necessary to launch the Helium Mobile carrier on the data offloading, customer tooling and support flows side. Launch of staking, Hotspot rewards, and other blockchain related functionality is dependent on the Solana migration and the successful implementation of these features by Helium Core Developers.

## Deployment Impact

- Hotspot owners will start earning MOBILE rewards for the data transfer work.
- Service Providers will be able to offload data traffic to the Helium Mobile Network and receive Service Provider rewards.
- Subscribers to Helium Mobile will be able to opt-in to earn MOBILE rewards for discovery mapping activity (provided [HIP79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md) passes).

## Success Metrics

The main success metric would be cellular data being offloaded to the Helium Mobile Network by the Helium Mobile Service Provider, creating increased utility for HNT and MOBILE.
