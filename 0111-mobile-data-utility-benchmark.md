# HIP 111: MOBILE Data Utility Benchmark - 10x Reward Boost
 
- Author(s): [ElonTusk007](https://github.com/capjbadger007), [Max Gold](https://github.com/maxgold91), [Fizzy99](https://github.com/mrfizzy99)
- Start Date: 2024-03-05
- Category: Economic, Technical
- Original HIP PR: [#903](https://github.com/helium/HIP/pull/903)
- Tracking Issue: [#929](https://github.com/helium/HIP/issues/929)
- Vote Requirements: veMOBILE Holders

---
 
## Summary

This Helium Improvement Proposal (HIP) introduces data transfer requirements for MOBILE CBRS Radios/Wi-Fi Access Points, hereinafter referred to as Radios/APs, to be eligible for Boosted Coverage Points (CPs) in a given epoch. Units meeting the specified data transfer benchmark (set initially to 1 MB within the previous 7 epochs) will receive 10x CPs for the current epoch. The boost in Coverage Points will result in increased MOBILE rewards for those Radios/APs. 

## Motivation
 
To ensure a fair and active participation of MOBILE Radios/APs in the Helium Network, it is essential to establish benchmarks that encourage consistent data transfer through these units. This proposal addresses the need for a measurable metric to gauge the activity of MOBILE units, enhancing the overall health and performance of the network.

## Stakeholders

This HIP affects only participants of the MOBILE network in the following ways:

- Service Providers
- MOBILE Hotspot Operators
- Subscribers of the MOBILE Network

*Service Providers:* Incentives will shift to areas where subscribers are moving data, reducing costs to the service provider.
*MOBILE Radio/AP Owners:* Will get the ability to earn extra MOBILE rewards by providing useful coverage with their MOBILE Radios/APs. The increase in MOBILE rewards will depend on the number of boosted Radios/APs on the network.
MOBILE Radio/AP owners with no data transfer will see reduced MOBILE rewards, but this is easily resolved by passing data through the hotspot.
*Network Subscribers:* More coverage will be available to users of the MOBILE Network as MOBILE Radios and APs are deployed in areas where subscriber data is being used.
 
## Detailed Explanation
 
#### 1. Data Transfer Requirement
 
MOBILE Radios/APs must transfer at least 1MB of rewarded data through the radio/AP within a 7 epoch rolling window to be eligible for the boosted CP for that Radio/AP for the current epoch. The data transfer benchmark will be calculated at the end of each epoch. Each MOBILE Radio/APs meeting the 1MB data transfer benchmark within the specified timeframe will receive a 10x CPs multiplier for the current epoch. All other multiplier or scaling from other HIPs will be applied after this CP adjustment. 
 
#### 2. Benchmark Exemption
 
MOBILE Radios/APs that cannot pass rewarded data through no fault of their own will be exempt from the benchmark and recieve the boosted CPs. Exemption will automatically trigger for the epoch if that protocol has passed <1MB of rewarded data in a 14 epoch rolling window.
Example: All WiFi certs (due to some bug) become inactive. After 14 epochs, all Wifi APs would not be subject to the benchmark requirement. Given the 7 epoch rolling window, Devs would have 7 epochs to get the issue corrected before Wifi AP owners would see a loss of the boost. 

Currently CBRS and WiFi are the only MOBILE subDAO protocols. This HIP will apply to any future protocols as they are added to the MOBILE subDAO.
 
## Rationale
 
- **Encouraging Activity:** Establishing data transfer benchmarks incentives MOBILE Radios/APs to actively participate in the network, contributing to the overall usefulness to the Helium Network. This also has an effect on DC burn, which drives the Helium flywheel.

- **Utility Based Reward Distribution:** Adjusting rewards based on rewarded data transfer activity ensures that rewards are proportionate to the level of network engagement, promoting utility and sustainability.

- **Helium Mobile Subscriptions:** This HIP will also have a positive impact on signing up more HM subscribers.

## Implementation
 
The proposed changes will require updates to the Helium rewards mechanism. This work will need to be implemented, today as a part of MOBILE Oracles. Specific implementation details will be added as this HIP continues discussion.
 
## Unresolved Questions

* Specific implementation details will need to be fleshed out through community discussion. 

## Drawbacks

Installs with no data transfers will see fewer MOBILE rewards. This is aligned with the goals of the network. This is easily corrected by passing data through the Radio/AP.

## Success Metrics:
 
Useful MOBILE Radios/APs will see an increase in POC rewards. Data transfers and DC burn will increase. Data providers and community tracking applications can be used to track the increased MOBILE data transfers.
