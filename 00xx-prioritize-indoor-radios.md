# HIPxx: Prioritize Indoor Radios

- Author(s): KeithR#7325 <!-- your GitHub @username -->
- Start Date: 2023-04-04 <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: Mobile PoC Rewards <!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

Given the inherent limitations of indoor radios (fixed modeled coverage, building-level attenuation, and multi-story building installations), it is proposed that indoor radios are to be counted prior to counting outdoor radios in the rewards eligibility calculation process.

<!-- Read the content requests in all sections before starting to write any section. -->

## Stakeholders

Given that the rewards calculation process affects all Helium 5G radios, any and all participants in the Mobile subDAO are stakeholders covered by this HIP.  The coders responsible for modifying the reward calculation are, by default, also stakeholders.

## Detailed Explanation

The current reward model using obstruction data is counting coverage for outdoor radios first.  This creates a scenario where the fixed value of indoor radios is not being calculated correctly.  The hex where the indoor radio is located is being counted correctly but if an outdoor radio’s coverage overlaps with an indoor radios outer ring of hexes (six surround each hex), then the indoor radio’s outer ring is not counted.

No more than five radios per hex are rewarded by the Mobile subDAO’s Proof of Coverage (PoC) reward algorithm.  An indoor radio’s coverage rewards are fixed at 1000 points; that is, 400 points for the occupied hex and 100 points each for the surrounding ring of six hexes.  The potential coverage range of an indoor radio is significantly attenuated by the walls of the facility in which the radio is installed.  Multi-story buildings may require multiple indoor radios per floor and are likely to require multiple floors to be installed with indoor radios.  Given these inherent limitations, it is proposed that indoor radios are to be counted prior to counting outdoor radios in the rewards eligibility calculation process.

## Drawbacks

Adding such logic may be a contrary to the five best radio signals being rewarded under the current model.  The concept of prioritizing one radio type over another is contrary to the decentralized nature of the network.

## Rationale and Alternatives

The current algorithm under the model coverage reward system is unfair to indoor radios.  It has been seen that indoor radio coverage that shares the same hex as outdoor radio coverage are being ignored.  It is assumed this is because the indoor radios do not have expected signal parameters in the obstruction model, so therefore they are always subordinate to outdoor radios.

## Unresolved Questions

The belief is that there are no unresolved issues.

## Success Metrics

Success will be measured when hexes with outdoor radio coverage are subordinate to hexes with indoor radio coverage.  If a hex has five indoor radios overlapping in coverage and a outdoor radio also has model coverage in that hex, then the outdoor radio should not get any points or rewards for that hex.