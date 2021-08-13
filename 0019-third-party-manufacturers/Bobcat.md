# Bobcat (Easylinkin)

### HIP19 amendments for alternate security implementations

## Summary

[Easylinkin](www.easylinkin.net) is an Wide Area IoT solution provider with core competency in LoRaWAN Gateway Manufacturing and Module Design. 

We are currently one of the biggest manufaturers for Helium Hotspot Miner and provide gateway prototype for Helium Light Gateway.

In this HIP19 Amendments we propose an alternative security chip for ATECC608.

## Company Information

**EasyLinkin Technology Co., Ltd.** is a high-tech enterprise that specializes in the R&D and applications of LPWAN technologies. Leading a team of creative, technology-savvy professionals with in-depth domain knowledge in the IoT industries, we have designed and manufactured stable, multi-functional LoraWAN gateways for both indoor and outdoor usage, and more than 70 sensor models in 30 different categories. 

Since our foundation in 2015, we have sold many hundreds of thousands of our products via direct and indirect channels worldwide, including US, EU, Indonesian, Africa and have collaboration with Semtech, Alibaba, Huaxu, Radaking. We believe in time-to-market without compromising to quality and future expandability.

Further to expand company organization, EasyLinkin had finished C round capital investment by end of 2019 from IDG, total fund raised US$85M.

**Product & Services:** LoRa Gateway, NS platform, LoRa Modules and IoT Ecosystem

**Applications:** Water/Electricity/Gas Metering, Public Security, Smart City, Environmental Monitoring, Agricultural and Rural IoT, industry Automation/Control

**Member of LoRa Alliance since Y2016**

**Member of ICA (IoT Connectivity Alliance LoRa Standard committee)**

## Product Information

We provide two stable and compact gateway solutions.

* Bobcat Miner 300 for Helium Hotspot Miner, Black Box, Retail Price: $429.00
* G200 for Helium Light Gateway, White Box, Estimated Price: $119.99

**Bobcat Miner 300 Features:** 

* Concentrator based on the Semtech SX1308/SX1302 with ADR
* Quad-core Cortex-A35 CPU with 64G eMMC Flash and 1G/2G DDR2 RAM
* ATECC608 for swarm keys storage
* Wi-Fi: BCM4339 IEEE802.11a/b/g/n/ac double frequency, Ethernet Connectivity
* Bluetooth: BT V4.1 EDR, GPS: BDS B1+GPS L1
* Frequency band: 470MHz/868MHz/915MHz/923MHz and other
* Coverage radius: 3km in city, 5km in rural area
* Voltage DC 12V 
* Comes in IP30 case, size: 142 * 142 * 35mm

**Helium Light Gateway Features:**

* Concentrator based on the Semtech SX1308 with ADR
* MIPS 650MHz with 16MB Flash and 128MB RAM
* RJGT102WDP8 encryption chip for swarm keys storage
* Wi-Fi: QCA9513, 4G/Ethernet Connectivity
* Support Bluetooth and GPS
* Frequency band: 470MHz/868MHz/915MHz/923MHz and other
* Voltage DC 12V (11.0 VDC ~ 14.0 VDC)
* Comes in IP30 case, size: 142 * 142 * 35mm

## Customer Support ##

Bobcat can provide customer support via:

* Discord’s Vendor channel
* 7 * 24 hours customer enquiry
* FAQ section for customer to search the answers of their issues.
* The hardware maintenance service will be one year free for labor cost, provided hardware replacement if the breakdown of hardware comes from itself.
* The software issues could be solved by SSH remote access or OTA upgrade.

## Hardware Security Amendment ##

Currently we use ATECC608 encryption chip for swarm key storage, we now propose an alternative encryption implementation DX83E08 from [Shanghai Dongxin Microelectronics](http://www.chipsec.com/), which has equivalent ecryption capabilities. Here is the [Datasheet](./DX83E08.pdf).

DX83E08 supports the following Algorithm:

* Asymmetric Algorithm:
  * ECC-GF(P256): ECDSA Signature, ECDH(E) Key agreement, support curve Secp256r1 and Secp256k1
  * SM2: SM2 Signature and Key Agreement
* Symmetric Algorithm:
  * AES: 128/192/256 bits key length, support ECB/CBC/OFB/CFB/CTR cipher mode
  * SM4: 256 bits key length, support ECB/CBC/OFB/CFB/CTR cipher mode
* Hash Algorithm:
  * SHA256/HMAC-SHA256
  * SM3/HMAC-SM3
* Key Derive Function:
  * HKDF-SHA256
  * HKDF-SM3

Every key of DX83E08 has unique KID, and key is accessed according to KID. Keys can be directly imported or generated into key’s KID storage space using designed API. Below is the KID definition:

| **Key Type**      | **KID**   | **Groups** | **Flash or RAM** | **Status** | **Length** | **Remark**                                                   |
| ----------------- | --------- | ---------- | ---------------- | ---------- | ---------- | ------------------------------------------------------------ |
| PIN               | 0x10      | 1          | Flash            | One Time   | 32         | After verifying PIN successfully, DX83 opens the access right, and generate I2C bus session key |
| Server Public Key | 0x20-0x23 | 4          | Flash            | One Time   | 64         | Sever fix public key                                         |
| Server Public Key | 0x24      | 1          | RAM              | Dynamic    | 64         | Sever temporary public key                                   |
| Device Key Pair   | 0x30-0x37 | 8          | Flash            | One Time   | 96         | Device fix Asymmetric Key Pair                               |
| Device Key Pair   | 0x38-0x39 | 2          | RAM              | Dynamic    | 96         | Device temporary symmetric Key Pair                          |
| Symmetric Key     | 0x40-0x47 | 8          | Flash            | One Time   | 32         | Device fix symmetric Key                                     |
| Symmetric Key     | 0x48      | 1          | RAM              | Dynamic    | 32         | Device temporary symmetric Key                               |
| Zone Key          | 0x50-0x57 | 8          | Flash            | One Time   | 32         | Every User Zone has own Zone Key, only after verifying the zone successfully, you can write or read the zone data, and I2C bus dynamic encrypts the access data. |

Keys can never read from DX83E08 directly, and the keys stored in Flash are One Time Programming Locked. When importing key into key’s KID storage, you must verify PIN successfully first, and I2C bus is dynamic encryption, so you cannot get the plaintext through I2C detection by oscilloscope. All DX83E08 keys’ physical Flash storage are address scrambled and data encrypted according to every chip’s SN. The same logic address/data stored on every DX83E08 have different physical address and physical data. Even you can steal the physical Flash code, but you cannot reverse the real plaintext. Also, DX83E08 chip has the extra shield layer on the top metal, which can protect FIB or other physical attacking. Samples have been sent to Dewi for audit.

## Manufacturing Information ##

We have long-standing business cooperation with a number of trusted manufacturing partners and have successfully delivered multiple major projects in the past 5 years including Alibaba LoRaWAN City Coverage for Hangzhou, 300Ku LoRaWAN Water Meter projects in China and 30Ku LoRaWAN Electricity Meter Projects for Indonesia. We will continue using these manufacturers for producing Helium Hotspot Miner and Helium Light Gateway.

## Proof of Identity

Separately submitted to DeWi.

## Budget & Capital

Based on the current estimate and market insight, Bobcat intends to produce 20Ku per month in 2021 and allows production flexibility as customer demand requires.

Due to the necessity of components readiness for manufacturing gateway products, Bobcat should balance cash flow and reserve a minimum US$1M as the budget for supply chain. 

## Risks & Challenges

Since our factories are all in mainland China, there may be possible delay in transportation and maintenance of our products. We are planning to establish cooperation with international courier service should the proposal goes well.

Another thing to concern is the scale of our customer service with the growth of the network. More resource will be deployed.

## Other information

* Discord channel - [Official Bobcat Miner Comuunity](https://discord.gg/BuWna9Px54)
* Website – [www.bobcatminer.com](https://www.bobcatminer.com/)
