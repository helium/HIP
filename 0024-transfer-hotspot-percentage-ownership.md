# HIP Template

- Author(s): @ericmheilman
- Start Date: 2020-12-26
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

This proposal introduces a new transaction, transfer_gateway_v2, which will
allow a hotspot owner to transfer a percentage of hotspot ownership to another
address. Percentage of hotspot ownership will be determinant in the payout of
HNT rewards (50% ownership -> 50% of HNT, 10% ownership -> 10% of HNT, etc.).
Similarly to transfer_gateway_v1, this transaction can have an optional amount of HNT associated.

# Motivation
[motivation]: #motivation

There are various repetitive tasks associated with the host-owner relationship
that make the relationship more time and energy consuming than necessary. For example,
owners have to calculate payouts for each of their hosts and pay out each host
manually. Likewise, hosts have to cross-reference hotspot earnings tracker platforms
with their payments in order to ensure they are getting fair payouts. Hosts must also
reference earnings tracker platforms in order to ensure their hotspots are online and
functioning properly.

This new transaction would automate these tasks by allowing HNT earnings to automatically
be routed to their intended addresses, as opposed to being manually rerouted at set intervals
by hotspot owners.

This automation would benefit the Helium network as it would facilitate less cumbersome
host-owner relationships.


# Stakeholders
[stakeholders]: #stakeholders

Current and future participants in host-owner relationships.

The Helium blockchain engineering team.

Feedback will be gathered by sharing this HIP in various Discord channels.


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Implement a new transaction, `transfer_gateway_v2`

This new transaction would require two parties to sign the transaction in order to
update the gateway's ownership percentages in the ledger.

### Steps

1. Current owner creates a partially signed transaction with a proposed ownership
percentage as well as an optional HNT amount that is required to complete the transaction.

2. Current owner sends the partially signed transaction to the receiving owner.

3. Recipient signs the transaction and pays the DC fee to submit the transaction to the blockchain.

4. If the receiving account contains sufficient HNT balance as requested by the current
owner and contains enough HNT to burn into DCs for the transaction, the transaction
is accepted and the gateway's owner is updated in the ledger.

5. The hotspot appears in both the sender's hotspot list and as well as the recipient's
hotspot list. The respective hotspot ownership percentages are reflected accordingly.

## Implement the transaction in the helium-wallet client

The [Helium Wallet CLI](https://github.com/helium/helium-wallet-rs) currently supports exporting a partially completed transaction as either a QR code or a Base64-encoded text blob. Either of these formats would be useful for competing the transaction.

## Implement the transfer UI in the Helium app

Not considered. The Helium blockchain team will implement the transaction and implementation via the command line client. Future work on integrating this transfer into the Helium mobile app will be prioritized but is out of scope of this HIP.


# Drawbacks
[drawbacks]: #drawbacks

The only drawback consideration that has been raised so far is chain bloat.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Rationale

The rationale for this change is six-fold.

1. Save time for participants of host-owner relationships
2. Give users a sense of legitimate ownership which will encourage further
investment and use in the network over time
3. Remove the hard-cap of how many hotspots an owner can deploy to hosts. Right
now, if a host only has time to perform 'x' payments, the host can only deploy
'x' hotspots
4. Remove the need for hosts to trust owners and hotspot earnings tracker platforms
5. Allow users to see their HNT earnings in real-time
6. Remove the need for hotspot earnings tracker platforms

An alternative design would be to allow owners to allocate a percentage of HNT earnings from a
hotspot to a different address. We believe this to be the inferior option as it does not
provide hosts with a sense of legitimate ownership of their hotspot.


# Deployment Impact
[deployment-impact]: #deployment-impact

We believe that many helium hotspots will have a percentage of their ownership
transferred after this functionality is deployed. We also believe that this deployed
functionality will have a notable impact on the positive-feedback loop that is driving
helium network deployment, as it will reduce the friction associated with establishing
relationships between hotspot owners and hotspot hosts.



# Success Metrics
[success-metrics]: #success-metrics

The Helium blockchain team will not be explicitly tracking success metrics for this
transaction type addition but we expect that host-owner relationships will proliferate
as they are now simpler to maintain for both parties.
