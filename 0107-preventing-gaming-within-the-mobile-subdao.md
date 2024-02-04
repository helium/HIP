# HIP 107: Preventing Gaming Within the MOBILE SubDAO

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) 
- Start Date: 2023-12-31
- Category: Economic, Technical
- Original HIP PR: [#857](https://github.com/helium/HIP/pull/857)
- Tracking Issue: [#881](https://github.com/helium/HIP/issues/881)
- Vote Requirements: veMOBILE Holders

## Summary:
This Helium Improvement Proposal (HIP) proposes the following:

- A $20 MOBILE burn be submitted along with CPI submissions
- A $10 MOBILE burn be submitted when updating location information on outdoor Wi-Fi Access Points
- Giving Service Providers tools to prevent and stop ongoing gaming


## Motivation:
The primary Service Provider and company that reviews CPI information, Nova Labs (d.b.a. Helium Mobile), has expressed concern for ongoing gaming that they've identified within the MOBILE subDAO; however, they do not have the appropriate tools to stop this from occurring. This HIP will give MOBILE subDAO Service Providers the tools needed to curb gaming. 

## Stakeholders:
The stakeholders of this proposal are:

- **Outdoor CBRS and Wi-Fi Deployers** will be required to pay a fee when they move their radio/AP or onboard a new radio
- **CPI Entities** will now be able to charge a fee of up to $20 for reviewing CPI information of CBRS radios.
- **MOBILE Holders** will benefit with an increased value in terms of MOBILE/HNT Treasury swap rate.
- **Service Providers** will be able to temporarily turn off radios/Wi-Fi APs suspected of gaming
- **Gamers** will now suffer a financial and or opportunity cost loss when they are caught gaming

## Detailed Explanation:
This HIP proposes the following fee structure:

### Outdoor CBRS Radios
A $20 fee in MOBILE burn will be required whenever new CPI information is submitted, which includes the initial/first CPI submission, and any submissions thereafter. If the CPI submission is rejected for a mistake made by the deployer when submitting the information, the deployer will have one (1) free resubmission for that radio, so long as that re-submission is done within 30 calendar days after initial rejection. If the CPI rejects the submission for any potential gaming concerns, there will be no free re-submissions, and a new fee will need to be paid. 

This HIP also grants authority to the CPI reviewer of outdoor CBRS radios to charge a separate standard or priority fee of up to a $20 paid in MOBILE to the CPI reviewing entity. This fee is paid directly to the entity that is completing the CPI submission, and is NOT burned. If a fee is charged by the CPI reviewing entity, the following is required:

- The CPI submission must be approved or rejected within 2 business days
- A guide must be created that documents each reason a submission may be rejected (i.e. incorrect height, incorrect azimuth, outdoor radio installed indoors, gaming concerns, etc.)
- If the CPI submission is rejected for a reason that is not noted within the guide, the re-submission may be redone for free, regardless if it is the first or second submission, and also must be reviewed (approved or rejected) within one (1) business day of re-submission. Please note, this rule is not applicable if the submission was rejected due to gaming concerns.

### Outdoor Wi-Fi AP's
A $10 location submission fee in MOBILE burn will be required when the location/height/direction for outdoor Wi-Fi AP's are re-submitted/updated. Unlike CBRS, the first location assert will occur at a $0 MOBILE burn cost. Below are the minimum requirements that must be submitted when updating the location/height/direction of an outdoor Wi-Fi AP:

- Install height (in feet)
- Azimuth
- One picture verifying the height of the install taken from the ground level. If it is not feasible to capture a photo of the AP at the ground level, a picture at the deployment level may be used.

Note, that information and images submitted are not required to be reviewed and or verified; however, they can be used and reviewed by any Tier 1 Service Provider at any time to detect gaming. 

Please note, that any outdoor Wi-Fi AP's that were deployed prior to requiring an image within their submission above will be required to submit an image of their set up within 120 calendar days upon HIP passing. If information is not submitted by 120 calendar days, the Wi-Fi AP will cease to earn Modeled Coverage Points, and be required to pay a $10 MOBILE burn to update its information.

## Rejection Due to Gaming Concerns
As gaming becomes rampant within the MOBILE ecosystem, this HIP gives CPI's and Tier 1 Service Providers (Tier 1 Service Provider is defined as a Service Provider who was approved by the MOBILE subDAO via HIP and staked 500M MOBILE) the authority to deny submissions on radios and Wi-Fi AP's even after they were initially approved or submitted if new information comes to light that the CPI or Service Provider suspects that the information originally submitted is no longer accurate or valid. Upon denying a previously approved submission, the radio/Wi-Fi AP will no longer earn ANY rewards (including data and modeled coverage rewards) until a new submission is submitted to the CPI/Service Provider, and approved by the CPI/Service Provider. These new submissions will incur the same fees identified in the fee schedule above. New submissions due to gaming concerns may require additional submission data beyond what is required in the above portion of this HIP at the request of the CPI/Service Provider, such as a live or recorded video of the actual installation and or a written explanation explaining the discrepancy. 


The following is a list of gaming reasons that the CPI/Service Provider may deny a submission:

- Radio/Wifi AP is not in the same location as the submission data states. This includes:
    - Height mismatch
    - Location mismatch
    - Spoofing of location

- False, inaccurate, or deceptive images/data submitted

- Fraud
    - Including subscriber abuse of subscribers signing up, offloading data, and then canceling the subscriber plan prior to grace period end date
    - Consistently offloading data of subscribers who signed up with fraudulent information, such as payment source

If a submission is rejected for gaming concerns, the CPI/Service Provider may take up to 30 calendar days to re-verify the new information submitted. The Service Provider and or CPI Entity that rejects submissions will be required to review any re-submissions as a result of the rejection within the timelines identified in this HIP.

## Indoor Hotspot Gaming
This HIP also grants authority to Tier 1 Service Providers to turn off, or effectively provide a 0X reward multiplier for both PoC and Data rewards for indoor CBRS and indoor Wi-Fi APs for up to ten (10) epochs for suspicion of gaming, so long as the reason is a reason identified in the section above. The gaming reason and length of deactivation must be submitted to the Oracle so the reason and deactivation length is public. After 10 epochs, the device must automatically be turned back on with full use with reward multipliers recalculated. However, if the gaming continues, the Service Provider may continue to deactivate the device, 10 epochs at a time until gaming ceases.    

## Abuse of Power
If it is identified that Service Providers are abusing their power to turn off MOBILE equipment without valid gaming reasons, or do not adhere to the requirements of this HIP, an informal governance proposal may be raised by the MOBILE Working Group to slash an amount of the Service Providers stake. The proposal must be voted on by the MOBILE subDAO with veMOBILE and pass by at least 67%.

## Drawbacks:
Deployers will now have to pay a fee whenever they move locations, or onboard a new CBRS radio.

## Rationale and Alternatives:
An alternative would be to do nothing, and do nothing to stop gaming from occurring. 

## Deployment Impact:
The following will need to occur once the HIP is passed:

- A method to burn MOBILE from the Helium Wallet and or Helium Builder app will need to be created in such a way that the CBRS radio and or Wi-Fi AP serial number or hotspot name is inscribed in the transaction message of the burn in order to keep everything on-chain.
- Helium Mobile (and or any new outdoor Wi-Fi Manufacturer) will need to capture and retain an image for each outdoor hotspot deployment as a part of the onboarding and or location update process, and make this image available to any Tier 1 Service Providers upon request. 


## Success Metrics: 
This HIP is successful if: the amount of gaming is reduced on the MOBILE Network.




