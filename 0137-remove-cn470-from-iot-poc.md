# HIP 137: Remove CN470 from IOT PoC

- Author: [@BFGNeil](https://github.com/BFGNeil)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR: [#1110](https://github.com/helium/HIP/pull/1110)
- Tracking Issue: [#1112](https://github.com/helium/HIP/issues/1112)
- Voting Requirements: veIOT Holders

---

## Summary

This proposal removes the CN470 region from earning Proof-of-Coverage rewards on the IOT network until such a time when classifiers and other methods of anti-gaming can identify and stop gaming in this region.

## Motivation

Whilst the gaming is easy to detect by eye, it's hard to detect it programmatically without finding caveats. ITM (Irregular Terrain Model) models do work with regions where legitimate coverage exists to weed out the gamers, but it's clear the CN470 region has gotten to a point where next to none exists on the Helium network. Additionally ITM models can be bypassed by setting increased heights on Hotspots and would need further development and time to implement.

[A recently produced report](files/0137/cn470-gaming.pdf) shows that 9,738,419 IOT rewards in one epoch were going to the CN470 region whilst gaming detection methods can show over 86.9% of this is gaming, with the remaining hotspots being hard to confirm if they are gaming or not. This 9.7M IOT is 13.6% of the PoC and Data Transfer rewards available each Epoch

Currently the CN470 region accounts for 1,563DC ($0.01563) per Epoch of data transfer. This figure is minute in proportion to the number of Hotspots deployed in China, compared to other countries of large Hotspot deployments

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network. 
- Gaming Hotspot owners and "Honest" Hotspot owners located in China are specifically negatively affected with 0 PoC earnings.
- Hotspot owners in other regions are specifically positively affected with an average 15% boost in PoC earnings.
- Hotspot manufacturers that are producing hotspots for the CN470 region.

## Detailed Explanation

We propose to remove the CN470 region from PoC reward calculations.

We then propose a new denylist focused on any Hotspots that have ever asserted to the CN470 region, now or in the past.  This includes Hotspots that were asserted in CN470 and have reasserted in other regions.

This proposal does not remove Data Transfer capability or rewards for CN470 Hotspots.

## Implementation

- Remove the CN470 region from PoC calculations by adding a check to the IOT PoC verifier to check if the witness is in the CN470 region and marking it invalid.
- Produce a new permanent denylist classifier for all hotspots that have ever been located in the CN470 region.
  This classifier will be run weekly to identify new Hotspots asserting or reasserting in the CN470 region.
  The denial of this Hotspot cannot be removed by reassertion or changing the height or antenna properties.
- Nova Labs/Helium Foundation will deploy this HIP in their appropriate capacities.

An implementation date is to be confirmed, but there is no requirement to delay implementation when ready to deploy.

## Alternatives

- None at this time.
- This HIP can be reversed by another HIP if a new gaming identification classifier is identified as implementable that will be effective.

## Drawbacks

- Negative Impact on "Honest" Hotspot owners in China who will no longer receive PoC rewards.
- A very small number of Hotspots previously deployed in CN470 and now in other regions that are not members of Gaming clusters could be affected.
- A proportion of the increased rewards to non-CN470 region Hotspots will be received by gamers in other regions who are less easy to identify and block.
- This HIP will not affect gamers operating Hotspots in those areas of China or Taiwan on the AS923 region frequencies.

## Unresolved Questions

-- Are there any genuine sensor deployments that may receive reduced coverage if genuine Hotspots turn off due to no PoC rewards. 

## Deployment Impact

We expect less gaming on the IOT network as a whole with this change and more PoC rewards going to other regions.

Hotspot Makers should halt sales of light and full CN470 Hotspots in favour of Data-Only Hotspots to service the CN470 region.

## Success Metrics

Gaming on the IOT network will reduce.
The average PoC rewards for all Hotspots in other regions will increase by 15%
