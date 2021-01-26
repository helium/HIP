# HIP 24: Transfer Percentage of Hotspot

- Author(s): @ericmheilman
- Start Date: 2020-12-26
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

This proposal introduces a new transaction, transfer_gateway_v2, which would allow a hotspot 
owner to transfer a percentage share (1% -> 100%) of a hotspot's earnings to another owner. This transfer
would be considered 'lasting' as once a percentage share is transferred, the only way to reverse it 
would be for the new owner to voluntarily transfer it back to the original owner. Percentage share would be directly 
determinant in the payout of HNT rewards (50% ownership -> 50% of HNT, 10% ownership -> 10% of HNT, etc.). 

This transaction is solely about rewards splitting on-chain and how people figure out hotspot ownership 
is an off-chain responsibility. Percentage share would be 'non-voting' as the ability to assert 
location would still be available exclusively to the original owner and would still be subject to the 
current hotspot transfer process. This transaction would have an optional amount of HNT associated.


# Motivation
[motivation]: #motivation

The goal of The People's Network is to create a telecom network that is rewards the people
that operate it. This new transaction facilitates that goal by allowing network participants 
to enter into trust minimized revenue share agreements. These agreements will take the current 
decentralized nature of the network one step further by allowing the earnings of network nodes 
to be broken down into smaller pieces that can be transferred between network participants as 
necessary. This will catalyze the growth of the Helium Network by reducing the need for trust 
in host-owner relationships as well as by automating various repetitive tasks that are currently 
necessary to maintain host-owner relationships.

An additional motivation for this functionality is the fact that this enables the securitization 
of hotspots. For instance, an owner could sell a percentage of their hotspot in order to 
raise cash to purchase an additional hotspot. In a similar fashion, an owner with 100 hotspots 
could auction off a bundled percentage share of their fleet on a market place for profit 
share in order to buy and deploy more hotspots. This will benefit the Helium Network as it 
will encourage further investment in network infrastructure.


# Stakeholders
[stakeholders]: #stakeholders

Current and future participants in host-owner relationships.

The Helium blockchain engineering team.

Feedback will be gathered by sharing this HIP in various Discord channels.


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

This change will necessitate the addition of new field to the ledger that is a map of 
wallet account and percentage ownership. It must add up to 100 or the remaining percentage 
will go to the owner field.

## Implement a new transaction, `transfer_gateway_v2`

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
