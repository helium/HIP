# HIP 69: Re-assertion Fee Reduction

- Author(s): @therealjohnmac50
- Start Date: 2022-07-24
- Category: Economy 
- Original HIP PR: https://github.com/helium/HIP/pull/453
- Tracking Issue: https://github.com/helium/HIP/issues/458
- Status: In Discussion 

# Summary

The average daily mining reward per hotspot is currently equal to around 50,000 DC; and it costs 1,000,000 DC to reassert a hotspot's location. 

As a result, it would take nearly a month for the average hotspot to earn enough to pay for one location reassertion.

Therefore, if we are trying to expand the network and want hotspots in saturated areas to move into less saturated areas (or moreover in lone wolf like areas), want to ease the burden on new people joining the network, and ease the burden on people making human errors, the current reassertion price is not viable and needs to be reduced.

# Stakeholders

In reality, since less DC burned has an economical impact, this hip effects everyone. Directly, this hip effects everyone that is reasserting their hotspots. Additionally, since people will need to be able to see their reassertion fee amounts prior to submitting the reassertion fee DC burn transaction which is a function of the Vendor Apps, this HIP directly effects all owners of Vendor apps.

# Detailed Explanation

The average daily mining reward per hotspot is currently equal to around 50,000 DC; and it costs 1,000,000 DC to reassert a hotspot's location.

As a result, it would take nearly a month for the average hotspot to earn enough to pay for one location reassertion. 

Therefore, if we are trying to expand the network and want hotspots in saturated areas to move into less saturated areas (or moreover in lone wolf like areas), want to ease the burden on new people joining the network, and ease the burden on people making human errors, the current reassertion price is not viable and needs to be reduced. 

To clarify, the original/first location assertion price would not be changed, merely the reassertion prices (from the 2nd assertion and on.)

In order to help expand the network and ease the burden on new people joining the network, I'm proposing that the reassertion price be reduced from 1,000,000 DC, to half which is 500,000 DC. 

Please note that I specifically chose 500,000 DC and not less (say 10,000 DC), to help prevent people from taking advantage of reduced reassertion fees. 

In addition, to prevent location spoofing as a result of reassertion fees deduction, any given individual hotspot may only have its reassertion fees reduced once per year (about 525k blocks).

Furthermore, in order to help prevent abuse of the reassertion fee reduction, there will be a minimum distance of 10KM (between the original location to the reasserted location) requirement. 

Finally, the reassertion fee reduction will only apply to those inserting their hotspots into Res8 hexes of < 3 (less than 3) hotpots. 

With the reassertion fees reduced to 500,000 DC, it would still require the average hotspot to spend approximately 10 days worth of mining for the reassertions. 

Thus, the 500,000 DC fee in addition to the three aforementioned gaming prevention methods are still preventing excessive/unnecessary reassertions, while also making it easier for those that want to expand the network and actually move their hotspots locations to that end.


To clarify in summary:

 - This HIP only applies to REassertions. Not the first assertion/onboarding.

 - This HIP only applies to those who are REasserting their hotspots to a distance equal to or greater than 10km (away from the original location point that is being changed).

 - This HIP only applies to REassertions, equal to or greater than 10km away from the original location, and only to those who are reasserting their hotspots into Res8 hexes with less than 3 hotspots [equal to or less than 2 hotspots].

 - The reassertion fee reduction will be limited to once per hotspot per year. Meaning, after a given hotspot's first reassertion fee reduction, said hotspot would need to wait one year (approximately 525k blocks) in order to be eligible for its second reassertion fee reduction.

All other location assertions, that do not meet the aforementioned requirements, will not have their assertions fee reduced.


This HIP will be implemented in two stages. 

 1) Upon community vote approval, the current 1,000,000 DC reassertion fee amount will immediately be reduced to 500,000 DC.
 
 2) In order to dynamically meet the goals of this HIP regardless of the future oracle price, monthly rewards, and daily average DC earned per hotspot, the following mathematical equation/logic will be implemented.

 * (((("monthly_reward"/100000000 * 0.6115) / Active Hotspots) / 30 Days) * Oracle Price) * (8 / 0.00001) = Reassert Fee In DC. 

Additionally, there will always be a minimum of 100,000 DC and maximum of 500,000 DC reassertion fee requirement that supersedes the above equation, using the following logic. 

 * IF "Reassert Fee In DC" > 500,000 THEN "Reassert Fee In DC" = 500,000
 
 * IF "Reassert Fee In DC" < 100,000 THEN "Reassert Fee In DC" = 100,000

# Drawbacks

Although the aforementioned three gaming prevention methods will drastically reduce the chances of gaming as a result of the reassertion fee reduction, location spoofers may possibly benefit from reduced reassertion fees. 

# Rationale

Not doing this will result in people who may have moved from an over saturated areas to much less saturated areas, but will not do so on the notion that the reassertion fee in and of itself would cost many months (if not longer) worth of mining. Additionally, without this HIP, the burden will not be lighter for those joining the network (for example people who purchase a second hand hotspot and need to reassert their location), and those who made human errors (such as "fat finger" mistake of placing their hotspots on the wrong location accidentally).

# Unresolved Questions

Who will write the code for this HIP? 

# Success Metrics

Success may be measured, once we see hotspots in over saturated areas moving to less saturated areas.
 
