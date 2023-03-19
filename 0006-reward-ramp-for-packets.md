# HIP6: Ramp-up period for data transfer rewards

- Start Date: May 21 2020
- HIP PR:
- Tracking Issue:

# Summary

Data Packets are already transferring on the network. Once the price oracle is in place, users will
be able to burn HNT and generate Data Credits, use DC to send packets on the network, and Hotspots
routing those packets will earn a reward in the form of HNT. This share is expected to be 30% of HNT
per month, which is a large amount and can be easily gamed.

This proposal is to recommend a ramp up to 30% over a period of time to prevent undesirably gaming
behaviour.

# Motivation

Why are we doing this? What use cases does it support? What problems does it solve? What is the
expected outcome?

In the early days of data transferring on the network, it is expected that less devices will
transact, and the Hotspots transferring data will earn a larger portion of the rewards (30%) as set
out in <https://www.dewi.org/tokens>. This proposal is to ensure token distribution is fair as
device usage grows and in accordance to the work a Hotspot does.

# Stakeholders

- Who is affected by this HIP? Hotspot owners Decentralized Wireless Alliance

- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIPs repository or even aren't directly active in the Rust Async Ecosystem working
  group.

We will be discussing the HIP in community slack

# Detailed Explanation

- Introduce and explain new concepts. There has been a few suggestions on how we can do this. Those
  include a slow ramp up to 30% with an increase of n% every n blocks.

- It should be reasonably clear how the proposal would be implemented.

- Provide representative examples that show how this proposal would be commonly used.

- Corner cases should be dissected by example.

# Drawbacks

- Why should we _not_ do this?

# Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design space. This is
probably the most important section!

- Why is this design the best in the space of possible designs?

- What other designs have been considered and what is the rationale for not choosing them?

- What is the impact of not doing this?

# Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?

- What parts of the design do you expect to resolve through the implementation of this feature?

- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?

# Deployment Impact

Describe how this design will be deployed and any potential imapact it may have on current users of
this project.

- How will current users be impacted?

- How will existing documentation/knowlegebase need to be supported?

- Is this backwards compatible?

        - If not, what is the procedure to migrate?

# Success Metrics

What metrics can be used to measure the success of this design?

- What should we measure to prove a performance increase?

- What should we measure to prove an improvement in stability?

- What should we measure to prove a reduction in complexity?

- What should we measure to prove an acceptance of this by it's users?
