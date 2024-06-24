# HIP 123: Redefining IOT Data-Only Hotspot Onboarding and Assertion Fees

- Authors: [@Ducktatorrr](https://github.com/Ducktatorrr), Members of the IoT Working Group
- Start Date: 2024-05-13
- Category: Economic, Technical
- Original HIP PR: [#1006](https://github.com/helium/HIP/pull/1006)
- Tracking Issue: [#1012](https://github.com/helium/HIP/issues/1012)
- Vote Requirements: veIOT Holders

---

## Summary

This proposal aims to reduce the cost of onboarding [Data-Only Hotspots](https://docs.helium.com/iot/data-only-hotspots) to the Helium IOT Network to $0.50 in Data Credits and reducing location assertion cost to $0.50 in Data Credits. This initiative is designed to lower the barriers to entry for deploying low-cost IoT solutions using off-the-shelf LoRaWAN gateways and enhance the network's coverage and data accuracy through more accessible onboarding and location updates.

## Motivation

The class of Hotspot known as a "Data-Only Hotspot" enables the carte blanche onboarding of any standard LoRaWAN gateway to the Helium IOT Network. This is a valuable tool for IoT companies looking to migrate fleets to Helium or expand coverage leveraging readily available hardware. These Hotspots do not participate in Proof of Coverage and are only eligible to earn IOT tokens for the work of transferring LoRaWAN traffic.

An off-the-shelf LoRaWAN gateway is capable of transferring traffic through the Helium Network when paired with [gateway-rs](https://github.com/helium/gateway-rs), the light client which enables communication with the Helium Packet Router for PoC-enabled and Data-Only Hotspots alike. This software package can be used without any onboard or assert of the Hotspot. Functionality is illustrated in the table below:

| Gateway State                        | Capabilities                                                               |
|--------------------------------------|----------------------------------------------------------------------------|
| gateway-rs installed and configured. | Data transfer is allowed, but not rewarded to any entity.                  |
| Hotspot is onboarded.                | Data transfer is rewarded to the Hotspot.                                  |
| Hotspot location is asserted.        | Hotspot location is known to the network and returned in payload metadata. |

Status quo pricing for the onboarding of a Data-Only Hotspot is:

| Action                                            | Cost               |
|---------------------------------------------------|--------------------|
| Data-Only Onboard                                 | 1,000,000 DC ($10) |
| Location Assert (incl elevation and antenna gain) | 500,000 DC ($5)    |
| Transaction Fee                                   | ~0.1 Sol           |

This HIP acknowledges that data transfer rewards and location metadata might not provide enough incentive for Data-Only Hotspot operators to fully onboard their hardware. Consequently, the Helium Network misses out on valuable data. On-chain knowledge of a Hotspot's location allows it to be included on coverage maps, which the broader Helium community can rely on for their sensor deployments. Furthermore, the precise location of a Hotspot is advantageous for asset tracking applications that rely on multilateration.

During the time of writing, 1883 Hotspots were not onboarded/asserted but were transferring data on the network. This HIP aims to enable these and future operators to onboard and assert their Hotspots without concern for the financial burden. The IoT Working Group believes that by adopting this proposal, Helium can enhance the IOT Network's robustness and utility while fostering a more vibrant and inclusive community of developers and users.

## Stakeholders

Existing and future operators of Data-Only Hotspots will benefit from reduced costs or the ability to update their Data-Only Hotspot's location for a lower fee.

## Detailed Explanation

This HIP will reduce the cost of onboarding a Data-Only Hotspot from 1,000,000 DC ($10) to 50,000 DC ($0.50). The cost of a Data-Only Hotspot's location assertion will be reduced from 500,000 DC ($5) to 50,000 DC ($0.50). SOL fees remain unaffected.

## Drawbacks

The main concern is the potential reduction in DC burn per onboarding or assertion. However, the increase in the number of Data-Only Hotspots and assertions might compensate for this reduction by enhancing network coverage and utility.

## Rationale and Alternatives

This HIP significantly lowers the entry barrier for onboarding and assertion, allowing existing LoRaWAN deployers and IoT enthusiasts easier access to the network, potentially increasing overall network engagement and data validity.

The price effectively discourages spamming of location assertion while balancing a de minimis cost for operators to overcome when onboarding their Hotspots.

Other approaches have been considered in the discussion of this HIP:

- $5 onboard with free location assert every 30 epoch ($1 location assertion if within the 30 epoch period)
- Free onboard and assertion of Data-Only Hotspots

If this HIP or another of similar design is not approved, Data-Only Hotspots may continue to brought online without the inclusion of their on-chain onboarding and assert.

## Unresolved Questions

None.

## Deployment Impact

The Helium documentation will need updates to reflect new fee structures and the benefits of the free monthly location assertion. Pages of particular focus:

- https://docs.helium.com/iot/data-only-hotspots
- https://docs.helium.com/tokens/data-credit#iot-protocol-fees

Additionally, all developers of Helium Wallets, Maker Apps, CLI, and API tools must update their software to accommodate the new fee structure and free assertion feature to ensure smooth operation across the network.

This proposal is designed for easy reversibility, minimizing disruptions in the event that we need to revert to previous settings. Should a rollback be necessary, developers of Helium CLI will need to re-implement the original fee structures and assertion rules. This requirement ensures the changes are manageable but would involve coordinated efforts across all developer platforms to maintain assertion and onboarding functionality for Data-Only Hotspot operators.
