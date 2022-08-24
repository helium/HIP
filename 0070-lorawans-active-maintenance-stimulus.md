# HIP Template

- Author(s): <@criptosaurios>
- Start Date: <2022-06-08>
- Category: <economic>
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

This HIP proposes to open a wide dialogue, in the most used and easy access platforms (not only Discord), to discuss the need to find a way to bring a complementary (and may be temporary) reward  mechanism to those who have supported the current growth of LORAWAN network in HELIUM (Hotspot Owners, Validators/oracles and the richest HNT Wallets).
  
# Motivation
[motivation]: #motivation

Through this reward mechanism is intended to prevent the current size of the LORAWAN network from being reduced in active hotspots size/coverage, and then putting at risk the deployment of IOT devices, that will finally provide the Data Credit´s consumption for the support and maintenance of the Hotspots in the long term.
  
The LORAWAN network has a clear use case and bright future, but it needs more time for the deployment of devices that will use the network to make it self-sustaining based only on Data Credits. 
 

# Stakeholders
[stakeholders]: #stakeholders

-	All ACTIVE Hotspots at the moment of Snapshot. Hotspots that are activated after the capture will NOT be eligible.
-	All Validators/Oracles ACTIVE at the moment of Snapshot. Validators that are activated or created after capture will NOT be eligible.
-	The Richest wallets in HNT at the moment of Snapshot. (How a wallet is clasified as part of richest is part of this dialogue proposed).
  
# Detailed Explanation
[detailed-explanation]: #detailed-explanation

In a date to be determinated during the dialogue, this HIP proposes taking a snapshot of:
-	ACTIVE hotspots (those with valid activity in the last 30 days).
-	ACTIVE Validator/Oracle Nodes: Each active node and with the latest updated software version at the time of sanpshot. 
-	The richest wallets in HNT.
  
At first option to open the discusión, This HIP propose that each subDAO that is incorporated into HELIUM after LORAWAN, must contribute with 15% of the issuance of its tokens (DNT) in each epoch, to assign rewards in the following way. Based only in record obtained during the snapshot:
 - 5% will be distributed among the Hotspots.
 - 5% Will be distributed among the Validators/Oracles.
 - 5% will be distributed among the richest wallets in HNT.
  
This proposal also establishes THE CONDITIONS for each valid participant in the Snapshot to be eligible to receive the reward in each epoch:
  
- Hotspots: must be ACTIVE in order to participate in the reward distribution. The 5% reward will be shared only among those that meet this requirement.
- Validator/Oracle Nodes: must be active and updated in order to participate in the reward distribution. The 5% reward will be shared only among those that meet this requirement.
- The Richest wallets: Those Wallet with a valid record during the snapshot must maintain at least 75% of their balance registered in the capture in order to participate in the reward distribution. The 5% of reward will be shared only among those that meet this requirement.

# Drawbacks
[drawbacks]: #drawbacks

- It is necessary to modify the tokemonic that is being considered in [HIP51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md), [HIP52](https://github.com/helium/HIP/blob/main/0052-iot-dao.md), [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) and [HIP64](https://github.com/helium/HIP/blob/main/0064-wifi-dao.md)

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Allow a user change the Hotspot participating in this reward system. (1:1 due equipment failure or hardward upgrade). This will help to keep the mínimum network size.

# Unresolved Questions
[unresolved]: #unresolved-questions

Is there a better way to stop the trending of equipments being shutdown?

# Deployment Impact
[deployment-impact]: #deployment-impact

This wide dialogue in a more common and easy access platform could help to find the best way to keep the current LORAWAN network size, either through the mechanism proposed here or others found during this discussion. 

 # Success Metrics
[success-metrics]: #success-metrics

We can expect a surge in HOTSPOT DEPLOYMENT and HOTSPOTS BACK TO ACTIVE status, previous to the snapshot. 
After snapshot we can expect:
- At least Hotspots captured in snapshot will continue ACTIVE.
- Richest wallets will get an extra incentive to keep at least 75% of their balance at the snapshot.
- Validators/Oracles will get and extra incentive to keep their nodes updated at each epoch.


