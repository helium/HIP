HIP108: subDAO Governance Addendum
●	Author: @tjain-mcc, @shayons297, @abhay
●	Start Date: 2024-01-24
●	Category: Economic / Technical
●	Original HIP PR: 
●	Tracking Issue: #
Summary
HIP-51 outlined a structure for subDAOs to exercise governance over subnetwork specific attributes under the broader umbrella of the Helium network. This proposal is an addendum to the original proposal to refine the subnetwork governance process to ensure continued incentive alignment across HNT and all DNT tokenholder cohorts.

We propose a federalist governance system that allows the Helium DAO to review the outcome of any particular subDAO vote.

Motivation 
A core objective of HIP-51 was to provide the ability for subnetworks to govern their own proof-of-coverage rules, hotspot onboarding rules, data transfer pricing, and rewards distribution mechanisms through veDNT voting. 

The governance mechanism should allow subDAOs to operate independently with some degree of oversight exercised by the Helium DAO. The current procedure does not formally allow for this degree of oversight, as subDAO governance occurs exclusively in veDNT tokens.
 The proposed addendum places checks and balances for subDAO governance to ensure alignment across the broader Helium DAO.  Stakeholders 
This proposal impacts all current and future stakeholders in the Helium Community.
Implementation
Design Principles 
The proposed architecture mirrors federalist models of governance. Historically, federalist systems balance local level autonomy with appropriate federal authority, aligning incentives across local and central actors. 

In the US, the federalist system of state and federal governments helps to align localization with national priorities, provide oversight against violations, and lend stability through a structured governance process. 60% of countries worldwide have some form of a federalist political system that delegates powers across states yet retains federal oversight. This principle applied to Helium vision grants flexibility and speed to subDAOs where beneficial within a framework of alignment. As such, Helium DAO governance should be able to supercede subDAO voting outcomes, wherein any individual subDAO decision can be reviewed by the Helium DAO. 

Process 

In the proposed structure, certain proposals and votes approved within a subDAO governance process could be appealed to the Helium DAO before taking effect. The Helium DAO would consider the appeal as a new HIP and vote on it directly. 

As such, subDAO governance proposals would follow this lifecycle:
1.	Proposal A proposal is put up for voting by a member of a given subDAO 
2.	Vote DNT denominated voting occurs
3.	Review Period If the vote passes at the subDAO level, a seven-day review period begins in which Helium DAO members are able to escalate for review.
a.	A Helium DAO member must submit a new HIP with substantive criticism around the subDAO proposal
b.	Helium Foundation decides based on rough consensus whether to accept or reject the request for review.
4.	Assessment Helium DAO moves forward with reviewing the proposal with a new vote measured via stake weighted veHNT.
5.	Outcome If ratified, the proposal takes effect in subDAO. If vetoed, the proposal fails.
For this standard of governance to be applied universally, Helium DAO needs to be the sole token mint authority for all DNTs. SubDAOs retain the ability to modify parameters around emissions, but distributions are ultimately made downstream of Helium DAO.

Open Questions
1.	How does the Helium DAO handle recourse in cases where a HIP is not honored by the subDAO, or the subDAO generally acts out of mandate with the governance process?
2.	Criteria for vetoing subDAO proposals - based on security, economic sustainability, alignment with Helium's goals?
3.	Timeline for review - balance subDAO agility with time for Helium DAO review? Is one week enough or do we need more time?
4.	Procedures for revising proposals or appealing Helium DAO vetoes
Deployment Impact
This structured appeals process is a step toward graduating to fully on-chain governance in the future. Over time, Helium Foundation is removed as the bottleneck between subDAO governance and Helium governance. 
