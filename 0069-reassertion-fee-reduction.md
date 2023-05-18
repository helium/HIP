# HIP-69: Re-assertion Fee Reduction

- Author(s): @therealjohnmac50
- Start Date: 2022-07-24
- Category: Economy
- Original HIP PR: <https://github.com/helium/HIP/pull/453>
- Tracking Issue: <https://github.com/helium/HIP/issues/458>

# Summary

The average daily mining reward per hotspot is currently equal to around 18,500 DC; and it costs
1,000,000 DC to reassert a hotspot's location.

As a result, it would take more than a month for the average hotspot to earn enough DC to pay for
one location assertion.

Therefore, if we are trying to expand the network and want hotspots in saturated areas to move into
less saturated areas, want to ease the burden on new people joining the network, and ease the burden
on people making human errors, the current reassertion fee is not viable and needs to be reduced.

Please note that it is likely the hotspots which are earning below average income, are the ones that
would want to change locations most, so the current assertion costs would be greater than 30 days
average earnings for those hotspots.

# Stakeholders

In reality, since the amount of DC burned has an economic impact, this hip (indirectly) affects
everyone. Directly, this HIP affects everyone that is reasserting their hotspots. Additionally,
since maker apps are used to assert locations, this HIP directly affects all owners of maker apps.

# Detailed Explanation

The average daily mining reward per hotspot is currently equal to around 18,500 DC; and it costs
1,000,000 DC to reassert a hotspot's location.

As a result, it would take more than a month for the average hotspot to earn enough to pay for one
location reassertion.

Therefore, if we are trying to expand the network and want hotspots in saturated areas to move into
less saturated areas (or moreover in lone wolf like areas), want to ease the burden on new people
joining the network, and ease the burden on people making human errors, the current reassertion fee
is not viable and needs to be reduced.

Furthermore, in terms of the "this will help gamers/location spoofers," many gamers assert their
hotspot’s locations inaccurately and will soon be caught by the new denylist algorithm (regardless
of assertion fee cost). What do we need to identify the gamers/spoofers? Many more location
assertions. How do we get more location assertions? By offering this (temporary) assertion fee
discount.

In order to help expand the network and accomplish obtaining (the aforementioned) location assertion
data, I'm proposing that the reassertion price be reduced from 1,000,000 DC to half (which is
500,000 DC) for 3 (three) months post HIP-70's transition to Solana.

Please note that I specifically chose 500,000 DC and not less (say 10,000 DC), to help prevent
people from taking advantage of reduced reassertion fees, and to lessen the economic effect on the
Network.

If approved by community (HNT) vote, this HIP will reduce **all** location assertion fees in half, for three
months, beginning immediately upon the migration to Solana, and will revert back after three months.

No new (blockchain) code is required, since this may be accomplished via chain variables. However,
maker apps will have to update their apps to request the lower (500,000 DC) amount (at the start of
the 3 month period,) and they will need to update their apps to request the original (1,000,000 DC)
amount at the end of the three month period. That being said, makers are in essence being paid to
make these changes, since the end result is that their 1st ($10) location/onboarding assertion costs will
be reduced by 50%.

_Please note that this HIP does **not** impact 5G CBRS gateways & radios._

# Drawbacks

Location spoofers may benefit from reduced reassertion fees. Nevertheless, it will provide the
necessary data for the new algorithm to catch dishonest location assertions.

# Rationale

Not doing this can possibly result in people who may have moved from an over saturated areas to much
less saturated areas, but may not do so on the notion that the reassertion fee in and of itself
would cost many months (if not longer) worth of mining. Additionally, without this HIP, the
reassertion fee burden will not be lighter for those joining the network (for example people who
purchase a second hand hotspot and need to reassert their location), and those who made human errors
(such as "fat finger" mistakes of placing their hotspots into the wrong location accidentally).
Furthermore, without this HIP, there may be many dishonest location assertions that will not be
caught- due to the potential lack of (additional) location assertion data.

# Unresolved Questions

Regarding the economic effect, burning less HNT as a result of reduced reassertion fees, has a
negative economic impact. However, there may end up being more DC burned from more location
assertions (than there were prior to the reassertion fee reduction.) Thus, the question remains, will this HIP impact
the Network's economics negatively or positively?

# Success Metrics

Success may be measured, once we see more location assertions occurring than there were prior to the
implementation of this HIP.
