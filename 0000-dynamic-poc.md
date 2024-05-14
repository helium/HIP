# HIP XXX: Dynamic IOT Proof-of-Coverage

- Author(s): [gradoj](https://github.com/gradoj)
- Start Date: 2024-05-07
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT Holders

## Summary

This is a proposal for the Helium IoT network to update Proof of Coverage (PoC) beacons by introducing a random selection of datarate, transmit power, and packet length. The existing PoC algorithm was designed to show maximum coverage with a limited number of beacons. Increased beacon frequency today allow us to utilize higher data rate capabilities and variable transmit power to collect a more complete picture of the network's capability. This proposal aims to enhance network reliability, improve the accuracy of coverage mapping, and increase security.


## Motivation

- Why are we doing this?
- What use cases does it support?
- What problems does it solve?
- What is the expected outcome?

One of the primary benefits of this change is to reduce the overall transmit time of beacons, decreasing network noise and enhancing reliability. Longer transmission times increase the likelihood of packet collisions and losses, making it important to minimize on-air time in ISM bands. Currently, PoC beacons are 52-byte packets transmitted at the maximum Effective Isotropic Radiated Power (EIRP) for each region. 

A second benefit to varying beacon parameters is it allows us to collect a more rich map of the networks capability through the poc mechanism. This is important to understand as it allows sensors to utilize a higher data and ultimately extend their battery life.

Randomizing transmission power also enhances security by making it more difficult for malicious actors to manipulate hotspot metadata. Currently, while the source of a beacon may be unknown, its constant transmission power is predictable. By dynamically adjusting this power, we introduce an additional layer of uncertainty that challenges potential manipulators.

It is hoped that by introducing this random behavior into the traditional PoC mechanism it will bring additional value for minimal effort.


## Stakeholders

- Who is affected by this HIP? A stakeholder is any individual, group, or party such as network
  users, Hotspot hosts, or token holders.
- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIP repository or even directly active in the Helium Community chat channels.

No action will be required but all hotspots will be impacted by the randomness introduced to PoC. The random parameters are expected to have varying amounts of coverage and this will impact the number of witnesses received by each beacon. No significant impact is expect to individual hotspots earnings as more or less witnesses will average out.

Oracle bucket data proto definitions may need to be updated to handle any additional parameters. Ingesters of this data will need to be notified if changed.

Feedback and suggestion to this hip can be discussed on Discord.


## Detailed Explanation

- Introduce and explain new concepts.
- It should be reasonably clear how the proposal would be implemented.
- Provide representative examples that show how this proposal would be commonly used.
- Corner cases should be dissected by example.

Terms
EIRP
LNS
LUT
dBm
dBi
dc

Each hotspot on the Helium network transmits a beacon every six hours or 4 times per day. Every hotspot that witnesses this beacon will report their data, proving functional coverage information of the network. By altering some standard parameters of the transmitted beacon more information and value can be obtained from the same procedure.  

### Transmit Power
Each hotspot is capable of transmitting at a variable rate over a limited power range. The transmit power is requested when the packet is submitted to be sent. The default or maximum EIRP is specified by the (4)LoRaWAN 1.0.4 standard for each region. The hotspots asserted gain is used to keep the transmitted power within regulatory limits.

$EIRP(dBm) <= TransmitPower(dBm) + AntennGain(dBi)$

Default(Max) EIRP is taken from (4)LoRaWAN Regional Parameters 1.0.4. The transmit power must be lowered to keep the EIRP within regulatory limits when paired with a high gain antenna.  

| Region | Max EIRP(dBm) | Notes |
|--------|---------------|-------|
| KR920  | 14            |       |
| AS923  | 16            |       |
| RU864  | 16            |       |
| EU868  | 16            |       |
| IN865  | 30            | 36?   |
| US915  | 30            | 36?   |
| AU915  | 30            | 36?   |

As an alternative to always transmitting at the maximum permitted value it is suggested that a random selection is made from a subset of allowable transmit powers. The large spread in allowable power across regions makes it difficult to implement one general set of transmit powers. Differentiating power-level selection by regions allows POC to be 'balanced' across regions. This hip does not attempt to address any possible imbalance in the current poc system which is outside the scope, however, this mechanism could be used to adjust any imbalance in the future. These suggested values keep status quo with today and do not introduce any change across regions:

AU915, US915, IN865:

$`\{MaxEIRP,\ MaxEIRP*0.8 dBm,\ MaxEIRP*0.6 dBm\}`$

KR920, AS923, RU864, EU868 regions set of power values. The duplicate 3rd value is intentionally left to make comparison to the fixed channel plans easier:

$`\{MaxEIRP,\ MaxEIRP*0.8 dBm,\ MaxEIRP*0.8 dBm\}`$

A selection is made between full power or one of the reduced values. MaxEIRP minus 3dBm will cut the transmit power in half and minus 6dBm will be a quarter of the total power. Using inverse square law the estimated range will roughly double with a change of 6dBm.

Suggested set of EIRP values for each region:

| Region | EIRP Values(dBm) | Notes |
|--------|------------------|-------|
| KR920  | 14, 11, 11       |       |
| AS923  | 16, 13, 13       |       |
| RU864  | 16, 13, 13       |       |
| EU868  | 16, 13, 13       |       |
| IN865  | 30, 22, 16       | 36?   |
| US915  | 30, 22, 16       | 36?   |
| AU915  | 30, 22, 16       | 36?   |

To enhance the detail and accuracy of the coverage map, we propose introducing variable transmit power for beacons. By randomly adjusting the transmit power at each spreading factor, we can generate a comprehensive map that more accurately reflects the network’s capabilities.

Questions

High gain antenna in EU may not be able to be reduced a further 6dbm
Does tx power have to be even?
What is the minimum/max tx power used?
Why do we use 36 in north america?

### Spreading Factor(Datarate)

The spreading factor (SF) in LoRa determines the number of chirps (symbol) used to encode a bit of information. A higher spreading factor increases the number of chirps per bit, which makes the signal take longer to transmit but increases its resilience to noise and increases range. Further detail is beyond the scope of this document but the performance improvements have been shown to the minimum sensitivity:

Sensitivity improvements take from (3)Semtech AN1200.22:


| Mode  | Bit Rate(kb/s) | 	Sensitivity(dBm) | Symbol Time(ms) | US915 Max Packet Size(bytes) |
|-------|----------------|-------------------|-----------------|------------------------------|
| FSK   | 1.2            | -122	             |                 | -                            |
| SF12	 | 0.293	         | -137              | 	32.768         | -                            |
| SF11	 | 0.537	         | -134.5            | 	16.384         | -                            |
| SF10	 | 0.976	         | -132	             | 8.192           | 19                           |
| SF9	  | 1.757	         | -129	             | 4.096           | 61                           |
| SF8	  | 3.125	         | -126	             | 2.048           | 133                          |
| SF7	  | 5.468	         | -123	             | 1.024           | 230                          |

Regulatory constraints in the US915 region, which have a maximum dwell time of 400ms, restrict the use of spreading factors above SF9 for 52-byte packets. In contrast, the EU868 region can utilize SF12 but are limited in the EIRP. By randomly selecting the data rate, the proposed change is expected to reduce overall PoC airtime by 38% in US915(SF7,SF8,SF9) and 57% in EU868(SF7,SF10,SF12).

The following table, based on calculations from this airtime calculator, illustrates the potential reductions in on-air time across different configurations:

Airtime taken from (2)https://avbentem.github.io/airtime-calculator/



| Region | Spreading Factor | Datarate(bps) | Packet Length (bytes) | On-Air Time(ms) | Max EIRP | Notes                             |
|--------|------------------|---------------|-----------------------|-----------------|----------|-----------------------------------|
| US915  | SF7              | 5470          | 52                    | 103             | 36       | 30?                               |
| US915  | SF8              | 3125          | 52                    | 185             | 36       | 30?                               |
| US915  | SF9              | 1760          | 52                    | 329             | 36       | Current POC Beacon                |
| US915  | SF10             | 980           | 52                    | 616             | 36       | Dwell time exceeded(Max 25-bytes) |
| EU868  | SF7              | 5470          | 52                    | 103             | 16       |                                   |
| EU868  | SF8              | 3125          | 52                    | 185             | 16       |                                   |
| EU868  | SF9              | 1760          | 52                    | 329             | 16       |                                   |
| EU868  | SF10             | 980           | 52                    | 616             | 16       |                                   |
| EU868  | SF11             | 440           | 52                    | 1315            | 16       |                                   |
| EU868  | SF12             | 250           | 52                    | 2466            | 16       | Current POC Beacon                |


Enabling higher data rates on the network allows battery-powered LoRaWAN sensors to extend their battery life by transmitting data more quickly, which reduces transmitter on-time and consequently lowers system noise and collision risks. However, these higher data rates reduce transmission range, making it essential to accurately understand and map the network's coverage capabilities.



Questions
The maximum packet size M was take from 1.0.4 of the regional parameters. I need to double check whether this includes the LoRaWAN headers. If it doesn't this value may be increased as the beacon format does not require LoRaWAN headers.

### Beacon Packet Length

The current packet length of the PoC beacon is 52 bytes. This length comes from legacy data included during targeted proof of coverage. The longer the packet the higher a chance of interference and packet loss(1). Using a variable packet length for POC will further help to understands the networks capability. 

If the beacon packet length can be reduced from 52-bytes and made variable ideally it would be multiples of 24-bytes or 1dc. If it could be reduced to 19-bytes SF10 could be utilized in US915 while still respecting the 400ms dwell time.


### Entropy

The random values will be selected based off...


### Beacon Creation Algorithm

Each parameter will be independent of each other when creating the beacon. This will allow a random selection of Datarate, Transmit Power and Packet Length without worrying that certain combinations of parameters are not compatible. eg. All packet length and datarate combinations will respect the 400ms dwell time. 

The will allow a very simple random selection of Datarate, Transmit Power and Packet Length to create the beacon.

## Drawbacks

- Why should we _not_ do this?
- What problems could occur if we do this?

One reason to not do this is the increased complexity in PoC challenge. There is some thought that will need to be put into transmit power capabilities, limitations and resolutions. 

There will be a slight shuffling of rewards as beacons of random varying capability make their way through the system. On average it is expected to work out very closely to current state.

The number of witnesses will be more variable per packet. Therefore earnings will be more variable from beacon to beacon.  

## Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design space. This is probably the most important section!

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?

This design was chosen for its potential to enhance network integrity and mapping measurement accuracy. It also utilizes existing mechanisms to gain more quality data without altering the POC mechanism.


Alternative designs include adjusting some subset of the parameters discussed above. eg. dynamic spreading factor but do not vary transmit power. These do not offer the same level of unpredictability as varying all three parameters.

Other discussions of dual beacons from neighboring hotspots with a time sync method. This HIP does not exclude this addition in the future if deemed valuable.

One alternative method sends multiple beacons within a very short interval. This would remove any long-term variation due to weather or other external factors but would require the beacons to be grouped instead of evenly spaced. This would further aggravate the lumpiness that may be introduced to earnings with dynamic beacons.


## Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?
- Are there dependencies, milestones, or dates that need to be met for this HIP to succeed?

- Exact methods for deriving parameters from blockchain entropy need refinement.
- Impact assessment on existing hotspots and any required updates.
- POC equalization across regions. Suggestions have been made to reduce the maximum EIRP for US915 to 22dBm. This hip does not try to equalize the existing poc rewards across regions but only keep the status quo.

## Deployment Impact

Describe how this design will be deployed and any potential impact it may have on current users of
this project.

- How will current users be impacted?
- How will existing documentation/knowledge base need to be supported? Any content to change at
  <http://docs.helium.com>?
- Is this backwards compatible? Can this HIP be undone?
  - If not, what is the procedure to migrate?

- Documentation on docs.helium.com will need updates to reflect new PoC operation.
- Code needs to be updated to select and request random values.

There is the potential for the power control to not work as expected across different hotspots and manufacturers. It is up to the hotspot manufacturer to ensure the hotspot is transmitting at the proper levels. If the transmit LUT are misconfigured the output power may be incorrect causing confusing PoC data.

Current beacons, configured for maximum range, will still be send but at a less frequent interval. Users may notice less witnesses while sending beacons of a higher datarate or lower power. In some cases these beacons may not cover as large a footprint but still contains valuable data or its capability

Comparison of potential beacon combinations compared to maximum of today. The Delta dB shows the difference from today's current POC beacon accounting for spreading factor and transmit power with the values suggested in the sections above:

EU868

| Spreading Factor | Transmit Power(dBm) | Packet Size | Delta dB | Notes          |
|------------------|---------------------|-------------|----------|----------------|
| SF12             | 16                  | 52          | 0        | Current Beacon |
| SF10             | 16                  | 52          | -5       |                |
| SF7              | 16                  | 52          | -14      |                |
| SF12             | 13                  | 52          | -3       |                |
| SF10             | 13                  | 52          | -8       |                |
| SF7              | 13                  | 52          | -17      |                |
| SF12             | 13                  | 52          | -3       |                |
| SF10             | 13                  | 52          | -8       |                |
| SF7              | 13                  | 52          | -17      |                |


US915

| Spreading Factor | Transmit Power(dBm) | Packet Size | Delta dB | Notes          |
|------------------|---------------------|-------------|----------|----------------|
| SF9              | 27                  | 52          | 0        | Current Beacon |
| SF8              | 27                  | 52          | -3       |                |
| SF7              | 27                  | 52          | -6       |                |
| SF9              | 22                  | 52          | -5       |                |
| SF8              | 22                  | 52          | -8       |                |
| SF7              | 22                  | 52          | -11      |                |
| SF9              | 16                  | 52          | -11      |                |
| SF8              | 16                  | 52          | -14      |                |
| SF7              | 16                  | 52          | -17      |                |

![image](https://github.com/gradoj/HIPS/assets/7544765/5bbe60eb-953f-4c91-aae1-c333c32dcf5c)

## Success Metrics

What metrics can be used to measure the success of this design? Are any new ETL reports needed to
measure the success?

- What should we measure to prove a performance increase?
- What should we measure to prove an improvement in stability?
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by its users?


Reducing the beacons from the current maximums will reduce the on-air time on average. This will reduce interference and packet collision. This may not be important in sparely populated areas but in dense deployments the PoC airtime from all hotspots within range could significantly degrade the channel.

Visualization of PoC coverage could include multiple layers for capability. Feedback from the community on improved coverage maps would be expected.

The variable transmit power will most likely help to detected gaming or manipulation incidents. It will also make gaming 0dB antenna less effective. Finding the right distance apart will be more difficult as the packet strengths will vary and they are using noise and near-field effects versus propagation. 

## Referenced Documents

1. https://www.researchgate.net/publication/362115325_On_the_Performances_of_Packet_Error_Rate_for_LoRa_Networks
2. https://avbentem.github.io/airtime-calculator/
3. https://www.frugalprototype.com/wp-content/uploads/2016/08/an1200.22.pdf
4. https://resources.lora-alliance.org/technical-specifications/rp002-1-0-4-regional-parameters
5. https://semtech.my.salesforce.com/sfc/p/E0000000JelG/a/2R000000HSSa/nimci8O3XiFeGQpltq_YTbps18CSIaKKgMfssp5VWwE
6. 
