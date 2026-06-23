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

This HIP bundles four governance decisions, executed in a single program upgrade that ships once the Council is seated:

1. Mobile data deployers earn HNT based on the data they deliver, held within a band tied to the per-GB offload price Nova sets under [HIP 143][hip-143]: a target minimum, in dollars, of half that price, and a cap at twice it. The HNT that funds the minimum is capped at HNT recently burned, so the target on its own does not grow net HNT supply; earnings above the cap (when HNT appreciates faster than carrier revenue) are redirected to veHNT stakers and do not change supply. The Decision 2 supplement is separate, and it does raise the supply ceiling.
2. An operations and growth supplement: a per-epoch HNT mint into a Nova-administered Squads multisig vault for a flat-rate window followed by a multi-year linear taper. Total **~141M HNT over 36 months**, about 77% of current on-chain HNT supply (~182.5M), front-loaded (~50% in the first 12 months). Both windows are hardcoded at deploy and self-terminate.
3. Retirement of Proof-of-Coverage on both Mobile and IoT. Mobile data deployers earn pro-rata of rewardable bytes; the on-chain Service Provider allocation under [HIPs 82][hip-82]/[87][hip-87] is reframed as a flat Mobile Operations Fund. IoT data transfer continues at the existing $/DC peg.
4. A 7-seat Advisory Council with standing oversight of how the operations and growth supplement is used, with the authority to escalate to a community termination vote.

One veHNT vote approves all four decisions together.

## Motivation

The $0.50/GB target earn rate set in [HIP 53][hip-53] has compressed materially at the Hotspot. Over the past year, network rewardable bytes grew ~4× (from ~24K GB/day in June 2025 to ~97K GB/day in April 2026) while HNT issuance stayed fixed under the [HIP 20][hip-20] schedule and HNT price more than halved.

Three problems follow:

- **Deployer earnings are unanchored to revenue.** Carrier-driven burn enters circulation as DC and permanently leaves on use; the income deployers receive is decoupled from the rate carriers actually pay.
- **Proof-of-Coverage pays for existing rather than for serving subscribers.** The work that grows the network now is offload utility, not coverage proofs.
- **Operations and growth are under-funded.** Carrier expansion, deployer programs, and core engineering are funded on a year-by-year basis with no encoded runway.

This proposal ties deployer earnings to the payer rate Nova sets under [HIP 143][hip-143], supplements operations and growth on a bounded schedule, retires PoC on both networks, and establishes standing community oversight of the supplement.

## Stakeholders

- **Mobile data deployers.** Gain two-sided participation from Decision 1: downside protection from the target minimum (binding at current HNT prices), and upside participation as HNT appreciates, since rewards are HNT-denominated, up to twice the payer rate. Above that the surplus is shared with stakers. Plus a modest uplift from the Decision 3 reallocation (data bucket 70% → 74%).
- **IoT data deployers.** Unchanged on the income side ($/DC peg preserved); IoT PoC retires.
- **veHNT holders and delegators.** 6% delegator allocation preserved, plus any Mobile data earnings above the Decision 1 cap. Effective HNT max supply rises from ~206M (today's effective ceiling, after cumulative reductions since HIP 20) to ~347M to fund the supplement in Decision 2.
- **Carriers and offload partners.** Continue under the existing [HIP 143][hip-143] commercial framework. The deployer target follows the payer rate.

## Detailed Explanation

### Decision 1: Revenue-linked emissions with a target minimum for Mobile deployers

What deployers get: earnings that move with the network in both directions. Proof-of-Coverage is already retired by consensus; in its place, deployers earn from the data they deliver, tied to the per-GB offload price Nova sets under [HIP 143][hip-143] (the dollar amount the network charges carriers per GB). On the downside, a target minimum holds deployers at no less than half that price per GB: if HNT falls, the protocol mints extra HNT that epoch to keep them at the floor. On the upside, deployers share in HNT's appreciation, because rewards are paid pro-rata in HNT and their dollar value rises with the token, all the way up to twice the payer rate. The old $/DC peg gave neither; it paid a fixed dollar rate regardless of where HNT traded. Now that network metrics reveal the true utility each deployment delivers, the deployments carrying real traffic share in the upside the token provides. Past twice the payer rate, where deployers would be earning more than double what carriers pay for the data, the surplus flows to veHNT stakers. Deployers, stakers, and the network each gain.

Where the HNT comes from: the top-up is capped at the HNT recently burned, mostly Nova burning HNT to create the Data Credits carriers spend on offload. The protocol never mints more than was just burned, so this target on its own does not grow the net HNT supply. Decision 2's supplement is separate, and it does raise the supply ceiling.

The top-up is shared, not deployer-only: it is added to the epoch's total emissions and split across all reward pools by the usual percentages, the same as every other HNT emission. It is sized so Mobile data deployers land on the target after that split; the other pools (the Mobile Operations Fund, delegators, and the IoT sub-DAO) rise proportionally as a side effect.

The target minimum is what the protocol aims to deliver, not a hard guarantee every epoch. After a sharp drop in the HNT price, the amount delivered can fall short for 1 to 2 weeks, until the burn average catches up. In normal conditions deployers receive the full target.

![Figure 1: the top-up needed to reach the target stays under the HNT burned that day at any HNT price, so it never adds to net supply; only the HNT count scales.](files/0149/decision-1-affordable-at-any-price.png)

![Figure 2: after an HNT price drop, the amount delivered to deployers dips below the target for 1 to 2 weeks, then returns to the target as the burn average catches up.](files/0149/decision-1-shortfall-and-recovery.png)

| Condition | Outcome for Mobile data deployers |
|---|---|
| Baseline between half and twice the payer rate (USD/GB) | Top-up = 0, no redirect. Deployer earns baseline. |
| Baseline < half the payer rate | Total daily emissions increase, staying below the burn bound. Deployer earns half the payer rate in USD (target minimum binds). |
| Baseline < half the payer rate, and the required increase exceeds recent burns | Total daily emissions increase, bounded at `smoothed_hnt_burned`. Deployer earns below the target until the burn average catches up. |
| Baseline > twice the payer rate | Deployer earns twice the payer rate in USD (earnings cap binds); the excess HNT goes to veHNT stakers. Total daily emissions unchanged. |

The protocol computes the top-up (floor) and the overflow (cap) each epoch from the published formula:

```
D_target = 0.5 × R_payer × bytes_GB / HNT_price
D_cap    = 2.0 × R_payer × bytes_GB / HNT_price
α        = mobile_percent_share × 0.74
top_up          = min(smoothed_hnt_burned, max(0, (D_target − D_baseline) / α))
staker_overflow = max(0, deployer_pool − D_cap)
```

`R_payer` is the per-GB offload price Nova sets under [HIP 143][hip-143] (what the network charges carriers per GB); `bytes_GB` is rewardable bytes in the epoch (the GB that qualify for rewards); `HNT_price` is the HNT/USD price; `D_baseline = (HIP 20 schedule + Net Emissions re-emit) × α`; and `α` is the fraction of total HNT emission that reaches the Mobile data bucket. `mobile_percent_share` is the Mobile sub-DAO's on-chain percent share (a 30-epoch EMA of `mobile_vehnt / (mobile_vehnt + iot_vehnt)`, ~0.89 today, giving `α ≈ 0.66`), read from chain each epoch; it is not a parameter and floats with veHNT delegation, so the target binds under any Mobile/IoT split.

The division by `α` follows from the distribution described above: only `α` of the top-up lands at Mobile data deployers; the remaining `(1 − α)` flows to the Mobile Operations Fund, the delegator pool, and the IoT sub-DAO at their existing percent shares (see Decision 3).

The cap is simpler than the top-up. `deployer_pool` is the Mobile data bucket itself, so the overflow above `D_cap` is moved directly from that bucket to the delegator pool with no `α` division (the top-up needs the division only because it sizes a DAO-level mint that then splits across buckets). The overflow is neither minted nor burned: total emission that epoch is unchanged, and the HNT is paid to veHNT delegators (claimed DAO-wide pro-rata of total veHNT) instead of deployers, so the cap is net-supply-neutral. The floor and the cap never bind in the same epoch, since the floor sits at a quarter of the cap. On-chain, the redirect rides the existing reward fields: the Mobile sub-DAO's reward-issuance step mints the overflow to the delegator pool rather than the rewards escrow, and the verifier oracle sizes the Mobile data pool as the escrow remainder after the flat Operations Fund cut, so no new account or schema is required.

The `min(smoothed_hnt_burned, …)` cap stops the top-up from emitting more HNT than has recently been burned. `smoothed_hnt_burned` is the existing HIP 20 variable: a 7-epoch moving average of HNT destroyed on-chain, mostly from Nova's burns to mint DC. Over any window, the top-up stays below total HNT destruction over the same window, so the top-up never adds to net supply. The top-up is distinct from and additive to the existing HIP 20 net-emissions re-emit, which is already counted in the baseline; combined, the two re-emission paths can exceed destruction by at most the net-emissions cap (~1,644 HNT/epoch), a pre-existing property unchanged by this proposal. The trade-off shows up during sharp HNT price moves: it takes Nova 1–2 weeks of burns at the new price for the moving average to catch up, and during that window the cap binds and delivery falls short of the full target. Once the average catches up, delivery returns to the full target.

Effective Mobile data deployer earn rate per GB = `clamp(baseline_$/GB, 0.5 × R_payer, 2.0 × R_payer)`, the floor subject to the burn bound. Two effects flow through to deployers without a follow-on vote: HNT/USD price increases raise the USD value of pro-rata baseline rewards, up to the cap at twice the payer rate, above which the excess goes to stakers; payer-rate increases under [HIP 143][hip-143] raise both the floor and the cap.

Before the vote, and separately from this proposal, Nova reduces the payer rate from $0.50/GB to ~$0.10/GB under [HIP 143][hip-143] (its existing authority), reflecting current commercial offload rates, with further adjustments permitted under Nova's commercial discretion. The floor and cap follow from that rate: $0.05/GB (50% × $0.10) and $0.20/GB (200% × $0.10).

Where deployers land depends on the HNT price. At current delegations (`α ≈ 0.66`), ~91K GB/day rewardable volume, and the ~14,660 HNT/day Mobile data deployer baseline (HIP 20 schedule + Net Emissions re-emit pass-through, after Decision 3's +4pp reallocation), the baseline equals the $0.05/GB floor near an HNT price of $0.31 and the $0.20/GB cap near $1.24. HNT trades below the floor threshold today (~$0.27), so the target minimum is already binding and is the protection that matters now; the cap is a guard against sustained appreciation, several times above the current price. The floor also activates under a payer-rate uplift; the cap also activates under a payer-rate cut.

The target share (50%), the cap (200%), and the 74% Mobile data bucket are hardcoded; changing them requires a community HIP and program upgrade.

IoT data transfer is unaffected by Decision 1 and continues on the existing $/DC peg. The IoT sub-DAO's existing percent share of any Mobile-driven top-up flows to the IoT Operations Fund (Decision 3).

### Decision 2: Operations and growth supplement

A per-epoch HNT mint into an operations and growth supplement vault (Nova-administered Squads multisig; recipient address fixed at the program upgrade), with two hardcoded boundary timestamps. Distinct from the on-chain Mobile Operations Fund in Decision 3 (which is a 20% slice of Mobile sub-DAO emission distributed on-chain); the supplement vault is a separate mint stream that does not flow through the sub-DAO allocation.

| Parameter | First window (flat) | Second window (taper) |
|---|---|---|
| Per-epoch rate | ~196,000 HNT | 196,000 → 0 (linear decay) |
| Duration | ~360 days (≈12 months) | ~720 days (≈24 months) |
| Total | ~70.6M HNT | ~70.6M HNT |
| Boundary | hardcoded at ~mint start +12mo | hardcoded at ~mint start +36mo |

Combined accrual: **~141M HNT**, fully bounded at deploy. Both boundaries auto-terminate via hardcoded timestamps; no future vote or manual halt is required to end them.

**Scale.**

| | Value |
|---|---|
| Mint rate during flat window | ~196,000 HNT/day (~9.5× the current ~20,548 HNT/day HIP 20 network emission) |
| Vault share of gross HNT issuance during flat | ~90% (mint + existing emission ≈ 216,500 HNT/day; vault receives ~196,000 of it) |
| Program total | ~141M HNT over 36 months, front-loaded (~50% in the flat first 12 months, ~50% tapering linearly over the next 24) |
| Cumulative new supply vs current on-chain HNT | ~141M / ~182.5M ≈ 77% of current on-chain HNT supply (issued over 36 months) |
| USD value at HNT $0.30 reference | ~$42M total (~$21M in the first 12 months, ~$21M over the next 24); illustrative, scales linearly with HNT price |

USD figures in this proposal are illustrative at a ~$0.30 HNT reference and scale linearly with price; the binding commitments are HNT-denominated.

**Supply impact.** The supplement is a new mint stream, additive to [HIP 20][hip-20]'s halving schedule and not subject to its halvings. [HIP 20][hip-20]'s halving schedule continues unchanged; its named max-supply property is not preserved. HIP 20 projected an asymptotic max of 223M HNT in Nov 2020. Cumulative permanent reductions since (~9.5M L1 post-Y1 reductions plus ~10.3M Solana-era burns above the net_emissions_cap path and via the no_emit wallet, partially offset by HIP 138's ~2.9M supplement above schedule) have shifted the effective ceiling to ~206M today (current on-chain supply ~182.5M plus ~23.6M remaining under the HIP 20 schedule). Effective max HNT supply rises from ~206M to ~347M (= 206M + 141M HIP 149 supplement). The same pattern was used in the audited [HIP 138][hip-138] MOBILE-treasury supplement (~2.9M HNT minted outside HIP 20's schedule from Dec 2024 to Aug 2025); the supplement here is also bounded at deploy.

**Use of funds.** International carrier expansion, deployer programs, engineering (network intelligence and carrier interoperability), ecosystem grants, regulatory work, and core operating costs. The supplement mints to the vault only; it does not flow to on-chain Hotspot rewards. Council compensation (Decision 4) is paid from this vault as a separate ~1% charge, not one of the operating uses above.

**Bound and immutability.** Per-epoch rate, boundary timestamps, and recipient vault address are fixed at the program upgrade; changing any of them requires a new community-voted program upgrade. Vault balance and outflows are observable on-chain in real time.

### Decision 3: PoC retirement on both networks

Removal of Proof-of-Coverage mechanisms from the Mobile and IoT verifier oracles, and reframing of the Mobile Service Provider allocation.

**Mobile sub-DAO allocation (at the program upgrade):**

| Bucket | Today | Under this proposal |
|---|---|---|
| Data deployers | ~70%, pro-rata in practice | **74%**, pro-rata of rewardable bytes |
| SP / Operations Fund | up to 24% ([HIP 87][hip-87] data-proportional, capped by [HIP 82][hip-82] plan-price formula) | **20%** flat, Mobile Operations Fund (reuses the SP NFT/entity as bucket holder) |
| veHNT delegators | 6% | 6% (unchanged) |
| PoC bucket | residual under [HIP 147][hip-147] | **0** (retired) |

The Mobile data pool moves from 70% to 74% of sub-DAO emission (+4pp). The reallocation is a modest absolute lift; the deployer value comes from Decision 1's target minimum and earnings cap, which at current HNT prices is the binding support.

The on-chain SP role under [HIPs 82][hip-82] and [87][hip-87] ends; the SP NFT/entity is reused as the bucket holder for the flat 20% Mobile Operations Fund. The 20% level covers the cost of operating and growing Mobile network infrastructure and keeps Nova, which administers the fund, aligned with network success, at a level comparable to the up-to-24% Service Provider allocation it replaces. Future carriers onboard as offload carriers under the existing [HIP 143][hip-143] framework, not as on-chain SPs.

**IoT sub-DAO changes:**

- PoC bucket retired.
- IoT data transfer continues at the existing $/DC peg (no change to deployer income mechanism).
- IoT Operations Fund absorbs the former PoC bucket and data-bucket underflow.
- The IoT sub-DAO's existing percent share of any Mobile-driven top-up (Decision 1) also flows to the IoT Operations Fund. IoT data deployers are already paid at peg from baseline; this share is not split with them.

**Top-up flow.** Decision 1's top-up distributes via the standard sub-DAO allocation. At the current ~89/11 Mobile/IoT veHNT split, ~66% reaches Mobile data deployers (the targeted uplift); the remaining ~34% routes to the Mobile Operations Fund (~18%), the delegator pool (~6%), and the IoT sub-DAO (~10%) at their existing percent shares. These shares move with veHNT delegation. The IoT sub-DAO's portion flows to the IoT Operations Fund.

### Decision 4: Advisory Council

A 7-seat Advisory Council with standing oversight of how the operations and growth supplement is used across both supplement windows. Its members are charged to act independently and in the best interest of the community. The Council exists for the life of the supplement and dissolves when the taper window ends.

**Composition:**

- **5 community-nominated.** Any veHNT holder above a low threshold may nominate themselves or others; each nominee confirmed by veHNT-weighted vote.
- **2 Nova-appointed.** Designated directly by Nova; voting members; Nova responsible for their conduct, and may replace them at any time at its discretion. They serve unpaid: compensation is paid only to the five community-nominated seats.

**Authority:** Once seated, the Council has the following authority at any time, including the pre-mint review window and both supplement windows.

- NDA-level information rights over use of the operations and growth supplement, including insight into carrier revenue negotiations relevant to the [HIP 143][hip-143] payer-rate setting (insight only; [HIP 143][hip-143] authority stays with Nova).
- Standard actions (demand disclosure, publish dissent, recommend course-correction): quorum 4 of 7 seated, including at least 2 community seats.
- Trigger a community vote to terminate the supplement, or to amend its parameters (per-epoch rate, window durations, recipient vault, Council compensation): quorum 5 of 7 seated, including at least 3 community seats. Nova's 2 seats alone cannot trigger or block.
- Council votes require 5 days' written notice to all seven seats, waivable only by unanimous consent. An absent seat that received notice does not block quorum.
- No unilateral on-chain levers. Halting or amending either supplement window requires a community-voted program upgrade. The Council drafts that upgrade proposal itself rather than leaving a vacuum; the community retains the final vote.

**Scope.** Council authority over the supplement is oversight, not control. It covers whether spending conforms to the use-of-funds purposes defined in Decision 2, and the parameters governing accrual and compensation (per-epoch rate, window durations, recipient vault, Council compensation). The Council cannot block or direct any individual spend, and does not impose new spending restrictions by its own authority. The target-minimum parameters (the 50% share and the formula) sit outside Council authority; changing them requires a community HIP and program upgrade.

**If funds are used outside scope.** The Council has no on-chain veto over the Nova-administered vault. Where it finds use outside the defined purposes, its remedies escalate: (1) demand disclosure; (2) publish dissent; (3) recommend course-correction; (4) trigger a community vote to amend the supplement (including adding or tightening requirements on use) or terminate it. Any new requirement on use therefore takes effect only when the community adopts it by vote, not by Council fiat. The binding safeguard is the community's standing ability to tighten or end the supplement.

**Compensation.** Paid only to the five community-nominated members; the two Nova-appointed seats serve unpaid. HNT-denominated: 8,000 HNT per community member per month, paid by Nova out of the operations and growth supplement vault. It comes out of the supplement, not on top of it: about 1.46M HNT total (~1% of the supplement), reducing funds available for operations and growth by that amount. A $10,000 per-member-per-month value cap applies if HNT appreciates: above ~$1.25/HNT, fewer than 8,000 HNT are paid. At the ~$0.30 reference, 8,000 HNT is ~$2,400 per member per month, ~$12,000/month across the five seats. The amount is set by this authorizing vote contingent on passage, not deferred to first seating, and adjustable forward at any time by community vote: a reduction at simple majority, an increase at the 66.67% supermajority. Minted HNT cannot be reclaimed. Compensation accrues only while a member is seated; amounts accrued before mint start are paid in arrears once the vault funds. There is no Council-controlled discretionary fund: for funding beyond compensation, the Council recommends use of the supplement or escalates a proposal to a community vote.

**Council-raised amendment or termination vote (operations and growth supplement; either or both supplement windows):**

- Triggered by Council escalation, at any time once seated.
- 7-day voting window.
- Simple majority of votes cast; ≥7% quorum. Asymmetric with the authorizing vote: starting the supplement takes a 66.67% supermajority, while correcting, reducing, or terminating it through Council escalation takes a simple majority. This lever loosens downward only; an amendment that increases issuance (higher per-epoch rate, longer windows, or higher compensation) takes the same 66.67% supermajority as the original authorization.
- 7-day enforcement: on approval, a program upgrade implementing the change is deployed within 7 days. Termination halts subsequent accrual in the active window (or, before mint start, prevents the first window from beginning); amendments take effect from deployment forward.

This is the Council's built-in escalation mechanism, not a limit on normal governance: the community may raise an independent HIP to amend or stop the mint at any time, under the vote requirements that apply to that proposal.

**Nova voting position.** Nova votes its veHNT like any other holder, including on votes arising from Council escalation; all votes are public on-chain. Supplement HNT is different: Nova does not lock or delegate supplement HNT for voting while it is under Nova's control. The vault address is fixed, so outflows into lockup positions are publicly traceable.

**Operational terms.** The obligations a member takes on once seated, the detailed information rights, confidentiality, the HNT trading policy, and removal for cause, are set out in the [Advisory Council Roles, Responsibilities, and Access][council-roles] document and the [Confidentiality and Participation Agreement (NDA)][council-nda] each member signs. These are operational terms set by Nova; they are not part of this vote and do not alter the authority established here.

### Execution sequence

| Milestone | Timing | What happens |
|---|---|---|
| **Pre-vote payer-rate change** | pre-passage | Nova reduces the payer rate from $0.50/GB to ~$0.10/GB under [HIP 143][hip-143] (existing authority; no governance vote required), reflecting current commercial offload rates. |
| **Passage** | pre-M0 | Bundle approved at the 66.67% supermajority. Council nomination opens. |
| **Council seated** | M0 | Per-nominee community confirmation concludes; all seven seats filled, disclosure obligations and escalation pathway operational. Program upgrade ships: the target-minimum formula (live; binding at current HNT prices near $0.27), PoC retirement in Mobile and IoT verifier oracles, Mobile data reallocation to 74% pro-rata, SP allocation reframed to the 20% Mobile Operations Fund. Supplement mint configured but not yet active. |
| **Mint start** | M0 + 2 weeks | First-window supplement begins minting into the vault. The two-week gap lets the seated Council review materials and, if it objects, escalate a community vote to terminate or amend the supplement before minting starts; a termination here prevents the first window from beginning. Its standing escalation power continues throughout both windows. |
| **Flat boundary** | ≈ mint start + 12 months (hardcoded) | First-window supplement auto-transitions to the tapering window. |
| **Taper boundary** | ≈ mint start + 36 months (hardcoded) | Tapering supplement reaches zero and halts. |

### Voting mechanics

- veHNT-weighted, single yes/no on the four-decision bundle. The Council exists to oversee the supplement that funds operations and growth; voting them separately would let one pass without the other.
- Minimum 7-day forum discussion period; 7-day voting window.
- 66.67% supermajority of votes cast; ≥7% quorum. Token-economic votes pass on a supermajority, not a simple majority (precedent: [HIP 85][hip-85], [HIP 124][hip-124]); a proposal should not authorize its own issuance at a self-set simple-majority bar.

### What this proposal does not change

- [HIP 20][hip-20] halving emission schedule and Net Emissions re-emission mechanism (HIP 20's max-supply projection is raised by HIP 149's supplement; the schedule itself runs unchanged).
- Sub-DAO structure (Mobile and IoT).
- veHNT lockup positions, multipliers, and voting mechanics.
- 6% delegator allocation.
- [HIP 138][hip-138] single-token (HNT) reward model.
- [HIP 143][hip-143] commercial payer-rate decoupling. The deployer target anchors to the payer rate Nova sets under [HIP 143][hip-143]; authority over the rate itself stays with Nova.
- [HIP 130][hip-130] data-only Mobile Hotspots.
- $/DC peg for IoT data transfer.

## Drawbacks

- **Dilution.** The supplement in Decision 2 raises effective max HNT supply from ~206M (today's effective ceiling, after cumulative reductions since HIP 20's 2020 projection) to ~347M. The accrual is bounded at deploy and self-terminating.
- **Bundling.** Voters cannot accept some decisions and reject others. The decisions are operationally coupled (the Council oversees the supplement; the target relies on the same program upgrade as the reallocation), but a voter who supports three of four still has to vote on the bundle.
- **PoC removal ends a reward category.** Some deployments that brought network value primarily through PoC may not be sustained on data utility alone. The proposal accepts this trade in exchange for routing rewards to verifiable utility.
- **Dependence on the payer-rate setting.** The deployer target depends on the payer rate Nova sets under [HIP 143][hip-143]. Council insight rights cover this setting, but the authority remains with Nova as in [HIP 143][hip-143].
- **Delivery dips briefly after sharp HNT moves.** The top-up is bounded by `smoothed_hnt_burned` so it can't emit more HNT than has been burned recently. After a sharp HNT crash, deployers get partial delivery for 1–2 weeks until Nova's burns at the new price lift the moving average; delivery returns to the full target after. The same bound is what prevents unbounded minting under crash.

## Rationale and Alternatives

**Why a target tied to the payer rate rather than a fixed $/GB.** A fixed $/GB number goes stale as HNT price and offload economics change; the original $0.50/GB target no longer reflects actual deployer earnings. Tying the target to the payer rate Nova sets under [HIP 143][hip-143] makes deployer earnings track the revenue the network actually generates and routes future payer-rate improvements directly to deployers.

**Why cap deployer earnings at twice the payer rate, and route the excess to stakers.** Because the baseline pool is fixed in HNT and distributed pro-rata, its USD value rises without limit as HNT appreciates, so deployers could earn many multiples of what carriers pay the network for the same GB. The cap bounds that: deployer USD pay can't run more than 2× ahead of revenue. The 4× band ($0.05 to $0.20/GB at the current payer rate) leaves deployers full exposure to HNT appreciation through normal ranges and engages only on sustained appreciation. The excess is redirected to veHNT stakers rather than burned: it gives lockers a revenue-linked upside that activates exactly when deployer pay outruns revenue, and keeps the cap net-supply-neutral. Burning instead would tighten supply but return nothing to participants; redirecting concentrates the benefit on the holders who lock to govern.

**Why pro-rata of rewardable bytes for Mobile data.** Pro-rata is splitting-resistant by construction: subdividing a busy site doesn't change total rewards earned from its traffic. Tiered-DAU and per-Hotspot caps were modeled and rejected because they reward subdivision.

**Why 20% for the Mobile Operations Fund.** The fund covers the cost of operating and growing Mobile network infrastructure, and 20% keeps Nova, which administers it, aligned with network success at a level comparable to the up-to-24% Service Provider allocation it replaces (HIPs 82/87). It is a flat pre-allocation rather than a residual because Mobile data is oversubscribed and has no underflow to absorb.

**Why retire PoC rather than reduce it further.** [HIP 147][hip-147] already implemented "data eats first" in Sept 2025. With most viable Mobile deployments now reaching carrier offload within weeks, the residual PoC bucket pays for existing rather than for utility. Retiring it is preferable to maintaining a verifier code path that produces near-zero rewards.

**Why encode the supplement rather than seek annual approvals.** Operations and growth funding through year-by-year HIPs creates uncertainty that compromises multi-year hiring, partner commitments, and carrier expansion. Encoding the windows at deploy with hardcoded boundaries gives the protocol runway without leaving open-ended issuance authority. The same pattern was used in the audited [HIP 138][hip-138] MOBILE-treasury supplement (2024-2025).

**Why a 7-seat Council rather than a larger body or no body.** A 7-seat Council with 5 community-elected members is large enough that no single appointment swings outcomes and small enough to function as a working body. Without a Council, the supplement accrues without scheduled disclosure.

**Alternatives considered and not adopted:**

- A 60/40 tiered-DAU + data composite for Mobile, rejected because tiered-DAU's diminishing-returns curve creates a splitting incentive.
- A utility-indexed emission curve replacing the [HIP 20][hip-20] schedule, rejected in favor of preserving the halving schedule and layering a USD target minimum on top.

## Unresolved Questions

- Council nomination threshold (veHNT minimum) and selection cadence specifics for replacements during a term.
- Whether to add additional disclosure obligations beyond the quarterly supplement outflow report.

## Deployment Impact

The on-chain changes ship in a single program upgrade once the Council is seated. Verifier oracle changes for PoC retirement (Mobile and IoT) are coordinated with that upgrade. We leave the implementation of the program upgrade and verifier oracle changes up to the Helium Core Developers to determine.

This proposal is not backwards compatible in the sense that PoC reward emissions stop when the program upgrade ships (at Council seating). Hotspots earning predominantly through PoC today will see their rewards drop to zero from the PoC bucket and depend on data utility. The Mobile data reallocation (70% to 74%) and, primarily, the target minimum are the offsetting mechanisms for Mobile; IoT continues at the existing $/DC peg.

HIPs retired by Mobile PoC removal: [74][hip-74], [75][hip-75], [85][hip-85], [105][hip-105], [113][hip-113], [119][hip-119], [131][hip-131], [133][hip-133], [135][hip-135], [147][hip-147].

HIPs retired by IoT PoC removal: [15][hip-15], [17][hip-17], [54][hip-54], [58][hip-58], [83][hip-83], [136][hip-136], [137][hip-137].

HIPs retired under the SP allocation reframe: [82][hip-82] and [87][hip-87].

HIPs partially amended: [10][hip-10] (Mobile $/DC peg replaced by pro-rata of rewardable bytes plus the target minimum; IoT $/DC peg preserved), [53][hip-53] ($0.50/GB Mobile target superseded by Decision 1's target minimum; Mobile sub-DAO structure preserved), [93][hip-93].

Documentation at <http://docs.helium.com> will need to reflect the retirement of PoC on both networks, the new Mobile allocation, and the target-minimum mechanism.

## Success Metrics

- Mobile data deployer earnings (USD per GB) meet the target in every epoch after Decision 1 goes live, outside the brief recovery windows after a sharp HNT price drop.
- Carrier offload traffic on the Mobile network (rewardable GB/day) continues to grow after passage.
- Operations and growth supplement vault outflows are published quarterly by the Council, with material disclosures (carrier expansion commitments, deployer programs, ecosystem grants).
- Council activity: nominee participation, quorum on standard actions, escalation events surfaced for community vote.

[council-roles]: ./files/0149/advisory-council-roles.md
[council-nda]: ./files/0149/advisory-council-nda.md
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
[hip-124]: ./0124-securing-iot-governance-through-voting-rewards.md
[hip-130]: ./0130-data-only-mobile-hotspots.md
[hip-131]: ./0131-bridging-gap-between-verification-mappers-and-anti-gaming-measures.md
[hip-133]: ./0133-bridging-gap-for-anti-gaming-measures-phase2.md
[hip-135]: ./0135-transitioning-to-templated-mobile-coverage.md
[hip-136]: ./0136-eliminate-iot-rewards-for-redundant-coverage.md
[hip-137]: ./0137-remove-cn470-from-iot-poc.md
[hip-138]: ./0138-return-to-hnt.md
[hip-143]: ./0143-decoupling-service-provider-pricing-from-governance.md
[hip-147]: ./0147-mobile-data-eats-first.md
