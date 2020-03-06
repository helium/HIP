- Start Date: 02/19/2020
- HIP PR:
- Tracking Issue:

# Summary
[summary]: #summary

A comprehensive set of improvements to Proof-of-Coverage, the scoring system, how Hotspots join the network, and participate in mining and the HBBFT consensus group.

# Motivation
[motivation]: #motivation

On the Helium network today, only Hotspot hardware purchased from Helium Inc. is considered trustworthy. These Hotspots are sold using a hardware key storage device (a secure element) that makes it reasonably challenging for an attacker to create a virtual network of Hotspots that have valid keys. The downside of this situation is that the tens of thousands of non-Helium Inc. LoRa gateways that exist in the world cannot join the network and participate in mining.

The goal of this proposal is to propose a set of measures that make it safe for LoRa gateways of unknown origin to participate in Proofs-of-Coverage and earn tokens for that participation. This goal poses some interesting challenges, as in the current system the network loses the ability to verifiably prove that any sub-network created by such new gateways truly exists since it's possible for dishonest actors to fake geographic locations and radio activitity.

# Stakeholders
[stakeholders]: #stakeholders

- 3rd party Hotspot manufacturers
- DIY miners

# Problem Deinifition
[problem-definition]: #problem-definition

There are a number of problems we hope to address with this proposal:

1. Allow non-Helium Inc manufactured Hotspots to participate in Proof-of-Coverage and mining
2. Provide a way for non-radio hardware to participate in consensus groups
3. Increase the requirements for consensus group participation to improve the overall health of the network
4. Introduce a number of penalties for failing to perform any of the roles required for earning HNT

# Allowing non-Helium Inc manufactured Hotspots to participate in Proof-of-Coverage
[non-helium-hotspots]: #non-helium-hotspots

## The problem

Consider the below network where Hotspots A through F are of unknown origin, with the lines representing reported RF connectivity between hotspots.

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

Since it is possible for RF data to be fabricated - there is no way to verify that data was sent via RF once it has been demodulated - the network does not know whether these Hotspots are part of a virtual network, or whether they are physically deployed at their claimed locations.

To correctly identify whether the above network is legitimate, we can introduce a Helium Inc (or authorized 3rd party reseller) 'trusted' Hotspot into the network and learn more about the behavior of the Hotspots A-F. Only real Hotspots will be able to successfully participate in PoC challenges involving the trusted Hotspot.

Reimagining the above network with the introduction of a trusted Hotspot, consider the below:


                     +------+
                     |      |
                     |  A   +---------------+
                     |      |               |
                     +------+               |
                                         +--+---+
    +------+                             |      |
    |      |                             |  X   +<--+ Trusted Hotspot
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

With this information, we can verify that A, B, D and E can successfully complete PoC challenges which involve X. Since we know that Hotspot X is trustworthy, we can conclude that any Hotspot which can participate in a PoC challenge involving X can only do so if it's operating within the rules set by the consensus mechanism and also has an operating radio chip.

However, even with this scheme we still need a way to allow Hotspots not manufactured by Helium Inc or authorized manufacturers to not only participate in PoC but also be candidates for consensus membership.

To counter that and allow any hotspot to participate in PoC and have consensus membership candidacy, we propose to introduce "Levels of Trust".

## Current Network Behavior

In the current network, onboarding a Helium Inc manufactured Hotspot grants full Proof-of-Coverage priviledges. 

As mentioned in the problem defintion, we cannot assume that every single DIY hotspot is going to incorporate a GPS chip or a radio chip. Malicious enttities may try to game the system by tweaking/removing hardware and yet be able to participate in PoC. Currently we _know_ that every single hotspot being added to the network is manufactured by helium and has the required hardware to participate in proof-of-coverage challenges, as soon as we allow other hotspots to join the network we have no verifiable way of being able to separate a virtual network from a real one.

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
