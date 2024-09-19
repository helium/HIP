# HIP XXXX: IOT Data Pricing

- Author(s): [@bfgneil](https://github.com/bfgneil)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR:
- Tracking Issue:
- Voting Requirements: veIOT holders

## Summary

This HIP proposes to change the per packet cost of transferring messages on the Helium IOT Network from **1 Data Credit (DC) per 24-byte packet** to **10 Data Credits per 24-byte packet** to increase the network's short-term financial sustainability.

We recognise a longer term variable price needs to be saught for long-term finacial stability, as any change to DC pricing does not offer and long term solutions.

## Motivation

The primary motivation is to better align sensor usage with costs of operating the network, driving better revenue by increasing the cost of an uplink on the network, driving better returns for hotspot hosts.

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network.

## Detailed Explanation

The cost of packet transfer on the Helium IOT Network is currently $0.00001 per uplink.

We can look at some more advanced usecases that are seeing growth on the helium network from many sources, the RAK2270 sensor.

That sensor uses max copies of 6 for working out its location based on the signal strength of hotspots and uplinks every hour with a battery that lasts around a year.

If we do the maths on usage, with the current cost of $0.00001 this works out to:

0.00001 _ 24 uplinks a day _ 6 copies \* 365 days = $0.5256 per year

As a user of this sticker, I understand this rate is not going to sustain the IOT network.

If we run some models of increasing the price 10x, 20x 50x and 100x we will see:

100x - 0.001 _ 24 uplinks a day _ 6 copies _ 365 days = $52.56 per year
50x - 0.00005 _ 24 uplinks a day _ 6 copies _ 365 days = $26.28 per year
20x - 0.00002 _ 24 uplinks a day _ 6 copies _ 365 days = $10.51 per year
10x - 0.00001 _ 24 uplinks a day _ 6 copies _ 365 days = $5.26 per year

It is our belief this usecase is invalidated based on costs of anything more than 10x. It's not just this one usecase that is growing, we can look to other usecases , for example the SenseCAP T1000 where uplink rates are often as fast as 2-5 minutes, the cost is simply unsustainable above a 10x increase without offering volume discounts.

As a comparison it costs around $10 per year to run a lte sensor with 500mb of data. this means the increase of 10x is in line with costs of other network choices.

This HIP does not change the mechanism of how Hotspots are paid for data transfer or the price of Data Credits, which will remain at $0.00001 per DC.

## Implementation

The oracle configuration variable that determines DC cost per packet will be modified from `1` to `10`.

We leave this implementation up to the Helium Core Developers.

## Alternatives

- Per-device pricing is a common approach in the LoRaWAN industry, it should be looked at with a working group to see how this is possible for long term growth.

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
Footer
