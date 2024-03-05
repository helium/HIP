# HIP 112: Scaling IOT Hotspot Assert Fees

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2024-03-05
- Category: Economic, Technical
- Original HIP PR: [#912](https://github.com/helium/HIP/pull/912)
- Tracking Issue: [#931](https://github.com/helium/HIP/issues/931)
- Vote Requirements: veIOT Holders

---

## Summary

This HIP proposes allowing one (1) free IOT assertion per rolling 365 epoch period, including the initial assertion. Any additional assertions conducted within the 365 epoch rolling period will be required to pay a $10 fee in IOT burn.

## Motivation

Currently, assertion fees for the IOT subnetwork are paid in Data Credit (DC) burn, which is created by burning HNT. Due to net emissions, the burning of HNT and DC may at times benefit the MOBILE subDAO greater than the IOT subDAO. This is due to the fact that the DAO utility score created in  [HIP 53](https://github.com/helium/HIP/blob/main/0051-helium-dao.md) does not provide greater emissions for more DC burn outside of onboards. 

Further, this HIP will make it cheaper for hotspot deployers to ensure their asserted location is accurate by allowing one (1) free location assert per 365 epochs. 


## Stakeholders

- **IOT Hotspot Makers** will no longer be required to cover the initial $10 DC assertion fee, which may allow hotspot makers to sell hotspots for a cheaper price.
- **IOT Hotspot Owners** who have a new hotspot in which the maker wallet does not contain appropriate funds to cover the initial assertion will now be able to complete that initial assertion for free.
- **IOT Token Holders** will benefit through an increase in demand and decrease in total supply of IOT.
- **HNT Holders** will experience a decrease in demand for HNT to DC burn, as DC burn will no longer be required to assert hotspots.

## Detailed Explanation
By allowing one (1) free location assertion per year, hotspot owners are more likely to relocate their hotspots, leading to improved network coverage in various locations. Further, by making subsequent assertions requiring a $10 IOT burn instead of DC burn will help increase demand for the IOT token.

## Technical Implementation


The workflow for location re-assertions will be as followed:

1. User initiates location assertion within the Helium Wallet App
2. The Helium Wallet App will review on-chain data for that hotspot to determine when the last location assertion was
3. If the last free (0 IOT)  location assertion was > 365 epochs or never occurred, cost for re-assertion is 0 IOT
4. If the last free (0 IOT) location assertion was < 365 epochs, cost for re-assertion is $10 worth of IOT at current Oracle Price.


The workflow for initial location assertions will be as followed:

1. User is prompted to select an initial location for their hotspot
2. Helium Wallet App will review on-chain data for that hotspot to determine if the hotspot has ever been asserted. If no, the initial assertion fee is 0 IOT.

## Drawbacks

The primary drawback of this proposal is a lower overall DC burn for the network. However, the potential benefits gained from increased hotspot relocation, improved network coverage and potential IOT burn can offset this drawback.

## Rationale

Certain market conditions may discourage deployers from re-asserting their hotspot to the correct location due to costs, or discourage them from even setting up future deployments due to the associated fees. This  HIP proposes to fix that.

## Unresolved Questions

- Do maker apps still allow for location asserts? If yes, does it matter since location asserts can be done in the helium wallet app?


## Success Metrics
This HIP will be considered successful if more IOT hotspots become active on the network.

