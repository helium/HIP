# HIP 1xx: Mobile Hotspot Benchmark 10x Rewards Boost
 
- Author(s): *ElonTusk007, Capc0m (Max), fizzy99*
- Start Date: Feb 1, 2024
- Status: Draft
- Category: Economic, Technical
- Original HIP PR: <!--- TBD -->
- Tracking Issue: <!--- TBD -->
- Vote Requirements: veMOBILE Holders
 
## Summary:
 
This Helium Improvement Proposal (HIP) introduces data transfer requirements for Mobile gateways (CBRS, wifi, and any other protocols that pass mobile data for the Mobile subdao) to be eligible for Boosted Coverage Points (CPs) in a given epoch. Units meeting the specified data transfer benchmark (1MB) within the previous 7 epochs will receive 10x CPs for the current epoch. The boost in Coverage Points will result in increased MOBILE rewards for those gateways.
Exceptions are made for units that cannot pass data due to actions of the Service Provider, and such units will not be held to the benchmark requirement to receive the boost until their ability to pass data is restored.
 
## Motivation:
 
To ensure a fair and active participation of Mobile gateways in the Helium Network, it is essential to establish benchmarks that encourage consistent data transfer through these units. This proposal addresses the need for a measurable metric to gauge the activity of mobile units, enhancing the overall health and performance of the network.

## Stakeholders

This HIP affects only participants of the MOBILE SubDAO:

- Service Providers
- Mobile Hotspot Operators
- Subscribers of the Mobile Network

**More specifically, this HIP will affect these Stakeholders in the following ways:**

*Service Providers:* Incentives will shift to areas where subscribers are moving data, reducing costs to the service provider.

*Mobile Hotspot Owners:* Will get the ability to earn extra MOBILE rewards by providing useful coverage with their Mobile hotspots. The increase in MOBILE rewards will depend on the number of boosted hotspots on the network.
Mobile Hotspot owners with no data transfer will see reduced MOBILE rewards, but this is easily resolved by passing data through the hotspot.

*Network Subscribers:* More coverage will be available to users of the MOBILE Network as Mobile hotstpots are deployed in areas where subscriber data is being used.

 
## Detailed Explanation:
 
#### 1. Data Transfer Requirement:
 
Mobile gateways must transfer at least 1MB of data through the radio within a 7 epoch rolling window to be eligible for the boosted CP for the current epoch. The data transfer benchmark will be calculated at the end of each epoch.
 
#### 2. Coverage Points Adjustment:
 
Mobile gateways meeting the 1MB data transfer benchmark within the specified timeframe will receive a 10x CPs multiplier for the current epoch.

#### 3. Exception for Service Provider Actions:
 
Mobile gateways that cannot pass data due to actions of the Service Provider (such as SIM or Certificate disabled, etc.) are exempt from these benchmarks and will receive the boost until the ability to pass data through the Mobile gateway is restored. Restored data transfer ability will be defined as “50% of current subscriber devices have the ability to pass data through the affected devices/protocol”. Note this is regardless of the subscriber uninstalling/not installing the required SIM, certificate, etc. If the subscriber device can be set up to pass data through the mobile gateway, it will be counted towards the 50% threshold. 
 
## Rationale:
 
- **Encouraging Activity:** Establishing data transfer benchmarks incentivizes Mobile gateways to actively participate in the network, contributing to the overall usefulness to the Helium Network. This also has an effect on DC burn, which drives the Helium flywheel.
 
- **Utility Based Reward Distribution:** Adjusting rewards based on data transfer activity ensures that rewards are proportionate to the level of network engagement, promoting utility and sustainability.

## Implementation:
 
The proposed changes will require updates to the Helium rewards mechanism. The group coding this work is TBD.
 
## Unresolved Questions:

## Drawbacks:
Installs with no data transfers will see fewer MOBILE rewards. This is however very easily corrected by passing data through the hotspot.

## Success Metrics:
 
Useful Mobile gateways will see an increase in POC rewards. Data transfers and DC burn will increase. Sites such as any Helium Explorer can be used to track the increased mobile data transfers.
