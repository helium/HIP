---
authors:
  - "@madninja"
start-date: 2026-06-02
category: Economic, Technical
original-hip-pr: https://github.com/helium/HIP/pull/1200
tracking-issue: https://github.com/helium/HIP/issues/1201
vote-requirements: veHNT Holders
status: In Discussion
reddit-post-id: 1twsn06
---

# HIP 149: Helium Utility and Emissions Realignment

## Summary

This HIP bundles four governance decisions, executed in a single program upgrade at passage:

1. Mobile data deployers earn HNT pro-rata of rewardable bytes, with a USD floor at 50% of the carrier-paid burn rate Nova sets under [HIP 143][hip-143]. When the floor binds, total per-epoch HNT emission rises; the increase distributes through the standard sub-DAO split and is sized so Mobile data deployers land on the floor.
2. An operations and growth supplement: a per-epoch HNT mint into a Nova-administered Squads multisig vault for a flat-rate window followed by a multi-year linear taper. Total **~141M HNT over 36 months**, about 77% of current on-chain HNT supply (~182.5M), front-loaded (~50% in the first 12 months). Both windows are hardcoded at passage and self-terminate.
3. Retirement of Proof-of-Coverage on both Mobile and IoT. Mobile data deployers earn pro-rata of rewardable bytes; the on-chain Service Provider allocation under [HIPs 82][hip-82]/[87][hip-87] is reframed as a flat Mobile Operations Fund. IoT data transfer continues at the existing $/DC peg.
4. A 7-seat Advisory Council with standing oversight of how the operations and growth supplement is used, with the authority to escalate to a community termination vote.

One veHNT vote approves all four decisions together.

## Motivation

The $0.50/GB target earn rate set in [HIP 53][hip-53] has compressed materially at the Hotspot. Over the past year, network rewardable bytes grew ~4× (from ~24K GB/day in June 2025 to ~97K GB/day in April 2026) while HNT issuance stayed fixed under the [HIP 20][hip-20] schedule and HNT price more than halved.

Three problems follow:

- **Deployer earnings are unanchored to revenue.** Carrier-driven burn enters circulation as DC and permanently leaves on use; the income deployers receive is decoupled from the rate carriers actually pay.
- **Proof-of-Coverage pays for existing rather than for serving subscribers.** The work that grows the network now is offload utility, not coverage proofs.
- **Operations and growth are under-funded.** Carrier expansion, deployer programs, and core engineering are funded on a year-by-year basis with no encoded runway.

This proposal ties deployer earnings to the carrier-paid rate Nova sets under [HIP 143][hip-143], supplements operations and growth on a bounded schedule, retires PoC on both networks, and establishes standing community oversight of the supplement.

## Stakeholders

- **Mobile data deployers.** Gain an immediate +20% uplift on baseline data rewards from the reallocation in Decision 3, plus a USD-anchored floor from Decision 1.
- **IoT data deployers.** Unchanged on the income side ($/DC peg preserved); IoT PoC retires.
- **veHNT holders and delegators.** 6% delegator allocation preserved. Effective HNT max supply rises from ~206M (today's effective ceiling, after cumulative reductions since HIP 20) to ~347M to fund the supplement in Decision 2.
- **Carriers and offload partners.** Continue under the existing [HIP 143][hip-143] commercial framework. The deployer floor follows carrier pricing.

## Detailed Explanation

### Decision 1: Revenue-linked emissions with a Mobile deployer floor

The result first: when the floor defined below binds, the protocol emits more HNT that epoch. The backstop is not a separate deployer-only pool. It raises the epoch's total HNT emission, and the increase distributes through the standard sub-DAO allocation, so every recipient (Mobile data deployers, the Mobile Operations Fund, the delegator pool, the IoT sub-DAO) rises proportionally. The mint is sized so the Mobile data slice lands exactly on the floor.

The floor: Mobile data deployers earn HNT pro-rata of rewardable bytes from the 84% data bucket of Mobile sub-DAO emission (Decision 3). Each epoch, that baseline emission is valued in USD/GB and compared against 50% of the carrier-paid burn rate. When the baseline meets or exceeds the floor, the backstop is zero and deployers earn the pro-rata baseline. When it falls below, the backstop fires.

| Condition | Outcome for Mobile data deployers |
|---|---|
| Baseline ≥ half the carrier-paid rate (USD/GB) | Backstop = 0. Deployer earns baseline. |
| Baseline < half the carrier-paid rate | Backstop emits. Deployer earns half the carrier-paid rate in USD (floor binds). |

The protocol computes the backstop emission each epoch from the published formula:

```
D_target = 0.5 × R_burn × bytes_GB / HNT_price
α        = mobile_percent_share × 0.84
backstop = min(smoothed_hnt_burned, max(0, (D_target − D_baseline) / α))
```

`R_burn` is the carrier-paid burn rate Nova sets under [HIP 143][hip-143]; `bytes_GB` is rewardable bytes in the epoch; `HNT_price` is the HNT/USD price; `D_baseline = (HIP 20 schedule + Net Emissions re-emit) × α`; and `α` is the fraction of total HNT emission that reaches the Mobile data bucket. `mobile_percent_share` is the Mobile sub-DAO's on-chain percent share (a 30-epoch EMA of `mobile_vehnt / (mobile_vehnt + iot_vehnt)`, ~0.89 today, giving `α ≈ 0.75`), read from chain each epoch; it is not a parameter and floats with veHNT delegation, so the floor binds under any Mobile/IoT split.

The division by `α` follows from the distribution described above: only `α` of the backstop lands at Mobile data deployers; the remaining `(1 − α)` flows to the Mobile Operations Fund, the delegator pool, and the IoT sub-DAO at their existing percent shares (see Decision 3).

The `min(smoothed_hnt_burned, …)` cap stops the backstop from emitting more HNT than has recently been burned. `smoothed_hnt_burned` is the existing HIP 20 variable: a 7-epoch moving average of HNT destroyed on-chain, mostly from Nova's burns to mint DC. Over any window, backstop emissions stay below total HNT destruction over the same window, so the backstop never adds to net supply. The backstop is distinct from and additive to the existing HIP 20 net-emissions re-emit, which is already counted in the baseline; combined, the two re-emission paths can exceed destruction by at most the net-emissions cap (~1,644 HNT/epoch), a pre-existing property unchanged by this proposal. The trade-off shows up during sharp HNT price moves: it takes Nova 1–2 weeks of burns at the new price for the moving average to catch up, and during that window the cap binds and the floor delivers less than the full USD target. Once the average catches up, the floor returns to full delivery.

Effective Mobile data deployer earn rate per GB = `max(baseline_$/GB, 0.5 × R_burn)`. Two effects flow through to deployers without a follow-on vote: HNT/USD price increases raise the USD value of pro-rata baseline rewards; carrier-rate increases under [HIP 143][hip-143] raise the floor.

Ahead of the vote on this proposal, Nova will reduce the carrier-paid burn rate from $0.50/GB to ~$0.10/GB under [HIP 143][hip-143]. The reduction reflects current commercial offload rates; [HIP 143][hip-143] is the existing authority for the burn-rate setting and permits further adjustments under Nova's commercial discretion. The floor sits at $0.05/GB (50% × $0.10 carrier-paid burn rate). At current delegations (`α ≈ 0.75`), the Mobile data deployer pool (~15,215 HNT/day after Decision 3's +14pp reallocation) at ~91K GB/day rewardable volume falls below $0.05/GB in USD when HNT drops below ~$0.30. Above that threshold the backstop stays at zero; it activates under HNT downside or carrier-rate uplift.

The floor share (50%) and the 84% Mobile data bucket are hardcoded; changing them requires a community HIP and program upgrade.

IoT data transfer is unaffected by Decision 1 and continues on the existing $/DC peg. The IoT sub-DAO's existing percent share of any Mobile-driven backstop emission flows to the IoT Operations Fund (Decision 3).

### Decision 2: Operations and growth supplement

A per-epoch HNT mint into an operations and growth supplement vault (Nova-administered Squads multisig; recipient address fixed at the program upgrade), with two hardcoded boundary timestamps. Distinct from the on-chain Mobile Operations Fund in Decision 3 (which is a 10% slice of Mobile sub-DAO emission distributed on-chain); the supplement vault is a separate mint stream that does not flow through the sub-DAO allocation.

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
| Cumulative new supply vs current on-chain HNT | ~141M / ~182.5M ≈ 77% of current on-chain HNT supply (issued over 36 months) |
| USD value at HNT $0.60 reference | ~$85M total (~$42M in the first 12 months, ~$42M over the next 24); scales linearly with HNT price |

**Supply impact.** The supplement is a new mint stream, additive to [HIP 20][hip-20]'s halving schedule and not subject to its halvings. [HIP 20][hip-20]'s halving schedule continues unchanged; its named max-supply property is not preserved. HIP 20 projected an asymptotic max of 223M HNT in Nov 2020. Cumulative permanent reductions since (~9.5M L1 post-Y1 reductions plus ~10.3M Solana-era burns above the net_emissions_cap path and via the no_emit wallet, partially offset by HIP 138's ~2.9M supplement above schedule) have shifted the effective ceiling to ~206M today (current on-chain supply ~182.5M plus ~23.6M remaining under the HIP 20 schedule). Effective max HNT supply rises from ~206M to ~347M (= 206M + 141M HIP 149 supplement). The same pattern was used in the audited [HIP 138][hip-138] MOBILE-treasury supplement (~2.9M HNT minted outside HIP 20's schedule from Dec 2024 to Aug 2025); the supplement here is also bounded at deploy.

**Use of funds.** International carrier expansion, deployer programs, engineering (network intelligence and carrier interoperability), ecosystem grants, regulatory work, and core operating costs. The supplement mints to the vault only; it does not flow to on-chain Hotspot rewards.

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

**Backstop flow.** Decision 1's backstop distributes via the standard sub-DAO allocation. At the current ~89/11 Mobile/IoT veHNT split, ~75% reaches Mobile data deployers (the targeted floor uplift); the remaining ~25% routes to the Mobile Operations Fund (~9%), the delegator pool (~6%), and the IoT sub-DAO (~10%) at their existing percent shares. These shares move with veHNT delegation. The IoT sub-DAO's portion flows to the IoT Operations Fund.

### Decision 4: Advisory Council

A 7-seat Advisory Council with standing oversight of how the operations and growth supplement is used across both supplement windows.

**Composition:**

- **5 community-nominated.** Any veHNT holder above a low threshold may nominate themselves or others; each nominee confirmed by veHNT-weighted vote.
- **2 Nova-appointed.** Designated directly by Nova; voting members; Nova responsible for their conduct.

**Authority:** Once seated, the Council has the following authority at any time during either supplement window.

- NDA-level information rights over use of the operations and growth supplement, including insight into carrier revenue negotiations relevant to the [HIP 143][hip-143] burn-rate setting (insight only; [HIP 143][hip-143] authority stays with Nova).
- Standard actions (demand disclosure, publish dissent, recommend course-correction): quorum 4 of 7 seated, including at least 2 community seats.
- Trigger a community vote to terminate the supplement, or to amend its parameters (per-epoch rate, window durations, recipient vault): quorum 5 of 7 seated, including at least 3 community seats. Nova's 2 seats alone cannot trigger or block.
- No unilateral on-chain levers. Halting or amending either supplement window requires a community-voted program upgrade.

**Scope.** Council authority covers the operations and growth supplement: how funds are used, and the parameters governing accrual (per-epoch rate, window durations, recipient vault). Dynamic floor parameters (50% share, the formula) sit outside Council authority; changing them requires a community HIP and program upgrade.

**Compensation.** HNT-denominated, performance-gated. Paid from the Mobile and IoT Operations Funds (not from the supplement). Working amount: ~2,000 HNT/month per member, settled by community vote at first seating.

**Termination or amendment vote (operations and growth supplement; either or both supplement windows):**

- Triggerable by Council escalation or direct community proposal, at any time during either supplement window.
- 7-day voting window.
- Simple majority of votes cast; ≥7% quorum (symmetric with this authorizing vote: same bar to amend or terminate as to authorize).
- 7-day enforcement: on approval, a program upgrade implementing the change is deployed within 7 days. Termination halts subsequent accrual in the active window; amendments take effect from deployment forward.

### Execution sequence

| Milestone | Timing | What happens |
|---|---|---|
| **Pre-vote burn-rate change** | pre-M0 | Nova reduces the carrier-paid burn rate from $0.50/GB to ~$0.10/GB under [HIP 143][hip-143] (existing authority; no governance vote required), reflecting current commercial offload rates. |
| **Passage** | M0 | Program upgrade ships: supplement windows (flat boundary ≈ M0+12mo, taper boundary ≈ M0+36mo), the dynamic floor formula, PoC retirement in verifier oracles, Mobile data reallocation to 84% pro-rata, SP allocation reframed to the 10% Mobile Operations Fund. First-window supplement begins minting. Floor formula is live but dormant at passage conditions. Council nomination opens. |
| **Council seated** | ~M0+49 days | Per-nominee community confirmation vote concludes. Disclosure obligations and escalation pathway operational. |
| **Flat boundary** | ~M0+12 months (hardcoded) | First-window supplement auto-transitions to the tapering window. |
| **Taper boundary** | ~M0+36 months (hardcoded) | Tapering supplement reaches zero and halts. |

### Voting mechanics

- veHNT-weighted, single yes/no on the four-decision bundle. The Council exists to oversee the supplement that funds operations and growth; voting them separately would let one pass without the other.
- Minimum 7-day forum discussion period; 7-day voting window.
- Simple majority of votes cast; ≥7% quorum.

### What this proposal does not change

- [HIP 20][hip-20] halving emission schedule and Net Emissions re-emission mechanism (HIP 20's max-supply projection is raised by HIP 149's supplement; the schedule itself runs unchanged).
- Sub-DAO structure (Mobile and IoT).
- veHNT lockup positions, multipliers, and voting mechanics.
- 6% delegator allocation.
- [HIP 138][hip-138] single-token (HNT) reward model.
- [HIP 143][hip-143] commercial burn-rate decoupling. The deployer floor anchors to the rate Nova sets under [HIP 143][hip-143]; authority over the rate itself stays with Nova.
- [HIP 130][hip-130] data-only Mobile Hotspots.
- $/DC peg for IoT data transfer.

## Drawbacks

- **Dilution.** The supplement in Decision 2 raises effective max HNT supply from ~206M (today's effective ceiling, after cumulative reductions since HIP 20's 2020 projection) to ~347M. The accrual is bounded at deploy and self-terminating.
- **Bundling.** Voters cannot accept some decisions and reject others. The decisions are operationally coupled (the Council oversees the supplement; the floor relies on the same program upgrade as the reallocation), but a voter who supports three of four still has to vote on the bundle.
- **PoC removal ends a reward category.** Some deployments that brought network value primarily through PoC may not be sustained on data utility alone. The proposal accepts this trade in exchange for routing rewards to verifiable utility.
- **Dependence on the carrier-rate setting.** The deployer floor depends on the carrier-paid rate Nova sets under [HIP 143][hip-143]. Council insight rights cover this setting, but the authority remains with Nova as in [HIP 143][hip-143].
- **Floor dips briefly after sharp HNT moves.** The backstop is capped at `smoothed_hnt_burned` so it can't emit more HNT than has been burned recently. After a sharp HNT crash, deployers get a partial floor for 1–2 weeks until Nova's burns at the new price lift the moving average; floor returns to full after. The same cap is what prevents unbounded minting under crash.

## Rationale and Alternatives

**Why a floor tied to the carrier rate rather than a fixed $/GB.** A fixed $/GB number goes stale as HNT price and offload economics change; the original $0.50/GB target no longer reflects actual deployer earnings. Tying the floor to the carrier-paid rate Nova sets under [HIP 143][hip-143] makes deployer earnings track the revenue the network actually generates and routes future carrier-rate improvements directly to deployers.

**Why pro-rata of rewardable bytes for Mobile data.** Pro-rata is splitting-resistant by construction: subdividing a busy site doesn't change total rewards earned from its traffic. Tiered-DAU and per-Hotspot caps were modeled and rejected because they reward subdivision.

**Why retire PoC rather than reduce it further.** [HIP 147][hip-147] already implemented "data eats first" in Sept 2025. With most viable Mobile deployments now reaching carrier offload within weeks, the residual PoC bucket pays for existing rather than for utility. Retiring it is preferable to maintaining a verifier code path that produces near-zero rewards.

**Why encode the supplement rather than seek annual approvals.** Operations and growth funding through year-by-year HIPs creates uncertainty that compromises multi-year hiring, partner commitments, and carrier expansion. Encoding the windows at passage with hardcoded boundaries gives the protocol runway without leaving open-ended issuance authority. The same pattern was used in the audited [HIP 138][hip-138] MOBILE-treasury supplement (2024-2025).

**Why a 7-seat Council rather than a larger body or no body.** A 7-seat Council with 5 community-elected members is large enough that no single appointment swings outcomes and small enough to function as a working body. Without a Council, the supplement accrues without scheduled disclosure.

**Alternatives considered and not adopted:**

- A 60/40 tiered-DAU + data composite for Mobile, rejected because tiered-DAU's diminishing-returns curve creates a splitting incentive.
- A utility-indexed emission curve replacing the [HIP 20][hip-20] schedule, rejected in favor of preserving the halving schedule and layering a USD-anchored floor on top.

## Unresolved Questions

- Council nomination threshold (veHNT minimum) and selection cadence specifics for replacements during a term.
- The exact compensation amount; the working figure of ~2,000 HNT/month per member is to be settled by community vote at first seating.
- Whether to add additional disclosure obligations beyond the quarterly supplement outflow report.

## Deployment Impact

The on-chain changes ship in a single program upgrade at passage. Verifier oracle changes for PoC retirement (Mobile and IoT) are coordinated with that upgrade. We leave the implementation of the program upgrade and verifier oracle changes up to the Helium Core Developers to determine.

This proposal is not backwards compatible in the sense that PoC reward emissions stop after passage. Hotspots earning predominantly through PoC today will see their rewards drop to zero from the PoC bucket and depend on data utility. The +20% Mobile data reallocation and the dynamic floor are the offsetting mechanisms for Mobile; IoT continues at the existing $/DC peg.

HIPs retired by Mobile PoC removal: [74][hip-74], [75][hip-75], [85][hip-85], [105][hip-105], [113][hip-113], [119][hip-119], [131][hip-131], [133][hip-133], [135][hip-135], [147][hip-147].

HIPs retired by IoT PoC removal: [15][hip-15], [17][hip-17], [54][hip-54], [58][hip-58], [83][hip-83], [136][hip-136], [137][hip-137].

HIPs retired under the SP allocation reframe: [82][hip-82] and [87][hip-87].

HIPs partially amended: [10][hip-10] (Mobile $/DC peg replaced by pro-rata of rewardable bytes plus the dynamic floor; IoT $/DC peg preserved), [53][hip-53] ($0.50/GB Mobile target superseded by Decision 1's dynamic floor; Mobile sub-DAO structure preserved), [93][hip-93].

Documentation at <http://docs.helium.com> will need to reflect the retirement of PoC on both networks, the new Mobile allocation, and the dynamic-floor mechanism.

## Success Metrics

- Mobile data deployer earnings (USD per GB) stay at or above the floor in every epoch after Decision 1 goes live.
- Carrier offload traffic on the Mobile network (rewardable GB/day) continues to grow after passage.
- Operations and growth supplement vault outflows are published quarterly by the Council, with material disclosures (carrier expansion commitments, deployer programs, ecosystem grants).
- Council activity: nominee participation, quorum on standard actions, escalation events surfaced for community vote.

[hip-10]: ./0010-usage-based-data-transfer-rewards.md
[hip-15]: ./0015-beaconing-rewards.md
[hip-17]: ./0017-hex-density-based-transmit-reward-scaling.md
[hip-20]: ./0020-hnt-max-supply.md
[hip-53]: ./0053-mobile-dao.md
[hip-54]: ./0054-h3dex-targeting.md
[hip-58]: ./0058-poc-distance-limit.md
[hip-74]: ./0074-mobile-poc-modeled-coverage-rewards.md
[hip-75]: ./0075-mobile-poc-initiate-programmatic-minting-and-updated-emissions-curve.md
[hip-82]: ./0082-helium-mobile-service-provider.md
[hip-83]: ./0083-restore-first-to-witness.md
[hip-85]: ./0085-mobile-hex-coverage-limit.md
[hip-87]: ./0087-proportional-service-provider-rewards.md
[hip-93]: ./0093-addition-of-wifi-aps-to-mobile-subdao.md
[hip-105]: ./0105-modification-of-mobile-subdao-hex-limits.md
[hip-113]: ./0113-reward-cbrs-as-experimental.md
[hip-119]: ./0119-closing-gaming-loopholes-within-the-mobile-network.md
[hip-130]: ./0130-data-only-mobile-hotspots.md
[hip-131]: ./0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md
[hip-133]: ./0133-bridging-gap-for-anti-gaming-measures-phase2.md
[hip-135]: ./0135-transitioning-to-templated-mobile-coverage.md
[hip-136]: ./0136-eliminate-iot-rewards-for-redundant-coverage.md
[hip-137]: ./0137-remove-cn470-from-iot-poc.md
[hip-138]: ./0138-return-to-hnt.md
[hip-143]: ./0143-decoupling-service-provider-pricing-from-governance.md
[hip-147]: ./0147-mobile-data-eats-first.md
