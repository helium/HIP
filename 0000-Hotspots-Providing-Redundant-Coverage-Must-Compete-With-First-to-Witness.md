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
### *Faster to Witness*
The procedures in HIP 83 are used to determine which hotspot is *Faster to Witness* a beacon. 
### Why use resoloution 11 hexes?
When the distances between hotspots are calculated using hexes, the hotspots are assumed to be at the center of the hex.  As the resolution increases, the location of the hotspot is more accurate, since the size of the hex containing the hotspot decreases.

### Examples
All witnesses are assumed to be potentially valid for discussion purposes, that is they have not been invaidated by some other invalidation reason defined elsewhere. 

Suppose there are two hotspots, **A** and **B**, and they are less than *Minimum Distance* apart.  **A** and **B** both witness a beacon, and there are greater than *Maximum Witnesses*. Therefore, by definition above, **A** and **B** are providing *Rednundant Coverage*. 

Imagine hotspot **A** is  *Faster to Witness* than **B**.  Since **A** and **B** are providing *Redundant Coverage*, only the *Faster to Witness*, **A**,will be rewarded.  **B** will be invalidated with *Invalidation Reason*. 

Suppose we add another hotspot, **C**. **C** is less than *Minimum Distance* from **B**, but greater than *Minimum Distance* to **A**. You might think of this as **A** is too close to **B**, **B** is too close to **C**, **A** and **C** are far enough apart.

**A**, **B**, and **C** all witness the same beacon and there are greater than *Maximum Witnesses*. According to the above definition, **A** and **B** provide *Redundant Coverage*, and **B** and **C** provide *Redundant Coverage*. 

If **A** is *Faster to Witness* than **B**, **B** is invalidated with *Invalidation Reason*.  Since **B** is denied, **C** no longer provides *Redundant Coverage* as **B** has been invalidated. **B** must be *Faster to Witness* than both **A** and **C** to be rewarded.  

Once a hotspot is invalidated with *Invalidation Reason*, it may no longer compete, it's out of the race.

When invalidated witnesses cause there to be less than *Maximum Witnesses* **valid** witnesses, then the next *Faster to Witness* hotspot would then be considered for validation.  If it is not providing *Redundant Coverage*, then it is valid as normal.  Otherwise if it is providing *Redundant Coverage*, it must also be *Faster to Witness* than all hotspots within *Minimum Distance* to itself. If it is not, it is invalidated with *Invalidation Reason* and  the next fastest would be considered, and so on, until either *Maximum Witnesses* valid witnesses are obtained or there are no more witnesses to consider.  

For example, there are 16 witnesses to a beacon.  Number 14 is invalidated with *Invalidation Reason*.  Number 15 would then be considered, if it validates all is done, otherwise 16 is considered. If neither 15 or 16 passes, then there are 13 valid witnesses to the beacon.

Suppose 16 hotspots witness a beacon.  Suppose 4 are invalidated with *Invalidation Reason*.  This would mean that only 12 total hotspots would be rewarded.  There is no recurrsion, once a hotspot is denied it no longer competes.  The number of hotspots invalidated with *Invalidation Reason* do not count towards the total number of hotspots to witness a beacon.
## Drawbacks
- May encourage false assertions.
- May encourage owners to turn off hotspots rather than compete

## Rationale and Alternatives
Over saturated areas abound and many hotspots are rewarded for providing *Redundant Coverage*.  Some users install multiple hotspots in a single location in an effort to increase rewards.  

Currently, first to witness (network latency) is the only metric available to gauge a hotspot's performance.  Until other metrics are available, this is a convinient method to only reward the best performing hotspot in an area with *Redundant Coverage*.

It's common advice to new hotspot owners to install their hotspots 350-400 meters apart from one another.  This is the distance represented by 8 resolution 11 hexes.  Hotspots that are asserted less than this distance apart may not witness each other's beacons. This HIP extends that concept. Hotspots which are less then *Minimum Distance* apart are providing *Redundant Coverage* and only the first to witness shall be rewarded.

Many owners want to install multiple hotspots per location for various reasons.  This proposal would implicity allow such installations, yet discourage them by removing rewards.

Many hotspot owners have low moral.  They are discouraged by a seeming lack of progress.  The goal is to instill hope, change, and encourage the discouraged.

## Unresolved Questions
- Is less than 8 resolution 11 hexes the correct distance?  
- Discussion may bring up additional questions.

## Deployment Impact
- Owners with low performance hotspots providing redundant coverage will likely see a reduction in rewards. 

- Other owners may see an increase in rewards with the elimination of rewards for *Redundant Coverage*.

## Success Metrics
Success could be measured by calculating the rewards for hotspots providing *Redundant Coverage*.

