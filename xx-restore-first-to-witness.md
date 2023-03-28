# XX Restore first to respond witness rewarding

- Author(s): @BFGNeil
- Start Date: 2023-03-23 <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: economic, technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

Now that hotspots no longer sync the chain it makes little sense to leave a 20 block (~20 minute)
window for witnesses to report. This allows hotspots on slower connections that would not service
traffic (late delivery) to earn from PoC.

## Motivation

The motivation here is to move to reward the "best" setup hotspots in an area when there are a lot
of hotspots. This change wont effect areas where beacons recieve under 14 witnesses, but will take
effect in dense areas where putting a 3g/4g backed hotspot makes little sense over using fiber if
its available.

Density of hotspots is currently following population, and if there is a lot of population that
means its proffitable for ISP's to provide fiber at a much lower cost. These areas make little sense
to deploy a LTE hotspot when fiber is available cheaply.

## Stakeholders

This effects every hotspot on the network's potential earnings, increasing rewarders for "better"
setups reducing rewards for those not providing "usefull" coverage.

## Detailed Explanation

Currently hotspots have a 20 block window to report their witnessing of a beacon. Out of everyone
that heard the beacon (no matter if they report the witness instantly or ~20 minutes later) 14 are
chosen and rewarded.

This randomisation means a hotspot on a windowcill on wifi has just as much chance as a hotspot on
cable internet placed on a roof with wired internet access, but the hotspot on wifi would very
likely not be able to report data transfer and simply wouldn't be rewarded.

If a hotspot heard a packet from a sensor, and took 20 minutes to report it, the packet would be
marked as late and the hotspot would not be rewarded, yet in the current system we would potentially
reward them for their laggy setup.

Having this window also allows for packet stuffers to recieve, edit and submit fake witnesses and
have just as much chance of being selected as a legitimate setup.

This change ensures the "best setup" (in terms of line of sight & internet speed, distance from
originating gateway) are rewarded over those setup on for example slow connections, badly placed
indoors or those far away on towers pointing into cities not providing useful coverage for sensors.

## Drawbacks

- Fiber connections will always have a faster delivery over ISP connection types.
- 600 or so DIY gateways exist with the key stored on the filesystem, these hotspots will always be
  faster at delivering as they don't have to ask the ECC to sign the witness, they can just use the
  flat file key which is quicker.
- Differences in security methods mean some are slower than others to sign witnesses reports and
  send them.

## Rationale and Alternatives

An alternative would be to reduce this window, and pair this with better gaming detection. This was
considered but the time it takes to write such a system it makes more sense to change it back to
first to witness and then look into better options later, such as modeled coverage and then repeal
this hip in favour of a smaller randomised window.

## Unresolved Questions

None so far.

## Deployment Impact

The impact of these changes will be a reduction in earning from packet stuffing, better rewards to
the better setup hotspots (better line of sight, closer to the beacon and on faster connections)
which will match the experience we want for sensors.

## Success Metrics

To measure the success of this hip we need to look at packet stuffing reward reductions and an
increase to the better setup hotspots in an area which should be confirmable comparing rewards to
how hotspots respond in an area to mappers.
