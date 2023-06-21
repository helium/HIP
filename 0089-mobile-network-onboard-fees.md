# HIP 89: MOBILE Network Onboarding Fees 
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig), [Max Gold](https://github.com/MaxGold91)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: [#701](https://github.com/helium/HIP/pull/701)
- Tracking Issue: [#714](https://github.com/helium/HIP/issues/714)
- Voting Requirements: veMOBILE

## Summary
This HIP requests that The Helium Foundation correct the MOBILE Onboarding Fee from 0 USD to 40 USD as soon as possible so that the MOBILE Onboarding Fee will be in compliance with HIP 53. 

## Stakeholders
MOBILE Hotspots - All currently onboarded MOBILE Hotspot owners. 

Approved MOBILE Hotspot Makers - The sub-group of Approved Hotspot Makers that manufacture omni-protocol Hotspots that utilize the MOBILE Network and the IOT Network.  

## Motivation
Current MOBILE Hotspots, such as the FreedomFi Gateway and the Bobcat 500, are both omni-protocol Hotspots; that is, they contain both IOT and MOBILE network capabilities.  HIP 53 ('Economics Overview' section) dictates that all Hotspots must pay an Onboarding Fee of 40 USD and a Location Assert Fee of 10 USD.  [Helium Maker Ethics Documentation](https://docs.helium.com/hotspot-makers/maker-ethics/)  Section 9 indicates that Approved Hotspot Makers are responsible for funding the onboarding server for their Hotspots.

At the time of onboarding these Hotspots, there was no MOBILE subDAO to which to designate the MOBILE subDAO's 40 USD Onboarding Fee.  As such, all MOBILE Hotspots were only onboarded to the IOT network with its associated Onboarding Fee of 40 USD and Location Assert Fee of 10 USD.  At the time of the migration in April of 2023, these Hotspots were incorrectly onboarded to the MOBILE network with an Onboarding Fee of 0 USD.  The error continues to this day.  As a result, 0 USD in Onboarding Fees have been burned towards the MOBILE subDAO's $A$ Factor, which introduces an error in the $A$ Score of the DAO Utility Score established in HIP 51.

## Detailed Explanation
Unfortunately, the framework for the MOBILE subDAO was established after the passing of HIP 51; and as such, there was no MOBILE subDAO to apply the paid Onboarding Fees for MOBILE Hotspots.  Until the MOBILE subDAO framework was created, the Onboarding Fees for omni-protocol Hotspots were applied to the IOT subDAO only.  The correct action at the time of migration in April of 2023 should have been to set the Onboarding Fee to the required 40 USD and to fund the onboarding server for all hotspots to be onboarded.  Only after the fee was correctly set should the onboarding process have been completed.

It is assumed by the authors that the onboarding server was correctly funded with 100 USD worth of Data Credits for each Hotspot by the Approved Hotspot Makers so as to pay for the IOT subDAO Onboarding Fee of 40 USD, the IOT subDAO Location Assert Fee of 10 USD, the MOBILE subDAO Onboarding Fee of 40 USD, and the MOBILE subDAO Location Assert Fee of 10 USD.  Given there are no Location Asserts within the MOBILE subDAO, what to do with the unnecessary fees (10 USD per Hotspot) presumed to be paid into the onboarding server is outside of the scope of this HIP.

### Technical Implementations
The correction is reportedly easy.  As such, The Helium Foundation has agreed to modify the Helium multisig for MOBILE Onboarding Fees from 0 USD to 40 USD upon passing of the HIP.  The expected workload is to on the order of minutes and, therefore, should be able to be completed within the day.

## Drawbacks
The biggest potential drawback applies if HIP 88 is passed.  If the DAO Utility Score is modified to redefine the $A$ Factor calculation to be the the sum of all onboarding fees for active devices rather than a multiple of active devices and the set Onboarding Fee value, then it would seem required to ensure that the funds in the onboarding server were burned to the MOBILE subDAO's $A$ Factor.  The mechanism for how to do such a burn is outside of the scope of this HIP.

Another drawback is that since there are no Location Assert requirements for the MOBILE subDAO, it would have been understandable to not fund the onboarding server for any MOBILE subDAO Location Asserts.  A separate HIP should be created to set the MOBILE subDAO Location Assert Fee to 0 USD, no longer require the MOBILE subDAO Location Assert Fee to be funded into the onboarding server, and propose to allow MOBILE subDAO Location Assert funds to be utilized for paying for MOBILE subDAO Onboarding Fees.

## Alternatives
One alternative is to change the way the $A$ score of the DAO Utility Score is calculated so as to negate the need for Onboarding Fees.  Given the significance of modifying the Helium ecosystem's tokenomics, such an alternative would require a vote to be held at the Helium DAO level with veHNT.

## Success Metrics
This HIP is successful when the MOBILE Onboarding Fee is changed from 0 USD to 40 USD.  Once completed, all multi-protocol MOBILE Hotspots will automatically be onboarded to the MOBILE subDAO and the IOT subDAO and their required fees for both subDAOs are paid from the onboarding server.
