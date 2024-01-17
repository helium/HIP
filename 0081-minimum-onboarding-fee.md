# HIP 81: Minimum Device Onboarding Fee

- Author(s): @mawdegroot, @Maxgold91
- Start Date: 2023-04-07
- Category: economic Economic
- Original HIP PR: #606
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

This HIP proposes to set a minimum onboarding fee for devices in the subDAO structure. This HIP also proposes that devices for which the minimum onboarding fee has not been burned are not eligible for rewards from the subDAO. The minimum onboarding fee will be dynamically defined as $10 on August 1, 2023 and will follow the same halving schedule as HNT emissions as shown in the chart below. It is important to note, this HIP only defines a minimum fee and at the time of its writing, HIPs 51-53 have defined the onboarding fees as $40 per hotspot. If a subDAO wishes to change its onboard fees, it must do so through the subDAO governance process. This HIP will be implemented in phases, first clearly defining the requirements at the time of its passing, then on-chain with a target date of August 1, 2023.

| Date       | Minimum Onboard Fee in DC |
| ---------- | ------------------------: |
| 08/01/2023 |                 1,000,000 |
| 08/01/2025 |                   500,000 |
| 08/01/2027 |                   250,000 |
| 08/01/2029 |                   125,000 |
| 08/01/2031 |                    62,500 |
| 08/01/2033 |                    31,250 |
| 08/01/2035 |                    15,625 |

The HIP authors fully support any community initiative to set a floor price to stop the halving at a future date. However, it is our opinion that the current halving schedule gives the network about 8-10 years to figure out which figure works best. The halving schedule was chosen to be in line with the theory of Moore's Law and roughly correlate to the CAPEX required for these networks. If these features, in the future, are no longer relevant, the Helium DAO should update the minimum onboard price to be in line with future economic forces.

## Motivation

A minimum onboarding fee is necessary to:

1. Stop subDAOs from arbitrarily onboarding Hotspots.
2. Prevent nuisance attacks against subDAOs and the Helium DAO.

HIP51 has described the onboarding of Hotspots but has not made this explicit. Hotspots for which the minimum onboarding fee has not been burnt are not eligible for rewards. SubDAOs attempting to bypass this requirement will be subject to slashing.

## Stakeholders

All network participants.

## Detailed Explanation

### Network security

The onboarding fees protect the network against nuisance attacks as well as making other attacks against the network less viable. Industrialized gaming is made less viable by the onboarding fees as well as giving the opportunity to catch gaming before a net-positive result is achieved by the gamer. The $A$ factor allows subDAOs to recoup some of the cost they incur by securing their network as it increases the DAO Utility Score.

### Rewards burn

The Helium flywheel is based on creating DC burn. Onboarding fees have historically been the most influential driving force of DC burn. The $A$ factor rewards subDAOs for non-recurring DC burn such as the onboarding fee analog to the $D$ factor rewards a subDAO for recurring DC burn. The $A$ factor rewards networks that have contributed significantly to the Helium flywheel with non-recurrent fees. Without the $A$ factor the subDAOs will be incentivized to burn as little DC as possible on non-recurring costs, thereby slowing down the Helium flywheel.

### Dead networks

The original DAO Utility Score handles dead subDAOs gracefully. Given the unlikely scenario that a subDAO ceases operation the $V$ factor will decrease to $1$ as the delegators will redelegate to other networks. The $D$ factor for a dead network will also be $1$ as it no longer processes data. Finally the $A$ factor will go to $1$ as the amount of active Hotspots will decrease to $0$.

## Rationale and Alternatives

This proposal seeks to retain the DAO Utility Score as it was specified in [HIP51](./0051-helium-dao.md) and is a competing proposal for [HIP80](./0080-simplifying-dao-utility-score.md). While HIP80 seeks to 'simplify' the DAO Utility Score and remedy the missing MOBILE onboarding fees by a significant overhaul, this proposal seeks to keep the original DAO Utility Score and solve the problem at the source: require subDAOs to burn onboarding fees.

$\text{DAO Utility Score} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

Retaining the $A$ factor is valuable as the $A$ factor represents the onboarding fee that has several uses which are either partly or fully negated without the $A$ factor.

### Further specifications

#### DNP Device Activation Fee

The DAO Utility Score will use the onboarding fee that has been burned for a specific device. E.g. if a device is active and has burned a $40 onboarding fee the DNP Device Activation Fee will be $40 and if a device is active and has burned a $20 onboarding fee the DNP Device Activation Fee will be $20.

#### Grace Period

Due to technical limitations of the network architecture, and the complexities of the engineering required, during the proposal of this Helium Improvement Proposal (HIP), as well as the timing of the Solana migration, this HIP hereby sets a compliance deadline of August 1, 2023, for subDAOs that are non-compliant. This grace period affords subDAOs the opportunity to operate as if the burn occurred on April 17, 2023 (prior to the migration). However, it necessitates a retroactive burn to reconcile any outstanding onboarding debts [in a manner consistent with the previous IOT retroactive burn.](https://explorer.helium.com/txns/5hSdF8hhyYz1VNI6DxdI_GiaKV0xyR5IJQzIluYDu0w)

For purposes of determining the MOBILE subDAO's $A$ score, a value of $40 shall be allocated per FreedomFi and 'Bobcat 5G' gateway that has been onboarded and is actively participating in either subDAO's Proof of Coverage at any point during the preceding 30 epochs. In the event that the MOBILE subDAO onboards via burn before the compliance deadline, the greater of the allocated value or the actual burn shall be counted. If the actual onboard burn number falls short of the grace period amount, the Helium DAO shall reduce any incremental HNT earned from the MOBILE subDAO treasury via slashing.

#### Onboarding Devices

[HIP51](./0051-helium-dao.md) defines active devices as "_Active devices are the subDAO's definition of devices creating valid coverage (aka Hotspots) and therefore being rewarded during the epoch_". This definition will implicitly prevent devices that have not been onboarded to be credited towards the DAO Utility Score as the unonboarded devices are not allowed to be rewarded for anything other than data transfer. This includes, but is not limited to, Proof-of-Coverage rewards, pre-mine rewards, challenge construction rewards, and any other rewards that are not directly related to data transfer. Devices onboarded at the time of the Solana migration that do not meet the minimum outlined in this HIP may still be credited towards the DAO Utility Score based on the DC burn to onboard them (data only LoRaWAN hotspots).

We believe any incremental additions to hotspots that materially increase its price and materially increases its ability to mine more of a subDAO’s DNT constitutes a new device that must be onboarded. However, Helium DAO will give the subDAOs the freedom to reasonably decide what it considers to be a device. It is the position of Helium DAO that, while we encourage ECC chips and other similar security measures for devices, it is not a requirement and leave that distinction up to the subDAO. We also feel it is not necessary for a device to live on-chain if a subDAO feels it can effectively count and reward devices using off-chain oracles. SubDAOs that choose to maintain their device list and Proof-of-Coverage architecture in off-chain oracles agree to reasonable periodic audits at the Helium DAOs request.

For example, an antenna on a LoRaWAN hotspot, which does not guarantee any additional rewards, would not need to be onboarded. Whereas, a MOBILE radio which requires a material increase in CAPEX over a gateway and directly relates to an increase in rewards should be onboarded.

#### Active Devices

This HIP sets forth the definition of active devices as those that have been onboarded by a subDAO and rewarded for Proof-of-Coverage (or any other similar non-data transfer activity) within the preceding 30 days (or 30 epochs, as per a Solana epoch). In the event that a subDAO implements a 'deny list' or any other exclusionary measure, any device subject to such measure shall no longer be deemed active from the time it has its earning capability revoked.

#### Payer of onboarding fees

This HIP does explicitly _not_ prescribe subDAOs which entity is required to burn the onboarding fee. Historically, the onboarding fee has been burned by the manufacturer but each subDAO can, through governance, decide which entity burns the onboarding fee.

#### Multiple subDAOs in a single device

This HIP explicitly defines that devices are not required to onboard to every subDAO the hardware is capable of. The hotspots that are active before the Solana migration are considered to be onboarded on the IOT subDAO and will need to be onboarded on other subDAOs to be eligible for rewards, except during the grace period outlined above.

## Drawbacks

This proposal requires Hotspots that did not pay a minimum onboarding fee to burn the onboarding fee retroactively to continue earning rewards. While inconvenient, there is sufficient precedent as this situation has happened before with CalChip.

## Deployment Impact

The migration to Solana requires every Hotspot to be onboarded to every subDAO individually, as HIP51 intended. Existing Hotspots for which no onboarding fee has been burnt to a specific subDAO will have to rectify this to continue earning rewards for a subDAO.

## Implementation

To be implemented at the time of the Solana Migration on April 18th as part of the ongoing smart contract and subDAO work by the Helium Foundation. Full implentation will take place on or around August 1, 2023.

## Unresolved Questions

None

## Success Metrics

This is successful if the onboarding fees provide Sybil resistance for the subDAOs and perform the minimum requirements for the network to launch on Solana.
