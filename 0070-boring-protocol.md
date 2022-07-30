# HIP 70: Boring Protocol

- Author(s): [@FOMOBY](https://github.com/FOMOBY) [@franswan](https://github.com/franswan) 
- Start Date: 2022-07-31
- Category: Economy 
- Original HIP PR: Put URL here after we pull request
- Tracking Issue: TO DO 
- Status: In Discussion 

# Summary

The objective of this proposal is to outline a SubDAO dVPN facilitated by Boring Protocol and the Helium network as it pertains to privacy access for the broadcast layer, both entities' economic model and the ecosystem as a whole.

In response to [HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md), this proposal outlines integration of the Boring Protocol dVPN into Helium network as a subDAO with its own DNT (decentralized network token) known as BOP. 

In respect to the nature of difference between this potential SubDAO and existing SubDAOs many of the guidelines provided in HIP-51 will need to be considered for new solutions.

# Background

For the Helium Network to grow globally in number of active devices and users it is necessary to develop economic incentives and opportunity for the infrastructure operators participating in supporting the network. Adding utility and profitability to the hardware involved now and in the future will solidify the Helium network as a major player across many types of networks.

This proposal will require addition to the economic models set forth to further incentive individual participants' activity in new networks with the advantage of increasing profitability of said participants.

HIP 51 outlines basic requirements for existing models of the SubDAOs within the Helium Network. For the purpose of this HIP, the integration of two networks would need to omit some aspects of the economic model to procure the privacy and security that operators seek within both ecosystems. However, the pursuit of bringing value to the HNT-DC model must remain present. 

The opportunity to have HIP-51 subDAO layer 1 migrated to Solana is present in this proposal for the purpose of allowing the DC/HNT/BOP mechanics to flourish as well as to capitalize on the potential for Helium with the Solana Mobile platform. 
Boring Protocol is privacy and security at its foundation but can be grown to generate subDAOs of its own network models ie. Proxy networks, distributed storage etc. 

Boring Protocol operates currently on the token model envisioned by its team and community which is further described in this proposal.

The technical and economic design decisions of the Helium Network today have been made around the flagship LoRaWAN Decentralized Network Protocol. In order to support new networks and devices, there are two core problems to be addressed: blockchain scalability and DNP specific incentive alignment.

For this proposal we will outline possible approaches to these issues.

# Motivation

The drivers for this proposal are as follows:

- Privacy and Security for Helium “subscribers” & internet users as a whole
- Security and Scalability of the L1 as proposed in HIP-51
- Additional mechanisms for profitability to Helium Network infrastructure operators
- Network growth to Boring Protocol to generate a viable and strong dVPN (more nodes = greater obfuscation opportunity)
- Proving a model of multi chain redundancy to further secure network economics and participant profitability 
- Sustainability in manufacturing and distribution of hardware


# Stakeholders

This proposal impacts all HNT holders and their ecosystem as well as all BOP holders and their ecosystem. The objective is to provide greater growth to both networks while equally providing opportunity to the economics of Helium hardware operators,  simultaneously creating privacy access to Helium network infrastructure.

The Helium token model is described in the HIP’s presented previous to this proposal. Borings tokenomics weigh several key factors to provide incentive for network growth and network strength. 

The BOP token utility is mainly a settlement between “clients” of the dVPN and “operators” of nodes which are used to privately access the internet. Apart from this primary function the token is staked by node operators to present loyalty to the network and financial incentive to act in “good faith” as they operate exit nodes. As nodes remain connected they increase their opportunity for traffic/data to be directed through their node and increase their profitability as the token is settled on a data consumption rate. 

# Detailed Explanation

An initial integration may not include all economic requirements as described in HIP51 as the model for such only sets forth guidance for network structures that previously existed within the Helium ecosystem. As Boring is an entirely seperate access layer network we propose that the Data Credit models proposed in other subDAOs be removed from the equation for this particular proposal. As Boring grows and the opportunity to use DC as a solution within our network model presents itself the community can propose and implement such changes. 

Boring Protocol will instead add utility and value to the Helium token ecosystem by allowing customers to pay using SPL wrapped HNT to fund their usage of the dVPN. This provides two things to the Helium community: Dispersal of possible further HNT to the SPL wrapped HNT Liquidity pool and utility beyond market trading for the token itself. These value adds plus the ability for certain Helium infrastructure operators to also profit from running Boring Protocol simultaneously are the strongest presentation we can make at this time to consider our proposal.


- Introduce and explain new concepts.
- It should be reasonably clear how the proposal would be implemented.
- Provide representative examples that show how this proposal would be commonly used.
- Corner cases should be dissected by example.

 
## Economic Model
 
We propose in HIP69 Boring Protocol will circulate a firmware (move to software solution {NFT as software license distributed as well}) to the Helium network operators that allows these participants to simultaneously support both networks. The advantages presented should create these opportunities to both networks:
- Greater node count and network reach
- Privacy and security for “subscribers/clients”
- Increased utility to each networks token economics
- Increased cross chain liquidity to Tokens
- Opportunity for numerous SubDAO applications to include dVPN, Proxy and kinetic redundant data storage. 
- Necessity of Solana RPC Validator for Boring/Helium transactional throughput?

Trade offs may include limiting the necessity of multi chain liquidity with a migration of HNT to the Solana Blockchain. This migration would require obvious difficulty to the Helium chain but would allow greater scalability and a long term reduction of negative network effects. It would increase Helium ecosystem security and growth overall. 

Though not required for the implementation of Boring to Helium infrastructure, this proposal would reduce the friction of network infrastructure operators. These operators would have to manage multiple chain assets if the migration did not proceed. 

The advantage of not migrating would be redundancy in economic incentives across chains. If one network was to suffer outage the other may continue and provide profitability to those who participate in each simultaneously. However, the goal is to create cohesion between these networks.


# Drawbacks

Why should we not do this?
Will this affect the helium network?


# Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design space. This is probably the most important section!
- Raise an issue (link to github issues)
- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this? 



# Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the future independently of the solution that comes out of this HIP?

Two HIPS for Boring,
- Implementation to run both Helium and Boring for appropriate hardware (rasp pi 4b w/4gb ram minimum)
- Increase Profitability of capable operators.
- Anti-fragility (one chain outage does not impede the other)
- Economic HIP to institute Boring as a subDAO



# Deployment Impact
Dashboards: Find out what distribution methods will be most efficient. Talk with hardware devs who build the UI upon which Helium runs as an app. Our app must live together with Helium as a standalone app. 

Impact: OTA wherever possible. Avoid fresh installs wherever possible. Fresh install must be avoided all together unless we hear otherwise from the Helium side we will deploy something fresh together… doubt it. 


Deploying to limited number of nodes

Describe how this design will be deployed and any potential impact it may have on current users of this project.
- How will current users be impacted?
- How will existing documentation/knowlegebase need to be supported?

Is this backwards compatible?
  - If not, what is the procedure to migrate?

- How to deploy Boring to helium infrastructure
- How we envision Helium migrating to solana


# Success Metrics

What metrics can be used to measure the success of this design?
- Profits to nodes
- Liquidity drawn to wHNT
- Quantity & frequency of dual mining hnmt/bop nodes being deployed 
 
What should we measure to prove a performance increase?
- Added profitability for Helium Nodes with bop earning vs non bop earning
- Data Transfer Metrics
- Migration of Value from Helium layer 1 to Solana
 
What should we measure to prove an improvement in stability?
- Balance of customer data transfer requirements and node count servicing said needs.
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by it's users?




