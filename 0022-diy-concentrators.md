# HIP22: DIY Concentrators

- Author(s): @georgica, @lthiery, @Carniverous19/para1
- Start Date: 2020-11-16
- Category: Technical
- Original HIP PR: https://github.com/helium/HIP/pull/91
- Tracking Issue: https://github.com/helium/HIP/issues/94

# Problem Statement
[probem-statement]: #problem-statement

The `add_gateway` remains one of the few permissioned transactions relating to the network. Ideally, `add_gateway`
would be permissionless and any compatible hardware could be added to the blockchain and mine HNT. However, this 
transaction has always been regulated due to a concerns with bad actors creating virtual hotspots only to maximize
mining rewards without truly providing coverage.

Initially, only gateways sold by Helium could be added to the blockchain, but [HIP19](0019-third-party-manufacturers.md) 
expands this ability to approved vendors. One of the principal requirements of HIP19 is that the hotspot identity be
contained with a hardware security module.

While this does not prevent bad actors from lying about the packets they have seen, it does require bad actors to 
acquire hardware and to maintain physical access to the hardware security module; thus the overhead of such operations
is increased and the scalability is hindered.

The fact remains though, bad actors may lie about radio packets. Virtually all POC gaming strategies revolve around 
intercepting or entirely fabricating packets over the [Semtech GWMP Protocol over UDP](https://github.com/Lora-net/packet_forwarder/blob/master/PROTOCOL.TXT). 

![image GWMP Miner](0022-diy-concentrators/miner_packet_forwarder.jpg)

It is not difficult to put software between the packet forwarder and the Helium Miner to manipulated packets, 
[as demonstrated by community member, Carniverous19/para1](https://github.com/Carniverous19/helium-DIY-middleman).

# Physical Root of Trust
[physical-root-of-trust-value-and-incentives]: #physical-root-of-trust-value-and-incentives

We propose to create a special category of packet forwarders which cannot lie about what they physically perceive. As 
such, they provide the network with a **Physical Root of Trust**. They can still be "gamed" in various ways which will 
be detailed here, but these attack vectors all end up existing at the physical RF level instead of simply intercepting 
or fabricating UDP packets.

## Enabling DIY

Currently, every single gateway design must pass through [HIP19](0019-third-party-manufacturers.md). However, DIY
concentrators go above and beyond the security requirements detailed in HIP19. Therefore, we propose that any gateway
build that features a DIY concentrator be allowed on-chain.

## Higher Rewards

While they're role may grow and change as we gain confidence in their trustworthiness and as the network evolves, we 
propose their novel hardware design and inherent trustworthiness should entitle them to a 2x multiple 
[to normal beaconing reward units](./0015-beaconing-rewards.md). In terms of POC and incentives, these are provably
more honest witnesses, therefore, they should be rewarded more.

Incentivizing the usage of these modules is important, because the security requirements around this design will
increase the cost of manufacturing, which will then be passed onto the coverage provider. In addition, such a multiple
may encourage HIP19 approved vendors to migrate to these concentrator designs, as we hope coverage providers will 
generally prefer a slightly more expensive module that earns a witnessing bonus.

## Other POC Gaming Approaches

We believe this approach to be complementary to many other approaches to improving POC. What is unique about it is its 
scalability:
* even existing gateways could be retrofitted to have these trusted DIY concentrators
* after installation, these trusted DIY concentrators do not require human intervention

Moreover, while the blockchain and incentive impact is modest at this point, we believe this initial approach provides
extensibility: 
* actors capable of mobile auditing could be derived from the hardware
* more complex "trust score" and anti-gaming approaches could derive itself from this data (eg: GPS timestamping)

# Product Summary
[product-summary]: #product-summary

Almost every gateway on the network is currently compatible with the RAK2287.

![image RAK2287](0022-diy-concentrators/rak2287.png)

These "concentrator cards" are effectively one of Semtech's SX130x front-end and optional GPS. Over SPI and I2C, they
communicate back to the main processor, such as a Raspberry Pi. Should this HIP pass, a "DIY concentrator" will be
available for purchase.

Should existing gateway vendors provide software support, they could adopt these radio front-ends, either after-market 
or in future products. While SyncroB.it initially proposes this design, other vendors who provide similarly secured
concentrators could also enable "DIY Gateways."

# Hardware and Firmware Summary
[hardware-and-firmware-summary]: #hardware-and-firmware-summary

The Semtech GWMP Protocol over UDP communicates raw LoRa radio packets, which today become 
[Witness Receipts](https://github.com/helium/proto/blob/master/src/blockchain_txn_poc_receipts_v1.proto#L22).
The core of our problem is that all of those fields (RSSI, SNIR, GPS timestamps) may be lied about at the software 
layer.

The core of the proposal is to have a secure element, such as the MAX32510 run the packet forwarder application and sign
the packets on-chip.

![image Secure Concentrator](0022-diy-concentrators/concentrator.jpg)

The MAX32510 can provide a guarantee that the firmware on-board is unchanged. Along with a secure key-store, you can
guarantee that it only signs what you programmed the firmware to sign.

The main attack vector would be tampering with the SX130x and GPS modules either directly on-board or over RF. Additional
anti-tamper mechanisms may be deployed to reduce ease of tampering. In coordination with DeWi, the final design may 
feature the following such protections:
* existing tamper proof features on the MAX32510
* firmware on the MAX32510 could detect PCB modifications
* an out of band check by the concentrator on the antenna port, ensuring that the stock antenna is deployed

Although SyncroB.it is currently the only vendor proposing such a design, their design and security will be audited by 
DeWi.

A critical detail to the security model is that the firmware initially loaded is, in fact, the audited firmware. From that
point onwards, after leaving custody of the party entrusted with loading the secured firmware, the security keys inside
cannot be compelled to sign anything that the firmware has not requested. Thanks for a secure firmware update process
built into the chip, updates may even be safely delivered as their origin is verified by the chip.

While we do not propose initial designing around this, it is worth noting that fine GPS timestamping on these front-ends
might eventually provide a powerful tool for RF auditing.

Due to the signature from the packet forwarder, either an alternative protocol will need to be developed or an additional
field must be provided with a signature to the 
[POC witness receipts](https://github.com/helium/proto/blob/master/src/blockchain_txn_poc_receipts_v1.proto#L22).


# Unresolved Questions
[unresolved]: #unresolved-questions

**Chain Variables**: Why a multiple of 2?

**Incentives**: Are there better ways we can incentivize operators of DIY concentrators other than a simple multiple?

# Deployment Impact
[deployment-impact]: #deployment-impact

The HIP19 process is fairly involved and requires case-by-case handling of each vendor. While this HIP initially enables
DIY gateways (therefore enabling hobbyists to source modules and build custom gateways), we believe its possible that 
all future designs from large-scale vendors could comply with HIP22 and thus bypass HIP19. This would provide a higher
degree of trust in witness receipts from gateways while also reducing the overhead of the HIP19 process.

# Success Metrics
[success-metrics]: #success-metrics

If this HIP is successful, we will have higher confidence that POC rewards are going to legitimate operators, starting
with operators of DIY concentrators who are now rewarded the multiple on witnessing. As mentioned previously, the 
scalability and extensibility of the approach should lead to further developments in anti-gaming strategies.