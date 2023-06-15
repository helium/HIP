# HIP XX: Designate MOBILE Network Onboarding Fees and Device Definition
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veMOBILE

## Summary
This proposal designates the Onboarding Fees for the onboarding of MOBILE subDAO devices.  Also provides a definition of a Device within the MOBILE subDAO for the purposes of calculating the $A$ factor of the DAO Utility Score.  An Onboarding Fee of $40 will set immedaitely upon passing; and, then once the necessary coding is complete, an Onboarding Fee of $10 will be set for Indoor Radio devices and $20 for Outdoor Radio devices.  Indoor Devices and Outdoor Devices are defined in the detailed explanation section.

## Motivation
As implemented in HIP51, a DAO Utility Score is used to determine the daily emissions of HNT to each SubDAO treasury. The equation for this calculation is noted below:

$\text{DAO Utility Score} = V \times D \times A$
Where
$V = \text{max}(1, veHNT_{DNP})$
$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$
$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

At its current rate, the $A$ score in the equation for MOBILE is $0$ (zero) as, currently, there is not any prescribed onboarding fees for the MOBILE network.  The implementation of this HIP would inscribe onboarding fees for output devices as prescribed by HIP51 which would allow a more appropriate calculation of the DAO Utility Score.

This HIP only applies to Devices onboarded after the passing of this HIP.  Any Device onboarded prior to the passing of this HIP are to be considered already onboarded.

## Stakeholders
Stakeholders are all current and future Device deployers within the MOBILE subDAO.  HNT holders will also be impacted from the burning of HNT by each Device paying its Onboarding Fees.

## Detailed Explanation
At the passing of this HIP, all Devices onboarded to the MOBILE Network will be required to pay an onboarding fee; which is paid via $USD equivalent in Data Credits (DC). 

With this HIP, a way to track, manage, and burn Data Credits used to pay the Onboarding Fees for any newly onboarded Devices will need to be created by the Helium Foundation.  Therefore, any output devices onboarded the day after the passing of this HIP will be required to pay their onboarding fees no later than October 31st, 2023.  This allows time for the Helium Foundation to create a way to track and manage this process.  If any Device onboarded to the MOBILE Network after the passing of this HIP do not pay their onboarding fees by October 31st, 2023, their output device will become inactive and not earn any Proof-of-Coverage or Data Transfer rewards until the fee is paid in full.  Such Devices will be consider as if not onboarded.

### Definitions
Indoor Device (AKA indoor radio) - A device that outputs a cellular or wifi signal to which End Users connect that is designed to be installed indoors.

Outdoor Device (AKA outdoor radio) - A device that outputs a cellular or wifi signal to which End Users connect that is designed to be installed oudoors.

     At the time of this HIP's writing, both Indoor and Outdoor Devices would include CBRS Radioa and carrier-offloading Wifi (coWifi) devices.
     
End User - A device that connects to a cellular or wifi signal, such as a cell phone, tablet, laptop, etc.

## Unresolved Questions
Confirmation that the Helium Foundation can certainly complete the needed work by the stated deadline of October 31, 2023.  Conversations have been had various members of the FOundation and it has been conveyed that approximately 90 days would be needed to complete the work.

## Deployment Impact
Operators of Devices will now need to pay Onboarding Fees for any newly onboarded output devices after the implementation of this HIP.

The Helium Foundation will need to create a way to track and manage output device onboards and ensure fees paid for output devices prior to the October 31, 2023 deadline. Further, the foundation will need to ensure that after the passing of this HIP that the $A$ score of the DAO Utility Score for the MOBILE SubDAO is correctly updated to reflect the total amount of indoor and outdoor output devices, as well as their associated fees for the MOBILE SubDAO.

## Success Metrics
The success metric will be the implementation of Onboarding Fees for all new Devices.




**********************************************************************************************************************************************

# HIP XX: MOBILE Network Onboarding Fee
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veMOBILE

##Summary: 
This proposal suggests the implementation of an onboarding fee for indoor output devices of $10 and outdoor output devices of $20 that join the MOBILE network the day after the passing of this HIP. Output devices are defined in the detailed summary section below.

##Motivation:
As implemented in HIP 51, a DAO Utility Score is used to determine the daily emissions of HNT to each SubDAO treasury. The equation for this calculation is noted below:

$\text{DAO Utility Score} = V \times D \times A$
Where
$V = \text{max}(1, veHNT_{DNP})$
$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$
$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

At its current rate, the A score in the equation for MOBILE is zero (0), as there currently is not any prescribed onboarding fees for the MOBILE network. The implementation of this HIP would inscribe onboarding fees for output devices which would significantly boost the output of the A score, which in turn, would effectively provide a significant increase to the daily HNT emissions sent to the MOBILE SubDAO treasury.  

This HIP only applies to output devices onboarded the day after the passing of this HIP. Any output devices onboarded prior to the passing of this HIP are already onboarded, and as such, are not required to pay such fee. 

##Stakeholders:
Stakeholders are all current and future output device deployers on the MOBILE network. 

HNT holders will also benefit from the burning of HNT for each newly onboarded output device.

##Detailed Explanation:

At the passing of this HIP, all outdoor and indoor output devices onboarded to the MOBILE network will be required to pay an onboarding fee, which is paid via data credits. 

With this HIP, a way to track, manage and burn HNT/data credits for newly onboarded output devices will need to be created by the Helium Foundation. Therefore, any output devices onboarded the day after the passing of this HIP will be required to pay their onboard fee no later than October 31st, 2023. This allows time for the Helium Foundation to create a way to track and manage this process. If any output devices onboarded to the MOBILE network the day after the passing of this HIP do not pay their onboarding fees by October 31st, 2023, their output device will become inactive, and not earn any PoC or data transfer rewards until the fee is paid in full. 

###Definitions
Output Device (AKA Gateway) - A device that outputs a cellular or wifi signal to which End Users connect. For example, this would include a CBRS Radio or a carrier-offloading Wifi (coWifi) unit.  
End User - A device that connects to a cellular or wifi signal, such as a cell phone or mapping device.

##Alternatives:

One alternative is to do nothing, and keep onboarding fees as zero (0). However, this would impede the daily HNT emissions to the MOBILE SubDAO treasury since the A score would remain zero (0). 

Another alternative is to change the way the A score is calculated to benefit the HNT emissions of the MOBILE Network; however, this would require a vote with veHNT instead of veMOBILE. 

##Unresolved Question:
None

##Deployment Impact:
Output deployers will now need to pay onboarding fees for any newly onboarded output devices after the implementation of this HIP.

The Helium Foundation will need to create a way to track and manage output device onboards and ensure fees paid for output devices prior to the October 31, 2023 deadline. Further, the foundation will need to ensure that the day after the passing of this HIP that the A score for the MOBILE SubDAO is correctly updated to reflect the total amount of indoor and outdoor output devices, as well as their associated fees for the MOBILE SubDAO.

##Success Metrics:
The primary success metric will be greater daily HNT emissions to the MOBILE SubDAO treasury. 
