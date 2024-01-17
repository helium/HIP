# HIP-72: Secure Concentrators

- Author(s) [@Dinocore](https://github.com/dinocore1)
- Start Date: Oct 1, 2022
- Category: Technical
- Original HIP PR: [#484](https://github.com/helium/HIP/pull/484)
- Tracking Issue: [#489](https://github.com/helium/HIP/issues/489)
- Voting Requirements: veIOT Holders

## Summary

In this HIP, we propose an amendment to HIP 19 to enable a new type of IoT network actor: a Secure Concentrator Card (SCC). A Secure Concentrator Card is similar to a standard LoRaWAN concentrator card, but with an additional Secure Microcontroller Unit (SMCU) and onboard GPS receiver. The SMCU digitally signs LoRa data packets as they are received from the radio. In this way, packet data and its corresponding metadata (RSSI, Frequency, GPS location and time) can be verified to be authentic. The primary intention of this HIP is to combat Proof-of-Coverage gaming. Secure Concentrators achieve this by providing trustworthy data upon which better gaming detectors and PoC algorithms can be built.

- Secure Concentrators are _optional._ There is **no** requirement to upgrade or purchase new
  hardware. Helium Hotspots without Secure Concentrator will continue functioning as normal.
- Helium Hotspots with Secure Concentrators will earn **1.25x** rewards. (See _Proof Of Coverage Rewards_ section)

## Motivation

Today's Helium Hotspots have a large security flaw. Anyone can modify the software running on a Hotspot and generate fake LoRa packets. This is a big problem because PoC rewards are based on these packets. The new Secure Concentrator Card solves this problem by digitally signing packets in hardware making it _prohibitively_ difficult to generate fake data.

Also, Secure Concentrators will provide the Helium PoC Oracles data about the local area in which they are deployed. The trustworthy data can be used to build the next generation of gaming detection AI and improved PoC algorithms. The end result is a more secure Physical Root of Trust for the Helium IoT system and fair PoC earnings for all.

This HIP defines general hardware requirements for a Secure Concentrator and provides an example open-source implementation. The proposed requirements allow existing Helium Hotspots to be upgradable to Secure Hotspots simply by swapping out existing concentrator cards with a new secure card. In addition, SCC would enable the DIY community to build their own hotspot hardware capable of earning PoC rewards, greatly increasing the diversity and proliferation of Hotspots.

## Stakeholders

The entire IoT Helium network will be affected by this HIP as the introduction of SCC will create a reliable source of data to base Proof of Coverage algorithms on. SCC will also enable DIY Hotspot builds increasing the diversity and proliferation of Helium Hotspots. Finally, SCCs will enable a new type of location service for low-power devices (TDoA).

## Detailed Explanation

## Design Goals

- Increase security level of Helium's Proof-of-Coverage.
- Ability to replace/upgrade existing Miner's concentrator card with secure concentrator card
- Turn off-the-shelf LoRaWAN gateways into full PoC Helium miner (DIY Hotspot)
  - Secure Concentrators effectively replace the need for ECC608 security chip as mandated in HIP-19.
- Enable new class of Helium nodes that can provide additional functionality (LoRa PoC Mapper? Mobile Hotspot?)
- Enable new types of Proof-of-Coverage verification (possibly using Time Difference of Arrival
  (TDOA))

## Proof of Coverage Rewards

In order to incentivize adoption of Secure Concentrators, we propose increasing the earnings of PoC Witness packets received by Secure Concentrator by a factor of **(1.25x)**. We believe this is justified due to the increased security benefits the entire Helium network will enjoy with the addition of Secure Concentrators. A Secure Concentrator Hotspot is only eligible for the PoC reward if the Witness packet includes valid GPS time and location data. If a Secure Concentrator does not have a valid GPS lock at the time of receiving the Witness packet, it will not receive any reward.

This incentive structure is part of a larger future roadmap with more network improvements and
hardware types that will each have their own incentives. The proposed 1.25x rewards is intended to incentivize initial adoption. The rewards structure is subject to change with adoption of future HIP.

## Manufacturers

Hardware Manufacturers of Secure Concentrators will be required to be approved by the Helium
Manufacturer Compliance Committee and pass a hardware audit process similar to the hardware audit process required for Hotspot manufacturers (see HIP-19).

The process of onboarding new Secure Concentrators onto the Helium network is very similar to the Hotspot onboarding process as described in HIP-19. Manufacturers will also be bound by the same code of ethics as described in HIP-19. Also, the Helium Manufacturing Compliance Committee (MCC) will have the same authority over approved Manufacturers.

## Installation

Hotspot owners can optionally upgrade their existing Hotspot with a Secure Concentrator if they have a Hotspot that is capable of the upgrade. Most Hotspot designs that use a mPCIe card slot are capable of the upgrade. However, upgrading a Hotspot may void the warranty. Hotspot manufacturers are NOT required to support upgrade to Secure Concentrator. It is the Hotspot Manufacturer's discretion to provide support for SCCs.

manufacturers can include SCCs in new Hotspots designs, in which case manufacturers are responsible for providing installation and service for Secure Concentrator. Use of SCC in Hotspot design satisfies the HIP 19 requirement for Encrypted/locked-down firmware and Encrypted storage of the miner swarm_key. To be clear, Hotspots that use SCC will not be required to have locked-down firmware and will not be required to securely store the swarm_key. (Note swarm_key is not the same as the SCC's Hardware Key).

## General Requirements

This HIP gives authority the MCC to design a process for approving Secure Concentrators. The approval process may involve engaging with 3rd party security labs for intensive hardware/software penetration testing. Ultimately, the MCC shall hold final approval power of a candidate Secure Concentrator design. That being said, a Secure Concentrator design should meet the following requirements:

### Hardware features

An SCC design must meet the following minimum hardware requirements:

- Onboard GNSS (GPS) receiver. GPS provides geolocation and timestamping reference of every received packet. The GPS horizontal and vertical position error must be less than 20 meters 99% of the time.
- Appropriate hardware to precisely timestamp the arrival of received LoRa packets on par with Semtech SX1303.
- Ability to sign the received LoRa packets and associated metadata (GPS location, time, frequency, etc.) with a secured asymmetric key (see further security requirements).

### Security requirements

An SCC design must meet all the following minimum security requirements:

1.  A Secure Element capable of managing a permanent, unique ED25519 asymmetric key.
2.  A Security Boundary that ensures that:
    - The Secure Element only obeys signature requests from a Secure Processor.
    - The radio hardware is exclusively controlled by the Secure Processor.
    - All packets and meta-data attested by the Secure Processor come only from the radio and not from an external source.
    - The Secret key is only used to sign packet and meta-data or data with `no-rf` prefix.
    - Read access to Secret key material is restricted to the Secure Processor only.
    - Write access to the Secret key material if forbidden.
3.  A Secure Processor that only runs software which has been cryptographically authenticated to have come from the Manufacturer (or the MCC).

No design will be approved unless it meets all criteria.

Example design choices that reflect these requirements are:

- Using buried traces (2 & 3)
- Placing components under metal shields (2 & 3)
- Using potting material (2 & 3)
- Resistance to timing attacks (1)
- Resistance to fault injection (1, 2 and 3).
- Separate buses between the Host and the Secure Element (2)

### Performance requirements

1.  Can sign 10 or more packet receipts per second.

### Process requirements

All effort must be taken to ensure the Hardware Key stored in the Secure Concentrator remains a secret. Manufacturers themselves should never have access to the keys. Also, Manufacturers are required to have strong processes in place for handling firmware updates. manufacturers must demonstrate prudence when handling firmware update key. Manufacturers must also have a firmware update contingency plan in place in the event the Manufacturer should cease to support their product. To these ends, Manufacturers of Secure Concentrator are required to practice the following process requirements:

1.  Secure key generation is performed on the Secure Concentrator hardware itself. The key material is never transferer in or out of the Secure Concentrator.
2.  The Provisioning process must disable all diagnostic/debug interfaces permanently.
3.  The Manufacturer must disclose via written document to the MCC their process for handling firmware updates including who has access to the firmware update keys and how the key is securely stored.
4.  The Manufacturer must disclose via written document to the MCC their firmware update contingency plan.

One possible contingency plan is to use the "dual-key" update design. Under this plan, a Secure Concentrator will accept updates from either the Manufacturer's firmware update key OR the MCC's firmware update key. Another possible contingency plan is to enter into an escrow agreement in which a third-party keeps a copy of the firmware update key. In the event the Manufacturer ceases to support the product, the third party transfers control of the firmware update key to the MCC.

## Hotspot Mechanics

Registering a Hotspot that uses a Secure Concentrator is a similar process to registering a Data-Only Hotspot. First, the Hotspot generates a new random `swarm_key`. Unlike other Hotspot types, the `swarm_key` on a Secure Hotspot is not considered a high priority secret because it is not used for earning PoC rewards. As such, it is not required to store the `swarm_key` in a secure element. In fact, a Secure Hotspot is not required to have a hardware secure element at all (for example, it can be stored in flash). Next, a transaction is sent to the blockchain defining the new Hotspot as a 'secure' type. This transaction (the Binding transaction) includes the Hotspot's `swarm_key`, the Secure Concentrator's Hardware Key, and the Hotpot Owner's wallet address. The Binding transaction is signed by all keys. The first time the Secure Concentrator's Hardware Key is used in a Binding transaction, there is no fee. Every subsequent Binding transaction cost 500000 DC ($5 USD). Note: this mechanism enables several things that are currently difficult or impossible such as resale of Secure Concentrators/Hotspots on the secondary market.

Note: hotspot currently on the denylist will continue to be denied earning PoC rewards even if they are upgraded with a Secure Concentrator.

Note: the Binding transaction still requires a small Solana transaction fee. It is expected that
initial transaction fee will be paid out of the Maker's wallet. Subsequent binding transaction fees
will be covered from the Hotspot owner's wallet.

## RF Data Signature

![image ](files/0072/rf_signing.png)

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

## Example Hardware Architecture

NLighten Systems has developed an open-source hardware and firmware Secure Concentrator reference design with the aid of a Helium Foundation grant. The design files can be found here: https://gitlab.com/nlighten-systems/kompressor/
The following sections describe the reference design choices. Alternative Secure Concentrator design does not necessarily need to include the same design components as long as it adheres to the General Requirements.

Note: approval of this HIP does NOT automatically approve NLighten System's design. The MCC has final approval power of any Secure Concentrator design, including the design by NLighten Systems.

![image ](files/0072/hardware_block.png) NLighten hardware architecture for SCC is based on Semtech's LoRa Corecell Gateway reference design. The major change involves the addition of a Secure MCU (**SMCU**) placed in between the communication path of the Host CPU and the SX1303. The SMCU's primary job is to cryptographically sign RF data received over the air such that other nodes participating on the Helium network are able to verify the data is authentic and unaltered from it original form. It is important the SMCU has exclusive access SX1303's SPI bus to eliminate the possibility of spoofing incoming RF packets. The hardware design employs several techniques to make it physically difficult to access the SMPU and SX130x including using buried traces, placing the components under a metal shield, and using hard-curing potting material.

### Semtech SX1303

The Semtech SX1303 is a new generation of LoRa baseband processor for gateways. It is size and pin compatible with SX1302 and like SX1302, it excels in cutting down current consumption, simplifying thermal design, lowering Bill Of Materials cost, and reducing overall size of gateways. In addition to supporting all the features of SX1302, SX1303 introduces a new Fine Timestamp capability that enables Time Difference of Arrival (TDOA) network-based geolocation. The new TDOA feature could potentially enable another layer of Proof of Coverage. For example, Helium Hotspots using SX1303 chipset could coordinate together to assert that another Helium Hotspot's beacon signal actually originated from the stated geolocation.

### Hardware Key

The SMCU stores a unique ED25519 keypair generated at manufacturing time in its non-volatile memory known as the **Hardware Key**. Note: the Hardware Key is not the same as the `swarm_key`. This is an important concept as it allows existing Miner's to upgrade their existing concentrator card with new SCC. The Hardware's private key is considered a secret and stored in a special section of the SMCU non-volatile memory used for secure storage. Secure storage can not be read-out and is not accessible to the Host CPU or via hardware debugging tools.

The Hardware Key can also be used to sign other types of transactions beyond RF data. However, it does not allow signing _arbitrary_ data. Doing so would put the security on par with existing HIP-19 secure element approach and thus defeat the purpose of this HIP. Note: If the SMCU's firmware allowed for signing arbitrary data with its Hardware Key, an attacker could jailbreak the Host CPU and craft a signing request that contained fake RF data.

### Secure Firmware

The firmware running on NLighten’s Secure Concentrator's SMCU is licensed under the GPLv3 open-source license. Its code repository is kept public and maintained by the Community. The firmware itself has a bootloader that checks the cryptographic signature of the application image at each power up to ensure it is unaltered from its original form. The key used to sign the application image is called the `App Signing Key`. The firmware actually has two App Signing Keys slots. One of the key slots must be populated with Helium Foundation's App Signing Key. The other key slot can optionally be populated with a Manufacturer's App Signing Key. Helium Foundation will use its App Signing Key to sign firmware from the official open-source repository. Manufacturers can optionally fork the open-source repository and create changes specific to their hardware variants. Manufacturer's must comply with the reciprocal nature of the GPLv3 license.

The intention of the "two-slot" scheme is to always allow any Secure Concentrator produced by any Manufacturer to be updated with the official open-source firmware. In the case a Manufacturer goes out of business or otherwise unable to provide support for their hardware, owners of Secure Concentrators can always choose to run the open-source firmware.

## Drawbacks

## Rationale and Alternatives

The proposed architecture of SCC is the best possible design because it cleanly and securely
decouples low-level RF packet data from high-level Helium network protocol and constructs. This decoupling is important because we expect the Helium network protocol to continue to grow and evolve in the future and it would be prohibitively difficult to maintain SMCU firmware to keep up. This architecture also enables potential new class of Helium nodes that can provide additional future functionality. For example, an SCC could be used in a PoC Mapper device to securely verify coverage in remote locations. Perhaps most importantly, this architecture can be used to upgrade existing Helium miners providing reliable data to PoC algorithms.

## Unresolved Questions

## Deployment Impact

Changes to the blockchain code will need to be made and tested on the `testnet`. When ready, these changes can be merged to `mainnet` but should have no impact on existing nodes. These changes are backwards compatible. Upgrading an existing miner with new SCC should not require any action on the Hotspot owner's part.

## Success Metrics

SCC success can be measured several ways. One metric will be the number of DIY Hotspots and Secure mapper devices built with SCC. Another metric is the amount of low-power sensors that utilize the TDoA location services SCC provide. Also the amount of DCs associated with those sensors. Finally, Secure Concentrators will enjoy in the success of any future PoC algorithm that utilizes its data.
