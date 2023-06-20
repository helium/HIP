# HIP XX: Ability to Govern SubDAO Fees
- Authors: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 6/19/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veHNT

## Summary: 
This Helium Improvement Proposal (HIP) suggests giving power to each subDAO to dictate the type of payment (Decentralized Network Tokens, Data Credits, or a combination of both) used to pay for any fees within their subDAOs, including but not limited to onboarding fees and or location reassertion fees. Any services sold by each subDAO, such as data transfers, are not considered a fee, and as such, will need to continue to be paid in Data Credits (DC).

## Motivation:
Although HIP 51 created a Helium DAO which allowed the creation of Network subDAOs and their Decentralized Network Tokens (DNT), it specified that Helium (HNT) remain the unit of buy-and-burn in order to maintain the HNT flywheel. However, outside of onboarding fees represented in the DAO Utility Score, there is no economic benefit to each subDAO to pay for fees in DC, nor requirement that states a subDAO needs to charge fees. For example, at the time of writing this HIP, the MOBILE subDAO has no onboarding or reassertion fees. 

Fees charged for each subDAO are optional, and are dictated by that subDAO. Therefore, each subDAO should have the authority to choose the payment type (DNT, DC, or a combination of both) fees are paid in. 

## Stakeholders:

All subDAOs - If implemented, all subDAOs will have the authority to change the payment method of fees charged to their native DNT, keep it as DC, or some combination of both. 

HNT Holders - All HNT holders will be impacted by this HIP, as the HIP may decrease the demand for HNT, as less fees will be paid in DC. However, it is to be expected that onboarding fees for subDAOs continue to be paid in DC, as this directly impacts the subDAO's $A$ Score within the DAO Utility Score.

## Detailed Explanation:
The DAO Utility Score created in HIP 51 that determines the daily HNT emissions to each subDAO only takes into account onboarding fees burned as a factor, but does not include other fees, such as a Hotspot location reassertion. Thus, subDAOs do not directly benefit from paying other fees outside of onboarding fees in HNT/DC nor have a way or mechansim to burn their native DNT. 

Therefore, this HIP proposes granting each subDAO the authority to determine the payment type fees are paid in.

## Alternatives:
One alternative is to keep DC as the source used to pay for these fees; however, this mostly does not benefit the subDAO or their token holders.

## Drawbacks
Currently, the treasury swap function within the Helium wallet only allows the swapping of DNT to HNT, and not the other way around. Thus, if any hotspot needs DNT to pay for a fee, it would need to be bought on the secondary market.

## Deployment Impact:
This HIP would require the Helium Foundation to create a way that would allow the burning of DNT to pay for subDAO fees.

## Success Metrics:
The primary success metric will be each when subDAOs can change the payment method for any fees charged on their subDAO network. 
