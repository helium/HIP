# HIP 97: Removing Manual MOBILE Location Assertions

- Authors: [Andy Zyvoloski](https://github.com/heatedlime) & [Max Gold](https://github.com/maxgold91)
- Start Date: 2023-10-02
- Category: Economic, Technical
- Original HIP PR: [#787](https://github.com/helium/HIP/pull/787)
- Tracking Issue: [#795](https://github.com/helium/HIP/issues/795)
- Vote Requirements: veMOBILE Holders

## Summary

This HIP proposes removing the MOBILE location assert fee for Helium 5G Hotspots and indoor Wi-Fi Hotspots, while having locations automatically updated on chain as they occur.

## Motivation

Paying a fee to manually self-assert a location change for Helium 5G Hotspots is wasteful, as the data obtained from self-assertions is unreliable as deployers can assert their equipment in a location other than where it's actually deployed without an impact to earnings. Additionally, indoor Wi-Fi AP's have the ability to self determine the location, bypassing the need for a manual assertion.

## Stakeholders

MOBILE Hotspot and indoor Wi-Fi AP Deployers - This stakeholder is impacted as it removes the cost and manual intervention needed to relocate their coverage devices.

Helium (HNT) Token Holders - This stakeholder is impacted as less DC will be burned upon implementation.

Helium 5G Vendors/Manufactures - These stakeholders will be required to pay on chain transaction fees when Hotspots and indoor Wi-Fi APs move locations.

## Detailed Explanation

Currently, when Helium 5G Hotspots are asserted or re-asserted, the location of the Hotspot will update on the blockchain to note the Hotspot location at the res8 hex level. This location data is not used for any other purpose other than having the ability to display the hotspot location on a 3rd party explorer. This data is not useful, as it relies upon the self-assertion to be asserted in the correct spot, and does not show the assertion at the res12 hex level, which is used by the MOBILE subDAO. Further, currently, Hotspots do not need to be asserted at all, nor be asserted in the same location for the Hotspot to earn MOBILE rewards.

Additionally, unlike Helium 5G Hotspots, indoor Wi-Fi APs have the ability to self-assert their location through a third party vendor integrated within the Hotspot, which independently verifies the location. Eliminating the manual location assert process will give deployers a more enjoyable user experience, as after the AP is onboarded, the location will automatically report any location changes to the blockchain without manual intervention.

This HIP will be implemented in three (3) phases, which are noted below:

### Phase 1

Upon the passing of this HIP, the Helium Foundation will need to update the Helium multisig for the MOBILE Assertion Fee from 10 USD to 0 USD.

### Phase 2

Phase 2 consists of reporting radio Spectrum Access System (SAS) and Wi-Fi Access Points location data at a res12 hex level to an oracle. Nova has agreed to undertake the work that is required to implement Phase 2.

As each indoor and outdoor Wi-Fi Access Point is placed or moved, a confidence score is generated from a third party vendor integration to determine how confident the system is that the automatically asserted location is accurate. To ensure that each Wi-Fi Access Point is given enough time to self determine its location and generate a confidence score, each time the Access Point is moved to a new location, or onboarded, it must first undergo a probationary period of 1 epoch, and within that epoch, have a distinct 12 valid heartbeats within the new location before it will be rewarded PoC. The probationary period will still allow the Access Point to be rewarded for data transfers. During each reported heartbeat, the confidence score at the time of the heartbeat will be recorded. The average confidence score captured from all heartbeats within the probationary period must be greater than or equal to 80%. If the average confidence score is not greater than or equal to 80% within the first probationary period of 1 epoch, and/or there was not at least 12 distinct, the Access Point will stay in a probationary period and not be eligible to earn PoC rewards (it will still earn data rewards) until the average confidence score per epoch is greater than or equal to 80%, and at least 12 distinct heartbeats occurred.

After the probationary period, if it is detected that the Access Point has moved locations, it will then be required to undergo a new probationary period to establish a new confidence level. Movement detection is noted by a drop in confidence level for one or more heartbeats of 75% or lower.

In any instances where a heartbeat is not generated or valid, that confidence score will not be reported, or counted towards any averages.

### Phase 3

Phase 3 consists of moving location data on-chain. Once locations are on-chain, Wi-Fi Access Point manufactures will be required to pay for any on-chain fees associated with the assertions.

## Alternatives

One alternative is instead of reducing the assertion fee to 0 USD, would be to change how it is paid (i.e. MOBILE burn). However, prompting the user to pay a fee every time they change device locations may complicate the user experience.

## Success Metrics

This HIP will be noted as successful once radio GPS coordinates from SAS and Wi-Fi Access Point location data are on chain and updated automatically.
