- Author(s): [@no1-at-all](https://github.com/No1-at-all)
- Start Date: 2024-09-06
- Category: Economic, Technical
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veIOT

## Summary
Currently hotspots receive rewards for *Redundant Coverage*.  This HIP proposes to only reward the first hotspot to witness in areas with *Redundant Coverage* when there are greater than 14 witnesses to a beacon.
## Motivation
- Hotspots that are less than 8 resolution 11 hexes apart are providing *Redundant Coverage*.
- Disuade people from installing multiple hotspots per location when additional rewards are the motivation.
- Encourage people to spread out to under served areas.
- Some people belive Proof of Coverage rewards are broken and alternatives should be developed.

## Stakeholders
- All IOT Hotspot owners will be affected.
- Will require NOVA involvement and development.

## Detailed Explanation

### *Minimum Distance* 
*Minimum Distance* is defined as 8 resolution 11 hexes.  Hotspots less than this distance apart may not witness each other's beacons.
### *Maximum Witnesses*
*Maximum Witnesses* is equal to the variable max_witnesses_per_poc, which is currently 14.  This HIP will respect and follow any future changes to this number.  If there are *Maximum Witnesses* or fewer witnesses to a beacon then there are no changes, all witnesses would be rewarded as normal.  
### *Redundant Coverage* 
Each witness to a beacon is checked to determine if: 
- There are hotspots that are less than *Minimum Distance* apart that also witnessed the beacon.
- The witness has not been previoulsy invalidated with any invalidation reason.
- There are greater than *Maximum Witnesses* to the beacon.  

If each of the above conditions are met, then they are deemed to be providing *Redundant Coverage*.
### *Invalidation Reason*
*Invalidation Reason* means that witnesses are invalidated with invalidation reason 'Redundant Coverage'
### *First to Witness*
The procedures in HIP 83 are used to determine which hotspot is *First to Witness* a beacon. 
### Why use resoloution 11 hexes?
When the distances between hotspots are calculated using hexes, the hotspots are assumed to be at the center of the hex.  As the resolution increases, the location of the hotspot is more accurate, since the size of the hex containing the hotspot decreases.

### Example invalidation function
Imagine that all of the witnesses to a beacon were stored in a list sorted by *First to Witness*.  There are greater than *Maximum Witnesses* to the beacon.
- Start at the head of the list.  Check if there are other hotspots in the list that are within *Minimum Distance* and invalidate them.
- Proceed to next element in the list and validate as above.
- Repeat until the end of the list or *Maximum Witness* are validated.

The number of invalidated witness does not count towards the total number of witness a beacon
### Example map #1 
**3 hotspots in a resolution 11 hex with 7 rings**

![3 hotspots res 11 ring 7.png](/files/0000/3-hotspots-res-11-ring-7.png)
### Table #1 
**Hotspot distances**
| | **A** | **B** | **C** |
| - | ------- | ----- | ----- |
| **A** | | 7 | 14 |
| **B** | 7 | | 7 |
| **C** | 14 | 7 | |

***Example assumptions***

It is assumed that there are more than *Maximum Witnesses* to the beacon.  None of the other witnesses to the beacon are within *Minimum Distance* of each other.
### Example #1
**A** and **B** witness a beacon, but **C** does not.  There are more than *Maximum Witnesses* to the beacon.

**Table #1** shows that **A** is 7 hexes apart from **B**.  This is less than *Minimum Distance*.  

Start with the *First to Witness*.  If **A** is *First to Witness* compared to **B**, then hotspot **B** is invalidated with *Invalidation Reason*. Likewise, if **B** is *First to Witness* **A** is invalidated.
### Example #2
**A**, **B**, and **C** all witness the same beacon.  There are more than *Maximum Witnesses* to the beacon.

**Table #1** shows that **A** is 7 hexes from **B**.  **B** is 7 hexes from **C**.  **A** is 14 hexes from **C**.  **A** and **B** are redundant, and **B** and **C** are redundant.  **A** and **C** are not redundant.

Start with the *First to Witness* among the hotspots.  Suppose **A** is the *First to Witness* compared with the others. This would cause **B** to be invalidated.  **C**, would then compete via *First to Witness* to be selected.

Likewise, if **C** were *First to Witness*, **B** would be invalidated and **A** free to compete.

If **B** were *First to Witness*, then both **A** and **C** would be invalidated.
## Drawbacks
### May encourage false assertions
Many owners may want to falsely assert their location.  The current Antenna Classifier may catch many of these, but it also may be possible to update the classifier's parameters to align with this HIP.
### May encourage owners to turn off hotspots rather than compete

## Rationale and Alternatives
### Decrease the amount of witness redundancy 
If two or more hotspots are within *Minimum Distance*, they are more or less in the same place, they are providing *Redunant Coverage*.  If those same hotspots witness the same beacon, and they are both to be rewarded according to HIP 83, then they are proving more or less the same coverage as each other because:
- They are within *Minimum Distance* of each other
- They both are to be selected for rewards according to HIP 83

Denying the redundant hotspots give other hotspots, that may be slower to witness, an oppurtunity to compete to be selected and decrease the amount of redundancy of witnesses when there are greater than *Maximum Witnesses* to a beacon.

In other words, why should multiple hotspots within *Minumum Distance* be rewarded for providing more or less the same location coverage at more or less the same time? 
### Aligns with previous standards
It's common advice to new hotspot owners to install their hotspots 350-400 meters apart from one another.  This is the distance represented by *Minimum Distance*.  Hotspots that are asserted less than this distance apart may not witness each other's beacons. This HIP extends that concept. Hotspots which are less then *Minimum Distance* apart are providing *Redundant Coverage* and only the first to witness shall be rewarded.

Owners may have a grievance if the distance advice given them over years changed via this HIP.
### Multiple hotspots per location
Many owners want to install multiple hotspots per location for various reasons.  This proposal would implicity allow such installations, yet discourage them by removing rewards.

For example, if your use case needs multiple hotspots per location, that's fine, but only the *First to Witness* would be eligible for POC rewards. 
### Alternative
Changing the Antenna Classifier to Denylist all hotspots in the same location regardless of asserted location would solve some of the same issues as this HIP.  It would also Denylist legitimate use cases which require multiple hotspots per location.
## Unresolved Questions
- Is less than 8 resolution 11 hexes the correct distance?
- Discussion may bring up additional questions.

## Deployment Impact
- Owners with low performance hotspots providing redundant coverage will likely see a reduction in rewards. 

- Other owners may see an increase in rewards with the elimination of rewards for *Redundant Coverage*.

## Success Metrics
Success could be measured by calculating the rewards for hotspots providing *Redundant Coverage*.

