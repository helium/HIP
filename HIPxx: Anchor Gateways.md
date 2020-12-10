# HIPxx: Anchor Gateways

- Author(s): @georgica, @lthiery, @Carniverous19/para1
- Start Date: 2020-11-16
- Category: Technical
- Original HIP PR: 
- Tracking Issue: 

# Problem Statement
[probem-statement]: #problem-statement

In its current state, the Helium Blockchain does not allow permissionless adding of gateways. All gateways on the blockchain have one of the following origins:

|Name|MSRP|Quantity|Shipping Dates|Keys Store|
|---|---|---|---|---|
|Genesis Hotspots|$0|45|2019-07-29|File|
|Helium Hospots|$500|~9k on-chain, 14.5k in staking server|2019-07-29-2020-10-01|ECC608|
|RAK Hotspots|$250|~5k|2020-10|File|
|Miner Pro Alpha|$0|339|2020-09|File|

This strategy has thus far prevented large-scale attacks of “virtual gateways” as permissionless adding has the proposed cost of $40 to add and $10 to assert location. Instead, attacks require buying the hardware listed above with their respective costs; this means being a good actor is slightly easier as you are guaranteed to have LoRaWAN hardware and the cost of each node is at least 4x the cost of the permissionless model.

It is paramount to the network's growth in coverage to allow the permissionless adding of gateways to the network. In other words, anybody must be able to use a standard LoRaWAN gateway (or use already deployed hardware) and pay the $40 staking fee. 

With 1M deployed gateways worldwide (according to Semtech marketing materials), the scale of the opportunity to convert existing infrastructure cannot be ignored.
It is a general consensus in the community, including Helium and DeWi, that Proof-of-Coverage (POC) does not yet do enough to instill confidence for permissionless adding of gateways to be enabled. There are many ideas for how to improve POC, but they all boil down to concepts of circular trust validation between gateways.

HIP-9 proposes a levelling scheme based on trustworthiness of the gateways based on origin; however, it is the opinion of this HIP that gateways, no matter the origin, carry no inherent trust. In particular, it is quite possible to “jailbreak” even a Helium Hotspot and have it run an arbitrary Miner on the hardware. And over the months we have seen many questionable deployments of Helium Hotspot clusters which have proven to be quite difficult to snuff out using circular validation logic.


# The Root of trust

This proposal side-steps the inherent lack of trust in gateways by creating a special LoRa concentrator module that we can trust. Whereas today, RSSI, SNR and GPS timestamps cannot be inherently trusted, reports from these "Anchor Gateways" will be a root of trust for physical information on the network.
The core of the proposal is to have a secure element, such as the MAX32510 run the packet forwarder application and sign the packets on-chip.

![alt text](https://0a40547cca595ca02f5b5b1205d8def3.syncrob.it/images/concetrator.jpg)

The MAX32510 can provide a guarantee that the firmware on-board is unchanged. Along with a secure key-store, you can guarantee that it only signs what you programmed the firmware to sign.

The main attack vector would be tampering with the SX1302 and GPS modules. In theory, the lines could be carefully measured by the MAX32510 to detect PCB modification. In addition, MAX32510 features tamper proof sensors, temperature and voltage monitor.

Concentrator will also feature an out of band check on the antenna port, ensuring that the GG is actually connected to an antenna and not a series of attenuators.

These modules would be designed by SyncroB.it and manufactured under the supervision of DeWi. As such, our trust in these modules derives itself in trusting that process. In effect, modules with keys that have been provisioned by this process will be a root of trust for physical information on the network.

# Solution Summary
[solution-summary]: #solution-summary

This proposal side-steps the inherent lack of trust in gateways by creating a new blockchain actor: a “Golden Gateway”. In effect, this actor creates a root of trust for levelling and POC.

The Golden Gateway (GG) is a tamper-proof gateway, designed by SyncroB.it and audited by DeWi. The design is such that physical tampering may be near impossible. The design also focuses on making the device secure, such that supply of Golden Gateways can be relatively unrestricted.

The GG works as regular Helium/RAK gateway, upon which a p2p link with other network actors may be extended without adding additional cost or complexity to the GG hardware itself. This enables transmit claims to be made by the GG (ie: a packet was broadcast at this location at this time/block) and for the packet itself to be dynamically crafted using similar logic to Proof-of-Coverage challenges. We will dub these packets Golden Gateway Challenges.

When a gateway receives a challenge from a GG, it should not know of its origin. In other words, the packet looks like a standard RF packet. The GG would forward received packets to the Consensus Group, which would use the information to update the Trust Score of the gateway. While there is some notion of “Gateway Score” today, we will ignore current mechanisms entirely in this proposal and propose a brand new definition.

The general idea of the Trust Score is that it will qualify whether and to what extent a Gateway may be eligible for POC and POC rewards. In addition, the Trust Score would decay at a rate such that periodic reaffirmation by a GG would be necessary. The decay rate itself should be dependent on the relative earning rate of that Gateway. Therefore, high earning Gateways will require frequent validation, while perhaps remote and sparse clusters could subsist without frequent revalidation.


# Hardware and Firmware Design
[hardware-and-firmware-design]: #hardware-and-firmware-design

The Golden Gateway will feature LoRa, BLE, & GPS radio modules, and a hardware key store.

To make tampering near impossible, traces to the main chips will be buried in the 3rd and 4th layer while potting around chips will also be employed. The device will be calibrated upon certification and should anything change occur, the hardware key store will be invalidated.

The hardware key store will generate its on-chain identity and this identity will be certified by DeWi upon “blessing” these devices.

In the end, the construction of the device provides the following assurances:
* the device may not be modified, thus the content of its messages may be trusted
* a signed message is certifiable in its origin, as the key was generated in the hardware key store

This reduces all tampering to RF signals: GPS spoofing or LoRa attenuation or amplification/repeating.

# Golden Gateway Challenges
[golden-gateway-challenges]: #golden-gateway-challenges

A Golden Gateway creates challenges. Similar to Proof of Coverage, a GG challenge request is made where the approximate location is included. 

The packets are indistinguishable from other gateways on the network such as to mitigate special treatment of these packets by gateways. As such, gateways are truly proving that they provide coverage at this time. It’s worth noting that this only proves that a physical antenna has received the packet in the appropriate area and exploitation vectors where received packets are shared to many gateways are not mitigated.

For every packet that is broadcast via LoRaWAN, a receipt is provided via libp2p to the CG. As such, the GG claims to have emitted a packet at a certain GPS location with a certain GPS accuracy. Given that attenuating the LoRa signal is quite possible, these are perhaps only relevant for earning mechanisms for the GG and would not be used for negatively scoring Trust of gateways. This is so that a negative scoring attack on a region may not be performed.

Meanwhile, Gateways that do receive the packet shall be rewarded via an impact on Trust Score.


# Trust Score
[trust-score]: #trust-score

The goal of the Trust Score is to qualify authentic gateways to earn via Proof-of-Coverage, ie: the current gateway-to-gateway RF validation mechanism. The goal of the Trust Score is to make it uneconomical for virtual gateways to exist.

To put it succinctly, the information from the GG Challenge is that an antenna existed at that point in time at that location. It can do nothing to combat the sharing of a single packet amongst colluding gateways and other approaches are necessary for that. However, this information is effective for withholding POC earnings from gateways until they do get witnessed, thus a cheat cluster would require at least some bearing on reality.

In addition with other efforts of limiting earnings per grid area, this would effectively reduce the earning potential of bad actors as they would be forced to provide a spread of real antennas to maximize earnings, thus providing true coverage.

Finally, Trust Score would require some rate of decay and it is suggested that this rate of decay be proportional to earnings for that gateway or grid.


