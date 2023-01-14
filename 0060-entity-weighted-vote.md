# HIP 60 : Entity-Weighted Vote

- Author(s): [@cvolkernick](https://github.com/cvolkernick)
- Start Date: 2022-04-28
- Category: Governance
- Original HIP PR: <https://github.com/helium/HIP/pull/395>
- Tracking Issue: <https://github.com/helium/HIP/issues/399>
- Status: In Discussion

# Summary

Currently HIP votes are conducted via wallet signatures at heliumvote.com; this proposal suggests
further improvement by constraining a given entities voting power to equal the total number of
network entities (Hotspots, validators, routers), rather than by the balance of a voting wallet. The
vote should be weighted accordingly to incorporate the relative network utility value contributed by
a given entity respectively.

# Motivation

There is a need to further constrain the HIP voting process such that influence in vote cannot be
"bought" by holding large balances in wallets; in order to have input in the governance of the
Helium network, it must be taken into consideration the "stake" a given actor has in the network.

# Stakeholders

-Hotspot Owners -Validators -Routers / Console Operators / Service Companies

Voting would be limited to only the entities defined by this proposal. Voting will be constrained to
any entities / network participants that are defined as "contributing network utility". This means
that only any entities that are involved in operating the network itself (transmitting / receiving
data, routing data, validating PoC receipts / securing the network) are governed by and therefore
have "stake" in voting on changes to the network.

It may be later concluded that only affected part(ies) should be able to vote in any given HIP,
however it could potentially be problematic to enter a territory where it becomes a matter of
subjective debate whether or not a given "class" of entity is affected or not -- especially so when
there are any kind of conflicting interests or perceived loss/gain of power by one group or another.
Therefore, it is currently the opinion of the author that whatever weights are ultimately assigned
are consistent across each proposed HIP.

# Detailed Explanation

Ideally voting should at a minimum use a 1:1 correlation between participant stake in the network
(i.e. each Hotspot purchased / onboarded, validator staked, router loaded w/ DC).

HIP votes originated as limited scope straw polls, typically conducted and voted upon by the most
active of community members via Discord. This was limited in scope of awareness, and lacked any
"official" process, or really any way to verify the legitimacy of each vote.

The voting mechanism has since been improved greatly in awareness and security of vote simply by
implementing a public voting location and messaging through official, vastly more visible channels
(e.g. Helium app push notifications) when and where these votes are to occur -- along with relevant
context resources explaining each vote and its implications.

Using private key signatures to cast votes is also a step up in loosely connecting participation in
the network via some unique identifier (wallet address / DC burn), however there is no connection
between stake in the network _utility_ / infrastructure required to do so. Tying voting power to
number on onboarded Hotspots, validators, and/or DC held by routers provides a fair and logical
basis and "stake" in the vote, which mirrors the voting party's stake in the network.

Initial starting point suggestions would be using Hotspot onboarding stake as a basis for the
following weights:

-Hotspot: 1 vote (1,055,000 DC) -Validator: X votes, where X = DC equivalent of 10,000 HNT stake at
time of staking / 1,055,000 -Router: Y votes, where Y = DC on organization console / 1,055,000)

# Drawbacks

Larger private fleets will inherently have larger weight in votes than they presently do, which has
a perception of "big money" controlling the vote. This is, however, no worse off than the present
method of tying HNT balance to vote weight.

# Deployment Impact

Voting mechanism should not fundamentally change in terms of how one goes about voting. The key
distinction is that the Hotspot count on each a voting wallet is what is taken into consideration
for vote weight as opposed to simply allowing any wallet(s) to burn DC to cast votes.

# Success Metrics

With successful implementation it should be possible to audit any given HIP vote and see that votes
are proportionate to wallets' number of eligible onboarded Hotspots. It should possibly (in lieu of
privacy concerns or other controversy arising in the discussion of the proposal) also be possible to
see how wallet(s) and/or Hotspot(s) voted on a given HIP.
