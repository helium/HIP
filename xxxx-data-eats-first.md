# HIP XXX: Data Eats First

- Author: [@ferebee](https://github.com/ferebee)
- Start Date: 2025-08-20
- Category: Economic
- Original HIP PR: [#0000](https://github.com/helium/HIP/pull/0000)
- Tracking Issue: [#0000](https://github.com/helium/HIP/issues/0000)
- Voting Requirement: veHNT Holders

---

## Summary

Currently, 20% of the HNT emissions to the Mobile network are reserved for PoC rewards, as defined in [HIP-53][hip-53]. Data Transfer is rewarded pro-rata from the 40% Data Transfer bucket, with anything left over added to the PoC bucket.

Since the recent halvening, with Data Transfer increasing, and depending on the market price of HNT, this 40% of HNT emissions to Mobile may sometimes be insufficient to reward Hotspots 1:1 for the total Data Transfer utility of the network. Meanwhile, the time it takes for useful deployments to be selected for offload is decreasing, and developments such as Utility Probing, as proposed in [HIP-145][hip-145], are expected to reduce that further.

Therefore, PoC rewards are no longer the primary driver of network growth. Data Transfer is the ultimate proof of utility.

Under this proposal, the 20% reservation of emissions for PoC would be removed, so up to 60% of HNT emissions to Mobile would be used to reward Hotspots for Data Transfer pro-rata. Any leftover emissions would be distributed as PoC, as before.

## Motivation

The success of the Helium Mobile network depends on Data Transfer. PoC was an important motivator of deployment in the early stages of the network, but now that Hotspots which meet the needs of carrier partners can often earn Data Transfer rewards within weeks, PoC is less important.

The best motivator of network buildout is to reward actual utility, so Data Transfer should be rewarded first. Any leftover emissions can still be used as an additional incentive for desirable installations, as specified by the evolving rules of PoC.

## Stakeholders

This proposal primarily affects deployers in the Mobile network. In times of high network utility relative to token price, their deployments will receive greater rewards for Data Transfer, and less rewards for PoC.

## Detailed Explanation

Under this proposal, the 20% reservation of HNT emissions to the Mobile network for PoC will be removed. Rewards for Data Transfer will be prioritized over rewards for PoC.

As before, in an Epoch with no Data Transfer, 60% of emissions to Mobile will be distributed as PoC.

However, in an Epoch in which the DC Burn for Data Transfer is greater than the nominal fiat value of 60% of HNT emissions to the Mobile network, PoC rewards to Mobile Hotspots will be zero, and the entire 60% will be distributed pro-rata among Hotspots for Data Transfer.

## Drawbacks

The assumption behind this proposal is that deployers will be encouraged to create maximal utility for the network if the network prioritizes rewarding Data Transfer.

However, if it turns out that PoC rewards can encourage deployments which don’t achieve attractive rewards from Data Transfer, but which are still valuable to the network in some way, then this proposal might discourage such deployments, depending on market conditions and the total utility of the network as a whole.

## Rationale and Alternatives

There is strong support in the community to reward Data Transfer 1:1 as much as possible. However, under this proposal, depending on market conditions, Hotspots might not earn any rewards from PoC at all until selected for carrier offload, so their rewards would be limited to their offload for Helium Mobile subscribers.

It has been proposed that Hotspots could receive some form of UBI until they are accepted or rejected for carrier offload.

On the other hand, if carriers can reduce the time it takes to make an offload decision, perhaps with help from Utility Probing, it might serve the community better to focus deployers’ attention as much as possible on Data Transfer.

## Unresolved Questions

Are there situations where deployments that bring value to the network can only be sustained through PoC?

## Deployment Impact

Madninja can’t wait to deploy this already and thinks why do we even need a HIP about it?

## Success Metrics

This proposal will be successful if deployments in the top 20% of Data Transfer per Hotspot receive higher rewards than they would have if the 20% reservation for PoC had remained in place.

[hip-53]: https://github.com/helium/HIP/blob/main/0053-mobile-dao.md
[hip-145]: https://github.com/ferebee/HIP/blob/main/0145-utility-probing.md
