# HIP 92: Response Time Windows for Witness Rewarding

- Author: @disk91, @jmarcelino
- Start Date: 2023/07/20
- Category: Economic, Technical
- Tracking issue:
- Voting Requirements: veIoT Holders

# Summary 

Currently the Proof-of-Coverage Oracles rewards the 14 first hotspots reporting a witness. This rewards 
the fastest hotspots, incentivizing  fiber backhauls and specific hardware models that happen to be able 
to produce fast signatures.  The result is that the same hotspots are selected, making others unviable 
even if they provide unique and useful coverage for the network. In other words, punishes hotspots for 
falling short of millisecond optimizations when the LoRaWAN protocol functions to the order of seconds. 
A hotspot’s utility in providing LoRaWAN coverage is based on measuring “good enough” response times, not 
absolute fastest as absolute speeds provides no marginal utility. 

This HIP proposes to restore random hotspot selection but adding a response time window to eliminate only 
slow hotspots that fail to meet LoRaWAN-grade timing constraints.

# Motivation

The LoRaWAN network has some timing constraints to be considered, these ones are related to the JOIN mechanism 
and ACK/Downlink mechanism. JOIN requires a full loop within 5 seconds, ACK/Downlink requires a full loop in 1 
second for RX1 window. Out of this time frame, the response will be ignored by the devices. LoRaWAN is a question 
of seconds, not a question of microseconds, this is why creating a competition between hotspots and network 
connectivity at a millisecond scale is not achieving any network goal.

Hotspots with highly valuable locations, such as the mountaintops, cell towers, and even rooftops 
sometimes rely on higher latency connectivity (4G/5G, Home Plug, Satellites) which adds anywhere from 
10ms to 100ms. These hotspots generally have a higher operating cost and are unfairly impacted by the 
current selection algorithm as they still operate within LoRaWAN timing specifications.

Hotspot out of the city centers will get a slower Internet response time from the one in the city center, 
even with fast Internet access, due to some extra network hops.

Hotspot with the worst locations, indoor, in the city center, gets the best response time experience 
with direct fiber connectivity.

We have seen that depending on the hardware of the hotspot, the Witness processing time is largely dependent 
on the packet signature. As the signature is delegated to an hardware ECC chip for most of the deployed hotspot, 
the processing time depends on the hardware solution soldered. Even if firmware can be improved, the current solution 
disqualifies certain hardware whatever is the hotspot owner's efforts.  More generally speaking, it disqualifies 
lower-end hardware like light-hotspots based on micro-controllers. This is nonsense as these hardware have a better 
fit for stability, long-life, energy saving, lower cost, and should be privileged.
The Peoples Network must be accessible to anyone and not be a competition of micro-seconds optimization limited to a 
small group of experts.

The witness response time is not representative of the data packet processing. Witness response time does not have any 
constraint of time. Witnesses are processed by Oracle, and response time depends on the Oracle localization, 
associated with the network path to reach that Oracle. Response time can differ from a Witness to another Witness, 
the absolute response time is not a good way to measure a performance responding to the LoRaWAN timing constraints.

As for a given witness, the Hotspots from a similar area will report it to the same Oracle, we can consider a response 
time window starting from the first witness received by the Oracle as a viable solution to eliminate the variable offset 
timing and to eliminate hotspot that are really slower and can cause a problem for data processing.

# Detailed Explanation

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
