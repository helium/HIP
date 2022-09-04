# HIP 70: Scaling the Helium Network

- Author(s): Helium Core Developers
- Start Date: 2022-08-30
- Category: Technical
- Original HIP PR: https://github.com/helium/HIP/pull/470
- Tracking Issue: https://github.com/helium/HIP/issues/471
- Status: In Discussion

# Summary

In this HIP, we propose a new approach to Proof-of-Coverage and Data Transfer Accounting by moving this responsibility to oracles and, thereby, reducing the complexity required for operating a blockchain that supports the Helium Network. Through these actions, we believe we can allow for more reliable data transfer and more consistent and predictable Proof-of-Coverage activity. 

With the move to more “oracled” activity on chain, we believe that the simplification allows us to select a more scalable Layer 1 for the Helium community, specifically Solana. Integration of the Helium tokens (HNT, DC, IOT, and MOBILE, initially) into the Solana ecosystem additionally provides Helium wallet holders access to a variety of applications, governance mechanisms, and other utilities not available natively on our sovereign L1.

We acknowledge that this change removes the need for staked validators operating block production and challenge creation as they do today. That said, we expect that HNT stakers will migrate their positions towards securing current and/or future subDAOs and participating in governance through the vote-escrow token based system proposed in [HIP 51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md). Removal of the staked validator reward also returns the full 6.85% of HNT emissions back to the miner pool, benefitting Hotspot owners on all subDAOs. In the first year alone, this is estimated to be over 2 million more HNT rewarded for Hotspot activity.

We consider these changes as complementary to the changes proposed in HIP 51 and a necessary set of changes to more easily implement some of the redemption and governance mechanisms proposed in HIPs 51, [52](https://github.com/helium/HIP/blob/main/0052-iot-dao.md), and [53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md). We additionally expect that more protocols will be attracted to participate in the Helium ecosystem because of the move to a more widely used Layer 1 blockchain.

# Motivation

The Helium Network has grown incredibly quickly with close to 1 million Hotspots deployed around the world, with increasing data usage through an ever expanding list of use cases. While scaling up the network, the core developers and members of the community have spent countless hours supporting this unprecedented growth. As we look towards the implementation of HIP 51 (and the subsequent subnetworks with new use cases), the core developers believe it’s important to evolve the design of the Helium Network to meet the demands of current and future users.

We believe that the two most important goals of the Network should be to ensure the following:

* Reliable Data Transfer activity (and consistent accounting)
* Reliable Proof-of-Coverage activity (and proportional and fair rewards distribution)

In the last several months of the network, both have been challenging for network participants with much reduced Proof-of-Coverage activity due to network size and blockchain/validator load and packet delivery issues due to complexities related to managing routing and packet purchasing data on the Helium blockchain.

# Stakeholders

This HIP has a direct impact on all stakeholders on the network. We believe that overall, Hotspot owners and Users of the network will see more consistent and reliable data transfer as discussed above. 

One set of stakeholders, namely validator stakers, staking pool operators, and validator-as-a-service providers, may be negatively impacted by this change but we believe these parties will continue to be able to participate in network activities. Stakers will be able to more actively participate in governance by staking their HNT into veHNT as described in HIP 51 and earn subDAO tokens like IOT or MOBILE by assigning their veHNT to a network they “vote” for.

# Detailed Explanation

## Implementing Proof-of-Coverage Oracles

Re-designing PoC activity to be implemented as Oracles introduces some new services and changes the way beacons are constructed and reported, as well as how witnessed beacons are detected and reported. Although a final design of this system is still in development, there are a few key concepts that are significant changes to the design of Proof-of-Coverage as it exists today.

### Predictable Beaconing

Today, the Proof-of-Coverage system depends on Hotspots to be informed by their connected Validator that they are being challenged. This system depends on all Validators generating potential challenge keys, those keys being selected by the Consensus Group, the connected Validator staying in sync and connected, and the creating Validator being reachable). This complexity was introduced to improve the on-chain scalability of Proof-of-Coverage and to limit the amount of activity on the Helium blockchain as the network grows (making it not need to scale as the number of Hotspots increases). While well-intentioned, the reduction of activity this causes makes it more difficult for individual Hotspot owners to understand their performance and usefulness to the network and reduces Proof-of-Coverage activity rates in the network at the scale of many millions of Hotspots.

We propose, instead, that Hotspots themselves are responsible for beaconing regularly; with the initial proposed beacon rate to be once per hour. With a predictable beacon rate, a Hotspot owner can be assured that they are “alive” on the network, are eligible for Proof-of-Coverage rewards, and potentially providing useful coverage for devices on the network. 

### Scaling PoC Activity

The beacon itself is simplified to leverage difficult-to-forge entropy data from an oracle. This entropy can be combined with random data generated by the Hotspot and included in beacon receipts. The entropy data can be sourced from non-deterministic sources and can be used to limit replay and premature beaconing. For example, a block hash from another chain can be used as it is hard to predict and therefore hard to precompute a valid beacon. These Entropy Oracle services can be scaled independently using traditional methodologies (i.e., CDNs and regional data centers).

The beacon receipt can be reported, once transmitted, directly to the PoC Ingestion Oracle. This oracle can also receive witnessed beacon receipts from witnessing Hotspots. All these receipts will be signed by the emitting Hotspot and, instead of immediately processing this data, the Oracle’s job is to write the data to durable storage after simple validations to prevent structurally invalid data from being collected. Full validation can be deferred to a later data pipeline. Today, this function is served by a single Staked Validator that could be offline or unable to process receipts at scale. With this new model of collecting PoC receipts, the PoC Ingestion Oracle can be scaled horizontally both to increase reliability and reduce latency of beacon/witness delivery. Storage can also be scaled independently although this raw dataset need not be stored permanently in high availability storage as once it is processed, it can be archived.

From here, the PoC Verifier Oracle is introduced to the data pipeline. This oracle is responsible for analyzing receipt files, correlating beacons with witnesses, and analyzing entire events for validity. This Oracle can be scaled by sharing time buckets, and this task is extremely parallelizable.

Using traditional data pipeline techniques, this architectural change to Proof-of-Coverage will help scale the network to millions of Hotspots across multiple subDAOs. This technique can be adapted for the IOT and MOBILE network today and could be considered for the WIFI subDAO as well in the future. 

### Faster Iteration of Proof-of-Coverage

In addition to improving the scalability of processing data and sustainability as the number of Hotspots increase in the network, the PoC Verifier Oracle introduces an opportunity to quickly iterate on new models for Proof-of-Coverage validation. We are no longer limited by the 14 receipts per beacon as we have today due to limitations of the chain. We can also iterate more quickly on improvements proposed by the community including introducing oracles of location validation, secure concentrators and mappers, and using oracles to model the “Graph” of Hotspots.

### Oracling Rewards

By moving to this data pipeline of Proof-of-Coverage, we propose introducing a final Oracle to the network, the Rewards Oracle. Although the Verifier Oracle can produce rewardable and invalid receipt reports for analysis, this Oracle will be responsible for combining this data with emissions requirements for both Proof-of-Coverage and Data Transfer and issue appropriate subnetwork rewards (for both IOT and MOBILE) for each subDAO.

A diagram of this new set of oracles is below.

```mermaid
flowchart TB
    H1(Hotspot 1) --> |Beacon Report| LoadBalancer
    H2(Hotspot 2) --> |Witness Report| LoadBalancer
    H3(Hotspot 3) --> |Witness Report| LoadBalancer
    H1 -.-> |Beacon| H2
    H1 -.-> |Beacon| H3
    H1 --> Entropy
    H2 --> Entropy
    H3 --> Entropy
    Bucket[(PoC Bucket)]
    Ingest --> |Receipts| Bucket
    Verifier <--> |Rewardable/Invalid| Bucket
    Bucket <--> |Reward Details| Rewards
    subgraph PoC
        Entropy(Entropy)
        LoadBalancer(Load Balancer) --> |N| Ingest
        Ingest(PoC Ingest Farm)
        Verifier(PoC Verifier)
    end
    Rewards(Reward Server)
```

## Data Transfer Accounting Oracles

It’s equally important to scale data delivery and the associated rewards as the network grows. Today, the complexity of scaling Hotspots, Routers, and reimplementing LoRaWAN primitives has made it difficult to provide a usable network for the scale of activity we expect on the enormous network built by Hotspot owners.

We introduce a very similar structure as the updates to Proof-of-Coverage with some additional details around what data needs to be tracked. The fundamental goal is that any existing LoRaWAN Network Server (an LNS, e.g., Chirpstack), can be brought to the Helium network and, once onboarded, immediately be able to receive data from Helium Hotspots. Instead of buying OUIs on chain, and writing transactions to the blockchain to specify routing rules, a coordination layer with configuration is maintained along with a scalable Load Balancers and Packet Routers that forward packets from Hotspot to LNSs.

### Scaling Data Delivery

Today, Data Delivery can be dependent on Validators, Routers, and other chain-following entities on the network. This often causes failures in delivery and affects applications that use the LoRaWAN network. This is frustrating for device users. Although we have made significant improvements to stability, there still often are cases where a Router may not be able to scale appropriately, a Validator may not be ready to serve a Hotspot, etc.

In this proposal, we also introduce a few new pieces of infrastructure and return to using traditional LoRaWAN network servers with our new architecture. Hotspots will speak directly to Load Balancers which are traditionally easier to scale horizontally. These Load Balancers are paired with Packet Routers that have up-to-date information on how to route packets and are able to stream packet details like hashes, sizes, and originating Hotspots to a scalable storage layer, similar to the PoC Ingestion Oracle as described above.

These Packet Routers can stream packets directly to LNSs based on routing information stored in a Config Service and can make decisions on whether or not packets should be routed based on the rules of the network. 

These architectural changes are summarized in the following diagram.

```mermaid
flowchart TB
    H1(Hotspot 1) --> |Packet| LoadBalancer
    H2(Hotspot 2) --> |Packet| LoadBalancer
    H3(Hotspot 3) --> |Packet| LoadBalancer
    PacketRouter <--> |GRPC| Config
    PacketRouter <--> |GWMP| LNS
    Rewards(Rewards Server)
    Bucket[(Packet Reports)]
    PacketRouter --> |Packet Reports| Bucket
    PacketVerifier <--> | Rewardable/Invalid| Bucket
    Bucket <--> |Reward Details| Rewards
    subgraph Routing Config
        CD[(Config DB)] <--> Config
        Config(Packet Routing Config)
    end
    subgraph Data Routing
        PacketVerifier(Packet Verifier)
        LoadBalancer(Load Balancer) <--> |N| PacketRouter
        PacketRouter(Packet Router)
    end
    subgraph Users
        LNS(Lora Network Servers)
    end
```

## Moving Chains and Removing Staked Validators

The Helium Network is primarily intended to incentivize and develop the largest community-oriented wireless and data networks and enable utility in a way that has never been built before. With Proof-of-Coverage and Data Accounting moved to oracles, the consensus rules become somewhat commoditized as they are focused simply on payments (p2p and rewards) and identities (Accounts, Hotspots, Routers, etc.). As such, we believe that it’s in the best interest of the network to move to a more scalable architecture. We propose that the Helium tokens, governance, and economics around HNT, IOT, and MOBILE emissions be moved to the Solana blockchain.

There are a variety of advantages of integrating with the Solana ecosystem including fast and cheap transactions and native governance primitives, but it also brings a whole host of new developers into our ecosystem. The ecosystem’s development of the new Solana Mobile Stack (and the Solana Saga phone) brings a closer connection to the Helium ecosystem which can enable connectivity and access for these devices.

A more thorough analysis of the variety of options considered is forthcoming but to briefly summarize our reasoning, we evaluated several options. We considered scaling our existing L1 and bridging to other ecosystems. This would involve continuing to invest in our Erlang-based architecture that currently doesn’t have support for bridging, smart contracts, and other important features that we’d need as the network grows to many millions of Hotspots and new cohorts of users. We also considered running a new app chain on another platform (like Cosmos or an EVM L2 chain) but this also comes with the burden of maintaining a chain. Ultimately, it’s important for the developers in this ecosystem to focus on the most important thing: enabling building of data networks. Specifically, the core innovation of this network is incentivization through Proof-of-Coverage and enabling data transfer. When we started this journey, there wasn’t a viable blockchain that would scale in costs and would support the primitives this network needed so we went down the road of building our own. Over the last few years, this community has managed chain halts, consensus rule updates, and a tremendous amount of firefighting.

With the move to Solana, we propose that the Consensus and Challenge Construction Reward portions of HNT emissions (6.85%) are allocated to the subDAOs as proposed in HIP 51, increasing the allotment of rewards to Hotspot owners. This should continue to incentivize deployment of the IOT and MOBILE network.

The Helium Validator community is robust. At the time of writing, almost 38% of all HNT is staked in Validators. And the over 3,700 validator nodes are supported by a deep ecosystem of custodial (pooled) and non-custodial (dedicated) hosting providers. Though the transition to Solana would remove the need for staked HNT as we know it today, we believe the proposed subDAO structure allows for current HNT validators to redeploy their HNT and resources in ways that will earn comparable yield while playing a similarly important role in the growth of the network, with this role moving from mining blocks to subDAO governance. 

In order to prepare for this change, however, we also propose a few necessary steps to enable this transition:

**Convert all Staked HNT to veHNT**

All staked HNT at the time of the transition be automatically converted to veHNT with a minimum (as defined by HIP 51) six month lockup. This enables all staked HNT holders to continue to participate in the ecosystem by assigning their veHNT to a subDAO (IOT or MOBILE) in order to influence the DAO’s Utility Score, participate in new Subnetwork Proposals, or participate in overall governance of the Helium Network. 

According to HIPs 52 and 53 veHNT stakers will earn both IOT and MOBILE tokens, respectively, by staking their veHNT in support of these subDAOs and participating in their governance. The IOT (HIP 52) subDAO sets aside 6% of all emissions as does the MOBILE (HIP 53) DAO. A further elaboration of veHNT is also available in HIP 51.

**Reduce the cool-down period of Staked Validators**

We propose reducing the cool down period about a month before the chain migration. The proposed cool down period during this time would be two weeks which should give any existing staked HNT holder to release their stake if they choose to do so.

## Multiple Oracle Operators

Initially, we propose that the aforementioned oracles be built and operated by the Nova Labs team on behalf of the Helium Foundation. We believe that this will help the Helium network scale in the short term and immediately address concerns with scaling Proof-of-Coverage and Data Delivery. We do acknowledge, however, that there needs to be a long term plan to enable multiple Oracle operators to participate in these activities. 

We propose that as this infrastructure is deployed, the core developers and community introduce new HIPs that enable subDAOs to have multiple oracles, the specific coordination rules (consensus, etc), and discuss the potential of incentivizing these actors. Today, HIP 52 and 53 propose such oracle rewards but do not specify the responsibility of those oracles or how they come to agreement. We propose that until a time that multiple oracle providers are online, this reward is not issued to the single oracle, Nova Labs, or the Helium Foundation.

While this process completes, however, the deployed oracle code and raw event data used by the discussed data pipeline will be made available for analysis in order to replicate.

## PoC, Data Trasnfer, and Decentralization Milestones

In order to be accountable and transparent with progress towards oracle decentralization, we define a set of prioritized milestones based on network health regarding the stated goals and infrastructure proposals for PoC and Data Transfer.

Once these have been achieved and appropriate success metrics reached, milestones towards oracle decentralization will the the immediate next priority. Any deviation from the decentralization milestones and priorities must be documented and updated in this HIP with relevant justification.

| # | Milestone description | Completion date |
| - | - | - |
| 1 | PoC Oracles Deployed (Is it possible/preferable to decouple mainnet deployment of off-chain PoC from the new L1 deployment?) | |
| 2 | Data Transfer Oracles Deployed | |
| 3 | Deployment and migration to new L1 (are there any metrics we can define to measure success for improvements on PoC and Transfer rate? Beacon rate, transfer reliability, etc?)| |
| 4 | PoC Improvements: Witness stuffing / Anti-gaming, other security etc (would like to break this up into a few concrete milestones, but need input on which high priority improvements supercede decentralization) |
| 5 | Oracle Decentralization HIP Passage | |
| 6 | Oracle Decentralization Proof-of-Concept on testnet with community run Oracles | |
| 7 | Oracle Decentralization mainnet deployment | |

The proposed timeline for achieving these milestones is 12 months from the passage of this HIP. (is this reasonable?) Any extension must be documented and updated in this HIP with relevant justification.


# Drawbacks

The primary drawbacks of this proposal are discussed above in the Moving Chains, Removing Staked Validators, and Multiple Oracle Operators sections. Although there are some concerns, we believe that this is the best move forward in order to scale the network, align incentives to Hotspot owners, and enable HNT, IOT, and MOBILE holders more utility in the future.
