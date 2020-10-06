# HIP 17: Consensus Group Challenges

- Start Date: 2020-08-31
- Author: [@evanmcc](https://github.com/evanmcc)
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

The current need to have challenges come from Hotspots limits the ability of lighter nodes to be productive members of the network.
Some slower machines, or those with minimal storage, might still have good antennas and internet connections and could be "light nodes" that do not keep a chain, but still retain the ability to participate in PoC challenges.
This proposal is to work through enabling these nodes by moving the challenge and receipt process onto the consensus group, which would presumably be made up of more powerful nodes that have the full chain.

# Motivation
[motivation]: #motivation

As mentioned in the summary, we'd like to enable lighter gateway nodes without having them need to carry the full (or even a partial) chain.
Moving PoC challenging onto the consensus group allows for two or more classes of nodes that can all have different roles in the network.
Having lighter gateways will allow people to participate more cheaply, since the gateways can be cheaper than the current pi-based gateways, which in turn should allow the network to expand and gain value more quickly.

# Stakeholders
[stakeholders]: #stakeholders

**Who is affected by this HIP?**

Everyone who uses or in the future might want to use the network.  Allowing people to use cheaper hardware as gateways should allow more rapid expansion of the network.

**How are we soliciting feedback on this HIP from these stakeholders?**

This HIP process, initially the community, and reaching out to commercial partners who might prefer to provide lighter and simpler nodes.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Overview

Currently, all Hotspots are required to validate the chain block by block in order to participate in the PoC process.
They then run both sides of it, issuing challenges at regular intervals and then gathering up the replies.
This works well enough currently, but requires some heavy work on the side of the challenging spot, and requires the presence of an up-to-date chain in several places.
Additionally it puts a lot of pressure on the p2p network to keep important information in sync, as stale addresses are a common cause of failures.
The first iteration of this change would add a new type of gateway that is a member of the p2p mesh but does not have access to the chain except via API calls to external services.
These nodes would be expected to listen for challenge requests delivered from the consensus group via p2p and then execute them in a timely manner.
These p2p request paths could include both light and full nodes.
Challenges would instead come from members of the consensus group, who would divide up the responsibilities for communicating these requests amongst themselves (see the section on [request origination](#request-origination) for more details).
The members of the group would also keep track of the hops and witnesses much like current miner nodes.
They would then submit, along with their regular transaction proposals, either a normal receipt or a [voting transaction](#voting-transactions) depending on what design we decide on.

## Challenge Generation

This will likely reuse the existing code, but instead of generating a single challenge, we will generate the entire list of challenges for this particular block, the size of which will be governed by a new algorithm for automatically scaling the number of requests to the size of the network (see [Appendix B](#appendix-b) for details).
Once the list of targets is generated, group members will select a subset of which to construct and deliver requests to.
This can be tricky, see the next section.

The hard part here is that only the originating node is supposed to know the ephemeral key until the receipts are delivered.
One approach here is the race approach: the first consensus member to reach a node to make the request "wins", everyone else gets a response that the PoC request has already started.
Another would be for the nodes to validate the request via some simple math and only accept requests from nodes on their preference list (to prevent all consensus members spamming all of the target nodes all at once.
There are other options that are substantially more involved if we're seeing bad behavior or think that this needs to be more Byzantine fault-resistant.

## Request Origination
[request-generation]: #request-origination

In order to be resistant to byzantine failures (which isn't always a firm requirement), we need to make sure that at least F+1 nodes execute and report on any action.
There are two sides to this: 
 - Delivery: Each PoC participant needs to be able to receive requests over p2p specifying an onion packet.
 The participant needs to keep enough information about this around somewhere to ensure some level of idempotency; so that multiple onion packets aren't constructed and sent.
 This is easy enough, all requests have a single, deterministic PoC request id.
 - Reporting: Ideally each witness and poc path participant would report to F+1 nodes as well.  We currently do not do this, trusting the challenger to be an honest dealer.
 It's entirely possible to do this in a trusting manner (in which case [voting transactions](#voting-transactions) are not needed), and do something like slashing for consensus members who fail to do their challenges (prompt removal for not signing many/any poc receipts).
 A major complication here is that all witnesses and path members will need to know about everyone that is keeping track of the transaction, which will quite likely be far too many addresses to put into the packet envelope, even in an extremely compressed form.
 We might be able to get around this by identifying the poc transaction by some sort of hash, then having a p2p network metadata query service (see [Appendix A](#appendix-a) for some thoughts on this).

An additional concern on this side is neglecting to send a request, or sending it and ignoring the replies fully or partially (dropping them silently so the gateways think that they have been handled) so as to disadvantage nodes that you don't like (wrong owner, etc).
While we can get around this by forcing F+1 or more members to issue the challenge, 

## Voting Transactions
[voting-transactions]: #voting-transactions

NB: This section is tentative; it adds a fair amount of complexity to transaction processing and it's not clear that it's entirely needed.

The new poc receipt transactions would be handled in a different manner than plain, old transactions.
Each would be preliminary, and there would be several versions of each, which could then be combined into an actual transaction to be validated by the group and included in a block.
If we want this to be resistant to byzantine attacks, we'll need to accumulate F+1 (identical other than responder ID) responses before we include the receipt.
It's not clear that byzantine resistance is required in this situation, although it's a nice property to have.
The primary concern with requiring it is that it's quite a lot of network connections that need to work correctly (also ARPs, address lookups, etc etc) in order for a single receipt to be included.
It's possible that it just isn't worth the effort for a single receipt. 


# Drawbacks
[drawbacks]: #drawbacks

The primary drawback is the change in incentive structure for pioneering nodes.
No longer will geographically isolated nodes get any rewards for challenging (because no one will).
To some extent these rewards will be made up for by shifting a percentage of the rewards to challenges, and also being a lone wolf and passing traffic will always be a way to earn rewards, and can be especially lucrative if you're the only forwarder that will be able to do so.
We will need to do some work to restore these incentives, and this HIP is likely the proper place to discuss the alternatives.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

The only alternative to this that I've been able to think up so far is not doing this at all, which leaves us unable to use cheaper LoRaWAN gateways on the network, which is undesirable.
Alternative suggestions welcomed.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Pioneer spot rewards: we need to figure out the incentive structure for people to add gateways and light gateways in locations that can't see any other gateways.
- Light gateway information services: we need to figure out the best way to make the necessary information for a PoC challenge available to light gateways.
- Voting Transactions: Are they needed, or can we get away with simply slashing group members that aren't carrying their weight in terms of making challenges happen.
- Greedy Challengers: A node could challenge everyone in an attempt to "claim" all of the PoC challenges for this round either for censorship purposes or to force slashing for other nodes (so as to stay longer in the consensus group).  The request/reporting mechanism needs careful design to prevent this as well.

# Deployment Impact
[deployment-impact]: #deployment-impact

**Describe how this design will be deployed and any potential imapact it may have on current users of this project.**

There should be fairly little impact on the current network at this stage of the process.
We'll activate a chain var and behavior will change.
However, network incentives will change, perhaps a lot.
Since there will no longer be any challenges, lone-wolf nodes will no longer have the same incentive to participate or pioneer new regions.

Additionally, many users (and developers) use challenge recency as a heartbeat metric.
We will need to develop alternative metrics to for assessing the health of the network at large.

A more positive impact of this changeover should be that longer PoC paths outside of cheat clusters should be more feasible, as they will require less from the participating nodes.

# Success Metrics
[success-metrics]: #success-metrics

**What metrics can be used to measure the success of this design?**

Primarily: PoC rate success. The PoC rate shouldn't fall when we enable this design.

Secondarily: Do people actually add light gateways to the network?  How many?  Was this feature really needed for this adoption?

# Appendix A: libp2p Services
[appendix-a]: #appendix-a

Currently the network is a sea of undifferentiated nodes, all running more or less the same version of erlang lip2p.
Under this proposal, we will be moving to a network that has nodes with differing capacities (to some extent, we have this today with seed nodes).
Given that many of these nodes will have small memory and little to no persistent storage, it's probable that we'll need to be able to make informed decisions about what network peers we retain knowledge about.
In order to inform those decisions, I think that libp2p peers should start to declare some sort of service information, e.g. "can answer ARP requests", "full node", "poc capable", etc.
This way, we can drop or ignore the a large number of peer updates for peers that we're unlikely to ever interact with (distant nodes, etc) while retaining information about nodes that are likely to be more important or that we're more likely to need to contact (seed nodes, full nodes, etc).
This allows us to define new services and offload duties like "can answer queries about PoC challenges" to full nodes, which allows us to make light nodes even lighter.

# Appendix B: PoC Rate Auto-scaling
[appendix-b]: #appendix-b

Currently, we scale the PoC stuff in a fairly inelegant way, assuming that the goal is uniform coverage of the network.
Each node, despite knowing the size of the network, issues challenges at a uniform rate.
However, the PoC path length is not 1, so we should  be covering more than one node per challenge on average, which means that the interval should scale more slowly than its current linear scaling.
The base assumption here is that the entire graph can be seen, effectively, as a tree.
Since it's a tree, coverage is more accurately calculated via O(n log(k, n)), where k is the average relationship width (here, the median number of witnesses).
The exact calculation can be covered in a different HIP, but this auto-scaling should allow coverage to be more even without overwhelming the group due to linear scaling.The base assumption here is that the entire graph can be seen, effectively, as a tree.
Since it's a tree, coverage is more accurately calculated via O(n log(k, n)), where k is the average relationship width (here, the median number of witnesses).
The exact calculation can be covered in a different HIP, but this autoscaling should allow coverage to be more even without overwhelming the group due to linear scaling.
