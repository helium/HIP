# HIP 89: MOBILE Network Onboarding Fees 
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig), [Max Gold](https://github.com/MaxGold91)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: [#701](https://github.com/helium/HIP/pull/701)
- Tracking Issue: [#714](https://github.com/helium/HIP/issues/714)
- Voting Requirements: veMOBILE

## Summary
This HIP requests that Helium Foundation correct the MOBILE Onboarding Fee from 0 USD to 40 USD, so that the MOBILE Onboarding Fee will be in compliance with HIP 53. 

## Stakeholders
MOBILE Hotspots - All currently onboarded MOBILE Hotspot owners. 

Approved MOBILE Hotspot Makers - The subgroup of Approved Hotspot Makers that manufacture omni-protocol Hotspots that utilize the MOBILE Network and the IOT Network.  

## Motivation
Current MOBILE Hotspots, such as the FreedomFi Gateway and the Bobcat 500, are both omni-protocol Hotspots; that is, they contain both IOT and MOBILE network capabilities.  HIP-53 ('Economics Overview' section) dictates that all Hotspots must pay an Onboarding Fee of 40 USD and a Location Assert Fee of 10 USD.  [Helium Maker Ethics Documentation](https://docs.helium.com/hotspot-makers/maker-ethics/)  Section 9 indicates that Approved Hotspot Makers are responsible for funding the Onboarding Server for their Hotspots.

At the time of onboarding these Hotspots, there was no MOBILE subDAO which to designate the MOBILE subDAO's 40 USD Onboarding Fee.  As such, all MOBILE Hotspots were only onboarded to the IOT network with its associated Onboarding Fee of 40 USD and Location Assert Fee of 10 USD.  At the time of the Solana migration in April of 2023, these Hotspots continued to be onboarded to the MOBILE network with an Onboarding Fee of 0 USD instead of 40 USD, as the migration kept feature parity with the old chain.  The discrepancy continues to this day.  As a result, 0 USD in Onboarding Fees have been burned towards the MOBILE subDAO's $A$ Factor, which creates a negative impact in the $A$ Score of the DAO Utility Score as established in HIP-51.

## Detailed Explanation
Unfortunately, the framework for the MOBILE subDAO was established after the passage of HIP 51; and as such, there was no MOBILE subDAO to apply the paid Onboarding Fees for MOBILE Hotspots.  Until the MOBILE subDAO framework was created, the Onboarding Fees for omni-protocol Hotspots were applied to the IOT subDAO only.  The correct action at the time of migration in April of 2023 would have been to set the MOBILE Onboarding Fee to the required 40 USD, fund the onboarding server for all Hotspots to be onboarded, and burn the Onboarding Fee for each Hotspot as required by HIP-51.

HIPs 51 through 53 provide for the Onboarding Server to be correctly funded with 100 USD worth of Data Credits for each Hotspot by the Approved Hotspot Makers such that it can pay for the IOT subDAO Onboarding Fee of 40 USD, the IOT subDAO Location Assert Fee of 10 USD, the MOBILE subDAO Onboarding Fee of 40 USD, and the MOBILE subDAO Location Assert Fee of 10 USD.  Given that there is no Location Assert operation in the MOBILE subDAO, what to do with the excess funding (10 USD per Hotspot) presumed to be paid into the Onboarding Server for Location Assert is outside of the scope of this HIP.

### Technical Implementations
The correction is reportedly easy.  As such, The Helium Foundation has agreed to modify the Helium parameter that defines the MOBILE Onboarding Fee from 0 USD to 40 USD upon passing of this HIP.  The expected workload is on the order of minutes and, therefore, should be able to be completed within the day.

## Drawbacks
If HIP-88 is approved, and the DAO Utility Score is modified to redefine the $A$ Factor as the sum of all paid Onboarding Fees for active devices, rather than the product of the number of active devices and the defined Onboarding Fee, then it would seem required to ensure that the funds in the Onboarding Server be burned to the MOBILE subDAO's $A$ Factor as required in HIP-51.  The mechanism for how to do such a burn is outside of the scope of this HIP.

Another drawback is that since there are no Location Assert requirements for the MOBILE subDAO, there is no use to funding the Onboarding Server for any MOBILE subDAO Location Asserts as specified in HIP-51.  A separate HIP should be created to set the MOBILE subDAO Location Assert Fee to 0 USD, no longer require the MOBILE subDAO Location Assert Fee to be funded into the Onboarding Server, and allow MOBILE subDAO Location Assert funds to be utilized for paying for MOBILE subDAO Onboarding Fees.

## Alternatives
One alternative is to change the way the $A$ score of the DAO Utility Score is calculated so as to negate the need for Onboarding Fees.  Given the significance of modifying the Helium ecosystem's tokenomics, such an alternative would require a vote to be held at the Helium DAO level with veHNT.

## Success Metrics
This HIP is successful when the MOBILE Onboarding Fee is changed from 0 USD to 40 USD.  Once completed, all multi-protocol MOBILE Hotspots will automatically be onboarded to the MOBILE subDAO and the IOT subDAO and their required fees for both subDAOs will be paid from the Onboarding Server.
