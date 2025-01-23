# HIP 142: Add Inversion Capital as an International Service Provider to the Helium Mobile Network
 
- Author: [inversioncapital](https://github.com/inversioncapital)
- Start Date: 2025-01-22
- Category: Economic, Technical
- Original HIP PR: [#1152](https://github.com/helium/HIP/pull/1152)
- Tracking Issue: [#1154](https://github.com/helium/HIP/issues/1154)
- Voting Requirements: veHNT holders

---


## Summary

In this document, we propose to introduce Inversion Capital as the second Service Provider on the Helium Mobile Network, with a focus on international markets. The main goals are to expand the Helium Mobile Network's global presence and increase network demand.

## Motivation

The Helium Mobile Network has demonstrated success with its first Service Provider in the US market. However, to achieve true decentralization and global adoption, the network needs Service Providers focused on international markets. 

As a private equity fund specializing in crypto-enabled business transformation, Inversion Capital is well-positioned to:
- Expand Helium Mobile's presence in international markets through large-scale deployment strategies
- Drive adoption through acquiring traditional MVNOs and migrating their offload to the Helium Network
- Contribute to the network's decentralization by becoming its second Service Provider

## Stakeholders

This HIP affects:
- International mobile users seeking affordable cellular services
- Hotspot owners globally who will benefit from increased network usage
- Holders of HNT tokens through increased utility and adoption
- The Helium Mobile Network through expanded global presence

## Detailed Explanation

### Inversion Capital Investment Strategy

Inversion Capital (“Inversion”) is a private equity firm that acquires established businesses and leverages crypto elements to transform operations, eliminate inefficiencies, and unlock new value. A core pillar of Inversion’s investment strategy is leveraging DePIN networks to structurally reduce costs in traditional businesses while scaling demand for DePIN networks.

Inversion Capital is currently reviewing several potential MNVO acquisition targets globally. Once an asset is acquired, Inversion plans to integrate the MVNO as a roaming partner on the Helium Mobile Network, following all outlined Service Provider policies specified in [HIP-53][hip-53]. We expect to acquire or roll-up several MVNO targets with millions of existing subscribers, creating immediate demand for data credits and HNT burn in new, global markets.

### Service Provider Onboarding

In compliance with [HIP-53][hip-53], Inversion Capital will complete the staking requirement to become a Service Provider. [HIP-53][hip-53] required Service Providers to stake 500 million MOBILE tokens. However, given the network’s migration back to a single token standard, Inversion will stake 75,000 HNT to fulfill the requirement pari passu with a MOBILE total stake value in USD. Once the required amount is staked, the Inversion Capital Service Provider will be minted as an NFT by the ‘Helium entity manager’ smart contract on the Solana blockchain and will become a rewardable entity.

This stake will remain locked and will not earn any staking rewards, as long as the Service Provider remains as part of the Helium Mobile Network.

To match the initial Helium Mobile Service Provider cooldown requirements, this HIP requires a cooldown period of 90-days after a public announcement by the Service Provider of its intention to cease data offloading on Helium's mobile network before it can stop such data offloading. An additional 90-day cooldown period will be required before the Service Provider can claim the tokens they staked for the right to operate as a Service Provider on Helium's mobile network.

### Service Provider Rewards

[HIP-53][hip-53] created a rewards allocation bucket for Service Providers to support their ongoing operations and assist in growing their subscriber base. Rewards from the emissions contract are distributed between Service Providers, Mappers and Hotspot Operators as a function of the incentive points earned during a period of time.

Service Providers initially earned 20% of all MOBILE tokens minted by the DAO emissions curve, which will be distributed as a function of the number of incentive points accumulated by Service Provider participants during a given hour. Incentive points are issued using the following rules:
- Service Provider receives 1 point for each of the mappers that used a SIM from this Service Provider and witnessed the network
- Service Provider receives 3 points for each $1 worth of DCs settled in state channels

[HIP-79][hip-79] revised the Service Provider rewards allocation to 10% of all MOBILE tokens minted.

[HIP-138][hip-138] returns the Helium Network back to one token: HNT. However, [HIP-138][hip-138] did not specifically mention including the Service Provider allocation as part of the new HNT reward structure. This HIP codifies that Service Providers earn 10% of all HNT emissions of the Mobile Network's allocation, following the exact incentive point formula outlined in [HIP-53][hip-53].

It’s important to note that Inversion Capital, as an approved Service Provider, will not earn any HNT emissions until it contributes valuable data offloading to the network based on the Incentive Point formula in [HIP-53][hip-53].

## Implementation

We leave the implementation of the smart contract components, verifiability, and Service Provider compliance up to the Helium Core Developers to determine. We note that staking HNT to become a Service Provider locks up HNT independently of veHNT, meaning that a Service Provider does not get governance rights in addition to Service Provider rights.

## Success Metrics

The main success metric is cellular data being offloaded to the Helium Mobile Network by the Inversion Capital Service Provider, creating increased utility for HNT.


[hip-53]: ./0053-mobile-dao.md
[hip-79]: ./0079-mobile-poc-mappers-rewards.md
[hip-138]: ./0138-return-to-hnt.md
