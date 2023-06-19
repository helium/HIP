# HIP XX: MOBILE Network Onboarding Fees 
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veMOBILE

## Summary
This HIP proposes implementing a $40 onboard fee paid in Data Credits (DC) for each Hotspot onboarded to the MOBILE Network.

## Motivation
Current MOBILE Hotspots, such as FreedomFi and Bobcat 500, contain both IOT and a MOBILE network capabilities. As such, HIP-53 specifies that MOBILE Hotspots should burn a 40 USD Onboarding Fee to be onboarded to the network. All onboarded MOBILE Hotspots were onboarded to the IOT network with the correct Onboarding Fee of 40 USD, but were onboarded to the MOBILE network with an Onboarding Fee of 0 USD. As a result, 0 USD in Onboarding Fees have been burned towards the MOBILE subDAO's $A$ Factor, which negatively affects the $A$ Score established in HIP 51 for the MOBILE subDAO. The current $A$ Score within the DAO Utility Score is as follows:

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

## Stakeholders
Future MOBILE Hotspot owners - Future MOBILE Hotspot owners may have to pay a higher fee to purchase a MOBILE Hotspot, as manufacturers may pass the fee onto the consumer.

MOBILE Hotspot manufacturers - MOBILE Hotspot manufacturers will now be required to pay the onboarding fees for each MOBILE Hotspot, as well as retroactively pay onboarding fees for Hotspots already onboarded.

## Detailed Explanation
As the framework for the MOBILE subDAO was established after the passing of HIP 53, a way to pay onboarding fees for MOBILE Hotspots was never created, and therefore, the Onboarding Fee for MOBILE Hotspots is currently set to 0 USD.  It is the purview of subDAOs to set the fees that apply to their network.  The MOBILE subDAO, via this HIP, is setting the Onboarding Fee to 40 USD.  While we are leaving the coding of this work to the Foundation, it is understood to be a rather simple task (estimated at less than an hour of work).  The chain variable is to be changed from 0 USD to 40 USD.

## Drawbacks
The current $A$ Score factor within the DAO Utility Score currently accounts for the active devices on that subDAO multiplied by the current onboard fee set for each device. Therefore, the passing of this HIP and the establishment of a prescribed 40 USD MOBILE Onboarding Fee will raise the $A$ Score factor for the MOBILE subDAO. This will increase the daily emissions of HNT into the MOBILE subDAO treasury until the current limitation of the implementation is corrected. 

This proposal may cause Hotspot Manufacturers to increase the costs of MOBILE Network Gateways.  This is not expected to be the case.

An additional drawback is that the Onboarding Fees are not based the number of active radios, which may be a better metric of active devices. However, under guidance of the Helium Foundation, using Hotspots as the active device is easier to implement. 

## Alternatives
One alternative is to do nothing, and keep Onboarding Fees as $0$ (zero). However, this would impair the daily HNT emissions to the MOBILE subDAO treasury since the $A$ score would remain $1$ (one). 

Another alternative is to change the way the $A$ score is calculated to benefit the HNT emissions of the MOBILE Network; however, this would require a vote with veHNT instead of veMOBILE. 

A complementary HIP is to require that for each MOBILE Hotspot that was previously onboarded at 0 USD, there is to be 40 USD worth of DCs burned to the MOBILE subDAO.  Such a HIP should not require any specific payer for the DCs; it would be the responsibility of the MOBILE subDAO to find the payer(s) and to ensure the payment is settled.  Given there is no mechanism currently for this be done, such a feature can not be included in this HIP.

## Deployment Impact
After the passing of this HIP, the Helium multisig will need to modify the variable that defines the onboarding fee for the MOBILE subDAO.

## Success Metrics
The success metric will be that any MOBILE Hotspot that is added to the MOBILE network will have paid its Onboarding Fee.

