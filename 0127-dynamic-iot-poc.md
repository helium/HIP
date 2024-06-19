# HIP 127: Dynamic IOT Proof-of-Coverage

- Author(s): [gradoj](https://github.com/gradoj)
- Start Date: 2024-06-19
- Category: Technical
- Original HIP PR: [#1015](https://github.com/helium/HIP/pull/1015)
- Tracking Issue: [#1045](https://github.com/helium/HIP/issues/1045)
- Vote Requirements: veIOT Holders

---

## Summary

This is a proposal for the Helium IoT network to update Proof of Coverage (PoC) beacons by introducing a random selection of transmit power, datarate and packet length. The existing PoC algorithm was designed to show maximum coverage with a limited number of beacons. The current beacon frequency allow us to utilize higher data rate capabilities and variable transmit power to collect a more complete picture of the network's capability. This proposal aims to enhance network reliability, improve the accuracy of coverage mapping, and increase security.

## Motivation

One of the primary benefits of this change is to reduce the overall transmit time of beacons, decreasing network noise and enhancing network reliability. Longer transmission times increase the likelihood of packet collisions and losses, making it important to minimize on-air time in ISM bands. Currently, PoC beacons are 52-byte packets transmitted at the maximum Effective Isotropic Radiated Power (EIRP) for each region. 

A second benefit to varying beacon parameters is it allows us to collect a more rich map of the networks capability through the PoC mechanism. This is important to understand as it allows sensors to utilize a higher data and ultimately extend their battery life.

Randomizing transmission power also enhances security by making it more difficult for malicious actors to manipulate Hotspot metadata. Currently, while the source of a beacon may be unknown, its constant transmission power is predictable. By dynamically adjusting this power, we introduce an additional layer of uncertainty that challenges potential manipulators.

It is hoped that by introducing this random behavior into the traditional PoC mechanism it will bring additional value for minimal effort.


## Stakeholders

All IOT Hotspot Operators will be impacted by the randomness introduced to PoC. The random parameters are expected to have varying amounts of coverage and this will impact the number of witnesses received by each beacon. No significant impact is expected to individual Hotspots earnings as more or less witnesses will average out.

IOT Hotspot Operators that are manipulating PoC data will be easier to identify and deny. 

Oracle bucket data proto definitions may need to be updated to handle any additional parameters. Ingesters of this data will need to be notified if changed. Coverage Map creators and explorers will need to update or create new layers of deployment coverage.

IOT Hotspot Manufacturers will need to ensure that their Hotspots transmit at the proper levels. If the transmit look up tables are misconfigured the output power may be incorrect causing confusing PoC data and affect rewards.



## Detailed Explanation

Each Hotspot on the Helium network transmits a beacon approximately every six hours or 4 times per day. Every Hotspot that witnesses this beacon will report their witness data, proving functional coverage information of the network. By altering parameters, namely (1) transmit power, (2) datarate and (3) packet length of the transmitted Proof of Coverage (PoC) beacons, more information and value for the users of the network can be obtained from the same procedure.  


#### Terms
[EIRP - Effective Isotropic Radiated Power](https://en.wikipedia.org/wiki/Effective_radiated_power)

[LNS- LoRaWAN Network Server](https://docs.helium.com/iot/lorawan-network-servers)

LUT- Look Up Table

[dBm - decibel(per milliwatt)](https://www.data-alliance.net/blog/dbi-db-dbm-dbmw-defined-explained-and-differentiated/)

[dBi - decibel(isotropic Antenna Gain)](https://www.data-alliance.net/blog/dbi-db-dbm-dbmw-defined-explained-and-differentiated/)

[DC- Data Credits](https://docs.helium.com/tokens/data-credit)


### ModifyingTransmit Power (1)
Each Hotspot is capable of transmitting at a variable rate over a limited power range. The transmit power is requested when the packet is submitted to be sent. The default or maximum EIRP is specified by the [(4) LoRaWAN 1.0.4 Regional Parameters standard][4] for each region. The Hotspots asserted antenna gain is used to keep the transmitted power within regulatory limits.

$`EIRP(dBm) <= TransmitPower(dBm) + AntennGain(dBi)`$

Default(Max) EIRP is taken from LoRaWAN 1.0.4 Regional Parameters standard and [(6) Helium lorawan-h3 repo][6]. The actual transmit power must be lowered to keep the EIRP within regulatory limits when paired with a high gain antenna.  

| Region    | Max EIRP(dBm) | Notes     |
|-----------|---------------|-----------|
| KR920     | 14            |           |
| AS923-1   | 16            |           |
| AS923-1B  | 16            |           |
| AS923-1C  | 30            |           |
| RU864     | 16            |           |
| EU868     | 16            |           |
| CN470     | 19            |           |
| IN865     | 30            |           |
| US915     | 36            | Default from Regional Params is 30dBm |
| AU915     | 30            |           |

As an alternative to always transmitting at the maximum permitted value it is suggested that a random selection is made from a subset of allowable transmit powers. But the large spread in allowable power across regions makes it difficult to implement one general set of transmit powers over all regions. Differentiating power-level selection by regions allows PoC to be 'balanced' across regions without additionally affecting the current region power imbalance. This hip does not attempt to address any possible imbalance in the current PoC system which is outside the HIP scope, however, this mechanism could be used to adjust any imbalance in the future. These suggested values keep status quo with today and do not introduce any change across regions:

#### Suggested for AU915, US915, AS923-1C and IN865(GroupA)

Power options are set to:

$`\{MaxEIRP,\ MaxEIRP*0.8 dBm,\ MaxEIRP*0.6 dBm\}`$

#### Suggested For KR920, AS923-1, AS923-1B, RU864, EU868, CN470(GroupB)

$`\{MaxEIRP,\ MaxEIRP*0.8 dBm,\ MaxEIRP*0.8 dBm\}`$

The duplicate 3rd value is intentionally left to make comparison to the fixed channel plans easier. Power options are set to

#### Suggested set of EIRP values for each region:

A selection is made between full power or one of the reduced values. MaxEIRP minus 3dBm will cut the transmit power in half and minus 6dBm will be a quarter of the total power. Using inverse square law the estimated range will roughly double with a change of 6dBm.

|  Region  | EIRP Values(dBm) | Group | Notes |
|----------|------------------|-------|-------|
| KR920    | 14, 11, 11       |    B  |       |
| AS923-1  | 16, 13, 13       |    B  |       |
| AS923-1B | 16, 13, 13       |    B  |       |
| AS923-1C | 30, 22, 16       |    A  |       |
| RU864    | 16, 13, 13       |    B  |       |
| EU868    | 16, 13, 13       |    B  |       |
| CN470    | 19, 15, 15       |    B  |       |
| IN865    | 30, 22, 16       |    A  |       |
| US915    | 30, 22, 16       |    A  | Currently 36  |
| AU915    | 30, 22, 16       |    A  |       |

To enhance the detail and accuracy of the coverage map, we propose introducing variable transmit power for beacons. By randomly adjusting the transmit power at each spreading factor, we can generate a comprehensive map that more accurately reflects the network’s capabilities for sensor fleet deployers.

### Modifying Spreading Factor - Datarate (2)

The spreading factor (SF) in LoRa determines the number of chirps (symbol) used to encode a bit of information. A higher spreading factor increases the number of chirps per bit, which makes the signal take longer to transmit but increases its resilience to noise and increases range. Further detail is beyond the scope of this document but the performance improvements have been shown to the minimum sensitivity:

Sensitivity improvements taken from [(3) Semtech AN1200.22][3]:


| Mode  | Bit Rate(kb/s) | 	Sensitivity(dBm) | Symbol Time(ms) | US915 Max Packet Size(bytes) |
|-------|----------------|-------------------|-----------------|------------------------------|
| FSK   | 1.2            | -122	             |                 | -                            |
| SF12  | 0.293	         | -137              | 	32.768         | -                            |
| SF11	| 0.537	         | -134.5            | 	16.384         | -                            |
| SF10	| 0.976	         | -132	             | 8.192           | 24                           |
| SF9	  | 1.757	         | -129	             | 4.096           | 61                           |
| SF8	  | 3.125	         | -126	             | 2.048           | 133                          |
| SF7	  | 5.468	         | -123	             | 1.024           | 230                          |

Regulatory constraints in the US915 region, which have a maximum dwell time of 400ms, restrict the use of spreading factors above SF9 for 52-byte packets. In contrast, the EU868 region can utilize SF12 but are limited in the EIRP. By randomly selecting the data rate, the proposed change is expected to reduce overall PoC airtime by 38% in US915 (SF7,SF8,SF9) and 57% in EU868 (SF7,SF10,SF12).

The following table, based on calculations from this [(2) Airtime calculator][2], illustrates the potential reductions in on-air time across different configurations:

| Region | Spreading Factor | Datarate(bps) | Packet Length (bytes) | On-Air Time(ms) | Max EIRP | Notes                             |
|--------|------------------|---------------|-----------------------|-----------------|----------|-----------------------------------|
| US915  | SF7              | 5470          | 52                    | 103             | 30       | Currently 36                      |
| US915  | SF8              | 3125          | 52                    | 185             | 30       |                                   |
| US915  | SF9              | 1760          | 52                    | 329             | 30       | Current POC Beacon 36 EIRP        |
| US915  | SF10             | 980           | 52                    | 616             | 30       | Dwell time exceeded(Max 25-bytes) |
| EU868  | SF7              | 5470          | 52                    | 103             | 16       |                                   |
| EU868  | SF8              | 3125          | 52                    | 185             | 16       |                                   |
| EU868  | SF9              | 1760          | 52                    | 329             | 16       |                                   |
| EU868  | SF10             | 980           | 52                    | 616             | 16       |                                   |
| EU868  | SF11             | 440           | 52                    | 1315            | 16       |                                   |
| EU868  | SF12             | 250           | 52                    | 2466            | 16       | Current POC Beacon                |

Reducing the poc packet size to 24bytes:
| Region | Spreading Factor | Datarate(bps) | Packet Length (bytes) | On-Air Time(ms) | Max EIRP | Notes                             |
|--------|------------------|---------------|-----------------------|-----------------|----------|-----------------------------------|
| US915  | SF7              | 5470          | 24                    |  62             | 30       | Currently 36                      |
| US915  | SF8              | 3125          | 24                    | 113             | 30       |                                   |
| US915  | SF9              | 1760          | 24                    | 206             | 30       | Current POC Beacon 36 EIRP        |
| US915  | SF10             | 980           | 24                    | 371             | 30       | Dwell Time no longer exceeded     |
| EU868  | SF7              | 5470          | 24                    |  62             | 16       |                                   |
| EU868  | SF8              | 3125          | 24                    | 113             | 16       |                                   |
| EU868  | SF9              | 1760          | 24                    | 206             | 16       |                                   |
| EU868  | SF10             | 980           | 24                    | 371             | 16       |                                   |
| EU868  | SF11             | 440           | 24                    | 823             | 16       |                                   |
| EU868  | SF12             | 250           | 24                    | 1483            | 16       | Current POC Beacon                |

Enabling higher data rates on the network allows battery-powered LoRaWAN sensors to extend their battery life by transmitting data more quickly, which reduces transmitter on-time and consequently lowers system noise and collision risks. However, these higher data rates reduce transmission range, making it essential to accurately understand and map the network's coverage capabilities.


### Modifying Beacon Packet Length (3)

The current packet length of the PoC beacon is 52 bytes. This length comes from legacy data included during targeted proof of coverage. The longer the packet the [(1) higher a chance of interference and packet loss][1]. Using a variable packet length for POC will further help to understand the network's capability.

The beacon packet length will be reduced from 52-bytes to a static 24-bytes or 1 DC (Data Credit) packet. This includes any header or overhead required for the POC packet. There will be no random selection for packet length. The length of the packet has a limited impact of the performance of the RF link and it has been decided the variable packet length is not worth the extra complication.

It should be noted that the reduction of the packet length has made SF10 feasible with the US915 channel plan as the maximum dwell time is no longer exceeded. 

#### Entropy

The random values will be selected based off...TBC


### Beacon Creation Algorithm

Each parameter will be independent of each other when creating the beacon. This will allow a random selection of Transmit Power and Datarate without worrying that certain combinations of parameters are not compatible. e.g. All datarate combinations will respect the 400ms dwell time.

This will allow a very simple random selection of Transmit Power and Datarate. Packet Length of the beacon will not be dynamic but reduced to a fixed 24 bytes.

## Drawbacks

One reason to not do this is the increased complexity in PoC challenge. There is some thought that will need to be put into transmit power capabilities, limitations and resolutions. 

There will be a slight shuffling of rewards as beacons of random varying capability make their way through the system. On average, it is expected to work out very closely to current state.

The number of witnesses will be more variable per packet. Therefore, earnings will be more variable from beacon to beacon.

## Rationale and Alternatives

This design was chosen for its potential to enhance network integrity and mapping measurement accuracy. It also utilizes existing mechanisms to gain more quality data without altering the core PoC mechanism.

Alternative designs include adjusting some subset of the parameters discussed above. e.g. dynamic spreading factor but do not vary transmit power. These do not offer the same level of unpredictability as varying all three parameters.

Other discussions of dual beacons from neighboring hotspots with a time sync method. This HIP does not exclude this addition in the future if deemed valuable.

One alternative method sends multiple beacons within a very short interval. This would remove any long-term variation due to weather or other external factors but would require the beacons to be grouped instead of evenly spaced. This would further aggravate the lumpiness that may be introduced to earnings with dynamic beacons.


## Unresolved Questions
  
- Does tx power have to be even?
- What is the minimum/max tx power used?
- Why do we use 36 dBm in North America?

- Exact methods for deriving parameters from blockchain entropy need refinement, the randomness of selecting the transmit power, datarate and packet length is not yet fully defined.
- Impact assessment on existing Hotspots and any required updates.
- POC equalization across regions. Suggestions have been made to reduce the maximum EIRP for US915 to 22dBm. This HIP does not try to equalize the existing poc rewards across regions but only keep the status quo.

## Deployment Impact

This HIP does not come with code. Nova Labs and Helium Foundation are requested to code the deployment.

There is the potential for the power control to not work as expected across different Hotspots and manufacturers. It is up to the hotspot manufacturer to ensure the hotspot is transmitting at the proper levels. If the transmit LUT are misconfigured the output power may be incorrect causing confusing PoC data.

Current beacons, configured for maximum range, will still be sent but at a less frequent interval. Users may notice fewer witnesses while sending beacons of a higher datarate or lower power. In some cases these beacons may not cover as large a footprint but still contains valuable data or its capability. 

Comparison of potential beacon combinations compared to maximum of today. The Delta dB shows the difference from today's current PoC beacon accounting for spreading factor and transmit power with the values suggested in the sections above.

### EU868

| Spreading Factor |      EiRP(dBm)      | Packet Size | Delta dB | Notes          |
|------------------|---------------------|-------------|----------|----------------|
| SF12             | 16                  | 52          | 0        | Current Beacon |
| SF10             | 16                  | 24          | -5       |                |
| SF7              | 16                  | 24          | -14      |                |
| SF12             | 13                  | 24          | -3       |                |
| SF10             | 13                  | 24          | -8       |                |
| SF7              | 13                  | 24          | -17      |                |
| SF12             | 13                  | 24          | -3       |                |
| SF10             | 13                  | 24          | -8       |                |
| SF7              | 13                  | 24          | -17      |                |


### US915

| Spreading Factor |      EiRP(dBm)      | Packet Size | Delta dB | Notes          |
|------------------|---------------------|-------------|----------|----------------|
| SF9              | 36                  | 52          | 0        | Current Beacon |
| SF10             | 30                  | 24          | -3       |                |
| SF8              | 30                  | 24          | -9       |                |
| SF7              | 30                  | 24          | -12      |                |
| SF10             | 22                  | 24          | -8       |                |
| SF8              | 22                  | 24          | -8       |                |
| SF7              | 22                  | 24          | -11      |                |
| SF10             | 16                  | 24          | -8       |                |
| SF8              | 16                  | 24          | -14      |                |
| SF7              | 16                  | 24          | -17      |                |

The SF9 52-byte packet has been included for comparison and will not be used for this HIP. The new highest power packet for US915 uses 30dBm EiRP and SF10 datarate which has an equivalent -3dB delta compared to the original beacon.

![image](https://github.com/gradoj/HIPS/assets/7544765/5bbe60eb-953f-4c91-aae1-c333c32dcf5c)

## Success Metrics

Reducing the beacons from the current maximums will reduce the on-air time on average. This will reduce interference and packet collision. This may not be important in sparely populated areas but in dense deployments the PoC airtime from all hotspots within range could significantly degrade the channel.

Visualization of PoC coverage could include multiple layers for capability. Feedback from the community on improved coverage maps would be expected.

The variable transmit power will most likely help to detected gaming or manipulation incidents. It will also make gaming 0dB antenna less effective. Finding the right distance apart will be more difficult as the packet strengths will vary, and they are using noise and near-field effects versus propagation.


## Referenced Documents

(1) https://www.researchgate.net/publication/362115325_On_the_Performances_of_Packet_Error_Rate_for_LoRa_Networks

(2) https://avbentem.github.io/airtime-calculator/

(3) https://www.frugalprototype.com/wp-content/uploads/2016/08/an1200.22.pdf

(4) https://resources.lora-alliance.org/technical-specifications/rp002-1-0-4-regional-parameters

(5) https://semtech.my.salesforce.com/sfc/p/E0000000JelG/a/2R000000HSSa/nimci8O3XiFeGQpltq_YTbps18CSIaKKgMfssp5VWwE

(6) https://github.com/helium/lorawan-h3/tree/main/region_params

[1]: https://www.researchgate.net/publication/362115325_On_the_Performances_of_Packet_Error_Rate_for_LoRa_Networks
[2]: https://avbentem.github.io/airtime-calculator/
[3]: https://www.frugalprototype.com/wp-content/uploads/2016/08/an1200.22.pdf
[4]: https://resources.lora-alliance.org/technical-specifications/rp002-1-0-4-regional-parameters
[5]: https://semtech.my.salesforce.com/sfc/p/E0000000JelG/a/2R000000HSSa/nimci8O3XiFeGQpltq_YTbps18CSIaKKgMfssp5VWwE
[6]: https://github.com/helium/lorawan-h3/tree/main/region_params

