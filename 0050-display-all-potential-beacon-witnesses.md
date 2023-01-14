# HIP 50: Display All Potential Beacon Witnesses

- Author(s): @captainhindsite
- Start Date: 2021-12-09
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/322>
- Tracking Issue: <https://github.com/helium/HIP/issues/331>

# Summary

Under the current Proof Of Coverage (POC) model, for each beacon sent, current tools / reporting
mechanisms allow interested parties to monitor only those witnessing hotspots which have been
randomly selected as potentially eligible to receive rewards. The details of other hotspots which
could have successfully witnessed said beacon but were excluded by that random selection process
remain unreported and inaccessible to hotspot owners

This can, especially during periods of sub-optimal network performance, make it difficult for
hotspot owners to know if their hotspot is performing poorly in terms of witnessing beacons, or if
they are just 'unlucky' with regard to the random selection process in effect. This in turn can
prove an obstacle to hotspot owners wishing to optimise their installations for coverage and
rewards. I propose a change to reporting, to display all potential witnesses regardless of the
results of the random selection process, to provide greater clarity and confidence for hotspot
owners seeking to optimise their installations.

# Motivation

It can be frustrating and counter-productive as a hotspot owner to witness beacons rarely, while
being unable to ascertain the most likely root cause and thus unable to undertake, with any
confidence, any likely or required remedial action, or to avoid unnecessary effort and expense
trying to remedy an issue which is outside the hotspot owner's influence.

The ability to differentiate between likely causes of a low witnessing count could be of significant
benefit to pro-active hotspot owners as well as to potential newcomers to the Helium network looking
to carry out thorough due-diligence.

# Stakeholders

Anyone interested in monitoring hotspot POC performance.

# Detailed Explanation

The maximum number of witnesses to a hotspot POC beacon event as governed (presumably) by chain
variable poc_per_hop_max_witnesses is, at time of writing, 18. Thus a maxium of 18 witnesses,
selected at random from the total number of possible witnesses, are potentially\* eligible to
receive rewards for witnessing any particular beacon.

\*The randomly selected hotspots can include hotspots which are subsequently classed as invalid
witnesses i.e. because of their geographical proximity to the beaconing hotspot.

Currently, these (up to) 18 hotspots are the only ones reported by the available tools / reporting
mechanisms. Potential witnesses which were excluded by the random selection process remain
unreported.

I submit that hotstpot owners would benefit from knowing how many and which particular hotspots were
potential witness candidates, as a means to gauge the effect on beaconing performance of changes
made to their individual setup in a bid to optimise their coverage and rewards - or to avoid
unnessary effort and expense in making modifications which can have no useful impact.

# Drawbacks

As a non-coder, based on my end-user experience alone of the way the existing tools / reporting
mechanisms operate currently, I can well imagine that implementing this suggestion would require
significant effort on the part of the Helium development team and can well appreciate that they
likely have more pressing priorities.

# Rationale and Alternatives

I foresee no alternatives to this proposal which would achieve the same objective.

The potential impact of not implementing some measure to provide hotspot owners with better ways to
ascertain if low witnessing count results from their setup or from the random selection process or
from network issues from time-to-time in effect is that those owners are likely to expend
unnecessary effort or expense or, alternatively, miss opportunities to improve their setup to the
benefit of themselves and to the network as a whole.

# Unresolved Questions

Is this a reasonably achievable objective in the context of the existing codebase, available
resource and other objectives?

# Deployment Impact

Information useful to existing and potential hotspot owners looking to ensure their setup is
optimised, and to existing and potential network users will be made available to them.
