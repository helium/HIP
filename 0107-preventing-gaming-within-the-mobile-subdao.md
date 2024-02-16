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
- Giving Service Providers the authority to temporarily deactivate radios/access points if they are suspected of gaming


## Motivation:
The primary Service Provider and company that reviews CPI information, Nova Labs (d.b.a. Helium Mobile), has expressed concern for ongoing gaming that they've identified within the MOBILE subnetwork; however, they do not have the appropriate authority to stop this from occurring. This HIP will give MOBILE subDAO Service Providers the authority needed to curb gaming. 

## Stakeholders:
The stakeholders of this proposal are:

- **Outdoor CBRS and Wi-Fi Deployers** will be required to pay a fee when they move their radio/AP or onboard a new radio.
- **MOBILE Holders** will benefit with an increased value in terms of MOBILE/HNT Treasury swap rate.
- **Tier 1 Service Providers** will be able to temporarily turn off radios/Wi-Fi APs suspected of gaming. This may require them to allocate internal resources to use these tools to manage the rejection communication.
- **CPI Reviewing Entity** will be able to reject previously approved CPI submissions and or outdoor Wi-Fi deployments if they are suspected of gaming.
- **Gamers** will now suffer a financial and or opportunity cost loss when they are caught gaming.
- **MOBILE App Developers** will need to ensure their the onboarding app allow for submitting and paying for location change and CPI submissions.


## Detailed Explanation:
This HIP proposes two main concepts to help curb gaming:

1. Impose CPI/relocation fees for outdoor CBRS and outdoor Wi-Fi access points to discourage providing false assertion/CPI information, and allowing the CPI/Service Provider to revoke the previously submitted CPI and or location assert information if the CPI/Service Provider suspects the initial information is no longer accurate.


2. Allowing Tier 1 Service Providers (Tier 1 Service Provider is defined as a Service Provider who was approved by the MOBILE subDAO via HIP and staked 500M MOBILE) the ability to temporarily deactivate indoor Wi-Fi and CBRS radios when they have a reasonable belief that gaming is occurring. 


Under concept 1 above, this HIP proposes the following fee structure:

### Outdoor CBRS Radios
A $20 fee in MOBILE burn will be required whenever new CPI information is submitted, which includes the initial/first CPI submission, and any submissions thereafter. If the CPI submission is rejected for a mistake made by the deployer when submitting the information, the deployer will have one (1) free resubmission for that radio, so long as that re-submission is done within 30 calendar days after initial rejection. If the CPI rejects the submission for any potential gaming concerns, there will be no free re-submissions, and a new fee will need to be paid. 

### Outdoor Wi-Fi AP's
A $10 location submission fee in MOBILE burn will be required when the location/height/direction for outdoor Wi-Fi AP's are re-submitted/updated. Unlike CBRS, the first location assert will occur at a $0 MOBILE burn cost. Below are the minimum requirements that must be submitted when updating the location/height/direction of an outdoor Wi-Fi AP:

- Install height (in feet)
- Azimuth
- One picture verifying the height of the install taken from the ground level. If it is not feasible to capture a photo of the AP at the ground level, a picture at the deployment level may be used.

Note, that information and images submitted are not required to be reviewed and or verified; however, they can be used and reviewed by any Tier 1 Service Provider at any time to detect gaming. 

## Rejection Due to Gaming Concerns
As gaming becomes rampant within the MOBILE ecosystem, this HIP gives CPI's and Tier 1 Service Providers the authority to deny submissions on radios and Wi-Fi AP's even after they were initially approved or submitted if new information comes to light that the CPI or Service Provider suspects that the information originally submitted is no longer accurate or valid. Upon denying a previously approved submission, the radio/Wi-Fi AP will no longer earn ANY rewards (including data and modeled coverage rewards) until a new submission is submitted to the entity that rejected it, and approved by said entity. These new submissions will incur the same fees identified in the fee schedule above. New submissions due to gaming concerns may require additional submission data beyond what is required in the above portion of this HIP at the request of the CPI/Service Provider, such as a live or recorded video of the actual installation and or a written explanation explaining the discrepancy. 

The following is a list of gaming reasons that the CPI/Service Provider may deny a submission:

- Radio/Wifi AP is not in the same location as the submission data states. This includes:
    - Height mismatch
    - Location mismatch
    - Spoofing of location


- False, inaccurate, or deceptive images/data submitted

- Fraud
    - Including subscriber abuse of subscribers signing up, offloading data, and then canceling the subscriber plan prior to grace period end date
    - Consistently offloading data of subscribers who signed up with fraudulent information, such as payment source

If a submission is rejected for gaming concerns, the CPI/Service Provider may take up to 30 calendar days to re-verify the new information submitted. The Service Provider and or CPI Entity that rejects submissions will be required to review any re-submissions as a result of the rejection within the timelines identified in this HIP. If the submission is not reviewed within 30 calendar days, the Service Provider is required to re-activate that device with the previous information submitted, and may not reject the device again for a minimum of 45 calendar days.

## Indoor Hotspot Gaming
This HIP also grants authority to Tier 1 Service Providers to turn off, stop from producing heart beats, or effectively provide a 0X reward multiplier for both PoC and Data rewards for indoor CBRS and indoor Wi-Fi APs for up to ten (10) epochs if they are suspected of gaming, so long as the reason is a reason identified in the section above. The gaming reason and length of deactivation must be submitted to the MOBILE Oracle so the reason and deactivation length is public. After the defined deactivation time (10 epochs maximum), the device must automatically be turned back on/re-activated. However, if the gaming continues, the Service Provider may continue to deactivate the device, up to 10 epochs at a time until gaming ceases.    

## Abuse of Power
If it is identified that Service Providers are abusing their power to turn off MOBILE equipment without valid gaming reasons, or do not adhere to the requirements of this HIP, an informal governance proposal may be raised by the MOBILE Working Group to slash an amount of the Service Providers stake. The proposal must be voted on by the MOBILE subDAO with veMOBILE and pass by at least 67%.

## Drawbacks:
 - Deployers will now have to pay a fee whenever they move locations, or onboard a new CBRS radio.
 - First time deployers of outdoor CBRS radios will now be required to hold MOBILE tokens in their wallet before deployment of a CBRS radio in order to pay for CPI submission fees.

## Rationale and Alternatives:
An alternative would be to do nothing, and do nothing and allow gaming to continue. 


## Implementation Phases
This HIP will be implemented in the following two phases:

### Phase 1
Immediately after passing, Tier 1 Service Providers will be allowed to deactivate indoor Wi-Fi and CBRS devices for up to 10 epochs at a time that are suspected of gaming, so long as the deactivation reason aligns with those identified within this HIP, and the reason and length of deactivation is submitted to the MOBILE Oracle.

Phase 1 will also allow the deactivation of outdoor Wi-Fi Access Points for up to 10 epochs at a time that are suspected of gaming until Phase 2 is implemented. 

### Phase 2
- A method to submit and or resubmit CPI data/images as well as outdoor Wi-Fi deployment images will be added into the Helium Builder app.
- Nova Labs a.k.a Helium Mobile will work with the Helium Foundation to create or establish a method to burn MOBILE from the Helium Builder app (or similar app) in such a way that the CBRS radio, Wi-Fi AP serial number and or hotspot name is inscribed in the transaction message of the burn transaction in order to keep everything on-chain.
- Nova Labs will need to change the outdoor Wi-Fi onboard flow to allow outdoor Wi-Fi APs to be onboarded on chain without submitting an initial assertion, as well as requiring an image of the deployment at each assertion.


## Success Metrics: 
This HIP is successful if the amount of radios that are incorrectly asserted or that are abusing the network decrease.
