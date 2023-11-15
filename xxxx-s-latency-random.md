# HIP ???: remove latency sorting

## Value

The Helium network is an IOT network composed of several nodes, including hotspots.  
Hotspots bring value to the IOT network in routing data packets.

It can be inferred that the value they provide is proportional to the RF coverage they have.

Thus, Helium implemented a Proof of Coverage mechanism where some hotspots would broadcast a beacon, and neighbors would confirm they saw the message.

Hotspot owners are rewarded in crypto tokens whenever their hotspot(s) route data packets, broadcast a beacon, or witness a beacon. This is the value they bring to the network.

## Current state

Today, this value is rewarded in tokens based on latency, with an emphasis of the importance of a few milliseconds.

## Latency in an IOT network

Helium is an IOT network based on LoRaWAN.

LoRaWAN supports both ways communication, and support acks (confirmed uplinks/downlinks). Here is the most common delays in the world:

| Situation                                          | Minimal latency (ms) | Optimal latency (ms) |
|----------------------------------------------------|----------------------|----------------------|
| Unconfirmed uplink, class A, no scheduled downlink | none                 | 1000                 |
| Unconfirmed uplink, class A, scheduled downlink    | 2000                 | 1000                 |
| Confirmed uplink                                   | 2000                 | 1000                 |
| Join Request                                       | 6000                 | 5000                 |

For any uplink, there may be some considerations on the use case. For example, plotting the temperature of a refrigerator for historical data and a school panic button do not have the same requirements.  
The former would tolerate minutes if not hours of delay in data collection (as long as the data is there eventually), however the latter would not tolerate a latency over a few seconds.

Thus, LoRaWAN has a latency requirement in the order of magnitude of about 10^3 milliseconds.

## Latency vs. value

After looking at the value provided by hotspots and how they are rewarded, it appears that there are several orders of magnitude of difference between what is rewarded and what is actually useful to the network (10^1 vs 10^3 milliseconds).

## Proposition

Ideally, we should sort hotspots that perform the work (witnessing or routing a packet) using a KPI that fairly represents the value they bring to the network.

As a reminder of said value from the first paragraph:

* routing packets: unless they are unreasonably slow (see table above), all hotspots provide the same amount and value of work (e.g. routing the packet from A to B)
* witnessing coverage: the uptime, coverage, RF performance, reliability, power usage, data consumption, etc.

It is very hard to assert a reliable KPI to assess this value.  
Today, latency fails to do so.

Short of a better KPI, randomness seems the fairest option.

### Selection

A typical flow could be shown as:

1. Uplink received by gateway
2. Cloud processing
3. Downlink sent to gateway (if any)

Latency is often measured as round trip time (RTT), so here it would be split in two on steps 1 and 3.  
During step 2, it becomes known whether a class A downlink has to be sent to that device, we know which RX window can be selected, and we know from step 1 what is the uplink latency. By inferring that it is symmetrical (assumption that could be wrong and thus add the need for headroom), we could know at the end of step 2 whether a particular hotspot would be able to route the packet or not.

Thus, some hotspots could be eliminated if they fail to provide the packet within a reasonable time (threshold).

### Threshold

Even if latency does not matter in terms of milliseconds or tens or milliseconds (or more) for LoRaWAN (see above), there could be a threshold to filter out hotspots that are too slow.

| Scenario                                              | Threshold | Rationale                                                                                                 |
|-------------------------------------------------------|-----------|-----------------------------------------------------------------------------------------------------------|
| Uplink with no scheduled class A downlink             | 2500ms    | See table above; even with the most critical LoRaWAN use case, no latency below a few seconds is expected |
| Uplink with a scheduled class A downlink, target RX1  | 800ms     | Gives 200ms headroom for cloud processing (LNS handling, window selection, latency computation, etc)      |
| Uplink with a scheduled class A downlink, target RX2  | 1800ms    | Gives 200ms headroom for cloud processing (LNS handling, window selection, latency computation, etc)      |

## Behavior

For PoCs or data packets:

1. first packet received from first hotspot: check if there is a class A downlink pending, decide RX1/RX2, and compute threshold accordingly
2. collect hotspots that brought value (routing/witnessing) until the threshold expires (from packet timestamp, not from first hotspot)
3. validate their work (cryptographically or through analysis e.g. denylist)
4. if the list is greater than 14, select randomly 14 winners among the list
