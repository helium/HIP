- Start Date: 2019-08-16
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

Table of Contents
=================

* [Summary](#summary)
* [Versioning](#versioning)
* [LoRa Physical Layer](#lora)
* [Protocol](#protocol)
  * [Datagrams](#datagrams)
  * [Joining](#joining)
  * [Uplink](#uplink)
  * [Downlink](#downlink)
  * [Fingerprints](#fingerprints)
  * [Fragmentation](#fragmentation)
  * [Channels](#channels)
* [Regulatory](#regulatory)

## Summary
[summary]: #summary

This whitepaper introduces the high-level semantics of LongFi, the Helium network's wireless protocol.

Existing wide-area wireless protocols suffer from a variety of drawbacks which create challenging circumstances for a ubiquitous wireless network. Our desired implementation would be open source, lightweight, secure, and provide a universal routing and payment mechanism that allows the network to be used anywhere in the world as long as Hotspots are paid for routing traffic.

Providing wide-area wireless connectivity in a manner that is implementable by both Helium and third-parties requires a free and open protocol that Devices, Hotspots, and Routers understand.

This proposal is not an all-encompassing specification but lays the foundation for further HIPs and a reference implementation which will serve as the specification.

## Versioning
[versioning]: #versioning

LongFi is versioned so that it can be improved in future revisions without breaking backward compatibility.

## LoRa Physical Layer
[lora]: #lora

LongFi is built on top of the LoRa modulation format and physical layer. Any LoRa compatible transceiver is supported, although the SX126x is recommended due to the overall improved power consumption and performance.

LoRa is a _Chirp Spread Spectrum_ modulation scheme which encodes symbols as _upchirps_ and _downchirps_. It is extremely resilient to interference, and due to the relatively unique occurrence of the chirps in radio spectrum, packets can be locked on to at very low data rates and long durations of time.

The speed of the transmissions, in bits per second, is determined by the _spreading factor_ of the transmission. The spreading factor is the duration of each chirp, and ranges from SF12 (approximately 250bps) to SF5 (approximately 20,000bps). Longer chirp durations increase the ability of the receiver to lock on to the packet, and receive sensitivities as low as -138dBm are possible using the LongFi specified 125khz channels.

## Protocol
[protocol]: #protocol

LongFi is a connectionless datagram protocol, similar to the [IP protocol](https://en.wikipedia.org/wiki/Internet_Protocol). However, unlike most wireless protocols which typically operate within a network of trusted base stations owned by a single operator, Devices in the Helium communicate _through_ untrusted Hotspots owned by many decentralized operators. Therefore, sessions in the Helium network are between Devices, typically a physical sensor, and Routers, which exist on the internet, that are owned by the same operator. Sessions persist regardless of which or how many Hotspots receive their packets.

_Routers_ are internet-connected application servers that communicate with Hotspots and the Helium blockchain via [libp2p](https://github.com/helium/erlang-libp2p).

It is expected that _Organizations_ deploying one or more _Devices_ will operate their own Router as the endpoint for [Datagrams](#datagrams) transmitted by their Devices. _Hotspots_, which are libp2p-connected TCP/IP to LongFi bridges, rely on an _Organizationally Unique Identifier (OUI)_ contained in the header of Device transmissions to determine which Router to deliver Datagrams.

In this sense LongFi combined with the Helium blockchain provides VPN-like functionality for an Organization; any Device whose Datagrams are heard by any Hotspot anywhere in the world will always be delivered to the correct Router.

```
     ┌──────────┐
     │  Router  │
     └──────────┘
           ▲
     ┌─────┴─────┐
     ▼           ▼
┌─────────┐ ┌─────────┐
│ Hotspot │ │ Hotspot │
└─────────┘ └─────────┘
     ▲           ▲
     └─────┬─────┘
           ▼
    ┌────────────┐
    │   Device   │
    └────────────┘
```

### Datagrams
[datagrams]: #datagrams

Due to variations on packet transmission size and time imposed by various regulatory domains it is impossible to send payloads of arbitrary size over unlicensed spectrum. As a consequence LongFi aims to provide a generic mechanism to spread the arbitrary payload over a number of smaller Datagrams that are guaranteed to comply with any regulatory domain's restrictions. Additionally, smaller transmissions can significantly improve the packet error rate (PER) as they are less susceptible to noise and interference due to the shorter transmission duration. A Datagram's focus should be on imposing as little overhead as possible while retaining enough information for routing and verification. As LongFi is a versioned specification, a Datagram Tag (Tag) field is used to provide for future extensions.

A datagram, in a given regulatory region, for a particular spreading factor, has a fixed size. The LoRa physical layer length field _may_ be used to denote a datagram of a shorter length but for maximum reliability it is recommended to transmit short payloads with padding such that the datagram is of the maximum size. Oversize datagrams _must_ be treated as length field corruption and truncated to the maximum allowed size.

The LoRa CRC option should be disabled and the code rate should be set to the minimum of 4/5.

A Datagram must always include the following fields (sizes in bytes):

| Tag | OUI | DID | FP |
|-----|-----|-----|----|
|  3  | 1+  | 1+  | 4  |

This basic structure provides enough information to identify the type of Datagram and to parse the subsequent fields needed for routing and verification.

Fields denoted _1+_ indicate that the field is an unsigned [variable length integer field](https://en.wikipedia.org/wiki/Variable-length_quantity) and grows in size as needed.

The Tag is a [Golay 24,12](https://en.wikipedia.org/wiki/Binary_Golay_code) encoded 12 bits with an additional 12 bits of error correction information. The Golay code is chosen for several reasons:

* It has a small block size
* It can correct any 3 bits of errors and detect any 7 bits of errors
* It is suitable for low-end microcontrollers
* It can be avoided entirely on extremely low-end microcontrollers
* It can encode enough information to describe the remainder of the packet, including the use of other error corrections schemes over the remainder of the datagram

The 12 bits of Tag data is divided into 3 regions (sizes in bits):

| Extension bit | Datagram Type | Flags |
|---------------|---------------|-------|
|       1       |       5       |   6   |

This provides for 32 different datagram types, each with 6 bits of type specific information or options.

The Datagram Tags are as follows:

#### Monolithic Datagram
[monolithic-datagram]: #monolithic-datagram

A Monolithic Datagram is expected to be the most common way to transmit data that can fit within a single Datagram. When sending or receiving small amounts of data, a Monolithic Datagram should be used.

| Tag | OUI | DID | FP | Seq # | Payload |
|-----|-----|-----|----|-------|---------|
| 3   |  1+ | 1+  |  4 |  1+   |   N     |

The Sequence Number should be a non-repeating number. When the payload is encrypted with AES it is recommended to use the Sequence Number as the initialization vector.

The length of the payload can be up to the maximum datagram size minus the length of the other fields.

The Datagram Type for this datagram shall be defined as 1. Available flags are as follows

| Bit | Flag | Description |
|-|-|-|
| 0 | Downlink | This packet is destined for a Device if this bit is set |
| 1 | Should ACK | The receiver of this packet should acknowledge receipt |
| 2 | CTS/RTS | On uplink this bit indicates the device is ready to receive, on downlink it indicates further information follows |
| 3 | Priority | This indicates to the receiver that the packet is deemed urgent by the sender and the receiver can choose to act accordingly |
| 4 | LDPC | The packet, beyond the Tag field, is encoded with a [Low Density Parity Code](https://en.wikipedia.org/wiki/Low-density_parity-check_code). The specific code used depends on the maximum datagram size for the current region and spreading factor |
| 5 | Reserved | Reserved for future use |

Note that Should ACK is distinct from receiving unsolicited downlink data. If Should ACK is set and CTS is not set the Router should not follow the Ack Frame with further packets.

#### Start of Frame Datagram
[start-of-frame-datagram]: #start-of-frame-datagram

A Start of Frame Datagram is used to describe a series of following Datagrams that contain a payload larger than a Monolithic Datagram can hold. In some cases, if there's room, some of the payload may appear at the end of this Datagram.

| Tag | OUI | DID | FP | Seq # | Datagram Count | Payload |
|-----|-----|-----|----|-------|----------------|---------|
| 3   |  1+ | 1+  |  4 |  1+   |       1+       |    N    |

A count of the subsequent Datagrams is provided (*not* the length of the entire payload).

The Datagram Type for this datagram shall be defined as 2. The Flags are the same as for the monolithic datagram.

The Should ACK and CTS/RTS flags should take effect after all the subsequent Frame Data datagrams have been sent.

#### Frame Data Datagram
[frame-data-datagram]: #frame-data-datagram

The Frame Data Datagram contains chunks of payload data that correspond to a previous Start of Frame Datagram. The Sequence ID should be included in the fingerprint generation to avoid crosstalk between frames, but it is not needed to transmit it. The fragment number is used to determine the ordering of the payload fragments.

| Tag | OUI | DID | FP | Fragment # | Payload |
|-----|-----|-----|----|------------|---------|
|  3  |  1+ | 1+  | 4  | 0+         |   N     |

The Datagram Type for this datagram shall be defined as 3. The Flags in this case are a single flag LDPC followed by a 5 byte variable integer that tracks the fragment ID and spills over into the Fragment ID field.

Because any hotspot can receive the datagram, the LDPC flag needs to be present on all fragements because the hotspot needs to know if it must do any error correction itself before offering the packet along.

#### Ack Datagram
[ack-datagram]: #ack-datagram

The Ack datagram is used to indicate success/failure of a prior transmission, in response to the prior transmission having the `Should ACK` flag set. The Ack datagram can indicate success or failure and request retransmits.

| Tag | OUI | DID | FP | Seq # | Payload |
|-----|-----|-----|----|-------|---------|
|  3  |  1+ | 1+  | 4  | 1+    |   N     |

| Bit | Flag | Description |
|-|-|-|
| 0 | Failure | The receiver was unable to receive the previous message |
| 1 | Session expired | Downlink only; the receiver requests the sender to renegotiate a session key |
| 2 | CTS/RTS | On uplink this bit indicates the device is ready to receive, on downlink it indicates further information follows |
| 3 | Retransmit | Retransmit requested |
| 4 | LDPC | The packet, beyond the Tag field, is encoded with a [Low Density Parity Code](https://en.wikipedia.org/wiki/Low-density_parity-check_code). The specific code used depends on the maximum datagram size for the current region and spreading factor |
| 5 | Reserved | Reserved for future use |

The Datagram Type for this datagram shall be defined as 4. The Failure indicator should not be taken as an invitation to retransmit merely that the recipient was unable to receive the data. The Failure flag left at 0 indicates success.

Session Expired, only on downlink, indicates that the session key currently being used should be renegotiated. This may or may not be paired with the Failure flag.

An explicit Retransmit field indicates that the data should be retransmitted. In the case the prior packet was a Monolithic Datagram, the Seq # indicates the requested packet to retransmit. When the prior transmission was a Data Frame the particular fragment IDs that should be retransmitted should appear in the payload (TODO how to encode this). The Failure flag _must_ also be set for this field to be meaningful.

Following data, or the willingness to receive more data, is denoted with the CTS/RTS flag. This can be used, for example, to keep the Device awake for more data. The CTS/RTS flag _may_ be set even if the previous transmission did not have the CTS/RTS flag, but if the device did not indicate it was Clear To Send more packets should not be sent.

### Uplink
[uplink]: #uplink

Uplink data - data sent *from* a device - is broadcast in [ALOHA](https://en.wikipedia.org/wiki/ALOHAnet) fashion. Devices transmit data at any time and on any supported channel, without having to synchronize with any nearby Hotspots and without any coordination with their Router on the internet. Because LongFi compatible Hotspots are capable of listening to all LongFi channels simultaneously, one or more Hotspots within range will hear the transmission and begin the delivery process to the appropriate Router. This system allows Devices to remain simple, and for the LongFi protocol overhead to be kept to a minimum. 

### Downlink
[downlink]: #downlink

Downlink data - data sent *to* a a device - is only delivered to a Device in response to an uplink message. Following each uplink transmission the end-device opens a short receive window. The receive window start time is a fixed protocol value. The downlink channel is a function of the upstream channel used in the initial transmission, represented as: _uplinkChannel % 8_. 

### Fingerprints
[fingerprints]: #fingerprints

Fingerprints are a crucial mechanism for Devices and Routers to determine if the Datagram they've received, or been offered, is valid. They resemble a HMAC with the twist that the message cannot be supplied in the clear. Instead, a hash of the message must be used. This allows for the Hotspot to offer a Datagram to a Router by simply providing the hash of the contents and the Fingerprint and allows the Router to verify the authenticity and integrity of the packet without the Hotspot having to reveal the packet up front.

This layer of presentation allows a Hotspot to receive confirmation from a Router that it will be paid for the Datagram, without having to reveal the entire Datagram first and risk not being paid.

> TODO:
> - specifiy this more formally and account for common attacks like length-extension, etc

### Channels
[channels]: #channels

LongFi operates in unlicensed subghz spectrum. The specific frequencies and channels vary by region, and are described in this section.

#### United States (US915)

In the United States the unlicensed frequency ranges from 902-928MHz.

- Uplink: 8 uplink channels utilizing LoRa 125 kHz bandwidth using coding rate 4/5. Numbered 1-8, with Channel 1 centered at 916.0MHz and incrementing linearly by 200 kHz to 917.4 MHz.

- Downlink: 8 downlink channels utilizing LoRa 500 kHz bandwidth using coding rate 4/5. Numbered 1 to 8 with Channel 1 centered starting at 918.0 MHz and incrementing linearly by 600 kHz to 922.2 MHz.

#### Europe (EU868)

Coming soon.

> TODO

## Regulatory
[regulatory]: #regulatory

Regulations on intentional radiators vary region by region. These regulations inform much of LongFi's design.

### United States (FCC)

The relevant regulation for the United States is described in FCC 15.247.

There are three types of radiator (transmitter) described in 15.247 that are applicable to LongFi:

- those employing frequency hopping spread spectrum (FHSS)
- those employing digital modulation techniques, such as DSSS or CSS
- those employing a hybrid of FHSS and digital modulation

LongFi qualifies for the first and third of these modes.

In either mode, a Device cannot transmit for longer than 400ms on a single channel. Given the low data rates available on LongFi - approximately 1000-5000bps - LongFi enforces that the maximum amount of data which can be sent fits this criteria. On the low-end of this is approximately 24bytes, and 250bytes at the fastest rate.

> TODO:
> - enforced at the router like LoRaWAN?
> - is a specific type of "exceeding dwell time" Datagram needed?

The maximum output power of the Device is limited depending on the mode of operation. If the Device hops between at least 50 channels and does not return to the same channel in a 20 second interval, the maximum power output is 30dBm (1 watt). If the Device hops over at least 25 channels but less than 50, the maximum power output is 26dBm. If the Device uses "hybrid" mode, which for practical purposes means hopping over greater than 4 channels but less than 25, the maximum power output is approximately 22dBm.

It is important to note that a Device can can "simulate" hopping between 25+ channels by incorporating the appropriate dwell time between channels and use higher output power as a result, even if a Hotspot is only able to receive on fewer channels.

### Europe (ETSI)

Coming soon.

> TODO:
> - time on air
> - duty cycle


## OLD

> TODO:
> - Detail information on when ACK's can occur may be needed. Alternatively, should it be excluded for brevity in this doc?
> - Size of fields to be included
> - S1/S1 may be converted to sequence number?

@vagabond

> TODO:
> - diffie hellman?
> - how long do sessions live for?
> - explanations of each field

---
**Tag**

Datagram tag. A tag value indicating this datagram's variant type.

> **TODO:**
> - How many variants are needed?
> - Can this tag serve both versioning and variant disambiguation?
> - Is this enough?

---
**OUI**

Organizationally unique identifier. A globally unique number which hotspots use to forward datagrams to the correct organization's router.

---
**DID**

Device identifier. DIDs are assigned to devices by organizations. Every hardware device in an organization _should_ have a unique DID, but sharing DIDs is not forbidden.

> TODO:
> - Can DIDs really be shared?

---
**PAY**

Datagram payload. Payload lengths depend on spreading and coding, but on their actual content. Payloads are intended to be encrypted and opaque to hotspots.

> **TODO:**
> - ~indended~ required to be encrypted?

---
**FP**

Fingerprint. Packet brokerage between hotspots and routers depend on fingerprints. They allow a hotspot to prove to a router the hotspot has a datagram destined for that router, without divulging the datagram's payload. This ability is core to hotspots earning data credits for forwarding datagrams.

> **TODO:**
> - What data are fingerprints derived from?
> - Are they SHA or something more exotic?
> - Is the fingerprint, along with non-payload data, a
>   zero-knowledge-proof (ZKP)?


### Uplink
[uplink]: #uplink

Uplink communication is from device to router.

> TODO:
> - Unacknowledged vs acknowledged
> - Listen before talk
> - Spreading-factor vs dwell-time vs range
> - Initial uplink spreading factor

### Downlink
[downlink]: #downlink

Downlink communication is from router to device.

> TODO:
> - Unacknowledged vs acknowledged
> - Listen before talk
> - Spreading-factor vs dwell-time vs range
> - Initial uplink spreading factor

### Fragmentation
[fragmentation]: #fragmentation

Datagrams are the fundamental unit of messaging in LongFi. Additionally, they have regulatory imposed maximum payload sizes. This poses a problem for applications needing to send data of arbitrary length. The solution to this is problem is fragmentation. Fragmentation is the process of decomposing large application-level messages into several datagrams and reassembling those fragments at the recipient's end of the link. A naive implementation of this process is fraught with peril when communicating over unreliable links.

### Channels
[channels]: #channels
