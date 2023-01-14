# HIP 69: Re-assertion Fee Reduction

- Author(s): @therealjohnmac50
- Start Date: 2022-07-24
- Category: Economy
- Original HIP PR: <https://github.com/helium/HIP/pull/453>
- Tracking Issue: <https://github.com/helium/HIP/issues/458>
- Status: In Discussion

# Summary

The average daily mining reward per Hotspot is currently equal to around 50,000 DC; and it costs
1,000,000 DC to reassert a Hotspot's location.

As a result, it would take nearly a month for the average Hotspot to earn enough to pay for one
location reassertion.

Therefore, if we are trying to expand the network and want Hotspots in saturated areas to move into
less saturated areas, want to ease the burden on new people joining the network, and ease the burden
on people making human errors, the current reassertion price is not viable and needs to be reduced.

# Stakeholders

In reality, since the amount of DC burned has an economic impact, this hip affects everyone.
Directly, this hip affects everyone that is reasserting their Hotspots. Additionally, since people
will need to be able to see their reassertion fee amounts prior to submitting the reassertion fee DC
burn transaction which is a function of the Vendor Apps, this HIP directly affects all owners of
Vendor apps.

# Detailed Explanation

The average daily mining reward per Hotspot is currently equal to around 50,000 DC; and it costs
1,000,000 DC to reassert a Hotspot's location.

As a result, it would take nearly a month for the average Hotspot to earn enough to pay for one
location reassertion.

Therefore, if we are trying to expand the network and want Hotspots in saturated areas to move into
less saturated areas (or moreover in lone wolf like areas), want to ease the burden on new people
joining the network, and ease the burden on people making human errors, the current reassertion
price is not viable and needs to be reduced.

In order to help expand the network and ease the burden on new people joining the network, I'm
proposing that the reassertion price be reduced from 1,000,000 DC, to half which is 500,000 DC.

Please note that I specifically chose 500,000 DC and not less (say 10,000 DC), to help prevent
people from taking advantage of reduced reassertion fees, and to lesson the economical effect on the
Network.

If approved by community (HNT) vote, this HIP will reduce **all** assertion fees in half, for three
months, beginning immediately upon the migration to Solana, and will revert back after three months.

No code is required, since this may be accomplished via chain vars.

**PLEASE NOTE THAT FROM THIS POINT ON IS NO LONGER RELEVANT, ALL OF THE BELOW WILL NOT BE VOTED ON,
AND MUST BE REWRITTEN IN A NEW HIP.**

In addition, to prevent location spoofing as a result of reassertion fees deduction, any given
individual Hotspot may only have its reassertion fees reduced every 525k blocks (approximately once
per year).

Furthermore, in order to help prevent abuse of the reassertion fee reduction, there will be a
minimum distance of 10KM (between the original location to the reasserted location) requirement.

Finally, the reassertion fee reduction will only apply to those inserting their Hotspots into Res8
hexes of < 3 (less than three) hotpots.

With the reassertion fees reduced to 500,000 DC, it would still require the average Hotspot to spend
approximately 10 days worth of mining for the reassertions.

Thus, the 500,000 DC fee in addition to the three aforementioned gaming prevention methods are still
preventing excessive/unnecessary reassertions, while also making it easier for those that want to
expand the network and actually move their Hotspots locations to that end.

**To clarify all methods provided to help prevent location spoofing or gaming as a result of the
reassertion fees deduction in summary:**

- This HIP only applies to **RE**assertions. Not the first assertion/onboarding. To clarify, the
  original/first location assertion price will not be changed, merely the reassertion prices (from
  the 2nd assertion and on.)

- This HIP only applies to those who are REasserting their Hotspots to a distance equal to or
  greater than 10km (away from the original location point that is being changed). As a direct
  result, this HIP will not help those trying to increase their TS scales.

- This HIP only applies to REassertions, equal to or greater than 10km away from the original
  location, and only to those who are reasserting their Hotspots into Res8 hexes with less than 3
  Hotspots (equal to or less than 2 Hotspots). This gaming prevention method will help enforce the
  core goal of this HIP, which is to ease the burden on those that are trying to expand the network.

- The reassertion fee reduction will be limited to once per Hotspot per year. Meaning, after a given
  Hotspot's first reassertion fee reduction, said Hotspot would need to wait 525k blocks
  (approximately one year) in order to be eligible for its second reassertion fee reduction. This
  gaming prevention method will ultimtately limit any potential abuse of the reassertion fee
  reduction to no more than once per Hotspot per year.

- _All other location assertions, that do not meet the aforementioned requirements, will not have
  their assertions fee reduced._

**This HIP will be implemented in two stages:**

1.  Upon community vote approval and upon the completion of HIP 70, the current 1,000,000 DC
    reassertion fee amount will immediately be reduced to 500,000 DC. Stage 2 will only be
    implemented if we see Hotspots moving to a distance of 10km or greater, within Res8 hexes that
    contain less than 3 Hotspots (post stage 1).

2.  In order to dynamically meet the goals of this HIP regardless of the future oracle price,
    monthly rewards, and daily average DC earned per Hotspot, the following mathematical
    equation/logic will be implemented.

- (((("monthly*reward"/100000000 *(dc*percent + poc_challengees_percent + poc_witnesses_percent)) /
  Active Hotspots) / 30 Days)* Oracle Price) \* (8 / 0.00001) = Reassert Fee In DC.

Additionally, there will always be a minimum of 100,000 DC and maximum of 500,000 DC reassertion fee
requirement that supersedes the above equation, using the following logic.

- IF "Reassert Fee In DC" > 500,000 THEN "Reassert Fee In DC" = 500,000

- IF "Reassert Fee In DC" < 100,000 THEN "Reassert Fee In DC" = 100,000

**To explain the mathematical equation/logic:**

(Average Daily Rewards Per Hotspots [HNT/day]) x OraclePrice[USD/HNT] x 8 [Days] x 100.000 [DC/USD]
= Reassert Fee In DC.

In stage two, the reassertion fee will be dynamically calculated by what an average Hotspot earns.
These earnings change, depending on the monthly rewards target set by the HIP 20 halvings schedule,
the number of active Hotspots, and the price of HNT. This notwithstanding, the reassertion fee shall
never be higher than 500,000 DC (5 USD) and never lower than 100,000 DC (1 USD).

**This HIP will be voted on as follows:**

1. Stage/phase 1 will be an HNT vote to cut the assertion fees in half for the first three months
   post HIP 70 to correct their Hotspots locations, without any antigaming code. Since everyone will
   be warned that, if they do not correct their Hotspots to their actual location, then they will be
   caught for spoofing/cheating and blacklisted. (This HIP will NOT blacklist Hotspots.) The
   Foundation/Nova will also use the data derived from this for future antigaming/antispoofing
   proofing. After three months, the assertion fee will be reverted. If the vote is approved by the
   community, then this stage will be implemented via a simple chain variable. Therefore, no code is
   necessary for this stage.

2. Stage/phase 2 will be a veIOT vote, to determine whether or not there should be a permanent or
   ongoing dynamic level mathematical equation, determining the ongoing reassertion fees. (Allowed,
   based on whatever proper antigaming eligibility/criteria methods the Foundation determines
   appropriate at that time.) This stage requires a veIOT voting system, as well as antigaming and
   the dynamic level mathematical code. Additionally, it will help test the new veIOT voting system,
   and helps keep IOT in the treasury, which is beneficial for every IOT Hotspot owner.

_Please note that this HIP does **not** impact 5G CBRS gateways & radios._

# Drawbacks

Although the aforementioned gaming prevention methods will drastically reduce the possibilities of
gaming as a result of the reassertion fee reduction, location spoofers may benefit from reduced
reassertion fees. Nevertheless, it will be impossible for any given Hotspot to benefit from the
reassertion fee reduction more than once every 525k blocks (approximately once per year).

# Rationale

Not doing this can possibly result in people who may have moved from an over saturated areas to much
less saturated areas, but may not do so on the notion that the reassertion fee in and of itself
would cost many months (if not longer) worth of mining. Additionally, without this HIP, the
reassertion fee burden will not be lighter for those joining the network (for example people who
purchase a second hand Hotspot and need to reassert their location), and those who made human errors
(such as "fat finger" mistakes of placing their Hotspots into the wrong location accidentally).

# Unresolved Questions

On the economic effect, burning less HNT as a result of reduced reassertion fees, has a negative
economic impact. However, there may end up being more DC burned from more location assertions (than
there were prior to the reassertion fee reduction.) Therefore, will this HIP impact the Network's
economics negatively or positively?

On the UX side, the non-scoped factors are the work that is needed in various maker apps, ensuring
that all Hotspots can use the variable rate (depending on the aforementioned equation/logic).
Additionally, if a maker decides not to respect the reassertion fee reduction amount, the chain may
accept the higher fee amount (which cannot be undone).

As far as resourcing, who will build/write the code?

# Success Metrics

Success may be measured, once we see MORE Hotspots moving to a distance of 10km or greater, within
Res8 hexes that contain less than 3 Hotspots.
