- Start Date: 2019-08-16
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

Table of Contents
=================

* [Summary](#summary)
* [Regulatory](#regulatory)
* [Protocol](#protocol)
  * [Joining](#joining)
  * [Datagram](#datagram)
  * [Downlink](#downlink)
  * [Fragmentation](#fragmentation)

## Summary
[summary]: #summary

This whitepaper introduces the high-level semantics of LongFi, the Helium network's wireless protocol.

Providing wide-area wireless connectivity is the Helium network's _raison d'être_. Providing this connectivity in a manner that is implementable by both Helium and third-parties requires a free and open protocol that devices, hotspots, and routers understand.

This proposal is not an all-encompassing specification but lays the foundation for further HIPs which will serve as the specification.

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

When device starts up, it is session-less, or not connected to its organization's router. The process of establish a session is called joining.

Sessions have a finite lifetime.

@vagabond

> TODO:
> - diffie hellman?
> - how long do sessions live for?

### Datagram
[datagram]: #datagram

LongFi datagrams are extremely simple and contain a minimal number of cleartext fields required for hotspot to router forwarding.

DGK | OUI | DID | PAY | FP
----|-----|-----|-----|---

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


### Downlink
[downlink]: #downlink

> TODO

### Fragmentation
[fragmentation]: #fragmentation

Datagrams are the fundamental unit of messaging in LongFi. Additionally, they have regulatory imposed maximum payload sizes. This poses a problem for applications needing to send data of arbitrary length. The solution to this is problem is fragmentation. Fragmentation is the process of decomposing large application-level messages into several datagrams and reassembling those fragments at the recipient's end of the link. A naive implementation of this process is fraught with peril when communicating over unreliable links.
