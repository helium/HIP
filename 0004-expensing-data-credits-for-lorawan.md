# HIP4: Expensing data credits for LoRaWAN traffic

- Start Date: 2020-02-26
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary

Data Credits have a fixed value of $.00001 per 24 bytes. There were original
consideration to charge for Time-on-Air, but a fixed price for data usage was
settled upon to simplify the experience of network users.

However, how are bytes counted? Between the LoRa Physical Header, the
LoRaWAN/MAC header, and the MAC Payload, FOpts and FRMPayload there are several
ways of deciding how to meter bytes.

This proposal here is to charge for **FOpts** and **FRMPayload** exclusively,
but to charge 1 DC per Join uplink and 1 DC per Join-Accept downlink. In
addition, any packet up or down will cost at
least 1 DC.

FOpts are fifteen optional bytes used almost exclusively for MAC Commands.

FRMPayload are essentially the application data.

By defining things this way, we can keep the data calculations very simple for
network users, while also protecting against simple ways to move additional
data "for free".

Finally, the minimum charge of 1 DC for any packet assures that ACK packets
are not free despite having potentially empty FOpt or FRMPayload fields.

Meanwhile, for network operators, there may be some confusion as "bytes on
[LoRaWAN] air" do not match 1:1 bytes over the Internet backhaul. Radio packet
context is communicated (frequency, spreading factor, FCnt, etc). And should
the miner be colocated on the Hotspot, the message delivery protocol between
Miner and the Router/Network Server will create additional overhead.

Finally, we do propose to round up DC costs; in a way this does mitigate this
point above. Therefore, if I transmit a DataUp frame with 55 bytes:
   `55/24.0 ~= 2.3 DCs => 3 DCs`
burned on behalf of the Hotspot delivering the packet.

# Motivation

Striking the balance here means being fair to both sides of the market: Users and
Operators.

# Stakeholders

- Helium Network Users
- Helium Network Operators

# Detailed Explanation

When an Operator transmits or receives a packet, they are unable to transmit
and/or receive packets. As such, we must fight against exploits and charge a fee
for Join and Join-Accept frames.

When a User considers the Helium Network, they know about their application and
likely can estimate how large and frequent their payloads are. On the other
hand, they are not expected to know of LoRa/LoRaWAN's many nuances. We believe
the highest priority is to simplify their DC estimations as much as possible
in order to lower the barriers of adoption.

By charging essentially 2 DC to "make the initial connection" and 1 DC per 24
bytes of application data (ie: FRMPayload) and network command data (ie: FOpts), we can resolve both points.

In addition, we charge for FOpts which is only used when issuing MAC Commands;
these are generally advanced networking messages which fine tune how the device
operates within the LoRaWAN stack. It is assumed that only sophisticated users
would be using and thus would need to account for these. Not charging for these
opens up an easy to manipulate field.

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

For example, running in SF9, a device can only send 55 bytes in the FRMPayload.
`55/24.0 ~= 2.3 DCs` and I would be expected to pay 3 DCs.

But to construct a pathological example, if for some reason, I needed to
transmit a 56th byte, I would have to send a full second packet which would
cost a full third DC. Therefore, I would need to pay 4 DCs even though I may
have calculated `56/24.0 ~= 2.33`

However, we believe that with an online calculator and spreadsheet resources,
we can help Network Users understand and avoid this misunderstanding.

# Drawbacks

- We must establish a clear definition of how DCs are expensed. Not doing so
will cause confusion amonst both Operators and Users.

# Rationale and Alternatives

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

MACPayload

```
________________________________
| **FHDR **| FPort |FRMPayload |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

FHDR

```
__________________________________
| DevAddr | FCtrl | FCnt | FOpts |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
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

## Charge for FRMPayload only

This would make the entire FHDR free. Meanwhile, the FHDR has the FOpts field
for MAC Command transport, which would be easy to exploit for free transmission
of data.
