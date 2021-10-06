# HIP 40: Validator Denylist

- Author(s): @BFGNeil, @Anthonyra, @ElonTusk
- Start Date: 2021-09-27
- Category: Economic, Technical
- Original HIP PR: https://github.com/helium/HIP/pull/284
- Tracking Issue: https://github.com/helium/HIP/issues/285
- Status: In Discussion

## Summary and Motivation
[motivation]: #motivation

While the situation with regards to Proof-of-Coverage gaming has improved and additional enhancements are intended, we need a backstop prevention mechanism that allows us to quickly allow the network to grow and deal with obvious gaming and spoofing situations as they materialise. 

This plan proposes that *validators* would maintain a denylist of Hotspot addresses.

## Semi-Detailed Implementation Plan
[detailed-explanation]: #detailed-explanation

The Committee 

A new board will be selected under the DEWI banner, name ideas will need to be decided, working title Security Committee

- Committee members are voted on by the community and term lengths will be defined
- Public can vote and the top voted 11 are selected to join
- Each case under review gets assigned to a random 5 people within the committee to investigate.
- The committee has the power to select what lists are used, as well as publish the first list of its kind.
- Because of the appeal process, a whitelist should also be used, so that the appeal process can override external lists.

Analysis

This committee will analyse hotspots, patterns of gaming, and then submit evidence to to committee to discuss and vote on.

There is no golden bullet here with gaming, a multitude of factors go into defining if a hotspot is gaming the system, and so defining what is gaming will always change. We need a trusted, elected committee that is focused on whats best for the network.

Appealing

When this action is decided on by the committee, the information should be made public and a notice period should be given. 

From there hosts can choose to appeal, and submit evidence the committee would need to vote if they accept (super majority).

If a new list has been chosen for use, said list must be published and notified to give hotspot owners chance to appeal.

List Generation / Publishing

- Lists for use are stored in a chain var, with a seperate versioning chain var applied so the list can be updated.

- Lists will automatically be used by validators, with the process being opt-out with a env flag.

- Stored in chain var, the chosen lists can be voted on and updated by the Security Committee, and a version chain var shall be used to update it.

List Usage

- Validators do not have to use the same denylist file, or any denylist at all. Only if all consensus group members both have a denylist and have a matching records for a Hotspot on the denylist would any action be taken. 

- When PoC transactions are submitted to the consensus group, if all consensus group members agree that a given Hotspot address is on the denylist, any transaction from that address will be marked as invalid with a reason of `denylist`

## Open Questions
[unresolved]: #open-questions

Should there be a decay rate to deny's?

how is the list published? (dns vs websites with json/yaml vs chain vars)

## Success Metrics
[success-metrics]: #success-metrics

Success here means that a Hotspot address contained on a majority of validators' denylist have their PoC witness receipts rejected as invalid.

