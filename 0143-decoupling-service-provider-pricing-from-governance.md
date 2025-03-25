# HIP 143: Decoupling Service Provider Pricing from Governance

- Author: [inversioncapital](https://github.com/inversioncapital), [zer0tweets](https://github.com/zer0tweets), [Nova Labs](http://nova.xyz)
- Start Date: 2025-01-29
- Category: Economic, Technical
- Original HIP PR: [#1153](https://github.com/helium/HIP/pull/1153)
- Tracking Issue: [#1155](https://github.com/helium/HIP/issues/1155)
- Voting Requirements: veHNT holders

---

## Summary

This HIP proposes that Nova Labs act as a settlement intermediary between the Helium Network and any network operator using the network, regardless of country. This proposal does not change the cost of data on the network.

## Motivation

The Helium Network is currently used by multiple network operators in the U.S. and one in Mexico, with more expected to join. Each network operator has its own pricing model for Wi-Fi data. Some pay per gigabyte (GB), others pay a flat-rate per month, and some set limits on a per user or per plan basis.

Meanwhile, the Helium Network pays Hotspots a fixed rate of $0.50 per GB of data transfer. Creating separate pricing models for each provider through governance votes is currently complex and time-consuming.

This proposal allows Nova Labs to independently negotiate agreements with network operators while paying for usage of the Helium Network at $0.50 per GB (as outlined in HIP 27) and rewardable cap rules (as outlined in HIP 82). 

## Stakeholders

This HIP affects:
- International mobile users seeking affordable cellular services
- Hotspot owners globally who will benefit from increased network usage
- Holders of HNT tokens through increased utility and adoption
- The Helium Mobile Network through expanded global presence

## Detailed Explanation

Nova Labs already manages contracts with several U.S. network operators, who pay varying rates and apply different data caps based on their internal policies. Nova Labs then converts dollar payments into HNT that is burned to get data credits, ensuring the network is paid $0.50 per GB. Nova also manages subscriber rewardable data caps to align with HIP 82 rules, ensuring that certain types of subscribers (i.e. unlimited plans) do not pay for the traffic when their rewardable data caps have been exceeded. 

This proposal aims to formally extend this existing process to Mexico and other countries, making it easier to onboard providers like Telefónica and others in new regions.

## Implementation

We leave the implementation of the smart contract components, verifiability, and network operator compliance up to the Helium Core Developers to determine.

## Success Metrics

The main success metric is cellular data being offloaded to the Helium Mobile Network by the Inversion Capital Service Provider, creating increased utility for HNT.

