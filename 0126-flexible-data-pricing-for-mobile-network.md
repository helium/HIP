# HIP 126: Flexible Data Pricing for MOBILE Network

- Author [zer0tweets](https://github.com/zer0tweets)
- Contributors [KeithR](https://github.com/KeithR), [zer0tweets](https://github.com/KeithR)
- Start Date: 2024-05-20
- Category: Economic, Technical
- Original HIP PR: [#1018](https://github.com/helium/HIP/pull/1018)
- Tracking Issue: [#1023](https://github.com/helium/HIP/issues/1023)
- Vote Requirements: veMOBILE Holders

---

## Summary

This document outlines a new flexible data pricing model for the Helium Mobile Network and introduces the concept of a utility score as a relative indicator of a MOBILE hotspot's usefulness on the network.

## Related Previous HIPs

* [HIP 27](https://github.com/helium/HIP/blob/main/0027-cbrs-5g-support.md) established the price of cellular data on the network at $0.5 per gigabyte.

## Motivation

Data pricing on the network is currently fixed at $0.5 per gigabyte across all locations, as initially set by HIP 27. With growing interest from Mobile Network Operators (MNOs) in using the Helium network for data offloading, there's a need to adapt. Service providers vary in their payment approaches based on hotspot location and data demand, with possible rates ranging from free to $1/Gb. The network's pricing strategy should reflect these market dynamics to optimize service provider connectivity.

## Stakeholders

Hotspot operators will be able to adjust pricing and set unrewarded data limits, affecting their data rewards. Service providers will specify the price they are willing to pay for data and the locations. Hotspot vendors will need to update the control settings UX of the hotspots they manufacture to allow operators to specify flexible pricing settings flexibly.

## Detailed Explanation

### Hotspot Price Settings

Hotspots can set their data pricing from free to $1 per gigabyte. The interface may use a slide control or any other implementation, chosen by a hotspot vendor.  

Hotspot vendors may also implement functionality to suggest optimal pricing for each hotspot based on its asserted location. Individual hotspot price settings are hashed and published on-chain and are not known to anyone other than the hotspot owner.

### Service Provider Price Offers

Service providers can specify the price they are willing to pay in a given res12 hex. They can blacklist hexes, set the price to zero, or any price above zero. Hexes that are blacklisted mean that service provider subscribers will not connect to MOBILE hotspots in these hexes, regardless of the price. If a hotspot's set price exceeds the bid price of a service provider in that location, the hotspot's virtual SSID for PassPoint connections will be disabled, preventing any subscriber of that service provider from connecting to or even detecting the hotspot.

### Utility Score

To create downward pressure on data price settings among hotspot operators, it is suggested that hotspots engage in a competitive process to attract the maximum number of unique connections from service providers. Initially, this competition will be theoretical, where hotspots are ranked in a publicly accessible "hotspot utility" directory based on their performance. The utility ranking is calculated based on the percentage of unique connections and the volume of data a hotspot serves over the past seven epochs compared to others within a certain radius. The formula for this ranking is: score = (a * unique connections) + (b * data), where 'a' and 'b' are predefined weights that indicate the importance of the number of connections versus the volume of data served. Eventually, we may consider a Helium Improvement Proposal (HIP), where this utility score can be used to adjust the Proof of Coverage (POC) rewards calculation. The adjustment will be linear; for example, in a group of 10 hotspots, the second-ranked may receive a 0.9x multiplier on their POC rewards, the third 0.8x, and so on, down to the lowest ranked, which might not receive any POC rewards.

## Drawbacks

This HIP introduces new complexity to the rewards calculation and may also introduce new gaming vectors, whereby hotspot operators can manipulate data pricing and use fake accounts to earn rewards using fake data and/or unfairly manipulate their utility score.

## Rationale and Alternatives

An alternative could be to prevent hotspots from controlling price setting altogether. Either a hotspot gets paid by the service provider at the price the service provider has set for a given res12 hex, or it doesn't. This would significantly simplify the system but would remove all control from the hotspot operator and somewhat eliminate an incentive for service providers to consider setting the price to anything higher than zero.

## Unresolved Question

There are currently no service providers that use the CBRS network, which would mean that CBRS radios are effectively precluded from having a non-zero utility score. However, since, at this point, the utility score won’t impact rewards and CBRS is already treated as experimental per HIP 113, this won’t materially affect CBRS hotspot operators. Helium Mobile plans to release CBRS sims in Q2 2024, ahead of any HIPs that may propose using the utility score to influence rewards.

It is unclear how, given the proposed flexible pricing scheme, hotspot operators can prevent service providers from discovering the price settings of a hotspot in a given location by simply bidding lower and lower and gauging whether offload connections occur. Some MOBILE burn mechanism could be introduced to preclude bottom price discovery by service providers. E.g., every time a service provider wants to revise the price down in a given hex from what it originally bid, it needs to burn some amount of MOBILE that may be a function of how much lower the new price setting is.

## Deployment Impact

Nova Labs will collaborate with the Helium Foundation to complete the implementation, should this HIP pass voting. Specific deployment impact details and timeframe will be filled out by engineering prior to the HIP going to vote.

## Success Metrics

The total aggregate amount of data (both paid and unpaid) increased at least 10x no later than 6 months after HIP deployment and the total amount of paid data at least doubled.
