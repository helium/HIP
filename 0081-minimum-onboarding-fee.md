# HIP 81: Minimum Device Onboarding Fee

- Author(s): @mawdegroot, @Maxgold91 
- Start Date: 2023-04-07 
- Category: economic Economic
- Original HIP PR: #606
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

This HIP proposes to set a minimum onboarding fee for Hotspots in the subDAO structure. This HIP also proposes that Hotspots for which the minimum onboarding fee has not been burned are not eligible for rewards from the subDAO. The minimum onboarding fee will be dynamically defined as $40 and will follow the same halving schedule as HNT and will therefore start at $20.

## Motivation

A minimum onboarding fee is necessary to:

1. Stop subDAOs from arbitrarily onboarding Hotspots. 
2. Prevents nuisance attacks against subDAOs and the Helium DAO. 

HIP51 has described the onboarding of Hotspots but has not made this explicit. Hotspots for which the minimum onboarding fee has not been burnt are not eligible for rewards. SubDAOs attempting to bypass this requirement will be subject to slashing.

## Stakeholders

All network participants.

## Detailed Explanation

### Network security

The onboarding fees protect the network against nuissance attacks as well as making other attacks against the network less viable. Industrialized gaming is made less viable by the onboarding fees as well as giving the opportunity to catch gaming before a net-positive result is achieved by the gamer. The $A$ factor allows subDAOs to recoup some of the cost they incur by securing their network as it increases the DAO Utility Score.

### Rewards burn

The Helium flywheel is based on creating DC burn. Onboarding fees have historically been the most influential driving force of DC burn. The $A$ factor rewards subDAOs for non-recurring DC burn such as the onboarding fee analog to the $D$ factor rewards a subDAO for recurring DC burn. The $A$ factor rewards networks that have contributed significantly to the Helium flywheel with non-recurrent fees. Without the $A$ factor the subDAOs will be incentivized to burn as little DC as possible on non-recurring costs thereby slowing down the Helium flywheel.

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

## Drawbacks

This proposal requires Hotspots that did not pay a minimum onboarding fee to burn the onboarding fee retroactively to continue earning rewards. While inconvenient, there is sufficient precedent as this situation has happened before with CalChip.

## Deployment Impact

The migration to Solana requires every Hotspot to be onboarded to every subDAO individually, as HIP51 intended. Existing Hotspots for which no onboarding fee has been burnt to a specific subDAO will have to rectify this to continue earning rewards for a subDAO.

## Implementation

To be implemented at the time of the Solana Migration on April 18th as part of the ongoing smart contract and subDAO work by the Helium Foundation.

## Unresolved Questions

None

## Success Metrics

This is successful if the onboarding fees provide Sybil resistance for the subDAOs and perform the minimum requirements for the network to launch on Solana.
