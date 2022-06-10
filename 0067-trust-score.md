# HIP62: Trust Score

- Author(s): [@H-Baguette](https://github.com/h-baguette)
- Start Date: 2022-06-11
- Category: Technical
- Original HIP PR: 
- Tracking Issue: 

# Summary
[summary]: #summary

There is no single way to determine whether a hotspot is spoofing. This HIP therefore looks at several types of data that are typically looked at when looking for spoofers and combines them into a score, the Trust Score, which is designed to tell how likely a hotspot is to be spoofing, in order for them to be manually added to the denylist later.

The HIP doesn't make any automatic additions to the denylist, nor does it invalidate witnesses that it deems to be spoofing ; it only attributes a Trust Score to each hotspot.

Additionally, the HIP provides convenient ways for hotspot owners to report hotspots to the denylist as well as prove their own integrity, directly in-app.

# Motivation
[motivation]: #motivation

Despite the different updates introduced to limit spoofing (PoCv11, the denylist, HIP 58, Crowdspot, ...), spoofers are still thriving, as only a small portion of them end up on the denylist. This HIP aims to facilitate the addition of spoofing hotspots to the denylist by giving users an easier way to find them, investigate them, and report them.

I previously tried to automate the invalidation of spoofing witnesses by using the hotspot's IP, but it turned out to be unsuccessful, as there are too many cases of honest miners having an IP situation that I deemed irregular. This made evident that no single data is enough to determine whether a hotspot is spoofing. This HIP works differently, by taking into account different types of data that are typically looked at before adding a hotspot to the denylist.

# Stakeholders
[stakeholders]: #stakeholders

* All hotspot owners are affected by this proposal.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

This HIP calculates a hotspot's Trust Score by focusing on the following data :
- Blockchain addition date
- Asserted location
- Owner addresses
- HNT transactions
- RSSI
- SNR
- IP address
- Interactions with other hotspots
- Photo & Video proof
- GPS localization
- Invalid witnesses

Each hotspot has its own Trust Score. This document explains how the data will be used and how it will affect a hotspot's Trust Score, and why the data is relevant. Some of this data requires features to be added to the Helium app, in order to make the process more user-friendly than the denylist currently is. These are detailed as well.

It is important to understand that all of the data is used to calculate the Trust Score. An honest hotspot can lose points in some places because their behavior is associated to that of a spoofer. For example, an honest hotspot using a VPN and showing an IP outside of the country it is located in will lose points. **Losing points does not mean a hotspot is automatically accused of spoofing**. The Trust Score takes everything into account. Losing points simply means that, from a purely statistical point of view, a hotspot is *more likely* to be spoofing. Since no penalty is given automatically, a hotspot that loses points for one type of data will not be added to the denylist if its activity appears to be normal.

For a better understanding of this document :

**interaction** : Two hotspots are considered to be interacting when one of them witnesses the other. *Two hotspots witnessing the same beacon is not considered to be an interaction.*

- # Blockchain addition date

The date at which a hotspot is added to the blockchain cannot be changed. Spoofing farms often add many hotspots to the blockchain on the same day, making a cluster of hotspots witnessing each other that were added to the blockchain on the same day more likely to be spoofing than honest.

**Impact on the Trust Score** : from **-1 to -0** for each interaction in the last 15 days with a hotspot that was added to the blockchain on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day difference  (-1 if both were added on the exact same date, -0 if they were added 30 days appart or more).

- # Asserted Location

Owners of spoofing hotspots can try to change the location of their hotspots in order to hide their spoofing activity, namely by better accomodating this HIP's criteria. Hotspots changing location several times are more likely to belong to spoofers than to honest miners physically moving their hotspot.

Additionally, just like spoofing hotspots are likely to be added to the blockchain on the same day, they are also likely to have their location asserted on the same day. Because each newly asserted location is already penalized, we only take the last location assertion date into account.

**Impact on the Trust Score** :
- **-1** for each location assertion in the last 365 days *(the first location assertion in a hotspot's history doesn't count)*.
- from **-1 to -0** for each interaction in the last 15 days with a hotspot whose latest location was asserted on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day difference  (-1 if both were asserted on the exact same date, -0 if they were asserted 30 days appart or more).

- # Owner addresses

It is common for spoofing farms to add all of their hotspots to the blockchain using the same Helium address for convenience. They may then transfer ownership to different addresses out of fear of their irregular activity being spotted. Honest miners owning several hotspots are more likely to have them spread out rather than setup in the same cluster. Therefore, a cluster of hotspots having been owned by the same address and interacting with each other is more likely to be owned by a spoofing farm.

A list of all addresses that have had ownership of a hotspot is established. When two hotspots that share at least one address interact with each other, they lose points.

**Impact on the Trust Score** : **-1** for each interaction in the last 15 days with a hotspot that shares at least one address

- # HNT transactions

Spoofing hotspots belonging to the same owner are likely to send their rewards to the same wallet, in order for them to be sold.

We follow the money trail and make a list of every address that HNT was sent to, starting from the hotspot whose Trust Score is being calculated. Two hotspots sharing an address in that list and interacting with each other are likely to be spoofing hotspots belonging to the same person.

**Impact on Trust Score** : **-1** per unique hotspot that was interacted with in the last 30 days and that shares an address in their money trail.

- # SNR

The SNR value (Signal to Noise Ratio) tells us how clean a radio signal is when it is received. The higher the SNR value, the cleaner the signal. Generally, the bigger the distance between an emitter and a receiver, the lower the SNR, as the signal loses in clarity with every obstacle (buildings, trees, air, rain, dust, birds, clouds, ...).

SNR values for spoofing hotspots are often found to be higher than average, which makes sense, because spoofing hotspots are barely a few meters appart in a safe environment in the same room, instead of being outside, kilometers appart.

Although it is certainly possible for some witness events registering a higher than average SNR even though both hotspots are physically separated by several kilometers, a high SNR value is more likely to be caused by spoofing activity.

**Impact on the Trust Score** : from **-0 to -1** for each interaction in the last 30 days showing an SNR value above a certain threshold, ranging from an SNR value of n to n+5, with n = 16.204e^(-0.086d) - 2, with d the registered distance between both hotspots (in kilometers).

- # RSSI

Similar to the SNR, the RSSI (Received Signal Strength Indication) is an indication of the strength of the received signal. Typically, the greater the distance between two hotspots, the lower the RSSI. An RSSI value that is too high usually means that two hotspots are physically closer than their asserted location suggests. It is common for spoofing hotspots to have their witnesses invalidated because their RSSI is too high. Although it can happen to honest miners, it is more rare.

Additionally, even if an RSSI is low enough that a witness is not automatically invalidated, a high RSSI value close to the maximum allowed value should at least be considered suspicious.

**Impact on the Trust Score** :
- **-1** per witness at least 2 hexes away in the last 60 days being invalid for having an RSSI too high.
- from **-1 to -0** per valid witness at least 2 hexes away in the last 60 days whose RSSI is close to the maximum allowed value, ranging from a difference of 0 to 15 between the recorded RSSI value and the maximum allowed value.

- # IP address

Spoofers often either use a VPN to conceal their IP in order to appear legit, or assert their location in a different country than their physical location.

There are cases of honest hotspots having an IP in a different country than their asserted location. Some owners are using VPNs either for convenience, or to hide their mining activity from their ISP *(Internet Service Provider)*. ISP can also be using CGNAT, with the hotspot's IPv4 being located in a different country. However, the former can use a VPN located in their country, while the latter is rare enough that we can consider the case of IP addresses being located in a different country than the asserted location of a hotspot to be more likely to belong to a spoofing hotspot.

**Impact on the Trust Score** :
- **-5** for a hotspot whose IP is located in a different country than its asserted location.
- **-1** for each interaction in the last 7 days with a hotspot whose IP is located in a different country than its asserted location.



- # Interactions with other hotspots



- # Photo & Video proof



- # GPS localization



- # Invalid witnesses



# Drawbacks
[drawbacks]: #drawbacks

Despite all precautions introduced with the irregular status balancing mechanic, and despite the fact that solutions exist for affected miners (changing IP, changing location, adding new hotspots), it is still technically possible that some legit hotspots witnessing each other and sharing the same IP might have no solution to fix or balance their irregular status. Preventing people from cheating the system at the cost of a few honest isolated miners losing their rewards might be considered unfair by some.
Additionally, some people (namely in the US) feel obligated to use a VPN in order to hide their mining activity from their internet provider. Some internet providers forbid the use of their connection for business-related purposes. Hotspot owners affected by this might need to find alternative solutions, like changing their internet provider, upgrading to a plan allowing business-related usage, or checking their local law to ensure that mining HNT does not fall in the business category.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

A simpler design would have been to simply invalidate witnesses with the same IP as the beacon. This, however, would have had a much bigger impact on honest miners sharing the same IP. This HIP aims to reduce that impact to a minimum, while still affecting as many spoofers as possible.

Other ideas which involve GPS tracking are both too complex to implement and too easily cheated.

The impact of not implementing this HIP would be a gradual decrease in rewards for honest miners, and therefore also a decrease of the spread of the network's coverage, as well as a decline in the reputation of the Helium network as spoofers keep filling their pockets cheating the system.

Regarding VPN restrictions, another, more restricting method, would be to check the distance between the IP's estimated location and the hotspot's location on the explorer, and invalidate the witness if the distance is greater than a fixed value, say 100km. However, this is highly imperfect, as locating a device solely on its IP is far from being precise. Additionally, CGNAT connections would result in constantly invalid witnesses, as the IP could direct to a location hundreds of kilometers away from the hotspot, even though it is neither spoofing or using a VPN. Checking only the country greatly limits the risk of wrongfully invalidating witnesses, while still impacting spoofing farms.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Are honest miners who happen to share their IP address with others sufficiently protected by all the precautions introduced in this HIP ?

- Are there cases of honest miners being poorly affected by this HIP that were not thought of ?

- Will this be enough to prevent spoofing ? Could spoofing farms still use VPNs while conforming to this proposal's requirements ?

- Is it acceptable to combat spoofing at the cost of possibliy penalizing a few honest miners that don't fall within the precautions introduced in this proposal ?

- How could we better restrict VPNs without risking honest miners losing their rewards, especially CGNAT connections ?

# Deployment Impact
[deployment-impact]: #deployment-impact

Who will it affect, and how ?

✓ Spoofers, who will lose most if not all of their rewards

✓ Legit hotspot owners, who will see their rewards increasing

× Hotspot owners putting their legitimately spread hotspots on the same IP through a VPN for practical reasons. Although these are quite rare, I've heard that they exist, and therefore matter. These would have to find another way for the benefit of the network.

× Widely spread hotspots' owners using CGNAT connections sharing the same IP. Having access to a variety of witnesses should suffice in most cases, as irregular witnesses caused by CGNAT should be balanced by nearby valid witnesses. But there might be a few cases of CGNAT connected hotspots mostly witnessing other CGNAT connected hotspots with the same IP, without enough valid witnesses to balance their irregular status. As the irregular status is visible on the explorer, owners would realize the issue and could consider moving their hotspot to another location, changing their IP, or encourage new hotspots to cover their area, thus enabling their irregular status to be balanced (and spreading the coverage of the network as a consequence, which is what Proof of Coverage is all about).

× Legitimately spread hotspots sharing the same connection. Hotspots can be 300+ meters appart while still sharing the same connection. Much like in the case described above, having access to a variety of valid witnesses should be enough to balance their irregular status. Again, in the few cases where it is not possible, the visible irregular status on the explorer could tell these hotspots' owners to either change their connection, change their location, or encourage the birth of new hotspots in their area.

× Hotspot owners using a VPN to hide their mining activity from their internet service provider. They would first have to check whether mimning HNT really is forbidden. If it is not, then the use of a VPN would no longer be required. Otherwise, they would have to either upgrade to a plan allowing HNT mining, or change their internet service provider altogether.

This change is entirely backwards compatible.

# Success Metrics
[success-metrics]: #success-metrics

- Rewards of hotspots on the denylist decreasing

- Rewards of other known spoofed hotspots decreasing

- Number of hotspots with IP in different country than their location decreasing

- Legit hotspots' rewards increasing

- People sharing their respectful spoofing-related criticism on Reddit decreasing
