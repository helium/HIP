# HIP 27: Support CBRS 5G on Helium Network

- Author: FreeedomFi @zer0tweets 
- Start Date: February 23th, 2021
- Category: Technical
- Tracking Issue: N/A

## Summary
This proposal suggests an economic mechanism to support higher new wireless protocols on Helium network, starting with LTE and 5G in CBRS spectrum band
Motivation

The long term goal for Helium network is to go beyond LoRaWan and to make it possible to build wireless networks using other wireless protocols like Wi-Fi, LTE, 5G etc. Data pricing and, as well as, algorithm and economic model for verifying RF coverage (aka proof-of-coverage) that works well for LoRaWan isn’t an ideal fit for other wireless protocols like 5G, LTE, Wi-Fi etc. 

## Stakeholders
- People looking to transmit the data across Helium network 
- Miners looking to deploy non-LoRaWan wireless nodes 

## Detailed Explanation
To experiment with Helium’s expansion towards support for high throughput wireless protocols, we are looking to pilot a Helium-based neutral host CBRS network, where HNT miners can be attached to CBRS small cells. The goal of the experiment is to build a few clusters of CBRS infrastructure around a handful of urban locations and open such network to MNOs and MVNOs to offload their existing data traffic. It is important to note that to make such a network useful to MNOs and MVNOs, it is not required to completely blanket a particular area with CBRS wireless coverage. It is expected that operators roaming into Helium neutral host network will have existing wireless coverage within the area and will use Helium network for augmenting cellular capacity indoors or in highly trafficked areas.   

If successful with CBRS, we see this expanding into WiFi (akin to a decentralized version of Google’s project Orion) as well as other, non-CBRS 5G bands for urban densification of cellular networks. 

Aside from the required modifications to the miner software itself, enabling this experiment also requires a number of changes to the Helium blockchain. Specifically: 

- Introduce a way to redeem Data Credits towards passing data using a variety of RF protocols 
- Introduce new Proof-of-Coverage model to suit the use case of LTE offload to CBRS, ideally in a fashion that would be portable to other wireless protocols that can be used for LTE offload (i.e. other non-CBRS 5G-friendly bands as well as WiFi)   

## Redeeming Data Credits for 5G, LTE and Wi-Fi

To make it possible to redeem Data Credits towards different types of wireless data, it is suggested that we introduce a chain variable that will function as a conversion ratio of DC to data packets as a function of: 

- Types of wireless protocol i.e. LTE, 5G, Wi-Fi etc. 
- Specific location of the access point transmitting the packets, since data prices vary per geography

In the future, as we grow and expand the network, we may want to have different conversion ratios, but for the purposes of the initial contemplated pilot, we’d like to focus on introducing just a conversion ratio that would denominate economics of a CBRS network. To figure out the initial cost of CBRS Data Credit we looked at the following guiding factors: 

- Cheap prepaid LTE data plans in US sell for $1.50/Gb (Mint Mobile 15Gb bundle) 
- Comcast charges $10 for each $50Gb 

While it is clear that we’ll need to tweak the pricing for CBRS data as we get more data and better understand the market economics, it is suggested that we initially set the price of passing 1Gb of CBRS data through Helium network at $1 per Gb or $.00000006 per LTE packet of 66 bytes.

## Proof-of-Coverage for LTE/5G  

We believe proof-of-coverage in Helium is about wireless radios performing tasks that are useful in validating network readiness to cater to a particular use case. In the case of the original Helium LoRaWan build-out that use case was to act as a stand-alone LoRaWan network provider to end users. As we expand into CBRS, the initial use case we aim to tackle is to augment existing network footprint of MNOs and MVNOs by adding capacity indoors and in urban areas. Because the use case is different, so is the definition of network readiness. Consequently, a new variant of proof coverage must be added to augment the established and well-working LoRaWan model. 

### Portability of Implementation 

While an LTE/5G-specific proof-of-coverage model can work well for LTE & 5G, we may likely require yet another proof-of-coverage model for WiFi. It is, therefore, suggested that in implementing this HIP, we consider long term architecture implications and make it possible for proof-of-coverage models on the Helium network to be pluggable. Akin to chain variables we proposed to define different ratios for redeeming Data Credits as a function of wireless protocol and location, there should be a mechanism to map wireless protocol to a particular implementation of proof-of-coverage, specific to that protocol. 

### Special considerations for CBRS data offload pilot 

Since our goal is to create a few clusters of CBRS networks (aka neutral host networks) for 3rd party MNOs and MVNOs to offload data traffic, it would make little sense to end up with a few dozen nodes randomly spread out around the US. We suggest to initially pick 2-3 small pilot cities and run the program as an “invitation only” beta. Only miners within those cities will be eligible to mine HNT by offering CBRS coverage. Over time, when the model is proven, we will gradually expand to ever greater number of cities.

### Specifics of Proof-of-Coverage Model for CBRS LTE/5G

To effectively validate network readiness for CBRS data offload use case, proof-of-coverage should be structured such that it accomplish the following three goals: 

- Validates that the CBRS cell is on and radiating signal 
- Estimate the usefulness of the location: i.e. is the cell in the woods in Alaska where no phone will ever join it or is in downtown San Francisco with great potential for offloading traffic from multiple MNO networks? 
- Estimate reliability of backhaul: does the cell have good, reliable backhaul or is it just radiating RF signal with no ability to pass traffic to the Internet 

#### Validating that CBRS Cell is Radiating Signal and Estimating Usefulness of Location 

Unlike LoRaWan access points, cellular radios do not have the ability to challenge and witness each other in the same way. Cellular networks are architected to facilitate communication exclusively between a base station and a UE (user equipment) with a sim card in it. Base stations themselves do not have a sim card and cannot emulate a UE, which makes it impossible for one base station to “witness” the RF “challenge” issued by another base station.  

The good news, however, is that unlike in LoRaWan networks, cellular networks already have a large number of devices that are continuously seeking for a cell tower to attach to. To validate that the CBRS cell is on and, at the same time, to estimate the usefulness of a particular CBRS cell on the network, Helium miner attached to the cell will need to perform the following tasks: 

- Continuously collect data on the unique number of IMSIs attempting to attach to the PLMN(s) broadcasted by the cell. 
- Continuously collect information on other cells within the Helium network competing for the UEs (potentially also getting pinged by UEs with the same IMSIs in the neighborhood) 

Based on the above data points we can derive if a) a particular cell is deployed in a location with likely high concentration of UEs; b) whether or not this location is potentially already overserved by the abundance of competing cells. Using this information each CBRS cell within the Helium network will get a usefulness score, which can then be used to determine the final amount of proof-of-coverage rewards that a cell will receive. I.e. cells deployed in locations with no demand will have low usefulness score, as well as cells deployed in locations with oversupply of other cells will also have low usefulness score. 

#### Estimating reliability of backhaul  
Unlike with LoRaWan networks, where data transfer rate and latency are generally not a significant consideration, operating an LTE or 5G cell requires that the cell is connected to a relatively high throughput and low latency backhaul link. Quality of backhaul is directly relevant to usefulness of the LTE/5G node on the network. To determine the quality of backhaul, a Helium miner attached to the cell can perform a periodic backhaul latency and throughput test and adjust that cell’s usefulness score accordingly by multiplying it by some number ranging from 0-1. If the backhaul capacity of the cell is 150Mbs or better (a safe upper limit for a commodity CBRS small cell) and ping latency to 8.8.8.8 (google dns) is 30ms or less -  backhaul multiplier will be 1. As averages for these metrics deteriorate, the multiplier will proportionately move closer to zero. 

At the end of each epoch, rewards allotted to proof of coverage of the Helium CBRS network will then be ratably distributed between all cells in the network based on the total score of cell usefulness multiplied by backhaul reliability score. 

### Economic Model for Experimental Proof-of-Coverage Implementations
Today on the Helium network, all HNT minted per epoch and NOT burned by purchases of data credits simply gets ratably redistributed towards LoRaWan proof of coverage. To incentivize experimentation with new wireless protocols and new proof-of-coverage models that such protocols may require we propose to allocate up to 30% of HNT minted per epoch and NOT burned by purchases of data credits towards proof-of-coverage rewards for new wireless networks, starting with CBRS network. 

This approach protects existing operators of LoRaWan network nodes, yet at the same time incentivizes experimentation with new wireless protocols that are likely to bring more data usage to the Helium network.  

Over time, as more data usage comes to the Helium network and the pool of “HNT minted and not burned by DCs” shrinks to zero, community can explore introducing additional HIPs to properly balance the Proof-of-Coverage rewards between nodes using different types of wireless protocols. 

#### Limiting Upside 
To limit opportunities for gaming the system and avoid the situation where during initial network build out, just a few CBRS nodes will get insanely outsized returns, it is suggested that we introduce a chainvar that will define HNT mining ceiling per CBRS node. The ceiling figure should be pinned to dollar and will automatically vary per epoch, based on HNT oracle price. Ceiling level should be roughly tied to cost of network node hardware and initially set to fairly liberal levels to incentivize fast network build out. Based on the CBRS network costs, it is proposed that the initial ceiling per node be set at $1500 USD per month (which would allow a miner to break even on equipment investment during the course of ~4 months). 

#### Examples 

To illustrate the economics of the above, here are a couple of scenarios:

Scenario #1: Little data going through network and only 5 CBRS nodes on network. 

- 10,000,000 DC are transferred across the network through various Hotspots. 
- The HNT oracle price is $2.
- Total HNT value of DC being transferred is 50 HNT (10,000,000 DC * $0.00001 DC fixed priced divided by the $2 oracle price).
- There are 5 CBRS nodes on the network.  
- 50 HNT would be split proportionally to the CBRS and LoRaWan Hotspots who did the work of passing data, and the remaining 1,624,950 HNT from the DC allocation would be distributed into two buckets:
  - $1500 (ceiling) * 5 (number of CBRS nodes on network)  / $2 (oracle price) = 3750 HNT will be distributed ratably among the operators of the CBRS LTE network 
  - 1,624,950 - 3750 = 1,621,200 will be distributed ratably among the Challengers, Witnesses and Challengees of the LoRaWan network 


Scenario #2: Little data going through network and many CBRS nodes on network.  

- 10,000,000 DC are transferred across the network through various Hotspots. 
- The HNT oracle price is $2.
- Total HNT value of DC being transferred is 50 HNT (10,000,000 DC * $0.00001 DC fixed priced divided by the $2 oracle price).
- There are 2,000 CBRS nodes on the network.  
- 50 HNT would be split proportionally to the CBRS and LoRaWan Hotspots who did the work of passing data and the remaining 1,624,950 HNT from the DC allocation would be distributed wit
  - 1,624,950 - (1,624,950*30%) = 487,470 will be distributed ratably among the operators the CBRS LTE network 
  - 1,624,950 - 487,470 = 1,137,480 will be distributed ratably among the Challengers, Witnesses and Challengees of the LoRaWan network 

[This model](https://docs.google.com/spreadsheets/d/1-ARuH5-JQveDk_yd0Dn3JrTTrD6f6xUSD7MkhZJkHC0/edit?usp=sharing) enables us to play with various scenarios for above: 

##Outcome of new scheme

- Introduces general framework and system variables (new DC vars and new economic model) for expanding Helium network beyond LoRaWAN use case
- Introduces a concept of supporting multiple Proof of Coverage models, aligned with various wireless protocols and use cases 
- Provides specific implementation approach for 5G/LTE proof of coverage  
- Protects existing network by utilizing only a small portion of HNT unused for data credits towards community innovation, aimed at bringing more data usage for the network (vs. redistributing everything back to LoRa PoC rewards) 
- Sets a ceiling per miner for mining using new wireless protocols to preclude gaming the system 
 




