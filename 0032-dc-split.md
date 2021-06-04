# HIP Template

- Author(s): @PapaOwl <!-- your GitHub @PapaOwl -->
- Start Date: 2021-06-03<!-- fill me in with today's date, 2021-06-03 -->
- Category: economic<!-- economic -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

The current reward structure incentivises companies too much to install a 50$ light hotspot for the use-cases they are installing even in well covered areas, since the following will always be true with the current structure:
If it is profitable for any hotspot to be in the area, it is even more profitable for a company to bring in a new cheap hotspot 1m next to the use-case that they install.
**Thus I propose to change the DC reward from the fastest responder to all hotspots that could have performed this duty in a timely fashion.**
# Motivation
[motivation]: #motivation

The price of Hotspots will see a drastical reduce over time due to Light Hotspots having much lower requirements and economics of scale factoring in. The latest estimation on this that I saw put it at 50$ for hotspots somewhere around 2022/23.
As it currently stands most use-cases are very static in nature.
From the parkmeters, to parking spot counters, various environmental sensors, water leakage things and so on.

As a company you have to worry about a central question: Will the coverage last. You cannot answer that for smaller cities, because you do not know the hotspot owners. Thus this alone is already a reason to install a light hotspot as you install the use-case. Unfortunately with how it currently runs it would also mean that all the DC rewards would go to the company. There is no reason to believe that another hotspot can challenge a hotspot literally built into the use-case on this.

The company has not added coverage, but it reaps the entire reward and thus disregards all others that were already there and furthermore might even violate hex-rules and punish the other miners. However they have a good reason to do and we should not prohibit that, but we should not reward it too much either.

We have to think of those that provide coverage even in areas that don't see as much action, because a network that reaches far and wide is worth much more to companies of all kinds, than a network that only exists on top of use-cases and major population areas.

For the customer it does not matter one bit who is rewarded unless he is also the one that decided to place a hotspot on himself to get a kind of cashback on his DC useage instead of using the coverage that is already provided.

This HIP does not have an affect to areas that have no other hotspots nearby. 

# Stakeholders
[stakeholders]: #stakeholders
All those already providing coverage
* Who is affected by this HIP?
All new "coverage" providers

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

I am not a code guy, but with how it looks to me currently only the resolver of a DC packet is rewarded. Hotspot 2,3 or how many there are have no way of knowing that Hotspot 1 will be faster, so they aswell will at least have tried to resolve it. Currently only Hotspot 1 would be rewarded for resolving. All others would not receive anything.

Thus we could tie the reward to the blocktime, but preferably I would set 1-2s after the resolve as cut-off to give a bonus to those that provide good and fast services.

As an example we have a use-case sending out a ping and there is 6 Hotspots that receive and try to act. Hotspot 1 was the fastest, but Hotspot 2-5 all reacted in under 1s aswell. Hotspot 6 only responded after 2 seconds now the reward is going out to to Hotspot 1-5 in equal amount. Hotspot 6 failed and is thus not rewarded. Maybe he was too far, maybe its internet is too slow.

**No new rewards or price increase is happening here. The reward that would go to one guy in full before would now be equally split to all that could have handled the request well. If there is no other hotspot to begin with, then this changes nothing.**

- It should be reasonably clear how the proposal would be implemented.

Not a code guy, so I cannot say how this would end up being solved.

- Provide representative examples that show how this proposal would be commonly
  used.
If you think of any small scale city being filled by several hotspots and providing good coverage. A company comes and installs any use-case at some point in that coverage and additionally a light hotspot is also planted.

Now instead of the DC rewards going solely to the new hotspot they go to all those that could also have provided the service for the use-case.

- Corner cases should be dissected by example.

I think gamey cases are covered as long as we tie the DC output to the reward scale.
# Drawbacks
[drawbacks]: #drawbacks

The drawback is that it isn't as profitable for companies to bring their use-case and a hotspot at the same time. However I would not call this a drawback to the network, but an advantage.

- Why should we *not* do this?

Honestly I see no reason. Good coverage is done by several miners and not by a single one on top of the use-case. If we want coverage to be widespanning, then we cannot have a system that rewards placements directly on top of use-cases the most.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives
An alternative could be to lock out new devices out of DC earnings for a time if they are placed in already settled areas, but I feel simply sharing among all is simply better.

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

I know that currently we have a huge incentive to provide cover, but eventually the Network will be rewarding DC only. If companies start to plant in a well-covered area it is a slap to those already covering. In this it doesn't matter if the coverage is provided by 10 individuals or a single guy, that made sure that the city he lives in is well covered. The use-case would finally appear and the reward would rarely go to those.

If we take the example of park meters, then a company would be well advised, to incorporate the LoRaWAN directly into the design, but they also should not be rewarded exclusively on the DC. Otherwise we undermine those that provided the possibility for it to be used.

In case the network surrounding the use-case breaks down the parkmeter would keep functioning as it comes with its own device.

**So this is a very good compromise between protecting companies against the failure of coverage and protecting the interest of those that already provide coverage longterm.**

- Why is this design the best in the space of possible designs?
I don't think, that I could come up with all possible design solutions to this problem, so I guess I cannot answer such a broad question.
- What other designs have been considered and what is the rationale for not
  choosing them?
I think there was ideas about locking out new devices of earning and protecting old devices. I feel those ideas are too harsh and Helium should in general go further away from individual hotspot earnings and more to area earnings. A LoRaWAN Network that reaches far, is worth more than a Network that exists only in big clusters. We need to make sure, that rewards go to a wider area than the action.
- What is the impact of not doing this?
Individuals who built the network when there was no use-case will be driven out by companies that bring the use-case. Last time I checked this was supposed to be a network made by people and not by medium sized companies.
# Unresolved Questions
[unresolved]: #unresolved-questions

Maybe discussion of this HIP brings it to light. Consider this HIP as a nudge. If someone can write it better, feel free to take this idea and develop it further, but I believe as it stands it should neither be too hard to implement, nor be unreasonable to do so.

# Deployment Impact
[deployment-impact]: #deployment-impact



# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- What should we measure to prove a performance increase?
The entire problem is something that still has to come up. This HIP targets to remove a problem before it occurs as thus it not happening is our success metric.


- What should we measure to prove an acceptance of this by it's users?
- A vote

As a final note I want to greet Tim and re-offer poffertjes to be guaranteed a purchase of 5 longaps.
