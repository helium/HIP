# HIP 27: Data Credit Support for CBRS 5G on Helium Network

- Author: FreeedomFi @zer0tweets 
- Start Date: February 23th, 2021
- Category: Technical
- Tracking Issue: https://github.com/helium/HIP/issues/134
- Status: In Discussion

## Summary
This proposal suggests an economic mechanism to support higher new wireless protocols on Helium network, starting with LTE and 5G in CBRS spectrum band

## Motivation

The long term goal for Helium network is to go beyond LoRaWAN and to make it possible to build wireless networks using other wireless protocols like Wi-Fi, LTE, 5G etc. Data pricing and, as well as, algorithm and economic model for verifying RF coverage (aka proof-of-coverage) that works well for LoRaWAN isn’t an ideal fit for other wireless protocols like 5G, LTE, Wi-Fi etc. 

## Stakeholders
- People looking to transmit the data across Helium network 
- Miners looking to deploy non-LoRaWAN wireless nodes 

## Detailed Explanation
To experiment with Helium’s expansion towards support for high throughput wireless protocols, we are looking to pilot a Helium-based neutral host CBRS network, where HNT miners can be attached to CBRS small cells. The goal of the experiment is to build a few clusters of CBRS infrastructure around a handful of urban locations and open such network to MNOs and MVNOs to offload their existing data traffic. It is important to note that to make such a network useful to MNOs and MVNOs, it is not required to completely blanket a particular area with CBRS wireless coverage. It is expected that operators roaming into Helium neutral host network will have existing wireless coverage within the area and will use Helium network for augmenting cellular capacity indoors or in highly trafficked areas.   

If successful with CBRS, we see this expanding into WiFi (akin to a decentralized version of Google’s project Orion) as well as other, non-CBRS 5G bands for urban densification of cellular networks. 

Aside from the required modifications to the miner software itself, enabling this experiment also requires that it is possible to redeem Data Credits towards passing data using a variety of RF protocols 

## Redeeming Data Credits for 5G, LTE and Wi-Fi

To make it possible to redeem Data Credits towards different types of wireless data, it is suggested that we introduce a chain variable that will function as a conversion ratio of DC to data packets as a function of: 

- Types of wireless protocol i.e. LTE, 5G, Wi-Fi etc. 
- Specific location of the access point transmitting the packets, since data prices vary per geography

In the future, as we grow and expand the network, we may want to have different conversion ratios, but for the purposes of the initial contemplated pilot, we’d like to focus on introducing just a conversion ratio that would denominate economics of a CBRS network. To figure out the initial cost of CBRS Data Credit we looked at the following guiding factors: 

- Cheap prepaid LTE data plans in US sell for $1.50/GB (Mint Mobile 15GB bundle)
- Comcast charges $10 for each 50GB

While it is clear that we’ll need to tweak the pricing for CBRS data as we get more data and better understand the market economics, it is suggested that we initially set the price of passing 1GB of CBRS data through Helium network at $.50 per GB or $.00000003 per LTE packet of 66 bytes.

 




