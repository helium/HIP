# HIP 112: Scaling IOT Hotspot Assert Fees

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2024-03-05
- Category: Economic, Technical
- Original HIP PR: [#912](https://github.com/helium/HIP/pull/912)
- Tracking Issue: [#931](https://github.com/helium/HIP/issues/931)
- Vote Requirements: veIOT Holders

---

## Summary

This HIP proposes allowing one (1) free IOT assertion per rolling 365 epoch period for Hotspots, including the initial assertion, and allowing one (1) free IOT assertion per one (1) epoch for data-only Hotspots. Any additional assertions conducted within the above rolling periods will be required to pay a $10 fee in Data Credit (DC) burn for Hotspots, and $5 fee in DC for data-only Hotspots. 

## Motivation

Currently, some Hotspot deployers disagree with paying a $10 fee to reassert their Hotspots location, and therefore, will not reassert their location after they move to a different hex. This may result in IOT explorers being inaccurate and displaying Hotspots in locations they may no longer be in.  


## Stakeholders

- **IOT Hotspot Makers** will no longer be required to cover the initial $10 DC assertion fee, which may allow Hotspot makers to sell Hotspots for a cheaper price.
- **New IOT Hotspot Owners** who have a new Hotspot in which the maker wallet does not contain appropriate funds to cover the initial assertion will now be able to complete that initial assertion for free.
- **IOT Hotspot Owners** will be able to assert their location for free once per year.

## Detailed Explanation
By allowing one (1) free location assertion per year for Hotspots, and one (1) free per epoch for data-only Hotspots, Hotspot owners are more likely to relocate and assert their Hotspots correctly, leading to improved network coverage in various locations. 

## Technical Implementation

The workflow for initial and reassertions for Hotspots will be as followed:

1. User initiates location assertion within the Helium Wallet App
2. The Helium Wallet App will review on-chain data for that Hotspot to determine when the last location assertion was
3. If the last free (0 DC) location assertion was > 365 epochs or never occurred, cost for reassertion is 0 DC
4. If the last free (0 DC) location assertion was < 365 epochs, cost for reassertion is $10 worth of DC.

The workflow for initial and reassertions for data only Hotspots will be as followed:

1. User initiates initial or reassert location within the Helium Wallet App
2. The Helium Wallet App will review on-chain data for that Hotspot to determine when the last location assertion was
3. If the last free (0 DC) location assertion was > 1 epochs or never occurred, cost for reassertion is 0 DC
4. If the last free (0 DC) location assertion was < 1 epochs, cost for reassertion is $5 worth of DC.


## Drawbacks

The primary drawback of this proposal is a lower overall DC burn for the network. However, the potential benefits gained from increased Hotspot relocation and improved network coverage can offset this drawback.

## Rationale

Certain market conditions may discourage deployers from reasserting their Hotspot to the correct location due to costs, or discourage them from even setting up future deployments due to the associated fees. This HIP proposes to fix that.


## Success Metrics
This HIP will be considered successful if more IOT Hotspots assert their correct location on the network.

