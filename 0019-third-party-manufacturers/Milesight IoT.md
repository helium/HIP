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

- Quad-core 1.5 GHz, 64-bit ARM Cortex-A53,512 MB DDR4 RAM,8 GB eMMC

- CN470/IN865/EU868/RU864/US915/AU915/KR920/AS923

- Based on SX1302, 8 channels

- 4G, WIFI
- Operation temperature range: -40°C to +70°C

- IP65 rated

- Power options: 9-24 VDC power supply or  802.3 af PoE input

- Dimensions: 180 x 110 x 56.5 mm




UG67:  [Live Video Introduction](https://www.youtube.com/watch?v=yO7YfnvWJtQ&list=PLb33srEEYIJbcm5VfG5PGRFy-XgTN6jEG&index=2)

- Quad-core 1.5 GHz, 64-bit ARM Cortex-A53,512 MB DDR4 RAM,8 GB eMMC

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

Milesight IoT gateways have an embedded hardware security built in the CPU i.MX8 Nano, which is NXP Cryptographic Acceleration and Assurance Module (CAAM, [i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page265), CAAM is built-in hardware module that implements secure memory and a dedicated AES cryptographic engine for encryption/decryption operations, A device specific random 256-bit OTPMK private key is fused in each SoC at manufacturing time, this key is unreadable and can only be used by the CAAM for AES encryption/decryption through the Secure Non-Volatile Storage (SNVS) companion block. 

Every time when the gateway is powered on, CAAM will verify whether the bootloader and the firmware's signature matches by the burned key inside the SoC before proceed or stop. When try to upgrade or downgrade the firmware, the CAAM will act the same behavior in SoC before load it or refuse it. The bootloader itself cannot be modified (locked and signed), The High Assurance Boot (HAB) component of the ROM protects against the potential
threat of attackers modifying the areas and prevents the attempts to gain access to features which must not be available.

Full Security Block Diagram ([i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page68)

CAAM Block Diagram ([i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page266)

High-Assurance Boot (HAB): ( [i.MX8 guide](http://resource.milesight-iot.com/files/IMX8MNSRM.pdf)-Page150)

Milesight IoT gateways supports Replay Protected Memory Block ([RPMB](https://lwn.net/Articles/682276/)) partition within e-MMC to store the secrets keys (swarm_key) after encrypted by CAAM by the burned key inside the SoC, the swarm_key(256bit) will be generated by OpenSSL inside gateway. 

The RPMB is protected by the write Counter and a random secured 256-bit key burned in OPT, which is generated randomly and not cannot be modified.  The encrypted swarm_key can only be read by the HOST(The gateway) and transmitted to CPU for the blockchain transaction and data encryption. It cannot be used or extracted since it's been cyphered by CAAM using SHA-256.

RPMB partition is also used to store the [finger print and critical modem data of smart phones](https://ieeexplore.ieee.org/document/7411305) widely.

Milesight IoT will consider adopting the ECC608 into the device in future release according to HIP19's recommendation.



## Hardware Information

**Processor/CPU**: NXP's  i.MX 8M nano (ARM-Cortex-4*A53, 1.5Ghz)

**RAM**: 512MB, DDR4

**Flash**: 8GB eMMC

**LoRa Chipset**: SX1302+SX1250+SX1262(for LBT), One gateway produces one concentrator only. 

**Security Chip**: RPMB (Replay Protected Memory Block) Partition within e-MMC, which is encrypted by HMAC SHA-256 and protected by Write Counter.

  

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

 
