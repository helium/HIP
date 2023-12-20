## Restricting PoC Rewards for New CBRS Deployments
Authors: [Andy Zyvoloski](https://github.com/heatedlime)  

Start Date: 

Category: Technical & Economic

Original HIP PR: #

Tracking Issue: #

Voting Requirements: veMOBILE


## Summary:
This Helium Improvement Proposal (HIP) will temporarily remove Proof of Coverage (PoC) rewards for new indoor and outdoor CBRS radios to the Helium 5G Network for six (6) months (180 calendar days) after implementation. If this HIP passes, it will be implemented 30 calendar days after passing. 


## Motivation:
CBRS radios currently provide a lot less utility on the network. Specifically:

- There is no immediate solution for Android phones to seamlessly hand-off data sessions between macro network like T-Mobile and CBRS;
- There is a way to do this for iOS17 devices, but, so far, this only works on iPhones 13+ and requires an install of a geo-fencing profile by the end user;
- CBRS radios have no ability to provide guest / public Wi-Fi service and will always require an installation of an additional, second CBRS sim on a client device to be accessible.

Therefore, as the CBRS coverage is not ready for mainstream usage, this HIP proposes decreasing the incentive to deploy new CBRS radios. 

## Stakeholders:
CBRS Hardware Vendors and Distributors - these stakeholders will be affected as they may experience a decrease of sales of CBRS equipment during the 6 month period this HIP is in effect. 

Deployers - this HIP will make it more fair for deployers who are able to deploy a more optimal Wi-Fi AP setup than current existing setups.


Subscribers - Subscribers may see more coverage of Wi-Fi access as this HIP will encourage Wi-Fi deployments to not be bunched together.


Service Providers - if better Wi-Fi coverage is added due to this HIP, Service Providers will see an increased amount of data being offloaded onto the Helium Mobile Network.

## Detailed Explanation:
As MOBILE token demand increases, the incentive for deployers to deploy more CBRS coverage increases, even though that coverage won’t be usable for the foreseeable future to all Helium Mobile subscribers (at the time of this HIP, Helium Mobile is the only service provider for the MOBILE subDAO). As such, the network should stop rewarding new CBRS deployments PoC as they don’t provide much benefit to the network at this point in time. 


### Grace Period
Upon HIP passing, this HIP would grant a 30 day grace period to allow any newly purchased CBRS radios to have their CPI information submitted (for outdoor radios) or pass heartbeat requirements for one (1) epoch for indoor radios. If false pictures or data is used to try to pass CPI approval, the CPI approver may reject the submission, and ban this radio from being approved at this time. If the information submitted to the CPI is not doctored, false, and the correct data was used, but there was an honest error or omission, the submission may still be rejected, but can be re-submitted with the correct information to attempt to be onboarded again. Any re-submissions must be submitted within 60 calendar days after HIP passing. Any submissions submitted after 60 days after HIP passing will not be reviewed, and will be automatically rejected.

### Grandfathered Radios
Any radios that were onboarded (CPI has been approved for that radio to operate on the Helium 5G Network at least once) will be grandfathered in and will continue to earn PoC rewards on the network. 

### Special Circumstances
In an instance where a new service provider is approved to join the MOBILE network, and that service provider will use CBRS to offload data, this HIP will expire, even if 180 days have not passed.

## Drawbacks:
The implementation of this proposal will stunt the growth of the CBRS network; however, it should increase the focus to Wi-Fi deployments, which are usable by the network's service provider customers today. 

## Deployment Impact
Upon 30 days after passing, for any CPI submissions for outdoor radios, and any new onboarding of indoor radios, Nova/Freedomfi must modify the PoC multiplier for these devices to 0. 
 

## Success Metrics
The primary success metric will be to stop future CBRS deployments until CBRS is a usable/viable offload ramp for one of our service provider customers.
