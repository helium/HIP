# HIP Template (Give it a title here but do not allocate a number, maintainer will allocate a number)

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

the motovation here is to move to reward the "best" setup hotspots in an area. The IOT PoC WG is
focusing on improving PoC to reward for the better utilised hotspots in an area, this is one step of
that by rewarding the best setup hotspots rather than anyone who heard it within 20 minutes.

Currently Hotspots have a 20 block window to report their witnessing of a beacon in. out of everyone
that heard the beacon (no matter if they report the witness instantly or ~20 minutes later) 12 are
chosen and rewarded.

Having this window to report also allows for packet stuffers to recieve, edit and submit fake
witnesses and have just as much chance of being selected as a legitimate setup.

Reducising this window makes little difference as we're talking milliseconds of difference, the only
way to reudce it is to return back to first to hear over this random selection as forwarding will
always add latency.

If a hotspot heard a packet from a sensor, and took 20 minutes to report it, the packet would be
marked as late and rejected, yet in the current system we would potentially reward them for their
laggy setup.

## Stakeholders

This effects every hotspot on the network,

## Detailed Explanation

- Introduce and explain new concepts.
- It should be reasonably clear how the proposal would be implemented.
- Provide representative examples that show how this proposal would be commonly used.
- Corner cases should be dissected by example.

## Drawbacks

- Fiber connections will always have a faster delivery over other providers options.
- 600 or so DIY gateways exist with the key stored on the filesystem, these hotspots will always be
  faster at delivering as they dont have to ask the ECC to sign the witness, they can just use the
  flat file key which is quicker

## Rationale and Alternatives

An alternative would be to reduce this window, but it would not solve the issue of stuffing, we're
talking milliseconds of difference, only changing to first to hear solves this.

## Unresolved Questions

None

## Deployment Impact

The impact of these changes will be a reduction in earning from packet stuffing, better rewards to
the better setup hotspots (better line of sight, closer to the beacon and on faster connections)
which will match the experience we want for sensors.

## Success Metrics

To measure the success of this hip we need to look at packet stuffing reward reductions and an
increase to the better setup hotspots in an area which should be confirmable via mapping
