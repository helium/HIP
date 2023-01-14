# HIP 42: Beacon/Witness Ratio - Witness Reward Limit

- Author(s): @anthonyra
- Start Date: 9/30/2021
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/289>
- Tracking Issue: <https://github.com/helium/HIP/issues/303>
- Discord channel: #hip-42-beacon-witness-ratio
- Status: In Discussion

# Motivation

Twofold:

1. To ensure that hotspot owners are motivated to build a fully working IoT network. Both witnessing
   and beaconing are essential.
2. To combat recent gaming that has been observed.

# Summary

This proposal intends to enforce a hard limit on the number of witness receipts a hotspot is capable
of claiming based on how well the hotspot is able to perform all functions related to Proof of
Coverage (PoC). The two major components of PoC are a hotspot's abilities to both beacon and
witness. Beaconing is the mechanism used by the blockchain to determine if a hotspot has the
capability to perform downlinks and also provides a means to determine coverage without the need for
devices. Downlinks are integral for a LoRa based Internet of Things (IoT) network since they
wouldn't be able to join if they couldn't receive downlinks for example.

The primary function of this proposal is to tie beacons to witness receipts to ensure that setups
benefit the network and not just the individual hotspot.

A secondary function of this proposal is to combat the most recent gaming associated to the
following
**[#poc-discussion on Discord](https://discord.com/channels/404106811252408320/730243594707009608/891400425968898099)**.

# Stakeholders

- All hotspots who currently get rewarded more for witnessing than they do for beacons
- Setups that rely on cellular backhaul (CGNAT setups), sector antennas on mountains with high gain
  antennas, or even hotspots that aren't port forwarded can be affected. Relayed hotspots are
  capable of beaconing and witnessing. However, they can have lower performance than properly set up
  hotspots. Due to the setups listed here there will be added wiggle room to ensure the impact is
  minimized while incentivizing PoC optimized setups. Most of these concerns will be allieviated
  when light hotspots are released since hotspots will only perform outbound connections and won't
  need inbound connections.

# Detailed Explanation

## Basics

Proof of Coverage (PoC) has limitations on the frequency that a hotspot can create challenges which
loosely ties to other hotspots being able to beacon. The current mechanism for targeting a hotspot
for a challenge is also limited by an IP bloom filter which is reset based on the
`poc_challenge_interval` chain variable. This in theory should cap beacons of a hotspot to `4`
daily, but this isn't guaranteed.

> **NOTE** The theoritical cap on beacons per day is based on the number of blocks produced per day
> and the value of the chain varaible `poc_challenge_interval` as of writing (1/10/22) that's (1440
> blocks/day / 360 blocks) = 4 per day

However, with recent network growth and overall setup quality of miners this can lead to very
"unfavorable" averages for beacons and witnesses... This can be amplified if the operators of the
miners aren't motivated to fix these setups simply because they earn enough as is by simply
witnessing nearby hotspots.

The limitations noted above are based off of the currently inforced limitations with PoC based on
the following chain variables `poc_challenge_interval` and `poc_per_hop_max_witnesses`. There will
be added wiggle room to account for the imperfect system. The two big factors that need to be
accounted for in this wiggle room comes from the fact that LoRa communication aren't truly
bidirectional in nature and that the current network state [^1] is less than ideal.

| Chain Variables             | Value | Units      |
| --------------------------- | ----- | ---------- |
| `poc_challenge_interval`    | 360   | blocks     |
| `poc_per_hop_max_witnesses` | 18    | per beacon |

## Calculate Witness Limit Cap - Daily limit on witnesses

To calculate this hard limit (witness limit cap) all you need to do is look at your hotspots witness
list which is populated over the course of the last 5 days. If your hotspot performs a beacon which
results in a valid witness it's added to the list. This number can be seen on
[explorer](https://www.explorer.helium.com) as "Total Witnesses" or via the following api
[endpoint](https://docs.helium.com/api/blockchain/hotspots#witnesses-for-a-hotspot)... With the
current max witnesses per beacon of 18 and 4 beacons a day for 5 days, the theoritical max for your
hotspots witness list is 360.

To account for "good" and "bad" days the hard limit is a daily limit instead of per epoch or block.
If it was performed per epoch you'd be clipped on good epochs (witness receipts exceed the witness
limit per epoch) even if you had 0 witness receipts epochs that day. Having a daily limit will
ensure that you can have "good" and "bad" epoches and not be adversely effected.

The `compensation_factor` is based on the theoritical max for the day divided by the average beacon
count across the network which would result in 4/2 with the current network. Since most hotspots are
only receiving 50% of expected beacons we multiple the results by this factor. Which at the time of
writing is 2. Hopefully as we can get the average beacon rates closer to the theoritical max the
`compensation factor` will return to the default value of 1.

| Constants / Factors        | Value    | Units  |
| -------------------------- | -------- | ------ |
| `witness_list_bucket_size` | 5        | days   |
| `blocks_per_day`           | 1440     | blocks |
| `epochs_per_day`           | 48       | blocks |
| `compensation_factor`      | 2 => 1\* |        |

`* Will be adjusted depending on the network state in regards to beacons. But the default value if the network is functioning as intended will be 1.`

```
Max Daily Witness Receipt Limit

witness_limit_cap = witness_list * (blocks_per_day / poc_challenge_interval) / witness_list_bucket_size * compensation_factor
witness_limit_cap = 360 * (1440 / 360) / 5 * 2
witness_limit_cap = 576
```

---

You can also use the following tools built with the DeWi ETL Metabase website. You'll need to have
an account which requires a gmail.com email address to login.

> [Check HIP-42 using Hotspot Name](https://etl.dewi.org/question/624-poc-witness-scaling-by-name-hip-42)

> [Check HIP-42 using Hotspots Public Address](https://etl.dewi.org/question/461-poc-witness-scaling-hip-42)

---

## Edge Case Concerns

Recently asserted hotspots on the network start with a zero witness list. For this reason, I suggest
that the blockchain brings back "test beacons", during multi-hop PoC they were called "0-hop
beacons", to initially populate the witness list. The recently asserted hotspot will perform a
beacon upon being asserted however this beacon isn't elgible for PoC rewards it would simply allow
them to receive witness rewards while they wait to populate their witness list via normal beacons.

> **Alternatives:** Set a minimum other than 0 for the daily limit currently proposed value is 24
> for this.

## Implementation

When a witness is added to the witness list of a hotspot the daily limit will be calculated with the
equation stated above.

If a hotspot submits a witness receipt to the challenger it will check to see if the limit has been
reached for the last 24 hours. If the witness receipt doesn't exceed the limit the witness receipt
is marked as valid (as long as the rest of the checks succeed). If the limit was exceeded those
witness receipts will be simply dropped.

An alternative is to keep the witnesses and mark them as invalid with the reason
`witness_count_exceeded` but this could result in those witnesses taking the spot (1/18) of a
hotspot that has witnesses available still. Dropping the witness can be viewed as harsh for the
individual but for their neighbors the better option.

Another concern, is with HIP-15 since an invalid witness actually hurts the rewards for the
witnesses simply because a neighbor has exceeded their daily limit.

[^1]:
    The following Metabase dashboard shows the overall network health centered around beaconing
    (<https://etl.dewi.org/dashboard/208-beacons>) you can see that the average beacon per day is
    around 2-3 beacons. The average however, doesn't take into account for "bad" days or "good"
    days.

# Drawbacks

Hotspots could be limited depending on their setup:

- Limited

  - [shallow-walnut-yak](https://etl.dewi.org/question/461-poc-witness-scaling-2-proposal-check?address=113dhjEAg55ozDSdonsM1gb9JuhdLcxQVFyaH5nJGA4WjMzVR9e)

- Not Limited
  - [rough-chili-bird](https://etl.dewi.org/question/461-poc-witness-scaling-2-proposal-check?address=112JbKk4fvYmoSqHR93vRYugjiduT1JrF8EyC86iMUWjUrmW95Mn)

# Rationale and Alternatives

@paulM on Discord

> Every time a hotspot beacons, a counter is reset for the number of witnesses that hotspot can
> submit and it counts down until it is zero and stops being able to submit witnesses. The counter
> amount is based on how many witnesses the most recent beacon got. For example, if the challenge is
> acknowledged but there are no witnesses, then the counter is set to 2, but if the beacon had
> witnesses set it to some multiple of the number of witnesses it got.

## Concerns

This would have the same results but will be less lenient when it comes to network performance. It's
not unheard of a hotspot not beaconing for >24hours. Utilizing the witness list buffers those bad
days with good ones. If there was a minimum beacon per day this wouldn't be an issue for this
implementation.

# Unresolved Questions

- Should hotspots be rewarded for simply being in a "good" location where they have the ability to
  hear 100's if not 1000's of other hotspots?

- Should this HIP be delayed until Light Hotspots are released?

- Would this result in more adverse results then what network stands to get as a result?

# Deployment Impact

It will require software updates and can be updated OTA. The actual development time will depend on
the load currently on the core development team but could be sooner depending on community
involvement.

With a yes on the Temperature Check vote at
<https://www.heliumvote.com/13NyqFtVKsifrh6HQ7DjSBKXRDi7qLHDoATHogoSgvBh56oZJv8>, I will head the
code required for this to be implemented.

# Success Metrics

What metrics can be used to measure the success of this design?

- As more setups start ensuring adequate beacons are being performed we should see the average
  beacons increase across the network since there's about 14% of hotspots not beaconing as intended
  right now.
- We should see a flattening of the rewards curve, resulting in more dense areas receiving less
  rewards and more rewards for the less dense areas since the overall witness pool will decrease.
- As a secondary function this will also clip setups such as `Clever Smoke Raven` until they provide
  both components to PoC.
