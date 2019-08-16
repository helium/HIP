- Start Date: 2019-08-16
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

This HIP proposes the high-level semantics of LongFi, the Helium
network's wireless protocol.

# Motivation
[motivation]: #motivation

Providing wide-area wireless connectivity is the Helium network's
_raison d'être_. Providing this connectivity in a manner that is
implementable by both Helium and third-parties requires a free and
open protocol that devices, hotspots, and routers understand.

This proposal is not an all-encompassing specification but lays the
foundation for further HIPs which will serve as the specification.

# Stakeholders
[stakeholders]: #stakeholders

<!-- * Who is affected by this HIP? -->

<!-- * How are we soliciting feedback on this HIP from these stakeholders? Note that -->
<!--   they may not be watching the HIPs repository or even aren't directly active in -->
<!--   the Rust Async Ecosystem working group. -->

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

<!-- - It should be reasonably clear how the proposal would be implemented. -->

<!-- - Provide representative examples that show how this proposal would be commonly -->
<!--   used. -->

<!-- - Corner cases should be dissected by example. -->

LongFi is not a protocol itself, but more of an umbrella for two
protocols operating in contiguous and non-overlapping layers of the
[OSI model](https://en.wikipedia.org/wiki/OSI_model), LowFi (layers 1
& 2), and HighFi (layers 3 & 4).

<table>
  <tr>
    <th>Layer</th>
    <th>Name</th>
    <th>Protocol</th>
  </tr>
  <tr>
    <td>4</td>
    <td>Transport</td>
    <td rowspan="2">HighFi</td>
  </tr>
  <tr>
    <td>3</td>
    <td>Network</td>
  </tr>
  <tr>
    <td>2</td>
    <td>Data Link</td>
    <td rowspan="2">LowFi</td>
  </tr>
  <tr>
    <td>1</td>
    <td>Physical</td>
  </tr>
</table>

## LowFi

LowFi is a low-level, non-reliable, protocol for exchanging datagrams
between devices and hotspots. LowFi datagrams are extremely simple,
and contain a minimal number of cleartext fields required for hotspot
to router forwarding.

### Datagram

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

## HighFi

HighFi, as its name suggests, sits atop LowFi. HighFi is responsible
for providing _reliable?_ two-way communication between devices and
routers.

...<!-- TODO: add detail -->

# Drawbacks
[drawbacks]: #drawbacks

<!-- - Why should we *not* do this? -->

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

<!-- This is your chance to discuss your proposal in the context of the whole design -->
<!-- space. This is probably the most important section! -->

<!-- - Why is this design the best in the space of possible designs? -->

<!-- - What other designs have been considered and what is the rationale for not -->
<!--   choosing them? -->

<!-- - What is the impact of not doing this? -->

# Unresolved Questions
[unresolved]: #unresolved-questions

<!-- - What parts of the design do you expect to resolve through the HIP process -->
<!--   before this gets merged? -->

<!-- - What parts of the design do you expect to resolve through the implementation -->
<!--   of this feature? -->

<!-- - What related issues do you consider out of scope for this HIP that could be -->
<!--   addressed in the future independently of the solution that comes out of this -->
<!--   HIP? -->

# Deployment Impact
[deployment-impact]: #deployment-impact

<!-- Describe how this design will be deployed and any potential imapact it may have on -->
<!-- current users of this project. -->

<!-- - How will current users be impacted? -->

<!-- - How will existing documentation/knowlegebase need to be supported? -->

<!-- - Is this backwards compatible? -->

<!--         - If not, what is the procedure to migrate? -->

# Success Metrics
[success-metrics]: #success-metrics

<!-- What metrics can be used to measure the success of this design? -->

<!-- - What should we measure to prove a performance increase? -->

<!-- - What should we measure to prove an improvement in stability? -->

<!-- - What should we measure to prove a reduction in complexity? -->

<!-- - What should we measure to prove an acceptance of this by it's users? -->
