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

This plan proposes that *validators* would maintain a denylist file of Hotspot addresses.

## Semi-Detailed Implementation Plan
[detailed-explanation]: #detailed-explanation

[Identification]: #Identification

The first thing to note is this is not to catch all gaming. The denylist is to catch the most extreme gamers and not a method to report and block all gaming. For this reason we believe a basic identification query should be run on all hotspots, and select the worse based on a floor function.

This function looks at a hotspots average daily earnings, and if this amount is greater than what an average hotspot earns in a 14 day period, they are selected.

Hotspots selected by this floor can be seen here: https://etl.dewi.org/public/question/54f5138b-b7ec-47c7-9da3-6a8c94ffe0eb

[analysis-of-results]: #Analysis


[appeal-period] #Appealing


[list-generation]: #List Generation / Publishing

- A public JSON or YAML file of denylisted Hotspot unique addresses will be included in the *validator* software. This list is meant to be the first of its kind, but not the only one validators could use.

[list-usage]: #List Usagae

- Validators do not have to use the same denylist file, or any denylist at all. Only if all consensus group members both have a denylist and have a matching records for a Hotspot on the denylist would any action be taken. 

[invalidating-transactions]: #Invalidating Transactions

- When PoC transactions are submitted to the consensus group, if all consensus group members agree that a given Hotspot address is on the denylist, any transaction from that address will be marked as invalid with a reason of `denylist`

## Open Questions
[unresolved]: #open-questions

TTLs, implementation of list fetching (dns vs websites with json/yaml vs chain vars, etc.

## Success Metrics
[success-metrics]: #success-metrics

Success here means that a Hotspot address contained on a majority of validators' denylist have their PoC witness receipts rejected as invalid.
