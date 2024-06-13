# HIP 122: Amend Service Provider Hex Boosting

- Author(s): [@mrfizzy99](https://github.com/mrfizzy99) (Fizzy99 - Fiz-Tech.net)
- Start Date: 2024-04-29
- Category: Economic, Technical
- Original HIP PR: [#916](https://github.com/helium/HIP/pull/916)
- Tracking Issue: [#998](https://github.com/helium/HIP/issues/998)
- Vote Requirements: veMOBILE Holders

---

## Summary

This HIP aims to do three things to amend HIP-84 Service Provider Hex Boosting. It creates a dedicated Service Provider Hex Boosting emissions funding category. It reduces the minimum time for Service Provider Hex Boosting to 3 months and finally limits future boost creation to a maximum of 10x rewards.

1. The dedicated Service Provider Hex Boosting Rewards bucket will be limited to a maximum of 10% of all future emissions in the MOBILE network and will be taken out of the current Proof-of-Coverage category (reduced from 20% to a minimum of 10%). Any of the 10% not used by Service Provider Hex Boosting is returned to the Proof-of-Coverage bucket.
2. The minimum time for Service Provider Hex Boosting is reduced to 3 months from 6 months to allow more flexibility of boosting to hexes that may have an unsure value to the network.
3. Limit FUTURE hex boost creation to a maximum of 10x rewards. As the community believes the current 100x boosted hexes are breeding temporary deployments that are reward-chasing and attempting gaming of Proof-of-Coverage.

[HIP-84](./0084-service-provider-hex-boosting.md) established Service Provider Hex Boosting but it provides too much unilateral control over emissions distribution to any Service Provider as it has no limits over the network's PoC emissions. For example, when a service provider decides to place boosts, this directs the disproportionate amount of PoC emissions, including all the Data Transfer overage, to boosted hexes. Because of this skewed emission targeting, deployments in remaining regions nationwide have a disincentive to build on the Helium MOBILE network.

It's important to note that these changes do not affect the Data Transfer category of emissions where unused emissions are granted to the Proof-of-Coverage category. This mechanism will remain untouched.


## Prior / Related HIPs

* [HIP-84 Service Provider Hex Boosting](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.
* [HIP-109 Hex Boosting by Deployment](https://github.com/helium/HIP/blob/main/0109-hex-boosting-by-deployment.md) modifies hex boosting to allow Service Providers to specify a radio type.

## Motivation

This HIP is being proposed to address some concerns about the original implementation of HIP-84.

## Stakeholders

- The MOBILE Subnetwork.
- Service Providers assigning boosted Hex Rewards.
- Operators/Deployers of CBRS and Wi-Fi MOBILE Hotspots outside of boosted hexes will see increased earnings.
- Operators/Deployers of CBRS and Wi-Fi MOBILE Hotspots inside of boosted hexes will see decreased earnings.

## Detailed Explanation

This HIP aims to do three (3) things to amend HIP-84 Service Provider Hex Boosting.

1. Create a dedicated Service Provider Hex Boosting Rewards bucket. This will be 10% of all future emissions in the MOBILE network and will be taken out of the current Proof-of-Coverage category (reduced from 20% to 10%).
   - Any amount not used in this 10% boosted bucket, gets distributed back to the regular PoC bucket.
   - Boosted rewards will no longer benefit from the overflow from the Data Transfer Bucket, as they will be solely dependent on their own bucket.
   - Because of this 10% allocated Hex Boosting Bucket, this would enable a dynamic maximum / ceiling for hex boosts depending on the number of hexes that are actively pulling for boosted rewards. As of writing this HIP, the allocation of PoC to boosted hexes is far above 10%. This will cause boosted hexes to natively get less rewards until the bucket reaches the 10% equilibrium.
   - Mobile rewards are calculated based on the total CPs for that epoch and the PoC bucket of rewards (sans the Mobile due to unused Data rewards). The total Mobile rewards due to the CPs from the boosted hexes are then checked against the 10% Mobile emissions for that epoch. If the number of mobile tokens is higher that the 10% amount, the Mobile rewards for the boosted CPs are reduced  to meet the 10% cap. Mobile rewards from base CPs are then re-calculated after the unused Data rewards are added back into the PoC reward bucket.
      - Example:
           - Assumptions
             - Total Poc bucket: `1,000,000 MOBILE` (500,000 boosted PoC and 500,000 normal PoC)
             - Total Coverage Points: `100,000`
             - Total Boosted Coverage Points: `75,000`
             - Total Normal Coverage Points: `25,000`
           - Calculation
             - `1,000,000 / 100,000 = 10 MOBILE per CP, 10 * 75,000` exceeds the boosted PoC cap, so we have to calculate the MOBILE per CP differently for boosted vs non boosted
             - Boosted
               ```
               500,000 / 75,000 = 6.666666667 MOBILE per boosted CP
               ```
             - Normal
               ```
               500,000 / 25,000 = 20 MOBILE per normal CP
               ```
             - For a hotspot with 500 CP, 100 normal and 400 boosted
               ```
               (100 x 20) + (400 * 6.666666667) = 4666.666667
               ```


2. Reduce the minimum time for Service Provider Hex Boosting to 3 months.
   - Currently set to 6 months, reducing this to 3 months allows Service Providers more flexibility in boosting a hex that they may be unsure of the actual value of that location.
   - It also sets more precedent for deployers to not get accustomed to making contracts based on the boosted time, but rather that this is just a reward to jumpstart the deployment.

3. Limit FUTURE boost creation to a maximum of 10x.
   - Currently uncapped, we as a community have come to the conclusion that the 100x boosted hexes will mostly breed reward-chasing and attempted gaming of PoC.
   - This can be proven as there were very few people (if not no one) deploying within boosted hexes prior to the value oracle of MOBILE changing drastically late in 2023. It is this author's opinion that boosted hexes should incentivize a longer-term deployment strategy, and the deployers should have their goals aligned with that in mind. With the current multipliers that can be set, the goals of the deployments in these are not long-term but only short-term. This multiplier would only reduce the maximum for any future hex boosting and not change any current boosted hexes once passed.


## Drawbacks

In the future (when there are only up to 10x boosts), this theoretically limits the maximum amount of boosted hexes that service providers could create and be active during a range of time without hitting the maximum bucket limit. Which in turn could no longer guarantee the 10x boosts and would eventually really become 9.8x boosts, or 9.5x boosts, and so forth as more boosted hotspots get rewarded from the bucket.

## Rationale and Alternatives

There are a few alternatives to HIP-84 that are being discussed; however, the most prominent topic discussed is where the allocation of rewards comes from which this HIP addresses.

## Unresolved Questions

I will add them as they come up in discussion.

## Deployment Impact

This HIP requests Nova to do the coding and implementation. This will impact the emissions allocation for boosted hexes, switching from being an almost unlimited distribution within the current PoC bucket to a bucket dedicated to boosted rewards and capped at 10% of emissions. Because of this, PoC rewards for non-boosted hexes will see an increase.


## Success Metrics

The success of this HIP will show when over-boosted areas get rewards redistributed back into the regular PoC bucket.

