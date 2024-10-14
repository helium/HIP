# HIP XXXX: Remove CN470 from PoC

- Author(s): [@bfgneil](https://github.com/bfgneil)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR:
- Tracking Issue:
- Voting Requirements: veIOT holders

## Summary

This HIP proposes to remove the CN470 region from earning poc until a time when classifiers and other methods of anti gaming can identify and stop gaming.

## Motivation

Currently around 14% of PoC rewards are going to hotspots in the cn470 region.

Whilst the gaming is easy to detect by eye, its hard to detect it programatically without finding caveats.

The closest we have is the newer ITM model, this can be bypassed by setting height on hotspots and would need further development and time to implement.

These hotspots represent under 1,000 of DC usage.

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network.

## Detailed Explanation

We propose to remove the CN470 region from PoC reward calculations.

We then propose a new denylist focused on any hotspots moving from this region to others be added.

We also propose these changes be removed when anti gaming techniques have been developed to adress these issues.

## Implementation

- Remove the cn470 region from PoC calculations
- Track any hotspots in the cn470 region for location assertions out of region and produce a list to be added to the denylist

## Alternatives

- Let gaming happen forever

## Drawbacks

- None

## Unresolved Questions

-- none so far

## Deployment Impact

- less gaming.

## Success Metrics

Gaming on the IOT network will reduce.
