**WIP Helium Improvement Proposal (HIP): Mobile Gateway Activity Benchmark 10x Boost**
 
*HIP Number:* 1XX
 
*Title:* Mobile Radio Data Transfer Requirements for Proof-of-Coverage (POC) Rewards
 
*Author:* ElonTusk007, Capc0m (Max), fizzy99
 
*Status:* Draft
 
*Created:* Feb 1, 2024
 
### Summary
 
This Helium Improvement Proposal (HIP) introduces data transfer requirements for Mobile gateways (CBRS, wifi, and any other protocols that pass mobile data) to be eligible for Boosted Proof-of-Coverage (POC) rewards in a given epoch. Units meeting the specified data transfer benchmark (1MB) within the previous 7 epochs will receive 10x POC rewards for the current epoch. Exceptions are made for units that cannot pass data due to actions of the Service Provider, and such units will not be held to the benchmark requirement to receive the boost until their ability to pass data is restored.
 
### Motivation
 
To ensure a fair and active participation of Mobile gateways in the Helium Network, it is essential to establish benchmarks that encourage consistent data transfer through these units. This proposal addresses the need for a measurable metric to gauge the activity of mobile units, enhancing the overall health and performance of the network.
 
### Specification
 
#### 1. Data Transfer Requirement
 
Mobile gateways must transfer at least 1MB of data through the radio within the previous 7 epochs to be eligible for the boosted POC rewards for the current epoch. The data transfer benchmark will be calculated at the end of each epoch.
 
#### 2. POC Rewards Adjustment
 
Mobile gateways meeting the 1MB data transfer benchmark within the specified timeframe will receive a 10x POC rewards multiplier for the current epoch.

#### 3. Exception for Service Provider Actions
 
Mobile gateways that cannot pass data due to actions of the Service Provider (such as SIM or Certificate disabled, etc.) are exempt from these benchmarks and will receive the boost until the ability to pass data through the Mobile gateway is restored. Restored data transfer ability will be defined as “50% of current subscriber devices have the ability to pass data”. Note this is regardless of the subscriber uninstalling/not installing the required SIM, certificate, etc. If the subscriber device can be set up to pass data through the mobile gateway, it will be counted towards the 50% threshold. 
 

 
### Rationale
 
- **Encouraging Activity:** Establishing data transfer benchmarks incentivizes Mobile gateways to actively participate in the network, contributing to the overall robustness of the Helium Network.
 
- **Fair Reward Distribution:** Adjusting POC rewards based on data transfer activity ensures that rewards are proportionate to the level of network engagement, promoting fairness and sustainability.
 
### Stakeholders
 
- **Mobile Gateway Operators:** Primary stakeholders affected by this proposal as they will need to meet the data transfer benchmark to receive boosted POC rewards.
 
### Implementation
 
The proposed changes will require updates to the Helium blockchain protocol and corresponding adjustments in the software used by mobile radios. Coordination with the Helium community and relevant stakeholders will be essential for the successful implementation of this HIP.
 
### Unresolved Questions

 
### Success Metrics
 
Useful Mobile gateways will see an increase in POC rewards, as should data transfers. Sites such as any Helium Explorer can be used to track the increased mobile data transfers. 
 


 
*Note: This HIP is a draft and subject to further discussion and refinement by the Helium community.*

