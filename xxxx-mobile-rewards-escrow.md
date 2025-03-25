# HIP XXX: Mobile Hotspot Rewards Escrow

- Author: [madninja](https://github.com/madninja), [ChewingGlass](https://github.com/ChewingGlass)
- Start Date: 2024-03-25
- Category: Economic
- Original HIP PR: [#1162](https://github.com/helium/HIP/pull/1162)
- Tracking Issue: [#1164](https://github.com/helium/HIP/issues/1164)
- Voting Requirements: veHNT holders

---

## Summary

Add a 30 day rolling window rewards escrow for Helium Mobile Hotspots. This increases the "stake" a Hotspot Deployer has in the Hotspot which can be burnt if the Hotspot is caught exploiting the Helium Network for rewards.

Different escrow collection timelines will be used for existing and newly deployed Hotspots.


## Motivation

As the cost of the Hotspots goes down with brownfield and self-service Data-Only Hotspots, the cost to game network rewards goes down very low. Today, a gaming hotspot (and all associated hotspots) will get banned when caught but in most cases the gaming has earned back the cost of the effective hardware cost "slash". With Brownfield and Data-Only hotspots the cost of a Hotspot goes to near zero which makes the cost to game effectively free. This is made worse by the ability generate a new Self-Serve Data-Only Hotspot very quickly.

Using a 30 rolling window rewards escrow will:

- Protect network from reward gaming and exploitation. Adding a 30 rolling window escrow adds 30 days worth of rewards as a slashable stake for a Hotspot.
- Allow sufficient time for activity verification
- Maintain simplicity by using existing claim infrastructure
- Ensure rewards correspond to legitimate network usage

## Stakeholders

- Existing Hotspot Deployers, which have existing fleets with ongoing operational expenses and payouts
- New Hotspots Deployers, which onboard new hotspots


## Detailed Explanation

 No on-chain changes are needed for this feature.

On activation of this HIP, The Mobile Reward Indexer will:

 - For new hotspots collect and maintain 30 days of pending rewards for a hotspot and post the first day as claimable using the existing mechanism on day 31, while escrowing day 31. This will continue on to maintain a 30 day rolling window of escrowed rewards.
 - For existin hotspots a 90 day grace period will start, after which the 30 day escrow window will start collecting and releasing as described above 

The Pending Rewards Oracle will return all earned rewards whether claimable or not.

A new ingest ban report to "perma-ban" a hotspot will be created. This ban type does not expire. The Mobile Rewards Indexer will burn accumulated escrow rewards for the banned hotspot. The Mobile Verifier will no longer allocate rewards for a perma-banned hotspot.

Builder and Helium Wallet Applications will be modified to show claimable and earned rewards separately. The existing claim mechanism can be used for the claimable amount.

In case it is not clearly obvious a Hotspot is gaming the escrow window can be extended to 60 or 90 days to allow more time to investigate and collaborate with the Deployer and Community members on analysis. If found gaming the whole escrow window is burned. If found to not be gaming the escrow window is shortened back to 30 days and the escrow over 30 days will be claimable.


## Drawbacks

1. **Operational**
   - Initial 30-day delay for new operators
   - Longer wait for first rewards
   - Need to track reward aging
2. **Economic**
   - Delayed access to earned rewards
   - Impact on operator cash flow, mitigated by grace period for already deployed hotspost
   - Potential effect on operator participation
3. **Technical**
   - Additional reward aging tracking
   - Updates to application to separate Subscriber and Hotspot claiming logic
4. **Transition**
   - Migration period for current rewards
   - Clear communication needed
   - Operator education required


## Rationale and Alternatives

The impact of a rewards escrow includes:

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
  - Better alignment with actual network value## Unresolved Questions

Some alternatives considered, include:

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

 - New Deployers will not be able to claim rewards for 30 days. Application changes to indicate both claimable and earned rewards will be needed

 - Existing Deployers will need to set aside enough rewards during the grace period to cover the 30 days initial collection timeframe. Notices will need to go out to all deployers. 

## Success Metrics

This design will be considered a success if the number of caught gaming Hotspots goes down due to the increased rewards at stake for potential or existing gamers. 

---

[hip-103]: https://github.com/helium/HIP/blob/main/0139-phase-out-cbrs.md
[hip-140]:  https://github.com/helium/HIP/blob/main/0140-adjust-service-provider-boost-qualifiers.md
