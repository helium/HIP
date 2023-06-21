# HIP 89: MOBILE Network Onboarding Fees 
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: [#701](https://github.com/helium/HIP/pull/701)
- Tracking Issue: [#714](https://github.com/helium/HIP/issues/714)
- Voting Requirements: veMOBILE

## Summary
This HIP proposes allowing previously onboarded MOBILE Hotspots to designate which subDAO their onboard fee is applied to, and implements a 40 USD onboard fee for all newly onboarded MOBILE Hotspots. 

## Motivation
Current MOBILE Hotspots, such as FreedomFi and Bobcat 500, contain both IOT and a MOBILE network capabilities. At the time of onboarding these Hotspots, there was no option to designate whether the 40 USD onboard fee was paid to the IOT or the MOBILE subDAO. As such, all onboarded MOBILE Hotspots were automatically onboarded to the IOT network with an Onboarding Fee of 40 USD, but were onboarded to the MOBILE network with an Onboarding Fee of 0 USD, even if there was no intention to use the Hotspot for the IOT network. As a result, 0 USD in Onboarding Fees have been burned towards the MOBILE subDAO's $A$ Factor, which negatively affects the $A$ Score established in HIP 51 for the MOBILE subDAO. The current $A$ Score within the DAO Utility Score is as follows:

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

## Stakeholders
Current MOBILE Hotspot owners - Current MOBILE Hotspot owners will have to designate whether the 40 onboard fee previously applied is to be designated to the MOBILE or IOT subDAO. If a MOBILE Hotspot user designates that the previous fee is to be applied to the MOBILE subDAO, the device will no longer earn IOT for PoC. Similarly, if the Hotspot delegates the fee to the IOT subDAO, the MOBILE Hotspot and any radios attached to that MOBILE Hotspot will cease to earn MOBILE from PoC activities. 

Future MOBILE Hotspot owners - Future MOBILE Hotspot owners may be impacted if MOBILE Hotspot manufacturers decide to not pre-pay Onboarding Fees to cover being onboarded to both networks (IOT and MOBILE). This would require the MOBILE Hotspot owner to pay an extra fee in order to onboard the Hotspot to both networks.

MOBILE Hotspot Manufacturers - All MOBILE Hotspots onboarded after this HIP will automatically have the 40 prepaid Onboarding Fee applied to the MOBILE network. The manufacturer will have the option to include the Onboarding Fee for IOT; it is strongly suggested but is not required.  

## Detailed Explanation
Unfortunately the framework for the MOBILE subDAO was established after the passing of HIP 51; and as such, a way to apply the paid Onboarding Fees for MOBILE Hotspots to the MOBILE subDAO was not present.  As a short-term solution, the Onboarding Fees for MOBILE Hotspots were applied to the IOT subDAO. HIP 53 in preparation for the MOBILE subDAO framework set the Onboarding Fee for the MOBILE subDAO at 0 USD.

The MOBILE community, via this HIP, is setting the MOBILE subDAO Onboarding Fee to 40 USD.

## Deployment Impact

The below technical implementations are recommended to be completed in the following order after the passing of this HIP:

1. The Helium Foundation will need to modify the Helium multisig for MOBILE Onboarding Fees from 0 USD to 40 USD.
2. FreedomFi/Nova Labs will be required to ensure all MOBILE Hotspots onboarded after the passing of this HIP are automatically on boarded to the MOBILE subDAO instead of the IOT subDAO.
3. FreedomFi/Nova Labs will enhance the current FreedomFi Dashboard or create a way for current MOBILE Hotspot owners to designate to which subDAO their previously applied fee is designated.
4. FreedomFi/Nova Labs will need to create a way for MOBILE Hotspot Owners to pay Onboard Fees to the IOT network if IOT Onboard Fees are not included with the purchase of the MOBILE Hotspot.

## Drawbacks

The most inconvenient drawback is that all MOBILE Hotspots onboarded between the passing of this HIP and the time that FreedomFi/Nova finishes the first three deployment impacts will automatically be onboard to both the IOT and MOBILE subDAOs and thus will have to pay 80 USD.  Because of this, it is hoped that they will proceed with haste.

## Alternatives
One alternative is to do nothing, and keep Onboarding Fees as $0$ (zero). However, this would impair the daily HNT emissions to the MOBILE subDAO treasury since the $A$ score would remain $1$ (one). 

Another alternative is to change the way the $A$ score is calculated to benefit the HNT emissions of the MOBILE Network; however, this would require a vote with veHNT instead of veMOBILE. 

## Success Metrics
This HIP is successful when all current onboarded MOBILE Hotspot have the option to designate their previous onboard fee to the MOBILE subDAO, and all future MOBILE Hotspots are automatically on boarded to the MOBILE subDAO.
