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
[HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) specifies the DAO Utility Score, which determines the distribution of HNT between all Helium subDAOs. The Hotspots of each subDAO count towards its Utility Score based on the onboarding fee set by that subDAO.

However, current MOBILE Hotspots, such as Freedomfi and Bobcat 500, contain both an IOT Hotspot and a MOBILE Hotspot. While HIP-53 specifies that MOBILE Hotspots should burn a $40 onboarding fee, just like IOT Hotspots, the existing implementation only onboarded the IOT network component. All active MOBILE Hotspots have been onboarded to the IOT network, but no separate onboarding process for the MOBILE network was ever implemented. As a result, no onboarding fees have yet been burned towards the MOBILE subDAO, which negatively affects the A Score for the MOBILE subDAO. The current A Score within the DAO Utility Score is as followed:

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

## Stakeholders
Future MOBILE Hotspot owners - Future MOBILE Hotspot owners may have to pay a higher fee to purchase a MOBILE Hotspot, as manufactures may pass the fee onto the consumer.

MOBILE Hotspot manufacturers - MOBILE Hotspot manufactures will now be required to pay the onboarding fees for each MOBILE Hotspot, as well as retroactively pay onboarding fees for Hotspots already onboarded.

## Detailed Explanation
The current A Score factor within the DAO Utility Score noted in the Motivation section above currently accounts for the active devices on that subDAO multiplied by the current onboard fee set for each device. Therefore, the passing of this HIP and the establishment of a prescribed $40 MOBILE onboard fee will instantly raise the A Score factor for the MOBILE subDAO. This will instantly increase the daily emissions of HNT into the MOBILE subDAO treasury. 

To show good faith to other subDAOs, this HIP also requires that manufactures of MOBILE Hotspots that were previously onboarded to the IOT network are required to retroactively pay a $40 onboard fee to the MOBILE subDAO.

## Drawbacks
This proposal may require Hotspot Manufactures to increase the costs of MOBILE Network Gateways. 

An additional drawback is that this HIP does not include the number of active radios, which may be a better metric of active devices. However, under guidance of the Helium Foundation, using Hotspots as the active device is easier to implement. 

## Alternatives
One alternative is to do nothing, and keep Onboarding Fees as zero (0). However, this would impair the daily HNT emissions to the MOBILE subDAO treasury since the A score would remain one (1). 

Another alternative is to change the way the A score is calculated to benefit the HNT emissions of the MOBILE Network; however, this would require a vote with veHNT instead of veMOBILE. 

## Deployment Impact
After the passing of this HIP, the Helium Foundation will need to modify the chain variable that defines the onboarding fee for the MOBILE subDAO.

## Success Metrics
The primary success metric will be greater daily HNT emissions to the MOBILE subDAO treasury.
