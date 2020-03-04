- Start Date: 02/19/2020
- HIP PR:
- Tracking Issue:

# Summary
[summary]: #summary

Ensuring trust in the network when non-helium hotspots begin to
participate in the network.

# Motivation
[motivation]: #motivation

Helium's primary objective has always been to establish a decentralized
permissionless wireless network allowing anyone to be able to join and
provide RF Coverage with off-the-shelf hardware and open source
software.

This goal poses some interesting challenges specifically regarding
network growth. Once we allow non-helium hotspots to be able to join the
network, we lose the ability to verifiably prove that any sub-network
created by such new hotspots truly exist physically since it's easily
possible for dishonest actors to fake geographic locations and radio
transmit/receive and claim that they are providing network coverage.

# Stakeholders
[stakeholders]: #stakeholders

- 3rd party hotspot manufacturers
- DIY hotspot builders

# Problem Deinifition
[problem-definition]: #problem-definition

Consider the below network where hotspot A-F are non-helium manufactured
hotspots, with the lines representing RF visibility between hotspots.

                     +------+
                     |      |
         +-----------+  A   |
         |           |      |
         |           +------+
         |
    +------+
    |      |
    |  F   |
    |      |
    +------+
        |            +------+
        |            |      |
        |            |  B   |
        |            |      |
        |            +------+            +------+
    +------+             |               |      |
    |      |             |               |  C   |
    |  E   +-----------------------------+      |
    |      |             |               +------+
    +------+             |
        |                |
        |             +------+
        |             |      |
        +-------------+  D   |
                      |      |
                      +------+

There exists no possible way to ensure that these hotspots do not form
part of a virtual network, since they can easily fake locations and RF
coverage and verify each other via the existing PoC mechanism.

To correctly identify whether the above network is legitimate, we have
the option of introducing a Helium (or authorized 3rd party reseller)
hotspot in the network and learning more about the behavior of each
hotspot. Only the real hotspots can successfully participate with
eventual PoC challenges involving the Helium hotspots.

Reimagining the above network with the introduction of a helium hotspot,
consider the updated graph below:


                     +------+
                     |      |
                     |  A   +---------------+
                     |      |               |
                     +------+               |
                                         +--+---+
    +------+                             |      |
    |      |                             |  X   +<--+Helium Hotspot
    |  F   |             +---------------+      |
    |      |             |               +------+
    +------+             |
                     +---+--+
                     |      |
                     |  B   |
                     |      |
                     +---+--+            +------+
    +------+             |               |      |
    |      |             |               |  C   |
    |  E   |             |               |      |
    |      |             |               +------+
    +---+--+             |
        |                |
        |             +--+---+
        |             |      |
        +-------------+  D   |
                      |      |
                      +------+

With this information, we can verifiably prove that A, B, D and E can
successfully complete PoC challenges which involve hotspot X. Since we
know that hotspot X is bound to be trustworthy by design and any hotspot
which can participate in a PoC challenge involving X can only do so if
it's operating within the rules set by the consensus mechanism and also
has an operating radio chip.

However, even with the above explained scheme, we still need a way to be
able to allow hotspots not manufactured by Helium or authorized
manufacturers to not only participate in PoC but also be candidates for
consensus membership to build a truly decentralized permissionless
network.

To counter that and allow any hotspot to participate in PoC and have
consensus membership candidacy, we propose to introduce "Levels of
Trust".

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Current Network Behavior

In the current network onboarding a helium manufactured hotspot allows
full proof-of-coverage priviledges as soon as the hotspot syncs fully
with the blockchain, however this behavior is insufficient to ensure
that non-helium manufactured hotspots or DIY hotspots by individual
developers adhere to the consensus rules and also honestly provide RF
coverage.

As mentioned in the problem defintion, we cannot assume that every
single DIY hotspot is going to incorporate a GPS chip or a radio chip.
Malicious enttities may try to game the system by tweaking/removing
hardware and yet be able to participate in PoC. Currently we _know_ that
every single hotspot being added to the network is manufactured by
helium and has the required hardware to participate in proof-of-coverage
challenges, as soon as we allow other hotspots to join the network we
have no verifiable way of being able to separate a virtual network from
a real one.

To mitigate that, we propose a new model for establishing trust among
hotspots and subsequently change how hotspots earn HNT, perhaps aptly
named "Levels of Trust".

## Levels of Trust

We introduce the concept of levels of trust, defining constraints,
relationships and progress of what it means for a hotspot to be in a
particular level and subsequently transition between levels. This is
akin to a character leveling up in a game, except the characters are
hotspots!

Below is a visual representation of the aforementioned levels, the most
important takeaway here is that any higher level encompasses all the
benefits and constraints of the lower levels.


    +--------------------------------------------------+
    |                                                  |
    |                                                  |
    |    +--------------------------------------+      |
    |    |                                      |      |
    |    |                                      |      |
    |    |    +--------------------------+      |      |
    |    |    |                          |      |      |
    |    |    |                          |      |      |
    |    |    |     +--------------+     |      |      |
    |    |    |     |              |     |      |      |
    |    |    |     |     Level I  |     |      |      |
    |    |    |     |              |     |      |      |
    |    |    |     +--------------+     |      |      |
    |    |    |                          |      |      |
    |    |    |                 Level II |      |      |
    |    |    |                          |      |      |
    |    |    +--------------------------+      |      |
    |    |                                      |      |
    |    |                            Level III |      |
    |    |                                      |      |
    |    +--------------------------------------+      |
    |                                                  |
    |                                        Level IV  |
    |                                                  |
    +--------------------------------------------------+


### Level I

- Any hotspot which aims to enter the helium network starts it
  progressing at this level. The entry fee to gain access to this level
  is burning data credits worth $X. Note that the market price of data
  credits is not controlled by Helium.
- The only PoC priviledge a hotspot has in this level, is that it can
  add other hotspots in its witness list, given that it is successfully
  witnessing nearby occuring PoCs.
- A hotspot in this level can freely transmit data and earn HNT based
  solely on transmitting network data.

### Level 2

- The minimum criteria to enter this level require that a hotspot must
  have witnessed X% of nearby occuring PoCs involving a Level 3 hotspot
  over the course of Y days (or Z block equivalent).
- A hotspot can also be promoted to this level via a TBD governance
  proposal.
- In addition to the Level I priviledges, this level also grants the
  ability to participate in PoCs.

### Level 3

- The minimum criteria to enter this level require that a hotspot must
  have completed X successful PoC challenges involving other Level 3
  hotspots.
- In addition to the Level II priviledges, hotspots are granted the
  ability to construct challenges. Constructing challenges is only
  granted to hotspots which have been proven to be consistent and is
  also the most reliable and regular way to gain a steady HNT influx,
  therefore it's reserved as a priviledge for Level 3.

### Level 4

- This is the final, most coveted level.
TBD....This is where hotspots gain consensus membership candidacy
priviledge.


# Drawbacks
[drawbacks]: #drawbacks

TBD

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

TBD

# Unresolved Questions
[unresolved]: #unresolved-questions

TBD

# Deployment Impact
[deployment-impact]: #deployment-impact

TBD

# Success Metrics [success-metrics]: #success-metrics

TBD
