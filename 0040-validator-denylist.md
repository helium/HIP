# Validator Denylist

- Author(s): @BFGNeil, @Anthonyra, @ElonTusk
- Start Date: 2021-09-27
- State: Proposed
- Original HIP PR: https://github.com/BFGNeil/HIP/blob/master/0040-validator-denylist.md
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary and Motivation
[motivation]: #motivation

While the situation with regards to Proof-of-Coverage gaming has improved and additional enhancements are intended, we need a backstop prevention mechanism that allows us to quickly allow the network to grow and deal with obvious gaming and spoofing situations as they materialize. 

This plan proposes that *validators* would maintain a denylist file of Hotspot addresses which are selected from a basic floor function, selecting the hotspots where earnings are abnormal, and then this is likey followed up with more metrics (see unresolved questions)

This proposal has two consensus mechanisms:

1. how Hotspots are added or removed from the denylist
2. whether validators choose to adopt the community denylist

## Semi-Detailed Implementation Plan
[detailed-explanation]: #detailed-explanation

- A public JSON or YAML file of denylisted Hotspot unique addresses will be included in the *validator* software

- When PoC transactions are submitted to the consensus group, if a super majority (66.6%) of consensus group members agree that a given Hotspot address is on the denylist, any witness receipts from that address will be marked as invalid with a reason of `denylist`

- Only witness receipts are affected by the denylist. Hotspots on the denylist can still transmit and be witnessed by others, and be rewarded for that activity. This also allows Hotspots to justify being removed from the denylist in the future

- Validators do not have to use the community denylist file, or any denylist at all. Only if a super majority (66.6%) of consensus group members both have a denylist and have common Hotspots on the denylist would any action be taken. This puts consensus decision making in the hands of a) the entity that approves/denies pull requests to the community denylist, and b) validators who choose whether to adopt the denylist

- A pattern with quite a few of these extreme earners is that they have no listen address, because of this we feel its best to also deny them from chalengee rewards.

- To prevent the abuse this reporting system there needs to be minimum set of requirements that need to be met before a case can be considered for investigation. The first suggested minimum requirement is around the amount of HNT the accused miner is being rewarded in a 24 hour period. If this amount is greater than the average HNT rewarded to a hotspot in a 24hr period times 7 days it can be flagged as suspicious.

- Hotspots selected by this floor can be seen here: https://etl.dewi.org/public/question/54f5138b-b7ec-47c7-9da3-6a8c94ffe0eb

- Community members will be able to submit pull requests against this file to remove addresses from the list with some explanation for the request. A chosen party will review (who exactly is unanswered)

## Open Questions
[unresolved]: #open-questions

- Who decides which denylist PR's to accept or reject?

- What other methods if any, should be applied to this basic floor to help define it more?

- How often is the deny list updated?

- When on the denylist does a hotspot still count as interactive for HIP17 calculations?


## Success Metrics
[success-metrics]: #success-metrics

Success here means that a Hotspot address contained on a majority of validators' denylist have their PoC witness receipts rejected as invalid.
