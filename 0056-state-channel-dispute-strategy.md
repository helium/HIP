# HIP 56: Improved State Channel Disputes

- Author(s): [@macpie](https://github.com/macpie),
  [@michaeldjeffrey](https://github.com/michaeldjeffrey),
  [@Vagabond](https://github.com/Vagabond), [@abhay](https://github.com/abhay),
  et al
- Start Date: 2022-02-21
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/366>
- Tracking Issue: <https://github.com/helium/HIP/issues/369>
- Status: In Discussion

# Summary

This HIP describes an update to the dispute mechanism for State Channels that
would improve blockchain scaling, better reconcile Data Transfer activity and
rewards for Hotspots, and address recent issues around large block sizes.

State Channel disputes provide a mechanism to validate the integrity of a State
Channel. Previously, disputes triggered by participating Hotspots contained
redundant information, and increased block size. On a couple of occasions the
number of disputes caused some large blocks to halt chain activity due to
Validators not being able to consume them. This proposal retains the State
Channel integrity check by any participant, but also updates the dispute
mechanism to prevent disputes from halting chain activity.

We propose that the first valid instance of a disputed State Channel that is
accepted by Validators becomes canonical and does the following:

1. All other disputes are marked as invalid and are rejected by the Consensus
   Group.
2. No rewards are distributed to _any_ participant of the State Channel.
3. The State Channel owner will still be slashed of its Data Credits and its
   Data Credit overage. As a note, this point is the current implementation that
   will not be changed with this proposal.

We believe these three steps (with the changes included) will reduce the impact
of State Channel disputes on the overall blockchain and not inadvertently reward
(potentially) colluding actors who could be in control of both the Hotspot and
the Router. This would allow the blockchain to increase the State Channel Grace
Period (described below) and better reward Hotpots in the majority of cases
where Routers are able to close State Channels promptly and Hotspots do not need
to file disputes.

# Motivation

Failures in Routers closing State Channels within the network-specified block
interval has caused participating Hotspots to file disputes on chain leading to
bloated blocks resulting in a few chain halts in the last few months. These
halts are due to Validators not being able to ingest the series of large dispute
transactions. Routers may occasionally fail to close their State Channels and
thus trigger a cascade of events that may eventually lead to a stream of
disputes. To improve the resiliency of the blockchain, we believe that it's
appropriate to be intolerant to potentially misbehaving Routers and/or Hotspots.

# Stakeholders

All Router operators and Hotspot owners are directly affected by this HIP. When
a State Channel is validly disputed, Router Operators will be slashed their Data
Credits, and participating Hotspots will not be rewarded.

# Detailed Explanation

Routers open and close State Channels in order to buy packets on the LoRaWAN
network. You can read more about how State Channels work in this [blog
post][blog]. The Router is given a grace period, defined as the
`sc_grace_blocks` chain variable, to close their State Channel after it is
supposed to expire. Once the Router submits the close transaction, the current
dispute mechanism allows for any Hotspot to file a State Channel close
transaction as a dispute, if they disagree with the initial close of the State
Channel. Since Routers accept/attest that they will buy a packet before the
Hotspot sends it to them, the Hotspot has all the information it needs to
dispute the State Channel.

State Channel close transactions are already fairly large since they can contain
up to 2000 Hotspot addresses, controlled by the `sc_max_actors` chain variable.
A disputed close transaction can potentially be twice this size. In the past few
months, this has become problematic as having several of these disputes in a
single block can cause block absorption issues and chain halts. Moreover, it
complicates rewards calculations as Validators will attempt to reconcile these
disputes and will, most of the time, not be able to reward all Hotspots in the
State Channel equitably.

This proposal includes the following changes to insure that disputes do not
cause the chain to slow down or halt:

1. As soon as one dispute is filed by a Hotspot, subsequent dispute transactions
   will be marked invalid and rejected. This will avoid the creation of massive
   blocks containing too many State Channel close transactions.
2. If a dispute is filed against a State Channel close transaction, no rewards
   will be distributed to any participant of this state channel.
3. The State Channel owner will still, like before, lose its Data Credits and
   the Overage.

It is safer to not reward any participant for several reasons. It can be
computationally expensive to distribute all rewards to each participant involved
if the dispute and original close have a large discrepancy. Also, a Hotspot and
Router could conspire to publish a fake dispute and assign all rewards to one or
multiple Hotspots. By potentially slashing the Router's Data Credits, this
approach avoids that risk.

All of these changes will be enabled by a chain variable:
`sc_dispute_strategy_version`.

This proposal is currently implemented in [blockchain-core#1229][core-1229] and
[blockchain-core#1238][core-1238].

# Drawbacks

As soon as a State Channel close is disputed no rewards will be distributed for
this Data Transfer activity.

# Deployment Impact

Normal users should not expect to see a measurable impact, other than
improvements to chain performance.

[blog]: https://blog.helium.com/helium-state-channels-383ade2368d0
[core-1229]: https://github.com/helium/blockchain-core/pull/1229
[core-1238]: https://github.com/helium/blockchain-core/pull/1238
