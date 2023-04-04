# HIP Template (Give it a title here but do not allocate a number, maintainer will allocate a number)

- Author(s): @mawdegroot, @Maxgold91 <!-- your GitHub @username -->
- Start Date: 2023-04-03 <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: economic <!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

This HIP proposes that the definition for the `A` includes _all onboarded devices_. Determining which devices are active is based on a subDAOs interpretation of active and requires an oracle to submit this information. To make the implementation easier and to remove the need for a subDAO interpretation this HIP proposes to use all devices that have been onboarded for the `A` factor.

<!-- Read the content requests in all sections before starting to write any section. -->

## Motivation

There are two main reasons why the `A` factor should include all onboarded devices. The first is that the definition of an active device influences the DAO Utility Score and a subDAO is therefore incentivized to define active as being rewarded in some extremely long interval. This means that a subDAO is already incentivized to use 'any onboarded device' as their definition for active. The second reason is that determining which Hotspots are active requires a subDAO to operate an oracle to feed this information to the chain. By aligning the implementation with the definition subDAOs are incentivized to use anyway we remove an implementational hurdle.

## Stakeholders

- Who is affected by this HIP? A stakeholder is any individual, group, or party such as network
  users, Hotspot hosts, or token holders.
- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIP repository or even directly active in the Helium Community chat channels.

## Detailed Explanation

All network participants.

## Deployment Impact

This proposal will make the DAO Utility Score easier to implement and removes the requirement for a subDAO operated active devices oracle.

