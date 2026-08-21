# Implementation notes

Where the changes in the Mobile deployer prioritization HIP land in code. Nothing
here is part of the proposal, and the Helium Core Developers own the
implementation; this exists so a reviewer can see that each decision has a place
to go and what it costs.

## On chain, in `helium-sub-daos`

| Change | Where |
|---|---|
| The Backstop mints to the Mobile data rewards escrow rather than to DAO-level total rewards | `backstop.rs`, and the mint on the Mobile pass of `issue_rewards_v0` |
| The Mobile data bucket constant moves from 70 to 94 | `MOBILE_DATA_BUCKET_PERCENT` in `backstop.rs` |
| The target-minimum constant moves from 50% to 80% | `backstop.rs` |

`issue_rewards_v0` already mints to the rewards escrow through the HNT circuit
breaker, so direct delivery needs no new mint path. One constant governs the data
bucket in all three places it is read: the deployer baseline, the divisor, and the
earnings-cap ceiling.

**No new state, and nothing migrates.** The package adds no account and no field.
The Backstop keeps its existing read of the Mobile percent share, since the
Protocol Score is unchanged. Solana account space cannot be reclaimed.

## On chain, in `hpl-crons`

The end-of-epoch task graph encodes the accounts each instruction takes, so a
change to either instruction's account list ships in the same rollout or issuance
halts.

## In the oracles

**The multiplier belongs in the packet verifier**, where rewardable bytes are
converted to data credits, and applies to the derived data credit count rather
than to the bytes. Rewardable bytes are a physical measurement that reaches reward
manifests and public reporting; inflating them would corrupt every volume metric.
A fractional multiplier is rounded down, so a payer never burns more than the
multiplier earns, and the multiplier is applied after the per-user rewardable cap.

**The reward path needs no multiplier change.** It distributes pro-rata of the same
data credits and reads them from the burned sessions rather than recomputing them,
so one insertion point moves the payer's burn, the on-chain `dc_burned` the
earnings band reads, and each Hotspot's share.

**Tickets** are accepted from a known signing key, authorized the way other oracle
submissions are, and a multiplier outside 1 to 5 is rejected.

**Separately**, the Mobile verifier stops computing a Service Provider pool and
treats the whole issued amount as the data pool. Its residual arithmetic is
unchanged by this: with the Service Provider share at zero, the data pool is the
whole issued amount. The IoT verifier is untouched.

## Sequence

The program upgrade and the oracle releases ship together, since Decisions 2 and 3
change the same computation. No multiplier ticket can be issued before the oracle
release is live, and none takes effect until issued, so the two sides never
disagree.
