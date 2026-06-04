# HIP 149: Helium Utility and Emissions Realignment

- Author: [@madninja](https://github.com/madninja)
- Start Date: 2026-06-02
- Category: Economic, Technical
- Original HIP PR: <!-- maintainer will fill in -->
- Tracking Issue: <!-- maintainer will create -->
- Voting Requirement: veHNT Holders

---

## Summary

This HIP bundles four governance decisions, executed in a single program upgrade at passage:

1. Mobile data deployers earn HNT pro-rata of rewardable bytes. A USD-anchored backstop tops up that baseline whenever it falls below 50% of the carrier-paid burn rate Nova sets under [HIP 143][hip-143].
2. An operations and growth capitalization: a per-epoch HNT mint into a Nova-administered Squads multisig vault for a flat-rate window followed by a multi-year linear taper. Total **~141M HNT over 36 months**, about 72% of current circulating HNT supply, front-loaded (~50% in the first 12 months). Both windows are hardcoded at passage and self-terminate.
3. Retirement of Proof-of-Coverage on both Mobile and IoT. Mobile data deployers earn pro-rata of rewardable bytes; the on-chain Service Provider allocation under [HIPs 82][hip-82]/[87][hip-87] is reframed as a flat Mobile Operations Fund. IoT data transfer continues at the existing $/DC peg.
4. A 7-seat Advisory Council with standing oversight of how the operations and growth capitalization is used, with the authority to escalate to a community termination vote.

One veHNT vote approves all four decisions together.

## Motivation

The $0.50/GB target earn rate set in [HIP 53][hip-53] has compressed materially at the Hotspot. Over the past year, network rewardable bytes grew ~4× (from ~24K GB/day in June 2025 to ~97K GB/day in April 2026) while HNT issuance stayed fixed under the [HIP 20][hip-20] schedule and HNT price more than halved.

Three problems follow:

- **Deployer earnings are unanchored to revenue.** Carrier-driven burn enters circulation as DC and permanently leaves on use; the income deployers receive is decoupled from the rate carriers actually pay.
- **Proof-of-Coverage pays for existing rather than for serving subscribers.** The work that grows the network now is offload utility, not coverage proofs.
- **Operations and growth are undercapitalized.** Carrier expansion, deployer programs, and core engineering are funded on a year-by-year basis with no encoded runway.

This proposal ties deployer earnings to the carrier-paid rate Nova sets under [HIP 143][hip-143], capitalizes operations and growth on a bounded schedule, retires PoC on both networks, and establishes standing community oversight of the capitalization.

## Stakeholders

- **Mobile data deployers.** Gain an immediate +20% uplift on baseline data rewards from the reallocation in Decision 3, plus a USD-anchored floor from Decision 1.
- **IoT data deployers.** Unchanged on the income side ($/DC peg preserved); IoT PoC retires.
- **veHNT holders and delegators.** 6% delegator allocation preserved. Effective HNT max supply rises from 223M to ~364M to fund the capitalization in Decision 2.
- **Carriers and offload partners.** Continue under the existing [HIP 143][hip-143] commercial framework. The deployer floor follows carrier pricing.

## Detailed Explanation

### Decision 1: Deployer floor tied to carrier burn

Mobile data deployers earn HNT pro-rata of rewardable bytes from the 84% data bucket of Mobile sub-DAO emission (Decision 3). Each epoch, that baseline emission is valued in USD/GB and compared against a floor of 50% of the carrier-paid burn rate. When the baseline meets or exceeds the floor, the backstop is zero and deployers earn the pro-rata baseline. When it falls below, the protocol emits additional HNT sized to bring deployer earnings up to the floor.

| Condition | Outcome for Mobile data deployers |
|---|---|
| Baseline ≥ half the carrier-paid rate (USD/GB) | Backstop = 0. Deployer earns baseline. |
| Baseline < half the carrier-paid rate | Backstop emits. Deployer earns half the carrier-paid rate in USD (floor binds). |

The protocol computes the backstop emission each epoch from the published formula:

```
backstop = max(0, ((0.5 × R_burn × bytes_GB / HNT_price) - D_baseline) / 0.75)
```

`R_burn` is the carrier-paid burn rate Nova sets under [HIP 143][hip-143]; `bytes_GB` is rewardable bytes in the epoch; `HNT_price` is the HNT/USD price; `D_baseline` is baseline Mobile data deployer emission ((HIP 20 schedule + net emissions re-emit) × Mobile percent share × 84% data bucket). The 0.75 factor accounts for the backstop flowing through the existing sub-DAO allocation (see Decision 3).

Effective Mobile data deployer earn rate per GB = `max(baseline_$/GB, 0.5 × R_burn)`. Two effects flow through to deployers without a follow-on vote: HNT/USD price increases raise the USD value of pro-rata baseline rewards; carrier-rate increases under [HIP 143][hip-143] raise the floor.

Ahead of the vote on this proposal, Nova will reduce the carrier-paid burn rate from $0.50/GB to ~$0.10/GB under [HIP 143][hip-143]. The reduction reflects current commercial offload rates; [HIP 143][hip-143] is the existing authority for the burn-rate setting and permits further adjustments under Nova's commercial discretion. The floor sits at $0.05/GB (50% × $0.10 carrier-paid burn rate). It binds when the Mobile data deployer pool (~15,215 HNT/day after Decision 3's +14pp reallocation) at the current ~91K GB/day rewardable volume falls below $0.05/GB in USD, which happens when HNT drops below ~$0.30. Above that threshold, deployers earn baseline and the backstop stays at zero. The backstop activates under HNT downside or carrier-rate uplift.

The floor share (50%) and the formula itself sit outside any administrative authority. Changing them requires a community HIP and program upgrade.

IoT data transfer is unaffected by Decision 1 and continues on the existing $/DC peg. The IoT sub-DAO's existing percent share of any Mobile-driven backstop emission flows to the IoT Operations Fund (Decision 3).

### Decision 2: Operations and growth capitalization

A per-epoch HNT mint into an operations and growth capitalization vault (Nova-administered Squads multisig; recipient address fixed at the program upgrade), with two hardcoded boundary timestamps. Distinct from the on-chain Mobile Operations Fund in Decision 3 (which is a 10% slice of Mobile sub-DAO emission distributed on-chain); the capitalization vault is a separate mint stream that does not flow through the sub-DAO allocation.

| Parameter | First window (flat) | Second window (taper) |
|---|---|---|
| Per-epoch rate | ~196,000 HNT | 196,000 → 0 (linear decay) |
| Duration | ~360 days (≈12 months) | ~720 days (≈24 months) |
| Total | ~70.6M HNT | ~70.6M HNT |
| Boundary | hardcoded at ~M0+12mo | hardcoded at ~M0+36mo |

Combined accrual: **~141M HNT**, fully bounded at deploy. Both boundaries auto-terminate via hardcoded timestamps; no future vote or manual halt is required to end them.

**Scale.**

| | Value |
|---|---|
| Mint rate during flat window | ~196,000 HNT/day (~9.5× the current ~20,548 HNT/day HIP 20 network emission) |
| Vault share of gross HNT issuance during flat | ~90% (mint + existing emission ≈ 216,500 HNT/day; vault receives ~196,000 of it) |
| Program total | ~141M HNT over 36 months, front-loaded (~50% in the flat first 12 months, ~50% tapering linearly over the next 24) |
| Cumulative new supply vs current circulating | ~141M / ~196M ≈ 72% of current circulating HNT supply (issued over 36 months) |
| USD value at HNT $0.60 reference | ~$85M total (~$42M in the first 12 months, ~$42M over the next 24); scales linearly with HNT price |

**Supply impact.** The capitalization is a new mint stream, additive to [HIP 20][hip-20]'s halving schedule and not subject to its halvings. [HIP 20][hip-20]'s halving schedule continues unchanged; its 223M max-supply property is not preserved. Effective max HNT supply rises to roughly 364M (~196M circulating + ~27M HIP 20 remainder + ~141M capitalization). The same pattern was used in the audited [HIP 138][hip-138] MOBILE-treasury supplement (~2.9M HNT minted outside HIP 20's schedule from Dec 2024 to Aug 2025); the capitalization here is also bounded at deploy.

**Use of funds.** International carrier expansion, deployer programs, engineering (network intelligence and carrier interoperability), ecosystem grants, regulatory work, and core operating costs. The capitalization mints to the vault only; it does not flow to on-chain Hotspot rewards.

**Bound and immutability.** Per-epoch rate, boundary timestamps, and recipient vault address are fixed at the program upgrade; changing any of them requires a new community-voted program upgrade. Vault balance and outflows are observable on-chain in real time.

### Decision 3: PoC retirement on both networks

Removal of Proof-of-Coverage mechanisms from the Mobile and IoT verifier oracles, and reframing of the Mobile Service Provider allocation.

**Mobile sub-DAO allocation (at passage):**

| Bucket | Today | Under this proposal |
|---|---|---|
| Data deployers | ~70%, pro-rata in practice | **84%**, pro-rata of rewardable bytes |
| SP / Operations Fund | up to 24% ([HIP 87][hip-87] data-proportional, capped by [HIP 82][hip-82] plan-price formula) | **10%** flat, Mobile Operations Fund (reuses the SP NFT/entity as bucket holder) |
| veHNT delegators | 6% | 6% (unchanged) |
| PoC bucket | residual under [HIP 147][hip-147] | **0** (retired) |

The Mobile data pool grows from 70% to 84% of sub-DAO emission (+14pp), a ~+20% per-Hotspot uplift on baseline data rewards (84/70 = 1.20).

The on-chain SP role under [HIPs 82][hip-82] and [87][hip-87] ends; the SP NFT/entity is reused as the bucket holder for the flat 10% Mobile Operations Fund. Future carriers onboard as offload carriers under the existing [HIP 143][hip-143] framework, not as on-chain SPs.

**IoT sub-DAO changes:**

- PoC bucket retired.
- IoT data transfer continues at the existing $/DC peg (no change to deployer income mechanism).
- IoT Operations Fund absorbs the former PoC bucket and data-bucket underflow.
- The IoT sub-DAO's existing percent share of any Mobile-driven backstop emission (Decision 1) also flows to the IoT Operations Fund. IoT data deployers are already paid at peg from baseline; this share is not split with them.

**Backstop flow.** Decision 1's backstop flows through the standard sub-DAO allocation. 75% reaches Mobile data deployers; the remaining 25% routes to the Mobile Operations Fund (~9%), the delegator pool (~6%), and the IoT sub-DAO (~10%) at their existing percent shares. The IoT sub-DAO's portion flows to the IoT Operations Fund.

### Decision 4: Advisory Council

A 7-seat Advisory Council with standing oversight of how the operations and growth capitalization is used across both accrual windows.

**Composition:**

- **5 community-nominated.** Any veHNT holder above a low threshold may nominate themselves or others; each nominee confirmed by veHNT-weighted vote.
- **2 Nova-appointed.** Designated directly by Nova; voting members; Nova responsible for their conduct.

**Authority:**

- NDA-level information rights over use of the operations and growth capitalization, including insight into carrier revenue negotiations relevant to the [HIP 143][hip-143] burn-rate setting (insight only; [HIP 143][hip-143] authority stays with Nova).
- Standard actions (demand disclosure, publish dissent, recommend course-correction): quorum 4 of 7 seated, including at least 2 community seats.
- Trigger a community vote to terminate the capitalization accrual: quorum 5 of 7 seated, including at least 3 community seats. Nova's 2 seats alone cannot trigger or block.
- No unilateral on-chain levers. Halting either accrual window requires a community-voted program upgrade.

**Scope.** Council authority covers use of the operations and growth capitalization only. Dynamic floor parameters (50% share, the formula) sit outside Council authority; changing them requires a community HIP and program upgrade.

**Compensation.** HNT-denominated, performance-gated. Paid from the Mobile and IoT Operations Funds (not from the capitalization accrual). Working amount: ~2,000 HNT/month per member, settled by community vote at first seating.

**Termination vote (operations and growth capitalization; either or both accrual windows):**

- Triggerable by Council escalation or direct community proposal.
- 7-day voting window.
- Simple majority of votes cast; ≥7% quorum (symmetric with this authorizing vote: same bar to terminate as to authorize).
- 7-day enforcement: on approval, a program upgrade halting subsequent accrual in the active window is deployed within 7 days.

### Execution sequence

| Milestone | Timing | What happens |
|---|---|---|
| **Pre-vote burn-rate change** | pre-M0 | Nova reduces the carrier-paid burn rate from $0.50/GB to ~$0.10/GB under [HIP 143][hip-143] (existing authority; no governance vote required), reflecting current commercial offload rates. |
| **Passage** | M0 | Program upgrade ships: capitalization windows (flat boundary ≈ M0+12mo, taper boundary ≈ M0+36mo), the dynamic floor formula, PoC retirement in verifier oracles, Mobile data reallocation to 84% pro-rata, SP allocation reframed to the 10% Mobile Operations Fund. First-window capitalization accrual begins. Floor formula is live but dormant at passage conditions. Council nomination opens. |
| **Council seated** | ~M0+49 days | Per-nominee community confirmation vote concludes. Disclosure obligations and escalation pathway operational. |
| **Flat boundary** | ~M0+12 months (hardcoded) | First-window capitalization auto-transitions to the tapering window. |
| **Taper boundary** | ~M0+36 months (hardcoded) | Tapering capitalization reaches zero and halts. |

### Voting mechanics

- veHNT-weighted, single yes/no on the four-decision bundle. The Council exists to oversee the capitalization that funds operations and growth; voting them separately would let one pass without the other.
- Minimum 7-day forum discussion period; 7-day voting window.
- Simple majority of votes cast; ≥7% quorum.

### What this proposal does not change

- [HIP 20][hip-20] halving emission schedule and Net Emissions re-emission mechanism (the 223M max-supply property is the only HIP 20 element affected; the schedule itself runs unchanged).
- Sub-DAO structure (Mobile and IoT).
- veHNT lockup positions, multipliers, and voting mechanics.
- 6% delegator allocation.
- [HIP 138][hip-138] single-token (HNT) reward model.
- [HIP 143][hip-143] commercial burn-rate decoupling. The deployer floor anchors to the rate Nova sets under [HIP 143][hip-143]; authority over the rate itself stays with Nova.
- [HIP 130][hip-130] data-only Mobile Hotspots.
- $/DC peg for IoT data transfer.

## Drawbacks

- **Dilution.** The capitalization in Decision 2 raises effective max HNT supply from 223M to ~364M. The accrual is bounded at deploy and self-terminating.
- **Bundling.** Voters cannot accept some decisions and reject others. The decisions are operationally coupled (the Council oversees the capitalization; the floor relies on the same program upgrade as the reallocation), but a voter who supports three of four still has to vote on the bundle.
- **PoC removal ends a reward category.** Some deployments that brought network value primarily through PoC may not be sustained on data utility alone. The proposal accepts this trade in exchange for routing rewards to verifiable utility.
- **Dependence on the carrier-rate setting.** The deployer floor depends on the carrier-paid rate Nova sets under [HIP 143][hip-143]. Council insight rights cover this setting, but the authority remains with Nova as in [HIP 143][hip-143].

## Rationale and Alternatives

**Why a floor tied to the carrier rate rather than a fixed $/GB.** A fixed $/GB number goes stale as HNT price and offload economics change; the original $0.50/GB target no longer reflects actual deployer earnings. Tying the floor to the carrier-paid rate Nova sets under [HIP 143][hip-143] makes deployer earnings track the revenue the network actually generates and routes future carrier-rate improvements directly to deployers.

**Why pro-rata of rewardable bytes for Mobile data.** Pro-rata is splitting-resistant by construction: subdividing a busy site doesn't change total rewards earned from its traffic. Tiered-DAU and per-Hotspot caps were modeled and rejected because they reward subdivision.

**Why retire PoC rather than reduce it further.** [HIP 147][hip-147] already implemented "data eats first" in Sept 2025. With most viable Mobile deployments now reaching carrier offload within weeks, the residual PoC bucket pays for existing rather than for utility. Retiring it is preferable to maintaining a verifier code path that produces near-zero rewards.

**Why encode capitalization rather than seek annual approvals.** Operations and growth funding through year-by-year HIPs creates uncertainty that compromises multi-year hiring, partner commitments, and carrier expansion. Encoding the windows at passage with hardcoded boundaries gives the protocol runway without leaving open-ended issuance authority. The same pattern was used in the audited [HIP 138][hip-138] MOBILE-treasury supplement (2024-2025).

**Why a 7-seat Council rather than a larger body or no body.** A 7-seat Council with 5 community-elected members is large enough that no single appointment swings outcomes and small enough to function as a working body. Without a Council, the capitalization accrues without scheduled disclosure.

**Alternatives considered and not adopted:**

- A 60/40 tiered-DAU + data composite for Mobile, rejected because tiered-DAU's diminishing-returns curve creates a splitting incentive.
- A utility-indexed emission curve replacing the [HIP 20][hip-20] schedule, rejected in favor of preserving the halving schedule and layering a USD-anchored floor on top.

## Unresolved Questions

- Council nomination threshold (veHNT minimum) and selection cadence specifics for replacements during a term.
- The exact compensation amount; the working figure of ~2,000 HNT/month per member is to be settled by community vote at first seating.
- Whether to add additional disclosure obligations beyond the quarterly capitalization outflow report.

## Deployment Impact

The on-chain changes ship in a single program upgrade at passage. Verifier oracle changes for PoC retirement (Mobile and IoT) are coordinated with that upgrade. We leave the implementation of the program upgrade and verifier oracle changes up to the Helium Core Developers to determine.

This proposal is not backwards compatible in the sense that PoC reward emissions stop after passage. Hotspots earning predominantly through PoC today will see their rewards drop to zero from the PoC bucket and depend on data utility. The +20% Mobile data reallocation and the dynamic floor are the offsetting mechanisms for Mobile; IoT continues at the existing $/DC peg.

HIPs retired by Mobile PoC removal: [74][hip-74], [75][hip-75], [85][hip-85], [101][hip-101], [105][hip-105], [107][hip-107], [111][hip-111], [113][hip-113], [118][hip-118], [119][hip-119], [131][hip-131], [132][hip-132], [133][hip-133], [135][hip-135], [147][hip-147].

HIPs retired by IoT PoC removal: [15][hip-15], [17][hip-17], [21][hip-21], [42][hip-42], [44][hip-44], [50][hip-50], [54][hip-54], [57][hip-57], [58][hip-58], [61][hip-61], [62][hip-62], [66][hip-66], [72][hip-72], [83][hip-83], [94][hip-94], [127][hip-127], [136][hip-136], [137][hip-137].

HIPs retired under the SP allocation reframe: [82][hip-82] and [87][hip-87]. [HIP 93][hip-93] is partially amended.

Documentation at <http://docs.helium.com> will need to reflect the retirement of PoC on both networks, the new Mobile allocation, and the dynamic-floor mechanism.

## Success Metrics

- Mobile data deployer earnings (USD per GB) stay at or above the floor in every epoch after Decision 1 goes live.
- Carrier offload traffic on the Mobile network (rewardable GB/day) continues to grow after passage.
- Operations and growth capitalization vault outflows are published quarterly by the Council, with material disclosures (carrier expansion commitments, deployer programs, ecosystem grants).
- Council activity: nominee participation, quorum on standard actions, escalation events surfaced for community vote.

[hip-15]: ./0015-beaconing-rewards.md
[hip-17]: ./0017-hex-density-based-transmit-reward-scaling.md
[hip-20]: ./0020-hnt-max-supply.md
[hip-21]: ./0021-poc-link-layer.md
[hip-42]: ./0042-beacon-witness-ratio-witness-reward-limit.md
[hip-44]: ./0044-witness-decay.md
[hip-50]: ./0050-display-all-potential-beacon-witnesses.md
[hip-53]: ./0053-mobile-dao.md
[hip-54]: ./0054-h3dex-targeting.md
[hip-57]: ./0057-poc-rewards-establishment-period.md
[hip-58]: ./0058-poc-distance-limit.md
[hip-61]: ./0061-increase-challenger-rewards.md
[hip-62]: ./0062-poc-witness-ip-check.md
[hip-66]: ./0066-trust-score-and-denylist-convenience.md
[hip-72]: ./0072-secure-concentrators.md
[hip-74]: ./0074-mobile-poc-modeled-coverage-rewards.md
[hip-75]: ./0075-mobile-poc-initiate-programmatic-minting-and-updated-emissions-curve.md
[hip-82]: ./0082-helium-mobile-service-provider.md
[hip-83]: ./0083-restore-first-to-witness.md
[hip-85]: ./0085-mobile-hex-coverage-limit.md
[hip-87]: ./0087-proportional-service-provider-rewards.md
[hip-93]: ./0093-addition-of-wifi-aps-to-mobile-subdao.md
[hip-94]: ./0094-response-time-windows-for-witness-rewarding.md
[hip-101]: ./0101-equalizing-poc-rewards-across-wifi-and-cbrs.md
[hip-105]: ./0105-modification-of-mobile-subdao-hex-limits.md
[hip-107]: ./0107-preventing-gaming-within-the-mobile-network.md
[hip-111]: ./0111-mobile-data-utility-benchmark.md
[hip-113]: ./0113-reward-cbrs-as-experimental.md
[hip-118]: ./0118-verification-mapping.md
[hip-119]: ./0119-closing-gaming-loopholes-within-the-mobile-network.md
[hip-127]: ./0127-dynamic-iot-poc.md
[hip-130]: ./0130-data-only-mobile-hotspots.md
[hip-131]: ./0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md
[hip-132]: ./0132-scaling-mobile-mappers.md
[hip-133]: ./0133-bridging-gap-for-anti-gaming-measures-phase2.md
[hip-135]: ./0135-transitioning-to-templated-mobile-coverage.md
[hip-136]: ./0136-eliminate-iot-rewards-for-redundant-coverage.md
[hip-137]: ./0137-remove-cn470-from-iot-poc.md
[hip-138]: ./0138-return-to-hnt.md
[hip-143]: ./0143-decoupling-service-provider-pricing-from-governance.md
[hip-147]: ./0147-mobile-data-eats-first.md
