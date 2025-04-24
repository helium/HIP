# HIP 144: Mobile Hotspot Rewards Escrow

- Author: [madninja](https://github.com/madninja), [ChewingGlass](https://github.com/ChewingGlass)
- Start Date: 2024-03-25
- Category: Economic
- Original HIP PR: [#1162](https://github.com/helium/HIP/pull/1162)
- Tracking Issue: [#1164](https://github.com/helium/HIP/issues/1164)
- Voting Requirements: veHNT holders

---

## Summary

This proposal would authorize Nova Labs to introduce a 30-day delay, or Rewards Escrow period, to the process of claiming rewards for Helium Mobile Hotspots. This would increase the "stake" a Hotspot deployer has in the Hotspot, which could be burned if the Hotspot is caught exploiting the Helium Network for rewards.

Rewards would be calculated and earned as before, but each day’s rewards would be held in escrow for 30 days by the Mobile Reward Indexer, and would be released as claimable 30 days after being earned.

If a Hotspot is determined to be gaming the network, and is perma-banned, all earned rewards held in escrow would be burned, or "slashed", thereby reducing the profitability of gaming.

Allowances would be made for Hotspots deployed prior to the implementation of this proposal, so that deployers could make economic adjustments.

Note that this HIP does not mandate the implementation of an escrow mechanism. Rather, if it is approved by the community, it grants Nova the authority to make a unilateral determination at a later date that Rewards Escrow is necessary for the health of the network. Nova would then implement such a mechanism and include it in an HRP for release.

## Motivation

As the cost of Hotspots goes down with brownfield and self-service Data-Only Hotspots, the cost to game network rewards also decreases. Today, a gaming Hotspot (and all associated Hotspots) is banned when caught, but in most cases the gaming has already earned back the cost of the hardware that is "slashed" by the ban. With brownfield and Data-Only Hotspots, the hardware cost of a Hotspot is nearly zero, and self-serve Data-Only Hotspots can easily be regenerated if banned. Thus, gaming can be effectively free using Data-Only Hotspots.

Using a 30-day rolling window, Rewards Escrow can:

- Protect the network from reward gaming and exploitation, as the escrow effectively introduces 30 days of rewards as a slashable stake for each Hotspot.
- Allow sufficient time for activity verification.
- Maintain simplicity by using existing claim infrastructure.
- Ensure rewards correspond to legitimate network usage.

## Stakeholders

- Existing Hotspot deployers, who have ongoing operational expenses and payouts
- New Hotspot deployers


## Detailed Explanation

Because this change can be made in oracles, no on-chain changes are required for this feature.

If Nova Labs, under the authority granted by this HIP, implements Rewards Escrow, the Mobile Reward Indexer will:

 - For new Hotspots, collect and maintain 30 days of pending rewards for a Hotspot and post the first day as claimable using the existing mechanism on day 31, while escrowing day 31. This will continue on to maintain a 30 day rolling window of escrowed rewards.
 - For existing Hotspots, a 90 day grace period will start, after which the 30 day escrow window will collect and release rewards as described above.

The Pending Rewards Oracle will report all earned rewards, claimable and escrowed.

The Builder and Helium Wallet Applications will be modified to show claimable and earned rewards separately. The existing claim mechanism can be used for the claimable amount.

In case it is not clearly obvious that a Hotspot is gaming, the escrow window can be extended to 60 or 90 days to allow more time to investigate and coordinate with the deployer and larger community for analysis. If the Hotspot is found to be gaming, the whole escrow window is burned. If it is found not to be gaming, the escrow window is shortened back to 30 days, and the all rewards escrowed beyond 30 days become immediately claimable.

Conversely, Nova may elect to shorten the escrow window for individual well-known deployers who have existing financial stakes and trust relationships through other programs such as the Nova or Foundation Deployer Grants. 

## Drawbacks

1. **Operational**
   - Initial 30-day delay for new deployers
   - Need to track reward aging
2. **Economic**
   - Delayed access to earned rewards
   - Impact on operator cash flow, mitigated by grace period for already deployed Hotspots
   - Potential effect on deployer participation
3. **Technical**
   - Additional reward aging tracking
   - Updates to applications to separate Subscriber and Hotspot claiming logic
4. **Transition**
   - Migration period for current rewards
   - Clear communication and deployer education needed

## Rationale and Alternatives

The impact of Rewards Escrow includes:

* Security Benefits
  - Extended verification window
  - Reduced gaming incentive when more is at stake
* Operator Experience
  - Consistent with existing claim process
  - No new interfaces to learn
  - Clear reward maturation timeline
* Economic Effects
  - More stable reward distribution
  - Reduced impact of gaming attempts
  - Better alignment with actual network value

  
## Unresolved Questions

Some alternatives considered include:

1. **Current System**
   - Immediate reward availability
   - Higher vulnerability to exploitation
   - No verification period
2. **Fixed Monthly Release**
   - Calendar-based release
   - Less flexible
   - More complex tracking

## Deployment Impact

As described in the Detailed Explanation:

 - New deployers will not be able to claim rewards for 30 days. Application changes to indicate both claimable and earned rewards will be needed.

 - Existing deployers will need to set aside enough rewards during the grace period to cover the 30 days initial collection timeframe. Notices will need to go out to all deployers. 

## Success Metrics

This design will be considered a success if the number of Hotspots caught gaming goes down due to the increased rewards at stake for potential or existing gamers. 

---

[hip-103]: https://github.com/helium/HIP/blob/main/0139-phase-out-cbrs.md
[hip-140]:  https://github.com/helium/HIP/blob/main/0140-adjust-service-provider-boost-qualifiers.md
