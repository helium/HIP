# HIP 136: Eliminate IOT Rewards for Redundant Coverage

- Authors: [@No One At All](https://github.com/No1-at-all) & [@waveform](https://github.com/waveform06)
- Start Date: 2024-10-16
- Category: Economic, Technical
- Original HIP PR: [#1084](https://github.com/helium/HIP/pull/1084)
- Tracking Issue: [#1108](https://github.com/helium/HIP/issues/1108)
- Vote Requirements: veIOT Holders

---

## Summary

Currently, Hotspots receive rewards for providing Redundant Coverage where other Hotspots are also rewarded for covering the same area.  This proposal intends to only reward the *First to Witness* in areas with *Redundant Coverage* when there are greater than *Maximum Witnesses* to a beacon.

## Motivation

- Hotspots that are less than *Minimum Distance* hexes apart are providing *Redundant Coverage*.
- Dissuade people from installing multiple Hotspots per location when additional rewards are the motivation.
- Encourage people to spread out to underserved areas.
- Some people believe Proof of Coverage rewards are broken and alternatives should be developed.

## Stakeholders

- All IOT Hotspot owners will be affected.
- Will require NOVA involvement and development.

## Detailed Explanation

This proposal intends to make several changes to the existing IOT Proof-of-Coverage implementation.

Rewards for PoC events that have equal to or less than *Maximum Witnesses* (1-14) will not be affected by this HIP.

### Redundant Coverage

After removing any Hotspots due to previous invalidation reasons (e.g, within *Minimum Distance* from the beaconing Hotspot, invalid due to Antenna Classifier, etc.), each witnessing Hotspot is evaluated for whether they are providing *Redundant Coverage*. This *Redundant Coverage* is defined as being within the *Minimum Distance* of another witnessing Hotspot and is the same distance as the minimum *Witness Distance Limit* from a beacon from [HIP 15](https://github.com/helium/HIP/blob/main/0015-beaconing-rewards.md#witness-distance-limits). *Minimum Distance* is currently defined as eight (8) resolution size 11 h3 hexes, approximately 350 meters.

Ordering of evaluation will use the *First to Witness* function defined in [HIP-83](./0083-restore-first-to-witness.md).

Identified redundant witness events will be marked with the invalidation reason "Redundant Coverage" and removed from reward calculation. After removals, the remaining witnesses, up to the *Maximum Witnesses* defined as `14` through the `max_witnesses_per_poc` variable, will be considered for rewards.

The intent is to have all of the Maximum Witnesses to a beacon be greater than or equal to Minimum Distance apart from any other witness. Hotspots less than Minimum Distance apart from any other are invalidated.

### Example Invalidation Function

Given a PoC event with more than *Maximum Witnesses* (15 or more), the following process should be followed to determine validity.

1. Remove and mark all invalid witnesses for other invalidation reasons.
2. Order all witnesses by the *First to Witness* function.
3. For each witnessing Hotspot:
   1. Iterate over the later Hotspots to determine whether they are within the *Minimum Distance* from the selected Hotspot.
   2. If they are, mark the later Hotspots as ineligible for reward due to *Redundant Coverage*
4. Once *Redundant Coverage* has been evaluated, also mark any Witnesses in excess of *Maximum Witnesses* as ineligible for reward.

Developers are free to implement this logic in a way that optimizes for data processing as the above description implies an `O(n²)` implementation which can be inefficient. The intention of this example is to also confirm that the number of invalidated witnesses do not count towards the total number of witnesses in a PoC event.

### Example map - 3 Hotspots in a resolution 11 hex with 7 rings

![3 Hotspots res 11 ring 7.png](/files/0136/3-hotspots-res-11-ring-7.png)

### In this scenario ###

**A** and **B** are within *Minimum Distance*, **B** and **C** are within *Minimum Distance*. None of the other witnesses to the beacon are within *Minimum Distance* of each other. There are more than *Maximum Witnesses* to the beacon.

### Example #1

**A** and **B** witness a beacon, but **C** does not.

If **A** is *First to Witness* before **B**, then Hotspot **B** is invalidated with reason *Redundant Coverage*.  Likewise, if **B** is *First to Witness* **A** is invalidated.

### Example #2

**A**, **B**, and **C** all witness the same beacon.

If **B** were *First to Witness*, then both **A** and **C** would be invalidated with reason *Redundant Coverage*.

### Example #3

**A**, **B**, and **C** all witness the same beacon.

If **A** is the *First to Witness*, this would cause **B** to be invalidated with reason *Redundant Coverage*.  **C**, would then be evaluated for *Minimum Distance* and be validated

### Example #4

**A**, **B**, and **C** all witness the same beacon.  

As Example 3 but there are other witnesses not shown within *Minimum Distance*.

If **A** is the *First to Witness*, this would cause **B** to be invalidated with reason *Redundant Coverage*.  **C**, would be evaluated for *Minimum Distance* and *First to Witness* for further rewards eligibility with the other witnesses.

### PoC events with 14 witnesses or less ###
Given a PoC event with less than or equal to *Maximum Witnesses* (14), then all PoC witnesses including A, B and C are eligible for reward.

## Drawbacks

- May encourage false assertions: Many owners may want to falsely assert their location.  The current Antenna Classifier may catch many of these, but it also may be possible to update the classifier's parameters to align with this HIP.
- May encourage owners to turn off Hotspots rather than compete: This is an acceptable outcome as the goal of the network should be to align incentives towards expanding network coverage not deploying redundant coverage.

## Rationale and Alternatives
### Decrease the amount of witness redundancy

If two or more Hotspots are within *Minimum Distance*, they are more or less in the same place and they are providing *Redundant Coverage*.  If those same Hotspots witness the same beacon, and they are both to be rewarded according to [HIP 83](https://github.com/helium/HIP/blob/main/0083-restore-first-to-witness.md#detailed-explanation), then they are providing the same coverage as each other and both being paid for it.

Denying earnings for these redundant Hotspots give other Hotspots, that may be slower to witness but provide more unique coverage, an opportunity to compete to be selected and decrease the amount of witness redundancy when there are greater than *Maximum Witnesses* to a beacon.

Multiple Hotspots within *Minimum Distance* should not be rewarded for providing more or less the same location coverage at more or less the same time.

### Aligns with previous standards

New Hotspot owners are advised to install their Hotspots at least 350 meters apart from one another to receive PoC rewards.  This is the distance represented by *Minimum Distance*.  Hotspots that are asserted less than this distance apart do not earn by witnessing each other's beacons. This HIP extends that concept to only rewarding the *First to Witness* Hotspots which are less than *Minimum Distance* apart and providing *Redundant Coverage*.

Keeping this distance ensures Hotspot deployers do not have a grievance if the minimum distance advice given them over the years changed via this HIP.

### Multiple Hotspots per location

Many deployers want to install multiple Hotspots per location for various reasons or use cases.  This proposal still supports these installations, yet it discourages rewards based reasons by removing PoC rewards for the slower responding Hotspots in dense locations.

### Alternatives
#### Antenna Classifier

Changing the Antenna Classifier to Denylist all Hotspots in the same location regardless of asserted location would solve some of the same issues as this HIP.  It would also Denylist legitimate use cases which require multiple Hotspots per location.

#### Split rewards for redundant Hotspots

Instead of invalidating witnesses with *Redundant Coverage*, rewards could be split equally among the Hotspots.  This would not decrease *Redundant Coverage*.

## Unresolved Questions

- Discussion may bring up additional questions.
- Evaluation of possible gaming vector scenarios needs to be considered and likely configurations of gaming deployment.
- Deployers may just reassert Hotspot locations and not physically move them. Denylist classifiers may be the way these reasserts are prevented from continuing to receive rewards from faking unique coverage.

## Deployment Impact

- Deployers of Hotspots providing *Redundant Coverage*  in dense areas will likely see a reduction in rewards.
- Other Hotspots deployers may see an increase in rewards because of this reduction in rewards for Hotspots rewarded for *Redundant Coverage*.
- This HIP comes with no code and Nova-Labs would be requested to develop the code for this HIP.

## Success Metrics

Success can be measured by
- Observing that Hotspots within *Minimum Distance* of each other are rewarded less for witnessing the same beacon if there are more than *Maximum Witnesses* to the beacon.
- A decrease in rewards to overly dense areas of Hotspot deployment.
- An increase in the reassertion of Hotspots in dense areas to those less dense measured by evaluating the change in Hotspots in larger resolution Hexes.
