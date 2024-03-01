# HIP 1xx: Mobile Data Utility Benchmark 10x Reward Boost
 
- Author(s): *ElonTusk007, Capc0m (Max), fizzy99*
- Start Date: Feb 1, 2024
- Status: Draft
- Category: Economic, Technical
- Original HIP PR: <!--- TBD -->
- Tracking Issue: <!--- TBD -->
- Vote Requirements: veMOBILE Holders
 
## Summary:
 
This Helium Improvement Proposal (HIP) introduces data transfer requirements for Mobile CBRS Radios/WiFi Access Points (Hereinafter referred to as Radios/APs) to be eligible for Boosted Coverage Points (CPs) in a given epoch. Units meeting the specified data transfer benchmark (1MB) within the previous 7 epochs will receive 10x CPs for the current epoch. The boost in Coverage Points will result in increased MOBILE rewards for those Radios/APs.
 
## Motivation:
 
To ensure a fair and active participation of Mobile Radios/APs in the Helium Network, it is essential to establish benchmarks that encourage consistent data transfer through these units. This proposal addresses the need for a measurable metric to gauge the activity of mobile units, enhancing the overall health and performance of the network.

## Stakeholders

This HIP affects only participants of the MOBILE SubDAO:

- Service Providers
- Mobile Hotspot Operators
- Subscribers of the Mobile Network

**More specifically, this HIP will affect these Stakeholders in the following ways:**

*Service Providers:* Incentives will shift to areas where subscribers are moving data, reducing costs to the service provider.

*Mobile Radio/AP Owners:* Will get the ability to earn extra MOBILE rewards by providing useful coverage with their Mobile Radios/APs. The increase in MOBILE rewards will depend on the number of boosted Radios/APs on the network.
Mobile Radio/AP owners with no data transfer will see reduced MOBILE rewards, but this is easily resolved by passing data through the hotspot.

*Network Subscribers:* More coverage will be available to users of the MOBILE Network as Mobile Radios and APs are deployed in areas where subscriber data is being used.

 
## Detailed Explanation:
 
#### 1. Data Transfer Requirement:
 
Mobile Radios/APs must transfer at least 1MB of rewarded data through the radio within a 7 epoch rolling window to be eligible for the boosted CP for that Radio/AP for the current epoch. The data transfer benchmark will be calculated at the end of each epoch. Each Mobile Radio/APs meeting the 1MB data transfer benchmark within the specified timeframe will receive a 10x CPs multiplier for the current epoch. All other multiplier or scaling from other HIPs will be applied after this CP adjustment. 
 
#### 2. Benchmark Exemption:
 
Mobile Radios/APs that cannot pass rewarded data through no fault of their own will be exempt from the benchmark and recieve the boosted CPs. Exemption will automatically trigger for the epoch if that protocol has passed <1MB of rewarded data in a 14 epoch rolling window.
Currently CBRS and WiFi are the only Mobile subDAO protocols. This HIP will apply to any future protocols as they are added to the Mobile subDAO.
 
## Rationale:
 
- **Encouraging Activity:** Establishing data transfer benchmarks incentivizes Mobile Radios/APs to actively participate in the network, contributing to the overall usefulness to the Helium Network. This also has an effect on DC burn, which drives the Helium flywheel.
 
- **Utility Based Reward Distribution:** Adjusting rewards based on rewarded data transfer activity ensures that rewards are proportionate to the level of network engagement, promoting utility and sustainability.

- **Helium Mobile Subscriptions:** This HIP will also have a positive pressure on signing up more HM subscribers.

## Implementation:
 
The proposed changes will require updates to the Helium rewards mechanism. The group coding this work is TBD.
 
## Unresolved Questions:

## Drawbacks:
Installs with no data transfers will see fewer MOBILE rewards. This is however very easily corrected by passing data through the Radio/AP.

## Success Metrics:
 
Useful Mobile Radios/APs will see an increase in POC rewards. Data transfers and DC burn will increase. Sites such as any Helium Explorer can be used to track the increased mobile data transfers.
