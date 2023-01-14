# HIP 46: LoRaWAN NetID Routing

- Author(s): [@lthiery](https://github.com/lthiery)
- Start Date: 2021-10-26
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/300>
- Tracking Issue: TBD
- Status: Approved

## Summary and Motivation

There are two types of LoRaWAN frames: Join and Data. These each have their own header to enable
routing. On the Helium Network, we have a mechanism for routing each type of packet to the
appropriate Organizational Unique Identifier (OUI). OUI operators are the entity that purchases
packets on the Helium Network.

### Join Frame

```
+---------------------------------------------------------+
|   Size (octets)  |      8     |      8     |      8     |
+------------------+------------+------------+------------+
|   Join Request   |   JoinEUI   |   DevEUI   |  DevNonce  |
+---------------------------------------------------------+
```

Join frames are routed on the Helium Network thanks to the filters maintained by each OUI. These
filters are written onto the blockchain by the OUI operator and indicate interest in purchasing
those Join frames that have matching (JoinEui, DevEui). When a hotspot (LoRaWAN gateway) receives a
Join packet, it will cycle through each OUI and each filter for each OUI to check if they are
interested in this Join frame.

### Data Frame

```
+----------------------------------------------------------------------+
|   Size (octets)  |     4      |      1     |      2     |    0..15   |
+------------------+------------+------------+------------+------------+
|   FHDR           |  DevAddr   |    FCtrl   |     FCnt   |    FOpts   |
+----------------------------------------------------------------------+
```

Data frames are routed thanks to their DevAddr. The DevAddr is assigned after a successful Join
(JoinRequest followed by JoinAccept). The DevAddr field is as follows:

```
+------------------------------------------------+
|                     DevAddr                    |
+------------------------+-----------------------+
|   NwkID (bits 31–25)   |  NwkAddr (bits 24–0)  |
+-----------+--------------------+---------------+
|     Helium Network     |   allocated by slab   |
|        NetworkID       |      to OUIs          |
+-----------+--------------------+---------------+
```

If the NwkID (aka NetID) matches that of the Helium Network, the bottom 25-bits, aka: NwkAddr, is
used to determine which OUI this device belongs to. OUIs can purchase one or many "slabs" of
NwkAddrs; they can then allocate devices to these addresses in their JoinAccept responses and expect
that hotspots will offer these Data frames to them.

### Non-Helium NetIDs

Currently, packets that are not under the Helium NetID are dropped. They belong to other networks,
such as Actility or Senet. However, these other networks have manifested interest in purchasing
these packets and thus "roaming" on the Helium Network. Ultimately, enabling this makes the existing
infrastructure more valuable as the same hotspots (LoRaWAN gateways) can provide coverage for these
existing LoRaWAN Networks.

**We need a way to tell hotspots that one or many OUIs is interested in purchasing Data frames from
another network.** The existing mechanism for Join frames requires no changes.

## Solution

We propose to create a new `chain_var` that maps NetID to OUI. It will be of the following type:

```
[{<<netid:32/integer>>, <<oui:64/integer>>}]
```

This mapping will be maintained by the DeWi LoRaWAN Committee who can receive requests from NetID
owners to route these frames to one or many OUIs. The entity making the request must be confirmed by
the contact person listed in the LoRaWAN Alliance NetID registry, which DeWi has access to as a
LoRaWAN Alliance Contributor. The OUI operator(s) need not be the same as the entity making the
request.

## Alternate Solutions

We could conceive of a system where any OUI operator could submit interest in purchasing packets for
a NetID via a permissionless transaction. However, this is a direct violation of LoRaWAN Alliance
requirements agreed by DeWi upon joining the LoRaWAN Alliance and receiving a LoRaWAN NetID
allocation. Furthermore, bad actors could exploit this mechanism to harvest data from the Helium
Network without even compensating hotspot operators.
