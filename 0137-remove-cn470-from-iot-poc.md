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

Whilst the gaming is easy to detect by eye, it's hard to detect it programmatically without finding caveats. ITM models do work with regions where legitimate coverage exists to weed out the gamers, but it's clear the CN470 region has gotten to a point where next to none exists on the Helium network.

[A recently produced report](files/0137/cn470-gaming.pdf) shows that 9,700,000 IOT rewards per epoch are going to the cn470 region whilst gaming detection methods can show over 86.9% of this is gaming, with the remaining hotspots being hard to confirm if they are gaming or not.

Currently the CN470 region accounts for 1,563DC ($0.01563) per Epoch of data transfer.

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network. Gateway manufacturers producing hotspots for the CN470 region.

## Detailed Explanation

We propose to remove the CN470 region from PoC reward calculations.

We then propose a new denylist focused on any Hotspots that have been asserted to the CN470 region.

This proposal does not remove Data Transfer capability for CN470 Hotspots.

## Implementation

- Remove the CN470 region from PoC calculations by adding a check to the IOT PoC verifier to check if the witness is in the CN470 region and marking it invalid
- Produce a new denylist for all hotspots that have ever been located in the cn470 region.

## Alternatives

- None at this time.

## Drawbacks

- None

## Unresolved Questions

-- none so far

## Deployment Impact

We expect less gaming on the IOT network as a whole with this change and more PoC rewards going to other regions.

## Success Metrics

Gaming on the IOT network will reduce.
