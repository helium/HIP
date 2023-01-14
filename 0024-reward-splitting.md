# HIP 24: Reward Splitting

- Author(s): @ericmheilman
- Reviewer: @abhay
- Start Date: 2020-12-26
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/104>
- Tracking Issue: <https://github.com/helium/HIP/issues/105>

# Summary

This proposal introduces a new transaction, rewards_split_v1, which would allow a Hotspot's revenue
stream to be split between multiple addresses. This split would be 'stable' as once a revenue stream
is transferred from address A to address B the only way to reverse the transfer would be for B to
voluntarily transfer it back to A. Transfers would range from 1 to 100% and would have an optional
amount of HNT associated.

The sole purpose of this transaction would be to enable rewards splitting on-chain. Reward splitting
would be in no way indicative of Hotspot ownership and legal Hotspot ownership would remain an
off-chain responsibility. The ability to perform transactions such as location assertions and
Hotspot transfers would continue to be exclusively available to the Hotspot owner regardless of how
the Hotspot's revenue stream is split.

# Motivation

The Helium blockchain is currently designed to pay out HNT rewards to a single wallet. This design
can be problematic whenever the work or resources necessary to deploy a Hotspot are provided by
multiple people as the HNT rewards must be split up equitably between several wallets. Many of the
common workarounds for this problem require more trust, time, energy, technical expertise, or
resources than is desirable. The ability to split rewards on-chain would help resolve this issue by
eliminating the need for these workarounds in many use cases.

An additional motivation for this transcation is the added possibility of Hotspot securitization.
Hotspot securitization could offer various benefits to both Hotspot owners ('sellers') and Hotspot
investors ('buyers'). Sellers would be able to access advantages such as lower capital requirements,
reduced deployment risk, and the ability to access various goods and services that would otherwise
be unattainable. Buyers would be able to access advantages such as increased portfolio
diversification, the ability to invest solely in high-value Hotspot placements, and the ability to
mine HNT with relatively little effort.

The following list illustrates some of the use cases this transaction would facilitate.

1. Owners could offer hosts a more favorable reward split as a referral bonus
2. SaaS companies could offer services for as little as 1% of earnings
3. Owners could incentivize hosts to upgrade their Hotspot in exchange for a more favorable reward
   split
4. Manufacturers could offer Hotspots at a discounted rate in exchange for a % stake
5. Co-inhabitants could enter into trust-minimized agreements to split the cost and earnings of a
   Hotspot
6. A large group of people could pool their money for an otherwise cost-prohibitive premium Hotspot
   placement and split the earnings
7. Hotspot owners could sell off a % of their Hotspot in order to raise cash for upgraded /
   additional Hotspot deployments
8. Companies could sell off a bundled % of a fleet's earnings before they are deployed to hedge
   deployment risk
9. Companies could sell of a bundled % of a deployed fleet's earnings to raise cash for more
   Hotspots
10. Hotspot owners could sell off a % of their Hotspot's earnings to hedge against price risk

# Stakeholders

Hotspot owners

Hotspot hosts

Helium investors

Manufacturers

SaaS companies

The Helium blockchain engineering team.

Feedback will be gathered by sharing this HIP in various Discord channels.

# Detailed Explanation

## Implement a new transaction, `rewards_split_v1`

This transaction would necessitate the addition of a new field to the ledger, 'rewards_addresses',
which would be a map of addresses and splits. This transaction would require two parties to sign the
transaction in order to update the gateway's reward split in the ledger.

### Steps

1.  Hotspot owner creates a partially signed transaction with a proposed reward percentage to
    transfer as well as an optional HNT amount that is required to complete the transaction. The
    transaction would perform a validity check of the proposed percentage transfer by ensuring the %
    meets the following criteria

            A. % is an integer

            B. 1 <= % <= 100 (This range would be defined by a chain variable)

            C. % <= the Hotspot owners currently allocated reward %

2.  Hotspot owner sends the partially signed transaction to the reward split receiver

3.  On receipt, the recipient ensures the proposed split is valid by verifying the following
    criteria

        A. The sum of all splits on the ledger would add up to 100 after the transaction

        B. The number of splits on the ledger does not exceed 10 (This limit would be defined by a chain variable)

4.  If valid, recipient signs the transaction and pays the DC fee to submit the transaction to the
    blockchain

5.  If the receiving account contains sufficient HNT balance as requested by the Hotspot owner and
    contains enough HNT to burn into DCs for the transaction, the transaction is accepted and the
    rewards_address field is updated in the ledger

6.  The Hotspot appears in both the sender's Hotspot list and as well as the recipient's Hotspot
    list. The respective Hotspot's rewards_address fields are reflected accordingly

## Implement the transaction in the helium-wallet client

The Helium Wallet CLI currently supports similar transactions that could be built upon for this
implementation.

## Implement the transfer UI in the Helium app

The Helium Blockchain Engineering team will decide if adding this functionality to the Helium app is
necessary.

# Drawbacks

Drawback considerations include potential chain bloat, the added legal complexities associated with
securitization, and the risk of network participants misinterpreting a rewards split as being
determinant in ownership.

# Rationale and Alternatives

The rationale for this change is six-fold.

1. Enable trust-minimized reward splitting of Hotspots
2. Reduce the time, energy, technical expertise and resources necessary to maintain host-owner
   relationships
3. Enable the securitization of Hotspots
4. Allow hosts to see their HNT earnings in real-time within the Helium app
5. Remove DC cost associated with owners regularly paying out HNT to hosts
6. Simplify tax reporting

An alternative design would be to give Hotspot owners the ability to revoke a rewards split at any
time. We believe this to be an inferior design as it would not be trust-minimized.

# Deployment Impact

We believe that many Hotspots will have their rewards split between multiple addresses after this
functionality is deployed. We also believe that this deployed functionality will have a notable
impact on the positive-feedback loop that is driving helium network deployment as it will reduce the
friction associated with establishing relationships between Hotspot owners and Hotspot hosts.

# Success Metrics

This HIP will be considered successful if the following two metrics are reached 1 year after
implementation.

1. A reduction in the average number of data credits burned per Hotspot owning address by at least
   10%
2. At least 5% of the Hotspots in the Helium network have a reward mapping to a Hotspot that is <
   100%
