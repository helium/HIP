# HIP 140: Adjust Service Provider Boost Qualifiers

- Author: [@madninja](https://github.com/madninja)
- Start Date: 2025-01-03
- Category: Technical, Economic
- Original HIP PR: [#1141](https://github.com/helium/HIP/pull/1141)
- Tracking Issue: [#1142](https://github.com/helium/HIP/issues/1142)
- Vote Requirements: veMOBILE Holders

## Summary

This HIP proposes adjusting the Service Provider boost eligibility qualifiers in a boosted hex to be based solely on the ongoing unique connections specified in HIP-134. This change would eliminate the ability for a Hotspot in a boosted hex to qualify for boosted rewards based on Call Detail Records (CDR) in HIP-133 or by passing data (HIP-84). A Hotspot would earn normal (non-boosted) PoC rewards in a boosted hex using HIP-133 rules and would only receive Service Provider boost rewards when it has sufficient ongoing unique offload connections.

## Related Prior HIPs

- [HIP-134](./0134-reward-mobile-carrier-offload-hotspots.md): Rewarded MOBILE Carrier Offload Hotspots
- [HIP-133](./0133-bridging-gap-for-anti-gaming-measures-phase2.md): Extended CDR requirements for anti-gaming
- [HIP-84](./0084-service-provider-hex-boosting.md): Created hex boosting rewards## Summary

## Motivation

When a Hotspot is placed in a Service Provider boosted hex, it is expected to achieve significant offload. Currently, there are hundreds of Hotspots in boosted hexes that earn boosted PoC while selected for offload, yet they have little or no actual offload. These Hotspots are essentially farming boosted PoC by manipulating their location and meeting one-time CDR requirements as outlined in HIP-133.

## Stakeholders

 * Wi-Fi Hotspot Deployers: Will receive higher rewards due to reduced gaming of boosted rewards.
 * Service Providers and the Network Overall: Will gain value from remaining boosted hexes by only paying for PoC when a Hotspot is actually offloading data.


## Detailed Explanation

Hotspots that assert in a boosted hex:

* Qualify for non-boosted PoC rewards if they meet HIP-133 CDR/disco mapping rules.
* Qualify for boosted rewards with 25+ unique offload connections over an ongoing 7-day window as specified in HIP134. The Hotspot receives boosted rewards for the boosted hex, with this being an ongoing requirement rather than a one-time threshold.

The activation of a boosted hex as defined in HIP-84 will be adjusted to occur only when the asserted hotspot covering that hex qualifies for boosted rewards per the unique connection rule above.

Since the implementation timeline of this HIP may overlap the HIP-139 CBRS phase-out, CBRS radios will not qualify for boosted rewards. 

The HIP-84 requirement of 3 unique devices is deprecated and no longer applicable once this HIP is approved and activated.

Upon approval and implementation, this HIP will activate in the US, followed by Mexico as carrier offload is activated there. The existing 3 device Service Provider boost qualification remains in place in Mexico but will be deprecated and replaced by this HIP when carrier offload is activated in Mexico.



## Drawbacks

If a Hotspot in a boosted hex is never selected for carrier offload, it is unlikely to see enough unique connections to qualify for boosted rewards. While this can be seen as a drawback, it aligns with the network's and offload carrier's expectations that the Hotspot will be selected and transmit significant traffic in a boosted hex.

## Rationale and Alternatives

When a hex is boosted, it is expected to experience significant subscriber traffic. The Service Provider boosts to encourage and reward Hotspots for providing offload in that area. Limiting boost rewards to only those Hotspots that provide offload reinforces that expectation.

## Unresolved Questions

None

## Deployment Impact

Nova is committed to implementing this HIP.


## Success Metrics

Hotspots in Service Provider boosted hexes will earn (boosted) PoC rewards when actually providing useful offload service for carriers. This means the number of Hotspots in boosted hexes that are selected for carrier offload but with no actual data offload will drop to zero. 

Conversely, the percentage of Hotspots providing coverage to hexes that have been boosted by a Service Provider while also providing useful offload service for carriers will approach 100%.
