# HIP 96: WiFi AP Onboarding Structure

- Authors: [Max Gold](https://github.com/maxgold91) & [Nik Hawks](https://github.com/gristlekinginc)
- Start Date: 2023-08-31
- Category: Economic, Technical
- Original HIP PR: [#780](https://github.com/helium/HIP/pull/780)
- Tracking Issue: [#785](https://github.com/helium/HIP/issues/785)
- Vote Requirements: veMOBILE Holders

---

# Summary

This HIP outlines the onboarding fee structure for two new device types: "Indoor WiFi APs" and "Outdoor WiFi APs". The proposed onboarding fees are designed to be approximately 10% of the Manufacturer's Suggested Retail Price (MSRP) of the devices (please see below for specifics). The fees consist of a combination of HNT derived data credits and MOBILE tokens. It is expected that future devices of different classes will follow a similar pricing structure based on their respective MSRP. 

# Motivation

As the Helium Network expands to accommodate various types of devices, it is crucial to establish a standardized onboarding fee structure that balances the needs of the network's growth, token economy, and fair compensation for network participants. The proposed onboarding fees for the "Indoor WiFi APs" and "Outdoor WiFi APs" devices aim to achieve these goals.

# Specification

## Onboarding Fee Structure

Please note, this HIP does not define WiFi AP types and does intend to decouple from the definitions laid out in HIP-93.  If a future HIP changes these definitions, this HIP intends to follow the guidance voted on by the MOBILE subDAO.

1. **Indoor WiFi APs:**
   - Cost:1,000,000 Data Credits ($10 worth of HNT) $10 in HNT derived data credits + $10 worth of MOBILE tokens -at the live Oracle price
   - Total Onboarding Fee: $20

2. **Outdoor WiFi APs:**
   - Cost: 1,000,000 Data Credits ($10 worth of HNT) $10 in HNT derived data credits + $20 worth of MOBILE tokens - at the live Oracle price.
   - Total Onboarding Fee: $30

## MSRP-based Pricing

The proposed onboarding fees are based on the principle of being approximately 10% of the initial MSRP of the respective devices. This approach ensures a fair and consistent fee structure relative to the value of the devices being onboarded.  It is important to note that this section is simply explaining the rationale behind the decision for the pricing and does advocate for any dynamic pricing. It is anticipated that future device classes introduced to the Helium Network will adopt a similar onboarding fee structure based on their own MSRP. This approach maintains consistency and predictability for device manufacturers, network operators, and other stakeholders.

## Flexibility for Cost Reductions

In the event of a significant reduction in the hardware costs associated with devices, the community is advised to reassess the onboarding fees. A principle of maintaining approximately 10% of MSRP as the fee should be applied to align the fees with the evolving landscape of hardware costs, network growth, and token valuation.

# Rationale

The chosen onboarding fee structure balances the need for fair compensation, network expansion, and alignment with device value. The 10% approximation of MSRP serves as a reliable anchor for establishing these fees and ensuring their adaptability to changing circumstances.  

# Implementation

* This fee structure will be implemented in the Helium Network's onboarding process for the specified device types. This process will be handled within the maker app.  Nova Labs has agreed to take on any engineering work required to pull the oracle price of Nova at the time of onboarding.  The fees will be paid by the maker on behalf of the buyer otherwise referred to in HIP-53 as the “hotspot host.” 
* Makers would be required to support this new onboarding fee process in their App
* Makers would be required to hold MOBILE in their Maker Wallet 

# Drawbacks

* This fee structure is a bit more complicated to implement than the current onboarding process.
* There is a potential for a maker to either have insufficient DC or MOBILE to onboard devices.  There is currently no mechanism to ensure that any maker has enough DC in their maker wallet and the authors believe another HIP should be written in the future to remedy this problem.  Under the rules agreed to in HIP-53 a hotspot maker must stake 50M MOBILE tokens to be an approved maker.
* MOBILE prices are based on human oracles and not Python automated oracles.  This creates a potential situation where if human oracles stop quoting prices we will be unable to calculate a price in MOBILE.
   - The above is unlikely, as it would also mean any data transfer payments would not be calculated.

# Success Metrics

The hotspot owner will deploy a new WiFi AP hotspot using the makers app and the maker will be charged the fees stated above.
