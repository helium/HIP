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
[HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) specifies the DAO Utility Score, which determines the distribution of HNT between all Helium subDAOs. The Hotspots of each subDAO count towards its Utility Score based on the Onboarding Fee set by that subDAO.

Current MOBILE Hotspots, such as FreedomFi and Bobcat 500, contain both an IOT Hotspot and a MOBILE Hotspot. As such, HIP-53 specifies that MOBILE Hotspots should burn a \$40$ USD Onboarding Fee to be onboarded to the network. All onboarded MOBILE Hotspots were onboarded to the IOT network with the correct Onboarding Fee of \$40$ USD, but were onboarded to the MOBILE network with an Onboarding Fee of $\0$ USD. As a result, $\$0 USD in Onboarding Fees have been burned towards the MOBILE subDAO's $A$ Factor, which negatively affects the $A$ Score for the MOBILE subDAO. The current $A$ Score within the DAO Utility Score is as followed:

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

## Stakeholders
Future MOBILE Hotspot owners - Future MOBILE Hotspot owners may have to pay a higher fee to purchase a MOBILE Hotspot, as manufacturers may pass the fee onto the consumer.

MOBILE Hotspot manufacturers - MOBILE Hotspot manufacturers will now be required to pay the onboarding fees for each MOBILE Hotspot, as well as retroactively pay onboarding fees for Hotspots already onboarded.

## Detailed Explanation
The current $A$ Score factor within the DAO Utility Score noted in the Motivation section above currently accounts for the active devices on that subDAO multiplied by the current onboard fee set for each device. Therefore, the passing of this HIP and the establishment of a prescribed $40 MOBILE Onboarding Fee will raise the $A$ Score factor for the MOBILE subDAO. This will increase the daily emissions of HNT into the MOBILE subDAO treasury. 

This HIP also requires that for MOBILE Hotspots that were previously onboarded at $0 USD, there is to be $40 USD worth of DCs burned to the MOBILE subDAO.  This HIP does not require any specific payer for the DCs; it is the responsibility of the MOBILE subDAO to find the payer(s) and to ensure the payment is settled.

## Drawbacks
This proposal may cause Hotspot Manufacturers to increase the costs of MOBILE Network Gateways.  This is not expected to be the case.

An additional drawback is that the Onboarding Fees are not based the number of active radios, which may be a better metric of active devices. However, under guidance of the Helium Foundation, using Hotspots as the active device is easier to implement. 

## Alternatives
One alternative is to do nothing, and keep Onboarding Fees as zero (0). However, this would impair the daily HNT emissions to the MOBILE subDAO treasury since the $A$ score would remain one (1). 

Another alternative is to change the way the $A$ score is calculated to benefit the HNT emissions of the MOBILE Network; however, this would require a vote with veHNT instead of veMOBILE. 

## Deployment Impact
After the passing of this HIP, the Helium Foundation will need to modify the chain variable that defines the onboarding fee for the MOBILE subDAO.

## Success Metrics
The primary success metric will be greater daily HNT emissions to the MOBILE subDAO treasury.
