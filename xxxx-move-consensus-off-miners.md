# HIP Template

- Author(s): @cvolkernick
- Start Date: 2020-12-15
- Category: Economic, Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

Changes the structure & process involved in forming consensus on the network - primarily by separating concerns of miners (providing verifiable coverage) and consensus group (securing the network / block formation).

# Motivation
[motivation]: #motivation

Why are we doing this? What use cases does it support? What problems does it
solve? What is the expected outcome?

In its current state, consensus takes place onboard miners, or in the cloud in the case of "light gateways" with cloud-based miners. This HIP proposes moving away from the former and toward the latter as a standard, by moving consensus away from miners and onto dedicated cloud-based or otherwise privately operated server farms. By separating the concerns of miners (involved in tandem with gateways/packet forwarders) and consensus group, the two can be better optimized to perform their respective duties.

Presently, there is a compromise of optimization, as hardware and software needs are at odds with one another; the most optimized approach for gateways/miners (coverage providers) and consensus group (security / data integrity providers) are distinct and different. Considerations for each are as follows:

Gateways (presumed as onboard miners):

-Lightweight; both in form factor & complexity
-Economic; lowest cost to achieve the same outcome optimally
-Security; inability to compromise and/or repurpose hardware for malicious purposes (gaming)

Consensus Group:

-Performant; performs necessary compute tasks at peak efficacy/efficiency (fastest, low compute overhead, most energy/cost efficiency)
-Reliability; maintains highest uptime, least timeouts, least dropped/failed transaction confirmations
-Security; robust against potential gaming, attacks, etc., and does not allow for powerful and/or bad actors to compromise the system at scale or via brute force.

# Stakeholders
[stakeholders]: #stakeholders

* Who is affected by this HIP?

* How are we soliciting feedback on this HIP from these stakeholders? Note that
  they may not be watching the HIPs repository or even aren't directly active in
  the Helium Community Slack channels.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

- Introduce and explain new concepts.

- It should be reasonably clear how the proposal would be implemented.

- Provide representative examples that show how this proposal would be commonly
  used.

- Corner cases should be dissected by example.

# Drawbacks
[drawbacks]: #drawbacks

- Why should we *not* do this?

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

- Why is this design the best in the space of possible designs?

- What other designs have been considered and what is the rationale for not
  choosing them?

- What is the impact of not doing this?

# Unresolved Questions
[unresolved]: #unresolved-questions

- What parts of the design do you expect to resolve through the HIP process
  before this gets merged?

- What parts of the design do you expect to resolve through the implementation
  of this feature?

- What related issues do you consider out of scope for this HIP that could be
  addressed in the future independently of the solution that comes out of this
  HIP?

# Deployment Impact
[deployment-impact]: #deployment-impact

Describe how this design will be deployed and any potential impact it may have on
current users of this project.

- How will current users be impacted?

- How will existing documentation/knowlegebase need to be supported?

- Is this backwards compatible?

        - If not, what is the procedure to migrate?

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

Success for this HIP can be measured in several ways. First, improved consensus performance overall should be emphasized. This can be measured by improvement of CG participants dropping / timing out, material reduction in consensus group stalls, and perhaps even reduction in block times (if this is so desired...it is the author's understanding that there is a desire to hold block times as close to ~60s as possible, pending correction). Given there are also issues of individual miners crashing due to being underpowered and being elected to CG, it would follow that a successful implementation of cloud / distributed consensus would cause less of these problems to occur.

It should also be considered that there are potential economic implications to this change, as well. HIP 16 implementing random consensus selection appears to be widely popular within the community due to more equity of opportunity and more widely distributed rewards. Among these considerations are lone wolves, who rightfully have concerns about any changes that would result in them being at an inherent disadvantage. A successful implementation of these changes to consensus should ensure that these concerns are considered and that consensus group election considerations do not adversely effect the changes implemented successfully in HIP 16.

- What should we measure to prove a performance increase?

- What should we measure to prove an improvement in stability?

- What should we measure to prove a reduction in complexity?

- What should we measure to prove an acceptance of this by it's users?
