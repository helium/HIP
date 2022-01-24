# HIP 40: Validator Denylist

- Author(s): @BFGNeil, @Anthonyra, @ElonTusk, @AP
- Start Date: 2021-09-27
- Category: Economic, Technical
- Original HIP PR: https://github.com/helium/HIP/pull/284
- Tracking Issue: https://github.com/helium/HIP/issues/285
- Status: In Discussion

## Summary and Motivation

[motivation]: #motivation

While the situation with regards to Proof-of-Coverage gaming has improved and additional enhancements are intended, we need a backstop prevention mechanism that allows us to quickly allow the network to grow and mitigate obvious gaming and spoofing situations as they materialise.

This plan proposes that _validators_ would deny lists of Hotspot addresses.

## Detailed Implementation Plan

[detailed-explanation]: #detailed-explanation

### The Committee

A new board will be selected under the DeWI banner, working title Proof of Coverage Committee.

- Known community members with demonstrated experience in the following areas, POC mechanisms, Cyber security, Onchain analysis and gateway development, as well as publicly trusted community members to secure openness will be chosen to form the committee and vote on action.
- The committee will produce the first list of its kind to be automatically included with the validator software.

### Validator Usage

This committee will analyse hotspots, patterns of gaming, and then submit evidence to the committee to discuss and vote on.

There is no golden bullet here with gaming, a multitude of factors go into defining if a hotspot is gaming the system, and so defining what is gaming will always change. We need a trusted, elected committee that is focused on what's best for the network.

Data from the analysis will be passed to Helium Inc to provide a feedback mechanism to help improve anti-gaming methods.

### Appealing

When action against a hotspot is decided on by the committee, the information should be made public and a notice period should be given publicly so hotspot owners can appeal.

At this point hosts can submit evidence, and a committee will vote (super majority) to accept or deny this evidence.

### List Generation & Usage

- The Committee will generate a list of hotspot addresses and publish it.

- Validators will use the committee list by default which is set in the config file of the validator. Validators can add other lists here or opt out by removing the default list url.

- Additional lists can be created by the community and validators can choose to opt-in to additional lists.

- Lists are polled and collected regularly allowing quick updates and removals by the committee or from other lists.

- Validators do not have to use the same denylist file, or any denylist at all. Only if all consensus group members both have a denylist and have matching records for a Hotspot on the denylist would any action be taken.

- When any transactions are submitted to the consensus group, if all consensus group members agree that a given Hotspot address is on the denylist, any transaction from that address will be marked as invalid with the reason of `denylist`.

## Open Questions

[unresolved]: #open-questions

- Who will be on the DeWi committee?
- Term lengths of those on the committee?
- How many people are on the committee?
- Public voting / selection of members?

## Success Metrics

[success-metrics]: #success-metrics

Success here means that a Hotspot address contained on a majority of validators' denylist has their transactions rejected as invalid.
