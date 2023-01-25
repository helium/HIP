# HIP Draft: Linear Lockup Curve for veHNT, veIOT and veMOBILE

- Author(s): @ferebee
- Start Date: 2023-01-23
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

This proposal simplifies the relationship between the lockup duration of HNT locked by HNT holders as specified by HIP-51, and the amount of veHNT issued to their locked positions. The mechanics described here in terms of HNT and veHNT will apply equally to veMOBILE and veIOT when they are introduced.

# Motivation

A simpler veHNT distribution function is more equitable and removes counterintuitive and complicated incentives implied by HIP-51 for participants seeking to optimize their veHNT allocation.

HIP-51 specifies a voting power multiplier of 100x for a lockup period of 48 months, and 1x for the minimum lockup period of 6 months.

Therefore, the function that determines the allocation of veHNT on lockup is different from the linear decay function as determined by the Curve and Tribeca models referenced in HIP-51. This is difficult to implement using existing tools, and gives counterintuitive results in certain cases.

If the veHNT allocation is changed to a simple multiplier of lockup duration, the implementation is simplified, and additional features become practical, such as the ability to extend the lock duration of a locked position at any time, or add HNT to an existing locked position, with results that are intuitive and easy to understand.

The simpler the design, the sooner and more safely it can be implemented.

HIP-51 also specifies that veHNT is represented as a fully non-transferable non-fungible coupon in the user’s HNT address. In the case of a wallet compromise, all veHNT would be lost. Therefore, we propose to represent the veHNT position as a transferable non-fungible token.

# Stakeholders

This proposal is relevant to all holders of HNT who intend to lock HNT to receive veHNT, and existing validator operators who have not completed cooldown at the Solana L1 transition. As we also propose to eliminate the minimum 6 month lockup period, it is relevant to HNT holders who may previously have not considered locking their HNT due to the 6 month minimum lockup period specified in HIP-51.

# Detailed Explanation

HIP-51 specifies that HNT must be locked for a minimum of 6 months in order to receive veHNT, and that HNT locked for 6 months should receive 1x veHNT per HNT. HNT locked for the maximum duration of 48 months will receive 100x veHNT per HNT. The lockup function is [specified](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#vehnt-and-governance) with a graph in HIP-51.

Using available tools and following the specification of the Curve implementation referenced in HIP-51, when cooldown is triggered for a position of locked HNT, the amount of associated veHNT will decay linearly to zero over the entire lockup duration. Therefore, during decay, it will not follow the lockup curve specified in HIP-51.

As the cooldown decay curve is linear, but different from the lockup curve, the amount of veHNT associated with an HNT position during cooldown would be different from the amount of veHNT associated with a similar HNT position that is newly locked for the same lock duration.

For example, if 1 HNT is newly locked for 6 months, HIP-51 specifies that it will receive 1 veHNT. However, if 1 HNT is locked for 48 months, receiving 100 veHNT, and then enters cooldown for 42 months, so that its remaining lockup time is 6 months, it still has 100-100*(42/48) veHNT, or 12.5 veHNT, at that moment. (See image below.)

It would be simpler for all participants, reduce complexity, and improve equitability and the incentive to lock HNT, if a position of HNT locked for 6 months had the same associated amount of veHNT under all circumstances.

Therefore, we propose to remove the special-case provision that a 6-month lockup receive a 1x veHNT multiplier, instead of the 12.5x multiplier implied by the linear decay function.

We also propose that the 6-month minimum lockup period be removed, and HNT holders be allowed to lock HNT for any desired period, including periods less than 6 months.

Instead, veHNT will depend on locked HNT times lockup duration in a simple linear fashion.

The amount of veHNT associated with a locked position of HNT will be determined by the linear function

	veHNT(m) = m * 100 / 48
	
such that a lockup period of 48 months receives a 100x veHNT multiplier, a lockup period of 6 months receives a 12.5x veHNT multiplier, and a lockup period of 1 month receives a 2.0833x veHNT multiplier.

![veHNT curve HIP](https://user-images.githubusercontent.com/1608050/214618746-33cecad9-3de0-4e7c-a420-799347c476a2.png)

The 6 month lockup period specified in HIP-51 for validator stakes that have not completed cooldown at L1 transition will continue to apply, but the associated validator HNT accounts will receive 12.5x veHNT, or 125,000 veHNT per 10,000 HNT validator stake, instead of 10,000 veHNT as specified in HIP-51.

These 125,000 veHNT per validator will be subject to the 3x multiplier for staking in the initial 7-day landrush period after the Solana L1 transition, and thus the total veHNT issued to validator accounts will be 375,000. This will revert back to 125,000 at the end of the 6-month 3x multiplier bonus period, unless the lockup period is extended within the landrush period.

Equally, any HNT holder may lock HNT for 6 months and receive 12.5x veHNT instead of 1x veHNT as specified in HIP-51, with an additional 3x multiplier if locked within the initial 7-day landrush period.

The veHNT allocation for a 48-month lockup remains unchanged at 100x veHNT, or 300x with landrush multiplier if applicable.

The behavior of the 3x landrush multiplier is unchanged from HIP-51. To clarify, the 3x multiplier remains in effect for the duration of HNT lockup set during the 7-day landrush period, even if the HNT lockup is extended to a longer duration after the end of landrush.

# Transferability

The proposal in HIP-51 to represent veHNT as a non-transferable coupon in the user wallet raises security concerns in case of a wallet compromise. Therefore, we propose that veHNT be represented instead as an NFT. As the HNT remains locked and cannot be used in payment or DC burn transactions, the result of this is similar to the existing situation with validator stakes, which may be transferred to a new wallet while staking a new validator.

[... further details to follow pending technical discussion…]

# Consequences

As the requirement for a 6-month minimum lockup duration is removed in this HIP, this change to veHNT allocation will make veHNT accessible to all participants willing to lock HNT for any duration, with no 6 month minimum.

It will simplify implementation, as the existing code from Solana voter stake registry projects, such as Curve/veCRV, will become directly applicable to the veHNT lockup function.

It will continue to make long-term lockup attractive, as the highest allocation of veHNT will still be reserved for the longest 48-month lockup duration.

With respect to veHNT positions being represented as non fungible tokens, it greatly improves the UX around positions. Positions will be visible in any wallet, and able to be moved in the case of a compromise. This makes delegation to subdaos semantically easier, as users can easily manage multiple positions, delegating to different subdaos. 

# Drawbacks

A possible disadvantage of changing the veHNT allocation would be that it would discourage participants from locking HNT for longer periods.

Since maximum veHNT allocation still requires locking HNT for the maximum period of 48 months, we believe that this is a minor concern.

Removing the soulbound requirement on veHNT positions potentially means that owners of locked HNT could sell their positions. Due to the nature of soulbound positions, they are easily circumvented by smart contracts similar to liquid staking smart contracts.Given the difficulty in guaranteeing these positions stay soulbound, we think it is better for the whole position to be transferable so that we can foster a better user experience.

# Deployment Impact

Based on discussions with engineers currently implementing HIP-51, we believe that adopting this HIP will significantly accelerate the engineering effort required for the transition to the Solana blockchain, which is required for the adoption of HIP-51 and HIP-70.

The 6-month minimum lockup period for legacy validator stakes that have not completed cooldown at transition is unaffected. Validator stakes that transition to locked HNT will be assigned the same 6-month lockup period, but will benefit from a 12.5x veHNT multiplier instead of the 1x multiplier specified in HIP-51.

The additional 3x multiplier available to all lockups completed during the initial 7-day “genesis” period remains available as specified in HIP-70.
