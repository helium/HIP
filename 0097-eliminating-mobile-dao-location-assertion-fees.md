  # HIP 97: Eliminating MOBILE Location Assertion Fees

- Authors: [Andy Zyvoloski](https://github.com/heatedlime) & [Max Gold](https://github.com/maxgold91)
- Start Date: 2023-10-02
- Category: Economic, Technical
- Original HIP PR: [#787](https://github.com/helium/HIP/pull/787)
- Tracking Issue: [#795](https://github.com/helium/HIP/issues/795)
- Vote Requirements: veMOBILE Holders


## Summary 

This HIP proposes removing the MOBILE location assert fee for location assertions, and having locations automatically updated on chain as they occur. 

## Motivation 
Paying a fee to manually self-assert a location change is wasteful, as the data obtained from self-assertions is unreliable as deployers can assert their equipment in a location other than where it's actually deployed without an impact to earnings.

## Stakeholders
MOBILE Hotspot and Wi-Fi AP Deployers - This stakeholder is impacted as it removes the cost to relocate their coverage devices.

Helium (HNT) Token Holders - This stakeholder is impacted as less DC will be burned upon implementation.

Helium 5G Vendors/Manufactures - These stakeholders will be required to pay on chain transaction fees when Hotspots and radios move locations. 

## Detailed Explanation 
Currently, when Helium 5G Hotspots are asserted or re-asserted, the location of the Hotspot will update on the blockchain to note the Hotspot location at the res8 hex level. This location data is not used for any other purpose other than having the ability to display the hotspot location on a 3rd party explorer. This data is not useful, as it relies upon the self-assertion to be asserted in the correct spot, and does not show the assertion at the res12 hex level, which is used by the MOBILE subDAO. Further, currently, Hotspots do not need to be asserted at all, nor be asserted in the same location for the Hotspot to earn MOBILE rewards. 

Additionally, unlike Helium 5G Hotspots, Wi-Fi APs have the ability to self-assert their location through a third party vendor integrated within the Hotspot, which independently verifies the location. Eliminating the location assert fee will give deployers a more enjoyable user experience, as after the AP is onboarded, the location will automatically report any location changes to the blockchain without manual intervention. 

This HIP will be implemented in three (3) phases, which are noted below:

### Phase 1
Upon the passing of this HIP, the Helium Foundation will need to update the Helium multisig for the MOBILE Assertion Fee from 10 USD to 0 USD. 

### Phase 2
Phase 2 consists of reporting radio Spectrum Access System (SAS) and Wi-Fi Access Points location data at a res12 hex level to an oracle, and ultimately on chain. Nova has agreed to undertake the work that is required to implement Phase 2.

In order to prevent the continual moving of Wi-Fi Access Points, which then causes an on-chain transaction and associated fee, a Wi-Fi Access Point may only have its location automatically re-asserted once every three (3) epochs. Hotspot Vendors/Manufacturers will be required to pay any Solana transaction fees that occur from these assertions.

Further, in order to help cover on chain fees and time spent, this HIP grants authority to vendors providing CPI services to charge up to a $10.00 USD or equivalent fee paid directly to the vendor per request, so long as the request is approved or rejected within 2 business days. If a request results in a rejection, the submitter may re-submit that request up to three (3) times for free. Any resubmission after the third rejection will be treated as a new request, and subject to up to a $10.00 USD or equivalent fee. 

This HIP leaves the implementation of Phase 2 open to interpretation by Nova Developers who will implement this change on behalf of the community.

Once Phase 2 is implemented, manual user initiated location assertions will no longer exist, as assertions will be completed automatically. 


## Alternatives
One alternative is instead of reducing the assertion fee to 0 USD, would be to change how it is paid (i.e. MOBILE burn). However, prompting the user to pay a fee every time they change device locations may complicate the user experience. 

## Success Metrics
This HIP will be noted as successful once radio GPS coordinates from SAS and Wi-Fi Access Point location data are on chain and updated automatically.
