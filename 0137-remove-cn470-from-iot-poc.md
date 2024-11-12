# HIP 137: Remove CN470 from IOT PoC

- Author: [@BFGNeil](https://github.com/BFGNeil)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR: [#1110](https://github.com/helium/HIP/pull/1110)
- Tracking Issue: [#1112](https://github.com/helium/HIP/issues/1112)
- Voting Requirements: veIOT Holders

---

## Summary

This proposal removes the CN470 region from earning Proof-of-Coverage rewards on the IOT network until such a time when classifiers and other methods of anti-gaming can identify and stop the majority of gaming in this region.

## Motivation

Whilst gaming is often easy to detect by eye, it's hard to detect it programmatically without finding caveats. The closest we have is the newer ITM model, but this can be bypassed by setting height on Hotspots and would need further development and time to implement.

Currently around 12% of PoC rewards are going to Hotspots in the CN470 region. These Hotspots represent under 1,000 of DC usage.

A snapshot of active hotspots can be visually seen to be gaming, and the amount of data transfer in the next shot can be seen below

images here

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network. Hotspot manufacturers producing CN470 hotspots.

## Detailed Explanation

We propose to remove the CN470 region from PoC reward calculations. We then propose a new denylist focused on any Hotspots moving from this region to others be added. We also propose these changes be removed when anti gaming techniques have been developed to address these issues.

This proposal does not remove Data Transfer capability for CN470 Hotspots.

## Implementation

- Add a check to the poc oracle under the do_witness_verifications function to check if region is cn470, if so mark it invalid reason: denied region
- A grant will be opened to take a snapshot of hotspots asserted in CN470 before 12/11/2024.
- A grant will be opened to produce a script that will check for assertions outside of the country for these selected hotspots and a new denylist produced weekly with any hotspots that have asserted outside of the country.
  
## Alternatives

- Just create a denylist of all hotspots in the cn470 region.

## Drawbacks

- None

## Unresolved Questions

-- none so far

## Deployment Impact

We expect less gaming on the IOT network as a whole with this change and more PoC rewards going to other regions.

## Success Metrics

Gaming on the IOT network will reduce.
