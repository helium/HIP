- Start Date: 2019-08-16
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

Table of Contents
=================

* [Summary](#summary)
* [Protocol](#protocol)
  * [Datagram](#datagram)
  * [Joining](#joining)
  * [Downlink](#downlink)

## Summary
[summary]: #summary

This whitepaper itroduces the high-level semantics of LongFi, the
Helium network's wireless protocol.

Providing wide-area wireless connectivity is the Helium network's
_raison d'être_. Providing this connectivity in a manner that is
implementable by both Helium and third-parties requires a free and
open protocol that devices, hotspots, and routers understand.

This proposal is not an all-encompassing specification but lays the
foundation for further HIPs which will serve as the specification.

## Protocol
[protocol]: #protocol

> TODO:
> - add lower-level summary that above?

### Datagram
[datagram]: #datagram

LongFi datagrams are extremely simple,
and contain a minimal number of cleartext fields required for hotspot
to router forwarding.

DGK | OUI | DID | PAY | FP
----|-----|-----|-----|---

---
**DGK**

Datagram kind. A 'tag' value indicating what which variant of datagram
this is.

> **TODO:**
> - How many variants are needed?
> - Can this tag serve both both versioning and variant disambiguation?
> - Is this enough?

---
**OUI**

Organizationally unique identifier. A globally unique number which
hotspots use to forward datagrams to the correct organization's router.

---
**DID**

Device identifier. Assigned to devices by organizations. Every
hardware device in an organization _should_ have a unique DID, but
sharing DIDs is not forbidden.

> TODO:
> - Can DIDs really be shared?

---
**PAY**

Datagram payload. Payload lengths are fixed and depend on which
spreading factor the datagrams is transmitted with. Payloads are
intended to be encrypted and opaque to hotspots.

> **TODO:**
> - ~indended~ required to be encrypted?

---
**FP**

Fingerprint. Fingerprints are required for packet forwarding
brokerage. They allow a hotspot to prove to a router the hotspot has a
datagram destined for that router, without divulging the datagram's
payload. This ability is core to hotspots earning data credits for
forwarding datagrams.

> **TODO:**
> - What data are fingerprints drived from?
> - Are they SHA or something more exotic?
> - Is the fingerprint, along with non-payload data, a
>   zero-knowlege-proof (ZKP)?

### Joining
[joining]: #joining

> TODO

### Downlink
[downlink]: #downlink

> TODO
