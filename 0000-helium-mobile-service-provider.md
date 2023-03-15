# HIP Add Helium Mobile as a Service Provider to the Helium Mobile subDAO

- Author(s): [@zer0tweets](https://github.com/zer0tweets), [@meowshka](https://github.com/meowshka) (Nova Labs, Inc.)
- Start Date: 2023-03-15
- Category: economic, technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

This HIP proposes to introduce Helium Mobile as a Service Provider (as defined in [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview)) on the Mobile Network. The main goal is to bring usage to the Network and pave the way for other Service Providers to join. The HIP describes integration with Helium Mobile Network, anti-gaming mechanism, and overall impact on the Network.

## Motivation

The Community has gone a long way in building Helium Mobile Network, and now is the perfect time to bring usage and utility to it.

As a Service Provider member of Helium Mobile subDAO, Helium Mobile will actively offload its subscriber traffic into the Helium Mobile Network.  Launch of Helium Mobile carrier will help pave the path for other Service Providers coming to the Network by ironing out any undiscovered issues and creating a smooth onboarding process.  In addition, the increased traffic on the network as a result of the launch will have a commensurate increase in HNT burn and data rewards for Hotspot operators.

## Stakeholders

This HIP affects:

- Subscribers interested in using a crypto-carrier for cellular services will benefit by having inexpensive, private cellular Service and get rewards from Helium Mobile for improving the Network.
- Mobile carrier partners of Helium Mobile will have an economic opportunity to increase revenue by sharing their mobile infrastructure.
- Owners of Hotspots with active Radios will be rewarded for providing data access to Subscribers.
- Helium Mobile will have an opportunity to provide cellular Service to Subscribers and earn rewards.
- Holders of HNT and MOBILE tokens as we anticipate an increase in utility of both HNT and MOBILE.

## Detailed Explanation

The staking amount, rewards, and responsibilities of Helium Mobile as a Service Provider will follow those outlined in the [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md).

### Staking

In compliance with HIP53 staking requirements for Service Providers, Helium Mobile will stake 500M MOBILE for the right to operate as a Service Provider on the Helium Mobile subDAO.

### Integration with Helium Mobile Network

Helium Mobile will operate as a roaming partner of Helium Mobile Network, using core Mobile coverage and paying DC for the data transfer at $0.5 per 1 GB as specified in HIP53.

Where Helium Mobile Network coverage is unavailable, Helium Mobile will rely on the 5G coverage provided by T-Mobile. The partnership of Nova Labs with T-Mobile allows Helium Mobile subscribers to access both nationwide 5G coverage by T-Mobile and the growing Helium Mobile Network, which, due to its people-driven nature, is available in places that are hard to reach and acquire by traditional service providers.

More details about Nova Labs and T-Mobile partnership can be found in the [press release](https://www.webwire.com/ViewPressRel.asp?aId=294475).

### Data Reward Limits and Gaming Prevention for Unlimited Plans

Helium Mobile specifically plans to launch an Unlimited Plan offering to the market as part of its line-up and is faced with solving a potential gaming problem.  Helium Mobile rewards Hotspots for data on a per GB basis. This creates a potential gaming loophole whereby a person can purchase an unlimited plan for a fixed price that then streams movies and shows from a streaming service 24/7 through their own hotspots to rake up massive rewards.

We propose a basic anti-gaming mechanism for unlimited plans that is Helium Mobile-specific. This means that other carriers planning to join the Helium Mobile Network can propose their own algorithms or none.

For Helium Mobile unlimited plan we propose to set the limit for the data traffic rewards for Hotspot Owners based on the amount of traffic each Subscriber uses with an unlimited plan. We’ve analyzed average data usage and determined that setting a cap at 30GB of rewardable data per 30-day billing cycle, per subscriber would be sufficiently high. It reflects normal data consumption and does not unreasonably prevent MOBILE earnings for Hotspot Owners. In fact, we anticipate most of the usage will fall below that number.

The 30Gb rewards limit will reset with a start of a new 30-day billing cycle for each Subscriber with an unlimited data plan. The data traffic cap is not limited to a particular Hotspot. It is applicable to all Hotspots that provide data for a specific Subscriber.

It’s important to note that Helium Mobile offers an unlimited plan without data caps  for Subscribers. This means that the data offloading will still continue after the 30Gb usage is reached, however Hotspot Owners won’t earn MOBILE rewards for providing data traffic to such Subscribers. Additionally, DCs won’t be burned from the Helium Mobile Carrier account for the data traffic routing after the data caps are reached for Subscribers.

We don’t anticipate data caps to be reached frequently. Nevertheless, we will closely analyze usage on the Network and quickly iterate on solutions to ensure all members of the Network can earn rewards for legitimate use of the Network.

Approval of this approach is necessary for Helium Mobile to start offloading data to the Helium Mobile Network.

## Drawbacks

The only drawback of this proposal is related to anti-gaming mechanism. In rare cases Hotspot Owners might not get rewarded for the data traffic they provide, when the Subscriber of unlimited plan uses all the rewardable data limited to 30Gb per 30-day billing cycle.

## Dependencies

Nova Labs has done most of the work necessary to launch the Helium Mobile carrier on the data offloading, customer tooling and support flows side. Launch of staking, Hotspot rewards, and other blockchain related functionality is dependent on the Solana migration.

## Success Metrics

The main success metric would be cellular data being offloaded to the Helium Mobile Network by the Helium Mobile Service Provider.
