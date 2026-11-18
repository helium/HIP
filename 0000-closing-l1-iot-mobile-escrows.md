---
authors:
  - "@madninja"
start-date: 2026-11-13
category: Economic, Technical
original-hip-pr:
tracking-issue:
vote-requirements: veHNT Holders
status: Draft
---

# Closing the L1 Migration, IOT and MOBILE Escrows

## Summary

[HIP-138][hip-138] ended IOT and MOBILE emissions and left their treasuries open for redemption with no end date. The September 2026 loss showed the risk of keeping these accounts open indefinitely. This HIP pays unclaimed IOT and MOBILE rewards in HNT, delivers unclaimed L1 balances to their owners, and closes the IOT and MOBILE treasuries nine months after deployment, reversing HIP-138's open-ended redemption. Until then, rewards escrows hold only a working balance.

## Motivation

This proposal covers three kinds of protocol accounts that hold significant value and that earlier HIPs left open with no end date:

- **L1 migration escrow.** Holds the L1 balances moved to Solana under [HIP-70][hip-70] that owners have not claimed. Claims have no deadline; as of September 18, 2026, about 216,000 wallets had not claimed.
- **Rewards escrows.** Hold Hotspot rewards in HNT, IOT and MOBILE until claimed. [HIP-138][hip-138] ended IOT and MOBILE emissions, but unclaimed rewards can still be claimed with no end date.
- **Treasuries (swap escrows).** Hold the HNT that IOT and MOBILE holders redeem their tokens for at a fixed rate, mostly through Jupiter. [HIP-138][hip-138] left redemption open with no end date.

Balances on November 14, 2026, with IOT and MOBILE also shown at their treasury value:

| Account | Holds | HNT value |
|---|---|---|
| L1 migration escrow | 1.87M HNT, 229.4M IOT, 202.2M MOBILE, 321.8M DC | 1.93M HNT plus DC |
| HNT rewards escrow | 987k HNT | 987k HNT |
| IOT rewards escrow | 6.97B IOT | 1.06M HNT |
| MOBILE rewards escrow | 16.3M MOBILE | 2k HNT |
| IOT treasury | 2.24M HNT | 2.24M HNT |
| MOBILE treasury | 5.28M HNT | 5.28M HNT |

Each needs programs, oracles and services to keep running with no end date.

On September 14, 2026, a single wallet took funds worth about 580,000 HNT from the three rewards escrows (the September 2026 loss). The MOBILE rewards escrow can no longer pay all outstanding MOBILE rewards, and buying IOT or MOBILE to refill the escrows would move their price.

**Why close the treasuries.** [HIP-138][hip-138] was presented with redemption running indefinitely, and this proposal reverses that. In the September 2026 loss, the IOT and MOBILE taken were redeemed for HNT at the treasuries. The treasuries turn any stolen IOT or MOBILE, from protocol accounts, wallets or exchanges, into HNT, and they hold 7.5M HNT behind programs that must stay maintained and upgradeable for as long as redemption is open. With no new emissions the treasuries shrink, but they do not empty while unredeemed tokens remain, so that exposure has no end date. A fixed close with nine months' notice lets every holder redeem at the same rate and ends it.

## Stakeholders

- Hotspot owners with unclaimed IOT or MOBILE rewards, who receive HNT instead.
- IOT and MOBILE holders, who can redeem until the treasuries close.
- Holders of unclaimed L1 balances, who receive their balance without claiming.
- veHNT holders, who vote on this proposal.
- Nova Labs, which funds any shortfall in rewards caused by the September 2026 loss and the SOL needed to deliver L1 balances.

Feedback is collected on this HIP's pull request and in the Helium community Discord.

## Detailed Explanation

We propose to:

1. Move rewards escrow balances above a working balance to a reserve multisig, with signers separate from the multisig that operates the programs. The reserve tops up the escrows as rewards are claimed, and its address is published. The L1 migration escrow is held the same way, and is topped up ahead of each delivery batch.
2. End IOT and MOBILE reward claims 30 days after deployment (T1), and convert unclaimed IOT and MOBILE rewards to HNT at the treasury rate, claimable through the existing HNT claim.
3. Redeem the IOT and MOBILE held in the rewards escrows at the treasuries to fund the converted rewards.
4. Close the IOT and MOBILE treasuries nine months after deployment (T2), with the date set on chain at deployment.
5. Deliver unclaimed L1 balances worth at least 1 HNT directly to their owners' Solana wallets, then close the migration program at T2.

### Rewards Conversion

The treasury rate is the HNT held by a treasury divided by the token's supply, and it does not change as others redeem. On November 14, 2026, it was 0.000151 HNT per IOT and 0.000134 HNT per MOBILE. Each Hotspot owner receives what they would have received by claiming and redeeming, and the per-Hotspot amounts are published before claims open.

Converted rewards not claimed by T2 expire. Ordinary HNT rewards do not expire.

### Shortfall

As of November 14, 2026, after redeeming the escrowed IOT and MOBILE, the HNT rewards pool would cover about 78% of all outstanding rewards. Nova Labs adds HNT to the reserve whenever claims would exceed the pool, up to the September 2026 loss of about 580,000 HNT. The full amount is reached only if nearly all outstanding rewards are claimed before T2.

### Treasuries

Treasuries work as today until T2, including the daily redemption limit of 20% of each treasury's balance; a larger redemption is spread over several days.

The treasuries stay open until T2 without other changes: redemption is the only way HNT leaves a treasury, no new IOT or MOBILE can be minted, and treasury settings cannot change except for the closing date this proposal sets. These limits bound the exposure during the notice period; closing the treasuries ends it. Converting the protocol's own IOT, about 47% of IOT supply on November 14, 2026, also removes the largest balance that could be taken and redeemed.

veIOT and veMOBILE positions were unlocked under [HIP-141][hip-141]. As of November 14, 2026, 120M IOT and 79M MOBILE remain in them and can be withdrawn and redeemed before T2.

### L1 Migration

As of September 18, 2026, most unclaimed L1 balances could not be claimed because the escrow lacks the SOL needed to create accounts. Delivering every balance worth at least 1 HNT, counting IOT and MOBILE at the treasury rate, reaches about 71,000 wallets and 99.5% of the unclaimed value, and needs about 312 SOL, which Nova Labs provides. The list of balances is published before delivery starts, and delivery completes at least 60 days before T2 so delivered IOT and MOBILE can still be redeemed. Balances below the threshold, about $4,200 in total at September 18, 2026 prices, can still be claimed until T2.

### After T2

- IOT and MOBILE can be held and traded but not redeemed. Remaining treasury HNT is burned, as [HIP-138][hip-138] does with unallocated emissions.
- Unclaimed converted rewards expire, and the HNT held for them is burned. Other HNT rewards remain claimable.
- The migration program and service close, and undelivered L1 balances are burned.

## Drawbacks

- Closing the treasuries reverses [HIP-138][hip-138]'s provision that holders may redeem at any time. Holders have nine months' notice.
- MOBILE has at times traded above its treasury rate; converted MOBILE rewards are paid at the treasury rate.
- Wallets will show unclaimed IOT and MOBILE rewards drop to zero at T1 while HNT rewards rise.

## Rationale and Alternatives

The parts depend on each other: converted rewards are funded by redeeming at the treasuries before they close, and delivered L1 balances must arrive while they can still be redeemed.

- **Keep the treasuries open indefinitely.** Preserves [HIP-138][hip-138]'s provision, but keeps programs and integrations running with no end date.
- **Buy IOT and MOBILE to refill the escrows.** Moves the market price.
- **Fund the shortfall from treasury HNT left after T2.** The amount is unknown until T2, while claims begin at T1.
- **Move unclaimed L1 balances to a community fund.** Transfers balances that belong to identifiable holders.

## Unresolved Questions

- Signers and threshold of the reserve multisig.

## Deployment Impact

We leave the implementation to the Helium Core Developers. Program changes are audited before deployment. HNT claims, wallets and apps work as today, and IOT and MOBILE holders redeem through the same wallets and aggregators until T2.

## Success Metrics

- Each rewards escrow holds no more than its working balance within 60 days of deployment.
- Converted rewards are claimable at T1, and no HNT claim fails for lack of funds before T2.
- L1 delivery completes at least 60 days before T2.
- Treasury redemptions stop at T2.

[hip-70]: ./0070-scaling-helium.md
[hip-138]: ./0138-return-to-hnt.md
[hip-141]: ./0141-single-token-governance-and-release-proposals.md
