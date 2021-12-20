## YOUR NAME
Erickwok
Application to become an approved third party manufacturer as per HIP19.
## Summary
Taiwan Shengwei Electronic Technology Co., Ltd. was established in 2013 by two former Qualcomm and CSR communications engineers. It has been in development for 8 years. We have so far manufactured for TP-link, D-link, NETGEAR, Jabra, Vodafone Australia and Softbank of Japan, dozens of WiFi routers and several Bluetooth headsets, For Helium product, we will create a new website and brand to sell. 

## Company Information (required)
* What is your company name? Taiwan ShengWei Electronics Technology Company. 
* How long have you been in business? Taiwan Shengwei Electronic Technology Co., Ltd. was established in 2013 by two former Qualcomm and CSR communications engineers. It has been in development for 8 years. 
* What kind of products have you created? We have so far manufactured for D-link, NETGEAR, Jabra, Vodafone Australia and Softbank of Japan, dozens of WiFi routers and several Bluetooth headsets, including 802.11N, WiFi-MIMO, 5Gwi-fi, Wi-fi6 and other wireless routers and Bluetooth5.0 A2DP, Bluetooth5.0 BLE and other series of Bluetooth headsets. 
* How many have you sold? We have accumulated and manufactured more than 400,000 OEM devices for customers.
* What brought you to Helium etc? We went to China to participate in the exhibition, and a partner came over and asked if we could provide helium mining machines.

## Product Information (required)
* What is this product's model name or model number? Redsuns-HNT1
* Is this is Light Hotspot or Full Hotspot? (please submit two separate applications for Full and Light hotspots)  This is full hotspot.
* Is it for indoor or outdoor? It is for indoor.
* Provide a brief description of what you're making. We use RaspBerry Pi4B as the calculation and control module of the mining machine. We use chipmatrix M302 (sx1302 inside) as lora's communication gateway.（CN470、EU868、US915） At present, we have successfully completed the steps of connecting the Raspberry Pi to the lora gateway, but I did not find the HNT code, nor can I upgrade the Raspberry Pi and Lora gateway modules to Helium Mining.  

## What is your approximate price point? (required) We recommend that the retail price be in the range of US$700

## Please provide detailed hardware designs, including relevant parts (required)
Evidence of a functioning prototype - photos, videos. Renderings are OK but physical prototypes are much, much better. Your plan for software setup and configuration for the devices. This would includes remote updates and the ability for hosts to change wifi settings, via Helium's official app or otherwise. 
Raspberry Pi 4B with Debian Buster OS

SemTech sx1302
![image](https://user-images.githubusercontent.com/76428978/145804760-448ca9a6-1fdf-4c44-ae8b-8aff31b95cd4.png)


Assembly
![image](https://user-images.githubusercontent.com/76428978/145804722-59f82982-ec52-479e-af4f-0dbe1c7c9f00.png)


Adaptor
![image](https://user-images.githubusercontent.com/76428978/145804838-2fef2249-8c31-4bdd-a373-bf2a10b3e854.png)


According the setting of LPIOT-302(CN470) gateway, we could have the LoRa Gateway product.
![image](https://user-images.githubusercontent.com/76428978/145804884-875de2ad-2de8-4b0d-8aba-26eb112cfeaf.png)
![image](https://user-images.githubusercontent.com/76428978/145804916-9a71ca63-5b87-447f-8d83-c01c72cea85b.png)
![image](https://user-images.githubusercontent.com/76428978/145804952-5008e154-6786-4b3a-b86e-5e3e90908a06.png)


And next step would be HNT miner setting.



## What is your expected production and delivery timeline? (required)
Hardware prototype:11/20/2021
Software development: 12/30/2021
Radio Frequency certification: 1/30/2022
Helium Certification: 2/30/2022
First batch product delivery: 3/10/2022
## Previous shipments (required)

## Startups welcome! 
* Have you shipped anything in the past? Yes or No  Yes We have shipped WIFI routers, including AC-3, AC-3B, AC-4, AC-5, AC-1200, AC-1600, Bluetooth headset BTHS-470, BTHS-6023, BTHS-6023-F, BTH -400 etc.
* Which countries have you previously shipped regulatory FCC or CE approved products? Because we are an OEM manufacturer, we have applied for our foundry customers, including FCC, CE, SIG, MIC, NCC, EMC and other certifications.
* Which countries do you plan to ship to? North America, Japan, Australia and China

## Customer Support (required)
* How will your customers be able to contact you for support for your products? Client will be able to reach us through telephone, online store chat, email, and discord. 
* For how long? How are you planning to handle repairs and replacements? We plan to provide 1 year warranty to our product. We will stock products in US, Australia and Japan for replacement. Products will be repaired in Taiwan


## Hardware Security Element (required)
* The community is concerned about devices that can be easily hacked, specifically by copying their swarm_key files. Applications should include plan for how the devices will be secured, potentially including:  Yes, We will encrypt firmware

* Are you using an ECC608. Yes or no? For this generation of products, we have not added the ECC608 security module, we can add the ECC608 security module to the second generation of products.
* Encrypted/locked-down firmware. Yes or no? Yes, We will encrypt firmware
* Encrypted storage of the miner swarm_key, either via disk encryption or hardware measures. Yes or No? Yes, We will encrypt storage of miner swarm_key through disk encryption
* Encrypted buses, potting and other anti-tampering measures. Yes or No?  Yes, We will encrypt buses, potting and other anti-tampering measures.
* Willingness to submit a prototype for audit, and sharing those audit results publicly (pass or fail) Yes or No?  Yes, we are willing to submit a prototype for audit and share results publicly.

## Hardware Information (required)
* Please let us know:
1.Main control module, RaspBerry Pi4B
2.Lora Gateway is SX1302
* Which security (swarm) element are you using?  Encrypt Firmware
* Which LoRa chipset are you planning to use in your gateway (ie SX1302/03 & SX1250s or SX1301/08 & SX1255/57) We recommend you don't use the SX1301 in new designs. The Lora chipset of our device is Semtech SX1302
* Where are you sourcing your components from? We can purchase equipment in Taipei and Chengdu
* How many radio modules/ concentrators can you procure? We can buy 3000 sets

## Manufacturing Information (required)
* Have you built and delivered radio hardware products before? Yes, we have manufactured and delivered WiFi routers and Bluetooth headsets
* Have you built gateways before? Yes, we have established a WIFI gateway. And the two founders of our company are from Taiwan Qualcomm and CSR. We have rich manufacturing experience in WiFi and Bluetooth wireless communications.
* How many gateways did you make? We have made WiFi-AC, WiFi-AG, WIFI-5G, 3 gateway products.
* If you have not built gateways before, are you using a third party manufacturer? This is the single largest risk with most hardware ventures. If possible please provide information about your manufacturing partners and supply chain. We do not need third-party manufacturers. We have manufacturing capabilities and have our own manufacturing plants in Xizhi, Taipei and Dongguan, China. Therefore, we have no third-party R&D or foundry risks.

## Proof of Identity
Per typical KYC/AML procedures, proof of identity for major shareholders (25%+ ownership) will be expected to be provided privately to representatives from Helium Inc or DeWi board members. This will be attested and publicly confirmed by those representatives, e.g. as GitHub comments.
Contact details for this will be provided after your application is submitted on GitHub. 
Taiwan ShengWei Electronics Technology Company is100% owned by Yanming Kwok and xiaogang Xie Contact Info: +0086-0980678300 Email:Eroskwok@gmail.com Add:Block A, 9th Floor, No. 273, Section 4, Xingyi Road, Da'an District, Taipei City.

## Budget & Capital (required)
* How many of these are you hoping to make and sell? We estimate that the first batch of 2,100 units will be manufactured, of which 2,000 will be sold, 100 of which will be used as maintenance spare parts, and 10,000 units will be sold throughout the year in 2022.
* How much money will be required up-front? How much money do you have on-hand, and how much do you have access to?  We have allocated US$50,000 for preliminary design and development, manufacturing testing of engineering samples, and related certifications. In the future, we will invest 400,000 U.S. dollars for the production and manufacturing of encrypted mining machines and market operations.
* What is your plan for additional financing if required? This is the second biggest risk in new hardware ventures - getting almost over the line and then running out of cash. We are a small R&D and manufacturing company specializing in the field of wireless communications, and have been serving several major OEM fixed partners for many years. So far, we have stable customers and healthy financial status. We will independently operate the HNT project. We use the initial capital of the project as the early angel investment of the project, and in the later stage, we can obtain financial support through VC or market fundraising. Of course, I also hope to get official funding and technical support from Helium.

## Risks & Challenges (required)
Please tell us about some of the challenges that would prevent these products from becoming a reality and how you might address them.  We believe that excellent supply chain integration and excellent product experience are the core elements for products to be favored. We have many years of experience in manufacturing WiFi and Bluetooth wireless devices, which can help us better improve HNT devices, and we can get first-hand chips in Taiwan. So we are confident that we can run this project well.

## Other information (required) if you do not provide contact information we cannot review your proposal.
* Contact info (* required) Eric Kwok +0086-0980678300 Eroskwok@gmail.com
* Twitter profile -
* Facebook profile -
* Discord -Erickwok#6817
* Website -

## Payment methods available  Crypto, credit card, paypal, check, wire

## Which countries do you plan to ship to and get regulatory certifications for? (required) North America, Australia, Japan and China
