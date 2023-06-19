# HIP XX: Change IoT Hotspot Reassertion Fee
- Authors: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 6/19/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veIoT

## Summary: 
This HIP suggests changing the IoT location assertion fee from $10 in Data Creditis (DC) to $5 in IoT. 

## Motivation:
Currently, any IoT hotspot location re-assertion fees are paid in DC, by burning Helium (HNT). Since hotspot location re-assertion fees do not represent any variables within the DAO Utility Score which determines the daily HNT emissions to that SubDAO, the burning of HNT to pay hotspot location re-assertion fees currently does not benefit the IoT subDAO or IoT token holders. 

This HIP will also make it cheaper for hotspot owners to reassert their hotspot location, which may encourage hotspot owners to assert their hotspots in the correct location. 

## Stakeholders:

IoT Hotspot Owners - This HIP will make it less expensive to re-assert a hotspots location for IoT Hotspot Owners. 

IoT Token Holders - This HIP will benefit IoT token holders as it will decrease the supply of IoT as IoT is burned to pay for re-assertion fees. 

## Detailed Explanation:
As implemented in HIP 51, a DAO Utility Score is used to determine the daily emissions of HNT to each SubDAO treasury. The equation for this calculation is noted below:

$\text{DAO Utility Score} = V \times D \times A$

Where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$


This current calculation does not take into effect any fees that are paid by the subDAO for re-asserting a hotspot's location. Thus, the IoT subDAO does not directly benefit from paying this fee in HNT/DC. This HIP proposes changing the current method of paying for hotspot relocation fees to be paid in IoT, and lower the fee to $5, from $10.

Since it’s currently impossible to swap HNT to IoT from the subDAO treasury, this may make it more difficult for hotspot owners to obtain $5 worth of IoT to pay the relocation fee. Therefore, this HIP also proposes giving every onboarded hotspot one (1) free relocation coupon that never expires. 

## Alternatives:
One alternative is to keep DC as the source used to pay for these fees; however, this does not benefit the IoT subDAO or token holders.

Another alternative is to keep the overall fee price the same ($10), but change the source of payment to IoT. However, keeping a lower reassertion fee may encourage hotspot owners to assert their hotspot in the correct location. 

## Drawbacks
Currently, the treasury swap function within the Helium wallet only allows the swapping of IoT to HNT, and not the other way around. Thus, if any hotspot owners needed $5 in IoT, it would need to be bought on the secondary market. However, this is addressed within this HIP by giving each hotspot owner one free reassertion coupon. 


## Deployment Impact:
This HIP requires the Helium Foundation or Nova Labs to create a way that would allow the burning of IoT to pay hotspot location reassertion fees. 

## Success Metrics:
The primary success metric will be all hotspot reassertion fees being paid in IoT, which will lower the overall supply of IoT as each reassertion occurs. 
