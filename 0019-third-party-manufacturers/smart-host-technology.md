# Manufacturer name
### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)

## Summary

Two sentences about who you are and what you’d like to build. Indicate if you are building a Light Gateway, or a Full Gateway. Bonus points to include photos and links. 

## Company Information (required)

* What is your company name? 
 **SMART HOST TEKNOLOJİ İTHALAT İHRACAT LIMITED ŞİRKETİ**
* How long have you been in business? 
**from 2016**
* What kind of products have you created? 
**internet provider and web host provider**
* How many have you sold? 
**above 20K customers**
* What brought you to Helium etc?
**The ability to expand and become more advanced is what brought us to Helium Gateway.**

## Product Information (required)

Your time to shine! What are you building? What’s so great about it? 
* What is your approximate price point? 
**450-650$**
* Detailed hardware designs, including relevant parts
 ##################
**1.5 GHz quad core ARM Cortex-A72 CPU
2GB LPDDR4 RAM
64GB of MLC SSD storage
Gigabit Ethernet
Bluetooth 5.0, BLE
2.4GHz / 5.0GHz IEEE 802.11.b/g/n/ac wireless
Frequency band: 868MHz/915MHz/923MHz
Coverage radius: 3km in city, 7km in rural area
+3dBi LoRa antenna
Software security.
5V/2.5A DC-plug adapter
8-channels WAN modem**
########################
* Evidence of a functioning prototype - photos, videos. Renderings are OK but physical prototypes are much, much better.
* Your plan for software setup and configuration for the devices. This would presumably include remote updates and the ability  for hosts to change wifi settings, via Helium's official app or otherwise.
**There will be a vpn server that all devices will connect to and receive updates via ota**
* What is your expected production and delivery timeline?
**At the beginning of August**
Photos and videos welcome.

## Previous shipments (required)

Startups welcome! Answer No if that's the answer.
* Have you shipped anything in the past?
**yes WIFI routers**
* Which countries have you previously shipped regulatory FCC or CE approved products? 
**CE**
* Which countries do you plan to ship to? 
**worldwide**

## Customer Support (required)

* How will your customers be able to contact you for support for your products?
**Email and our website. We plan on providing support and updates for the lifetime of the product.**
* For how long? How are you planning to handle repairs and replacements?
**If the device is defective due to our manufacturing process or shipping/mishandeling on our part we will immediately ship a replacement out.
If the device/one of modules is defective due to user mishandeling/error we will provide repair or ship-out a replacement part for a price.
This includes case, concentrator, raspberry pi, motherboard, charger, antenna.**

## Hardware Security Element (required)

**Hotspot via VPN will connect to our servers to be able to access swarm_key. Comes encrypted with decryption key. The decryption key can only be accessed by the device because the key will be a combination of the processor ID number in the device with some random words The key can only be known by the VPN server and the key will be changed constantly because it can only be accessed once The VPN server can only be connected through the hotspot because the caller can only be identified if they have a MAC address, processor ID and password that will be changed every time the hotspot connects to the VPN server The programming of the metal will be modified to comply with the above so that the encryption key is provided through some files that we will include in the device in an encrypted form also so that no one can know the algorithm used in the encryption and decryption

If a hotspot performs a suspicious action, an unauthorized or suspicious connection attempt, subsequent attempts will be automatically blocked and the team will be alerted to review the process and monitor what is happening And if there is any error or malfunction, the team can address it remotely If we find out that there is an attempt to hack or tamper, it will be banned immediately

swarm_key will not be saved in hotspot on memory card or RAM

Some code files will be added encrypted in the metal that I can share via e-mail to the helium team in unencrypted formats to see the working method followed**

## Hardware Information (required)

Please let us know:
* Which security (swarm) element are you using? **software**
* Which LoRa chipset are you planning to use in your gateway (ie SX1302/03 & SX1250s or SX1301/08 & SX1255/57)
**SX1302,SX1303,SX1308**
* We recommend you don't use the SX1301 in new designs
* Where are you sourcing your components from?
**Semtech**
* How many radio modules/ concentrators can you procure?
**15000 per month**

## Manufacturing Information (required)

* Have you built and delivered radio hardware products before? **yes**
* Have you built gateways before? **yes**
* How many gateways did you make? **100 for test**
* If you have not built gateways before, are you using a third party manufacturer? **no**
This is the single largest risk with most hardware ventures. If possible please provide information about your manufacturing partners and supply chain.

## Proof of Identity

Per typical KYC/AML procedures, proof of identity for major shareholders (25%+ ownership) will be expected to be provided privately to representatives from Helium Inc or DeWi board members. This will be attested and publicly confirmed by those representatives, e.g. as GitHub comments. 
* Contact details for this will be provided after your application is submitted on GitHub.

## Budget & Capital (required)

* How many of these are you hoping to make and sell? **100K**
* How much money will be required up-front? How much money do you have on-hand, and how much do you have access to? What is your plan for additional financing if required? This is the second biggest risk in new hardware ventures -- getting almost over the line and then running out of cash.
**The budget and production quantity are linked to market supply and demand and we are ready to finance all market requirements and we have the ability to finance any quantity demanded by the market and meet new markets**

## Risks & Challenges (required)

Please tell us about some of the challenges that would prevent these products from becoming a reality, and how you might address them.

## Other information (required)
 
**Website - https://smart-host.com.tr
Contact info - Email : info@smart-host.com.tr
Payment methods available - CRYPTOCURRENCY - TURKEY LOCAL BANKS - CREDIT CARDS
Regions covered / shipped to - worldwide**
