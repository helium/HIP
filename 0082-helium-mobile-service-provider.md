# HIP 82: Add Helium Mobile as a Service Provider to the Helium Mobile subDAO

- Author(s): [@zer0tweets](https://github.com/zer0tweets), [@meowshka](https://github.com/meowshka) (Nova Labs, Inc.)
- Start Date: 2023-03-15
- Category: Economic, Technical
- Original HIP PR: #581
- Tracking Issue: #628
- Voting Requirements: veMOBILE Holders

## Summary

This HIP proposes to introduce Helium Mobile as a Service Provider (as defined in [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview)) on the Mobile Network. The main goal is to bring usage to the Network and pave the way for other Service Providers to join. The HIP describes integration with the Helium Mobile Network, an anti-gaming mechanism, and overall impact on the Network.

## Motivation

The Community has gone a long way in building the Helium Mobile Network. Now is the perfect time to bring usage and utility to it.

As a Service Provider member of the Helium Mobile subDAO, Helium Mobile will actively offload its subscriber traffic onto the Helium Mobile Network. The launch of the Helium Mobile carrier will help pave the way for other Service Providers coming to the Helium Mobile Network by ironing out any undiscovered issues and creating a smooth onboarding process.  In addition, the increased traffic on the network as a result of the launch will have a commensurate increase in HNT burn and data rewards for Hotspot operators.

## Stakeholders

This HIP affects:

- Subscribers interested in using a crypto-carrier for cellular services - will benefit by having inexpensive, private cellular Service and get rewards from Helium Mobile for improving the Network.
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

This HIP proposes a cooldown period of 3 months before the Service Provider can claim the staked amount after it stops data offloading to the Helium Mobile Network.

### Data Offloading to the Helium Mobile Network

Helium Mobile will operate as a roaming partner of the Helium Mobile Network, using core Mobile coverage and paying DC for the data transfer at $0.5 per 1 GB as specified in HIP53.

Where Helium Mobile Network coverage is unavailable, Helium Mobile will rely on the 5G coverage provided by T-Mobile. The partnership of Nova Labs with T-Mobile allows Helium Mobile subscribers to access both nationwide 5G coverage by T-Mobile and the growing Helium Mobile Network, which, due to its people-driven nature, is available in places that are hard to reach and acquire by traditional service providers.

More details about Nova Labs and T-Mobile partnership can be found in the [press release](https://www.webwire.com/ViewPressRel.asp?aId=294475).

### Service Provider Rewards

HIP53 specifies an overall rewards bucket for Service Providers, but does not go into specifics how rewards should be calculated based on the amount of data being offloaded. To prevent a scenario in which a Service Providers is rewarded the full 10% MOBILE reward bucket (Provided [HIP79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md) passes) while burning little to no DC, we propose to follow a similar usage-based approach as outlined in [HIP10](https://github.com/helium/HIP/blob/main/0010-usage-based-data-transfer-rewards.md) for the IoT Network.

We propose that Service Providers are rewarded up to 1:1 in MOBILE tokens for the amount of DC burned during a reward period, similar to the approach in HIP10. If the Service Providers collectively burn more DC than the equivalent amount of MOBILE tokens in the Service Provider reward bucket, a Service Provider will be rewarded proportionally to its share of DC burn. If the Service Providers collectively burn less DC than the equivalent amount of MOBILE tokens the remainder of the Service Provider bucket will not be minted.

To illustrate, here are two scenarios:

- Value of DCs burned for data traffic is less than the Service Provider reward bucket (10% of MOBILE emissions).

|                       |                   |
| ----------------------| ----------------- |
| DCs burned by SP      | 100,000,000       |
| Price of DC           | $0.00001          |
| Price of MOBILE**      | $0.0001           |
| DCs burned in MOBILE***| 10,000,000        |
| 10% SP bucket         | 0.5B MOBILE       |
| SP rewards            | 10,000,000 MOBILE |


** The price chosen is an example, not the actual price. The actual price will be determined by the Price Oracle on the Solana blockchain during the rewards calculation time.

*** Amount of MOBILE tokens with the same value as the value of the DCs burned by SP: (10,000 DC * $0.00001 (fixed price of DC) / $0.0001 (example price of MOBILE))

- Value of DCs burned for data traffic exceeds the Service Provider reward bucket (10% of MOBILE emissions).

|                       |                   |
| ----------------------| ----------------- |
| DCs burned by SP      | 100,000,000,000   |
| Price of DC           | $0.00001          |
| Price of MOBILE**     | $0.0001           |
| DCs burned in MOBILE  | 10B               |
| 10% SP bucket         | 0.5B MOBILE       |
| SP rewards            | 0.5B MOBILE       |

### Governance 

HIP53 specifies two conditions which a Service Provider needs to meet to be allowed to operate on the Mobile Network:

- Stake a minimum of 500M MOBILE,
- Obtain MOBILE subDAO governance approval.

Once voted in as a Service Provider, the operation of Helium Mobile on the Mobile Network should be governed with subsequent HIPs, until a new process of governance is created.

### Data Reward Limits for Hotspot Owners and Gaming Prevention for Unlimited Plans

Helium Mobile specifically plans to launch an Unlimited Plan offering to the market as part of its line-up and is faced with solving a potential gaming problem.  Helium Mobile rewards Hotspots for data on a per GB basis. This creates a potential gaming loophole whereby a person can purchase an unlimited plan for a fixed price that then streams movies and shows from a streaming service 24/7 through their own hotspots to rake up massive rewards.

We propose a basic anti-gaming mechanism for unlimited plans that is Helium Mobile-specific. This means that other carriers planning to join the Helium Mobile Network can propose their own algorithms or none.

For Helium Mobile unlimited plan we propose to set the limit for the data traffic rewards for Hotspot Owners based on the amount of traffic each Subscriber uses with an unlimited plan. We’ve analyzed average data usage and determined that setting a cap at 30GB of rewardable data per 30-day billing cycle, per subscriber would be sufficiently high. It reflects normal data consumption and does not unreasonably prevent MOBILE earnings for Hotspot Owners. In fact, we anticipate most of the usage will fall below that number.

The 30GB rewards limit will reset with a start of a new 30-day billing cycle for each Subscriber with an unlimited data plan. The data traffic cap is not limited to a particular Hotspot. It is applicable to all Hotspots that provide data for a specific Subscriber.

It’s important to note that Helium Mobile offers an unlimited plan without data caps for Subscribers. This means that the data offloading will still continue after the 30GB usage is reached, however Hotspot Owners won’t earn MOBILE rewards for providing data traffic to such Subscribers. Additionally, DCs won’t be burned from the Helium Mobile Carrier account for the data traffic routing after the data caps are reached for Subscribers.

Additionally, we propose a one-year grace period to allow for unrewarded traffic over 30GB per Subscriber on the Hotspots. Nova Labs will implement an option to opt-out of unrewarded data traffic in a Cloud Dashboard or similar tool no later than the expiration of the grace period. The reward cap of 30GB per Subscriber of the unlimited plan will remain in place after the opt-out feature is implemented.

We do not anticipate that the 30GB data cap will be reached frequently. Nevertheless, we will closely analyze the data usage of our Subscribers and quickly iterate on solutions in order to ensure all members of the Network will be appropriately rewarded for legitimate use of the Network.

Approval of this approach is necessary for Helium Mobile to start offloading data to the Helium Mobile Network.

## Implementation

We leave the implementation of the smart contract components, verifiability, and Service Provider compliance up to the Helium Core Developers to determine.
We note that staking MOBILE to become a Service Provider locks up MOBILE independently of veMOBILE, meaning that a Service Provider does not get governance rights in addition to Service Provider rights.

## Drawbacks

The only drawback of this proposal is related to the anti-gaming mechanism. In rare cases a Hotspot Owners might not get rewarded for the data traffic they provide if the Subscriber of the unlimited plan uses all the rewardable data per the limited 30GB per 30-day billing cycle.

## Unresolved Questions

Staking mechanics for Service Providers on the Solana blockchain.

## Dependencies

Nova Labs has done most of the work necessary to launch the Helium Mobile carrier on the data offloading, customer tooling and support flows side. Launch of staking, Hotspot rewards, and other blockchain related functionality is dependent on the Solana migration and the successful implementation of these features by Helium Core Developers.

## Deployment Impact

- Hotspot owners will start earning MOBILE rewards for the data transfer work.
- Service Providers will be able to offload data traffic to the Helium Mobile Network and receive Service Provider rewards.
- Subscribers to the Helium Mobile will be able to opt-in to earn MOBILE rewards for discovery mapping activity (provided [HIP79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md) passes).

## Success Metrics

The main success metric would be cellular data being offloaded to the Helium Mobile Network by the Helium Mobile Service Provider, creating increased utility for HNT and MOBILE.
