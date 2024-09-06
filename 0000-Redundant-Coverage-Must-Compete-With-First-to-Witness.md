- Author(s): [@no1-at-all](https://github.com/No1-at-all)
- Start Date: 2024-09-06
- Category: Economic, Technical
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veIOT

## Summary
When hotspots are less than 8 res 12 hexes apart only the first to witness will be rewarded.

## Motivation
Currently hotspots receive rewards for redundant coverage.  This would only reward the first to witness in areas with redundant coverage.
- Disuade people from installing multiple hotspots per location when additional rewards are the motivation.
- Encourage people to spread out to under served areas.
- Some people belive Proof of Coverage rewards are broken and alternatives should be developed.

## Stakeholders
All IOT Hotspot owners will be affected.

## Detailed Explanation
Currently hotspots that are less than 8 res 12 hexes apart may not witness each other's beacons.  This extends that concept to witnessing all beacons.  When multiple hotspots are less than 8 res 12 hexes apart, only the first to witness shall be rewarded.

## Drawbacks
May encourage false assertions.

## Rationale and Alternatives
Over saturated areas abound and many hotspots are rewarded for providing redundant coverage.  Some users install multiple hotspots in a single location in an effort to increase rewards.  

Currently, first to witness (network latency) is the only metric available to gauge a hotspot's performance.  Until other metrics are available, this is a convinient method to only reward the best performing hotspot in an area with redundant coverage.

It's common advice to new hotspot owners to install their hotspot 350-400 meters apart.  This is the distance represented by less than 8 resolution 12 hexes.  This HIP extends that meaning, hotspots that are within that distance are proving redundant coverage and only the first to witness shall be rewarded.

## Unresolved Questions
There are currently no unresolved questions.

## Deployment Impact
Users with low performance hotspots providing redundant coverage will likely see a reduction in rewards. 

Users with high performance hotspots providing redundant coverage will likely see an increase in rewards.  

Other users may see an increase in rewards with the elimination of rewards for redunant areas.

## Success Metrics
Success could be measured by calculating the rewards for hotspots proving redundant coverage.

