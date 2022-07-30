# HIP 70: Boring Protocol

- Author(s): [@FOMOBY](https://github.com/FOMOBY) [@franswan](https://github.com/franswan) 
- Start Date: 2022-07-31
- Category: Economy 
- Original HIP PR: Put URL here after we pull request
- Tracking Issue: TO DO 
- Status: In Discussion 


Summary
The objective of this proposal is to outline a SubDAO dVPN facilitated by Boring Protocol and the Helium network as it pertains to privacy access for the broadcast layer, both entities' economic model and the ecosystem as a whole.
In response to HIP-51, this proposal outlines construction for the integration of Boring Protocol dVPN into Helium network as a subDAO with its own DNT ( decentralized network token) known as BOP. In respect to the nature of difference between this potential SubDAO and existing SubDAOs many of the guidelines provided in HIP-51 will need to be considered for new solutions.
Background
For the Helium Network to grow globally in number of active devices and users it is necessary to develop economic incentives and opportunities for the infrastructure operators participating in supporting the network. Adding utility and profitability to the hardware involved now and in the future will solidify the Helium network as a major player across many types of networks. 
This proposal will require addition to the economic models set forth to further incentive individual participants' activity in new networks with the advantage of increasing profitability of said participants.
HIP 51 outlines basic requirements for existing models of the SubDAOs within the Helium Network. For the purpose of this HIP, the integration of two networks would need to omit some aspects of the economic model to procure the privacy and security that operators seek within both ecosystems. However, the pursuit of bringing value to the Helium token model must remain present. 
The opportunity to have HIP-51 subDAO layer 1 migrated to Solana is present in this proposal for the purpose of allowing the DC/HNT/BOP mechanics to flourish as well as to capitalize on the potential for Helium with the Solana Mobile platform. While not necessary at this time the eventual growth and overflow of Helium's “Network of Networks” could mean a more robust layer 1 is needed. The advantage of Keeping Helium and Boring separate via Multi-chain interoperability is that node operators can still stand to profit in the event that one of the networks faces outage(s). 
Boring Protocol is privacy and security at its foundation but can be grown to generate subDAOs of its own network models ie. Proxy networks, distributed storage etc. 
Boring Protocol operates currently on the token model envisioned by its team and community and is discussed further in this proposal.
The technical and economic design decisions of the Helium Network today have been made around the flagship LoRaWAN Decentralized Network Protocol. 

Motivation
The drivers for this proposal are as follows:
Privacy and Security for Helium “subscribers” & internet users as a whole
Security and Scalability of the L1 as proposed in HIP-51
Additional mechanisms for profitability to Helium Network infrastructure operators
Network growth to Boring Protocol to generate a viable and strong dVPN (more nodes = greater obfuscation opportunity)
Proving a model of multi chain redundancy to further secure network economics and participant profitability 
Sustainability in manufacturing and distribution of hardware
Increased Utility and Security for EVM mechanisms like wHNT

Stakeholders
This proposal impacts all HNT holders and their ecosystem as well as all BOP holders and their ecosystem. The objective is to provide greater growth to both networks while equally providing opportunity to the economics of Helium hardware operators,  simultaneously creating privacy access to Helium network infrastructure.
The Helium token model is described in the HIP’s presented previous to this proposal. Borings tokenomics weigh several key factors to provide incentive for network growth and network strength. 
The BOP token utility is mainly a settlement between “clients” of the dVPN and “operators” of nodes which are used to privately access the internet. Apart from this primary function the token is staked by node operators to present loyalty to the network and financial incentive to act in “good faith” as they operate exit nodes. As nodes remain connected they increase their opportunity for traffic/data to be directed through their node and increase their profitability as the token is settled on a data consumption rate. 
It is possible that the multi-chain interoperability may include a portion of Bop to be vested into contract to create a wrapped Bop on the Helium chain as well as liquidity. This proposal could be beneficial in the event Solana incurs an outage(s) and would allow Boring to continue operation and settlement from Helium. Though this is not ideal, it may be a greater measure for stability of the dVPN itself and allow for this continued profitability to node operators within the existing Boring Network and the Helium Network.
In researching and writing this HIP Boring has used our social forums to conduct numerous discussions within the Helium community to generate this proposal. Continued participation and discussion is greatly encouraged to ensure the proposal is in line with the needs of both communities.

Detailed Description
An initial integration may not include all economic requirements as described in HIP51 as the model for such only sets forth guidance for network structures that previously existed within the Helium ecosystem. As Boring is an entirely separate access layer network we propose that the Data Credit models proposed in other subDAOs be removed from the equation for this particular proposal. As Boring grows and the opportunity to use DC as a solution within our network model presents itself the community can propose and implement such changes. 

Boring Protocol will instead add utility and value to the Helium token ecosystem by allowing customers to pay using SPL wrapped HNT and eventually HNT via cross chain bridges to fund their usage of the dVPN. This provides two distinct advantages to the Helium community: 
Potential further dispersal of HNT to the SPL wrapped HNT Liquidity pool and utility beyond market trading for the token itself. 
The ability for certain Helium infrastructure operators to continue profiting from their equipment in the event of a Helium network outage.

As Boring implements cross-chain bridges the potential for added user payment types increases as well as the ability to access clients who may use these other blockchain based tokens. The ability to onramp such users will strengthen the network in driving further revenues to the operators who services said clients. To make this possible and continue with Bop token as the settlement, liquidity pools will be created as these client funding option types are added to the protocol. For instance, If Bob wishes to pay for the dVPN service using Monero (XMR) token, he can fund the usage contract and as he consumes data the settlement layer for Boring will use real time oracles and this new liquidity pool to produce a trade for the XMR to BOP. The settlement layer will then send the BOP to escrow to be withdrawn by the node operator servicing Bobs access to the network at the time the operator requests such. The same sort of process will take place as Helium(HNT) or the wrapped HNT is added as a funding option in regards to this proposal. 

DIAGRAM 1

Implementation of this proposal requires some key factors be settled beyond tokenomics. Distribution being the primary potential drawback. Boring Protocol and it’s existing economic model is primarily dependent on a strategic balance between number of consumers and online nodes servicing them. Technical boundaries of the hardware we have developed for (Rasp Pi4b) and the bandwidth node operators can distribute to users have resulted in a series of tests. These tests, while initial, have generated a balance of 10 simultaneous clients per node operated. While this balance is impossible to ensure given the decentralized nature of the protocol it remains a good measure for the Boring Protocol model. Factors such as client needs in regional node selection, pricing of bandwidth and general quality of connection are to be considered. 

It is important to fully understand the ways Boring Protocol node operators profit from the dvpn network to grasp the need to limit the number of total nodes on the network and how quickly the onboarding of dual mining HNT/BOP nodes  should occur.

Platform Incentives

45% of the total supply of Bop has been set aside for a 10 year distribution to node operators based on key factors that will reward uptime, specific region and bandwidth availability for node operators. This will subsidize growth of the network in key regions that have been identified as desirable to VPN users. This distribution is outlined in the platform incentives documentation found here: link or input document Emmissary

Early supporters operating V1 nodes are rewarded at 1.5X rates.

V2 operators are rewarded at 1.25x standard rates.

These nodes are identified for their rewards through a given transferable NFT they stake to their node. 

Bandwidth Exchange

All node operators who incur dvpn customer traffic are paid 95% of the proceeds from consumed data measured in KB as data is consumed on the network.

The remaining 5% flows back into the Boring treasury for future development and  operational costs.

We have projected a single node with a standard internet connection of X can earn as much as $24-240 per month from this one earning method given consistent traffic and data consumption across their node. This projection is further detailed here: Basis & Core

Subscriber Model

To further reach VPN users outside of the crypto economy Boring will allow fiat payment from subscriber model users. A fixed monthly and discounted yearly rate will be applied to these types of users and 95% of the income from this earning method will be equally distributed to all node operators according to uptime and connection bandwidth during the given period. It is proposed that these earnings be distributed monthly or quarterly. 

The remaining 5% of revenue from this model will be directed into the Boring Protocol treasury for future development and operational costs.


By limiting the total number of nodes allowed on the network Boring can ensure the existing operators remain profitable and servicing clients with quality connections. As the consumer demand grows the ability to add nodes to the network will be both desirable to new participants and be able to be completed quickly as this balance is maintained.

Future Integration

Other possible integrations we envision for 5G and WIFI clients on the Helium network is to have Boring dVPN as an optional product for their users to select and these nodes could offer this at a higher access cost than typical. We propose this be included in a future proposal to reduce the complexity of the current proposal and allow time to research and explore this topic. Boring Protocol can later provide proxy network and data storage infrastructure within the Helium ecosystem and is currently exploring potential proposals for such.

With the potential for a Helium 5G network to service the Solana Mobile phone or SAGA platform we also wish to explore Helium SubDAO migration to Solana as a whole with this proposal providing some “first steps” in bringing Helium liquidity to the Solana chain.


Drawbacks/Challenges


