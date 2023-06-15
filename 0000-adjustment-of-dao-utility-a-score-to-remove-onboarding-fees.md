# HIP XX: Adjustment of DAO Utility A Score to Remove Onboarding Fees
- Authors: [Gateholder](https://github.com/gateholder) & [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 6/15/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veHNT

## Summary
This proposal suggests removing the DNP Device Activation Fee (AKA onboarding fee) from the DAO Utility Score. 

## Motivation
Currently, the A Score factors includes Active Device Count multiplied by the current onboarding fee for each device for that network. As written, this currently discourages networks from lowering their device onboarding fee to make it more affordable to add and onboard devices to the network, since lowering their onboarding fee will ultimately lower that SubDAO's A score. As currently written, lowering onboarding fees would result in lower daily HNT emissions to that SubDAOs Treasury. This also creates a higher barrier of entry for each network, which may discourage the purchase of new equipment. As being a network of networks, the Helium Community should encourage the expansion of its sub networks, and make it more affordable for others to join. 

## Detailed Explanation
As implemented in HIP51, a DAO Utility Score is used to determine the daily emissions of HNT to each SubDAO treasury. The current equation for this calculation is noted below:

Current:

$\text{DAO Utility Score} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$


This HIP proposes adjusting only the A score to remove the DNP Active Device Count from the A score, to have the equation equal the following:

Proposed:

$\text{DAO Utility Score} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count}})$

## Stakeholders
The proposed changes to the A score calculation in the DAO score will impact various stakeholders within the Helium ecosystem. These stakeholders include:

SubDAO Treasuries: SubDAO Treasuries may experience a potential change in the distribution of HNT emissions. The removal of the onboarding fee from the A score calculation may encourage more device owners to participate in subDAO networks.

HNT Owners: The removal of onboarding fees from the A Score may result in networks removing onboarding fees from their network, which will result in less HNT burn.

## Drawbacks:

While the proposed changes to the A score calculation aim to improve the distribution of HNT emissions in the Helium ecosystem, there are potential drawbacks to consider:

Impact on Existing SubDAOs: Existing subDAOs that have been operating with the current A score calculation may be negatively affected by the proposed changes. The redistribution of HNT emissions could lead to disagreements or dissatisfaction among some stakeholders, particularly if they perceive the changes as unfavorable to their interests.


## Alternatives
Maintaining the Current Calculation: One alternative would be to keep the current A score calculation, with the onboarding fee included. However, doing so might lead to unnecessary complexity, as managing the onboarding fee using on-chain mechanisms like NFTs and storing the associated data would require additional resources and potentially increase costs. 

Adjusting the A Score Calculation Differently: Another option is to explore different adjustments to the A score calculation that might achieve similar goals while addressing the potential drawbacks of this proposal. This could include introducing new parameters or modifying the existing calculation in other ways.

## Deployment Impact
The Helium Foundation will need to adjust the A Score Calculation of the DAO Utility Score to remove onboarding fees. 

## Success Metrics
The success metric will be the HNT daily emissions being correctly recalculated to exclude onboarding fees from the A Score.
