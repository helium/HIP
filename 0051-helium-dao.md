# HIP 51: Technical and Economic Constructions for Scaling the Helium Network

- Authors: [@tjain-mcc](https://github.com/tjain-mcc), [@shayons297](htts://github.com/shayons297)
- Start Date: 2022-01-04
- Category: Economic, Technical
- Original PR: https://github.com/helium/HIP/pull/335
- Tracking Issue: https://github.com/helium/HIP/issues/338
- Status: Draft
- 
# **Summary**

This proposal outlines economic and technical constructions with the aim of scaling the Helium Network to support new users, devices, and types of Decentralized Network Protocols.

We propose that each communications network built on top of the Helium Network (LoRaWAN, WiFi, 5G, CDN, VPN — referred to as Decentralized Network Protocols or DNPs) has its own subDAO with its own token (referred to as Decentralized Network Tokens or DNTs). The key specifications of the DNT such as Proof-of-Coverage rules, mining rewards, and Data Transfer pricing are governed by each DNT subDAO.

The aim is to create an economy such that the underlying HNT-Data Credit burn-and-mint equilibrium continues to power the Helium Flywheel, while Proof-of-Coverage rules and earnings are dictated by the corresponding subDAO.

The technical model requires that the entire Helium Network (tokens, hotspots, emissions rules, governance, etc.) lives at some proposed base layer blockchain (L1). All accounts and transaction activity happens at this L1. The decision on which L1 to use will be based on the technical and economical evaluation of the requirements of this proposal.

All subDAOs must operate Oracles for their networks. Each subDAO Oracle runs software to calculate DNP specific items (eg: all the Proof-of-Coverage code that exists on the current LoRaWAN network to determine Hotspot rewards) and the subDAO Oracles who have staked DNTs come to consensus on these calculations and submit them to the Helium Network.

# **Background**

For the Helium Network to grow to global scale in number of active devices and users it is necessary to develop economic and technical primitives that will support that scale across various wireless networking technologies.

[HIP 27: CBRS 5G Support](https://github.com/helium/HIP/blob/master/0027-cbrs-5g-support.md) provides a broad discussion of 5G DNP specific Data Credits mechanisms, and [HIP 37: Omni-Protocol PoC](https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md) proposes an incentive model as well as Proof-of-Coverage rules for the 5G Network. This is a three-part proposal that builds on such existing work with two primary aims:

1. Provide a general structure for onboarding new DNPs to the broader Helium Network, with mechanisms in place to ensure that protocol-specific attributes such as Proof-of-Coverage rules, Data Transfer pricing, and miner rewards are within control of the DNT subDAO.
2. Specify the implementation of the structure proposed through detailed onboarding proposals for the LoRaWAN and 5G networks, described in [HIP 52: LoRaWAN DAO](https://docs.google.com/document/d/1fqy3JLdoP8YgOULx-sE_24xOL1UL9esHu_Ctju4iGcg/edit) and [HIP 53: 5G DAO](https://docs.google.com/document/d/1rg9VK28S8bWOeKNiKXUipsLsBxLjuHH7AnVe6TjKw4I/edit).

The technical and economic design decisions of the Helium Network historically have been made around the first LoRaWAN Decentralized Network Protocol. In order to support new networks and devices, there are two core problems to be addressed: **blockchain scalability** and **DNP specific incentive alignment.**

This proposal outlines two constructions to address the aforementioned core problems:

1. *Blockchain Scalability* We propose that each DNP has oracles who operate software to calculate DNP specific items (eg: all the Proof-of-Coverage code that exists on the current LoRaWAN network to determine Hotspot rewards) and make DNT payments to DNP stakeholders (eg: miners, stakers, etc). Oracles stake DNTs and are rewarded by a portion of DNT inflation.

These oracles share a set of network rules and submit independent attestations (through signatures or proofs) or come to consensus on their calculations and submit them in aggregate to the Helium Network.

1. *DNP Specific Incentive Alignment We propose that each DNP operate as its own subDAO within the broader umbrella of the Helium Network. DNP subDAOs are able to issue DNTs to their stakeholders and DNT denominated governance controls DNP specific attributes.*

# **Motivation**

There are three key drivers for proposing that DNP specific calculations are done by DNP oracles and then submitted to the the overall Helium Network:

1. *Scalability -* Each DNP has the ability to run its own code for DNP specific items. This enables multiple parallel developer teams to work on advancing the Helium Network. This design also allows for the complex Proof-of-Coverage calculations to be done off chain and therefore minimizes state bloat and transaction costs on the L1.
2. *Native Tokens Provide Separation of Governance Each DNP effectively governs its Proof-of-Coverage rules, Data Transfer pricing, and rewards distribution mechanisms through DNT voting. This structure provides significantly more flexibility over the structure of the DNP and allows those who are closest to a network to drive its own governance.*
3. *Composability Implies Utility -* If the overall Helium Network L1 is able to support smart contracts, it is possible to imagine a variety of novel use cases for HNT as well as each of the DNT tokens. Some examples here are decentralized exchanges, money markets (liquid borrow-lend markets for greater delegation to validators or leveraged staking), and token reward splitting (mining rewards being sent to multiple addresses).

# **Stakeholders**

This proposal impacts all current and future stakeholders in the Helium Community.

# **Construction**

We propose that each DNP operates its own subDAO and submits information to the broader Helium Network via Oracles. Each DNP has its own economic and governance layer through its subDAO, which comprises all its DNT holders.

![https://lh3.googleusercontent.com/sluRVsYUKoRqnXd5T3s6XqIQSlogUTuXM6j6ewuplOz5xSBE4JzrUEnzvIDBJqm_qhTc7utL7AI6dkxFipgD9nveSV0g5bwx9wLiqaua4NEtplCRpEUQYjGfv2hwhx4Br3gn1cntCkCBGoaD3g](https://lh3.googleusercontent.com/sluRVsYUKoRqnXd5T3s6XqIQSlogUTuXM6j6ewuplOz5xSBE4JzrUEnzvIDBJqm_qhTc7utL7AI6dkxFipgD9nveSV0g5bwx9wLiqaua4NEtplCRpEUQYjGfv2hwhx4Br3gn1cntCkCBGoaD3g)

New DNPs are added to the Helium DAO through the veHNT denominated governance process as defined below.

## veHNT and Governance

Helium operates as a network of networks under HIP 51, and as such requires its own global governance mechanism. While each subnetwork is able to define its own governance layer through its subDAO and DNT, core proposals involving the overall Helium network evaluated through veHNT (vote-escrowed HNT) weighted governance.

A user’s voting power is determined by 1) the amount of HNT they lock up with, and 2) the amount of time they commit to locking up their HNT. The structure applies a linear multiplier of time to the amount of HNT locked up in the voting contract. For the maximum amount of four years, users receive 100x the veHNT. For the minimum amount of a six month lockup, users receive 1x the veHNT. Note that veHNT is **fully non-transferable**, and represented as a non-fungible coupon in the user’s HNT address.

![https://lh6.googleusercontent.com/ikebMGiY7wqmny0-p3tX0FyYLKVonll2rYgTGHJf7RYNWbuBL8byEgzQYsDLRbSySOZwY3pgrK8XeRFL2fqN4uadKIWBkdMILAZR6OzXJv3pUGvk3crfGBQPvZrM2bIwxVGsHHKbDScbbPWbrQ](https://lh6.googleusercontent.com/ikebMGiY7wqmny0-p3tX0FyYLKVonll2rYgTGHJf7RYNWbuBL8byEgzQYsDLRbSySOZwY3pgrK8XeRFL2fqN4uadKIWBkdMILAZR6OzXJv3pUGvk3crfGBQPvZrM2bIwxVGsHHKbDScbbPWbrQ)

For example, suppose A, B, and C all choose to lock up 1000 HNT:

1. A chooses to lock up tokens for the minimum required duration of six months, and thus receives veHNT in the amount of 1000
2. B chooses to lock up tokens for twenty-seven months, and thus receives veHNT in the amount of 50 * 1000 = 50,000
3. C chooses to lock up tokens for forty-eight months, and thus receives veHNT in the amount of 100 * 1000 = 100,000

Note that durations are defined in blocks on the basis of the settlement time of the underlying L1.

Note that only proposals with code attached can be formally voted on. There are broadly three ways to use voting power within the Helium DAO:

1. **Protocol Score Curation Users can choose to delegate their veHNT in the name of an existing subDAO, thereby positively impacting that subnetwork’s protocol score. This leads to increased emissions for the DNP subDAO treasury reserve, and ultimately increases the value of the corresponding DNT. This is effectively a mechanism to allow stakeholders to signal ongoing support for subnetworks.veHNT stakers towards a DNP are rewarded a fixed 6% of DNT emissions every epoch. This is fixed across DNPs and cannot be changed by the DNP. The reason to keep this fixed is to avoid a scenario where DNPs compete to give more rewards to veHNT stakers at the expense of hotspot hosts.**
2. **New Subnetwork Proposals Proposals for new decentralized network protocol to become a part of the Helium Network as a subDAO must be voted on by veHNT.**
3. **Helium DAO Proposals All proposals that impact global Helium DAO parameters including protocol score parameters, subDAO structuring, communications architecture etc. can be voted on through this process.**

Further details on the vote-escrow weighted governance model can be found in [Curve governance documentation](https://resources.curve.fi/governance/understanding-governance) and [https://docs.tribeca.so/electorate/voting-escrow](https://docs.tribeca.so/electorate/voting-escrow).

## Omni Protocol PoC Incentive Model

Before we can define the DNP specific economic structures, we need to outline how the rewards are split between DNPs and how to fund the earliest stages of development for new DNPs.

Currently, under HIP-27, non-LoRaWAN gateways would only be rewarded based on Data Transfer and those rewards are based on the 1 DC burn = 1 DC equivalent earning principle laid out in HIP-10. That reward bucket is currently, as of January 2022, limited to 35% of total HNT issuance per epoch. Any HNT from that bucket that is not allocated to Data Transfer rewards is reallocated to LoRaWAN PoC rewards.

We propose to split PoC rewards between wireless protocols based on a formula that accounts for DCs burned and active devices per DNP

The success of the Helium network is contingent on its ability to find real world applications that burn data credits via data transfer activity. Therefore, the incentive model should be designed in a way that promotes Decentralized Network Protocols (DNPs) that accomplish that goal. Additionally, the scale of each DNPs participation network should also be taken into account, so as not to overly disadvantage early protocols with lower DC burn rates. To accomplish this propose the formula below:

Each protocol would be assigned a ‘score’ per epoch:

![https://lh3.googleusercontent.com/dGtzz-mdiKGBFdT-YjOaEm4UgHoffE-WDl-Vrp7WRF8GgCYdmvVKBBSA_SmDZ1sAHNllPjg7jFHNsWZ5kwxprYhoXxC4JKQHIVHmxxeLgHeet8JTsQOcwCUxr2MxomiK-KokUR0-5gaCDivqrQ](https://lh3.googleusercontent.com/dGtzz-mdiKGBFdT-YjOaEm4UgHoffE-WDl-Vrp7WRF8GgCYdmvVKBBSA_SmDZ1sAHNllPjg7jFHNsWZ5kwxprYhoXxC4JKQHIVHmxxeLgHeet8JTsQOcwCUxr2MxomiK-KokUR0-5gaCDivqrQ)

where

![https://lh3.googleusercontent.com/-5_TwRRXXS-wrt-vc66M5i5IEprAeMBIBRN6EEVzljpqJeIueFQLytVnW5DRg0G1RN7-tXcJRCLegqD9C78DEgFfzzmvR3CtEJmzE6EFt1iOLaoWs99uPsYIxUK-BS3Opl0ELXgff_lnFxM8Gg](https://lh3.googleusercontent.com/-5_TwRRXXS-wrt-vc66M5i5IEprAeMBIBRN6EEVzljpqJeIueFQLytVnW5DRg0G1RN7-tXcJRCLegqD9C78DEgFfzzmvR3CtEJmzE6EFt1iOLaoWs99uPsYIxUK-BS3Opl0ELXgff_lnFxM8Gg)

![https://lh4.googleusercontent.com/kwBJhMyXchk2fSuNX3ovLa3hVD412r-uACvT5SGYjFv5LMIv35KJ_JKh0ANjKow7tEQ8sI9YESydQBB19_VrYn6-Ov8elbargNvLbaQFiq0T1eT1FzJNCwrVHMejqbMZw67YzF5f](https://lh4.googleusercontent.com/kwBJhMyXchk2fSuNX3ovLa3hVD412r-uACvT5SGYjFv5LMIv35KJ_JKh0ANjKow7tEQ8sI9YESydQBB19_VrYn6-Ov8elbargNvLbaQFiq0T1eT1FzJNCwrVHMejqbMZw67YzF5f)

![https://lh3.googleusercontent.com/q8WdrGYo5hVP0m9hWP8_OuKSC2iOfpZMJSKnD-TWw9_-eDRIeyKQpzScvO54LTxpTajNAHGE2m-EzarxIKuTzBF7MlN1J-2FrsBDMZ-VJSh2gRyL0KAZYCWIheWAcM2IbQDHohRtcU5Lr4J10w](https://lh3.googleusercontent.com/q8WdrGYo5hVP0m9hWP8_OuKSC2iOfpZMJSKnD-TWw9_-eDRIeyKQpzScvO54LTxpTajNAHGE2m-EzarxIKuTzBF7MlN1J-2FrsBDMZ-VJSh2gRyL0KAZYCWIheWAcM2IbQDHohRtcU5Lr4J10w)

Once each protocol has a score, the % of total Epoch PoC rewards assigned to each DNP will be assessed by comparing the individual score to the sum of all scores:

![https://lh6.googleusercontent.com/LjMmGCO4OWvbfCO96KEioJVNbEyYjRmn7Fy-K0pOps52M5d3ACVEVmHLEbTlLRyiGtAgOrXtDHQKTDPkX9w2dFgClInr-LQdifPESQeiVJh7oL-zo0_KzMmo2oVW6O25wqDHG1_ocATqZqM5Nw](https://lh6.googleusercontent.com/LjMmGCO4OWvbfCO96KEioJVNbEyYjRmn7Fy-K0pOps52M5d3ACVEVmHLEbTlLRyiGtAgOrXtDHQKTDPkX9w2dFgClInr-LQdifPESQeiVJh7oL-zo0_KzMmo2oVW6O25wqDHG1_ocATqZqM5Nw)

Please refer to this model [spreadsheet](https://docs.google.com/spreadsheets/d/1up7-jJt3eM5Fn9K0NTnDA50ZzIDqV-bznbnwej1y3R4/edit#gid=2099369137) to review the parameters of this model.

Most importantly, this model gives us a framework to add new DNPs in the future without having to design reward splits on an ad-hoc basis. It is critical to note that if a subDAO is found to be artificially inflating core metrics to manipulate the protocol score, that subDAOs HNT reserves can be slashed via governance at the Helium Network layer.

### **Key definitions and calculations for Omni-Protocol PoC incentive model**

*DC burn used in PoC split calculation* DC burn is limited to data transfers per DNP. The calculation does *not* include fees associated with other actions, including, but not limited to, gateway assertions and gateway relocation fees.

*Decentralized Network Protocol (DNP)* A computer network that uses data connections between network nodes and utilizes a uniform, standard set of rules that determine how data is transmitted between different devices in the same network. (i.e. LoRaWan, 5G, Wi-Fi, NB-IoT etc. all different Decentralized Network Protocols).

*Frequency of PoC reward split recalculation* Recalculated every epoch using data from the trailing 30 days

*Active Device* Active devices are the subDAO's definition of devices creating valid coverage (aka hotspots) and therefore being rewarded during the epoch.

## subDAO Treasury Management

Each subDAO is governed using its DNT, which acts as the core economic and governance unit of the subnetwork.

DNT are issued according to a predefined **emission schedule**. This must be defined in the HIP to approve the DNP subDAO joining the Helium Network.

All subDAOs have full control over DNT issuance parameters including overall emission schedules, inflation rates, bonus carve-outs, and stakeholder distributions (hotspots, oracles, etc.). The only exception to this is the fixed 6% DNT rewards going to veHNT stakers. The reason to keep this fixed is to avoid a scenario where DNPs compete to give more rewards to veHNT stakers at the expense of hotspot hosts.

In each epoch, DNP subDAOs under the Helium network earn some amount of HNT as per the protocol score defined in the previous section. This HNT is deposited directly into the DNP subDAO treasury reserve.

HNT deposited to the treasury reserve can only be used to provide buy-side liquidity to DNT holders. In practice, the subDAO treasury reserve provides a continuous resting bid on an orderbook for DNT/HNT liquidity.

As the subDAO treasury reserve market making curve defines new floor prices for DNT on an epochal basis, prior limit orders are replaced with new limit orders at the updated market rate. Note that the order book used is permissionless, so third-party actors can set different rates to buy or sell DNT as they price the asset.

For example, if a DNP subDAO has 10B DNT outstanding and 50M HNT in its treasury, it must use that 50M HNT to provide a bid for DNT. The subDAO would provide a bid of 0.005 HNT per DNT.

DNT emissions are decoupled entirely from the HNT that flows into the subDAO treasury. This gives each subnetwork full sovereignty to enforce the monetary policy it believes to be best given its growth stage and overall aims. This construction further enforces HNT as the reserve economic asset for all subnetworks underneath the Helium network of networks.

## Minimum Viable subDAO Construction

For a given subDAO to join the Helium Network, a veHNT denominated proposal is required as defined in the previous section. For each new subnetwork, a minimum viable construction is required, and includes the following sections:

1. **Emissions Curve**Each subDAO must define the total supply, inflation rate, epochal issuance, and stakeholder distribution of its DNT. These are subject to change as per the subDAOs preferred governance layer.
2. **Treasury Reserve DNT Market Making Curve subDAOs have full control over the prices at which the subDAO treasury provides quotes to holders of DNT who wish to redeem their holdings for underlying HNT. This can be a flat bid or a more complex curve.**
3. **Oracle Specification**

Oracles ****perform work including verifying proof of coverage and data transfer. The oracles are also responsible for distributing DNT mining rewards to the appropriate parties. Responsibilities here include definition of oracle software, minimum stake amounts, and rewards for participation.

1. **Data Transfer Mechanism and Pricing**

Data transfer across subnetworks occurs via the process of procuring and burning data credits in the name of the hotspot or set of hotspots that provide coverage. Responsibilities here include Organizationally Unique Identifier (OUI) registration, state channel creation, and bandwidth capacity per data credit definition.

1. **Proof-of-Coverage Mechanism**

Most subnetworks will utilize a Proof of Coverage algorithm to verify on an ongoing basis that hotspots are accurately representing their location and the wireless network coverage they are creating from that location. Responsibilities here include Proof-of-Coverage challenge construction, target selection, reward scaling, and verification. Note that subnetworks can choose to skip this mechanism, but must provide reasoning as to why it is not necessary for proper functioning of the subnetwork.

1. **Governance Structure**

subDAOs retain control over critical components of the network, and subDAO members can propose and vote for changes to core parameters and mechanisms. Responsibilities here include specification of a formal on-chain voting process that is resistant to attacks.

## End-to-End Process

We provide an end-to-end description of data transfer, proof-of-coverage, and oracle rewards for a given DNP under the Helium Network.

*Data Transfer Process*

For each DNP, a device looking to receive coverage across the network purchases Data Credits by **purchasing and burning HNT**.

The device subsequently uses those Data Credits with a DNP specific State Channel at a particular Hotspot or set of Hotspots. The State Channel credits the Hotspot(s) once data has been transferred and submits this information to the DNP Oracles through State Channel Closes.

The hotspot may dispute the State Channel summaries by submitting signed attestations to the DNP Oracles.

Every epoch, DNP Oracles calculate each miners’ rewards based on data transferred in State Channels and distributes it to accounts on the L1 according to the emissions schedule for the subDAO.

*Proof-of-Coverage Process*

The DNP subDAO defines the rules for Proof-of-Coverage activity. In a given epoch, Challengers, Challenges, and Witnesses ****(in the case of a three party POC process) ****relay the results of challenges to DNP Oracles.

Every epoch, DNP Oracles calculate each miners’ rewards based on proof of coverage data and distribute DNT to accounts on the L1 according to the emissions schedule for the subDAO.

*HNT Emissions Calculation to subDAO Treasury Reserve*

At the end of a given epoch, the HNT emissions contract at the Helium DAO L1 calculates the amount of HNT to reward each DNP as per the protocol score in that given epoch. The emissions contract subsequently distributes the determined amount of HNT to the DNP subDAO treasury which is controlled by the DNP oracles.

*Oracle Process*

The DNP subDAO defines the rules for oracles to come to consensus, and distributes a portion of DNT emissions in a given epoch for DNP oracles.

![https://lh6.googleusercontent.com/6boBre9RQbrytVAu-kKZgqimQ-d5n19SUbw8IOkJDnlaazep_4dTn2yRHU_TGw_zYtbizMYWUY5k8ODeO7MiPNgXslJcOygxBICiVdB4NpzxstK0Cb5wuaK1LEpLsLyj68bWe1KIfkmiOz7ejQ](https://lh6.googleusercontent.com/6boBre9RQbrytVAu-kKZgqimQ-d5n19SUbw8IOkJDnlaazep_4dTn2yRHU_TGw_zYtbizMYWUY5k8ODeO7MiPNgXslJcOygxBICiVdB4NpzxstK0Cb5wuaK1LEpLsLyj68bWe1KIfkmiOz7ejQ)

*DNT Liquidity from subDAO Treasury Reserve*

If a given address wishes to redeem their DNT, they can “sell” against the subDAO treasury’s bid on the order book to receive the current rate of underlying HNT.

The transaction involves selling the desired amount of DNT tokens on the order book, and receiving the determined amount of HNT tokens from the DEX. The sunDAO automatically burns any DNT it purchases through this method.

The address relays the message of the sale to the set of DNP oracles, which then adjust the position of the programmatic treasury in the following epoch after adjusting for all other sales and any new issuance.

# **Clarifications**

We set the following economic constraints in order to ensure an equilibrium within each subDAO and the overall network

1. HNT remains the unit of buy-and-burn in order to maintain the HNT flywheel. Data Credits are universal, in that they can be created by burning HNT and are usable across any DNP. Once a Data Credit is added to an address’s subnetwork DC balance, it can be transferred to any other subnetwork DC balance on the L1. This is a notable change as today, Data Credits cannot be transferred once created.
2. Mining rewards for hotspots in a given DNP are distributed in the corresponding DNT. We encourage wallet applications to offer an auto swap feature for miners so they can automatically swap their mined DNT for HNT if they choose to do so.
3. DNTs can be traded on secondary markets but are redeemable for HNT as per the primary market defined by the Treasury Reserve.
4. Each DNP can set their own DNT emission schedule and distribution.

# **Open Questions**

1. What does a migration process look like for the existing implementation onto the new structure outlined?
