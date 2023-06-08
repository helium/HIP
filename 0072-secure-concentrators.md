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

The Secure Concentrator signs LoRa packets and metadata with its unique ED25519 Hardware Key. To optimize for low-latency, the unsigned data if first sent to the host CPU and the packet signature is later computed. This design allows the host CPU to serve latency-sensitive applications.

Signing data packets is performed by first converting the packet's metadata, payload, gps time, and location into a byte stream. The data is encoded using [Borsh](https://borsh.io/) serialization.

Here we have the structure of received LoRa packets and metadata.
```
struct RxPkt {
  /// Frequency in Hertz
  pub freq: u32,
  /// Datarate. Something like "SF7BW125"
  pub datarate: String,
  /// Signal to Noise radio (in 0.01 dB)
  pub snr: i16,
  /// Received Signal Strength Indicator (in 0.1 dBm)
  pub rssi: i16,
  /// 32 Mhz clock timestamp
  pub tmst: u32,
  /// Unique identifier of the Secure Concentrator.
  pub card_id: [u8 ; 8],
  // timestamp the packet was received (nanoseconds since the GPS epoch 1980-01-06 0:00 UTC)
  pub gps_time: Option<u64>,
  pub pos: Option<WGS84Position>,
  pub payload: Vec<u8>,
}

struct WGS84Position {
  /// longitude (deg) 1e-7 scale
  pub lon: i32,

  /// latitude (deg) 1e-7 scale
  pub lat: i32,

  /// Height above ellipsoid (millimeters)
  pub height: i32,

  /// Horizontal accuracy estimate (millimeters)
  pub hacc: u32,

  /// Vertical accuracy estimate (millimeters)
  pub vacc: Option<u32>,
}
```

### Example Signature
```
let pkt = RxPkt {
  freq: 904_000_000,
  datarate: "SF7BW125",
  snr: -1200,
  rssi: 100,
  tmst: 10_000,
  card_id: [1, 2, 3, 4, 5, 6, 7, 8],
  gps_time: Some(1209600100000000000),
  pos: Some(WGS84Position {
      lat: 7353466,
      lon: -3588727,
      height: 38472,
      hacc: 3425,
      vacc: Some(683485),
  }),
  payload: b"hello world",
};

// The above example encoded with Borsh serialization results in the following hex-encoded data:

00f2e13508000000534637425731323550fb64001027000001020304050607080100e8c6d8e15cc91001893dc9ff7a34700048960000610d000001dd6d0a000b00000068656c6c6f20776f726c64

```

Given the following private key and noise initiation, the resulting ED25519 signature of the above data would be:

```
private key: 38870584fa7cb9e56efe921a65e02fcc18d6d8e9fcfec7796181f422e6aa1e3fd466e616d43b44e2e045be240ad9faf7090fb444312445cef01f21ed5f74e55e
noise: 000102030405060708090a0b0c0d0e0f
sig (ED25519): c90fce6cc6810b6099cadfeb276a9b49077ec88a421d49045e1c7220fe459e081e75e4b77af51178396d1a94be3d6800b93605afe9fd5165134893c4b04e550b
```

Note: Secure Concentrators use ED25519 streaming (incremental) API for producing encrypted signatures.

### Sign Non-RF data

The SMCU can also sign any arbitrary data with its Hardware Key upon request. However, the signature will always include the string prefix `nonrf` in its message creation to distinguish from RF data.

For example, signing the ascii-encoded byte array: `hello world` would result:
```
private key: 38870584fa7cb9e56efe921a65e02fcc18d6d8e9fcfec7796181f422e6aa1e3fd466e616d43b44e2e045be240ad9faf7090fb444312445cef01f21ed5f74e55e
noise: 000102030405060708090a0b0c0d0e0f
sig (ED25519): 388609f27448a6981876edac0b9ed13f65015b36e48963056393434f562af0763ce81971c5421e0d54014fed3f7003489847241971e8c0be0d5f70bcee7fc500
```

Note: Secure Concentrators use ED25519 streaming (incremental) API for producing encrypted signatures.

## Secure Firmware

The firmware running on Secure Concentrator's SMCU is licensed under the GPLv3 open-source license.
Its code repository is kept public and maintained by the Community. The firmware itself has a
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
Manufacturer to be updated with the official open-source firmware. In the case a Manufacturer goes
out of business or otherwise unable to provide support for their hardware, owners of Secure
Concentrators can always choose to run the open-source firmware.

## Proof of Coverage Rewards

In order to incentivize adoption of Secure Concentrators, we propose increasing the earnings of PoC
Witness packets received by Secure Concentrator by a factor of **(1.25x)**. We believe this is
justified due to the increased security benefits the entire Helium network will enjoy with the
addition of Secure Concentators. A Secure Concentrator is only eligible for the PoC reward if the
Witness packet includes valid GPS time and location data. If a Secure Concentrator does not have a
valid GPS lock at the time of receiving the Witness packet, it will not receive any reward.

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

Onboarding refers to the action a Manufacture takes to add new Secure Concentrator Hardware Key to
the blockchain. Onboarding will occur at a time before shipping to final customers. a Secure
Concentrator is only capable of earning Proof of Coverage rewards after its Hardware Key has been
Onboarded.

Manufacturers will be required to stake $10 USD worth of HNT (as determined by HNT price oracle
using the trailing 30-day average from the time of the staking transaction) for each Secure
Concentrator they produce. The staking period is fixed at three years. The HNT is converted to veHNT
and automatically 100% delegated to the IoT subDAO. Any earning generated as a result of staking
activity is transferred to the Manufacturer wallet as per usual. If a Manufacturer is found to have
violated any of the terms of the Helium Foundation Ethics document (as determined by the Helium
Tribunal Process), their staking balance can be partially or fully Burned. The "Burned" action is
defined as converting the offending Manufacturer's stake balance into HNT and then removing the
resulting HNT from circulation permanently.

Onboarding is fully automatic processes performed by interacting with a Solana Smart Contract. A
Manufacturer will create an Oboarding transaction containing the new Secure Concentrator Hardware
Public key and $10 worth of HNT and send it to the Solana Smart Contract. The Smart Contract
processes the transaction, adds the Hardware Key to the blockchain, and converts the HNT to veHNT
and delegates 100% to IoT subDAO for a period of three years.

## Hotspot Mechanics

Registering a Hotspot that uses a Secure Concentrator is similar process to registering a Data-Only
Hotspot. First, the Hotspot generates a new random `swarm_key`. Unlike other Hotspot types, the
`swarm_key` on a Secure Hotspot is not considered a high priority secret because it is not used for
earning PoC rewards. As such, it is not required to store the `swarm_key` in a secure element. In
fact, a Secure Hotspot is not required to have a hardware secure element at all (can store in
flash). Next, a transaction is sent to the blockchain defining the new Hotspot as a 'secure' type.
This transaction (the Binding transaction) includes the Hotspot's `swarm_key`, the Secure
Concentrator's Hardware Key, and the Hotpot Owner's wallet address. The Binding transaction is
signed by all keys. The first time the Secure Concentrator's Hardware Key is used in a Binding
trasaction, there is no fee. Every subsequent Binding transaction cost 500000 DC ($5 USD). Note:
this mechanism enables several things that are currently difficult or impossible such as resale of
Secure Concentrators/Hotspots on the secondary market and repurposing Hotspots with lost keys or
Hotspots on the denylist.

For clarity, Hotspots with Secure Concentrators are not subject to any fees when adding a Hotspot to
the blockchain (with the exception of the $5 'Binding' fee which is only applicable for subsequent
Binding transactions). Hotspots with Secure Concentrators are not subject to Assert Location fees.
In fact, Secure Hotspots are free to continually move their physical location because the GPS
metadata is included in the signed packets. Secure Hotspots are still subject to the same density
scale rules.

Note: the Binding transaction still requires a small Solana transaction fee. It is expected that
initial transaction fee will be paid out of the Maker's wallet. Subsequent binding transaction fees
will be covered from the Hotspot owner's wallet.

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
