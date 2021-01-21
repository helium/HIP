# SyncroB.it (Launch Pad LLC)
### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)

## Summary

SyncroB.it is a new venture specifically modulated around the Helium ecosystem. While this is a new venture the people behind it have vast experience in manufacturing and do have part ownership of the factory producing these devices. And have produced secure/encrypted hardware in the financial sector. (POS, ATM hardware)

We are proposing a new breed of secure Hotspots (indoor, outdoor, light-gateways)

## Company Information

While SyncroB.it is a new venture, the company behind it Launch Pad LLC has been in business since 2013. We have created numerous products mostly in the Financial sector.

Helium is a bold take on IoT and blockchain/crypto, we see the potential and value of Helium. In our opinion Helium is the first blockchain trying to solve something that is a real struggle.

## Product Information

We are building a new breed of gateways that are more attractive and more compact.
* Our 1st product being a regular “vanila” gateway. ($300-$350)
* 2nd product is a secure anti-temper gateway (anchor gateway) ($500-$550)
* 3rd product is a light gateway. (WIP) ($50-$60)

**Features of the first 2 products include:**
* Concentrator based on the Semtech SX1302/SX1303 (applicable for “vanilla”)
* Anti-tamper/encrypted concentrator based on Semtech SX1302/SX1303 (anchor gateway)
* Raspberry PI Compute Module 4 (32 GB Storage, 2GB RAM)   
* Motherboard can be swapped between 2 cases (indoor and outdoor)
* Built-in heatsink for better temperature management
* Voltage support from 12 - 70 volt
* Support for PoE+ (802.3at) PD
* Local Web dashboard for easy diagnostics and reporting
* Remote Management console
* Different methods of onboarding (BLE, local web onboarding, remote onboarding, or link onboarding eg https://syncrob.it/setup)
* Automatic self diagnostic and repair.
* Graceful shutdown in case of power failure (prevents corruption of EEMC) 

**Light Gateway features:**
* Concentrator based on the Semtech SX1302/SX1303 
* Voltage support from 12 - 70 volt
* Support for PoE+ (802.3at) PD
* Remote Management console
* Minimal configuration

* Our software is custom and will include OTA updates for the lifetime of the device, encompassing useful features in addition to the original features.

* We are able to produce 10,000 units a week. Our first batch will be scheduled for delivery by the end of Jan 2021.

## Customer Support

Customer support will be handled via Discord, email and via our dashboard. We plan on providing support and updates for the lifetime of the product. 

Repairs/Replacements will be handled domestically:
* If the device is defective due to our manufacturing process or shipping/mishandeling on our part we will immediately ship a replacement out.
* If the device/one of modules is defective due to user mishandeling/error we will provide repair or ship-out a replacement part for a price. This includes case, concentrator, raspberry pi, motherboard, charger, antenna.  

## Hardware Security

We are providing our own custom firmware and hardware, in terms of security we implement the following methods:

**Encrypted/locked-down firmware**
Firmware is locked down to the hardware and will not boot on different hardware, root user cannot be reset easily. Unauthorized USB devices are not permitted 

**Encrypted storage of the miner swarm_key, via disk encryption.** 
Swarm key will be encrypted in such a way that the key changes at a random time interval and the encryption is actually scattered in different sectors of storage only the decryption module knowing where and how to decrypt. 

**Encrypted buses, potting and other anti-tampering measures.**
In addition to encryption, a few other measures have been implemented that prevent the RPI from booting and even the EMMC cannot be read as a Mass-storage device.
The golden gateway features encryption on the concentrator itself.

Samples can be provided to DeWi and/or Helium and be submitted to any tests.

## Manufacturing Information

Since we do own part of the factory manufacturing our products we have manufactured and supervised manufacturing for various products, and ensured the highest quality product.  


## Proof of Identity

Submitted privately to DeWi.


## Budget & Capital

We intend to produce 20,000 units as our 1st batch, and there after 10,000 each week in order to keep up with the current demand. We have secured all the capital needed in order to bring the first batch to market. By owning part of the factory production delays due to lack of capital will not be an issue.  


## Risks & Challenges

The biggest challenge that we see is the production of SX1302/SX1303, and the availability of raspberry Pi’s. 

We think that with good management these issues are not going to pose a problem and not cause delays. We intend to order/manufacture 30% more than we actually need in order to satisfy repairs and not hinder future production.  

## Other information

* Desired Discord support channel name - #SyncroB.it or SyncroBit
* Website - https://syncrob.it
* Payment methods available - All major credit cards accepted, crypto and HNT soon
* Regions covered / shipped to - USA for now and EU after the 1st batch

