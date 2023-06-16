# HIP 88: Adjustment of DAO Utility A Score
- Authors: [Gateholder](https://github.com/gateholder) & [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 6/15/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veHNT

## Summary
This proposal suggests removing the DNP Device Activation Fee (AKA onboarding fee) from the DAO Utility A Score. 

## Motivation
Currently, the A factor in the DAO Utility Score equates to Active Device Count multiplied by the current onboarding fee for each device on that network to the fourth root. As currently written, this discourages SubDAO networks from lowering their device onboarding fee, as doing so would lower their A Score. As a result of a decreased A Score, the daily HNT emissions within that SubDAO would decrease. 

Further, High onboarding fees make it less affordable for deployers to onboard new devices to that SubDAO network, which creates a higher  barrier of entry. As being a network of networks, the Helium Community should encourage the expansion of its SubDAO networks, and make it more affordable for others to join. 

## Detailed Explanation
As implemented in HIP 51, a DAO Utility Score is used to determine the daily emissions of HNT to each SubDAO treasury. The current equation for this calculation is noted below:

Current:

$\text{DAO Utility Score} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$


This HIP proposes adjusting only the A Score to remove the DNP Active Device Count from the score, to have the equation equal the following:

Proposed:

$\text{DAO Utility Score} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count}})$


Note, this HIP does not propose any changes to any current onboarding fees. Any changes to current onboarding fees are set by each SubDAO.

## Stakeholders
The proposed changes to the A Score calculation in the DAO Utility Score will impact various stakeholders within the Helium ecosystem. These stakeholders include:

Hotspot Makers: Some Hotspot Makers hold a large quantity of DC within their maker wallet. If this HIP should pass, and a new HIP to lower IoT onboarding fees is proposed by the IoT SubDAO, this may leave makers with a large sum of DC within their maker wallets. However, this HIP does not directly impact Hotspot Makers, as another HIP would need to be implemented to reduce IoT onboard fees. 

SubDAO Treasuries: SubDAO Treasuries will experience a change in the distribution of daily HNT emissions. The removal of the onboarding fee from the A Score calculation may encourage more device owners to participate in subDAO networks.

HNT Owners: The removal of onboarding fees from the A Score may result in SubDAO networks lowering their onboarding fees, which would result in less HNT burn and a decrease in demand for HNT. However, HNT burned for onboarding fees are not an organic indicator of the overall usage of the network.

## Drawbacks:

While the proposed changes to the A Score calculation aim to improve the distribution of HNT emissions in the Helium ecosystem, there are potential drawbacks to consider:

Impact on Existing SubDAOs: Existing subDAOs that have been operating with the current A Score calculation may be negatively affected by the proposed changes. The redistribution of HNT emissions could lead to disagreements or dissatisfaction among some stakeholders, particularly if they perceive the changes as unfavorable to their interests.

## Alternatives
Maintaining the Current Calculation: One alternative would be to keep the current A Score calculation, with the onboarding fee included. However, doing so might lead to unnecessary complexity, as this would force other SubDAOs to implement onboarding fees to increase their HNT emissions. This would require the buildout of additional backend infastructure to be built by Nova or the Helium Foundation, which is estimated to take around 3 months

Adjusting the A Score Calculation Differently: Another option is to explore different adjustments to the A Score calculation that might achieve similar goals while addressing the potential drawbacks of this proposal. This could include introducing new parameters to calculate the total amount of HNT burned for onboarding for each SubDAO network, vs only using the current fee. However, since the IoT network had a significant head start, and almost 1 million hotspots onboarded to the network, this metric would heavily favor the IoT network and disproportionately increase their HNT emissions. 

## Deployment Impact
This HIP requests that the Helium Foundation adjust the code for the A Score calculation within the DAO Utility Score to remove onboarding fees. 

## Success Metrics
The success metric will be the HNT daily emissions being correctly recalculated to exclude onboarding fees from the A Score.
