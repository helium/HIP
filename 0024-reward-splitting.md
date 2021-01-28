# HIP 24: Reward Splitting

- Author(s): @ericmheilman
- Reviewer: @abhay
- Start Date: 2020-12-26
- Category: Technical
- Original HIP PR: https://github.com/helium/HIP/pull/104
- Tracking Issue: https://github.com/helium/HIP/issues/105

# Summary
[summary]: #summary

This proposal introduces a new transaction, rewards_split_v1, which would allow a hotspot's
revenue stream to be split between multiple addresses. This split would be 'stable' as once 
a percentage of a revenue stream is transferred from address A to address B, the only way to
reverse the transfer would be for B to voluntarily transfer it back to A. Transfers would 
range from 1 to 100% and would have an optional amount of HNT associated.

This transaction would solely be about rewards splitting on-chain. Reward splitting would be 
in no way indicative of hotspot ownership and legal hotspot ownership would remain an off-chain
responsibility. The ability to perform actions such as location assertions and hotspot transfers 
would continue to beexclusively available to the hotspot owner regardless of how the hotspot's rewards are split.


# Motivation
[motivation]: #motivation

The goal of The People's Network is to create a telecom network that is owned by the people
that operate it. This new transaction would facilitate that goal by allowing network participants 
to enter into trust minimized revenue split agreements. These agreements would take the current 
decentralized nature of the network one step further by allowing the revenue stream of network nodes 
to be split between network participants as necessary. This would catalyze the growth of the Helium 
Network by reducing the need for trust in host-owner relationships as well as by automating various 
repetitive tasks that are currently necessary to maintain host-owner relationships.

This transaction would also catalyze network growth by enabling increased network investment by means 
of hotspot securitization. Hotspot owners would be able to sell a percentage of their hotspot to 
investors in order to raise cash to either upgrade their current hotspot or to purchase an additional 
hotspot. In a similar fashion, an owner with 100 hotspots that are yet to be deployed could sell a bundled
percentage of their fleet in order to hedge their deployment risk.


# Stakeholders
[stakeholders]: #stakeholders

Current and future participants in host-owner relationships.

The Helium blockchain engineering team.

Feedback will be gathered by sharing this HIP in various Discord channels.


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Implement a new transaction, `rewards_split_v1`

This new transaction would require two parties to sign the transaction in order to
update the gateway's ownership percentages in the ledger. The only way to reverse
a transfer will be for the new owner to transfer the ownership percentage back to the
original address.

### Steps

1. Current owner creates a partially signed transaction with a proposed ownership
percentage as well as an optional HNT amount that is required to complete the transaction

2. Current owner sends the partially signed transaction to the receiving owner

3. Recipient signs the transaction and pays the DC fee to submit the transaction to the blockchain

4. If the receiving account contains sufficient HNT balance as requested by the current
owner and contains enough HNT to burn into DCs for the transaction, the transaction
is accepted and the gateway's owner is updated in the ledger

5. The hotspot appears in both the sender's hotspot list and as well as the recipient's
hotspot list. The respective hotspot ownership percentages are reflected accordingly

## Implement the transaction in the helium-wallet client

The Helium Wallet CLI currently supports similar transactions that could be built upon for this implementation.

## Implement the transfer UI in the Helium app

The Helium Blockchain Engineering team will decide if adding this functionality to the Helium app is necessary.




# Drawbacks
[drawbacks]: #drawbacks

The only drawback consideration that has been raised so far is chain bloat.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives


The rationale for this change is six-fold.

1. Enable trust minimized co-ownership of hotspots
2. Reduce the time and energy necessary to maintain host-owner relationships
3. Enable the securitization of hotspots
4. Allow hosts to see their hotspot and HNT earnings in real-time within the Helium app
5. Remove DC cost associated with owners regularly paying out HNT to hosts
6. Simplify tax reporting

An alternative design would be to allow owners to allocate a percentage of HNT earnings from a
hotspot to a different address. We believe this to be an inferior / unrelated option as the owner 
could revoke the allocation at any time.


# Deployment Impact
[deployment-impact]: #deployment-impact

We believe that many helium hotspots will have a percentage of their ownership
transferred after this functionality is deployed. We also believe that this deployed
functionality will have a notable impact on the positive-feedback loop that is driving
helium network deployment as it will reduce the friction associated with establishing
relationships between hotspot owners and hotspot hosts.



# Success Metrics
[success-metrics]: #success-metrics

The Helium blockchain team will not be explicitly tracking success metrics for this
transaction type addition but we expect that host-owner relationships will proliferate
as they are now simpler to maintain for both parties.
