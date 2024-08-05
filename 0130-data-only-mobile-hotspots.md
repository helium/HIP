# HIP 130: Data-Only MOBILE Hotspots 

- Author: [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-08-05
- Category: Technical, Economic
- Original HIP PR: [#1064](https://github.com/helium/HIP/pull/1064)
- Tracking Issue: [#1067](https://github.com/helium/HIP/issues/1067)
- Voting Requirements: veMOBILE Holders

## Summary

This Helium Improvement Proposal introduces the concept of Data-Only MOBILE Hotspots that  earn MOBILE for data transfer, but are not eligible to earn MOBILE for Proof-of-Coverage.

## Motivation

Most commercial venues like airports or malls already have Wi-Fi coverage. To grow coverage of the MOBILE network faster, it makes sense to develop an approach to make such pre-existing installations part of the MOBILE network. Wider coverage will result in Helium being more useful for telecom carriers looking to offload data into the network, which ultimately results in more utility for the network. 

## Stakeholders

- Operators of the pre-existing Wi-Fi networks that support Passpoint will be able to add their Hotspots to the network, instead of having to buy brand new hardware from vendors certified by the Helium network 
- Network users will be able to connect to these Hotspots using the same authentication certificate they currently use for accessing greenfield Helium Hotspots 
 
## Detailed Explanation

In this proposal we formally introduce the concept of a Data-Only MOBILE Hotspot. Data-Only MOBILE Hotspots are any Wi-Fi Hotspots that support Passpoint authentication and does not need to be purchased from a certified Helium Hotspot vendor. Upon approval of this HIP, a set of procedures will be published to configure Data-Only Wi-Fi Hotspots, which will allow traffic from any device paying for traffic on the MOBILE network to connect and send data through such Hotspots, and to connect the Wi-Fi Hotspots to a rewardable entity on chain. Data-Only Hotspots will  earn rewards for passing paid data and will not earn any rewards for proof of coverage. 

## Onboarding and Location Assert Fee Structure

It is proposed that data-only Wi-Fi hotspots don't pay a location assertion fee, since such hotspots earn no POC and location assertion is not required. It is proposed that data-only Wi-Fi hotspots pay a minimal onboarding fee as follows:

- 100,000 Data Credits (worth $1, HNT-derived)
- $1 worth of MOBILE tokens - at the live Oracle price

Total Onboarding Fee: $2

## Drawbacks

Introducing Data-Only Hotspots potentially competes with sales of Hotspots by certified Helium vendors, potentially resulting in less revenue to certified Helium vendors. 

Introducing Data-Only Hotspots may create confusion for Hotspots deployers. In considering how to create coverage in a particular venue, deployers are now faced with having to make a choice, whether to deploy certified Helium Hotspots that earn POC, but cost money or to configure Hotspots that may already exist in this venue. 

There is no way to enforce the quality of service for such Hotspots. Specifically, we can’t validate the quality of backhaul connection on Data-Only Hotspots via regular backhaul tests or optimize Hotspot behavior for the ‘sticky edge’ problem, since such Hotspots will be running third-party firmware. As such, some of the Data-Only Hotspots may result in poor user experience when connecting to them, negatively affecting network reputation.  

## Rationale and Alternatives

To mitigate the lack of QoS with Data-Only Hotspots, it is possible to consider creative, but more complicated solutions that would require QoS enforcement through mappers. i.e., a mapper can measure the quality of the connection provided by a Hotspot and some system can be devised that would penalize Data-Only Hotspots with poor quality. It is suggested, however, that this be considered as stage two, when and if such QoS problems become an issue. 

## Unresolved Question

Different types of enterprise Wi-Fi Hotspots will require a different set of steps to get configured and verified as active on the MOBILE network. Nova has not yet tested all different types of Hotspots and does not have instructions for configuring all Passpoint capable Hotspots. 
 
## Deployment Impact

Nova Labs will collaborate with the Helium Foundation to complete the implementation, should this HIP pass voting. Specific deployment impact details and timeframe will be filled out by engineering prior to HIP going to vote. 
