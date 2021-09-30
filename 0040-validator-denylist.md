# HIP 40: Validator Denylist

- Author(s): @BFGNeil, @Anthonyra, @ElonTusk
- Start Date: 2021-09-27
- Category: Economic, Technical
- Original HIP PR: https://github.com/helium/HIP/pull/284
- Tracking Issue: https://github.com/helium/HIP/issues/285
- Status: In Discussion

## Summary and Motivation
[motivation]: #motivation

While the situation with regards to Proof-of-Coverage gaming has improved and additional enhancements are intended, we need a backstop prevention mechanism that allows us to quickly allow the network to grow and deal with obvious gaming and spoofing situations as they materialize. 

This plan proposes that *validators* would maintain a denylist of Hotspot addresses.

## Semi-Detailed Implementation Plan
[detailed-explanation]: #detailed-explanation

Identification

The first thing to note is this is not to catch all gaming. The denylist is to catch the most extreme gamers and not a method to report and block all gaming. For this reason we believe a basic identification query should be run on all hotspots, and select the worse based on a floor function.

This function looks at a hotspots average daily earnings, and if this amount is greater than what an average hotspot earns in a 14 day period, they are selected.

This floor currently selects *18 hotspots*, which can be seen here: https://etl.dewi.org/public/question/54f5138b-b7ec-47c7-9da3-6a8c94ffe0eb

Analysis

Anaysis will be done by an elected committee at dewi, members of this committee should be selected by the community and voted on. they would also need defined term lengths.

This committe will analyise hotspots, patterns of gaming, and then submit evidence to to committee to discuss and vote on.

There is no golden bullet here with gaming, a multitude of factors go into defining if a hotspot is gaming the system, and so defining what is gaming will always change, we need a trusted, elected committee that is focused on whats best for the network.


Appealing

When this action is decided on by the committee, the information should be made public and a notice period should be given. 

From there hosts can choose to appeal, and submit evidence the committee would need to vote if they accept (super majority).

List Generation / Publishing

- A public JSON or YAML file of denylisted Hotspot unique addresses will be included in the *validator* software. This list is meant to be the first of its kind, but not the only one validators could use.

List Usagae

- Validators do not have to use the same denylist file, or any denylist at all. Only if all consensus group members both have a denylist and have a matching records for a Hotspot on the denylist would any action be taken. 

- When PoC transactions are submitted to the consensus group, if all consensus group members agree that a given Hotspot address is on the denylist, any transaction from that address will be marked as invalid with a reason of `denylist`

## Open Questions
[unresolved]: #open-questions

Should there be a decay rate to denys?

how is the list published? (dns vs websites with json/yaml vs chain vars)

## Success Metrics
[success-metrics]: #success-metrics

Success here means that a Hotspot address contained on a majority of validators' denylist have their PoC witness receipts rejected as invalid.
