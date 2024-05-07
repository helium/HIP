# Redefining Data-Only IoT Hotspot Onboarding and Assertion Fees

- **Author(s):** Members of the IoT Working Group
- **Start Date:** 2024-05-07
- **Category:** Economic, Technical
- **Original HIP PR:** _[to be added]_
- **Tracking Issue:** _[to be added]_
- **Vote Requirements:** veIOT Holders


## Summary

This proposal aims to reduce the cost of onboarding data-only hotspots to the Helium network and to provide one free location assertion every 30 epochs. This initiative is designed to lower the barriers to entry for deploying low-cost IoT solutions using off-the-shelf LoRaWAN gateways and enhance the network's coverage and data accuracy through more frequent location updates.


## Motivation

- **Why are we doing this?**
  - To make onboarding for data-only hotspots more affordable and offer one free location assertion monthly to enhance network data quality and accessibility.
- **What use cases does it support?**
  - This facilitates easier and more economical IOT network coverage expansion, particularly benefiting asset tracking applications that rely on trilateration and precise network mapping.
- **What problems does it solve?**
  - It lowers the financial and technical hurdles for sensor deployers and network users, encouraging broader participation and engagement.
- **What is the expected outcome?**
  - Increased adoption of Helium's IOT network through lower initial costs and incentivized location assertions, leading to denser and more accurate network coverage.


## Stakeholders

- **Who is affected by this HIP?**
  - Existing and future operators of data-only hotspots will benefit from reduced costs and the ability to update their hotspots' locations without additional charges once per month.


## Detailed Explanation

- **Introduce and explain new concepts:**
  - Data-only hotspots will be eligible for a reduced onboarding fee of 500,000 DC ($5). After onboarding, these hotspots can assert their location for free once per month (30 epochs). Any additional assertions within the same period will cost 100,000 DC ($1).
- **How the proposal would be implemented:**
  - Users will use the Helium Wallet App, Maker App, or CLI Wallet to initiate location assertions. The system will check if a free assertion is available; if not, a fee will apply. The onboarding process remains unchanged but at a reduced cost. Solana fees will still apply for both onboarding and assertions.


## Drawbacks

- **Primary drawbacks:**
  - The main concern is the potential reduction in DC burn per onboarding or assertion. However, the increase in the number of hotspots and assertions might compensate for this reduction by enhancing network coverage and utility.

## Rationale and Alternatives

- **Why is this design the best?**
  - It significantly lowers the entry barrier, allowing existing LoRaWAN deployers and IoT enthusiasts easier access to the network, potentially increasing overall network engagement and data validity.
- **What other designs have been considered?**
  - Alternatives included varying fee structures and assertion frequencies, but the current proposal optimally balances cost reduction with network growth.
- **What is the impact of not doing this?**
  - Without implementing these changes, growth in network coverage and the integration of new technologies might stagnate, reducing the network's effectiveness and competitive edge.


## Unresolved Questions

- **Questions to resolve during the HIP process:**
  - Final determination of the exact onboarding and assertion fees and the duration of the free assertion period will be crucial.
  

## Deployment Impact

- **Impact on current users:**
  - Users will gain the ability to update hotspot locations monthly without a fee, encouraging more active and accurate participation in network data reporting.
- **Changes to documentation:**
  - The Helium documentation will need updates to reflect new fee structures and the benefits of the free monthly location assertion.
- **Backwards compatibility:**
  - This proposal is fully reversible and compatible with existing network practices.


## Success Metrics

- **Metrics for success:**
  - A successful outcome will be measured by an increase in the number of active data-only hotspots and the frequency of location assertions, reflecting greater network utilization and coverage.

In general the IoT Working Group believes that by adopting this proposal, Helium can enhance its IOT network's robustness and utility while fostering a more vibrant and inclusive community of developers and users.