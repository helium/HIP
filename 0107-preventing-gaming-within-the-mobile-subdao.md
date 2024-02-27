# HIP 107: Preventing Gaming Within the MOBILE SubDAO

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) 
- Start Date: 2023-12-31
- Category: Economic, Technical
- Original HIP PR: [#857](https://github.com/helium/HIP/pull/857)
- Tracking Issue: [#881](https://github.com/helium/HIP/issues/881)
- Vote Requirements: veMOBILE Holders

## Summary:
This Helium Improvement Proposal (HIP) proposes giving Service Providers the authority to temporarily deactivate radios/access points if they are suspected of gaming and impose additional measures to prevent gaming.


## Motivation:
The primary Service Provider and company that reviews CPI information, Nova Labs (d.b.a. Helium Mobile), has expressed concern for ongoing gaming that they've identified within the MOBILE subnetwork; however, they do not have the appropriate authority to stop this from occurring. This HIP will give MOBILE subDAO Service Providers the authority needed to curb gaming. 

## Stakeholders:
The stakeholders of this proposal are:

- **Tier 1 Service Providers** will be able to temporarily turn off radios/Wi-Fi APs suspected of gaming. This may require them to allocate internal resources to use these tools to manage the rejection communication.
- **CPI Reviewing Entity** will be able to reject previously approved CPI submissions if they are suspected of gaming.
- **Gamers** will now suffer an opportunity cost loss when they are caught gaming.
- **Outdoor Wi-Fi Deployers** will now be required to upload a picture of their deployment when they assert a new location


## Detailed Explanation:
This HIP proposes allowing Tier 1 Service Providers (Tier 1 Service Provider is defined as a Service Provider who was approved by the MOBILE subDAO via HIP and staked 500M MOBILE) the ability to temporarily deactivate CBRS Radios and Wi-Fi Access Points when they have a reasonable belief that gaming is occurring. Further, the Certified Professional Installer (CPI) Entity may revoke or deny submissions due to suspected gaming. 

Specifically, Service Providers can now stop Radios/Access Points from producing heart beats, or effectively provide a 0X reward multiplier for both PoC and Data rewards for CBRS Radios and Wi-Fi Access Points for up to ten (10) consecutive epochs if they are suspected of gaming, so long as the reason is a reason identified in the section below. The gaming reason and length of deactivation must be submitted to the MOBILE Oracle so the reason and deactivation length is public. After the defined deactivation time (10 epochs maximum), the device must automatically be turned back on/re-activated (exception is for outdoor CBRS radios, which need a new CPI submission approved). However, if the gaming continues, the Service Provider may continue to deactivate the device, up to 10 epochs at a time until gaming ceases.

Outdoor Radios suspected of gaming may have their CPI registration revoked or denied, and will not be able to earn rewards until a new submission is submitted and approved.

Further, it is noted that due to the shorter range of outdoor Wi-Fi, that the maximum height that can be asserted for outdoor Wi-Fi Access Points will be changed to 100 feet. Deployments can still be deployed higher than 100 feet; however, the maximum asserted height will only be able to be set to 100 feet. If any deployments currently have an asserted height of greater than 100 feet, they will need to lower it to 100 feet or less in order to continue to earn modeled coverage rewards.

Lastly, this HIP requires deployers asserting a new location for outdoor Wi-Fi Access Points will also be required to also submit a picture of the Access Point from the ground level showing the height of the installation. 

## Rejection Due to Gaming Concerns
The following is a list of gaming reasons that the CPI/Service Provider may deny a submission or deactivate a device:

- Radio/Wifi AP is not in the same location as the submission data states. This includes:
    - Height mismatch
    - Location mismatch
    - Spoofing of location

- False, inaccurate, or deceptive images/data submitted

- Fraud
    - Including subscriber abuse of subscribers signing up, offloading data, and then canceling the subscriber plan prior to grace period end date
    - Consistently offloading data of subscribers who signed up with fraudulent information, such as payment source


## Abuse of Power
If it is identified that Service Providers are abusing their power to turn off MOBILE equipment without valid gaming reasons, or do not adhere to the requirements of this HIP, an informal governance proposal may be raised by the MOBILE Working Group to slash an amount of the Service Providers stake. The proposal must be voted on by the MOBILE subDAO with veMOBILE and pass by at least 67%.

## Drawbacks:

Deployers who have an outdoor Wi-Fi Access Point asserted higher than 100 feet will need to update the assertion height to a maximum of 100 feet.

## Rationale and Alternatives:
An alternative would be to do nothing, and do nothing and allow gaming to continue. 

## Implementation Phases
 For HIP implementation, Helium Mobile has agreed to do the following: 

- Update the Helium Builder app to require a picture be uploaded when new assertions are done for outdoor Wi-Fi Access Points
- Update the Helium Builder app to change the maximum height an outdoor Wi-Fi Access Point can be asserted to at 100 feet
- For any outdoor Wi-Fi Access Points asserted greater than 100 feet, give each of those Access Points a 0X multiplier until the height is            asserted to 100 feet or less.
- Submit to the MOBILE oracle instances where they deactivate a device to include the deactivation reason and deactivation length.


## Success Metrics: 
This HIP is successful if the amount of radios/access points that are incorrectly asserted or that are abusing the network decrease.
