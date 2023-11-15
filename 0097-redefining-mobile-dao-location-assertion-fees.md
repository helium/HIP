  # HIP 97: Eliminating MOBILE Location Assertion Fees

- Authors: [Andy Zyvoloski](https://github.com/heatedlime) & [Max Gold](https://github.com/maxgold91)
- Start Date: 2023-10-02
- Category: Economic, Technical
- Original HIP PR: [#787](https://github.com/helium/HIP/pull/787)
- Tracking Issue: [#795](https://github.com/helium/HIP/issues/795)
- Vote Requirements: veMOBILE Holders


## Summary 
This HIP proposes effectively removing the MOBILE location assert fee for Wi-Fi Access Points (APs) and Helium 5G Hotspots by setting the fee to 0 USD.

## Motivation 
Paying a fee to self-assert a location change is wasteful, as the data obtained from self-assertions is unreliable as deployers can assert their equipment in a location other than where it's actually deployed and still earn MOBILE.  

## Stakeholders
MOBILE Hotspot and Wi-Fi AP Deployers - This stakeholder is impacted as it removes the cost to relocate their coverage devices.

Helium (HNT) Token Holders - This stakeholder is impacted as less DC will be burned upon implementation.

## Detailed Explanation 
Currently, when Helium 5G Hotspots are asserted or re-asserted, the location of the Hotspot will update in the new res8 hex within API and is then ingested onto 3rd party explorers, such as the [Moken Explorer](https://explorer.moken.io/). This location data is not used for any other purpose, other than showing the location of the hotspot on a 3rd party explorer at the res8 level. This data is not useful, as it relies upon the self-assertion to be asserted in the correct spot, and does not show the assertion at the res12 hex level, which is used by the MOBILE subDAO. Further, Hotspots do not need to be asserted at all, nor be asserted in the same location as the Hotspot to earn MOBILE rewards. 

Additionally, unlike Helium 5G Hotspots, Wi-Fi APs have the ability to self-assert their location through Skyhook, which independently verifies and report the location of the AP to the blockchain and API. Eliminating the location assert fee will give deployers a more enjoyable user experience, as after the AP is onboarded, Skyhook will report each location change to the API and blockchain. Thus, manual self-assertion is redundant and wasteful. 

Based on the above, this HIP proposes removing the location assertion fee for Wi-Fi APs and Helium 5G Hotspots. 

### SAS and Skyhook Data
This HIP also requires that Nova provide an API of Spectrum Access System (SAS) radio location data and Wi-Fi Access Points Skyhook asserted location data at a res12 hex level within 6 months of HIP passing to allow coverage maps of radios and access points to be created by third parties outside of Nova's Coverage Planner.

## Alternatives
One alternative is instead of reducing the assertion fee to 0 USD, to change how it is paid (i.e. MOBILE burn). However, prompting the user to pay a fee every time they change device locations may complicate the user experience. 

## Technical Implementations:
The Helium Foundation will need to update the Helium multisig for the MOBILE Assertion Fee from 10 USD to 0 USD.

## Success Metrics
This HIP will be noted as successful once the MOBILE assertion fee is set to 0 USD.
