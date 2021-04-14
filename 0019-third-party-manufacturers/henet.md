# HeNet B.V. / LongAP
### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)

## Summary
HeNet B.V. is a new subsidiary of Velorum B.V., a company from the Netherlands that specializes in security solutions with the main focus on cryptography.
We have developed the **LongAP One** Helium Gateway.
**LongAP One** is based on commonly and readily available components that have been used for years at large scale in various appliances. 

## Company Information

Velorum B.V. is founded by @timcooijmans and @bas-vk in 2018. HeNet B.V. is a newly founded subsidiary for building our **LongAP One** Helium Gateway. 
With Velorum B.V. we primarily focus on building solutions and helping corporates in the area of security, cryptography, and blockchain. @timcooijmans has 
been developing hardware and software-based crypto-solutions for over 10 years and @bas-vk has previously worked on the Ethereum blockchain at EthDev. 
We have done projects where we had 100s of devices in the field managed by us and operated over our own MVNO mobile network. 

## Product Information
### LongAP One
**Status**: Ready to start production, CE testing passed.

**Expected release date**: Q2-Q3 2021

**Estimated price**: 600 EUR.

We have developed Helium Gateway around an industry-grade reliable platform that has been used in many routers and other solutions for over 5 years. 
It's fully based on x64-hardware with reliable products such as Intel-interface-chips and MLC SSD storage. 

**Specs**:
- AMD GX-412TC 1.0 GHz x64 Quad-core
- 2 GB of DDR3 RAM
- 30GB of MLC SSD storage
- Intel i210/211AT LAN interfaces (LAN/WAN and management)
- Intel 7260 WiFi b/g/n/ac + Bluetooth interface
- SX1301/SX1308 LoRa concentrator
- +3dBi LoRa antenna
- ATEC608A security-chip for hardware-bound key storage and operations. 
- 3 LEDs for connectivity-status indication
- Button for entering/leaving setup-mode and full-reset
- 12V DC-plug adapter
- 5-10W power-consumption
- Fully metal case
- CE declaration of conformity available

### LongAP Pro
**Status**: Ongoing development

**Expected release date**: Q3-Q4 2021 (after gateway-rs is ready)

**Estimated price**: TBD. 

LongAP Pro will be a light-gateway in an outdoor IP65 housing ready to be installed in the harshest conditions.

**Specs**:
- 800 MHz Dual-Core MIPS processor
- 256 MB of RAM
- Gigabit ethernet with PoE
- LoRa concentrator (EU868 and US912 initially)
- Fiberglass +3dBi LoRa Antenna with N-type connector
- Fully metal case (pole and wall mount supported)
- Powered over PoE

Option LTE:
- 4G/LTE Cat 1 interface
- 2 Fiberglass LTE antennas with N-type connector
- World-wide SIM with data installed that can be enabled in our dashboard

Option WiFi:
- WiFi interface
- 2 WiFi antennas with N-type connector

Option Solar:
- Kit to run LongAP Pro on solar and batteries. 

## Customer Support

Support will be provided over e-mail and Discord and general troubleshooting will be available on our website. We aim 
to respond to questions within 1 business-day.

On our website we will provide clear information on the production status of our product, and the batches to be expected. The ordering process for our first product will collect payment-details 
during pre-ordering, but we will only charge the payment-method just before we ship out the devices. We will limit pre-orders based on the batches
we have planned. 

Full product warranty will be provided on **LongAP One** and **LongAP Pro** for 2 years for customers and 1 year for businesses. 

## Hotspot Fleet Management

We are using an internal update-management-system based on Puppet that we use for all our devices. It allows us to push 
updates (and rollbacks) over-the-air for all our components securely. Additionally, we have a pro-active
monitoring system to monitor the devices and to allow us to troubleshoot remotely if agreed by the owner. 

## Hardware Security

Our devices contain an ATEC608A security-chip for key-storage and cryptographic operations.
Keys are non-exportable ensuring a high level of security.
We are happy to provide a **LongAP One** and **LongAP Pro** for audit and answer questions. 

## Manufacturing Information

**LongAP One** and **LongAP Pro** are based on readily available components we have been using for several years with great success when it comes to reliability and stability.

Together with our suppliers we are planning to provide a combined volume (LongAP One and LongAP Pro) of 10.000+ units this year.

## Proof of Identity

Submitted and verified by DeWi.

## Budget & Capital

We have enough funds available to produce large volumes. This is eased by the fact that we don't have to manufacture a custom hardware platform. 

## Risks & Challenges

We have identified a number of risks and challenges:
- The readily available components come from different manufacturers causing potential supply-chain challenges
- While we have experience producing and shipping devices, **LongAP One** may require us to scale-up to meet demand. 
- We are used to building and developing solutions for corporates and professionals, selling directly to consumers, and giving support to consumers of different skill level is new to us. 

## Other information

Please note HeNet B.V. has just been founded and many of the following items are in progress.

* Desired Discord support channel name - #longap (to be created)
* Twitter profile - [@LongAPcom](https://twitter.com/longapcom) 
* Website - [longap.com](https://longap.com) (in progress)
* Payment methods available - All generally accepted payment methods (local European schemes, credit-card), cryptocurrencies and looking into accepting HNT.
* Regions covered / shipped - We initially focus on the European market
