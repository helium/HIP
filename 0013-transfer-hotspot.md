# HIP13: Transfer Hotspot

- Start Date: 2020-09-22
- Original HIP PR: [#42](https://github.com/helium/HIP/pull/42)
- Author: [@mrallen1](https://github.com/mrallen1), [@abhay](https://github.com/abhay)
- HIP Number: 13
- Tracking Issue: [#43](https://github.com/helium/HIP/issues/43)
- Status: Deployed ([audit](https://github.com/helium/miner/blob/master/audit/var-48.md) /
  [txn](https://explorer.helium.com/txns/DywtCExrXhTxv8VoDZl_hJDjQ2PUcov_AYrW98ZPpcg))

# Summary

This proposal introduces a new type of transaction to the Helium blockchain called
`transfer_gateway_v1`. This transaction will be an atomic transfer of an onboarded Hotspot / gateway
from one owner to another. This transaction can have an optional amount of HNT associated.

# Motivation

Although new RAK Hotspot Miners coming online and future efforts towards other gateways are
underway, we can enable existing Hotspot owners to redirect coverage resources to hosts who are
willing to provide coverage in underutilized areas.

Over 7000 Hotspots (at the time of writing) have come online since launching the Helium network.
They have been placed in over 1500 cities. Some cities like Modesto, Brooklyn, New York, and San
Francisco have over 250 Hotspots deployed over a relatively small area. Other notable cities like
New Orleans or Knoxville, TN are significantly under covered by existing Hotspots.

# Stakeholders

- Any Helium Hotspot owner who has deployed at least one Hotspot.
- The Helium blockchain engineering team.

# Detailed Explanation

## Implement a new transaction, `transfer_gateway_v1`

This new transaction would require two parties to sign the transaction in order to update the
gateway's owner in the ledger.

### Steps

1. Current owner creates a partially signed transaction with an optional HNT amount that is required
   to complete the transaction.
2. Current owner sends the partially signed transaction to the receiving owner.
3. Recipient signs the transaction and pays the DC fee to submit the transaction to the blockchain.
4. If the receiving account contains sufficient HNT balance as requested by the current owner and
   contains enough HNT to burn into DCs for the transaction, the transaction is accepted and the
   gateway's owner is updated in the ledger.
5. The Hotspot no longer appears in the sender's Hotspot list and now appears in the recipient's
   Hotspot list.

## Implement the transaction in the helium-wallet client

The [Helium Wallet CLI](https://github.com/helium/helium-wallet-rs) currently supports exporting a
partially completed transaction as either a QR code or a Base64-encoded text blob. Either of these
formats would be useful for competing the transaction.

## Implement the transfer UI in the Helium app

Not considered. The Helium blockchain team will implement the transaction and implementation via the
command line client. Future work on integrating this transfer into the Helium mobile app will be
proritized but is out of scope of this HIP.

# Drawbacks

Besides some additional complexity on ownership changing for a Hotspot across blocks, no additional
downside was characterized while developing his proposal.

# Rationale and Alternatives

We believe this approach will enable owners to transfers their Hotspots to other prospective owners.
Other alternatives have been considered including a multi-transaction series which may be too
complex for implementation and maintainence. Ultimately, we're looking to implement a simple
solution that will enable an frequently requested feature.

Other alternatives that were considered including just allowing a Hotspot to be disassociated from
an account. There are a few concerns with this approach which included accounting for rewards
between this action and a future association to another account. It also increases complexity as the
Hotspot would need to have another `add_gateway` transaction issued at a later date rather than a
single swap transaction as described here.

Another limitation that was considered was that the receiving owner would have to have a Helium
wallet before accepting a Hotspot via `transfer_gateway_v1`. Although this increases friction of
transfers, it was deemed not a significant cost give that in some cases, the receipient would need
to pay an amount of HNT as requested by the sender.

# Deployment Impact

We expect that some Helium Hotspots will be transfered to new owners and perhaps may move locations
to provide more favorable coverage.

# Success Metrics

The Helium blockchain team will not be explicitly tracking success metrics for this transaction type
addition but we expect that coverage will be improved in underserved areas as Hotspots become
transferrable.
