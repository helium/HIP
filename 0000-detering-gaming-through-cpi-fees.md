# HIP XXX: Detering Gaming Through CPI Fees

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) 
- Start Date: 12/31/2023
- Category: Economic, Technical
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veMOBILE Holders

## Summary:
This Helium Improvement Proposal (HIP) proposes requiring a fee in MOBILE be burned whenever a deployer submits new Certified Professional Installer (CPI) information for outdoor CBRS Radios, and updated location data for outdoor Wi-Fi in order to deter false information from being submitted.

## Motivation:
Currently, the IOT subDAO requires a fee whenever you move your Lorawan Hotspot; however, there are currently no fees associated with moving your outdoor CBRS radio and outdoor Wi-Fi AP. This HIP proposes establishing a fee to be burned for submitting new location data for outdoor radios and outdoor Wi-Fi APs.

## Stakeholders:
The stakeholders of this proposal are:

- **Outdoor CBRS and Wi-Fi Deployers** will be required to pay a fee when they move their radio/AP or onboard a new radio
- **CPI Entities** will now be able to charge a fee of up to $20 for reviewing CPI information of CBRS radios.
- **MOBILE Holders** will benefit with an increased value in terms of MOBILE/HNT Treasury swap rate.

## Detailed Explanation:
This HIP proposes the following fee structure:

### Outdoor CBRS Radios
A $20 fee in MOBILE burn will be required whenever new CPI information is submitted, which includes the initial/first CPI submission, and any submissions thereafter. If the CPI submission is rejected for a mistake made by the deployer when submitting the information, the deployer will have one (1) free resubmission for that radio, so long as that re-submission is done within 30 calendar days after initial rejection. If the CPI rejects the reason for any potential gaming concerns, there will be no free re-submissions, and a new fee will need to be paid. 

This HIP also grants authority to the CPI reviewer of outdoor CBRS radios to charge a seperate standard or priority fee of up to a $20 paid in MOBILE to the CPI reviewing entity. This fee is paid directly to the entity that is completing the CPI submission, and is NOT burned. If a fee is charged by the CPI reviewing entity, the following is required:

- The CPI submission must be approved or rejected within 2 business days
- A guide must be created that documents each reason a submission may be rejected (i.e. incorrect height, incorrect azimuth, outdoor radio installed indoors, gaming concerns, etc.)
- If the CPI submission is rejected for a reason that is not noted within the guide, the re-submission may be redone for free, regardless if it is the first or second submission, and also must be reviewed (approved or rejected) within one (1) business day of re-submission. Please note, this rule is not applicable if the submission was rejected due to gaming concerns.

### Outdoor Wi-Fi AP's
A $10 fee in MOBILE burn will be required when the location for outdoor Wi-Fi AP's are re-submitted. Unlike CBRS, the first location assert will occur at a $0 MOBILE burn cost. Additionally, location information will need to be submitted for review by a CPI, or at minimum under supervision of a CPI. The minimum information that is required to be submitted is as followed:

- Install height (in feet)
- Two (2) pictures of the setup - One (1) verifying the height of the install and one (1) showing the point of view (with the Wi-Fi AP in frame) of the direction the radio is facing
- Picture of a phone displaying the correct Azimuth of the direction the device is facing

No fees may be charged by the CPI reviewer for these submissions. Any re-submissions will incur a new $10 MOBILE burn. Note, that unlike CBRS CPI submissions, the Outdoor Wi-Fi AP will still earn even if the submission has not yet been reviewed. If the submission is rejected, the Wi-Fi AP will stop earning PoC Modeled Coverage Points until a new submission is submitted AND approved. 

Please note, that any outdoor Wi-Fi AP's that were deployed prior to requiring the information submission above will be required to submit that data within 60 calendar days upon HIP passing. If information is not submitted by 60 calendar days, the Wi-Fi AP will cease to earn Modeled Coverage Points, and be required to pay a $10 MOBILE burn.

## Rejection Due to Gaming Concerns
As gaming becomes rampant within the MOBILE ecosystem, this HIP gives CPI's the authority to deny submission information on radios and Wi-Fi AP's even after they were initially approved if new information comes to light that the CPI suspects that the information originally submitted is no longer accurate or valid. Upon denying a previously approved submission, the radio/Wi-Fi AP will no longer earn PoC Modeled Coverage Points until a new submission is submitted and approved by the CPI. These new submissions will occur the same fees identified in the fee schedule above. New submissions due to gaming concerns may require additional submission data beyond what is required in the above portion of this HIP, such as a live or recorded video of the actual installation. 


## Drawbacks:
Deployers will now have to pay a fee whenever they move locations, or onboard a new CBRS radio.


## Rationale and Alternatives:
An alternative would be to do nothing, and keep allowing outdoor CBRS radios and Wi-Fi APs to be onboarded, moved, and re-certified for no fee.


## Deployment Impact:
A method to burn MOBILE from the Helium Wallet will need to be created in such a way that the CBRS radio and or Wi-Fi AP serial number that is being submitted is inscribed in the transaction message of the burn in order to keep everything on-chain. 

## Success Metrics: 
This HIP is successful if: the amount of false and inaccurate CPI submissions decreases.  




