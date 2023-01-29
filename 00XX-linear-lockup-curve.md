# HIP Draft: Simplify Lockup and veTokens

- Author(s): @ferebee
- Start Date: 2023-01-23
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

HIP-51 specifies that holders of HNT may lock their HNT for a period of up to 48 months in order to receive veHNT (vote-escrowed HNT). veHNT conveys voting power in the Helium DAO, and may be delegated to a subDAO to receive a share of subDAO token emissions. The combination of HNT locked for a particular duration, combined with the assigned veHNT, is called a “position”. One wallet may contain multiple positions.

The amount of veHNT returned on lockup increases linearly per HIP-51 from 1x veHNT per HNT at the minimum lockup duration of 6 months, all the way to 100x veHNT per HNT at 48 months. However, when a locked HNT position enters cooldown, the associated veHNT follows a different curve and instead declines linearly to zero over the entire period. These asymmetric lockup and cooldown functions have unintuitive consequences.

**1. Simplify lockup**

We propose to simplify the lockup function by specifying a linear relation between the lockup period and the associated veHNT multiplier, assigning 0x veHNT at 0 months and 100x veHNT at 48 months, valid equally at lockup and cooldown. This would eliminate the special-case provision for a 6-month duration with 1x veHNT and accordingly increase the veHNT multiplier for short lockup durations in general.

**2. Eliminate minimum period**

We propose to eliminate the 6-month minimum lockup period, allowing participants to lock for any desired period up to the maximum, including shorter periods with an accordingly smaller associated amount of veHNT.

**3. Make veHNT transferable**

While HIP-51 specifies that veHNT be “fully non-transferable” and bound to the originating wallet, we propose that veHNT should be transferable along with the underlying HNT, for security reasons.

**4. Specify 3x landrush rules**

Finally, in accordance with the veHNT implementation as currently under development by Helium Foundation, we specify operation rules for the special-case 3x “landrush” multiplier introduced to veHNT by HIP-70.

The mechanics described here in terms of HNT and veHNT will apply equally to veMOBILE and veIOT when they are introduced.

As HIPs 51–53 and HIP-70 do not specify a 3x landrush period for IOT and MOBILE, the landrush provisions will only apply to a subDAO token if the subDAO introduces its own landrush period for its veToken.

# Motivation

In order to encourage as many participants as possible to lock their HNT and participate in governance, the relationship between lockup period and resulting veHNT multiplier should be simple and easy to understand, and the more flexible and convenient the lockup procedure can be made, the more approachable it will become.

As the implementation of veHNT has progressed, additional operations not described in HIP-51 have become possible that encourage lockup, such as the ability to extend the lockup period of already locked HNT. In some cases, these operations expose counterintuitive properties of the lockup function specified by HIP-51. For example, it is possible to extend the lockup period of an HNT position and thereby reduce the associated veHNT multiplier.

Changing the lockup curve to a simple linear function, which is easier to understand, also removes these counterintuitive edge cases. In addition, implementation becomes significantly simpler and therefore possibly quicker and safer.

The provision in HIP-51 of a 1x veHNT multiplier for a 6-month lockup was intended to encourage participants to lock HNT for longer durations. However, considering that locking 1 HNT for 48 months returns 100 veHNT, while locking 100 HNT for 6 months also returns 100 veHNT, the 6-month lockup is entirely unattractive. Instead of locking 100 HNT for 6 months, it would almost always be more attractive to lock 1 HNT for 48 months and keep 99 HNT completely unlocked.

Therefore, we believe the linear lockup function will actually encourage greater total lockup.

The 6-month minimum lockup period was intended to prevent holders of large HNT wallets from dominating governance by locking their HNT for short periods. However, even with the linear lockup function, a 1-month lockup receives just over 2% the veHNT multiplier of a 48-month lockup, and a 1-day lockup receives less than 0.1% the veHNT multiplier of a 48-month lockup.

Therefore, we hold that both for simplicity, and to encourage maximum participation, the 6-month minimum should be dropped.

HIP-51 specifies that veHNT should be “fully non-transferable”, meaning that the locked HNT position and the associated veHNT would be bound to the originating wallet.

An HNT position can be locked for 48 months, or longer if it does not enter cooldown. There is a significant chance that the originating wallet could be compromised during that time, such as through a security breach of the host system or through a security flaw in a wallet application. In such a case, the entire HNT/veHNT position could be lost if there is no way to transfer the position.

Therefore, we propose that locked positions be made transferable. Other operations would still be disabled, such as payment transfers or HNT burn to DC.

Finally, we make the rules governing 3x landrush positions explicit to document the behavior of the veHNT implementation that is being developed in accordance with HIP-70, which does not specify details.

# Stakeholders

This proposal is relevant to all holders of HNT who intend to lock HNT to receive veHNT, and existing validator operators who have not completed cooldown at the Solana L1 transition. As we also propose to eliminate the minimum 6 month lockup period, it is relevant to HNT holders who may previously have not considered locking their HNT due to the 6 month minimum lockup period specified in HIP-51.

# Detailed Explanation

HIP-51 specifies that HNT must be locked for a minimum of 6 months in order to receive veHNT, and that HNT locked for 6 months should receive 1x veHNT per HNT. HNT locked for the maximum duration of 48 months will receive 100x veHNT per HNT. The lockup function is [specified](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#vehnt-and-governance) with a graph in HIP-51.

Using available tools and following the specification of the Curve implementation referenced in HIP-51, when cooldown is triggered for a position of locked HNT, the amount of associated veHNT will decay linearly to zero over the entire lockup duration.

As the cooldown decay curve is linear, but different from the lockup curve, the amount of veHNT associated with an HNT position during cooldown would be different from the amount of veHNT associated with a similar HNT position that is newly locked for the same lock duration.

For example, if 1 HNT is newly locked for 6 months, HIP-51 specifies that it will receive 1 veHNT. However, if 1 HNT is locked for 48 months, receiving 100 veHNT, and then enters cooldown for 42 months, so that its remaining lockup time is 6 months, it still has 100-100*(42/48) veHNT, or 12.5 veHNT, at that moment. (See image below.)

It would be simpler for all participants, reduce complexity, and improve equitability and the incentive to lock HNT, if a position of HNT locked for 6 months had the same associated amount of veHNT under all circumstances.

Therefore, we propose to remove the special-case provision that a 6-month lockup receive a 1x veHNT multiplier, instead of the 12.5x multiplier implied by the linear decay function.

We also propose that the 6-month minimum lockup period be removed, and HNT holders be allowed to lock HNT for any desired period, including periods less than 6 months.

Instead, veHNT will depend on locked HNT times lockup duration in a simple linear fashion.

The amount of veHNT associated with a position of HNT locked for m months will be determined by the linear function

	veHNT(m) = m * 100 / 48
	
such that a lockup period of 48 months receives a 100x veHNT multiplier, a lockup period of 6 months receives a 12.5x veHNT multiplier, and a lockup period of 1 month receives a 2.0833x veHNT multiplier.

![veHNT curve HIP](https://user-images.githubusercontent.com/1608050/214618746-33cecad9-3de0-4e7c-a420-799347c476a2.png)

The 6 month lockup period specified in HIP-51 for validator stakes that have not completed cooldown at L1 transition will continue to apply, but the associated validator HNT accounts will receive 12.5x veHNT, or 125,000 veHNT per 10,000 HNT validator stake, instead of 10,000 veHNT as specified in HIP-51.

These 125,000 veHNT per validator will be subject to the 3x multiplier for staking in the initial 7-day landrush period after the Solana L1 transition, and thus the total veHNT issued to validator accounts will be 375,000. This will revert back to 125,000 at the end of the 6-month 3x multiplier bonus period, unless the lockup period is extended within the landrush period.

Equally, any HNT holder may lock HNT for 6 months and receive 12.5x veHNT instead of 1x veHNT as specified in HIP-51, with an additional 3x multiplier if locked within the initial 7-day landrush period.

The veHNT allocation for a 48-month lockup remains unchanged at 100x veHNT, or 300x with landrush multiplier if applicable.

The behavior of the 3x landrush multiplier is unchanged from HIP-51. To clarify, the 3x multiplier remains in effect for the duration of HNT lockup set during the 7-day landrush period, even if the HNT lockup is extended to a longer duration after the end of landrush.

# Transferability

The proposal in HIP-51 to represent veHNT as a non-transferable coupon in the user wallet raises security concerns.

If the originating wallet were compromised, an attacker could delegate the veHNT to a subDAO of their choice or vote in Helium DAO governance at any time, could potentially drain any awarded subDAO tokens, and could possibly drain the underlying HNT from the compromised wallet the moment cooldown is completed. With no ability to transfer the position out, the wallet owner would remain helpless for the duration of the lock.

Therefore, we propose that veHNT together with the underlying HNT be represented as a transferable NFT. As the HNT remains locked and cannot be used in payment or DC burn transactions, the result of this is similar to the existing situation with validator stakes on the legacy Helium blockchain, which may be transferred to a new wallet while staking a new validator. While the locked HNT position can be moved between wallets, it cannot enter the free float.

# Landrush 3x Multiplier

HIP-70 specifies a 7-day “landrush” period, beginning at the completion of the Helium L1 transition to Solana. (It is called a “genesis” period in HIP-70, but has since been renamed to “landrush” to avoid confusion with 5G Genesis rewards.)

HNT locked during landrush receives an additional 3x veHNT multiplier as specified in HIP-70. We now specify rules that apply to locked HNT positions that have received the 3x multiplier (“landrush positions”), according to the veHNT implementation as currently in development.

At any time during landrush, a wallet owner may open one or multiple HNT positions locked to any duration up to 48 months. Wallets with staked validators, that have not completed validator cooldown at transition, will automatically have each 10,000 HNT validator position migrated as a locked HNT position with a 6-month lockup duration.

During the 7-day landrush period, the following rules apply.
- The landrush position may be split into multiple landrush positions, which may be extended or delegated separately.
- The lockup duration may be extended to the maximum 48 months.
- HNT may be added to the landrush position.
- The landrush position may be transferred to another wallet. The veHNT and underlying HNT are transferred as one unit into the new wallet.
- The position may be delegated to a subDAO, or re-delegated to a different subDAO.

At the end of landrush, the duration of the 3x landrush multiplier is set to whatever the lockup duration of the position is. The duration of the landrush multiplier is counted from the moment of L1 transition.

After landrush ends, the following rules apply to landrush positions:
- The position may be split, but the landrush multiplier stays with the original position. The new position is not a landrush position and receives no 3x multiplier.
- The lockup duration may be extended. However, this does not extend the duration of the 3x landrush multiplier.
- No additional HNT may be transferred into the landrush position.
- The landrush position may be transferred to another wallet, and remains a landrush position.
- The position may be delegated or re-delegated.

At the end of the duration of the 3x landrush multiplier, as determined at the end of landrush, the 3x multiplier ends, and the landrush position reverts to a regular position.

# Consequences

As the requirement for a 6-month minimum lockup duration is removed in this HIP, this change to veHNT allocation will make veHNT accessible to all participants willing to lock HNT for any duration, with no 6 month minimum.

It will simplify implementation, as the existing code from Solana voter stake registry projects, such as Curve/veCRV, will become directly applicable to the veHNT lockup function.

It will continue to make long-term lockup attractive, as the highest allocation of veHNT will still be reserved for the longest 48-month lockup duration.

With respect to veHNT positions being represented as non fungible tokens, it will greatly improve the UX around positions. Positions will be visible in any Solana wallet, and able to be transferred out in the case of a compromise. Delegation to subDAOs becomes semantically easier, as users can easily manage multiple positions, delegating them to different subDAOs. 

# Drawbacks

A possible disadvantage of changing the veHNT allocation could be that it would discourage participants from locking HNT for longer periods.

Since maximum veHNT allocation still requires locking HNT for the maximum period of 48 months, we believe that this is a minor concern.

Similarly, removing the minimum requirement of a 6-month lockup duration could encourage participants to consider shorter rather than longer lockup durations.

Again, we believe that the linear veHNT allocation function provides sufficient incentives such that most participants will favor longer durations.

Permitting the transfer of veHNT positions between wallets potentially allows owners of locked HNT to sell their positions, reducing the effectiveness of token lock. This is conceptually similar to the way current validator operators can sell their validator stake.

We believe that the restrictions on locked positions, which disallow payment transfers and HNT burn, sufficiently restrict the liquidity of locked positions. Even if locked positions were bound to the originating wallets, their lock could in principle be circumvented by smart contracts similar to liquid staking smart contracts. Therefore, we believe the benefits to security and user experience of allowing transfers outweigh the potential drawbacks.

# Deployment Impact

Based on discussions with engineers currently implementing HIP-51 and HIP-70, we believe that adopting this HIP will significantly accelerate the engineering effort required for the transition to the Solana blockchain. By reducing the complexity of the implementation, it will enhance security and reduce the cost of changes should they become necessary in the future.

The 6-month minimum lockup period for legacy validator stakes that have not completed cooldown at transition is unaffected. Validator stakes that transition to locked HNT will be assigned the same 6-month lockup period, but will benefit from a 12.5x veHNT multiplier instead of the 1x multiplier specified in HIP-51.

Other participants will be able to lock HNT for any period without a 6-month minimum. The veHNT multipliers for short lock durations will be significantly higher than those specified by HIP-51.

The landrush 3x multiplier remains available as originally specified in HIP-70.
