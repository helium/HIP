- Start Date: 02/19/2020
- HIP PR:
- Tracking Issue:

# Summary

[summary]: #summary

A comprehensive set of improvements to Proof-of-Coverage, the scoring system, how Hotspots join the network, and
participate in mining and the HBBFT consensus group.

# Motivation

[motivation]: #motivation

On the Helium network today, only Hotspot hardware purchased from Helium Inc. is considered trustworthy. These Hotspots
are sold using a hardware key storage device (a secure element) that makes it reasonably challenging for an attacker to
create a virtual network of Hotspots that have valid keys. The downside of this situation is that the tens of thousands
of non-Helium Inc. LoRa gateways that exist in the world cannot join the network and participate in mining.

The goal of this proposal is to propose a set of measures that make it safe for LoRa gateways of unknown origin to
participate in Proofs-of-Coverage and earn tokens for that participation. This goal poses some interesting challenges,
as in the current system the network loses the ability to verifiably prove that any sub-network created by such new
gateways truly exists since it's possible for dishonest actors to fake geographic locations and radio activitity.

# Stakeholders

[stakeholders]: #stakeholders

- 3rd party Hotspot manufacturers
- DIY miners

# Problem Definition

[problem-definition]: #problem-definition

There are a number of problems we hope to address with this proposal:

1. Allow non-Helium Inc manufactured Hotspots to participate in Proof-of-Coverage and mining
2. Provide a way for non-radio hardware to participate in consensus groups
3. Increase the requirements for consensus group participation to improve the overall health of the network
4. Introduce a number of penalties for failing to perform any of the roles required for earning HNT

# Allowing non-Helium Inc manufactured Hotspots to participate in Proof-of-Coverage

[non-helium-hotspots]: #non-helium-hotspots

## The problem

Consider the below network where Hotspots A through F are of unknown origin, with the lines representing reported RF
connectivity between hotspots.

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

Since it is possible for RF data to be fabricated - there is no way to verify that data was sent via RF once it has been
demodulated - the network does not know whether these Hotspots are part of a virtual network, or whether they are
physically deployed at their claimed locations.

To correctly identify whether the above network is legitimate, we can introduce a Helium Inc (or authorized 3rd party
reseller) 'trusted' Hotspot into the network and learn more about the behavior of the Hotspots A-F. Only real Hotspots
will be able to successfully participate in PoC challenges involving the trusted Hotspot.

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

With this information, we can verify that A, B, D and E can successfully complete PoC challenges which involve X. Since
we know that Hotspot X is trustworthy, we can conclude that any Hotspot which can participate in a PoC challenge
involving X can only do so if it's operating within the rules set by the consensus mechanism and also has an operating
radio chip.

However, even with this scheme we still need a way to allow Hotspots not manufactured by Helium Inc or authorized
manufacturers to not only participate in PoC but also be candidates for consensus membership.

To counter that and allow any hotspot to participate in PoC and have consensus membership candidacy, we propose to
introduce "Levels of Trust".

## Current Network Behavior

In the current network, onboarding a Helium Inc manufactured Hotspot grants full Proof-of-Coverage priviledges.

As mentioned in the problem defintion, we cannot assume that every single DIY hotspot is going to incorporate a GPS chip
or a radio chip. Malicious enttities may try to game the system by tweaking/removing hardware and yet be able to
participate in PoC. Currently we _know_ that every single hotspot being added to the network is manufactured by helium
and has the required hardware to participate in proof-of-coverage challenges, as soon as we allow other hotspots to join
the network we have no verifiable way of being able to separate a virtual network from a real one.

To mitigate that, we propose a new model for establishing trust among hotspots and subsequently change how hotspots earn
HNT, named "Levels of Trust".

## Levels of Trust

Below is a visual representation of the aforementioned Levels, the most important takeaway here is that any higher Level
encompasses all the benefits and constraints of the lower Levels (with a few exceptions).

                                                        +-----------------------------+
                                                        |                             |
                                                  +---->+          Level 3A           +----+
                                                  |     |    (Organic Challenger)     |    |
    +--------------+       +---------------+      |     |                             |    |      +-----------------------+
    |              |       |               |      |     +-----------------------------+    |      |                       |
    |   Level 1    +------>+   Level 2     +------+                                        +----->+        Level 4        |
    |  (Observer)  |       | (Participant) |      |                                        |      | (Consensus Candidate) |
    |              |       |               |      |     +----------------------------+     |      |                       |
    +---------+----+       +---------------+      |     |                            |     |      +-----------------------+
              |                                   |     |          Level 3B          |     |
              |                                   +---->+   (Governance Challenger)  +-----+
              |                                         |                            |
              |                                         +-----------------+----------+
              |                                                           ^
              |                                                           |
              +-----------------------------------------------------------+

Before we get into the details and constraints of each level, we need to set some common ground:

- Every hotspot joining the network starts at the first level.
- Every successive level is granted the priviledges of all previous levels.
- Organic network growth allows hotspots to get to level 3A. In order to reach level 4, the owner must stake HNT.
- There is a path to get to level 3B from level 1 via on-chain governance mechanism (TBD).

### Level I: Network Observer

- Every hotspot which joins the helium network starts at Level 1 by issuing an `add_gateway` transaction.
- The entry fee is set to burning data credits worth $10 USD.
- A hotspot at Level 1 does not have any location asserted on the network, however, it is allowed to witness nearby PoC
  challenges. This is to ensure that when the hotspot does assert a location via `assert_location` transaction, we can
  be confident about its claim of location by analyzing its witness list.
- A hotspot at Level 1 is allowed to transmit data and earn HNT based only on transmitting network data.

### Level 2: Network Participant

- A hotspot must satisfy the below minimum criteria to enter Level 2:
  - It must be a Level 1 hotspot for X number of blocks.
  - Issue an `assert_location` transaction by incurring a $40 USD data credit burn fee.
  - Witness sufficient number of PoC challenges involving Level 3 and above hotspots.
- A hotspot at Level 2 gains access to participate in PoC challenges (become a member in the PoC path).

### Level 3: Network Challenger

Level 3 is divided into two broad categories:

#### Level 3A: Organic Network Challenger

- A hotspot must satisfy the below minimum criteria to enter Level 3A:
  - It must be a Level 2 hotspot for X number of blocks.
  - Successfully participate in X number of PoC challenges involving other Level 3 and above hotspots.
  - A successful challenge comprises of the hotspot being able to receive a PoC packet from a Level 3 hotspot,
    successfully decrypt it and successfully transmit it to a Level 2 or above hotspot.
- A hotspot at Level 3A gains access to construct PoC challenges.

#### Level 3B: Governance Network Challenger

- A hotspot must satisfy the below minimum criteria to enter Level 3B:
  - It must be a Level 1 hotspot for X number of blocks.
  - It must be voted in via the on-chain governance mechanism (TBD) wherein either Helium (or an authorized 3rd party)
    countersigns the `assert_location` transaction on the hotspot owner's behalf.
- A hotspot at Level 3B gains access to construct PoC challenges.

### Level 4: Consensus Candidates

- A hotspot must satisfy the below minimum criteria to enter Level 4:
  - It must be a Level 3 hotspot for X number of blocks.
  - The hotspot owner or another miner in the network must stake 10000 HNT in order to claim Level 4 status for the
    hotspot.
- A hotspot at Level 4 gains access to consensus membership candidacy.

## Level Demotion

With the exception of Level 3B and Level 4 hotspots, any hotspot belonging to other levels is susceptible to level
demotion governed by the hotspot's score.

### Level 4 to Level 3A

TBD

### Level 3A to Level 2

A hotspot operating at Level 3A may get demoted to Level 2 and lose challenger priviledges if its score continually
drops below a chain-var configured threshold for X number of blocks.

### Level 2 to Level 1

- A hotspot operating at Level 2 may get demoted to Level 1 and lose challenging priviledges if its score continually
  drops below a chain-var configured threshold for X number of blocks.

- Once this happens, the hotspot would lose its asserted location via an `unassert_location` transaction and would go
  back to observer mode.

- The hotspot owner must issue an `assert_location` and incur the onboarding fee to get back onto the network and
  qualify for Level 2 and above organic network growth.

# Drawbacks

[drawbacks]: #drawbacks

TBD

# Rationale and Alternatives

[alternatives]: #rationale-and-alternatives

TBD

# Unresolved Questions

[unresolved]: #unresolved-questions

1. Under what conditions do we remove the stake for Level 4 hotspots?
2. Where does the removed stake go to? Does it just vanish?
3. How do we actually remove the stake?

# Deployment Impact

[deployment-impact]: #deployment-impact

1. We need to ensure we transition the existing hotspots on the network in a meaningful way. Whether every single existing
   hotspot goes into the same level or not is yet to be determined.

2. We would also need to determine which hotspots qualify for Level 4 access as we need an initial pool of consensus
   members candidates which would continue to miner the blocks once this HIP goes live in production.

# Success Metrics

[success-metrics]: #success-metrics

NA
