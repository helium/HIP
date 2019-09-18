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

LongFi is a session-oriented protocol. However, unlike most wireless protocols which typically operate within a network of trusted base stations owned by a single operator, Devices in the Helium communicate _through_ untrusted Hotspots owned by many decentralized operators. Therefore, sessions in the Helium network are between Devices, typically a physical sensor, and Routers, which exist on the internet, that are owned by the same operator. Sessions persist regardless of which or how many Hotspots receive their packets.

_Routers_ are internet-connected application servers that communicate with Hotspots and the Helium blockchain via [libp2p](https://github.com/helium/erlang-libp2p).

It is expected that _Organizations_ deploying one or mode _Devices_ will operate their own Router as the endpoint for [Datagrams](#datagrams) transmitted by their Devices. _Hotspots_, which are libp2p-connected TCP/IP to LongFi bridges, rely on an _Organizationally Unique Identifier (OUI)_ contained in the header of Device transmissions to determine which Router to deliver Datagrams.

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

A Datagram must always include the following fields:

| Tag | OUI | DID | FP |
|-----|-----|-----|----|
| 1   |  4  |  2  | 4  |

This basic structure provides enough information to identify the type of Datagram and to parse the subsequent fields needed for routing and verification.

> TODO:
> - should we have a 'flags' field for things like ACK and ADR?

The Datagram Tags are as follows:

#### Monolithic Datagram
[monolithic-datagram]: #monolithic-datagram

A Monolithic Datagram is expected to be the most common way to transmit data that can fit within a single Datagram. When sending or receiving small amounts of data, a Monolithic Datagram should be used.

| Tag(0) | OUI | DID | FP | Payload |
|--------|-----|-----|----|---------|
| 1      |  4  |  2  |  4 |   N     |

Because the LoRa physical layer frame contains length information, the remainder of the Datagram is treated as the payload.

#### Start of Frame Datagram
[start-of-frame-datagram]: #start-of-frame-datagram

A Start of Frame Datagram is used to describe a series of following Datagrams that contain a payload larger than a Monolithic Datagram can hold. In some cases, if there's room, some of the payload may appear at the end of this Datagram.

| Tag(1) | OUI | DID | FP | Frame ID | Datagram Count | Optional Payload |
|--------|-----|-----|----|----------|----------------|------------------|

A count of the subsequent Datagrams is provided (*not* the length of the entire payload). The Frame ID is allocated by the client but it is recommended to be a strictly monotonic counter.

#### Frame Data Datagram
[frame-data-datagram]: #frame-data-datagram

The Frame Data Datagram contains chunks of payload data that correspond to a previous Start of Frame Datagram. The Frame ID should be included in the fingerprint generation to avoid crosstalk between frames, but it is not needed to transmit it. The sequence number is used to determine the ordering of the payload fragments.

| Tag(2) | OUI | DID | FP | Seq # | Payload |
|--------|-----|-----|----|-------|---------|


### Joining
[joining]: #joining

When a LongFi Device is powered on, it is session-less and not associated with its Organization's Router. The process of establishing a session is called joining.

As LongFi is primarily concerned with the delivery of Datagrams, a concrete requirement for how the join process should occur has been intentionally omitted. Device and Router implementors are free to choose how they want to establish, maintain and terminate sessions.

In general, the goal of the joining procedure is to negotiate a shared secret both the Router and the Device know and agree on, but is not known to anyone else. This can be achieved in several different ways, including:

* Pre shared keys
* Out of band negotiation (eg. over cellular/wifi/bluetooth)
* Elliptic Curve Diffie-Hellman key exchange (ECDH)

Having a shared secret is important to producing tamper-proof Datagram fingerprints so Routers and Devices cannot be tricked into accepting forged or corrupt Datagrams.

#### Reference Joining Implementation
[helium-joining]: #helium-joining

In Helium's reference implementation, the shared secret will be negotiated over ECDH. This assumes the router knows the public key associated with the Device ID and the Device knows some "root of trust" key associated with the Router. In addition a special public "join key" also needs to be stored on the Device. Finally, to reduce subsequent network traffic, a "key tree" with an associated trust epoch can be pre-loaded on the Device. These pieces of information are assumed to have been exchanged and recorded at Device provisioning. The specific elliptic curve used for the keys must also be pre-negotiated, but is expected to be NIST p-256 or Curve25519.

When a device does not have an active session (first time online, session expired, or session lost) it sends, via Datagrams as described above, a Join Ask. This Join Ask is a Monolithic Datagram with the following payload:

| JOIN-ASK(1) | Trust Epoch | Session ID |
|-------------|-------------|------------|

At this point, however, the Device does not have a session key to use in computing a Fingerprint or to optionally encrypt the payload with. Thus it should do an ECDH exchange with the 'join' key. This is the ONLY context in which this key should be used. To prevent replay attacks, Session IDs should not be reused within a trust epoch and the Session ID should be combined with the ECDH result to form the join AES key.

The Router will then send back a join answer. Depending on the Device's reported trust epoch, the Router may need to deliver key-tree updates. A key tree update is of the following form

| KeyID | Key      | Signature Trust Epoch | Signature |
|-------|----------|-----------------------|-----------|
|   1   |  32/64   |                       | 64        |

The signature field is a signature over all the previous fields.

A KeyID is an 8 bit integer destructured into 4 2-bit tree identifiers. They address a tree with up to 81 nodes as follows (MSB order, only significant bytes are shown, 00 is the terminator):

```
                                      Root Key (00...)
                                  /           |          \
                       Key 1 (0100...)   Key 2 (1000...)  Key 3 (1100...)
                   /        |          \                                |
Key 1.1 (010100...)  Key 1.2 (011000...) Key 1.3 (011100...)       Key 3.1 (110100...)
```

So, Key 3.2.1.3 would be 11 10 01 11. Keys that do not use all 4 layers of the tree would terminate the key address with the 00 bit sequence.

If the first 2 bytes are 00, that refers to the root key. Root keys can be updated if absolutely necessary if they're signed by the previous root key.

A key in the key tree is assumed to be signed by the parent key in the tree. Thus Key 1.2 is signed by Key 1 and Key 1 is signed by the root key (which is the pre-provioned root of trust key). Keys that are replaced should have all their children in the tree deleted (and replaced by subsequent updates). Key tree updates should appear in an order from the root of the tree to the tips of the branches. A replacement key should have a signature trust epoch higher than the previous key (and the device's current trust epoch). A new key should have a signature trust epoch higher than the device's current trust epoch.

Therefore, the Join Answer payload looks like:

| JOIN-ANS(2) | Trust Epoch | ECDH Key ID | Session ID | Payload Fingerprint | Key Updates |
|-------------|-------------|-------------|------------|---------------------|-------------|

The trust epoch MUST be equal to or greater than the Device's trust epoch. If it is the same then no key updates should be attached. If the trust epoch is greater than that of the Device, the Device should verify all the key updates and, if they're correct, it should store the new keys locally and increment its trust epoch. The trust epoch is effectively a monotonic counter describing the version of the chain of trust from a Router key back to the trust root. Each time a Router or intermediate key is rolled or added the trust epoch should increment.

The ECDH Key ID field indicates which key should be used for the ECDH operation to negotiate a session key. This key should not have any keys under it in the key tree (it should be a leaf node).

The Session ID must match what the device sent in its Join Ask. The Session ID and trust epoch should be mixed in with the result of the ECDH to generate the session key.

The Fingerprint for the Datagrams should be constructed using the join AES key. Additionally a Fingerprint over the preceeding payload should be constructed with the session key, so the Device is sure that this join answer has not been forged by someone with access to the join key.

If this step completes successfully the device and the router should agree on the following:

* Session ID
* Session Key
* Trust Epoch
* All relevant key updates

From this point normal Datagrams can be constructed, Fingerprinted, sent and authenticated by both ends of the communication.

TODO:
 * What if the router has lost the session key?

### Uplink
[uplink]: #uplink

> TODO
> - complete this

### Downlink
[downlink]: #downlink

> TODO
> - complete this

### Fingerprints
[fingerprints]: #fingerprints

Fingerprints are a crucial mechanism for Devices and Routers to determine if the Datagram they've received, or been offered, is valid. They resemble a HMAC with the twist that the message cannot be supplied in the clear. Instead, a hash of the message must be used. This allows for the Hotspot to offer a Datagram to a Router by simply providing the hash of the contents and the Fingerprint and allows the Router to verify the authenticity and integrity of the packet without the Hotspot having to reveal the packet up front.

This layer of presentation allows a Hotspot to receive confirmation from a Router that it will be paid for the Datagram, without having to reveal the entire Datagram first and risk not being paid.

> TODO:
> - specifiy this more formally and account for common attacks like length-extension, etc

### Fragmentation
[fragmentation]: #fragmentation

> TODO:
> - is this section needed?

### Channels
[channels]: #channels

LongFi operates in unlicensed subghz spectrum. The specific frequencies and channels vary by region, and are described in this section.

#### United States (US915)

In the United States the unlicensed frequency ranges from 902-928MHz.

- Uplink: 64 125KHz wide uplink channels, with Channel 1 centered at 914.0MHz and subsequent channels incremented by 200KHz.

- Downlink: ??????

> TODO
> - complete this accurately

#### Europe (EU868)

> TODO
> - etc etc

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
