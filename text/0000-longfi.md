- Start Date: 2019-08-16
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

Table of Contents
=================

* [Summary](#summary)
* [Regulatory](#regulatory)
* [Protocol](#protocol)
  * [Versioning](#versioning)
  * [Joining](#joining)
  * [Datagram](#datagram)
  * [Uplink](#uplink)
  * [Downlink](#downlink)
  * [Fragmentation](#fragmentation)
  * [Channels](#channels)

## Summary
[summary]: #summary

This whitepaper introduces the high-level semantics of LongFi, the Helium network's wireless protocol.

Providing wide-area wireless connectivity is the Helium network's _raison d'être_. Providing this connectivity in a manner that is implementable by both Helium and third-parties requires a free and open protocol that devices, hotspots, and routers understand.

This proposal is not an all-encompassing specification but lays the foundation for further HIPs which will serve as the specification.

## Versioning
[versioning]: #versioning

LongFi is versioned so that it can be improved in future revisions without breaking backward compatibility.

## Regulatory
[regulatory]: #regulatory

Regulations on intentional radiators vary region by region. These regulations inform much of LongFi's design, primarily...

> TODO:
> - time on air
> - duty cycle

## Protocol
[protocol]: #protocol

LongFi is a session-oriented protocol. However, unlike most wireless protocols which operate within a network of trusted base stations, devices in the Helium communicate _through_ untrusted hotspots. Therefore, sessions in the Helium network are between devices and routers. Sessions persist regardless of which or how many hotspots receive their packets.

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

Due to variations on packet transmission size and time imposed by various regulatory domains it's impossible to send payloads of arbitrary size over unlicensed spectrum. As a consequence LongFi aims to provide a generic mechanism to spread the arbitrary payload over a number of smaller "datagrams" that are guaranteed to comply with any regulatory domain's restrictions. A datagram's focus should be on imposing as little overhead as possible while retaining enough information for routing and verification. As LongFi is a versioned specification, a "datagram kind" (DGK) field is used to provide for future extensions.

Any currently specified datagram must always include the following fields:

Datagram Key (DGK) - OUI - Device ID (DID) - Fingerprint (FP)

| DGK | OUI | DID | FP |
|-----|-----|-----|----|
| 1   |  4  |  2  | 4  |

This provides enough information to identify the type of the datagram and to parse the subsequent fields needed for routing/verification.

TODO:
 * should we have a 'flags' field for things like ACK and ADR?

The currently specified datagram kinds are as follows:

#### Monolithic Datagram
[monolithic-datagram]: #monolithic-datagram

A monolithic datagram is expected to be the most common way to transmit data that can be fit within a single datagram.

| DGK(0) | OUI | DID | FP | Payload |
|--------|-----|-----|----|---------|
| 1      |  4  |  2  |  4 |   N     |

Because the Lora frame itself has length information, simply the remainder of the datagram is treated as the payload.

#### Start of Frame Datagram
[start-of-frame-datagram]: #start-of-frame-datagram

A start of frame datagram is used to describe a series of following datagrams that contain a payload larger than a monolithic datagram can hold. In some cases, if there's room, some of the payload may appear at the end of this datagram.

| DGK(1) | OUI | DID | FP | Frame ID | Datagram Count | Optional Payload |
|--------|-----|-----|----|----------|----------------|------------------|

A count of the subsequent datagrams is provided (*not* the length of the entire payload). The Frame ID is allocated by the client but it is recommended to be a strictly monotonic counter.

#### Frame Data Datagram
[frame-data-datagram]: #frame-data-datagram

The frame data datagram simply contains chunks of payload data that correspond to a previous start of frame datagram. The frame ID should be included in the fingerprint generation to avoid crosstalk between frames, but it is not needed to transmit it. The sequence number is used to determine the ordering of the payload fragments.

| DGK(2) | OUI | DID | FP | Seq # | Payload |
|--------|-----|-----|----|-------|---------|


### Joining
[joining]: #joining

When device starts up, it is session-less, or not connected to its organization's router. The process of establishing a session is called joining.

As LongFi is primarily concerned with the delivery of datagrams, it doesn't concretely specify how joins are done. Device and router implementors are free to choose how they want to establish, maintain and terminate sessions. Helium will provide a specification and a reference implementation that will be described below.

In general, the goal of the joining procedure is to negotiate a shared secret both the router and the device know and agree on, but is not known to anyone else. This can be achieved in several different ways, including:

* Pre shared keys
* Out of band negotiation (eg. over cellular/wifi/bluetooth)
* Elliptic Curve Diffie-Hellman key exchange (ECDH)

Having a shared secret is important to producing tamper-proof datagram fingerprints so routers and devices can't be tricked into accepting forged or corrupt data.

#### Helium Joining
[helium-joining]: #helium-joining

In Helium's implementation, the shared secret will be negotiated over ECDH. This assumes the router knows the public key associated with the DID and the device knows some "root of trust" key associated with the router infrastructure. In addition a special public 'join key' also needs to be stored on the device. Finally, to reduce network traffic later, a 'key tree' with an associated trust epochcan be pre-loaded on the device. These pieces of information are assumed to have been exchanged and recorded at device provisioning. The specific elliptic curve used for the keys has also been pre-agreed upon but is expected to be NIST p-256 or Curve25519.

When a device does not have an active session (first time online, session expired, session lost) it sends, via datagrams as described above, a JOIN message:

| JOIN-ASK(1) | Trust Epoch | Session ID |
|-------------|-------------|------------|

At this point, however, the device does not have a session key to use in computing a fingerprint or to encrypt the payload with. Thus it should do an ECDH with the 'join' key. This is the ONLY context in which this key should be used. To prevent replay attacks, session IDs should not be reused within a trust epoch and the Session ID should be combined with the ECDH result to form the join AES key.

The router will then send back a join answer. Depending on the device's reported trust epoch, the router may need to deliver key-tree updates. A key tree update is of the following form

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

Therefore, the join answer packet looks like:

| JOIN-ANS(2) | Trust Epoch | ECDH Key ID | Session ID | Payload Fingerprint | Key Updates |
|-------------|-------------|-------------|------------|---------------------|-------------|

The trust epoch MUST be equal to or greater than the device's trust epoch. If it is the same then no key updates should be attached. If the trust epoch is greater than the device has, the device should verify all the key updates and, if they're correct, it should store the new keys locally and increment its trust epoch. The trust epoch is effectively a monotonic counter describing the version of the chain of trust from a router key back to the trust root. Each time a router or intermediate key is rolled or added the trust epoch should increment.

The ECDH key ID field indicates which key should be used for the ECDH operation to negotiate a session key. This key should not have any keys under it in the key tree (it should be a leaf node).

The session ID must match what the device sent in its join request. The session ID and trust epoch should be mixed in with the result of the ECDH to generate the session key.

The fingerprint for the datagrams should be constructed using the join AES key. Additionally a fingerprint over the preceeding payload should be constructed with the session key, so the device is sure that this join answer has not been forged by someone with access to the join key.

If this step completes successfully the device and the router should agree on the following:

* Session ID
* Session Key
* Trust Epoch
* All relevant key updates

From this point normal datagrams can be constructed, fingerprinted, sent and authenticated by the far side.

TODO:
 * What if the router has lost the session key?

### Fingerprints
[fingerprints]: #fingerprints

Fingerprints are a crucial mechanism for devices and routers to determine if the datagram they've received, or been offered, is valid. They resemble a HMAC with the twist that the message cannot be supplied in the clear. Instead, a hash of the message must be used. This allows for the hotspot to offer a datagram to the router by simply providing the hash of the contents and the fingerprint and allows the recipient to verify the authenticity and integrity of the packet without the hotspot having to reveal the packet up front.

TODO:
 * Specifiy this more formally and account for common attacks like length-extension, etc


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
**DGK**

Datagram kind. A tag value indicating this datagram's variant type.

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
