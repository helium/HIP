# HIP 107: Preventing Gaming Within the MOBILE Network

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2023-12-31
- Category: Economic, Technical
- Original HIP PR: [#857](https://github.com/helium/HIP/pull/857)
- Tracking Issue: [#881](https://github.com/helium/HIP/issues/881)
- Vote Requirements: veMOBILE Holders

## Summary
This Helium Improvement Proposal (HIP) proposes giving Service Providers the authority to temporarily deactivate radios/access points if they are suspected of gaming and impose additional measures to prevent gaming.


## Motivation
Currently, the first MOBILE Service Provider and company that reviews CPI information, Nova Labs (d.b.a. Helium Mobile), has expressed concern for ongoing gaming that they've identified within the MOBILE subnetwork; however, they do not have the appropriate authority to stop this from occurring. This HIP will give current and future MOBILE Service Providers the authority needed to curb gaming. MOBILE Rewards are designed to reward materially positive contributions to the Helium Network, through enhancing either network performance, network utility, or both. MOBILE Rewards are not intended to reward self-serving activity that has no material benefit to the Helium Network ("Gaming").

## Stakeholders
The stakeholders of this proposal are:

- **Service Providers** will be able to temporarily turn off CBRS radios/Wi-Fi APs suspected of gaming. This may require them to allocate internal resources to use these tools to manage the rejection communication.
- **CPI Reviewing Entity** will be able to reject previously approved CPI submissions if they are suspected of gaming.
- **All Deployers** will now suffer an opportunity cost loss when they are caught gaming.


## Detailed Explanation
This HIP proposes allowing Service Providers (Service Provider is defined as an entity who was approved by the MOBILE network via HIP and has staked 500M MOBILE tokens) the ability to temporarily deactivate CBRS Radios and Wi-Fi access points when they have a reasonable belief that gaming is occurring. Further, the Certified Professional Installer (CPI) Entity may revoke or deny submissions due to suspected gaming.

Specifically, Service Providers may stop radios/access points from producing heartbeats if they are suspected of gaming, effectively setting their reward multiplier to `0X` for both PoC and Data Transfer rewards. This may be set on CBRS Radios and Wi-Fi access points for up to ten (`10`) consecutive epochs. The specific reasons are identified in the section below. The reason and length of deactivation must be publicly submitted to the MOBILE Oracle. After the defined deactivation time (10 epochs maximum), the device must be automatically returned to normal participation on the network (with the exception of outdoor CBRS radios, which need a newly approved CPI submission). However, if the gaming activity continues, the Service Provider may deactivate the device again using the same duration defined above.

Outdoor Radios suspected of gaming may have their CPI registration revoked or denied, and will not be able to earn rewards until a new submission is submitted and approved.

If a Wi-Fi Access Point is deactivated due to gaming concerns, the Service Provider may request additional content, such as a deployment picture be submitted. If an image is not provided during the deactivation period, the Service Provider may renew the deactivation (up to 10 epochs at a time) until the request has been satisfied. 

### Outdoor Wi-Fi Maximum Height
It is worth noting that due to the shorter range of outdoor Wi-Fi, the maximum asserted height will be changed to 100 feet. This will be enforced initially in MOBILE oracles by using the value of 100 feet for all values above this limit. It may, in the future, be blocked at the protocol level. Deployments can still be deployed higher than 100 feet but these values will not be considered for the purpose of modeled coverage rewards.

### Maximum Asserted Distance Difference
For indoor and outdoor Wi-Fi access points, Hotspot locations are verified using external services like Skyhook. If the asserted distance is greater than 1000 meters away from the external service location, the trust score will be set to `0.00`.

Further, in order for access points to be eligible for boosted Service Provider rewards defined in HIP-84, the asserted distances must be 30 meters or less than the reported location from external services. In instances where the difference is greater than 30 meters, the access point will still be eligible for PoC rewards, but not boosted rewards.


## Rejection/Deactivation Due to Gaming Concerns
The following is a list of gaming reasons that the CPI/Service Provider may deny a submission or deactivate a device:

- Radio/Wi-Fi AP is not in the same location as the submission data states. This includes:
    - Height mismatch
    - Location mismatch
    - Spoofing of location

- False, inaccurate, or deceptive images/data submitted

- Fraud
    - Including subscriber abuse of subscribers signing up, offloading data, and then canceling the subscriber plan prior to grace period end date
    - Consistently offloading data of subscribers who signed up with fraudulent information, such as payment source


## Abuse of Power
If it is identified that Service Providers are abusing their power to turn off MOBILE equipment without valid gaming reasons, or do not adhere to the requirements of this HIP, a governance proposal may be raised by the MOBILE Working Group to slash an amount of the Service Providers stake. The proposal must be voted on by the MOBILE network with veMOBILE and pass by at least 67%.

## Drawbacks

Deployers who have an outdoor Wi-Fi Access Point asserted higher than 100 feet will need to update the assertion height to a maximum of 100 feet.

## Rationale and Alternatives
One alternative is to give the MOBILE network the power to ban Hotspots, similar to how Crowdspot operated on the IOT network. However, as there were flaws to that method, Crowdspot no longer exists due to the overhead required to operate that particular implementation.

## Implementation Phases

### Phase 1

* Create a process for Service Providers to submit deactivation reason and deadline to MOBILE Oracles
* Update MOBILE oracles to automatically reactivate devices after the specified deadline.

### Phase 2

* Update the MOBILE oracle to use 100 feet for any heights asserted by outdoor Wi-Fi access points higher than this value.
* Enforce maximum elevation for Outdoor Wi-Fi Hotspots on chain and make this configurable.
* Update the Helium Builder app to change the maximum height an outdoor Wi-Fi Access Point can be asserted to at 100 feet.

### Phase 3

* Update the Hotspot trust score for Wi-Fi Hotspots to 0.00 if the asserted location is 1000 meters or more from external data sources like Skyhook, etc.
* Update and backfill the protocol to add Height and Azimuth to on chain data of MOBILE hotspots.
* Update the Helium Wallet app to allow location assertions within the app by capturing height and azimuth.

## Success Metrics
This HIP is successful if the amount of radios/access points that are incorrectly asserted or that are abusing the network decrease.
