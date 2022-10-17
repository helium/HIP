# HIP1: Longfi and LoRaWAN

- Start Date: 2020-02-18
- HIP PR: [#10](https://github.com/helium/HIP/pull/10)

# Summary

LongFi is not a full protocol from the ground up, but instead a blockchain
layer on top of LoRaWAN. This allows any off-the-shelf LoRaWAN device to
connect to the Helium network if you can update its AppKey and AppEui.

# Motivation

There are many LoRaWAN compatible devices already out there and LoRaWAN already
has many desirable protocol features (ACK, downlink, FCC certified,
international specification). In order to accelerate adoption of the Helium
network and to lower technical barriers, LongFi is no longer a distinct
protocol from LoRaWAN but instead a layering of some blockchain components on
top of LoRaWAN.

# Stakeholders

- LoRaWAN device users

# Detailed Explanation

This initial implementation of LongFi on LoRaWAN focuses on a single method of
end-device activation: Over-the-Air Activation (OTAA). Activation by
Personalization (ABP) is currently not supported.

In the US902-928 regulatory domain, the Helium network will operate on LoRaWAN
channels 48-55 (sub-band 7):

```
Channel 48, 911.900 Mhz
Channel 49, 912.100 Mhz
Channel 50, 912.300 Mhz
Channel 51, 912.500 Mhz
Channel 52, 912.700 Mhz
Channel 53, 912.900 Mhz
Channel 54, 913.100 Mhz
Channel 55, 913.300 Mhz
```

In OTAA, DevEUI, AppEUI, and AppKey are all the unencrypted LoRaWAN primitives
used in the Join Request:

```
___________________________________________________________
|   Size (octets)  |      8     |      8     |      8     |
|   Join Request   |   AppEUI   |   DevEUI   |  DevNonce  |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

<sub>source: LoRaWAN Specification 6.2.4</sub>

The LongFi primitives of Organizational Unique Identifier (OUI) and DeviceId
are mapped into AppEUI. The most significant 4 octets are OUI while the least
significant 4 octets are DeviceId.

```
_______________________________________________
|               AppEUI (8 octets)             |
|     OUI (4 octets)   | DeviceId (4 octets) |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

Thus Helium miners receiving these unencrypted Join messages are able to route
the request to the appropriate Router (ie: a NetworkServer) by deriving the OUI
from the AppEUI and then looking up the OUI route from the blockchain records.

DevEUI currently plays no role in LongFi, but remains important for LoRaWAN
functions.

Assuming the OUI is registered in the blockchain appropriately, hotspots will
route the JoinRequest packet to the appropriate Router. The Router will use
the Message Integrity Check (MIC) to authenticate the JoinRequest and, if
successful, an unencrypted JoinAccept message will be communicated down to the
hotspot which transmits to the device, providing a NetId, DevAddr, and AppNonce.

```
_______________________________________________________________________________________________
|   Size (octets)  |      3     |    3    |    4    |      1       |    1     | (16) Optional |
|   Join Accept    |   AppNonce |  NetId  | DevAddr |  DLSettings  | RxDelay  |   CFList      |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

<sub>source: LoRaWAN Specification 6.2.5</sub>

Thanks to the shared secret AppKey, these fields allow the Device and Router to
privately derive the same NwkSKey and AppSKey (LoRaWAN Specification 6.2.5).
Henceforth, payloads are encrypted using NwkSkey and AppSkey (LoRaWAN
Specification 4.3.3).

The DevAddr is used by LongFi to indicate the OUI and this is part of the Frame
Header Structure (FHDR) of all messages after the successful Join; this enables
hotspots to continue forwarding packets to the appropriate Router.

The Router/NetworkServer derives the DeviceId by bruteforcing the MIC against
its list of active session keys.

According to "LoRaWAN Regional Parameters 2.24: US902-928 JoinAccept CFList",
the optional CFList parameter is ignored by the device if appended to the
Join-Response. For this reason, the MAC Command (LoRaWAN Specification 5)
LinkADRReq is used to set a channel mask appropriate for the Helium Network.
MAC commands can only be piggybacked onto a MACPayload, therefore, these will
only be sent when there is a downlink message (ie: not a Join-Response).

# Drawbacks

- Devices are required to update their AppKey and AppEUI to join the Helium
Network
- There is no "Fingerprint" mechanism. That is to say, there no way for a
Router to validate a message before accepting it from a Hotspot; therefore,
Hotspot will forward packets without any negotiation with Routers.

# Rationale and Alternatives

- A standalone LongFi protocol was taking too long
- Modifications to the LoRaWAN specification may be made later to try to
address any architectural shortcomings

# Unresolved Questions

# Deployment Impact

# Success Metrics
