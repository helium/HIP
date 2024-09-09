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

- *Minimum Distance* is defined as less than 8 resolution 11 hexes apart.  This is the established distance that determines whether or not hotspots may witness each other's beacons.
- *Redundant Coverage* is defined as hotspots that are less than *Minimum Distance* apart.
- *Desired Redundancy* is defined as the maximun number of witnesses to a beacon, 14.
- *Invalidation Reason* witnesses are invalidated with invalidation reason 'Redundant Coverage'
 

If there are *Desired Redundancy* or fewer witnesses to a beacon then there are no changes, all witnesses would be rewarded as normal.

Suppose there are two hotspots, **A** and **B**, and they are less than *Minimum Distance* apart.  **A** and **B** both witness a beacon, and there are greater than *Desired Redundancy* witnesses. Hotspot **A** witnesses at number 8, hotspot **B** witnesses at number 10. Since **A** and **B** are less than *Minimum Distance* apart, only the first to witness, **A** at number 8, will be rewarded.  **B** will be invalidated with *Invalidation Reason*. 

Suppose we add another hotspot, **C**. **C** is less than *Minimum Distance* from **B**, but greater than *Minimum Distance* to **A**.  So **A** and **B** provide *Redundant Coverage*, and **B** and **C** provide *Redundant Coverage*.  **B** is doubly redundant.  Next,  **A**, **B**, and **C** all witness the same beacon and there are greater than *Desired Redundancy* witnesses.  If **A** witnesses before **B**, **B** is invalidated with *Invalidation Reason*.  Since **B** is denied, **C** no longer provides *Redundant Coverage*. **B** must witness before both **A** and **C** to be rewarded.  Once a hotspot is invalidated with *Invalidation Reason*, it may no longer compete, it's out of the race.

When hotspots have been invalidated with *Invalidation Reason*, there must be more than *Desired Redundancy* witnesses.  If there are less than *Desired Redundancy* valid witnesses, then next fastest hotspot to respond would then be considered for validation.  If it is not providing *Redundant Coverage*, then it is valid as normal.  Otherwise if it is providing *Redundant Coverage*, it must also be the first to respond of all hotspots within *Minimum Distance*. If it is not, it is invalidated with *Invalidation Reason* and  the next fastest would be considered, and so on, until either *Desired Redundancy* valid witnesses are obtained or there are no more witnesses to consider.  

For example, there are 16 witnesses to a beacon.  Number 14 is invalidated with *Invalidation Reason*.  Number 15 would then be considered, if it validates all is done, otherwise 16 is considered. If neither 15 or 16 passes, then there are 13 valid witnesses to the beacon.

Suppose 16 hotspots witness a beacon.  Suppose 4 are invalidated with *Invalidation Reason*.  This would mean that only 12 total hotspots would be rewarded.  There is no recurrsion, once a hotspot is denied it no longer competes.  The number of hotspots invalidated with *Invalidation Reason* do not count towards the total number of hotspots to witness a beacon.

To avoid being invalidated with *Invalidation Reason*, a hotspot providing *Redundant Coverage* must be faster to respond than all other hotspots within *Minimum Distance*, or all other hotspots within *Minimum Distance* must have been previously invalidated with *Invalidation Reason* or another invalidation reason defined elsewhere.


## Drawbacks
- May encourage false assertions.
- May encourage owners to turn off hotspots rather than compete

## Rationale and Alternatives
Over saturated areas abound and many hotspots are rewarded for providing *Redundant Coverage*.  Some users install multiple hotspots in a single location in an effort to increase rewards.  

Currently, first to witness (network latency) is the only metric available to gauge a hotspot's performance.  Until other metrics are available, this is a convinient method to only reward the best performing hotspot in an area with *Redundant Coverage*.

It's common advice to new hotspot owners to install their hotspot 350-400 meters apart.  This is the distance represented by less than 8 resolution 11 hexes.  This HIP extends that meaning, hotspots that are within that distance are proving *Redundant Coverage* and only the first to witness shall be rewarded.

Many owners want to install multiple hotspots per location for various reasons.  This proposal would implicity allow such installations, yet discourage them by removing rewards.

Many hotspot owners have low moral.  They are discouraged by a seeming lack of progress.  The goal is to instill hope, change, and encourage the discouraged.

## Unresolved Questions
- There are currently no unresolved questions.
- Discussion may bring up additional questions.

## Deployment Impact
- Users with low performance hotspots providing redundant coverage will likely see a reduction in rewards. 

- Users with high performance hotspots providing redundant coverage will likely see an increase in rewards.  

- Other users may see an increase in rewards with the elimination of rewards for *Redundant Coverage*.

## Success Metrics
Success could be measured by calculating the rewards for hotspots providing *Redundant Coverage*.

