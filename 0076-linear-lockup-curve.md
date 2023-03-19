# HIP 76: Simplify Lockup and veTokens

- Author(s): @ferebee
- Start Date: 2023-02-14
- Category: Economic
- Original HIP PR: #547
- Tracking Issue: #560

# Summary

HIP-51 specifies that holders of HNT may lock their HNT for up to 48 months in order to receive
veHNT (vote-escrowed HNT). veHNT conveys voting power in the Helium DAO and may be delegated to a
subDAO. The combination of HNT locked for a duration, together with the assigned veHNT, is called a
position. One wallet may contain multiple positions.

With this HIP, we propose simplifying the relationship between lockup duration and the associated
amount of veHNT, eliminating the minimum lockup period, introducing a 1 HNT minimum per lockup
position, and clarifying certain rules relating to the “landrush” bonus.

**1. Simplify lockup**

HIP-51 specifies that the amount of veHNT returned when HNT is locked should increase linearly from
1x veHNT per HNT at the minimum lockup duration of 6 months all the way to 100x veHNT per HNT at 48
months. However, when a locked HNT position enters cooldown, the associated veHNT follows a
different curve and instead declines linearly to zero over the entire period. These asymmetric
lockup and cooldown functions have counterintuitive consequences.

We propose simplifying the lockup function by specifying a linear relationship between the lockup
period and the associated veHNT multiplier, assigning 0x veHNT at 0 months and 100x veHNT at 48
months, valid equally at lockup and cooldown. This would eliminate the special-case provision for a
6-month duration with 1x veHNT and therefore increase the veHNT multiplier for short lockup
durations.

**2. Eliminate minimum period**

We propose eliminating the 6-month minimum lockup period, allowing participants to lock for any
desired period up to the maximum, including shorter periods with an accordingly smaller associated
amount of veHNT. Validator stakes that roll over into locked HNT will still be locked for 6 months.

**3. Introduce 1 HNT minimum lockup**

We propose introducing a 1 HNT minimum per lockup position to prevent spam positions.

**4. Specify 3x landrush rules**

We define rules of operation for the special-case 3x “landrush” veHNT multiplier that HIP-70
introduced but did not specify in detail.

HIPs prior to HIP-76 define subDAO veTokens and establish rules concerning the amount of veDNT that
is associated with the lockup of a DNT. Given that mechanisms of subDAO governance do not currently
exist by which these rules could be modified, and in the interest of establishing uniform veToken
lockup curves across the Helium DAO and its subDAOs at Solana transition, HIP-76 modifies the
provisions of existing HIPs concerning the amount of veDNT associated with DNT lockup positions in
the same way as it modifies the provisions concerning the amount of veHNT associated with HNT lockup
positions.

Specifically, the veDNT lockup curves defined in prior HIPs are modified such that veDNT shall be
associated with DNT lockup durations in a linear fashion for any duration, and there shall be no
minimum duration, insofar as prior HIPs specify otherwise.

Existing HIPs prior to HIP-76 do not specify a landrush period for the lockup of subDAO tokens. If
a subDAO landrush period is introduced by HIP or subDAO governance, the provisions of HIP-76
concerning the 3x landrush period of HNT lockup shall apply equally to the landrush period of the
lockup of the subDAO DNT, to the extent that a HIP or the subDAO do not introduce provisions
superseding them.

HIP-76 shall not be construed to establish any precedent concerning subDAO governance.

# Motivation

The current model of veHNT lockup does not ideally support long-term incentives. To encourage as
many participants as possible to lock their HNT and participate in governance, the relationship
between the lockup period and the resulting veHNT multiplier should be simple and easy to
understand. The more flexible and convenient the lockup procedure can be made, the more approachable
it will become.

As the implementation of veHNT has progressed, additional operations not described in HIP-51 have
become possible that encourage lockup, such as the ability to extend the lockup period of already
locked HNT. In some cases, these operations expose counterintuitive properties of the lockup
function specified by HIP-51. For example, in some cases, extending the lockup period of an HNT
position could reduce the associated veHNT multiplier.

Changing the lockup curve to a simple linear function, which is easier to understand, removes these
counterintuitive edge cases. Implementation becomes significantly simpler, quicker, and safer.

The provision in HIP-51 of a 1x veHNT multiplier for a 6-month lockup was intended to encourage
participants to lock HNT for longer durations. Yet, it provides an incentive to lock less total HNT.
Under the schedule of HIP-51, if a participant were to consider locking 100 HNT for 6 months, they
would receive 100 veHNT. However, they could receive the same 100 veHNT by locking just 1 HNT for 48
months, leaving the other 99 HNT unlocked. This outcome would increase optionality for the
participant while decreasing the total amount of locked HNT.

Therefore, the linear lockup function proposed in this HIP will encourage greater total lockup and
thereby promote long-term goals.

Similarly, we propose dropping the 6-month minimum lockup period for simplicity and to encourage
maximum participation.

For background, the 6-month minimum lockup period was intended to prevent holders of large HNT
wallets from dominating governance by locking their HNT for short periods. However, even with the
linear lockup function, a 1-month lockup receives just over 2% the veHNT multiplier of a 48-month
lockup, and a 1-day lockup receives less than 0.1% the veHNT multiplier of a 48-month lockup.

Further, HIP-51 does not specify a minimum amount of HNT that can be locked into one position.

Given the low transaction costs on the Solana blockchain, a bad actor could conceivably create many
positions, spamming the smart contract in a nuisance attack. To make this impractical, we propose to
require a minimum of 1 HNT per lockup position.

Finally, we make the rules governing 3x landrush positions explicit to document the behavior of the
veHNT implementation that is being developed in accordance with HIP-70, which does not specify
details.

In summary, the motivation of this HIP is to improve governance, usability, and long-term
engagement, and to provide clarity on the rules governing landrush.

# Stakeholders

This proposal is relevant to:

- All holders of HNT who intend to lock HNT to receive veHNT.
- Existing validator operators who still need to complete cooldown at the Solana L1 transition.
- As we also propose to eliminate the minimum 6-month lockup period, it is relevant to HNT holders
  who may not have considered locking their HNT due to the 6-month minimum lockup period specified
  in HIP-51.

# Simplified Lockup Curve

HIP-51 specifies that HNT must be locked for a minimum of 6 months in order to receive veHNT, and
that HNT locked for 6 months should receive 1x veHNT per HNT. HNT locked for the maximum duration of
48 months will receive 100x veHNT per HNT. The lockup function is
[specified](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#vehnt-and-governance) with a
graph in HIP-51.

Using available tools and following the specification of the Curve implementation referenced in
HIP-51, a locked position initially maintains the same lockup duration indefinitely. At any time,
the holder of the position may trigger cooldown, and then the amount of associated veHNT will decay
linearly to zero over the entire lockup duration. (Cooldown may also be stopped at any time.)

As the cooldown decay curve is linear but different from the lockup curve specified in HIP-51, the
amount of veHNT associated with an HNT position during cooldown would be different from the amount of
veHNT associated with a similar HNT position that is newly locked for the same lock duration.

For example, if 1 HNT is newly locked for 6 months, HIP-51 specifies that it will receive 1 veHNT.
However, if 1 HNT is locked for 48 months, receiving 100 veHNT, and then enters cooldown for 42
months, its remaining lockup time is 6 months and it still has 100-100\*(42/48) veHNT, or 12.5
veHNT, at that moment. (See image below.)

**It would be simpler for all participants, reduce complexity, and improve equitability of the
incentive to lock HNT, if a position of HNT locked for 6 months had the same associated amount of
veHNT under all circumstances.**

Therefore, we propose to remove the special-case provision of HIP-51 that a 6-month lockup receives
a 1x veHNT multiplier. Instead, it will receive the same veHNT as implied by the linear decay
function, which is 12.5x. E.g, a 100 HNT stake for 6 months will establish a 1250 veHNT position at
the time of staking.

We also propose that the 6-month minimum lockup period be removed and HNT holders be allowed to lock
HNT for any desired period up to 48 months, including periods less than 6 months.

This change will not apply to validator stakes that have not completed cooldown at transition. In
recognition of the fact that validator stakers have already made decisions based on the 6-month
lockup proposed in HIP-70, an automatic 6-month lockup will apply to all validator stakes that roll
over into locked HNT at transition as described in HIP-70.

The implementation calculates veHNT with a granularity of 1 day. The maximum lockup duration,
specified in HIP-51 as 48 months, corresponds to 1461 days.

The amount of veHNT associated with a position of HNT locked for d days will be determined by the
linear function:

    veHNT(d) = d * 100 / 1461

Such that a lockup period of 1461 days receives a 100x veHNT multiplier, a lockup period of 6 months
receives a roughly 12.5x veHNT multiplier, and a lockup period of 30 days receives a 2.0534x veHNT
multiplier.

![veHNT curve HIP](https://user-images.githubusercontent.com/1608050/214618746-33cecad9-3de0-4e7c-a420-799347c476a2.png)

Given this function, a 10,000 HNT validator stake that has not completed cooldown when the Solana L1
transition occurs will receive approximately 12.5x veHNT, or 125,000 veHNT, instead of 10,000 veHNT
as specified in HIP-51.

These 125,000 veHNT per validator will be subject to the 3x multiplier for staking in the initial
7-day landrush period. Thus the total veHNT issued per validator stake will be 375,000. This will
revert back to 125,000 at the end of the 6-month 3x multiplier bonus period, unless the lockup
duration is extended within the landrush period.

Equally, any HNT holder may lock HNT for 6 months and receive 12.5x veHNT instead of 1x veHNT as
specified in HIP-51, with an additional 3x multiplier if locked within the initial 7-day landrush
period.

The veHNT allocation for a 48-month lockup remains unchanged at 100x veHNT, or 300x with landrush
multiplier if applicable.

The behavior of the 3x landrush multiplier is unchanged from HIP-51. To clarify, the 3x multiplier
remains in effect for the duration of the most recent HNT lockup set during the 7-day landrush
period, even if the HNT lockup is extended to a longer duration after the end of the landrush.

# Minimum Lockup Amount

We propose to introduce a minimum HNT lockup amount per position of 1 HNT. This amount is set
through a chain variable and may be modified later through governance.

The intention is to prevent bad actors from creating very large numbers of frivolous lockup
positions and spamming the smart contract.

# Landrush 3x Multiplier

HIP-70 specifies a 7-day “landrush” period, beginning at the completion of the Helium L1 transition
to Solana. (It is called a “genesis” period in HIP-70 but has since been renamed to “landrush” to
avoid confusion with 5G Genesis rewards.)

HNT locked during landrush receives an additional 3x veHNT multiplier as specified in HIP-70. We now
specify rules that apply to locked HNT positions that have received the 3x multiplier (“landrush
positions”), according to the veHNT implementation as currently in development.

At any time during the landrush, a wallet owner may open one or multiple HNT positions locked to any
duration up to 48 months. Wallets with staked validators that have not completed validator cooldown
at transition will automatically receive a locked HNT position with a 6-month lockup duration
containing 10,000 locked HNT per staked validator.

During the 7-day landrush period, the following rules apply.

- A landrush position may be split into multiple landrush positions, which may be extended or
  delegated separately.
- The lockup duration may be extended up to the maximum of 48 months.
- HNT may be added to the landrush position.
- The position may be delegated to a subDAO or re-delegated to a different subDAO.
- Cooldown may be started or stopped.

At the end of the landrush, the duration of the 3x landrush multiplier is set to whatever the lockup
duration of the locked HNT position is.

The duration of the landrush multiplier is counted from the day at which the lockup was last set or
extended during the landrush, or from the day of L1 transition in the case of validator stakes which
were automatically rolled over to locked positions and not extended during the landrush.

After the 7-day landrush period ends, the following rules apply to landrush positions:

- The position may be split, but the landrush multiplier stays with the original position. The new
  position is not a landrush position and receives no 3x multiplier.
- The lockup duration may be extended. However, this does not extend the duration of the 3x landrush
  multiplier.
- No additional HNT may be transferred into the landrush position.
- The position may be delegated or re-delegated.
- Cooldown may be started or stopped.

At the end of the duration of the 3x landrush multiplier, as determined at the end of the landrush, the
3x multiplier ends, and the landrush position reverts to a regular position.

# Consequences of this HIP

As the requirement for a 6-month minimum lockup duration is removed by this HIP, the change to veHNT
allocation will make veHNT accessible to all participants willing to lock HNT for any duration, with
no 6-month minimum.

It will continue to make long-term lockup attractive, as the highest allocation of veHNT will still
be reserved for the longest 48-month lockup duration.

It will simplify implementation for Helium Core Devs with respect to smart contract development on
Solana and Realms.

The minimum lockup requirement should not affect legitimate participants.

The landrush provisions of this proposal clarify the rules of the implementation currently under
development, so participants who wish to lock HNT can make informed decisions. They do not change
the behavior specified in HIP-70.

# Drawbacks

A possible disadvantage of changing the veHNT allocation could be that it would discourage
participants from locking HNT for longer periods.

Since maximum veHNT allocation still requires locking HNT for the maximum period of 48 months, we
believe this is a minor concern.

Similarly, removing the minimum requirement of a 6-month lockup duration could encourage
participants to consider shorter rather than longer lockup durations.

Again, we believe that the linear veHNT allocation function provides sufficient incentives such that
most participants will favor longer durations.

# Deployment Impact

Based on discussions with engineers currently implementing HIP-51 and HIP-70, we believe that
adopting this HIP will significantly accelerate the engineering effort required for the transition
to the Solana blockchain. By reducing the complexity of the implementation, it will enhance security
and reduce the cost of changes should they become necessary in the future.

The 6-month minimum lockup period for legacy validator stakes that have not completed cooldown at
transition is unaffected. Validator stakes that transition to locked HNT will be assigned the same
6-month lockup period, but will benefit from a 12.5x veHNT multiplier instead of the 1x multiplier
specified in HIP-70.

Other participants will be able to lock HNT for any period without a 6-month minimum. The veHNT
multipliers for short lock durations will be significantly higher than those specified by HIP-51.

The landrush 3x multiplier remains available as originally specified in HIP-70.
