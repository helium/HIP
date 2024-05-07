# HIP 121: Service Provider Hex Boosting Improvements

- Author(s): [Jeremy Mahrle](https://github.com/jaym2518)
- Start Date: 2024-04-25
- Category: Economic, Technical
- Original HIP PR: [#991](https://github.com/helium/HIP/pull/991)
- Tracking Issue: [#995](https://github.com/helium/HIP/issues/995)
- Vote Requirements: veMOBILE Holders

---

## Summary

This Helium Improvement Proposal (HIP) makes changes to Service Provider (SP) Hex Boosting based on what we have learned from the last several months of an SP utilizing the hex boosting mechanism for the first time.

## Prior Related HIPs

- [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created SP Hex Boosting.

- [HIP-109](https://github.com/helium/HIP/blob/main/0109-hex-boosting-by-deployment.md) previously altered HIP 84 by allowing SPs to specify what types of deployments their hex boosting can be applied to.

## Motivation:
In hexes where SPs have or expect to have high demand for data, they have the ability to burn MOBILE tokens to provide a boost to Proof-of-Coverage (PoC) rewards in those hexes, as defined in HIP-84. However, our experiences have shown that the HIP as implemented has some shortfalls and, in some cases, can encourage behavior detrimental to the network.

## Stakeholders:

The stakeholders of this proposal are:
- Service Providers will be able to better utilize their Hex Boosting abilities.
- Deployers and Operators of both CBRS and Wi-Fi will have better guidance on where an SP wants coverage to be deployed.

## Detailed Explanation:
This HIP makes the following change:

**Cap on Boost Multiplier: ** We have learned that boosting hexes at too large of a percentage can encourage gaming behavior in order to collect increased PoC rewards, such as spoofing GPS coordinates, speed test results, and/or the Skyhook location of a deployment. By capping the amount that an SP can boost, we can reduce instances of this gaming vector.

This action will also mitigate the effects of a potential future gaming vector where an SP could boost hexes where their own deployments are located to such an extent that they would be able to collect nearly all the PoC rewards issued in an epoch.

To address these vectors, this HIP proposes creating a chain variable to allow for an upper cap to be placed on the multiplier that an SP can boost a hex.

Initially, the variable will be set to 20x. In the future if there is a desire to change the variable to a different cap, a new HIP will be required. If HIP authors follow the standard HIP template and limit their proposal to only adjusting this specific chain var with no other proposed changes, they will be able to request that the Foundation fast-track the proposal to a vote.

## Drawbacks:
None.

## Rationale and Alternatives
Taking no action would allow a known gaming vector to continue unabated by the subDAO.

The HIP authors acknowledge that the variable(s) proposed here will likely need to be revisited again at some point in the future as we learn more about the effects of SP Hex Boosting.

##Unresolved Questions
None.

## Deployment Impact
Implementation of this HIP will be completed by…

## Success Metrics
The primary success metrics will be continued growth in the number of legitimate deployments in hexes that have been boosted by an SP.
