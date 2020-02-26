- Start Date: 2020-02-26
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

Data Credits have a fixed value of $.00001 per 24 bytes. There were original 
consideration to charge for Time-on-Air, but a fixed price for data usage was
settled upon to simplify the experience of network users.

However, how are bytes counted? Between the LoRa Physical Header, the LoRaWAN/MAC header, and the Application/MAC Payload, there are several ways of slicing it.

This proposal here is to charge for Application/MAC Payload exclusively, but to
charge 1 DC per Join uplink and 1 DC per JoinAccept downlink.

In addition, we propose to round up DC costs. Therefore, if I transmit a DataUp
frame with 55 bytes: `55/24.0 ~= 2.3 DCs => 3 DCs` burned on behalf of the
Hotspot delivering the packet.

# Motivation
[motivation]: #motivation

Striking the balance here means being fair to both sides of the market: Users and
Operators.

# Stakeholders
[stakeholders]: #stakeholders

* Helium Network Users
* Helium Network Operators

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

When an Operator transmits or receives a packet, they are unable to transmit 
and/or receive packets. As such, we must fight against exploits and charge a fee
for Join and JoinAccept frames.

When a User considers the Helium Network, they know about their application, and
so have ideas of how large their payloads are, but may not know of the nuances
of LoRa or LoRaWAN versus other modulations or protocols. To help them make the
business decision to use the Helium Network, we believe it to be best to discuss
data costs in terms of Application/MAC payloads.

By charging essentially 2 DC to "make the initial connection" and 1 DC per 24
bytes of application data, we can resolve both points.

The 2 DC (1 up, 1 down) to make the connection can almost be ignored from a
costing perspective, as devices can use a Sessions as long as they can preserve
the session keys on both devices and network server (weeks, months, years).

Therefore, being able to simply calculate how much Application Payload is being
sent per packet to estimate the cost of the Helium network will be very simple
and reduce friction for potential Helium Network Users.

The rounding of DCs are a point on their own. DCs are atomic (and very low
in value), so rounding up per 24 bytes used seems fair. But combined with
Time-on-Air restrictions due to regulatory bodies such as FCC and ETSI,
the estimated cost of data may lead to unexpected results.

For example, running in SF9, a device can only send 55 bytes in the MACPayload.
`55/24.0 ~= 2.3 DCs` and I would be expected to pay 3 DCs.

But to construct a pathological example, if for some reason, I needed to
transmit a 56th byte, I would have to send a full second packet which would
cost a full third DC. Therefore, I would need to pay 4 DCs even though I may
have calculated `56/24.0 ~= 2.33`

However, we believe that with an online calculator and spreadsheet resources,
we can help Network Users understand and avoid this misunderstanding.

# Drawbacks
[drawbacks]: #drawbacks

- We must establish a clear definition of how DCs are expensed. Not doing so
will cause confusion amonst both Operators and Users.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

## Charge for Time-on-Air
This solution requires too much low-level knowledge of Network Users, although
it would perhaps be the most "fair" in terms of what resource is being used

## Charge for Bytes

Before dicussing the remaining alternatives, it may be helpful to visualize the
three nested layers of a LoRaWAN radio packet:

Radio PHY Layer

```
___________________________________________________
| Preamble | PHDR | PHDR_CRC |**PHYPayload**| CRC |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

PHYPayload

```
_______________________________________________________
| MHDR | **MACPayload/JoinRequest/JoinResponse** |MIC |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```
## Charge for Full PHY Layer

It is possible to charge for everything sent in the PHY layer, but this would
cause friction for the same reasons charging for Time-on-Air would cause
friction. It requires too much low-level knowledge for users to estimate cost.

## Charge for Full PHYPayload

Since MHDR and MIC are fixed and this would add some fixed overhead to every
packet fragment.These fields are negligible in size though and add complexity.

## Charge for MACPayload only

This would be simplest but would make JoinRequest/Response free. This would
open up a simple way to use the network for free by sending payloads in the
JoinRequest/JoinResponse frames.
