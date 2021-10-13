# HIP43: Update Release Guidelines

- Author(s): @ganey
- Start Date: 2021/10/13
- Category: Meta
- Original HIP PR: 
- Tracking Issue: 

# Summary
[summary]: #summary

This proposal intends improve the rollout process of new updates / changes to the network by ensuring they are released in a period where all vendors/involved parties can make software changes (such as GA's) in a timely manner.

# Motivation
[motivation]: #motivation

Helium GA releases can be quite frequent at times, and cause downtime on the network and for hotspot owners while thier devices download the updates. With an increasing number of third party vendors, less and less devices will automatically download a new GA and will require the manufacturer/vendor to release a software update.
Sometimes this has been on Fridays or weekends, at this time a significant part of the US/Europe would not be working, or ready to develop and test a new hotspot software update. This leaves third party devices with less rewards or even security issues until the following Monday. If this happened to be a public holiday, a significant part of the network could be vulnerable for 4 or more days.

# Stakeholders
[stakeholders]: #stakeholders

* Who is affected by this HIP? - No one would be adversely affected, developers may have to wait longer to release an update.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

- Certain updates can be released any time (such as zero-day, widespread hotspot issues or significant data transmission failure)

- All other updates such as hotspot GA's should be released on a weekday e.g: Monday, Tuesday, Wednesday or Thursday, this gives manufacturers/vendors time to test and release the updates

- The network will have better reliability, manufacturers have more time to test updates rather than rushing out updates last thing on a Friday, which could leave devices broken or poorly functioning all weekend

# Drawbacks
[drawbacks]: #drawbacks

- Why should we *not* do this? - It could be difficult for Helium developers to decide if an update is an emergency, or if it should potentially wait 4 days before release. 

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Recently several GA's have been released at the end of the week, requiring vendors to release updates out of hours, or hotspot owners wait until Monday to get the update. This makes rewards messy over this time period and hotspot owners can lose out on rewards over the weekend.

# Unresolved Questions
[unresolved]: #unresolved-questions

- How much of the network should be affected before an update is considered critical?

- Which public holidays would be reasonable to also not release updates on? e.g New Years Day, Chinese new year etc

# Deployment Impact
[deployment-impact]: #deployment-impact

- Vendors will be quicker at releasing device updates as they will be at work
- Network should be more stable as hotspots will all update in a more timely manner
- Rewards will be more consistent as surrounding hotspots will be on the same software version for longer

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- Manufacturers will have more time to test updates in thier working hours, rather than as an emergency at an evening or weekend

- Network updates should rollout in a shorter timeframe, a bugfix could be updated across the network within a couple of days or less, rather than potentially a week or more

- Rewards would likely be more stable over an update period, rather than a rollercoaster for a few days as with recent updates
