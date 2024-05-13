# HIP 122: Amend Service Provider Hex Boosting

- Author(s): [@mrfizzy99](https://github.com/mrfizzy99) (Fizzy99 - Fiz-Tech.net)
- Start Date: 2024-04-29
- Category: Economic, Technical
- Original HIP PR: [#916](https://github.com/helium/HIP/pull/916)
- Tracking Issue: [#998](https://github.com/helium/HIP/issues/998)
- Vote Requirements: veMOBILE Holders

---

## Summary

HIP-84 Service Provider Hex Boosting as it is written, provides too much unilateral control over where rewards are distributed to any service provider at the expense of the network PoC distribution pool.

If a service provider decides to hex boost all of Miami, the rewards distributed on behalf of the network is disproportionate to the amount burned and disincentivizes the remaining nationwide deployments on the network for the sole purpose of that service provider, ultimately dictating areas where majority of rewards should go.
While this author understands that the first service provider on the network is key to the networks success for future service providers to join, it should not be at the detriment of the network's natural expansion nationwide into other cities, and internationally.

With this in mind, there are also a few other amendments in this HIP that will also benefit the Service Provider in regards to HIP-84. One of which is changing the minimum boost time to 3 months, and the other is staking the hotspot in order to receive the boosted rewards.

## Prior / Related HIPs

* [HIP-84 Service Provider Hex Boosting](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.
* [HIP-109 Hex Boosting by Deployment](https://github.com/helium/HIP/blob/main/0109-hex-boosting-by-deployment.md) modifies hex boosting to allow Service Providers to specify a radio type.

## Motivation

This HIP is being proposed to address some concerns about the original implementation of HIP-84.

## Stakeholders

- The MOBILE subnetwork

## Detailed Explanation

This HIP aims to do four (4) things to amend HIP-84 Service Provider Hex Boosting.

1. Service Provider Hex Boosting rewards to be taken out of the Service Provider Bucket first.
    - HIP-84 is, by title, Service Provider Hex Boosting, and this should come out of the rewards distributed to the Service Provider. If there is not enough MOBILE allocated for the Service Provider bucket to cover the boosted hexes in a single epoch, the remainder would then come out of the networks regular PoC bucket.
    - This would incentivize Service Providers to think more carefully about where, for how long, and by how much a hex is boosted as it comes out of their own reward bucket.
2. Reduce the minimum time for Service Provider Hex Boosting to 3 months.
    - Currently set to 6 months minimum, reducing this to 3 months allows Service Providers more flexibility in boosting a hex that they may be unsure if it has value. Given if that this HIP passes and will be out of their own reward bucket, this will allow the Service Provider to further reduce the risk if the location or deployments in said location do not end up being beneficial to that Service Provider.
3. Limit boosting to a maximum of 10x.
    - Currently uncapped, we as a community have come to the conclusion that the 100x boosted hexes only breeds reward chasing and attempted gaming of PoC. This can be proven as there were very few people (if not no one) deploying within boosted hexes prior to the value oracle of MOBILE changing drastically late in 2023. It is this author's opinion that boosted hexes should incentivize a longer term deployment strategy, and the deployer should have their goals aligned with that in mind. With the current multipliers that can be set, the goals of the deployments in these are not long-term but only short-term. This multiplier would only reduce the maximum for any future hex boosting and not change any current boosted hexes once passed.
4. Staking a hotspot NFT for Boosted Hex rewards.

For CBRS, the FreedomFi is the NFT, while the radios are what determines the coverage and ultimately the rewards given. This HIP proposes locking the radio IDs to that FreedomFi Gateway during the stake time. This will prevent the deployer from re-utilizing the radios in another deployment with a new FreedomFi after the hex boosting has ended, but the staking time has not. This can be unlocked by Nova / FreedomFi in the case they can verify that a specific FreedomFi unit at a hardware standpoint is dead, but the radios are still operational. Nova / FreedomFi can either ask for an RMA to have the FreedomFi unit shipped and replaced, or it can be put on a mini-deny-list to be prevented from earning MOBILE in the case it 'magically' starts working again. And this would allow the radios to be used with another FreedomFi unit.

Staking Eligibility for Boosted Hex Rewards:
- For both Wifi and CBRS, the hotspot asserted or has modeled coverage overlapping a boosted hex location will need to go through 3 full epochs/days with a total of at least 48 valid heartbeats.
- In the case of WiFi, they will also have to pass Skyhook validation for that area in order to be eligible to stake their hotspot to receive hex boosting rewards. If the hotspot does not pass Skyhook validation, they will not be eligible to proceed with staking their hotspot due to the inaccuracy.

Examples of stake duration:
- If a Service Provider boosts a hex for 6 months and the boosted hex has not yet been activated, the asserting hotspot will be asked if they would like to stake their hotspot for a total of 12 months in order to receive the boosted rewards.
- For a boosted hex that has already been activated for 4 months of a total 6-month boost with 2 months left, the hotspot assertion will ask if they are willing to stake their hotspot for a total of 4 months to gain the boosted rewards.
- For a boosted hex that only has 1 month of epochs left, that hotspot will only be asked to stake for a total of 2 months to receive boosted rewards.

Examples of use when asserting and staking prompts:
- When the hotspot asserts their location in a boosted hex, or within a Resolution 6 hex of a boosted area, they will get a prompt after the assertion that they could be eligible for boosted hex rewards. They will be told that it will take 72 hours to validate coverage if they meet the eligibility requirements and will need to stake their hotspot NFT in order to receive the boosted rewards, lastly to check back in 72 hours for a new prompt on the status of such.
  Once the 72 hours have passed, if the hotspot meets eligibility requirements, they will have a prompt to begin the hotspot NFT stake, with a few prompts explaining the implications of staking, and a total time their hotspot will be staked for in order to start receiving those boosts hex rewards. A hotspot could be ineligible for various reasons, and should also give short feedback on why they are not eligible. This could range from something such as the modeled coverage not extending into a boosted hex, to a Skyhook inaccuracy flag.

Phase 1:
The first phase of this implementation would be Parts 1, 2, and 3 stated above, as these should take relatively little time for implementation.

Phase 2:
The second phase of this implementation would be Part 4 stated above, as this could take longer for the coding of the staking mechanism.

## Drawbacks

After the hex boosting has ended, a hotspot deployer could just unplug/dismantle their hotspot setup and closet the hotspot until their staking time has ended. This would only benefit them if the costs of being at that location outweigh the rewards, forcing the operator to retire that hotspot until the staking has expired.

## Rationale and Alternatives

There are a few alternatives to HIP-84 that are being discussed; however, the most prominent topic discussed is where the allocation of rewards comes from, which this HIP addresses.

## Unresolved Questions

Will add as they come up in discussion.

## Deployment Impact

This will impact all hotspots currently asserted that cover boosted hexes by having them stake their hotspot NFT for x amount of time/epochs in order to continue to receive boosted hex rewards. This will also require all future asserting hotspots to stake their hotspot if their coverage is within a boosted hexes.

This will also impact the emissions allocation for boosted hexes, switching from the PoC bucket to the Service Provider bucket.

## Success Metrics

With the success of this HIP we should see more dedicated deployments within Hex Boosted areas, as operators take more risk of staking their hotspot into that area. 
