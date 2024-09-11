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
### Example map #1 3 hotspots in a 11 hex with 7 rings
![3 hotspots res 11 ring 7.png](/files/0000/3-hotspots-res-11-ring-7.png)
### Table 1 hotspot distances
| | **A** | **B** | **C** |
| **A** | | 7 | 14 |
| **B** | 7 | | 7 |
| **C** | 14 | 7 | |

All witnesses are assumed to be potentially valid for discussion purposes, that is they have not been invaidated by some other invalidation reason defined elsewhere. 

Suppose there are two hotspots, **A** and **B**, and they are less than *Minimum Distance* apart.  **A** and **B** both witness a beacon, and there are greater than *Maximum Witnesses*. Therefore, by definition above, **A** and **B** are providing *Rednundant Coverage*. 

Imagine hotspot **A** is  the *First to Witness* compared **B**.  Since **A** and **B** are providing *Redundant Coverage*, only the *First to Witness*, **A**,will be rewarded.  **B** will be invalidated with *Invalidation Reason*. 

Suppose we add another hotspot, **C**. **C** is less than *Minimum Distance* from **B**, but greater than *Minimum Distance* to **A**. You might think of this as **A** is too close to **B**, **B** is too close to **C**, **A** and **C** are far enough apart.

**A**, **B**, and **C** all witness the same beacon and there are greater than *Maximum Witnesses*. According to the above definition, **A** and **B** provide *Redundant Coverage*, and **B** and **C** provide *Redundant Coverage*. 

If **A** is *First to Witness* compared to **B**, **B** is invalidated with *Invalidation Reason*.  Since **B** is denied, **C** no longer provides *Redundant Coverage* as **B** has been invalidated. **B** must be *First to Witness* compared to both **A** and **C** to be rewarded.  

Once a hotspot is invalidated with *Invalidation Reason*, it may no longer compete, it's out of the race.

When invalidated witnesses cause there to be less than *Maximum Witnesses* **valid** witnesses, and there are greater than *Maximum Witnesses*, then the subsequent witness would then be considered for validation.  If it is not providing *Redundant Coverage*, then it is valid as normal.  Otherwise if it is providing *Redundant Coverage*, it must also be *First to Witness* than all hotspots within *Minimum Distance* to itself. If it is not, it is invalidated with *Invalidation Reason* and  the next fastest would be considered, and so on, until either *Maximum Witnesses* valid witnesses are obtained or there are no more witnesses to consider.  

For example, there are 16 witnesses to a beacon.  Number 14 is invalidated with *Invalidation Reason*.  Number 15 would then be considered, if it validates all is done, otherwise 16 is considered. If neither 15 or 16 passes, then there are 13 valid witnesses to the beacon.

Suppose 16 hotspots witness a beacon.  Suppose 4 are invalidated with *Invalidation Reason*.  This would mean that only 12 total hotspots would be rewarded.  There is no recurrsion, once a hotspot is denied it no longer competes.  The number of hotspots invalidated with *Invalidation Reason* do not count towards the total number of hotspots to witness a beacon.
## Drawbacks
### May encourage false assertions
Many owners may want to falsely assert their location.  The current Antenna Classifier may catch many of these, but it also may be possible to update the classifier's parameters to align with this HIP.
### May encourage owners to turn off hotspots rather than compete

## Rationale and Alternatives
### Decrease the amount of witness redundancy 
If two or more hotspots are within *Minimum Distance*, they are more or less in the same place and they are providing *Redunant Coverage*.  If those same hotspots witness the same beacon, and they are both to be rewarded according to HIP 83, then they are proving more or less the same coverage as each other because:
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

