# Innodev
### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)
 
 
## Summary
 
 
Innodev is an electronic design and embedded software development company. It was founded in 2004, with large experience in M2M/IoT hardware design and software development.
Our proposal is to build a Helium Full Gateway, specially designed for outdoor usage.
 
 
 
 
## Company Information
 
* What is your company name? 
 
Our company name is Innodev SRL
 
* How long have you been in business? 
 
Innodev has been in business since 2004
 
* What kind of products have you created? 
 
Innodev has created Zigbee gateways, Ethernet and GSM gateways and different end devices.
 
* How many have you sold? 
 
Innodev has sold around 2000+ devices.
 
* What brought you to Helium etc?
 
We believe that Helium, as a global telecommunication carrier, offers an amazing market opportunity for all IoT manufacturers by simplifying the access to clients to global coverage. The technology chosen, LoRa, can achieve today what NB-IoT has as target in the next 10 years: low cost device, years long battery life, global coverage.
 
 
Below are more details regarding our answers.
 
 
Innodev SRL is a design company for embedded electronics devices that includes Zigbee, 3G/4G, BLE, PLC, VDSL modems, industrial control and monitoring devices etc. but also experience in engineering management for large scale projects.
 
 
The company was established in 2004, having more than 17 years of experience on market, developing solutions and consultancy contractors for various companies, including hardware, software and telecoms with in the following domains:
 
 
* Smart-metering using ZigBee, Ethernet, GSM
* BLE indoor tracking
* GPS/GSM tracking
* PLC and other industrial equipment design
* IoT – Blockchain integration
* SCADA software development 
* Defense communications and surveillance - 12+ years experience system level design and engineering
* Pre-Silicon verification ( SystemVerilog/e language) - + 10 years experience
* Data and voice communication - 10+ for IP/MPLS carrier grade network design
* Engineering management 
* Integration Verification and Validation - more that 10 years experience for defence and medical projects
 
 
We are focused on custom embedded solution design. Production was made only on small batches, but we have experience with PCB production, working with various partners for the factoring and component supply. The electronic design is fully made “in house” including schematic, PCB design, prototyping, testing, firmware development and other centralized software services (servers, APIs etc.)
 
 
We see Helium as a global telecommunication carrier, and definitely the future network for connected devices all over the globe. It will be an aggregation point for most of our existing and future solutions. We want to support this project in all its aspects, including network expansions via gateway production and also future end device design and production to be integrated in Helium.
 
 
### Company identification
* Name: Innodev S.R.L.
* EU VAT no: RO17036564
* Location: Bucharest, Romania
 
 
## Product Information
 
* What is your approximate price point? 
 
The approximate price point is 850 Euro ex. VAT.

* Detailed hardware designs, including relevant parts?
 
The gateway design is based on the Raspberry Pi Compute Module 4 (CM4), SX1303 and SX1250 radio chipsets, ATECC608B and DS28C36 for encryption of the swarm_key.
 
* Evidence of a functioning prototype - photos, videos. 
 
Please see below the pictures and details of the current status.
 
* Your plan for software setup and configuration for the devices. This would presumably include remote updates and the ability for hosts to change wifi settings, via Helium's official app or otherwise.
 
Please see below the Software and System Upgrade chapters.
 
* What is your expected production and delivery timeline?
 
We expect to deliver the first prototype for audit in September. Production is expected to start by December. Please see more details in  "Production and delivery timeline" chapter
 
 
Below are more details regarding our answers.
 
 
We are building a special Helium gateway. We are naming it TERRANIUM. Our main focus is on its outdoor characteristics and security.
 
 
### Current status
 
![Figure 1. Milestones and status](http://innodev.ro/wp/terranium_img/steps.png)  
 
**Figure 1. Milestones and status**
 
**Hardware design** - schematics, PCB, enclosure - **Done**
 
**Firmware** - Partially done
 
 
 - Configuration and troubleshooting UI – **Done** 
 
 - Integration with Helium app (Android/iOS) - **Ongoing**
 
 - Other software modules (enclosure thermal management and protection, light signaling drivers) – **Ongoing**
 
 **Prototyping** - **Ongoing**
 
 
 - RF Modules mPCIe - PCB manufactured 
 
![Figure2 - LWTERR-RF - Bottom](http://innodev.ro/wp/terranium_img/pcb-1.jpeg)![Figure2 - LWTERR-RF - Top](http://innodev.ro/wp/terranium_img/pcb-2.jpeg)
 
 **Figure 2 - RF modules PCB**
 
 - Enclosure - **Ongoing**
 
![Enclosure 1](http://innodev.ro/wp/terranium_img/enc_v.jpeg) ![Enclosure 2](http://innodev.ro/wp/terranium_img/enc_h.jpeg)
 
**Figure 3 - Enclosure**
 
 
 - Assembly line facility – **Ongoing** - we have our own new warehouse that will be prepared for device final assembling, automated testing and packaging.
 
 
### Estimated Price point
Estimated price is 850 Euro ex. VAT being dedicated for special outdoor conditions
 
 
### Functionalities
When we designed this device, we had in mind its outdoor usage and the consequences arising from this. Our own imposed requirements take in consideration some of the most restrictive usage scenarios like easy and fast installation outdoors on existing telecommunication poles in the city or transportation infrastructure (city roads, highways, railways subway stations etc.)
Some of the key features of this device are:
 
 
-   IP68 by design
-   Compact form factor – cylindrical (6x20 cm) aluminum case
-   Power supply – PoE only
-   Passive cooling – electronic modules are immersed into a special cooling liquid
-   No moving parts.
-   No physical buttons
-   RF module, CPU module and cooling liquid temperature monitoring and protection.
-   RGB light signaling via translucent enclosure caps
 
 
### High Level Design
The device is composed from the following main modules:
 
 
1.  RF module - Innodev LWTERR-RF which is our own made mPCIe Lora module around Semtech SX1303 chip
2.  Mainboard – Innodev LWTERR-MB that contains all other power, security, thermal management, communication, gps and security components
3.  Raspberry PI ComputeModule 4 with BLE and EMMC memory. In the future for the next revision we plan to develop our own module using ARM or RISC V cpu.
4.  Enclosure – sealed aluminum enclosure with IP68 RJ48 and N-type connectors including internal cooling liquid
 
![High Level Design](http://www.innodev.ro/wp/terranium_img/hla.png)
 
**Figure 4 - High Level Architecture**
 
### Electronic Modules
-   RF module – LWTERR-RF
-   Mainboard module – LWTERR-MB
-   RPI CM4 with BLE and EMMC
   
### Software
The software is composed from the following main modules:
-   Semtech Forwarder and HAL
-   Helium miner – docker
-   Mainboard aux kernel and service modules – thermal management, RGB LED control, ECC chip, all via I2C
-   Management interface using Django with docker
-   The Helium configuration application (/gateway-config) to support communication with the Helium Hotspot App
 
![enter image description here](http://www.innodev.ro/wp/terranium_img/webapp.png)
 
**Figure 5 - Internal WEB configuration app**
 
 
**System upgrade**
The gateway will permit the following upgrade methods:
-   Automatic via Internet – for entire system or for specific docker images or software
-   Manual via Internet - for entire system or for specific docker images
-   Manual only in service via USB – for entire system
 
 
**System daily updates check**
-   Updates for the miner
 
 
**Configuration management**
 
 
The device configuration is aggregated in a single .conf type file. Via web interface, the user can save a backup of the file or upload a backup one.
For the reset to factory default procedure the user will have a special configured BLE beacon only for that device, that should be placed nearby. After a power-on, if the device will detect this beacon nearby (3-5m radius) in no more than 1 minute after boot, it will initialize the factory reset procedure. This BLE beacon will be delivered with the device or if it is lost can be acquired separately from Innodev. As we specified earlier, the gateway is designed to work outdoors, mostly installed to 3 or more meters high. Using this procedure, we avoid adding a physical button on the enclosure for security and environment protection reasons. Users should also avoid open enclosure, being sealed and filled with thermal conducting liquid. Another reason is an operational one. Being installed most probably in a high position, the user could just power-off and power-on the device by disconnecting the ethernet cable, and place the beacon in the device proximity. The device status and reset procedure will be signalized by the LED light color and blinking of the bottom cap.
### Production and delivery timeline
1.  Prototypes – 10pcs of full functioning prototypes will be produced until September, and two of them will be sent to Helium for certification proposed
2.  First batch – 100pcs until December depending of Helium certification duration, using our own resource, and not relying on pre orders
3.  We estimate that we can produce one batch each 3 months starting with 200+ devices/batch but this figure can be increased depending of orders and component availability
See Figure 1
 
 
## Previous shipments
 
* Have you shipped anything in the past?
 
Yes, we have shipped around 2000+ devices with different 
 
* Which countries have you previously shipped regulatory FCC or CE approved products? 
 
We have shipped CE approved products to Romania which, as part of the European Union, has mandatory CE requirements. 
 
* Which countries do you plan to ship to? 
 
We plan to ship to all countries in Europe, for starters. After that we plan to expand to worldwide shipping.
 
Here are more details about our answers.
 
We shipped various equipment and turned key solutions. Until now we targeted custom made solutions for our customers, mostly industrial, not consumer ones.
We shipped only in the EU. Starting with the prototyping we will provide CE approval for them. First batches of production will be made only for Europe and countries that use 868Mhz band and where CE approval is sufficient. Later on, we will consider producing the RF modules for 915Mhz and apply for FCC approval.
 
 
## Customer Support
 
* How will your customers be able to contact you for support for your products?
 
We will offer customer support by phone and online (email ticket and Discord channel)
 
* For how long? 

Support will be available for the entire life duration of the product. 
 
* How are you planning to handle repairs and replacements?

Repairs and replacements will be executed in our factory in Romania.
 
 
Below are more details regarding our answers.
 
 
Our product will be ISO 9001:2015 Quality management standard compiled. We will establish a clear customer support procedure by phone and online (email ticket and Discord channel - #terranium). We will have a dedicated team for support available from Monday to Friday - from 9AM to 5PM CET). The team and working hours will be upgraded based on the equipment delivery quantities and regions. Romania has a well established reputation on the market for professional technical customer support for major companies like Ericsson, Oracle). We will offer support in the following languages: English, French, Spanish and Romanian.
 
 
The warranty will be for 1 year with the possibility to be extended. In the warranty period, our first option will be the replacement. The repairing procedures will be done by Innodev. User will send the equipment to our service office for this procedure. Due to the fact that all electronic modules will be immersed in a liquid, the repairing procedure requires special tools and skills.
 
 
For the replacement and repair, where is possible we will move the ECC chip to the new device so the user will keep the same swarm key and device settings
 
 
As part of the European Union we can ensure fast delivery time to all EU countries without any delays due to custom clearance, both for initial purchases and also for service returns.
 
 
## Hardware Security Element
 
* Encrypted/locked-down firmware
 
The firmware will be locked-down to the serial number of the processor. The data will be encrypted
 
* Encrypted storage of the miner swarm_key, either via disk encryption or hardware measures like an ECC chip
 
Swarm key and data encryption key will be stored in the ECC chip.
 
* Encrypted buses, potting and other anti-tampering measures.
 
Tampering will be mittigated by adding sensors to the board.
 
* Willingness to submit a prototype for audit, and sharing those audit results publicly (pass or fail)
 
We plan on submitting the prototype for auding in September.
 
 
Below are more details regarding our answers.
 
 
The hardware root of trust of the gateway is an ECC-P256 chip. This is a secure authenticator, compliant ECDSA, to ensure signature generation and verification to support a bidirectional asymmetric key authentication model.
The swarm_key files are stored in the ECC chip to ensure the highest grade of security.
 
 
In order to mitigate the scarcity of the ECC608 chips the board is designed to accommodate 2 different ECC chips from 2 different manufacturers. The software contains drivers for both chips.
 
 
To ensure the security of the swarm_key they will be stored in a cold storage. Swarm_keys are written to the device in a completely isolated zone (no internet or LAN access). Each device uses a different pair of asymmetric keys. This ensures that if one device encryption key is compromised no other device is affected.
 
 
The firmware is locked-down to the serial number of the raspberry-pi and to the ECC encryption key. In case of failure of the raspberry pi compute module the gateway will have to be sent in for service to generate new encryption keys.
 
 
The random number generator built in the ECC chip is used to generate the nonce required to prevent man-in-the-middle attacks.
 
 
The software is secured by an internal firewall.
 
 
Several security scripts will run at boot time and during run to ensure that the device is protected from known malware/botnets and detect new ones by monitoring the anomalies and changes in the day to day functionality.
 
 
Filesystem and data are encrypted (AES-256).
The communication channels are encrypted using OpenSSL.
Tampering attempts will be detected by measuring the right cooling liquid level and temperature of those 3 sensors.
 
 
## Hardware Information
 
* Which security (swarm) element are you using?
 
We use a ECC chip as security element.
 
* Which LoRa chipset are you planning to use in your gateway?
 
We use the SX1303 and SX1250 with our own radio board design.
 
* Where are you sourcing your components from?
 
Our supplier are located in UK, European Union and China.
 
* How many radio modules/ concentrators can you procure?
 
We can procure at least 1000 SX1303 and SX1250.
 
 
Below are more details regarding our answers.
 
 
**Security element**
An ECC608 chip is used to securely store the swarm_key. The board supports 2 different ECC chips from 2 different manufactures: ATECC608B and DS28C36
 
**LoRa module**
LoRa module is designed and produced by us. It is a mPCIe module, and uses SPI and GIO for communication. We use the SX1303 & SX1250 in order to take advantage of the Fine Timestamp capability of this chipset and implement higher accuracy location services in the future. This mPCIe radio module is designed by us, and produced in factories in China and, as backup,  Germany. There are other LoRa mPCIe modules on the market but we prefer to produce our own, in order to decrease the dependency from other partners and avoid procurement risks. We can produce RF modules as much as we need according to the orders. Components for it will be procured from different distribution partners from the UK, Romania and China.
 
 
**CPU Module**
TERRANIUM gateway uses a RaspberryPi Compute Module 4 with EMMC and BLE. We have a distribution partner in the UK for this component.
 
 
**Mainboard module**
The mainboard is fully designed by Innodev. As described above in High Level Design and Figure 4, it contains the connectors for LoRa module and RPI CM4, GPS module and includes all other functional components like thermal management, power management and PoE, RBG LED signaling, Ethernet Phy and USB. For the PCB and assembly, we have a good partnership with a factory in Bulgaria. The components will be acquired from our distribution partners from the UK and Romania.
 
 
**Enclosure**
Enclosure is designed by Innodev. It has a cylindrical form made from aluminum and translucent plastic caps for RGB light status signaling. Inside is filled with the cooling liquid. It is a special liquid used to cool electronic devices that are immersed into it. It has good temperature conductivity but an electric isolator. Its role is to transfer the heat from the electronic components to the aluminum enclosure body. The temperature of this liquid will cross a programmable limit, it will stop the power of the CPU and RF module. It will enable power only after the temperature decreases.
Mechanical processing will be made in Romania by a specialized factory.
 
 
**Final assembly and automatic testing** will be done by us, in our own production warehouse. It is already finalized in Bucharest and will be equipped for production processes.
 
 
**MTBF analysis**
The MTBF analysis and simulations will be performed for the electronic modules that we procedure and for the device itself.
 
 
## Manufacturing Information
 
* Have you built and delivered radio hardware products before?
 
Yes, we have built ZigBee products.
 
* Have you built gateways before?
 
Yes, we have built ZigBee gateways and Ethernet gateways.
 
* How many gateways did you make? 
 
We produced around 2000 gateways. 
 
 
Below are more details regarding our answers.
 
 
Our experience includes working with technologies like  Zigbee, BLE and GSM. We designed and produced gateways used in different IoT industrial applications like:
-   ZigBee to Ethernet/IP (MQTT)
-   ZigBee to GSM/IP (MQTT)
-   BLE to WIFI/IP (MQTT)
-   IP(MODBUS) to Ethernet/IP (MQTT and REST API)
-   Serial (MODBUS) to Ethernet/IP (MQTT and REST API)
 
In order to reduce the risk for delays in hardware production:
- we have design our own radio board with the latest radio chips available (SX1303 and SX1250)
- we are in contact with 3 board manufacturers in 3 different countries (China, Germany and Bulgaria)
- we have 3 supply chains in 3 different countries/regions (UK, European Union, China)
- final assembly and enclosure manufacturing is done in Romania 
 
## Proof of Identity
 
 
Innodev SRL is a private company with four private shareholders. Detailed information can be provided by request.
 
 
## Budget & Capital
 
* How many of these are you hoping to make and sell? 
 
We plan to start with a small batch (100) without any pre orders. After that we plan higher production batches (200-3000 devices/batch)
 
* How much money will be required up-front? How much money do you have on-hand, and how much do you have access to?
 
We have the money on-hand to produce 100 gateways and finance the software development, customer support and testing.
 
*  What is your plan for additional financing if required? 
 
 
Below are more details regarding our answers.
 
 
Innodev funds come from the consultancy services we provide so we have large profit margin. All shareholders can contribute to funding this projects as all shareholders have other sources of income.
 
-   Prototype batch – 10 devices
-   First batch – 100 devices founded by us with existing company founds with no additional financing    
-   Production batches - 3 to 4 batches per year starting with 200 - 3000 devices / batch.
 
 
We plan to accept pre-orders only for 868Mhz models for the Production batches. Our intention is that half of each batch to be financed by us, not from pre-orders to ensure a device buffer for warranties, repair & service and direct sales.
 
 
## Risks & Challenges
 
 
There are a series of risks that we identified and we have to mitigate. Most important are:
1.  Electronic component shortage – some components can not be found easily or in a high number. It is a case for some ICs, resonators, filters but also for some capacitors. In order to mitigate this risk we took some measures like establish equivalent components if it is possible, add additional footprint on PCB for a different replacement component but not pin compatible and establish a list with more suppliers from different regions ( EU, UK, US and Asia)
2.  Production delays – we could face some delays on module production ( PCB and assembly). To mitigate this risk, we have three partners for production in three different countries (Germany, Bulgaria and China). With all of them we have good past experiences and we plan to split the batches or modules between them.
3.  Logistic issues - for various reasons, like epidemic risk escalation or high over logistic companies, delays in the logistic process could appear. To mitigate this risk, we will create partnerships with at least two global logistic companies and one local for Romania and nearby countries. At least one of them will be able to keep spare devices in their own warehouses for fast delivery for special cases like urgent replacements.
4.  Support service overload - if the delivery will increase, the risk of overloading the support team is high. Starting with the second production batch, we will establish a partnership with a specialised company in Romania for international support services. Locally in Bucharest and also in other major cities, there are well known companies specialized for multilanguage technical and sales support, so we can gradually make knowledge transfer to them.
5.  Financing issues - production cost could be an issue. This risk will be minimised through some measures:
        a.  We will establish an internal budget for the production to support the first batch and at least half of the following ones. Sources of financing are internally, factoring and investors
        b.  Using bank financial tools like trade finance and invoice finance
        c.  Acquisition of high component quantities
7.  Component obsolescence - from the design phase we select only components recommended for new designs. Anyhow, if any of the components will be obsolete, it can be replaced by a similar one, and the design (PCB layout, schematics, firmware) can be changed if needed.
8.  Reliability issues - MTBF calculations and simulation will be performed for each module and for the device. Our target is to exceed 10 years. This is one of the reasons that we choose to use the EMMC variant and not SD.
 
 
## Other information
 
-   Contact info
        -   Email: terranium@innodev.ro
        -   Website - www.innodev.ro
-   Payment methods available - Bank transfer and online card payment in future.
-   Regions covered / shipped to - All countries with EU863-870 frequency plan.
