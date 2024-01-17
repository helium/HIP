# HIP 94: Response Time Windows for Witness Rewarding

- Author(s): [@disk91](https://github.com/disk91), [@jmarcelino](https://github.com/jmarcelino)
- Start Date: 2023-07-20
- Category: Economic, Technical
- Original HIP PR: [#749](https://github.com/helium/HIP/pull/749)
- Tracking issue: [#764](https://github.com/helium/HIP/issues/764)
- Voting Requirements: veIOT Holders

# Summary

Currently, the Proof-of-Coverage Oracles reward the 14 first hotspots (defined in _default_max_witnesses_per_poc_ ) reporting a witness. This rewards the fastest hotspots, incentivizing fiber backhauls and specific hardware models that happen to be able to produce fast signatures. The result is that always the same hotspots are selected, making others not viable even if they provide unique and useful coverage for the network. In other words, it punishes hotspots for falling short of millisecond optimizations when the LoRaWAN protocol functions to the order of seconds - [see also](#rewarded-hotspots-for-witnesses).
But a hotspot’s utility in providing LoRaWAN coverage depends on having “good enough” response times, not on being amongst the absolute fastest as absolute speeds provide no marginal utility: the Uplink does not have a particular time-window, the Downlink time windows is up to 2 seconds, and the Join process up to 6 seconds.

We see a continuous decrease of the number of [hotspots not participating to PoC anymore](#network-hotspot-loss-acceleration) over time, 41K (10%) are not seen anymore since August 15th compared to July 1st. The situations that is excluding or unequally rewarding a hotspot, when providing a valuable coverage, does not help is stabilize the number of active hotspots over time.

This HIP proposes to evolve the hotspot selection by adding a response time window

- to eliminate only slow hotspots that fail to meet LoRaWAN-grade timing constraints
- to push helium hotspots to improve their response time, over time, reasonably.

# Motivation

The LoRaWAN network has some timing constraints to be considered. They are related to the JOIN mechanism
and the ACK/Downlink mechanism. JOIN requires a full loop within 5 seconds, up to 6 seconds. ACK/Downlink requires a full loop in 1
second for RX1 windows, up to 2 seconds for RX2 windows. Out of this time frame, the response will be ignored by the sensor devices. [Appendix](#packet-processing-and-lorawan-time-constraints) gives the consequence of these constraints on the expected hotspot response time.

LoRaWAN is a question of seconds ($`10^0s`$ to $`10^{-1}s`$), not a question of microseconds ($`10^{-6}s`$), this is why creating a competition between hotspots and network connectivity at a millisecond ($`10^{-3}s`$) scale is not achieving any network goal.

Hotspots with highly valuable locations, such as the mountaintops, cell towers, and even rooftops
sometimes rely on higher latency connectivity (4G/5G, Home Plug, Satellites) which adds anywhere from
10ms to 100ms. These hotspots generally have a higher operating cost due to dedicated connectivity and hosting cost. They are unfairly impacted by the current selection algorithm as they still operate within LoRaWAN timing specifications.
See [appendix](#highly-valuable-coverage) about highly valuable coverage.

Hotspots located out of city centers will get a slower Internet response time from the one in the city center,
even with fast Internet access, due to some extra network hops or downgraded connectivity technology like xDSL.
See [Appendix](#suburb-valuable-coverage) about suburb valuable coverage.

Hotspots with the worst locations, indoor, in the city center, can get the best response time experience
with direct fiber connectivity.

We have seen that depending on the hardware of the hotspot, the Witness processing time is largely dependent
on the packet signature as described in the [appendix](#ecc-signature-impact). As the signature is delegated to the hardware
ECC chip for most of the deployed hotspots, the processing time depends on the [hardware solution](#mcu-performance-impact) soldered in.
Even if firmware can be improved, the current solution disqualifies certain hardware no matter the hotspot owner's efforts.

More generally speaking, it disqualifies lower-end hardware like light-hotspots based on microcontrollers as, by definition, their capacity to process the same thing as hotspots based on CPU [is lower](#mcu-performance-impact). This is a highly disadvantageous consequence as this hardware has a better fit for stability, long-life, energy saving, lower cost, and should be privileged long term.

The People's Network must be accessible to anyone and not be a competition of millisecond optimization limited to a
small group of experts.

The witness response time is not representative of the data packet processing. Witness response time does not have any
constraint of time. Witnesses are processed by Oracles, and response time depends on the Oracle localization,
associated with the network path to reach that Oracle. It is totally different from the LNS network path taken by sensors.
Response time can differ from one Witness to another Witness, the absolute response time is not a good way to measure a performance responding to the LoRaWAN timing constraints. The [Witness process](#witness-processing-waterfall) and the [Packet process](#packet-processing-waterfall) are detailed in the respective appendixes.

As for a given witness, the Hotspots from a similar area will report it to the same Oracle. We can consider a response
time window starting from the first witness received by the Oracle as a viable solution to eliminate the variable offset
timing and to eliminate those hotspots that are really slower and can cause a problem for data processing.

# Stakeholders

This HIP potentially affects the earnings of all hotspot owners: It positively benefits hotspot owners negatively affected by HIP-83, whose hotspots due to configuration or vendor are the slowest to respond and received less witness rewards.
It negatively affects hotspot owners positively affected by HIP-83, whose hotspots due to being the fastest to respond always got selected for witness rewards.
It positively affects hotspot vendor designs that were slower than other hotspot vendor designs but still within LoRaWAN specifications.
Nova Labs is the entity requested to implement the changes in the HIP.

# Rationale and Alternatives

This HIP proposes to select a valid witness from the ones arriving in a time window of MAX_WITNESS_WAIT_WINDOW_MS starting
from the first received witness by the Oracle.

The MAX_WITNESS_WAIT_WINDOWS_MS parameter will be initially set to 200ms (0.2 seconds), accordingly to the calculation described in [appendix](#packet-processing-waterfall).
It could be later adjusted from 100ms to 300ms by Helium Foundation to optimize the network quality without a need for a new
vote. The purpose of this adjustment is to push hardware manufacturers to optimize their solutions in a scheduled way. The initial 200ms take into consideration the ECC signature and radio backhaul normal impact vs DiY in the LoRaWan constraints.

When less than **default_max_witnesses_per_poc** Witnesses (Currently 14) have been received within the MAX_WITNESS_WAIT_WINDOWS_MS, the Oracle accepts Witnesses up to EXTENDED_WITNESS_WAIT_WINDOWS_MS, fixed at 500ms, the acceptable wait time for RX1 windows for regional traffic. This will allow slower responding hotspots to be accepted in the low density areas when in high density the constraint is stronger. The current situation, with HIP-83, is accepting witness without limit of time in a such case, even if the time makes no LoRaWAN downlink & join possible.

This means:

1. Different hotspots receive a beacon and send the witness information to the related Oracle
2. The Oracle receives the first witness notification and opens a witness reception window for MAX_WITNESS_WAIT_WINDOWS_MS
   milliseconds. Witness is marked Valid.
3. The Oracle receives the next witnesses during the MAX_WITNESS_WAIT_WINDOWS_MS ms and mark them Valid.
4. When **default_max_witnesses_per_poc** or more have been received, it marks the other as Invalid
5. When MAX_WITNESS_WAIT_WINDOWS_MS is over and less than **default_max_witnesses_per_poc** received, Oracle marks the first received as selected and waits until **default_max_witnesses_per_poc** or EXTENDED_WITNESS_WAIT_WINDOWS_MS, mark them as valid, then the others invalid.
6. The Oracle selects all the **selected** witnesses and allocates rewards to the number of hotspots defined in **default_max_witnesses_per_poc** by selecting randomly from the ones marked as valid.

### Example 1

8 witnesses received:

- 4 within MAX_WITNESS_WAIT_WINDOWS_MS 200ms
- 3 within EXTENDED_WITNESS_WAIT_WINDOWS_MS 200-500ms
- 1 outside EXTENDED_WITNESS_WAIT_WINDOWS_MS 500ms

The first 4 are marked as SELECTED, the 3 next are marked as VALID, the last one is marked as INVALID. Oracle rewards all the one marked as SELECTED, it can select 10 more randomly as part of the ones marked as VALID, so it reward all of them. The last one is not rewarded. Assuming **default_max_witnesses_per_poc** is 14

### Example 2

25 witnesses received:

- 20 within MAX_WITNESS_WAIT_WINDOWS_MS 200ms
- 4 within EXTENDED_WITNESS_WAIT_WINDOWS_MS 200-500ms
- 1 outside EXTENDED_WITNESS_WAIT_WINDOWS_MS 500ms

Only the first 20 within MAX_WITNESS_WAIT_WINDOWS_MS will be selected and marked as VALID, all the others are INVALID and won't be part of the reward calculation. The Oracle will randomly select 14 of the 20 VALID witness and reward them. Assuming **default_max_witnesses_per_poc** is 14

### Example 3

25 witnesses received:

- 10 within MAX_WITNESS_WAIT_WINDOWS_MS 200ms
- 8 within EXTENDED_WITNESS_WAIT_WINDOWS_MS 200-500ms
- 7 outside EXTENDED_WITNESS_WAIT_WINDOWS_MS 500ms

The first 10 are marked as SELECTED, the next 8 are marked as VALID, the 7 others are marked as INVALID. Oracle will reward all the SELECTED, then will randomly choose 6 (14-8) of the 8 witnesses marked as VALID and reward them. Assuming **default_max_witnesses_per_poc** is 14

** Alternate Proposal **

This HIP proposes to select **all witness** arriving in a time window of MAX_WITNESS_WAIT_WINDOW_MS starting
from the first received witness by the Oracle.

The MAX_WITNESS_WAIT_WINDOWS_MS parameter will be initially set to 200ms (0.2 seconds), accordingly to the calculation described in [appendix](#packet-processing-waterfall).  
It could be later adjusted from 100ms to 300ms by Helium Foundation to optimize the network quality without a need for a new
vote. The purpose of this adjustment is to push hardware manufacturers to optimize their solutions in a scheduled way. The initial 200ms take into consideration the ECC signature and radio backhaul normal impact vs DiY in the LoRaWan constraints.

When less than 5 Witnesses have been received within the MAX_WITNESS_WAIT_WINDOWS_MS, the Oracle accepts Witnesses, with a maximum ot 5 total, up to EXTENDED_WITNESS_WAIT_WINDOWS_MS, fixed at 500ms, the acceptable wait time for RX1 windows for regional traffic. This will allow slower hotspots to be accepted in the low density area when in high density the constraint is stronger. This allows to have satellite backhaul in low density areas. The current situation, with HIP-83, is accepting witness without limit of time in a such case, even if the time makes no LoRaWAN downlink & join possible.

This means:

1. Different hotspots receive a beacon and send the witness information to the related Oracle
2. The Oracle receives the first witness notification and opens a witness reception window for MAX_WITNESS_WAIT_WINDOWS_MS
   milliseconds. Witness is marked SELECTED.
3. The Oracle receives the next witnesses during the MAX_WITNESS_WAIT_WINDOWS_MS ms and mark them SELECTED.
4. When 5 or more have been received, it marks the other as INVALID
5. When MAX_WITNESS_WAIT_WINDOWS_MS is over and less than 5 received, Oracle marks the next SELECTED until EXTENDED_WITNESS_WAIT_WINDOWS_MS with a maximum of 5 witnesses total, next are marked INVALID.
6. The Oracle selects all the **SELECTED** witnesses to be rewarded.

### Example 1

25 witnesses received:

- 20 within MAX_WITNESS_WAIT_WINDOWS_MS 200ms
- 4 within EXTENDED_WITNESS_WAIT_WINDOWS_MS 200-500ms
- 1 outside EXTENDED_WITNESS_WAIT_WINDOWS_MS 500ms

Only the first 20 within MAX_WITNESS_WAIT_WINDOWS_MS will be selected and marked as SELECTED, all the others are INVALID and won't be part of the reward calculation. The Oracle will reward all the SELECTED witnesses.

### Example 2

25 witnesses received:

- 10 within MAX_WITNESS_WAIT_WINDOWS_MS 200ms
- 8 within EXTENDED_WITNESS_WAIT_WINDOWS_MS 200-500ms
- 7 outside EXTENDED_WITNESS_WAIT_WINDOWS_MS 500ms

The first 10 are marked as SELECTED, the next 8 are marked as INVALID, the 7 others are marked as INVALID. Oracle will reward all the SELECTED and reward them.

### Example 3

8 witnesses received:

- 4 within MAX_WITNESS_WAIT_WINDOWS_MS 200ms
- 3 within EXTENDED_WITNESS_WAIT_WINDOWS_MS 200-500ms
- 1 outside EXTENDED_WITNESS_WAIT_WINDOWS_MS 500ms

The first 4 are marked as SELECTED, the first 1 of the next 3 is marked as SELECTED, the 2 next of 3 within EXTENDED_WITNESS_WAIT_WINDOWS_MS and the one out of WINDOWS are marked as INVALID. Oracle rewards all the one marked as SELECTED. The last 3 are not rewarded.

** Option on proposal **

Community discussions proposes to keep an incentive on hotspot response time performance by getting a better reward distribution to the first responding and a lower to the last responding. This will be detailed if a later discussion comes to the selection of this option.
The way it would work would basically be like:

- in first alternative: select the 7 (50% of the **default_max_witnesses_per_poc**) first responding hotspots then randomly select the 7 others ( 50% of the **default_max_witnesses_per_poc**)
- in the second alternative: distribute 40% of the reward to the fastest 20%, 40% to the next 60%, 20% to the last 40%.

Positive impact:

- Reduce the impact of the reward calculation change for the one having a benefit of HIP-83.
- Continue to incentive hardware provider optimization
- Continue to incentive faster connectivity

Negative impact:

- This option add complexity in the development.
- Continue to have inequity in reward distribution based on your geographical localization.
- Continue to have an inequity between hotspot brands conducting to disconnection.
- Push to hack hotspot to grab some ms and create an inequity in regard of owner technical skills.

# Unresolved Questions

- Packet processing is currently involving signature from ECC for every packet, this is time costly and not mandatory.
  Some discussions are already opened to move this with a software signature from an ECC derived key negotiated with Helium
  Packet Router for a given period of time.

- Witness could be selected also in regard of their location. For example we could get a priority on the witnesses coming from the longest distance to offer an advantage to the hotspot offering the larger coverage.

- There could be some hotspot designs or configurations that always respond over 500ms, these would never be rewarded.

# Deployment Impact

Oracle PoC rewarding code needs to be modified to take this into consideration. Deployment is global, Hotspots are not impacted.
The Oracle PoC code update will impact the Nova team for deployment, the Author of this HIP is not attaching any code.

# Success Metrics

- The distribution of rewards is no longer a function of the hotspot manufacturer design
- Hotpots with large coverage get balanced rewards
- The decrease of active hotspots is slowing down
- The average response time to witness is improved over time

# Appendix

## Highly Valuable Coverage

Some of the hotspot have a really large coverage by being installed in really good / high location. These hotspots, due to the
geographical location and the height are covering a wide zone, larger than a city. That way, they are offering a unique coverage. The following picture is illustrating this: the blue area is representing the coverage offered by this single hotspot, the orange
represent the city coverage provided by the mass of the other hotspot in the same area. All these hotspots are in competition for the same witness.

![Highly valuable coverage illustration](files/0094/valuable-coverage.png)

This illustration is based on a real example, but is a general illustration for hotspot placed on cell-towers and high elevation point. The hotspot used in the illustration as model is Attractive-Olive-Cyborg, located in Clermont-Ferrand, France. This hotspot is deployed on high elevation point. Coverage can be seen on [mappers.helium.com](https://mappers.helium.com/uplinks/hex/891f96a85b3ffff), with 80km coverage from North to South.

In terms of coverage comparison, a 60km reach hotspot provides 36x the area coverage a 10km reach hotspot can provide. It provides about 3600x coverage compared to an indoor, city center located hotspot.

This HIP does not propose to give these hotspots any advantages, the existing POC mechanisms already manage this. This HIP attempts to remove the penalty these important hotspots are currently suffering due to HIP-83.

## Suburb Valuable Coverage

The hotspots located in suburb and above, in blue in the illustration, are expending the network coverage with unique
coverage zone and are in competition with the hotspot inside the city.

![Suburb illustration](files/0094/suburb-coverage.png)

Helium network development can be associated to a genetic algorithm growing from an already covered place. These Hotspots also making the link with hotspots out of the city and suburb. They are offering a chance, with their beacon, to isolated hotspots out of the city to participate with PoC.

These hotspots do not get benefit of the fastest Internet connection as their fiber connectivity will pass through the city center to reach the main Internet highways. For most of them the fiber connectivity will not be available, and they are going to rely on xDSL connectivity before reaching the ISPs fiber Internet backhaul.

As these hotspots are participating in PoC with the city center hotspots without getting benefit of the fastest Internet connection, then the chance is they have never been or rarely selected for witness rewards.

This HIP does not propose to give these hotspots any advantages, the existing POC mechanisms already manage this. This HIP attempts to remove the penalty these important hotspots are currently suffering due to HIP-83.

## Packet Processing and LoRaWan time constraints

The Helium Packet Router (HPR) is accepting all the coming packets up to the limit of the max_copies set on the route or eui in
the config service. First come, first paid. Only for roaming the HPR is applying a short time limit.

According to Nova labs response, Helium packets, first arriving is opening a packet session for collecting the copies of it, during the session, all the packets up to max_copies are accepted and transmitted to LNS, after max_copies packets all are discarded. On every 30 minutes the session having an age higher than 30 minutes are closed. This means, a packet can be accepted up to 30 to 60 minutes after being emitted at HPR level.

The time limit for accepting packets as a single group of copies is decided by the LNS after the HPR. This time limit for the LNS is a LNS setup and can vary for each of the LNS. A LNS operating a local fleet will prefer a larger time windows to collect more copies, 600-800ms are viable configurations, global LNS will prefer a shorter time windows (see above waterfall for details).

LoRaWAN time constraints are the following:

- UPLINK first copy arrival has no time constraint, next copies are withing the defined LNS deduplication time windows.
- JOIN REQUEST needs to be responded within 5 seconds for RX1 (same frequency, standard power) or 6 seconds for RX2 (other frequency, potentially higher power). LNS decides of the selection between RX1 and RX2 dynamically, according to the time available.
- DOWNLINK REQUEST / ACK needs to be responded within 1 seconds for RX1 (same frequency, standard power) or 2 seconds for RX2 (other frequency, potentially higher power). LNS decides of the selection between RX1 and RX2 dynamically, according to the time available.

There is no reasons to prefer RX1 vs RX2, most of the implementations try to reach RX1 first, but RX2 provides different advantages, in particular in Europe where the duty cycle on RX2 is better and the higher power makes more chance to reach the device. It also reduces the limited bandwidth usage on the 8 available channels and the risk of collision on these busy channels. Device power impact can be considered higher on RX2 but with a lower risk of collision and reception loss, practically speaking, this assumption is not always true. Selection between RX1 / RX2 is not a question in regard of this HIP. This is informative to
understand that nothing bad in using one vs the other, both have advantages.

Basically, only the DOWNLINK REQ / ACK creates generate a time constraint at the timescale discussed in this HIP. This time constraint is to make sure that the order to send the ACK or the DOWNLINK transfer order comes to the desired Hotspot before the RX2 windows.

In this constraint of time, we need to execute the [full packet processing steps](#packet-processing-waterfall).

Based on this the LNS is able to accept incoming packets in a time windows with a minimal duration of 210ms with a 200ms margin,
so basically up to 350-400ms.

## Network hotspot loss acceleration

The following data, computed on August 27th, gives the number of hotspots having given (witness, beacon, reward) activity at or after the given date. You can read it the following way:

- As seen on August 27th, there was 395717 uniq hotspots having received a witness (valid or not) since July 31st, 402719 having beaconned since July 31st, 395717 having been rewarded for any kind of activities including data reward. The max value of it can be considered as the number of active devices at this date.
- As the data are computed on August 27, the difference between two days is indicating the number of devices not been active on the network for at least a month.
- The reason of this can be denied list (the recent reactivation of the previously denied hostpot had a large impact on these day-to-day data), can be hostpot firmware bug stopping it, can be any local problem owner did not fixed, can be hostpot removal.

| Date       | Hs Witnessing | Hs Beaconing | Hs Rewarded | Hs Active | Hs Disconnected |
| ---------- | ------------- | ------------ | ----------- | --------- | --------------- | ---- |
| 30/06/2023 | 422691        | 428140       | 422691      | 428140    | 5449            | 796  |
| 01/07/2023 | 421811        | 427280       | 421811      | 427280    | 5469            | 860  |
| 02/07/2023 | 420993        | 426464       | 420993      | 426464    | 5471            | 816  |
| 03/07/2023 | 420094        | 425652       | 420094      | 425652    | 5558            | 812  |
| 04/07/2023 | 419239        | 424849       | 419239      | 424849    | 5610            | 803  |
| 05/07/2023 | 418376        | 423994       | 418376      | 423994    | 5618            | 855  |
| 06/07/2023 | 417483        | 423052       | 417483      | 423052    | 5569            | 942  |
| 07/07/2023 | 416539        | 422301       | 416539      | 422301    | 5762            | 751  |
| 08/07/2023 | 415770        | 421635       | 415770      | 421635    | 5865            | 666  |
| 09/07/2023 | 415014        | 420909       | 415014      | 420909    | 5895            | 726  |
| 10/07/2023 | 414250        | 420142       | 414250      | 420142    | 5892            | 767  |
| 11/07/2023 | 413448        | 419409       | 413448      | 419409    | 5961            | 733  |
| 12/07/2023 | 412579        | 418673       | 412579      | 418673    | 6094            | 736  |
| 13/07/2023 | 411787        | 417936       | 411787      | 417936    | 6149            | 737  |
| 14/07/2023 | 411000        | 417222       | 411000      | 417222    | 6222            | 714  |
| 15/07/2023 | 410167        | 416446       | 410167      | 416446    | 6279            | 776  |
| 16/07/2023 | 409373        | 415686       | 409373      | 415686    | 6313            | 760  |
| 17/07/2023 | 408555        | 414893       | 408555      | 414893    | 6338            | 793  |
| 18/07/2023 | 407717        | 414105       | 407717      | 414105    | 6388            | 788  |
| 19/07/2023 | 406949        | 413387       | 406949      | 413387    | 6438            | 718  |
| 20/07/2023 | 406110        | 412624       | 406110      | 412624    | 6514            | 763  |
| 21/07/2023 | 405227        | 411752       | 405227      | 411752    | 6525            | 872  |
| 22/07/2023 | 404327        | 410880       | 404327      | 410880    | 6553            | 872  |
| 23/07/2023 | 403425        | 410057       | 403425      | 410057    | 6632            | 823  |
| 24/07/2023 | 402609        | 409319       | 402609      | 409319    | 6710            | 738  |
| 25/07/2023 | 401761        | 408483       | 401761      | 408483    | 6722            | 836  |
| 26/07/2023 | 400833        | 407595       | 400833      | 407595    | 6762            | 888  |
| 27/07/2023 | 399864        | 406718       | 399864      | 406718    | 6854            | 877  |
| 28/07/2023 | 398746        | 405635       | 398746      | 405635    | 6889            | 1083 |
| 29/07/2023 | 397776        | 404689       | 397776      | 404689    | 6913            | 946  |
| 30/07/2023 | 396629        | 403571       | 396629      | 403571    | 6942            | 1118 |
| 31/07/2023 | 395717        | 402719       | 395717      | 402719    | 7002            | 852  |

Data after July 31th are impacted by Halving and later by the deny list changes.
Basically the average loss per day before HIP-83 is 785 and after HIP-83 is 845.
The average not rewarded was 5688 then 6583.

In a short term the HIP-83 did not have significant negative impact on disconnection rate (+6%) and it
did not add a significant impact on rewarded hotspots (beacons and data are not impacted by this evolution).
It did not have a positive impact either.

In a longer term, it will be impossible to evaluate the impact as the halving started on August 1st. Between August 1st and August 15th, the average disconnection a day jumped to 1020 (+20%).

![Hotspot disconnection evolution over 45 days](files/0094/hotspot-disconnection-evoltution.png)

Up to 41.000 hotspots (10% of the initial fleet) have been lost between July 1st and August 15th.

### Rewarded Hotspots for Witnesses

The following [Helium Geek](https://heliumgeek.com/stats/epoch/iot) stats displays the number of different hotspots rewarded for witnessing and beaconing within a same day.

![Hotspot daily stats](files/0094/hotspot-daily-stats.png)

You can notice that since HIP 83 launch we had a break in the witness participation by 10,000 hotspots. This means the witnesses rewards goes to fewer hotspots, even if all are participating to witness beaconing. 10,000 of the hotspots are out of most for the reward distribution, to the benefit of the others.

There is no visible short term evolution of the other trends, daily stats continue to decrease the same way.

## MCU performance impact

| Hotspot    | Motherboard | CPU/MCU         | Clock   | Cores |
| ---------- | ----------- | --------------- | ------- | ----- | --- |
| Nebra...   | RPI CM3     | BCM2837B0       | 1400MHz | 4     |
| Rak...     | RPI 4       | BCM2711         | 1500MHz | 4     |     |
| Kerlink    | Custom      | MCIMX6X1CVO08AB | 800MHz  | 1     |
| Senscap M2 | Mediatek    | MT7628          | 580MHz  | 1     |

## ECC Signature impact

The ECC Signature process is having a significant impact on the overall processing, some measure have been conducted by
community members like Miroslav (heliootics) & co, Jose Marcelino, using the gateway-mfr-rs test kit. For the tested hotspot provider we can the following average signature time:

| Manufacturer Brand | Model         | Avg Signature Time | Note   |
| ------------------ | ------------- | ------------------ | ------ |
| Calchip v1         |               | ?                  | no ECC |
| DiY                | x86           | ?                  | no ECC |
| DiY                | RPI 4         | ?                  | no ECC |
| Bobcat             | RK3566        | 105 ms             |        |
| Milesight          |               | 105 ms             |        |
| Nebra              | indoor CM3 v1 | 113 ms             |        |
| Synchrobit         | CM4           | 120 ms             |        |
| Cotx               | X3            | 130 ms             |        |
| Heltec             | HT-M2808      | 135 ms             |        |
| Bobcat             | Others        | 150 ms             |        |
| Linxdot            |               | 152 ms             |        |
| Dusun              |               | 154 ms             |        |
| Nebra              | indoor CM3 v2 | 157 ms             |        |
| RAK / MNTD         | Gold          | 165 ms             |        |
| RAK / MNTD         | Black         | 174 ms             |        |
| Pycom              | Other         | 175 ms             |        |
| Sensecap           | M1            | 175 ms             |        |
| PantherX1          |               | 179 ms             |        |
| Pisces             |               | 180 ms             |        |
| Controllino        |               | 180 ms             |        |
| Heltec             | Other         | 242 ms             |        |
| FreedomFi          |               | 400 ms             |        |

The signature impacts on the first to arrive show a variability up to 250ms. ( to be completed with the non ECC device data later one)

The consequence of this in regard of the HIP-83 can be shown on the following grapfics:

![ECC Signature impact on witness selection](files/0094/hip83-delta-by-maker.png)

This graphic shows, after the start of the HIP-83, the witness selection change by maker. It shows the number of hotspot (Y axis) selected more time, on the right side of the 0 (X axis) or selected less time, on the left side of the 0 (X axis).

We see that the distribution is not centered, with certain brands getting an advantage on the other, due to hardware and software implementation. Bobcat ( faster ECC ) and Kerlink ( MCU integrated ECC ) takes advantage over the other manufacturer.

The timing given above evolves based on the gateway-rs evolution, the manufacturer firmware improvement and my not be accurate at the day of the
reading. This aimed to illustrate how a single piece of hardware in the solution, will have a significant impact on the PoC response time.

## Packet Processing Waterfall

The following waterfall represents the different steps in the data packet processing, in the case of a packet requesting an ACK or a downlink. The HPR is geo-replicated, time to reach it is within the zone.

Two scenarios are identified:

- the first one in gray is the best case scenario, hotspot is fast and the LNS is in the same zone the device is, so the communication from HPR to LNS then LNS to Hotspot is short.
- the second one in orange is the worst case scenario, hotspot is slower and LNS and device are in at the longest Internet distance, considering 600ms.

The first scenario gives an idea of the acceptable copies reception windows to match with the RX1 window, in blue, up to 600ms. The second scenario gives an idea of the acceptable copies reception windows to match with RX2 window (RX1 not achievable due to round trip delay), up to 210ms. Both scenario includes a margin of 200ms for non seen yet.

![Packer Processing Waterfall](files/0094/packet-processing-waterfall.png)

This minimum reception window to achieve the worst case has been used to propose the initial time windows for accepting the
witnesses.

## Witness Processing Waterfall

The following waterfall represent the different steps in the witness processing, the variability of each of the steps, depending on hardware, network access, network variability as been identified to have the scale of magnitude of each of the steps on the global processing. As steps normal variability is large and really context driven, this illustration tries to approximate the best way as possible but can't be exact.

![Witness Processing Waterfall](files/0094/witness-waterfall-1.png)

- Witness processing is the time to execute the gateway-rs code (out of ECC signature), I don't have reference of time and assume it should be around 10ms, any better data is welcome. The variability comes from the different hardware performance for running the same code, we have seen previously a ratio of 3x in terms of cpu frequency, associated to performance.
- ECC signature, as seen previously is a factor of magnitude of 4x between no ECC signature and worst ECC implementation.
- The Witness is then reported to iot poc server, this architecture is zone distributed, so we can assume all the hotspot reporting the Witness will report to the same server within their zone. The time to reach http://mainnet-pociot.helium.io:8080 can be checked with https://check-host.net/ in TCP Port check. The response time vary from 20 to 100ms including network latency natural variability. On top of this we can add an extra variable time related to the use of 4G (50-100ms) or xDSL (30-50ms).
- Then the iot poc server reports the witnesses to the Oracle to verify the PoC and compute the rewarding. The time depends on the Oracle location compared to iot poc server. This is the same network path for all packets. The network natural network latency we have between packets (measurable with ping command, max - min) have an order of magnitude of 10-50ms (about 20%).

The variation of time related to the hotspot type of connectivity (yellow block) is really limited compared to the overall variability in the Witness processing. Hotspot hardware is first impacting the performance, then network access is quite equivalent to Internet natural variability from one packet to the other ( distribution is different ).

A reception windows of 320ms should cancel all the natural variability, the use of a windows 200ms will still impact the slow hotspots. The extended windows, used in the low density area is covering all the variability.
