- Start Date: 2020-02-04
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

Go from having a single, authoritative key to a group of keys, a majority of which are required to sign a given chain var transaction.

# Motivation
[motivation]: #motivation

Currently, Helium, Inc. is the only entity involved in proposing and authorizing changes to the the chain metadata (chain vars) which control the behavior of the chain.  This means that we can unilaterally decide to change the behavior of the chain.  Having multiple keys means that:
  * The key is harder to steal, and harder to lose.
  * Helium must seek the approval of all groups of key-holding stakeholders before making changes.
  * 

# Stakeholders
[stakeholders]: #stakeholders

* Who is affected by this HIP?

Everyone involved with the chain is affected by this.

* How are we soliciting feedback on this HIP from these stakeholders? 

This HIP PR, targeted outreach to specific stakeholders who are likely to hold one of the initial keys.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

- Introduce and explain new concepts.

- It should be reasonably clear how the proposal would be implemented.

- Provide representative examples that show how this proposal would be commonly
  used.

- Corner cases should be dissected by example.

# Drawbacks
[drawbacks]: #drawbacks

Having multiple people involved in signing the chain means that we need to divert engineering effort to implementing this proposal, and towards making usable tools for allowing people to interact with these keys and transactions in a way that probably doesn't involve a Erlang shell running a miner.  Ideally, we would have CLI tools to do the signing.

Additionally, we lose our ability to move quickly.  If we need to do a rescue block in the middle of the night, we're going to need to call people and wake them up and get them to do things.

We'll also need to invest additional effort in effectively communicating changes and incorporating feedback from other stakeholders (to be clear, the feedback is good, but the time overhead can be costly).

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

- Why is this design the best in the space of possible designs?

It's the cheapest to implement, and requires no additional dependencies, and very few, if any, design changes to the overall system.

- What other designs have been considered and what is the rationale for not choosing them?
  - Various threshold signature schemes: they would add additional development time, dependencies, and complexity for very little gain in terms of functionality.  While it might be nice for the ultimate signature to be smaller, var transactions are rare, so the additional size isn't as heavy a burden.
  - Voting:  It isn't even entirely clear what voting means or looks like.  While it might be more desirable, it isn't something that we can deliver at short notice; it will require a long period of design and discussion with stakeholders about what voting can change, what it means, who can propose, how votes are run, etc.  Multisig isn't incompatible with voting schemes in the long run, and indeed is a reasonable first step in decentralizing administrative power over the network.

- What is the impact of not doing this?

Not doing this leaves an unacceptable (in the long run) amount of power in the hands of Helium the company, putting our reputation as a fair steward of the network at risk.

# Unresolved Questions
[unresolved]: #unresolved-questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?

This HIP is primarily to socialize the idea, to have something to point other stakeholders who we might want to carry keys at when educating them about the plan.  This HIP process is also good place to talk through the social process of distributing the keys and how also the process of getting a new variable transaction signed once we've transitioned to the new process.

- What parts of the design do you expect to resolve through the implementation of this feature?

The implementation is relatively easy; mostly the things that will be determined during implementation is the network transition, since not only are we replacing the master key, we're changing how the master key system works.

- What related issues do you consider out of scope for this HIP that could be addressed in the future independently of the solution that comes out of this HIP?

The design of a voting system is out of scope.  It has been decided that this is a good enough step for now, and that a voting system, if implemented, is a longer-term project.

# Deployment Impact
[deployment-impact]: #deployment-impact

Describe how this design will be deployed and any potential imapact it may have on current users of this project.

- How will current users be impacted?

Users of the network should not be affected at all.  Administration will become more complex.

- How will existing documentation/knowlegebase need to be supported?

We'll need to write some additional documentation for keyholders about how to use the keys they're holding and what we expect from them.

- Is this backwards compatible?

Yes, it is required to be.

# Success Metrics
[success-metrics]: #success-metrics

This section is not relevant to this sort of feature.
