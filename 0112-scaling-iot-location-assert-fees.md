# HIP 112: Scaling IOT Hotspot Assert Fees

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2024-03-05
- Category: Economic, Technical
- Original HIP PR: [#912](https://github.com/helium/HIP/pull/912)
- Tracking Issue: [#931](https://github.com/helium/HIP/issues/931)
- Vote Requirements: veIOT Holders

---

## Summary

This HIP proposes allowing one (1) free IOT Location assertion per rolling 365 epoch period for IOT Hotspots, including the initial assertion, and allowing one (1) free IOT assertion per one (1) epoch for IOT Data-only Hotspots. Any additional assertions conducted within the above rolling periods will be required to pay the existing $10 fee in Data Credits (1,000,000 DC) burn for Hotspots, and the existing $5 fee in Data Credits (500,000 DC) for Data-only Hotspots. This HIP also removes the fee ($10 for IOT Hotspot and $5 for IOT Data-Only Hotspots) associated with asserting the initial location for Hotspots during onboarding.

## Motivation

Currently, some Hotspot deployers disagree with paying a $10 fee to reassert their Hotspot's location, and therefore, will not reassert their location after they move to a different hex. Depending on distance this may result in IOT explorers being inaccurate and displaying Hotspots in locations they may no longer be in.  

Current fees:
IOT Hotspot Makers pay the onboarding and initial location assertion fees for IOT Hotspots. 4,0000,000 DC for Onboarding and 1,000,000 DC for Assertion.
If Hotspot makers do not have the DC Balance, hotspot owners can elect to use the Helium Wallet App and pay these fees from their own wallet.
Hotspot owners pay the onboarding and initial location assertion fees for IOT Data-only/DIY  Hotspots from their own wallet. 1,0000,000 DC for Onboarding and 500,000 DC for Assertion.

## Stakeholders

- **New IOT Hotspot Owners** who have a new Hotspot in which the maker wallet does not contain appropriate funds to cover the initial assertion will now be able to complete that initial assertion for free.
- **IOT Hotspot Owners** will be able to assert their location for free once per year, including their first assert.
- **Data-only IOT Hotspot Owners** will be able to assert their location for free once per day, including their initial assert.
- **IOT Hotspot Makers** will no longer be required to cover the initial $10 DC assertion fee, which may allow Hotspot makers to sell Hotspots for a cheaper price.
  **IOT Hotspot Makers with large DC Balances** proportionate to quantity of Hotspot onboards will take longer to burn through their balance as DC is consumed 20% slower. Eg, SenseCAP, Browan, Milesight, Dragino

## Detailed Explanation
By allowing one (1) free location assertion per year for Hotspots, and one (1) free per epoch for data-only Hotspots, Hotspot owners are more likely to relocate and assert their Hotspots correctly, leading to improved network coverage in various locations. 

## Technical Implementation

The workflow for initial and reassertions for Hotspots will be as follows:

1. User initiates location assertion within the Helium Wallet App or Maker App.
2. The App requests on-chain data for that Hotspot to determine the location assertion fee.
3. If the last free (0 DC) location assertion was > 365 epochs or never occurred, the cost submitted for an assertion is 0 DC
4. If the last free (0 DC) location assertion was < 365 epochs, the cost submitted for an assertion is 1,000,000 DC ($10).

The workflow for initial and reassertions for Data-only Hotspots will be as follows:

1. User initiates location assertion within the Helium Wallet App or Maker App.
2. The App requests on-chain data for that Hotspot to determine the location assertion fee.
3. If the last free (0 DC) location assertion was > 1 epoch or never occurred, the cost submitted for an assertion is 0 DC
4. If the last free (0 DC) location assertion was < 1 epoch, the cost submitted for an assertion is 500,000 DC. ($5)


## Drawbacks

The primary drawback of this proposal is a lower overall DC burn for the network. However, the potential benefits gained from increased Hotspot relocation and improved network coverage can offset this drawback.
Makers with large holdings of DC will need to sell 25% more hotspots to consume this this DC Balance.

## Rationale

Certain market conditions may discourage deployers from reasserting their Hotspot to the correct location due to costs, or discourage them from even setting up future deployments due to the associated fees. This HIP proposes to fix that.

## Implementation

The Helium Wallet App and Maker Apps do not need to be updated. 
The Helium Foundation is requested to make the changes in the onboarding process to confirm the reduced 0 DC fee as appropriate.

## Success Metrics
This HIP will be considered successful if more incorrectly asserted IOT Hotspots reassert their Hotspot to correct location on the network.

