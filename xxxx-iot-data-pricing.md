# HIP XXXX: IOT Data Pricing

- Author(s): [@rawrmaan](https://github.com/rawrmaan)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR: 
- Tracking Issue: 
- Voting Requirements: veIOT holders

## Summary

This HIP proposes to change the per packet cost of transferring messages on the Helium IOT Network from **1 Data Credit (DC) per 24-byte packet** to **50 Data Credits per 24-byte packet** to increase the network's long-term financial sustainability.

## Motivation

The primary motivation is to realize and capture the true value of packet transfer delivered by the IOT subNetwork.

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network.

## Detailed Explanation

The cost of packet transfer on the Helium IOT Network is far too inexpensive. Some customers have even publicly commented that the cost is too low. Due to the low cost of data transfer, a Hotspot must transfer a huge number of packets to earn meaningful revenue. If an individual hotspot can't earn sustainable revenue, it's probable that the network as a whole cannot sustain itself.

Currently, transferring a 24-byte packet on the Helium IOT Network costs a customer 1 DC. This HIP proposes to change that cost to 50 DC per 24 bytes sent on the network. This change would result in a 50x increase in revenue for hotspots per unit of data transferred. This HIP does not change the mechanism of how Hotspots are paid for data transfer or the price of Data Credits, which will remain at $0.00001 per DC. 

## Implementation

The oracle configuration variable that determines DC cost per packet will be modified from `1` to `50`.

We leave this implementation up to the Helium Core Developers.

## Alternatives

- Per-device pricing is a common approach in the LoRaWAN industry, but it's not feasible for Helium due to its multi-LNS architecture.

- Regional pricing could be explored as a future option, as different regions may have varying price sensitivities.

## Drawbacks

- A significant price increase may deter customers from using the network, potentially reducing packet transfer volume.
  
- Increased Data Credit usage could lead to a reduction in available tokens for Proof of Coverage rewards.

## Unresolved Questions

The main unresolved question is how Helium IOT customers will respond to the price change. This HIP is being submitted in hopes of gaining that feedback.

## Deployment Impact

- LNS operators will need to understand this change and possibly communicate it to their customers, depending on how their customer relationships work
  
- When the variable is changed, data consumers will immediately begin paying the new rate

## Success Metrics

There are two success metrics. First that the price is changed and, second, that the demand remains inelastic (users don't leave the network). Only the first is required for the HIP to be considered successful.
