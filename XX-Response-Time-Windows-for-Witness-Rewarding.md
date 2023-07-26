# HIP XX: Response Time Windows for Witness Rewarding

- Author: @disk91, @jmarcelino
- Start Date: 2023/07/20
- Category: Economic, Technical
- Tracking issue:
- Voting Requirements: veIoT Holders

# Summary 

Currently the Proof-of-Coverage Oracles rewards the 14 first hotspots reporting a witness. This rewards 
the fastest hotspots, incentivizing fiber backhauls and specific hardware models that happen to be able 
to produce fast signatures. The result is that the same hotspots are selected, making others unviable 
even if they provide unique and useful coverage for the network. In other words, punishes hotspots for 
falling short of millisecond optimizations when the LoRaWAN protocol functions to the order of seconds. 
A hotspot’s utility in providing LoRaWAN coverage is based on measuring “good enough” response times, not 
absolute fastest as absolute speeds provides no marginal utility, Uplink does not have a particular time-window, 
donwlink time windows is up to 2 seconds, Join process up to 6 seconds.

This HIP proposes to restore random hotspot selection but adding a response time window to eliminate only 
slow hotspots that fail to meet LoRaWAN-grade timing constraints and push helium hotspots to improve their reponse time
over time reasonibly. 

# Motivation

The LoRaWAN network has some timing constraints to be considered, these ones are related to the JOIN mechanism 
and ACK/Downlink mechanism. JOIN requires a full loop within 5 seconds, up to 6. ACK/Downlink requires a full loop in 1 
second for RX1 window, up to 2 seconds for RX2 windows. Out of this time frame, the response will be ignored by the devices.  [Appendix](#packet-processing-and-lorawan-time-constraints) gives the consequence of these constraints on the expected hotspot response time.

LoRaWAN is a question of seconds, not a question of microseconds, this is why creating a competition between hotspots and network connectivity at a millisecond scale is not achieving any network goal.

Hotspots with highly valuable locations, such as the mountaintops, cell towers, and even rooftops 
sometimes rely on higher latency connectivity (4G/5G, Home Plug, Satellites) which adds anywhere from 
10ms to 100ms. These hotspots generally have a higher operating cost and are unfairly impacted by the 
current selection algorithm as they still operate within LoRaWAN timing specifications. 
See [appendix](#highly-valuable-coverage) about highly valuable coverage.

Hotspot out of the city centers will get a slower Internet response time from the one in the city center, 
even with fast Internet access, due to some extra network hops or downgraded connectivity technology like xDSL.
See [Appendix](#suburb-valuable-coverage) about suburb valuable coverage.

Hotspot with the worst locations, indoor, in the city center, gets the best response time experience 
with direct fiber connectivity.

We have seen that depending on the hardware of the hotspot, the Witness processing time is largely dependent 
on the packet signature as described in the [appendix](#ecc-signature-impact). As the signature is delegated to an hardware 
ECC chip for most of the deployed hotspot, the processing time depends on the hardware solution soldered. 
Even if firmware can be improved, the current solution disqualifies certain hardware whatever is the hotspot owner's efforts. 

More generally speaking, it disqualifies lower-end hardware like light-hotspots based on micro-controllers as, by definition, their capacity to process the same thing than an hotspot based on CPU is lower. This is nonsense as these hardware have a 
better fit for stability, long-life, energy saving, lower cost, and should be privileged long term.

The Peoples Network must be accessible to anyone and not be a competition of miliseconds optimization limited to a 
small group of experts.

The witness response time is not representative of the data packet processing. Witness response time does not have any 
constraint of time. Witnesses are processed by Oracle, and response time depends on the Oracle localization, 
associated with the network path to reach that Oracle. It totally differ from the LNS network path.
Response time can differ from a Witness to another Witness, the absolute response time is not a good way to measure a performance responding to the LoRaWAN timing constraints. The [Witness process](#witness-processing-waterfall) and the [Packet process](#packet-processing-waterfall) are detailed in the respective appendixes.

As for a given witness, the Hotspots from a similar area will report it to the same Oracle, we can consider a response 
time window starting from the first witness received by the Oracle as a viable solution to eliminate the variable offset 
timing and to eliminate hotspot that are really slower and can cause a problem for data processing.

# Rationale and Alternatives

This HIP proposes to select a valid witness from the ones arriving in a time window of MAX_WITNESS_WAIT_WINDOW_MS starting 
from the first received witness by the Oracle. 

The MAX_WITNESS_WAIT_WINDOWS_MS parameter will be initially set to 200ms and could be later adjusted from 100ms to 300ms 
by Helium Foundation to optimize the network quality without a need for a new vote. The purpose of this adjustement is to push 
hardware manufacturers to optimize their solutions in a scheduled way. The initial 200ms take into consideration the ECC 
signature and radio backhaul normal impact vs DiY. 

This means: 
1. Different hotspots receive a beacon and send the witness information to the related Oracle
2. The Oracle receives the first witness notification and opens a witness reception window for MAX_WITNESS_WAIT_WINDOWS_MS
milliseconds. Witness is marked valid.
3. The Oracle receives the next witnesses during the MAX_WITNESS_WAIT_WINDOWS_MS ms and mark them valid.
4. The Oracle receives the next witnesses after the MAX_WITNESS_WAIT_WINDOWS_MS ms time window and marks them invalid.
5. The Oracle selects 14 of the valid witnesses randomly to be rewarded.

# Unresolved Questions

- Packet processing is currently involving signature from ECC fro every packet, this is time costly and not mandatory.
Some discussions are already opened to move this with a software signature from an ECC derivated key negotiated with Helium
Packet Router for a given period of time.


# Deployment Impact
Oracle PoC rewarding code needs to be modified to take this into consideration. Deployment is global, Hotspots are not impacted.

# Success Metrics

# Appendix

## Highly Valuable Coverage

Some of the hotspot have a really large coverage by being installed in really good / high location. These hotspots, due to the 
geographical location and the height are covering wide zone, larger than the city. That way, they are offering a uniq coverage. The following picture is illustrating this: the blue area is representing the coverage offered by this sigle hotspot, the orange 
represent the city coverage provided by the mass of the other hotspot in the same area. All these hotspots are in competition for the same witness.

![Highly valuable coverage illustration](XX-response-time-windows-for-witness-rewarding/valuable-coverage.png)

This illustration is based on a real exemple, but is a general illustration for hotspot placed on cell-towers and high elevation point. The hotspot used in the illustration as model is Attractive-Olive-Cybord, located in Clermont-Ferrand, France. This hotspot is deployed on high elevation point. Coverage can be seen on mappers.helium.com, with 80km coverage from North to South. 

## Suburb Valuable Coverage



## Packet Processing and LoRaWan time constraints

## ECC Signature impact

The ECC Signature process is having a significant impact on the overall processing, some measure have been conducted by 
community members like Miroslav (heliootics) & co, Jose Marcelino, using the gateway-mfr-rs test kit. For the tested hotspot provider we can the following average signature time:

| Manufacturer Brand | Model | Avg Signature Time | Note |
| ------------------ | ----- | ------------------ | ---- |
| Calchip v1         |        | ?  | no ECC |
| DiY                | x86    | ?  | no ECC |
| DiY                | RPI 4  | ?  | no ECC |
| Bobcat             | RK3566 | 105 ms | |
| Milesight          |        | 105 ms | |
| Nebra       | indoor CM3 v1 | 113 ms | |
| Synchrobit            | CM4 | 120 ms | |
| Cotx                   | X3 | 130 ms | |
| Heltec           | HT-M2808 | 135 ms | |
| Bobcat             | Others | 150 ms | |
| Linxdot                  |  | 152 ms | |
| Dusun                    |  | 154 ms | |
| Nebra       | indoor CM3 v2 | 157 ms | |
| RAK / MNTD           | Gold | 165 ms | |
| RAK / MNTD          | Black | 174 ms | |
| Pycom               | Other | 175 ms | |
| Sensecap               | M1 | 175 ms | |
| PantherX1                |  | 179 ms | |
| Pisces                   |  | 180 ms | |
| Controllino              |  | 180 ms | |
| Heltec              | Other | 242 ms | |

The signature impact on the first to arrive show a variability up to 250ms. ( to be completed with the non ECC device data later one)


## Packet Processing Waterfall

## Witness Processing Waterfall




