# Milesight IoT

![img](http://harry-image-md.oss-cn-hongkong.aliyuncs.com/img/2021/05/27/52032fa05c91c5ccdf1096896c41f547-clip_image002-40f5c2.jpg)

### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)


## Summary

Milesight IoT is a well reputed manufacturer of LoRaWAN gateways and sensors. After evaluation, Milesight IoT gateways can run as regular Hotspot. 



[LoRaWAN Gateway UG65](https://www.milesight-iot.com/lorawan/gateway/ug65/)(Ethernet+4G+WIFI, IP65)

![image-20210527144606345](http://harry-image-md.oss-cn-hongkong.aliyuncs.com/img/2021/05/27/0fc2ec934c3fb66bfa016d55b608a480-image-20210527144606345-72264b.png)


 [LoRaWAN Gateway UG67](https://www.milesight-iot.com/lorawan/gateway/ug67/) (Ethernet+4G+WIFI, IP67)

![image-20210527144556761](http://harry-image-md.oss-cn-hongkong.aliyuncs.com/img/2021/05/27/f431b0b04177866e37e6d19bcc61e46c-image-20210527144556761-5e8fe4.png)


## Company Information

Milesight IoT is a subsidiary of Milesight Group which is founded in 2011. At Milesight IoT, we are passionate about the connectivity of “things” to the cloud. We leverage the value of the top trending technologies that transform the world we live in and are committed to our partners who share the same passion. We believe that the complexity of data collection, storage and retrieval can be simplified into the Cloud-intelligence. Our development and distribution of these appliances and services demonstrates our commitment to the digital transformation and continues to deliver compelling connectivity for the IoT world.

Milesight IoT has delivered LoRaWAN Gateways, LoRaWAN Sensors and Cellular Routers to more than 100 countries. We are a LoRa Alliance member and one of the leading LoRaWAN equipment manufacturers. 

Recently we received many inquiries for Helium compatible hotspot, and after evaluation we found our gateways could work well as a Helium hotspot, if we could integrate Helium into our gateway, we could bring many business opportunities to each other.



## Product Information

Milesight UG65/UG67 is robust 8-channel LoRaWAN® gateway. Adopting SX1302 LoRa chip and high-performance quad-core CPU, UG6X supports connection with more than 2000 nodes. 

UG6X has IP65/IP67 waterproof case and supports not only multiple back-haul backups with Ethernet, Wi-Fi and cellular, but also has integrated mainstream network servers (such as TTI, ChirpStack, etc.) and built-in network server and Milesight IoT Cloud for easy deployment.

 

UG65: [Live Video Introduction](https://www.youtube.com/watch?v=RMozMVlZQQc&list=PLb33srEEYIJbcm5VfG5PGRFy-XgTN6jEG&index=9)

- Quad-core 1.5 GHz, 64-bit ARM Cortex-A53, 2GB DDR4 RAM, 32 GB eMMC

- CN470/IN865/EU868/RU864/US915/AU915/KR920/AS923

- Based on SX1302, 8 channels

- 4G, WIFI
- Operation temperature range: -40°C to +70°C

- IP65 rated

- Power options: 9-24 VDC power supply or  802.3 af PoE input

- Dimensions: 180 x 110 x 56.5 mm




UG67:  [Live Video Introduction](https://www.youtube.com/watch?v=yO7YfnvWJtQ&list=PLb33srEEYIJbcm5VfG5PGRFy-XgTN6jEG&index=2)

- Quad-core 1.5 GHz, 64-bit ARM Cortex-A53, 2GB DDR4 RAM, 32 GB eMMC

- CN470/IN865/EU868/RU864/US915/AU915/KR920/AS923

- Based on SX1302, 8 channels

- 4G, WIFI, GPS
- Operation temperature range: -40°C to +70°C

- IP67 rated

- Power options: 802.3 af PoE input or 12 VDC with M12 Connector

- Dimensions: 250 x 172 x 92 mm

- These 2 gateways has been in mass production since October 2020, and we ship orders worldwide every day.



## Customer Support

Milesight provides 3 years warranty to our gateways.

Milesight IoT provides worldwide support and replacements through our distribution network. Together with our partners, our technical support team provide customers best class technical support.



## Hardware Security

Milesight gateways have an embedded hardware security built in the CPU i.MX8 Nano, which is NXP Cryptographic Acceleration and Assurance Module (CAAM, [i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page265), CAAM is built-in hardware module that implements secure memory and a dedicated AES cryptographic engine for encryption/decryption operations, A device specific random 256-bit OTPMK private key is fused in each SoC at manufacturing time, this key is unreadable and can only be used by the CAAM for AES encryption/decryption through the Secure Non-Volatile Storage (SNVS) companion block. 

Every time when the gateway is powered on, CAAM will verify whether the bootloader and the firmware's signature matches by the burned key inside the SoC before proceed or stop. When try to upgrade or downgrade the firmware, the CAAM will act the same behavior in SoC before load it or refuse it. The bootloader itself cannot be modified (locked and signed), The High Assurance Boot (HAB) component of the ROM protects against the potential
threat of attackers modifying the areas and prevents the attempts to gain access to features which must not be available.

Full Security Block Diagram ([i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page68)

CAAM Block Diagram ([i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page266)

High-Assurance Boot (HAB): ( [i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page150)

Milesight gateways have embedded the encrypt chip ECC608 on the board to generate and store the swarm_key by the miner program released officially according to HIP19's recommendation.



## HIP19 amendments for alternate security implementations

- What is the key's security model? 

The key's security model is the ECC608, which keeps the key in slot0 after initiated by the miner program.

- How/where is the key generated? 

It's generated by the gateway_mfr of miner program. (docker exec provision gateway_mfr ecc onboarding)

- What guarantees do we have about the key being extracted? 

The key has been burn in the slot0 of ECC608, it's not possible to read or extracted from anyway from the hotspot.

- Please provide datasheet and or link to relevant datasheet(s) when citing hardware based security features 

Here are the details:

​	Full Security Block Diagram ([i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page68)

​	CAAM Block Diagram ([i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page266),

​	High-Assurance Boot (HAB): ( [i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page150)

​    ECC608 [chipset](http://resource.milesight-iot.com/files/ATECC608B-CryptoAuthentication-Device-Summary-Data-Sheet-DS40002239A.pdf)

- What are your plans for software integration with Full Hotspot (miner) and Light Hotspot (gateway-rs) codebases?

We may prefer to finish the Full Miner and Light hotspot at the same time

  

## Manufacturing Information

Milesight IoT designs and produces all the products in our own production plant, since our supply chain is well managed, our business is still growing rapidly even COVID-19 is still impacting the supply chain worldwide.

 

## Proof of Identity

To be submitted privately to DeWi.



## Budget & Capital

Milesight Group has been well reputed world widely since 2011, we are shipping thousands of devices worldwide and we have enough funds to purchase raw materials for really larger orders.



## Risks & Challenges

Our business is still growing rapidly and orders are rushing in every day, lead time for larger orders may be longer than usual because chipset supply now is a worldwide problem. 

Our sourcing team is watching the market and purchasing the materials as soon as we find available stock in the market.



## Other information

- Desired Discord support channel name - Milesight IoT
- Twitter profile - https://twitter.com/MilesightIoT
- Facebook profile - https://www.facebook.com/MilesightIoT
- Other social profiles - https://www.linkedin.com/company/milesightiot/
- Website -  www.milesight-iot.com
- Payment methods available - Credit card, wire transfer
- Regions covered / shipped to - Worldwide

 
