---
authors:
  - "@BFGNeil"
start-date: 2026-07-08
category: economic, technical
original-hip-pr:
tracking-issue:
vote-requirements: veHNT Holders
status: Draft
---

# Restoration of IoT Proof-of-Coverage

## Summary

[HIP 149][hip-149] retired Proof-of-Coverage (PoC) on both Mobile and IoT. Without it, IoT rewards track only billed data traffic, which cannot fund coverage in areas before devices are deployed there, breaking the incentive that let independent operators build ahead of demand. This HIP restores PoC on IoT only, amending Decision 3 of [HIP 149][hip-149]. Nothing else in [HIP 149][hip-149], Mobile PoC retirement, the supplement, the Advisory Council, or the IoT $/DC data-transfer peg, changes.

## Author's Note

I've been part of this network since the early days of IoT, first as a hotspot operator, then building a company alongside it rather than separate from it. I've watched data usage stay low for years, so I understand why anyone reading this would be skeptical of another "usage is coming" argument. This isn't that.

What's changed for us, concretely, is that asset tracking is now getting real traction, not projected traction. We work with companies across pharmaceuticals, oil and gas, cold chain, and equipment hire and service industries, several of them relationships going back three to four years, with a number now past the trial stage and into mass manufacture. I'm not going to share figures here. Some of it isn't mine to share, and a number without the deal behind it means nothing to a voter, so I'd rather not ask anyone to take my word for it. That traction is why PoC's removal is a real problem for us and not an abstract one: our use cases need coverage in places we don't own or control, and PoC was what made that coverage exist.

But I want to be direct about why this proposal exists: [HIP 149][hip-149] passed, PoC was retired, and it turned out our use cases genuinely need it to work. That's the trigger. This isn't timed to a commercial opportunity; it's a direct response to a change that broke something we and others depend on, raised as soon as that change took effect.

I also don't see this as a single, isolated ask. If this passes, I intend to bring the per-device seat-fee proposal in the Accompanying Work section forward myself, not just flag it and move on, and to stay involved in IoT governance past this vote. Restoring PoC fixes one problem; it doesn't fix IoT's economics on its own, and I'd rather be part of that follow-on work than treat this HIP as the end of it.

The public evidence in the Motivation section below stands on its own regardless of anything above. I wanted the community to know where this proposal is coming from before reading it.

## Motivation

IoT data-transfer revenue is low today: roughly $125 a day network-wide as of Q4 2025, per Messari's State of Helium report, consistent with [HIP 146][hip-146]'s independent estimate of about $108 a day in mid-2025. Usage-based rewards alone can't sustain a coverage network at that revenue, and can't fund coverage ahead of demand. That's a chicken-and-egg problem: devices don't get deployed where there's no coverage, and coverage doesn't get built where there are no devices yet generating usage. PoC broke that loop by paying hotspots for verified presence, independent of billable traffic.

**Why now.** Two facts, independent of any single company's plans:

- NB-IoT is shrinking in key markets. AT&T shut down its US NB-IoT network in early 2025 and moved customers to LTE-M.
- LoRaWAN is growing. The LoRa Alliance reported 125 million global end-device deployments in December 2025, a 25% CAGR across the ecosystem, up to 50% for its largest vendors.

**Why Helium specifically.** Helium does not need to win that growth directly. Helium hotspots already provide roaming coverage for Netmore and Senet: Netmore customers can connect through Helium hotspots at no added cost, and Senet has a comparable arrangement spanning hundreds of thousands of Helium hotspots across 170 countries. When a company migrates off NB-IoT onto one of these networks and lands somewhere only a Helium hotspot covers, that traffic burns DC and pays Helium, with no direct relationship to Helium required.

That only works if Helium's coverage stays active in places without a paying contract yet, which is what PoC funded. Competitors are moving fast: Netmore's January 2026 acquisition of Actility created a combined network of over 14 million contracted devices across more than 100 countries. If Helium's uncontracted coverage thins out from a lack of PoC while rivals actively build out their own, Helium loses the advantage that currently lets it capture this growth without building the coverage itself.

**Why PoC, specifically, for IoT.**

- **Placement.** Without PoC, reward tracks only billed traffic, not where a hotspot actually sits.
- **Tracking use cases.** Asset tracking needs coverage on land the deployer doesn't own: transit routes, warehouses they don't lease. PoC was the reason independent operators covered those areas anyway.
- **Density.** PoC rewarded consistent beaconing regardless of traffic, the only incentive to maintain redundant coverage.

## Stakeholders

- **IoT hotspot operators.** Directly affected; regain a reward path independent of local traffic.
- **IoT data deployers.** No change; the $/DC peg is untouched.
- **veHNT holders and delegators.** 6% delegator allocation unaffected. Changes how IoT emission splits internally, not IoT's share relative to Mobile.
- **Mobile-side stakeholders.** Not affected.

Feedback on this proposal is solicited through the Helium Discord's IoT channel and via comments on this HIP's GitHub PR and tracking issue once opened.

## Detailed Explanation

1. **Verifier oracle.** Reinstate IoT PoC verifier logic (beaconing, witnessing, challenge/response) as defined by the HIPs [HIP 149][hip-149] lists under "HIPs retired by IoT PoC removal": [HIP 15][hip-15], [HIP 17][hip-17], [HIP 54][hip-54], [HIP 58][hip-58], [HIP 83][hip-83], [HIP 136][hip-136], [HIP 137][hip-137].
2. **IoT sub-DAO allocation.** Reinstate a PoC bucket at the pre-HIP-149 split, shrinking the data and Operations Fund buckets proportionally.
3. **Backstop routing.** Restore the pre-149 routing of IoT's share of the Mobile-driven backstop across IoT's buckets, PoC included, rather than sending it entirely to the IoT Operations Fund.

**Open parameter:** exact pre-149 IoT bucket percentages, to be verified against on-chain history before this goes to a vote.

## Drawbacks

- **Gaming risk returns.** The same placement incentive that helps tracking use cases is what made gaming worthwhile before; these are one mechanism, not two.
- **Engineering cost.** Restoring retired verifier code needs real Core Developer time to re-audit, not a parameter flip.
- **Reopens a passed bundle.** Unwinding one piece sets a precedent for piecemeal amendment.

## Rationale and Alternatives

Full restoration, not a partial bucket, because any nonzero cut still leaves coverage-only deployments partly unrewarded, and IoT PoC already has a known, audited implementation. Mobile PoC is left alone because its removal rested on Mobile-specific facts this proposal isn't disputing.

Alternatives considered: discretionary Operations Fund support for coverage-focused deployers, rejected because it is not a committed payout and reintroduces funding uncertainty. A geography-weighted data reward in place of PoC is not pursued here, but worth raising separately if the community prefers a data-tied incentive.

## Accompanying Work

PoC restores the coverage incentive but isn't a complete fix. Two follow-ons worth the community's attention:

- A minimum per-device monthly fee, for example around 10p, drawn down against actual data use, giving IoT a baseline revenue per active device regardless of usage. This needs its own HIP; the author intends to bring it forward.
- Anti-gaming: carry over the existing logic as-is at restoration, since it's already audited and known, then improve it afterward in a separate HIP rather than redesigning before PoC returns.

## Unresolved Questions

- Exact pre-149 IoT bucket percentages to restore.
- Scope and timeline for the anti-gaming follow-on improvements.

## Deployment Impact

IoT PoC has already been turned off following [HIP 149][hip-149]'s passage. IoT hotspots earning primarily through PoC are earning zero from that bucket today. This HIP reverses that specific change via a program upgrade to the IoT verifier oracle, coordinated with Core Developers, to turn PoC logic back on.

## Success Metrics

- IoT hotspots previously earning mainly through PoC resume earning after activation.
- IoT data deployer income unchanged.
- A seat-fee proposal reaches discussion within 30 days of this HIP's deployment, and updated anti-gaming measures follow.

[hip-15]: ./0015-beaconing-rewards.md
[hip-17]: ./0017-hex-density-based-transmit-reward-scaling.md
[hip-54]: ./0054-h3dex-targeting.md
[hip-58]: ./0058-poc-distance-limit.md
[hip-83]: ./0083-restore-first-to-witness.md
[hip-136]: ./0136-eliminate-iot-rewards-for-redundant-coverage.md
[hip-137]: ./0137-remove-cn470-from-iot-poc.md
[hip-146]: ./0146-iot-seat-fees-for-sensors.md
[hip-149]: ./0149-helium-utility-and-emissions-realignment.md
