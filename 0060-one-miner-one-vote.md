# HIP-60 : One Miner, One Vote

- Author(s): @cvolkernick
- Start Date: 2022-04-28
- Category: Governance
- Original HIP PR: https://github.com/helium/HIP/pull/395
- Tracking Issue: TODO
- Status: In Discussion

# Summary
[summary]: #summary

Currently HIP votes are conducted via wallet signatures at heliumvote.com; this proposal suggests further improvement
by allowing/constraining a given wallet's voting power to equal the total number of hotspots (unique b58 addresses) in said wallet.


# Motivation
[motivation]: #motivation

There is a need to further constrain the HIP voting process such that influence in vote cannot be "bought" by simply holding large ballances
in wallets.

# Stakeholders
[stakeholders]: #stakeholders

All hotspot owners [and potentially validators depending on general consesnsus to be determined by discussion within the community].

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Ideally voting should at a minimum use a 1:1 correlation between participant stake in the network (i.e. each hotspot purchased / onboarded).

HIP votes originated as extremely limited scope straw polls, typically conducted and voted upon by the most active of community members
via Discord. This was extremely limited in scope of awareness, and obviously lacked any "official" process, or really any way to verify the
legitimacy of each vote.

The voting mechanism has since been improved greatly in awareness and security of vote simply by implementing a
public voting location and messaging through official, vastly more visible channels when and where these votes occur -- along with relevant
context resources explaining each vote and its implications.

Using private key signatures to cast votes is also a step up in loosely connecting
partication in the network via some unique identifier (wallet address / DC burn), however there is no cost to create additional wallets and the
DC burn required to cast a vote with each wallet is relatively trivial.

Tying voting power to number on onboarded hotspots on the wallet voting provides a fair and logical basis and "stake" in the vote, which mirrors
the voting party's stake in the network (one could argue validators could/should be included here, however it may also be argued that their "stakes"
are governed separately by consensus protocol).

# Drawbacks
[drawbacks]: #drawbacks

Larger private fleets will inherently have larger weight in votes (debatably how it should be -- emphasis on "debatably").

# Deployment Impact
[deployment-impact]: #deployment-impact

Voting mechnism should not fundamentally change in terms of how one goes about voting. The key distinction is that the hotspot count on each
voting wallet is what is taken into consideration for vote weight as opposed to simply allowing any wallet(s) to burn DC to cast votes.

# Success Metrics
[success-metrics]: #success-metrics

With successful implementation it should be possible to audit any given HIP vote and see that votes are proportionate to wallets' number of 
eligible onboarded hotspots. It should possibly (in lieu of privacy concerns or other controversey arising in the discussion of the proposal)
also be possible to see how wallet(s) and/or hotspot(s) voted on a given HIP.
