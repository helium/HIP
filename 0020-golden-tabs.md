# HIP20: Golden Tabs

- Author: [@lthiery](https://github.com/lthiery)
- Start Date: 2020-10-29
- Category: Technical
- Original HIP PR: [#68](https://github.com/helium/HIP/pull/68)
- Tracking Issue: 

# Problem Statement
[probem-statement]: #problem-statement
In its current state, the Helium Blockchain does not allow permissionless adding of gateways. All gateways on the 
blockchain have one of the following origins:

|Name|MSRP|Quantity|Shipping Dates|Keys Store|
|---|---|---|---|---|
|Genesis Hotspots|$0|45|2019-07-29|File|
|Helium Hospots|$500|~9k on-chain, 14.5k in staking server|2019-07-29-2020-10-01|ECC608|
|RAK Hotspots|$250|   |2020-10|File|
|Miner Pro Alpha|$0|339|2020-09|File|


This strategy has thus far prevented large-scale attacks of “virtual gateways” as permissionless adding has the proposed
 cost of $40 to add and $10 to assert location. Instead, attacks require buying hardware listed above with their 
 respective costs; this means being a good actor is slightly easier as you are guaranteed to have LoRaWAN hardware and
 the cost of each node is at least 4x the cost of the permissionless model.

It is paramount to the network's growth in coverage to allow the permissionless adding of gateways to the network. In 
 other words, anybody must be able to on a standard LoRaWAN gateway (or use already deployed hardware) and pay the
 $40 staking fee. With 1M deployed gateways worldwide (according to 
 [Semtech marketing materials](https://www.semtech.com/lora)), the scale of the opportunity to convert existing 
 infrastructure cannot be ignored.
 
 
It is a general consensus in the community, including Helium and DeWi, that Proof-of-Coverage (POC) does not yet do 
 enough to instill confidence for permissionless adding of gateways to be enabled. There are many ideas for how to 
 improve POC, but they all boil down to concepts of circular trust validation between gateways. 

HIP-9 proposes a levelling scheme based on trustworthiness of the gateways based on origin; however, it is the opinion
 of this HIP that gateways, no matter the origin, carry no inherent trust. In particular, it is quite possible to 
 “jailbreak” even a Helium Hotspot and to run an arbitrary Miner on the hardware. And over the months we have seen many 
 question deployments of Helium Hotspot clusters which have proven to be quite difficult to snuff out using circular 
 validation logic.
 

# Solution Summary
[solution-summary]: #solution-summary

This proposal side-steps the inherent lack of trust in gateways by creating a new blockchain actor: a “Golden Tab”. In 
 effect, this actor creates a root of trust for levelling and POC.

The Golden Tab (GT) is a tamper-proof GPS tracker, designed by Helium and audited by DeWi. The design is such that 
 physical tampering may be near impossible and many public and confidential methods may be used to counteract GPS 
 spoofing. The design also focuses on making the device secure and cheap, such that supply of Golden Tabs can be
 relatively unrestricted.

The GT pairs with a smartphone over BLE, upon which a p2p link with other network actors may be extended without adding
 additional cost or complexity to the GT hardware itself. This enables transmit claims to be made by the GT (ie: a 
 packet was broadcast at this location at this time/block) and for the packet itself to be dynamically crafted using
 similar logic to Proof-of-Coverage challenges. We will dub these packets **Golden Tab Challenges**.

In addition to GPS spoofing, the design must be wary of transmit attenuation. That is to say, while the firmware on the
 GT may be more or less untamperable, it may be possible to attenuate the LoRa emissions while still allowing legitimate
 GPS reception.

When a gateway receives a packet from a GT, it should not know of its origin. In other words, the packet looks like a 
 standard LoRaWAN packet and will be routed to an OUI. To allow this, the GT construction should derive several mock 
 LoRaWAN Sessions and the GT would maintain several LoRaWAN sessions at once such that OUI censorship of gateways is
 mitigated.

The OUIs would forward received packets to the Consensus Group, which would use the information to update the Trust 
 Score of the gateway. While there is some notion of “Gateway Score” today, we will ignore current mechanisms entirely
 in this proposal and propose a brand new definition. 

The general idea is that the Trust Score is that it will qualify whether and to what extent a Gateway may be eligible
 for POC and POC rewards. In addition, the Trust Score would decay at a rate such that periodic reaffirmation by a GT
 would be necessary. The decay rate itself should be dependent on the relative earning rate of that Gateway. Therefore,
 high earning Gateways will require frequent validation, while perhaps remote and sparse clusters could subsist without
 frequent visits by a Golden Tab.


# Hardware and Firmware Design
[hardware-and-firmware-design]: #hardware-and-firmware-design

The Golden Tab will feature LoRa, BLE, & GPS radio modules, an accelerometer, a hardware key store, and an RGB LED.

To make tampering near impossible, a capacitive mesh will be potted around the main board. The device will be calibrated
 upon certification and should the capacitance of the mesh change within a range, the hardware key store will be
 invalidated.

The device will be battery powered and will feature wireless charging. The device must be able to maintain itself in a 
 power-down state for many years such that the tamper-proof capacitive mesh may not be circumvented. 

The device could feature an Over-the-Air update method, via BLE for example, but would need to validate its trust with a
 DeWi maintained actor before doing so. OTA could also be made entirely impossible. 

Regardless of OTA, the hardware key store will generate its on-chain identity and this identity will be certified by 
 DeWi upon “blessing” these devices.

The accelerometer will be used for user interaction, as tapping for example, could be used to put the device into active
 “mapping” or sleep mode. In addition, the accelerometer may play a role in counteracting GPS spoofing. BLE and LoRa may
 also contribute to this.

In the end, the construction of the device provides the following assurances:
* the device may not be modified, thus the content of its messages may be trusted
* a signed message is certifiable in its origin, as the key was generated in the hardware key store

This reduces all tampering to RF signals: GPS spoofing or LoRa attenuation or amplification/repeating.


# Golden Tab Challenges
[golden-tab-challenges]: #golden-tab-challenges


A Golden Tab creates challenges when it is in “active” mode. Similar to Proof of Coverage, a GT challenge request is 
 made where the approximate location is included. Once accepted by the Consensus Group (CG), a LoRaWAN session for
 `gt_challenge_num_ouis` OUIs is derived in such a way that only the end-device, the OUI, and perhaps the CG 
 (if necessary) may be able to derive the Session Keys. For the next gt_challenge_duration blocks, the challenge is
 active and GT packets are emitted by the Golden Tab.

The packets are indistinguishable from other end-devices on the network such as to mitigate special treatment of these
 packets by gateways. As such, gateways are truly proving that they provide coverage at this time. It’s worth noting
 that this only proves that a physical antenna has received the packet in the appropriate area and exploitation vectors
 where received packets are shared to many gateways are not mitigated.

For every packet that is broadcast via LoRaWAN, a receipt is provided via BLE to a smart phone which then submits it via
 libp2p to the CG. As such, the GT claims to have emitted a packet at a certain GPS location with a certain GPS accuracy.
  Given that attenuating the LoRa signal is quite possible, these are perhaps only relevant for earning mechanisms for
  the GT and would not be used for negatively scoring Trust of gateways. This is so that a negative scoring attack on a
  region may not be performed.

Meanwhile, Gateways that do receive the packet shall be rewarded via an impact on Trust Score.


# Trust Score
[trust-score]: #trust-score

The goal of the Trust Score is to qualify authentic gateways to earn via Proof-of-Coverage, ie: the current 
 gateway-to-gateway RF validation mechanism. The goal of the Trust Score is to make it uneconomical for virtual gateways
 to exist. 

To put it succinctly, the information from the GT Challenge is that an antenna existed at that point in time in that 
 location. It can do nothing to combat the sharing of a single packet amongst colluding gateways and other approaches
 are necessary for that. However, this information is effective for withholding POC earnings from gateways until they do
 get witnessed, thus a cheat cluster would require at least some bearing on reality. 

In addition with other efforts of limiting earnings per grid area, this would effectively reduce the earning potential
 of bad actors as they would be forced to provide a spread of real antennas to maximize earnings, thus providing true
 coverage.

Finally, Trust Score would require some rate of decay and it is suggested that this rate of decay be proportional to
 earnings for that gateway or grid.
