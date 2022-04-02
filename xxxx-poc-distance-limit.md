# HIP XX: PoC Distance Limit

- Author(s): [@abhay](https://github.com/abhay),
  [@mrpatrick1991](https://github.com/mrpatrick1991), et al
- Start Date: 2022-04-02
- Category: Technical
- Original HIP PR: TODO
- Tracking Issue: TODO
- Status: Draft

# Summary

The Proof-of-Coverage incentive model is crucial to the ongoing growth of the
Helium Network. As the network grows, efforts to prevent Proof-of-Coverage
gaming must be bolstered in order to encourage honest Hotspot deployment. One
known gaming technique works by altering the information provided by beacon and
witness packets to increase reported distances. This can make it appear that
Hotspots provide coverage where they do not. An effective way to reduce the
impact of this attack is to place an upper limit on the distance at which
witnesses for hotspots will be considered valid by the blockchain and thus be
considered for rewards. 

When PoCv11 was developed, a witness distance limit feature was written but
never activated. If approved, this proposal would impose a `100 km` limit to
Proof-of-Coverage witnessing and this value can be modified further through
governance in the future. Witnesses where the asserted distance is greater than
100 km would be marked invalid by the Challenger. This limit is further
supported by the fact that most sensor deployments have a practical maximum
distance of 30-50km. Although a Helium Hotspot may be able to see PoC beacons
greater than 100 km, there are no current use cases at this range.

# Motivation

Currently there is no sanity check on the reported distances at which witnesses
for a Hotspot are considered valid. Since there's a continuous FSPL curve that's
used, witness receipts can be manipulated to make it appear that a particular
Hotspot falsely provides immense (hundreds, or thousands of kilometers) of
coverage. In addition, it is harder to determine a realistic FSPL value at
longer distances. This problem results in disproportionate rewards being given
to those Hotspots, and subsequently fewer overall rewards sent to Hotspots which
provide legitimate coverage. 

A hard limit on the reported distances which generate rewards can be applied in
a way which does not significantly affect legitimate hotspots. This is because
LoRaWAN works when there is a clear line of sight between the transmitter and
the receiver. For example, the vast majority (> 99.9 percent based on 10,000
random witness reports) of Hotspots provide coverage within a radius of less
than 100 kilometers. It can also be shown that of the exceptional hotspots
providing legitimate coverage on this scale, any reduction in their expected
rewards will be insignificant.

There are two expected outcomes. The first is that gaming techniques which
operate on reported distances above the selected threshold will be made
impossible. The second outcome is that there will be no measurable reduction in
the rewards received by legitimate hotspots, even for exceptionally high
performers such as tower deployments.

# Stakeholders

All Hotspot owners are affected by this proposal. Other network participants
(Validators, Routers, etc) are not affected.
 
Data transfer remains unaffected.

# Detailed Explanation

The distance limit must be chosen so as to not reduce the rewards for legitimate
deployments. This can be seen in the following graph, which shows a cumulative
histogram of witness distances for a random sample of 10,000 current (< 1 week
old) witness receipts from the blockchain.

<!-- TODO IMAGE -->

Almost all of the valid witnesses occur over distances of less than 50
kilometers. The selection of an upper limit can be balanced against the
requirement to not affect rewards from legitimate deployments by examining the
effect of hypothetical cutoffs on existing witness data. The following is a
histogram showing the number of received beacons by given hotspot (sample size
n=10000) expressed as a percentage as a function of the distance to the received
beaconer. Lines are drawn at a distance of 100 kilometers and a percentage 0.5
percent. 

<!-- TODO IMAGE -->

Fewer than 1.6 percent of beacons are witnessed at distances of greater than 100
kilometers based on this sample. The y axis is shown on a log scale to make the
small population at distances greater than 100 kilometers visible. 

We show that of the highest performing hotspots, few of their rewards are due to
witnessing beacons from distances above the 100 kilometer cutoff. This ensures
that high performing operators, such as those with antennas on towers and other
high locations will not be de-incentivised from providing exceptional coverage.
Define a high performing hotspot as one which is in the top 20 percent of total
witnessers in the sample. The histogram of witness distances for these hotspots
is:

<!-- TODO IMAGE -->

Of the total number of beacons received by this high performing group, only 1.4
percent were from distances of greater than the threshold of 100 kilometers. 

Suppose that 0.1 percent of rewards are currently being distributed to gaming
hotspots who produce false witness reports with distances that fall above the
threshold. When these rewards are distributed to legitimate deployments, the
80th percentile witnessers will see a net increase in their rewards, even though
they will not be rewarded for witnessing beacons at distances above the
threshold. This effect increases if the percentage of gaming at these distances
is higher than we assumed. Ordinary hotspots, who witness beacons at shorter
distances, will be unaffected. 

# Drawbacks

This proposal realigns Proof of Coverage closer to effective distances of
existing devices and LoRaWAN use cases. Although we acknolwedge that there are a
small set of legitimate Hotspots who would be affected by this proposal at 100
km, this wouldn't be a significant impact on their witnessing activity and not
affect them at all at lower ranges.

# Rationale and Alternatives

This adjustment to the network is one of many changes that should be made to
continue to incentivize good LoRaWAN coverage creation. 

# Deployment Impact

* The majority of current hotspot owners will see no effect.
* The highest performing Hotspots may see an increase in rewards, and at
  minimum, will not see a decrease. 
* Gaming hotspots will be forced to work with falsely asserted distances under
  100 kilometers. This will reduce their earnings, especially in the most
  egregious cases of witnesses being reported at multiple thousands of
  kilometers. 
* Existing documentation will need to reflect that an upper limit on witness
  distance exists. 

# Success Metrics

The success of this design can be verified by community members and Hotspot
owners. Community members can verify that no Hotspots are being rewarded for
distances of greater than the threshold using explorer or the Helium API.
Hotspot owners may compute their rewards specifically due to witnesses at larger
than the threshold from before this HIP is implemented and verify that they are
either zero, or insignificant compared to their rewards from witnesses at
distances below the threshold. 
