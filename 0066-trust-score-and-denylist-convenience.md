# HIP 66: Trust Score & Denylist Convenience

- Author(s): [@H-Baguette](https://github.com/h-baguette)
- Start Date: 2022-06-10
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/430>
- Tracking Issue: <https://github.com/helium/HIP/issues/438>
- Status: In Discussion

# Summary

There is no single way to determine whether a Hotspot is spoofing. This HIP therefore looks at
several types of data that are typically looked at when looking for spoofers and combines them into
a score, the Trust Score, which is designed to tell how likely a Hotspot is to be spoofing, in order
for them to be manually added to the denylist later.

The HIP doesn't make any automatic additions to the denylist, nor does it invalidate witnesses that
it deems to be spoofing ; it only attributes a Trust Score to each Hotspot.

Additionally, the HIP provides convenient ways for Hotspot owners to report Hotspots to the denylist
as well as prove their own integrity, directly in-app.

# Motivation

Despite the different updates introduced to limit spoofing (Denylist, HIP 58, Crowdspot, ...),
spoofers are still thriving, as only a small portion of them end up on the denylist. This HIP aims
to facilitate the addition of spoofing Hotspots to the denylist by giving users an easier way to
find them, investigate them, and report them.

I previously tried to automate the invalidation of spoofing witnesses by using the Hotspot's IP, but
it turned out to be unsuccessful, as there are too many cases of honest miners having an IP
situation that I deemed irregular. This made evident that no single data is enough to determine
whether a Hotspot is spoofing. This HIP works differently, by taking into account different types of
data that are typically looked at before adding a Hotspot to the denylist.

# Stakeholders

- All Hotspot owners are affected by this proposal.

# Detailed Explanation

This HIP calculates a Hotspot's Trust Score by focusing on the following data :

- Blockchain addition date
- Asserted location
- Owner addresses
- HNT transactions
- RSSI
- SNR
- IP address
- Interactions with other Hotspots
- Photo & Video proof
- GPS localization
- Invalid witnesses

Each Hotspot has its own Trust Score. This document explains how the data will be used and how it
will affect a Hotspot's Trust Score, and why the data is relevant. Some of this data requires
features to be added to the Helium app, in order to make the process more user-friendly than the
denylist currently is. These are detailed as well.

It is important to understand that all of the data is used to calculate the Trust Score. An honest
Hotspot can lose points in some places because their behavior is associated to that of a spoofer.
For example, an honest Hotspot using a VPN and showing an IP outside of the country it is located in
will lose points. **Losing points does not mean a Hotspot is automatically accused of spoofing**.
The Trust Score takes everything into account. Losing points simply means that, from a purely
statistical point of view, a Hotspot is _more likely_ to be spoofing. Since no penalty is given
automatically, a Hotspot that loses points for one type of data will not be added to the denylist if
its activity appears to be normal.

The Trust Score should be visible on the Helium explorer. Users should be able to sort all Hotspots
by their Trust Score, or by specific data of their Trust Score (sorting Hotspots by their score on
RSSI and SNR values only, for example).

For a better understanding of this document :

**interaction** : Two Hotspots are considered to be interacting when one of them witnesses the
other. _Two Hotspots witnessing the same beacon is not considered to be an interaction._

- # Blockchain addition date

The date at which a Hotspot is added to the blockchain cannot be changed. Spoofing farms often add
many Hotspots to the blockchain on the same day, making a cluster of Hotspots witnessing each other
that were added to the blockchain on the same day more likely to be spoofing than honest.

**Impact on the Trust Score** : from **-1 to -0** for each interaction in the last 15 days with a
Hotspot that was added to the blockchain on a similar date, depending on how close the dates are,
ranging from a 0 to a 30-day difference (-1 if both were added on the exact same date, -0 if they
were added 30 days appart or more).

- # Asserted Location

Owners of spoofing Hotspots can try to change the location of their Hotspots in order to hide their
spoofing activity, namely by better accomodating this HIP's criteria. Hotspots changing location
several times are more likely to belong to spoofers than to honest miners physically moving their
Hotspot.

Additionally, just like spoofing Hotspots are likely to be added to the blockchain on the same day,
they are also likely to have their location asserted on the same day. Because each newly asserted
location is already penalized, we only take the last location assertion date into account.

**Impact on the Trust Score** :

- **-1** for each location assertion in the last 365 days _(the first location assertion in a
  Hotspot's history doesn't count)_.
- from **-1 to -0** for each interaction in the last 15 days with a Hotspot whose latest location
  was asserted on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day
  difference (-1 if both were asserted on the exact same date, -0 if they were asserted 30 days
  appart or more).

- # Owner addresses

It is common for spoofing farms to add all of their Hotspots to the blockchain using the same Helium
address for convenience. They may then transfer ownership to different addresses out of fear of
their irregular activity being spotted. Honest miners owning several Hotspots are more likely to
have them spread out rather than setup in the same cluster. Therefore, a cluster of Hotspots having
been owned by the same address and interacting with each other is more likely to be owned by a
spoofing farm.

A list of all addresses that have had ownership of a Hotspot is established. When two Hotspots that
share at least one address interact with each other, they lose points.

**Impact on the Trust Score** : **-1** for each interaction in the last 15 days with a Hotspot that
shares at least one address

- # HNT transactions

Spoofing Hotspots belonging to the same owner are likely to send their rewards to the same wallet,
in order for them to be sold.

We follow the money trail and make a list of every address that HNT was sent to, starting from the
Hotspot whose Trust Score is being calculated. Two Hotspots sharing an address in that list and
interacting with each other are likely to be spoofing Hotspots belonging to the same person.

**Impact on Trust Score** : **-1** per unique Hotspot that was interacted with in the last 30 days
and that shares an address in their money trail.

- # SNR

The SNR value (Signal to Noise Ratio) tells us how clean a radio signal is when it is received. The
higher the SNR value, the cleaner the signal. Generally, the bigger the distance between an emitter
and a receiver, the lower the SNR, as the signal loses in clarity with every obstacle it encounters
(buildings, trees, air, rain, dust, birds, clouds, mist, smoke, ...).

SNR values for spoofing Hotspots are often found to be higher than average, which makes sense,
because spoofing Hotspots are barely a few meters appart in a safe environment in the same room,
instead of being outside, kilometers appart.

Although it is certainly possible for some witness events to register a higher than average SNR
value even though both Hotspots are physically separated by several kilometers, a high SNR value is
more likely to be caused by spoofing activity than sheer luck.

**Impact on the Trust Score** : from **-0 to -1** for each interaction in the last 30 days showing
an SNR value above a certain threshold, ranging from an SNR value of n to n+5, with n =
16.204e^(-0.086d) - 2, with d the registered distance between both Hotspots (in kilometers).

(The values were chosen _somewhat_ arbitrarily, from the study of a small data set, for the sake of
this first draft. It should definitely be improved upon before being implemented)

![image](https://user-images.githubusercontent.com/106159694/173186803-36f81096-b20c-47fb-85f3-bfbcccc26b48.png)

SNR below green line : ✔️

SNR above red line : ❌ **-1**

SNR in-between : 🤔 between **-0 and -1**

- # RSSI

Similar to the SNR, the RSSI (Received Signal Strength Indication) is an indication of the strength
of the received signal. Typically, the greater the distance between two Hotspots, the lower the
RSSI. An RSSI value that is too high usually means that two Hotspots are physically closer than
their asserted location suggests. It is common for spoofing Hotspots to have their witnesses
invalidated because their RSSI is too high. Although it can happen to honest miners, it is rarer.

Additionally, even if an RSSI is low enough that a witness is not automatically invalidated, a high
RSSI value close to the maximum allowed value should at least be considered suspicious.

**Impact on the Trust Score** :

- **-1** per witness at least 2 hexes away in the last 60 days being invalid for having an RSSI too
  high.
- from **-1 to -0** per valid witness at least 2 hexes away in the last 60 days whose RSSI is close
  to the maximum allowed value, ranging from a difference of 0 to 15 between the recorded RSSI value
  and the maximum allowed value.

- # RSSI to distance variance

_This idea was taken directly from Crowdspot._

The RSSI shows the strength of the received signal. Normally, on average, the farther away the
receiver is from the emitter, the lower the RSSI is. Even so, the relation between RSSI and distance
is not constant. Every obstacle between both antennas affects the RSSI value. Outdoor obstacles
include a variety of varying obstacles (humidity, swaying trees, smoke, tall moving vehicles like
cranes, ...), meaning that even for a fixed distance between two Hotspots, the RSSI should vary and
be somewhat unpredictable. If the ratio of RSSI to distance seems to predictable, it could indicate
a cluster of spoofing Hotspots that are not actually exposed to the environment.

_Explanation taken from Crowdspot :_
![image](https://user-images.githubusercontent.com/106159694/177018086-e09fd799-2dcd-4d5a-8b06-127c9f8043c3.png)

**Impact on the Trust Score** :

- **-(R²-0.1) \* n**, R² being the variance (same value as on Crowdspot), and n being the number of
  interactions in the last 7 days.

  _(A value R² < 0.1 results in a gain of points, a value R² > 0.1 results in a loss of points)._

- # IP address

Spoofers often either use a VPN to conceal their IP in order to appear legit, or assert their
location in a different country than their physical location.

There are cases of honest Hotspots having an IP in a different country than their asserted location.
Some owners are using VPNs either for convenience, or to hide their mining activity from their ISP
_(Internet Service Provider)_. ISP can also be using CGNAT, with the Hotspot's IPv4 being located in
a different country. However, the former can use a VPN located in their country, while the latter is
rare enough that we can consider the case of IP addresses being located in a different country than
the asserted location of a Hotspot to be more likely to belong to a spoofing Hotspot.

**Impact on the Trust Score** :

- **-5** for a Hotspot whose IP is located in a different country than its asserted location, or
  whose IP cannot be located.
- **-1** for each interaction in the last 7 days with a Hotspot whose IP is located in a different
  country than its asserted location.

- # Interactions with other Hotspots

This HIP introduces the concept of **webs** of Hotspots. A web of Hotspots includes all Hotspots
that have interacted with each other in a given time frame. _If Hotspot A interacts with Hotspot B,
Hotspot B interacts with Hotspot C, and Hotspot C interacts with Hotspot D, Hotspots A through D are
all part of the same web._

This concepts allows to separate clusters of Hotspots that are only interacting with each other
(including spoofing Hotspots) and Hotspots that are legitimately interacting with the wider network.

**Clicking a Hotspot on the explorer should highlight the web it is part of.** This is especially
useful in dense areas, where it allows users to see which Hotspots are on a closed loop and are only
interacting with each other, which includes spoofers, since they are usually not physically present
where their location is asserted.

Example _(not representative of the actual situation in that area, hexes were chosen randomly for
the purpose of this example)_ :
![image](https://user-images.githubusercontent.com/106159694/173186619-b34804ee-425b-4042-beac-080b1c0d34ba.png)

In this example, the web can show us that the Hotspots in the orange web are having a suspicious
activity. Despite being located in a dense area with hundreds of other Hotspots to interact with,
the Hotspots highlighted in orange are only interacting with each other, indicating a possible
spoofing activity.

The green web is the largest web in the area, including most Hotspots in that area and strongly
indicating that Hotspots part of that web are not spoofing.

The other webs show Hotspots that are too isolated to interact with the rest of the network.

**Impact on the Trust Score** : **+n^0.5**, n being the number of unique hexes in the 7 day old web
of the Hotspot whose Trust Score is being calculated. **Capped at +20** _(reached at 400 hexes)_

![image](https://user-images.githubusercontent.com/106159694/173186557-4961e5de-becd-4595-b4fd-0387837497dc.png)

- # Invalid witnesses

A witness can be invalid for two reasons :

- The registered distance between the beacon and the witness is greater than 100km.
- Its RSSI value is too high.

Like it is mentioned in HIP 58, over 99.9% of witnesses are within the 100km limit. The only few
exceptions are tower deployments and spoofers. While the former might lose some points on their
Trust Score, they will without a doubt compensate with their many valid witnesses. Spoofers, on the
other hand, will have a harder time to regain those points.

**Impact on the Trust Score** :

- **-1** for each witness in the last 90 days that was invalid for being too far.
- _For invalid witnesses being caused by a high RSSI value, the impact on the trust score was
  detailed in the RSSI section of the HIP._

- # Changes to the Helium app and the explorer

This HIP introduces some changes to the Helium app and to the explorer :

- Make the Trust Score for each Hotspot visible on the explorer.
- Users should be able to sort Hotspots by they Trust Score or by specific parts on the Trust Score
  (for example sorting only by their score on SNR values) in the explorer.
- The explorer should be able to display Hotspot webs.
- The explorer should be able to display manufacturer information of the witness Hotspot directly.
- Users should be able to report Hotspots to the denylist directly from the Helium app / the
  explorer.
- Hotspot owners can be contacted directly via the Helium app by people in charge of the denylist.

# All Trust Score calculations

_A Hotspot's Trust Score starts at 0. Then, points are either added or substracted depending on the
Hotspot's behavior in a given timeframe._

- From **-1 to -0** for each interaction in the last 15 days with a Hotspot that was added to the
  blockchain on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day
  difference (-1 if both were added on the exact same date, -0 if they were added 30 days appart or
  more).
- **-1** for each location assertion in the last 365 days _(the first location assertion in a
  Hotspot's history doesn't count)_.
- From **-1 to -0** for each interaction in the last 15 days with a Hotspot whose latest location
  was asserted on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day
  difference (-1 if both were asserted on the exact same date, -0 if they were asserted 30 days
  appart or more).
- **-1** for each interaction in the last 15 days with a Hotspot that shares at least one address
- **-1** per unique Hotspot that was interacted with in the last 30 days and that shares an address
  in their money trail.
- From **-0 to -1** for each interaction in the last 30 days showing an SNR value above a certain
  threshold, ranging from an SNR value of n to n+5, with n = 16.204e^(-0.086d) - 2, with d the
  registered distance between both Hotspots (in kilometers).
- **-1** per witness at least 2 hexes away in the last 60 days being invalid for having an RSSI too
  high.
- From **-1 to -0** per valid witness at least 2 hexes away in the last 60 days whose RSSI is close
  to the maximum allowed value, ranging from a difference of 0 to 15 between the recorded RSSI value
  and the maximum allowed value.
- **+n^0.5**, n being the number of unique hexes in the 7 day old web of the Hotspot whose Trust
  Score is being calculated. **Capped at +20** _(reached at 400 hexes)_
- **-1** for each witness in the last 90 days that was invalid for being too far.

# Other ideas

Here are some more metrics that can be used to calculate the Trust Score. This category contains
metrics that are either too complicated to implement right away (or at all), too easy to cheat in
their current form, or not detailed enough to be added to the main chapters of the HIP yet.

- GPS localization : uploading GPS localization directly from the Helium app. The Helium app would
  make sure that no other apps are running, and would take every precaution at its disposal to
  ensure that the uploaded location is not fake.
- Photo & video proofs : uploading a photo and a video of the setup (Hotspot, antenna and
  surroundings), taken directly from the Helium app. The Helium app should ensure that no other apps
  are running and that the uploaded photos and videos were taken directly from the app, at the same
  moment the GPS localization was uploaded.
- Checking whether an IP is from China. As most cheaters are located in China, it would make sense
  to preemptively penalize all Hotspots in this country. However, this comes with the obvious
  downside that all honest miners in China would also be penalized.

# Drawbacks

The way the Trust Score is calculated might negatively impact some honest miners that are in very
specific situations. Although precautions are taken to limit this impact, by spreading the Trust
Score over many types of data, there will probably some honest miners losing points on several of
them _(an isolated cluster of Hotspots all connected to the same VPN, belonging to the same owner,
that were added to the blockchain and whose location was asserted on the same day, and whose rewards
are all sent to the same wallet, for example)_. However, regardless on their Trust Score, additions
to the denylist are never automatic, and even these rare cases should be able to prove their
integrity directly from the Helium app.

# Rationale and Alternatives

Automatically cut (or simply lower) Proof of Coverage rewards from Hotspots with a low Trust Score
is a possibility. However, it is important to keep the "assumed innocent until proven guilty" ethos,
which is why I designed the Trust Score to only be an indication, rather than a decisive value.

Data transfers could have been used in the calculation of the Trust Score, but they feel to easily
cheated, as spoofers could simply trigger data transfers themselves.

# Unresolved Questions

- Is the Trust Score too easily cheated ?

- Are there more types of data that can be used in its calculation ?

- Won't there be too many honest miners being negatively affected by the Trust Score for this HIP to
  be viable ?

- Can we really prevent cheaters from uploading fake photos, videos and GPS localization ?

- Do we really want Hotspot owners to be contacted directly via the Helium app ?

# Deployment Impact

Who will it affect, and how ?

✔️ Spoofers, who will be more susceptible to be reported and added to the denylist.

✔️ Legit Hotspot owners, who should see their rewards increasing as the spoofers' share of the
rewards is given back to honest miners.

❌ Honest Hotspot owners in specific situations that fall through the cracks and end up with a low
Trust Score, who might need to try harder to prove their integrity.

_This change is entirely backwards compatible._

# Success Metrics

- More Hotspots being reported to the denylist.
- More Hotspots being added to the denylist.
