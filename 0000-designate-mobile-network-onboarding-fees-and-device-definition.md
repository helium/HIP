# HIP XX: Designate MOBILE Network Onboarding Fees and Device Definition
- Authors: [Andy Zyvoloski](https://github.com/heatedlime), [Keith Rettig](https://github.com/keithrettig)
- Start Date: 6/14/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veMOBILE

## Summary
This proposal designates the Onboarding Fees for the onboarding of MOBILE subDAO devices.  It also provides a definition of a Device within the MOBILE subDAO for the purposes of calculating the $A$ factor of the DAO Utility Score.  An Onboarding Fee of $40 will set immediately upon passing and apply to HIP51-inherited Defined Devices; and, then once the necessary coding is complete, an Onboarding Fee of $10 will be set for Indoor Devices and $20 for Outdoor Devices.  Indoor Devices and Outdoor Devices are defined in the detailed explanation section.

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

With this HIP, a way to track, manage, and burn Data Credits used to pay the Onboarding Fees for any newly onboarded Devices will need to be created by the Helium Foundation.  Therefore, any output devices onboarded after the passing of this HIP will be required to pay their onboarding fees no later than October 31st, 2023.  This allows time for the Helium Foundation to create a way to track and manage this process.  If any Device onboarded to the MOBILE Network after the passing of this HIP do not pay their onboarding fees by October 31st, 2023, their output device will become inactive and not earn any Proof-of-Coverage or Data Transfer rewards until the fee is paid in full.  Such Devices will be consider as if not onboarded.

### Definitions

Device - A device includes but is not limited to a any hotspot/radio/router/modem or other output device that is onboarded to the MOBILE network that is  creating a cellular or Wi-Fi Helium 5G signal in which End Users can connect to access the internet. At the writing of this HIP, the two types of devices can include Indoor Devices and Outdoor Devices, which are defined below. 

Active Device - An active device is defined as a device that is creating valid coverage for that epoch.

Indoor Device (AKA indoor radio or wi-Fi unit) - A device that outputs a cellular or wifi signal to which End Users connect that is designed to be installed indoors.  At the time of this HIP's writing, this would include CBRS Radios and carrier-offloading Wifi (coWifi) devices.

Outdoor Device (AKA outdoor radio or wi-Fi unit) - A device that outputs a cellular or wifi signal to which End Users connect that is designed to be installed oudoors.  At the time of this HIP's writing, this would include CBRS Radios and carrier-offloading Wifi (coWifi) devices.

End User - A device that connects to a cellular or wifi signal, such as a cell phone, tablet, laptop, etc.

### Relocation/Reassertion Fees
Relocation and or re-asserting a device location shall not occur any fee. 

##Alternatives:

One alternative is to do nothing, and keep onboarding fees as zero (0). However, this would impede the daily HNT emissions to the MOBILE SubDAO treasury since the A score would remain zero (0). 

## Unresolved Questions
Confirmation that the Helium Foundation can certainly complete the needed work by the stated deadline of October 31, 2023.  Impromptu conversations have been had with various members of the Foundation and it is believed that approximately 90 days would be needed to complete the work.

## Deployment Impact
Operators of Devices will now need to pay Onboarding Fees for any newly onboarded output devices after the implementation of this HIP.

The Helium Foundation will need to create a way to track and manage output device onboards and ensure fees paid for output devices prior to the October 31, 2023 deadline. Further, the foundation will need to ensure that after the passing of this HIP that the $A$ score of the DAO Utility Score for the MOBILE SubDAO is correctly updated to reflect the total amount of indoor and outdoor output devices, as well as their associated fees for the MOBILE SubDAO.

## Success Metrics
The success metric will be the implementation of Onboarding Fees for all new Devices, which will lead to higher daily HNT emissions to the MOBILE SubDAO treasury.



