# HIP Beacon/Witness Ratio - Witness Scaling

- Author(s): @anthonyra#2034 <!-- your GitHub @username -->
- Start Date: 9/30/2021 <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
  
# Motivation
[motivation]: #motivation

To ensure that hotspot owners are motivated to not just prioritize witnessing but also to beacon. Duplicate coverage receipts are only so useful, meaning that if your hotspot can get 8 receipts in an epoch how much more information is gained than if there was only 2 or 3?

# Summary
[summary]: #summary

This proposal intends to enforce a hard limit on the number of witness receipts a hotspot is capable of claiming based on how well the hotspot is able to perform all functions related to Proof of Coverage (PoC). The two major componets to PoC, is the hotspots ability to beacon and witness. Being able to beacon proves to the network that a device has the ability to send a downlink. Downlinks are integral for a LoRa based Internet of Things (IoT) network since they wouldn't be able to join if they couldn't receive downlinks for example.

The primary function of this proposal is to tie beacons to witnesses to ensure that setups benefit the network and not just the individual hotspot. A secondary function of this proposal is to combat the most recent gaming associated to the following **[#poc-discussion on Discord](https://discord.com/channels/404106811252408320/730243594707009608/891400425968898099)**.

# Stakeholders
[stakeholders]: #stakeholders

* All hotspots who currently get rewarded more for witnessing than they do for beacons
* Setups that rely on cellular backhaul (CGNAT setups), sector antennas on mountains with high gain antennas, or even hotspots that aren't port forwarded can be affected. Relayed hotspots are capable of beaconing and witnessing however can have degragated performance when compared to hotspot that are setup properly. Due to the setups listed here there will be added wiggle room to ensure the impact is minimized while incentivizing PoC optimized setups.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation


### Basics
Proof of Coverage (PoC) has limitations on the frequency that a hotspot can create challenges which loosely ties to other hotspots being able to beacon. The current mechanism for targeting a hotspot for a challenge is also limited by an IP bloom filter which is reset based on the `poc_interval` chain variable. This in theory should limit beacons of a hotspot to 6, but this isn't guaranteed.

However, with recent network growth and overall setup quality of miners this can lead to very "unfavorable" averages for beacons and witnesses... This can be amplified if the miner themeselves aren't motivated to fix these setups simply because they earn enough as is by simply witnessing nearby hotspots.

The limitations noted above are based off of the currently inforced limitations with PoC based on the following chain variables `poc_interval` and `poc_per_hop_max_witnesses`. There will be added wiggle room to account for the imperfect system. The two big factors that need to be accounted for in this wiggle room comes from the fact that LoRa communication aren't truly bidirectional in nature and that the current network state [^1] is less than ideal.

| Chain Variables             | Value          | Units          |
| --------------------------- | -------------- | -------------- |
| `poc_interval`              | 240            | blocks         |
| `poc_per_hop_max_witnesses` | 10             | per beacon     |


To calculate this hard limit all you need to do is look at your hotspots witness list which is populated over the course of the last 5 days. If your hotspot performs a beacon which results in a valid witness it's added to the list. This number can be seen on [explorer](https://www.explorer.helium.com) as "Total Witnesses" or via the following api [endpoint](https://docs.helium.com/api/blockchain/hotspots#witnesses-for-a-hotspot)... With the current max witnesses per beacon of 10 and 6 beacons a day the theoritical max for this witness list is 300.

To account for "good" and "bad" days the hard limit is a daily limit instead of per epoch or block. If it was performed per epoch you'd be clipped on good epochs (witness receipts exceed the witness limit per epoch) even if you had 0 witness receipts epochs that day. Having a daily limit will ensure that you can have "good" and "bad" epoches and not be adversely effected.

For the `compensation_factor` the thought would be to base it on the average beacon count divide by the theoritical max which would result in 3/6 with the current network. Since most hotspots are only receiving 50% of expected beacons we multiple the results by this factor. Which at the time of writing is 2. Hopefully as we can get the average beacon rates closer to the theoritical max so that this can be removed.

| Constants / Factors         | Value          | Units          |
| --------------------------- | -------------- | -------------- |
| `witness_list_bucket_size`  | 5              | days           |
| `blocks_per_day`            | 1440           | blocks         |
| `epochs_per_day`            | 48             | blocks         |
| `compensation_factor`       | 2              |                |

```
Max Hard Limit

witness_limit_cap = witness_list * (blocks_per_day / poc_interval) / witness_list_bucket_size * compensation_factor
witness_limit_cap = 300 * (1440 / 240) / 5 * 2
witness_limit_cap = 720
```

```
Rough Chili Bird Hard Limit

witness_limit_cap = witness_list * (blocks_per_day / poc_interval) / witness_list_bucket_size * compensation_factor
witness_limit_cap = 52 * (1440 / 240) / 5 * 2
witness_limit_cap = 124
witnessed_list = 453 / 5 = 91
```

**Edge Cases:** Recently asserted hotspots on the network start with a zero witness list. For this reason, I suggest that the blockchain brings back "test beacons", during multi-hop PoC they were called "0-hop beacons", to initially populate the witness list. The recently asserted hotspot will perform a beacon upon being asserted however this beacon isn't elgible for PoC rewards it would simply allow them to receive witness rewards while they wait to populate their witness list via normal beacons.

### Implementation

When a witness is added to the witness list of the hotspot the daily limit will be calculated with the equation stated above. The limit will be the max size that the witnessed list can reach.

If a hotspot submits a witness receipt to the challenger it will check to see if the limit has been reached for the last 24 hours. If the witness receipt doesn't exceed the limit the witness receipt is marked as valid (as long as the rest of the checks succeed). If the limit was exceeded those witness receipts will be simply dropped not be eligible for the 10 witnesses in the poc receipt.

[^1]: The following Metabase dashboard shows the overall network health centered around beaconing (https://etl.dewi.org/dashboard/208-beacons) you can see that the average beacon per day is around 2-3 beacons. The average however, doesn't take into account for "bad" days or "good" days.

# Drawbacks
[drawbacks]: #drawbacks

- This hard limit will affect hotspots that are located in dense areas. The following hotspots are examples
  - [shallow-walnut-yak](https://etl.dewi.org/question/461-poc-witness-scaling-2-proposal-check?address=113dhjEAg55ozDSdonsM1gb9JuhdLcxQVFyaH5nJGA4WjMzVR9e)


# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

- This proposal is based on the current limitations already established with the Helium blockchain. The mechanisms needed to implement this proposal have already been used previously. They were removed from the ledger when the witness list weren't being used during challenge creation with the switch to HIP15.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Should hotspots in overly dense areas based on HIP17 still earn large rewards based simply on witnessing?

- Should hotspots be rewarded for simply being in a "good" location where they have the ability to hear 100's if not 1000's of other hotspots? I argue that's these areas are too redudant and shouldn't be rewarded like this.. hence this proposal


# Deployment Impact
[deployment-impact]: #deployment-impact

It will require software updates and can be updated OTA. The actual development time will depend on the load currently on the core development team but could be sooner depending on community involvement.

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- As more setups start ensuring adequate beacons are being performed we should see the average beacons increase across the network since there's about 6% of hotspots not beaconing as intended right now.
- We should see a flattening of the rewards curve, resulting in more dense areas receiving less rewards and more rewards for the less dense areas since the overall witness pool will decrease.
- As a secondary function this will also clip setups such as `Clever Smoke Raven` until they provide both components to PoC.