# HIP5: PoC fairness/epoch challenge limit

- Start Date: <!-- 2020-05-13 -->
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary

Proof of coverage challenge participation rewards are too concentrated for the top few hotspots. This has led to a concentration of mining rewards which are not ideal for the proliferation of the Helium Network.

I propose that we cap the number of challenges any given hotspot can participate in during a single Epoch.

# Motivation

1. Why are we doing this?
    1. The proof of coverage challenges are concentrated amongst the top hotspots. This leads to the proof of coverage challenge rewards being very concentrated as well. This current design was reasonable when we saw proof of coverage as a core input to hotspot score but with the upcoming deprecation of hotspot score the current distribution of proof of coverage challenges is no longer appropriate.
2. What use cases does it support?
    1. Moving forward, the goal of the proof of coverage challenge rewards should be to provide base rewards to honest hotspot hosts providing coverage.
3. What problems does it solve?
    1. The concentration of proof of coverage challenges is not ideal for growing the network coverage.
4. What is the expected outcome?
    1. A more equitable distribution of proof of coverage challenges and the associated rewards amongst honest hotspot hosts.

# Stakeholders

1. Who is affected by this HIP?
    1. The stakeholders are the hotspot hosts who are currently participating in challenges. If adopted, this HIP would more equitably spread out challenge rewards amongst hotspot hosts.
2. How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be watching the HIPs repository or even aren't directly active in the Rust Async Ecosystem working group.
    1. We will solicit feedback from specific Patrons in direct conversations and the hotspot host community more broadly via the community slack

# Detailed Explanation

1. Introduce and explain new concepts.
    1. The only new concept is a limitation on how many times a given hotspot can successfully participate in a proof of coverage challenge in a given Epoch. I propose that a hotspot can only successfully participate in a challenge X times per Epoch.
2. It should be reasonably clear how the proposal would be implemented.
    1. This should be a simple addition to the challenge construction process. If a hotspot has already been part of X successful challenges this epoch, then a new challenge path cannot be constructed with that hotspot in that Epoch.
3. Provide representative examples that show how this proposal would be commonly used.

4. Corner cases should be dissected by example.
    1. There is only one hotspot connecting two large groups of hotspots and we can only have X challenges between the groups per epoch.

# Drawbacks

- Why should we *not* do this?
Changing anything which affects econommics should generally be avoided unless necessary.

# Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

1. Why is this design the best in the space of possible designs?
    1. This change is very simple to implement and will make it very hard to game the proof of coverage challenge process in the future.
    2. This change will also cause more hotspots to be included in challenges because the same ones can’t keep coming up repeatedly.
2. What other designs have been considered and what is the rationale for not choosing them?
    1. More complex routing paths for challenges have been considered. But complexity is bad.
3. What is the impact of not doing this?
    1. We will see a continued concentration of proof of coverage challenges which will inequitably distribute mining rewards and encourage more gaming of the network rather than honest actors.

# Unresolved Questions

1. What parts of the design do you expect to resolve through the HIP process before this gets merged?
    1. The number of challenges a hotspot can successfully participate in per epoch.
2. What parts of the design do you expect to resolve through the implementation of this feature?
3. What related issues do you consider out of scope for this HIP that could be addressed in the future independently of the solution that comes out of this HIP?

# Deployment Impact

Describe how this design will be deployed and any potential imapact it may have on
current users of this project.

1. How will current users be impacted?
    1. The distribution of proof of coverage mining rewards will change. It was going to change pretty significantly with the roll out of data credits anyway.
2. How will existing documentation/knowledge base need to be supported?
    1. I am not aware of any public documentation about how challenge paths are constructed so I do not think any changes are needed.
3. Is this backwards compatible? If not, what is the procedure to migrate?
    1. Yes

# Success Metrics

1. What metrics can be used to measure the success of this design?
    1. Lower standard deviation of proof of coverage challenge rewards
