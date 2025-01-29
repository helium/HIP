# HIP 143: Update Helium’s Data Pricing Structure to Support Multi-Geography Expansion

- Author: [inversioncapital](https://github.com/inversioncapital)
- Start Date: 2025-01-29
- Category: Economic, Technical
- Original HIP PR: [#1153](https://github.com/helium/HIP/pull/1153)
- Tracking Issue: [#1155](https://github.com/helium/HIP/issues/1155)
- Voting Requirements: veHNT holders

---

## Summary

In this HIP, we propose a dynamic pricing model for data transfer that accounts for regional variations in wholesale data costs. The main goals are to expand the Helium Mobile Network's global presence, increase network demand, and establish a more equitable pricing structure for international markets.

## Motivation

The Helium Mobile Network has demonstrated success with its first Service Provider in the US market. However, to achieve true decentralization and global adoption, the network needs Service Providers focused on international markets. Additionally, the current fixed pricing model ($0.50/GB) doesn't account for significant variations in wholesale data costs across different regions, potentially limiting network growth in markets where this price point is not competitive.

In order to support Helium’s expansion into global markets, a new dynamic pricing formula for data must be defined.

## Stakeholders

This HIP affects:
- International mobile users seeking affordable cellular services
- Hotspot owners globally who will benefit from increased network usage
- Holders of HNT tokens through increased utility and adoption
- The Helium Mobile Network through expanded global presence

## Detailed Explanation

### Dynamic Regional Pricing Model

[HIP-53][hip-53] initially laid out a fixed $0.50/GB price for the Helium Mobile Network. While this initial pricing model works for the United States where Helium Mobile is currently live, the pricing model must be revised to support expansion into new international markets.

Wholesale data costs vary widely across markets. For example, in the U.S., wholesale data pricing can range from $1.50-$5.00/GB, depending on volume. In markets like the UK, pricing can be as low as $0.50 or less from traditional MNOs depending on volume - the same price as Helium’s current fixed data price. For Helium to remain competitive and scale internationally - and thus scale network demand - it must revise its Mobile pricing strategy.

We propose implementing a region-based pricing model where the price for data transfer will be set at 25% of each region's average volumetric wholesale data rate. This percentage is what Nova Labs, as the first Helium Service Provider, pays the network based on U.S. average wholesale rates. JP Morgan research estimates MVNOs typically pay ~$2/GB to MNOs for access to their network; Helium Mobile’s $0.50/GB rate is 25% of this figure. 

Moving to a percentage of average wholesale price approach should better reflect wholesale data price variations across regions, while ensuring Helium’s competitive cost advantage drives network traffic and demand.

We propose that the Helium Foundation maintain responsibility for tracking, reporting, and verifying the regional market wholesale pricing index to use for Helium Network pricing. The index should be updated on regular 6 month intervals.

## Implementation

We leave the implementation of the smart contract components, verifiability, and Service Provider compliance up to the Helium Core Developers to determine. We note that staking HNT to become a Service Provider locks up HNT independently of veHNT, meaning that a Service Provider does not get governance rights in addition to Service Provider rights.

## Success Metrics

The main success metric is cellular data being offloaded to the Helium Mobile Network by the Inversion Capital Service Provider, creating increased utility for HNT.

[hip-53]: ./0053-mobile-dao.md
