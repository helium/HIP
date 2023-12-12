# Hotspot Bidrectional Coverage Requirement

- Author(s): <!-- your GitHub @username -->
- Start Date: <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT

## Summary

Hotspots that can not provide bidirectional coverage are not useful for the IOT network as well as pose gaming risks. These risks are currently mitigated by the denylist operated by Nova Labs. This proposal proposes to move the bidirectionality metric that is currently enforced by the denylist to the PoC pipeline. This will result in hotspot owners being signaled of the issue faster and subsequently will signal hotspot owners that the issue has been resolved without waiting until the next denylist iteration.

## Motivation

- Why are we doing this?
- What use cases does it support?
- What problems does it solve?
- What is the expected outcome?

## Stakeholders

All hotspot owners will be affected by this HIP. In particular hotspot owners that have hotspots that are unable to successfully witness or beacon. Two groups of hotspot owners are directly affected: the group of hotspot owners that is currently flagged for not being able to witness or beacon and the group of hotspot owners that experience such a failure in the future.

The hotspot owners that are currently flagged for not being able to witness or beacon successfully will have a faster recourse if this proposal passes. The current denylist cadance is roughly 7 days whereas this proposal will determine if a hotspot supports bidirectional coverage on an epoch by epoch basis thus offering faster recourse and feedback if such a failure is resolved.

The hotspot owners that will experience an inability to provide bidirectional coverage in the future will have faster feedback because they will stop being rewarded the first full epoch after the fault. After resolving the issue the hotspot owner will not have to wait for the 7 day denylist cadence but instead will have immediate feedback that the issue is resolved as PoC rewards return.

## Detailed Explanation

- Introduce and explain new concepts.
- It should be reasonably clear how the proposal would be implemented.
- Provide representative examples that show how this proposal would be commonly used.
- Corner cases should be dissected by example.

## Drawbacks

- Why should we _not_ do this?
- What problems could occur if we do this?

## Rationale and Alternatives

The alternative to this solution is to maintain the status quo where a hotspot is added to the denylist for at least 7 days and will have to wait until the next denylist iteration after the issue has been resolved. We think an automated system within the PoC pipeline is a better solution because it resolves some of the problems the community currently experiences.

1. The signaling of an issue is applied much faster because it is on an epoch-by-epoch basis.
2. In case a hotspot owner resolves the issue the signaling that the fix has been succesful is faster
3. The currently denylist is largely automated but it still requires amount of manual intervention which could be avoided by this proposal


## Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?
- Are there dependencies, milestones, or dates that need to be met for this HIP to succeed?

## Deployment Impact

Describe how this design will be deployed and any potential impact it may have on current users of
this project.

- How will current users be impacted?
- How will existing documentation/knowledge base need to be supported? Any content to change at
  <http://docs.helium.com>?
- Is this backwards compatible? Can this HIP be undone?
  - If not, what is the procedure to migrate?

## Success Metrics

What metrics can be used to measure the success of this design? Are any new ETL reports needed to
measure the success?

- What should we measure to prove a performance increase?
- What should we measure to prove an improvement in stability?
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by its users?
