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

### Joining
[joining]: #joining

When device starts up, it is session-less, or not connected to its organization's router. The process of establish a session is called joining. The send and response layer is called a super frame. All call/response messages will have the following fields at a minimum:

Datagram Key (DGK) - OUI - Device ID (DID) - Fingerprint (FP)

|DGK | OUI | DID | FP | 
|-----|-----|-----|-----|

Sessions have a finite lifetime.

Super frames contain necessary connection information and requested payload size needed to facilitate communication. The added fields are: Session ID (SID), Payload Size (PLS). The generic super frame structure is as follows:

|DGK | OUI | DID | FP | SID | PLS |
|-----|-----|-----|-----|-----|-----|

The send structure of an unconnected device has the following fields completed: 

| DGK | OUI | DID | FP | SID | PLS |
|-----|-----|-----|-----|-----|-----|
| X | X | X | X | _ | X |

The received structure for an unconnected device has the following fields completed:

| DGK | OUI | DID | FP | SID | PLS |
|-----|-----|-----|-----|-----|-----|
| X | X | X | X | X | X |

Once the device receives a complete super frame structure (has been assigned a session ID) it is considered connected and can begin transmitting data frames.

#### Connection Frame 

Before sending a payload, a device must broadcast identifying information and receive confirmation from a router via hotspot that it is ready to receive data. The call/response for this described above again is: 

*Call*

| DGK | OUI | DID | FP | SID | PLS |
|-----|-----|-----|-----|-----| -----| 
| X | X | X | X | _ | X |

*Response*

| DGK | OUI | DID | FP | SID | PLS |
|-----|-----|-----|-----|-----|-----|
| X | X | X | X | X | X |

A completed response indicates that a receiver is in range and a router is capable of receiving/forwarding data to a desired endpoint. 

#### Data Frame

Once a connection has been established, the device, referred to as sender, will transmit an upper bounded number of packets to the receiver. The added fields are: Seed 1 (S1), Seed 2 (S2), Payload (PL). The general structure of the data frame is as follows: 

*Call*

| DGK | OUI | DID | FP | S1 | S2 | PL |
|-----|-----|-----|-----|-----|-----|-----|

Once the router has successfully received the entire message (one or many transmissions by the sender), the device will receive a response data frame. Added fields are: Acknowledge (ACK). The response data frame will have the following structure: 

*Response*

| DGK | OUI | DID | FP | ACK | 
|-----|-----|-----|-----|-----|

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

