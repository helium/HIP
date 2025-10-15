# HIP XXX: Deprecate Mobile PoC

- Authors: [@AndrewsMD](https://github.com/AndrewsMD), [@ferebee](https://github.com/ferebee)
- Start Date: 2025-10-09
- Category: Economic, Technical
- Original HIP PR: [#0000](https://github.com/helium/HIP/pull/0000)
- Tracking Issue: [#0000](https://github.com/helium/HIP/issues/0000)
- Voting Requirement: veHNT Holders

---

## Summary

Currently, as defined in [HIP-53][hip-53] and amended in [HIP-147][hip-147] and [HIP-148][hip-148], 70% of HNT emissions to the Mobile network are used to reward Hotspot deployers pro-rata for the value of Rewardable Data transferred by their Hotspots, up to the nominal rate, currently $0.50/GB.

If the market price of HNT is high relative to the total Data Transfer of the Mobile network, the excess HNT in the 70% deployer allotment is assigned to the PoC bucket, and is used to reward Hotspots with Proof of Coverage rewards according to the schedule defined in various HIPs.

This HIP proposes to repurpose the current PoC reward bucket in selected regions, beginning with the US, by retargeting PoC rewards into a Data Transfer Reward Escrow Fund.

In times when the HNT price is low relative to total Data Transfer, such that the Data Transfer rewards paid pro-rata to deployers are less than the nominal rate, the Escrow Fund can be used to supplement Data Transfer rewards.

## Motivation

In the United States, under current market conditions, Data Transfer revenue provides an effective incentive for the deployment of Mobile Hotspots that deliver utility to the network. US deployers have suggested that PoC rewards are not currently material to their operations. On the other hand, in the past, when PoC rewards have been high relative to Data Transfer rewards, PoC gaming has been a major challenge, diverting rewards from legitimate deployments and consuming significant developer resources.

If market conditions change, and the total value of HNT emissions once again allows for large PoC rewards, this could provide a new incentive for PoC gaming. Given that Data Transfer rewards already incentivize useful deployments in markets with active carrier offload agreements, the authors believe that high PoC rewards in addition to Data Transfer rewards would disproportionately incentivize gaming rather than effective network buildout.

Conversely, if market conditions become unfavorable, the value of total Data Transfer could exceed the total HNT value available in the deployer emissions bucket, reducing each deployer’s pro-rata Data Transfer rewards below the value they provide to the network. This could reduce the incentive to deploy.

Therefore, the authors propose to establish an Escrow Fund, using emissions that would otherwise be distributed as PoC rewards, which can be used to support Data Transfer rewards under unfavorable market conditions, or in markets where Data Transfer rewards alone are not yet sufficient to incentivize network growth.

## Stakeholders

This proposal primarily affects deployers in the Mobile network. Depending on geography, it could reduce their rewards when the market price of HNT is high relative to Data Transfer, while potentially supporting their Data Transfer rewards under unfavorable market conditions.

## Detailed Explanation

Under this proposal, PoC rewards to deployers in selected geographies, initially the United States, will no longer be distributed. Instead, those emissions will be deposited into a Data Transfer Reward Escrow Fund.

In any epoch when the total value of the deployer share of HNT emissions to the Mobile network is lower than the total value of Data Credits burned for Data Transfer, such that deployers cannot be fully rewarded at the nominal rate from emissions, but instead, would be rewarded pro-rata, HNT may be taken from the Escrow Fund and used to supplement the deployer reward bucket, not exceeding the amount needed to reward deployers at the nominal rate, currently $0.50 per GB of Rewardable Data.

The geographies where PoC emissions are redirected to the Escrow Fund, and the geographies which receive a subsidy to Data Transfer rewards from the Escrow Fund, and the amount of the subsidy, will be decided by Nova, and may be changed at any time in an HRP. Initially, all US PoC emissions will be escrowed when available, and all US Hotspots will receive full subsidies up to the nominal rate as funds permit.

This proposal does not directly address the rules governing PoC rewards, so existing rules would continue to determine the distribution of PoC and escrow emissions between geographies, even when the allocation to US Hotspots is placed in the Escrow Fund.

However, once PoC gaming incentives in the US are eliminated, simpler PoC rules may become sufficient to incentivize deployment in Mexico and other markets, and new methods of validating the utility of Hotspot installations may be developed.

Therefore, this proposal authorizes Nova to modify the rules governing the distribution of PoC and escrow emissions, with a view toward maintaining balanced deployer incentives across all geographical markets in the interest of total network utility. The incentives delivered as direct PoC rewards, and as disbursements from the Escrow Fund, will continue to be distributed through a decentralized mechanism, so that they may be accessed permissionlessly by deployers.

Modifications to the rules of PoC and the operation of the Escrow Fund will be proposed and authorized through the HRP process.

## Drawbacks

By limiting deployer rewards under favorable market conditions, this proposal may reduce deployment incentives. The authors believe that the potential benefits of subsidizing useful deployments under unfavorable market conditions, and of eliminating gaming vectors, outweigh this drawback.

## Rationale and Alternatives

The community of legitimate deployers has expressed strong support for eliminating PoC incentives in the US, and many find that Data Transfer rewards sufficiently incentivize their deployments, while PoC rewards introduce unnecessary gaming vectors.

It has been proposed that the Escrow Fund introduced in this HIP should be used preferentially to incentivize new deployments, rather than existing deployments that may have already recouped their investment. One approach could be to restrict the subsidy to Hotspots installed at new locations without existing coverage. Another approach could be to provide specific subsidies that would effectively lower the purchase price of a Hotspot for new deployers. This proposal does not address these questions, but more specific criteria for a subsidy could be introduced with a future HIP or HRP.

## Unresolved Questions

Is there potentially useful coverage that will not be built if PoC rewards are unavailable?

## Deployment Impact

Core developers would need to implement new code for the Escrow Fund and its disbursal. On the other hand, if the rules of PoC can be simplified, reward Oracles can be simplified as well.

## Success Metrics

This proposal will be successful if it encourages deployers to grow the network under adverse market conditions.

[hip-53]: https://github.com/helium/HIP/blob/main/0053-mobile-dao.md
[hip-145]: https://github.com/helium/HIP/blob/main/0145-utility-probing.md
[hip-147]: https://github.com/helium/HIP/blob/main/0147-mobile-data-eats-first.md
[hip-148]: https://github.com/helium/HIP/blob/main/0148-reallocate-mobile-mapping-rewards.md
