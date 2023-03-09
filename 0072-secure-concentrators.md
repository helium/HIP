# HIP-72: Secure Concentrators

- Author(s) @Dinocore
- Start Date: Oct 1, 2022
- Category: Technical
- Original HIP PR: #484
- Tracking Issue: #489

## Summary

In this HIP, we propose a new type of IoT network actor: the Secure Concentrator Card (SCC). Secure
Concentrator Card is similar to standard LoRaWAN concentrator cards, but with additional Secure
Microcontroller Unit (SMCU) and onboard GPS receiver. The SMCU digitally signs LoRa data packets as
they are received from the radio. In this way, packet data and its corresponding metadata (RSSI,
Frequency, GPS location and time) can be verified to be authentic.

- Secure Concentrators are _optional._ There is **no** requirement to upgrade or purchase new
  hardware. Helium Hotspots without Secure Concentrator will continue functioning as normal.
- Helium Hotspots with Secure Concentrators will earn **1.25x** rewards. (See _Proof Of Coverage
  Rewards_ section)

## Motivation

Today's Helium Hotspot have a large security flaw. Anyone can modify the software running on a
Hotspot and generate fake LoRa packets. This is a big problem because PoC rewards are based on these
packets. The new Secure Concentrator Card solves this problem by digitally signing packets in
hardware. Secure Concentrators make it _prohibitively_ difficult to game the PoC system by also
utilizing tamper-resistant design elements (routed traces, hard cured potting material, etc). The
end result is a more secure Physical Root of Trust for the Helium IoT system and fair PoC earnings
for all.

The proposed SCC design allows existing Helium miners to upgrade by swapping out existing
concentrator cards with new secure card. In addition, SCC would enable the DIY community to build
their own hardware, greatly increasing the diversity and proliferation of Hotspots.

## Stakeholders

The entire IoT Helium network will be affected by this HIP as the introduction of SCC will create a
reliable source of data to base Proof of Coverage algorithms on. SCC will also enable DIY Hotspot
builds increasing the diversity and proliferation of Helium Hotspots. Finally, SCCs will enable a
new type of location service for low-power devices (TDoA).

## Detailed Explanation

### Design Goals

- Increase security level of Helium's Proof-of-Coverage.
- Ability to replace/upgrade existing Miner's concentrator card with secure concentrator card
- Turn off-the-shelf LoRaWAN gateways into full PoC Helium miner (DIY Hotspot)
  - Secure Concentrators effectively replace the need for ECC806 security chip as mandated in
    HIP-19.
- Enable new class of Helium nodes that can provide additional functionality (LoRa PoC Mapper?
  Mobile Hotspot?)
- Enable new level of Proof-of-Coverage verification (possibly using Time Difference of Arrival
  (TDOA))

### Hardware Architecture

![image ](0072-secure-concentrators/hardware_block.png) The new hardware architecture for SCC is
based on Semtech's LoRa Corecell Gateway reference design. The major change involves the addition of
a Secure MCU (**SMCU**) placed in between the communication path of the Host CPU and the SX1303. The
SMCU's primary job is to cryptographically sign RF data received over the air such that other nodes
participating on the Helium network are able to verify the data is authentic and unaltered from it
original form. It is important the SMCU has exclusive access SX1303's SPI bus to eliminate the
possibility of spoofing incoming RF packets. The hardware design will consider several techniques to
make it physically difficult to access the SMPU and SX130x including using buried traces, placing
the components under a metal shield, and/or using potting material.

### Hardware Key

The SMCU stores a unique ED25519 keypair generated at manufacturing time in its non-volatile memory
known as the **Hardware Key**. Note: the Hardware Key is not the same as the `swarm_key`. This is an
important concept as it allows existing Miner's to upgrade their existing concentrator card with new
SCC. The Hardware's private key is considered a secret and stored in a special section of the SMCU
non-volatile memory used for secure storage. Secure storage can not be read-out and is not
accessible to the Host CPU or via hardware debugging tools.

The Hardware Key can also be used to sign other types of transactions beyond RF data. However, it
does not allow signing _arbitrary_ data. Doing so would put the security on par with existing HIP-19
secure element approach and thus defeat the purpose of this HIP. Note: If the SMCU's firmware
allowed for signing arbitrary data with its Hardware Key, an attacker could jailbreak the Host CPU
and craft a signing request that contained fake RF data.

### Semtech SX1303

The Semtech SX1303 is a new generation of LoRa baseband processor for gateways. It is size and pin
compatible with SX1302 and like SX1302, it excels in cutting down current consumption, simplifying
thermal design, lowering Bill Of Materials cost, and reducing overall size of gateways. In addition
to supporting all the features of SX1302, SX1303 introduces a new Fine Timestamp capability that
enables Time Difference of Arrival (TDOA) network-based geolocation. The new TDOA feature could
potentially enable another layer of Proof of Coverage. For example, Helium Hotspots using SX1303
chipset could coordinate together to assert that another Helium Hotspot's beacon signal actually
originated from the stated geo-location.

### GPS Receiver

The GPS receiver is a required component. GPS provides geolocation and timestampling of every
received packet. GPS is also needed to provide precise timing required for the Semtech SX1303 TDOA
feature.

### RF Data Signature

![image ](0072-secure-concentrators/rf_signing.png)

Semtech's open-source LoRa packet forwarder is traditionally the software that runs on the Host CPU
and reads data from the SX130x hardware via SPI or USB. The packet forwarder produces output JSON
formatted data when RF data is received. We propose modifying the packet forwarder software to
include an additional key/value pair containing the RF data cryptographic signature.

```
{
  "rxpk": {
    "tmst":20900514000,
    "chan":2,
    "rfch":0,
    "freq":866.349812,
    "stat":1,
    "modu":"LORA",
    "datr":"SF9BW125",
    "codr":"4/6",
    "rssis":-108,
    "rssic":-45,
    "lsnr":-12.8,
    "size":23,
    "data":"AMy7qgAAAAAATYMmmnj6AADl6YP1Jrw",
    // New fields below
    "hw_sig": "HsOIwoZaHB8Iw4LDq1QTwqV0w7HDqcOOHRxvdQ8vwobDjsO2Jg7CnRrDtHLDtA==",
    // optional fields below
    "gps_time_s": 465465,
    "gps_time_ns": 322983,
    "gps_lat": 48.858288,
    "gps_long": 2.294479,
    "gps_alt": 10,
  }
}
```

### Sign Non-RF data

The SMCU can also sign non-RF data with its Hardware Key upon request. The signature will always
include the string prefix `nonrf` in its message creation to distinguish from RF data.

```
payload_hash = sha512(payload | int32_msb(payload size))
msg = 'nonrf' | payload_hash | int32_msb(tmst)
signature = ed25519_sign(msg, pubKey, privKey)
```

## Secure Firmware

The firmware running on Secure Concentrator's SMCU is licensed under the GPLv3 open-source license.
It's code repository is kept public and maintained by the Community. The firmware itself has a
bootloader that checks the cryptographic signature of the application image at each power up to
ensure it is unaltered from its original form. The key used to sign the application image is called
the `App Signing Key`. The firmware actually has two App Signing Keys slots. One of the key slots
must be populated with Helium Foundation's App Signing Key. The other key slot can optionally be
populated with a Manufacturer's App Signing Key. Helium Foundation will use its App Signing Key to
sign firmware from the official open-source repository. Manufacturers can optionally fork the
open-source repository and create changes specific to their hardware variants. Manufacturer's must
comply with the reciprocal nature of the GPLv3 license and make their modifications compatible with
the GPLv3.

The intention of the "two-slot" scheme is to always allow any Secure Concentrator produced by any
Manufacture to be updated with the official open-source firmware. In the case a Manufacture goes out
of business or otherwise unable to provide support for their hardware, owners of Secure
Concentrators can always choose to run the open-source firmware.

## Proof of Coverage Rewards

In order to incentivize adoption of Secure Concentrators, we propose increasing the earnings of PoC
Witness packets received by Secure Concentrator by a factor of **(1.25x)**. We believe this is
justified due to the increased security benefits the entire Helium network will enjoy with the
addition of Secure Concentators. A Secure Concentrator is only eligible for the PoC bonus if the
Witness packet includes valid GPS time and location data. If a Secure Concentrator does not have a
valid GPS lock at the time of receiving the Witness packet, it will only receive the normal (1.00x)
reward.

This incentive structure is part of a larger future roadmap with more network improvements and
hardware types that will each have their own incentives.

## Manufacturers

Hardware Manufacturers of Secure Concentrators will be required to be approved by the Helium
Manufacturer Compliance Committee and pass a hardware audit process similar to the hardware audit
process required for Hotspot manufacturers (see HIP-19).

Responsibility for installation and service:

- Manufactures can include SCCs in Hotspots, in which case Manufactures are responsible for
  providing installation and service.
- Hotspot owners can buy and install SCCs in which case the Hotspot falls under the OEM's warranty.
- Note: upgrading an existing Hotspot with SCCs may require changes to the Hotspot firmware. It is
  the Hotspot Manufacture's discretion to provide support for SCCs.

Responsibility for MCC audit

The hardware audit process for SCCs are exactly the same as the process for Hotspot hardware under
HIP 19.

- MCC audits the SCC design and implementation.
- Use of SCC in Hotspot design satisfies the HIP 19 requirement for Encrypted/locked-down firmware
  and Encrypted storage of the miner swarm_key. To be clear, Hotspots that use SCC will not be
  required to have locked-down firmware and will not be required to securely store the swarm_key.
  (Note swarm_key is not the same as the SCC's Hardware Key).

## Onboarding

Onboarding refers to the action a Manufacture takes to add new Secure Concentrator Hardware Keys to
the blockchain. Onboarding will occur at a time before being shipped to final customers. a Secure
Concentrator is only capable of earning Proof of Coverage rewards after its Hardware Key has been
Onboarded. Onboarding is fully automatic processes performed by interacting with a Solana Smart
Contract.

Manufacturers will be required to deposit $10 USD of collateral into a Smart Contract for each
Secure Concentrator they produce. The collateral (AKA 'stake') will be locked in a Smart Contract
and slowly paid back to the Manufacturer over a three (3) year period. If a Manufacturer is found to
have violated any of the terms of the Helium Foundation Ethics document (as determined by the Helium
Tribunal Process), their staking balance can be partially or fully Burned. The "Burned" action is
defined as converting the offending Manufacturer's collateral balance into HNT and then removing the
resulting HNT from circulation permanently.

The Smart Contract will hold Manufacturer's stake balance in HNT. The Smart Contract will use the
HNT price oracle to dynamically calculate $10 USD worth of HNT at the time of Onboarding
transaction.

## Hotspot Mechanics

Registering a Hotspot that uses a Secure Concentrator is similar process to registering a Data-Only
Hotspot. First, the Hotspot generates a new random `swarm_key`. Unlike other Hotspot types, the
`swarm_key` on a Secure Hotspot is not considered a high priority secret because it is not used for
earning PoC rewards. As such, it is not required to store the `swarm_key` in a secure element. In
fact, a Secure Hotspot is not required to have a hardware secure element at all (can store in
flash). Next, a transaction is sent to the blockchain defining the new Hotspot as a 'secure' type.
This transaction includes the `swarm_key` and the Secure Concentrator's Hardware Key and is signed
by both keys. If this is the first time the Secure Concentrator's Hardware Key is used to bind
`swarm_key` and Hardware Key together, there is no fee. Otherwise, there is a small $5 fee. Note:
this mechanism enables several things that are currently difficult or impossible such as resale of
Secure Concentrators/Hotspots on the secondary market and repurposing Hotspots with lost keys or
Hotspots on the denylist.

Secure Hotspots do not require Location Assertion transactions. In fact, Secure Hotspots are free to
continually move their location because the GPS location metadata is included in the signed packets.
Secure Hotspots are still subject to the same density scale rules.

## Reference Hardware Design

NLighten Systems has developed Open-Source hardware and firmware Secure Concentrator reference
design. The design files can be found here: https://gitlab.com/nlighten-systems/kompressor/

## Drawbacks

## Rationale and Alternatives

The proposed architecture of SCC is the best possible design because it cleanly and securely
decouples low-level RF packet data from high-level Helium network protocol and constructs. This
decoupling is important because we expect the Helium network protocol to continue to grow and evolve
in the future and it would be prohibitively difficult to maintain SMCU firmware to keep up. This
architecture also enables potential new class of Helium nodes that can provide additional future
functionality. For example, a SCC could be used in a PoC Mapper device to securely verify coverage
in remote locations. Perhaps most importantly, this architecture can be used to upgrade existing
Helium miners providing reliable data to PoC algorithms.

## Unresolved Questions

## Deployment Impact

Changes to the blockchain code will need to be made and tested on the `testnet`. When ready, these
changes can be merged to `mainnet` but should have no impact on existing nodes. These changes are
backwards compatible. Upgrading an existing miner with new SCC should not require any action on the
Hotspot owner's part.

## Success Metrics

SCC success can be measured several ways. One metric will be the number of DIY Hotspots and Secure
mapper devices built with SCC. Another metric is the amount of low-power sensors that utilize the
TDoA location services SCC provide. Also the amount of DCs associated with those sensors. Finally,
Secure Concentrators will enjoy in the success of any future PoC algorithm that utilizes its data.
