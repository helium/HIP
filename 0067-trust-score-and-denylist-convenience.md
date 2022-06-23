# HIP67: Trust Score & Denylist Convenience

- Author(s): [@H-Baguette](https://github.com/h-baguette)
- Start Date: 2022-06-10
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

Despite the different updates introduced to limit spoofing (Denylist, HIP 58, Crowdspot, ...), spoofers are still thriving, as only a small portion of them end up on the denylist. This HIP aims to facilitate the addition of spoofing hotspots to the denylist by giving users an easier way to find them, investigate them, and report them.

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

The Trust Score should be visible on the Helium explorer. Users should be able to sort all hotspots by their Trust Score, or by specific data of their Trust Score (sorting hotspots by their score on RSSI and SNR values only, for example).

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

The SNR value (Signal to Noise Ratio) tells us how clean a radio signal is when it is received. The higher the SNR value, the cleaner the signal. Generally, the bigger the distance between an emitter and a receiver, the lower the SNR, as the signal loses in clarity with every obstacle it encounters (buildings, trees, air, rain, dust, birds, clouds, mist, smoke, ...).

SNR values for spoofing hotspots are often found to be higher than average, which makes sense, because spoofing hotspots are barely a few meters appart in a safe environment in the same room, instead of being outside, kilometers appart.

Although it is certainly possible for some witness events to register a higher than average SNR value even though both hotspots are physically separated by several kilometers, a high SNR value is more likely to be caused by spoofing activity than sheer luck.

**Impact on the Trust Score** : from **-0 to -1** for each interaction in the last 30 days showing an SNR value above a certain threshold, ranging from an SNR value of n to n+5, with n = 16.204e^(-0.086d) - 2, with d the registered distance between both hotspots (in kilometers).

(The values were chosen *somewhat* arbitrarily, from the study of a small data set, for the sake of this first draft. It should definitely be improved upon before being implemented)

![image](https://user-images.githubusercontent.com/106159694/173186803-36f81096-b20c-47fb-85f3-bfbcccc26b48.png)

SNR below green line : ✔️

SNR above red line : ❌ **-1**

SNR in-between : 🤔 between **-0 and -1**

- # RSSI

Similar to the SNR, the RSSI (Received Signal Strength Indication) is an indication of the strength of the received signal. Typically, the greater the distance between two hotspots, the lower the RSSI. An RSSI value that is too high usually means that two hotspots are physically closer than their asserted location suggests. It is common for spoofing hotspots to have their witnesses invalidated because their RSSI is too high. Although it can happen to honest miners, it is rarer.

Additionally, even if an RSSI is low enough that a witness is not automatically invalidated, a high RSSI value close to the maximum allowed value should at least be considered suspicious.

**Impact on the Trust Score** :
- **-1** per witness at least 2 hexes away in the last 60 days being invalid for having an RSSI too high.
- from **-1 to -0** per valid witness at least 2 hexes away in the last 60 days whose RSSI is close to the maximum allowed value, ranging from a difference of 0 to 15 between the recorded RSSI value and the maximum allowed value.

- # IP address

Spoofers often either use a VPN to conceal their IP in order to appear legit, or assert their location in a different country than their physical location.

There are cases of honest hotspots having an IP in a different country than their asserted location. Some owners are using VPNs either for convenience, or to hide their mining activity from their ISP *(Internet Service Provider)*. ISP can also be using CGNAT, with the hotspot's IPv4 being located in a different country. However, the former can use a VPN located in their country, while the latter is rare enough that we can consider the case of IP addresses being located in a different country than the asserted location of a hotspot to be more likely to belong to a spoofing hotspot.

**Impact on the Trust Score** :
- **-5** for a hotspot whose IP is located in a different country than its asserted location, or whose IP cannot be located.
- **-1** for each interaction in the last 7 days with a hotspot whose IP is located in a different country than its asserted location.

- # Interactions with other hotspots

This HIP introduces the concept of **webs** of hotspots.
A web of hotspots includes all hotspots that have interacted with each other in a given time frame. *If hotspot A interacts with hotspot B, hotspot B interacts with hotspot C, and hotspot C interacts with hotspot D, hotspots A through D are all part of the same web.*

This concepts allows to separate clusters of hotspots that are only interacting with each other (including spoofing hotspots) and hotspots that are legitimately interacting with the wider network.

**Clicking a hotspot on the explorer should highlight the web it is part of.** This is especially useful in dense areas, where it allows users to see which hotspots are on a closed loop and are only interacting with each other, which includes spoofers, since they are usually not physically present where their location is asserted.

Example *(not representative of the actual situation in that area, hexes were chosen randomly for the purpose of this example)* :
![image](https://user-images.githubusercontent.com/106159694/173186619-b34804ee-425b-4042-beac-080b1c0d34ba.png)

In this example, the web can show us that the hotspots in the orange web are having a suspicious activity. Despite being located in a dense area with hundreds of other hotspots to interact with, the hotspots highlighted in orange are only interacting with each other, indicating a possible spoofing activity.

The green web is the largest web in the area, including most hotspots in that area and strongly indicating that hotspots part of that web are not spoofing.

The other webs show hotspots that are too isolated to interact with the rest of the network.

**Impact on the Trust Score** : **+n^0.5**, n being the number of unique hexes in the 7 day old web of the hotspot whose Trust Score is being calculated. **Capped at +20** *(reached at 400 hexes)*

![image](https://user-images.githubusercontent.com/106159694/173186557-4961e5de-becd-4595-b4fd-0387837497dc.png)


- # Photo & Video proof

Users should be able to prove that they have an actual setup by providing high quality photographs as well as a video of their setup. People could then investigate these proofs to determine whether the picture and the video are legit, by checking details like the time of day, the weather, the environment, the actual setup, the quality of the picture, whether the picture was taken from the internet, ...

To limit cheating, **the photo and the video should be taken directly from the Helium app**, while ensuring that the device is not rooted and that no other apps are running in the background, in order to prevent people from using a third party app to tinker with the camera.

A picture or video that was proven to be fake is a heavy indication of spoofing, which can disincentivize spoofers from trying to cheat.

In order for genuine mistakes to be fixed, people responsible for denylist additions should be able to **contact hotspot owners directly via the Helium app**. Hotspot owners could then provide new and better proofs of their setup.

**Impact on the Trust Score** : **+10** for a hotspot with photo and video proof taken directly from the Helium app. If the proofs are then judged insufficent, the impact on the Trust Score would become **+0** until news proofs are provided and validated.

- # GPS localization

Users should be able to prove their location through GPS localization directly from the Helium app. In order to limit cheating, the Helium app should ensure that the device is not rooted and that no other apps are running in the background while the Helium app is open, in order to prevent people from using third party apps to simulate another location.

**Impact on the Trust Score** : **+10** for a hotspot with GPS localization proof uploaded directly from the Helium app.

- # Invalid witnesses

A witness can be invalid for two reasons :
- The registered distance between the beacon and the witness is greater than 100km.
- Its RSSI value is too high.

Like it is mentioned in HIP 58, over 99.9% of witnesses are within the 100km limit. The only few exceptions are tower deployments and spoofers. While the former might lose some points on their Trust Score, they will without a doubt compensate with their many valid witnesses. Spoofers, on the other hand, will have a harder time to regain those points.

**Impact on the Trust Score** :
- **-1** for each witness in the last 90 days that was invalid for being too far.
- *For invalid witnesses being caused by a high RSSI value, the impact on the trust score was detailed in the RSSI section of the HIP.*

- # Changes to the Helium app and the explorer

This HIP introduces some changes to the Helium app and to the explorer :

- Make the Trust Score for each hotspot visible on the explorer.
- Users should be able to sort hotspots by they Trust Score or by specific parts on the Trust Score (for example sorting only by their score on SNR values) in the explorer.
- The explorer should be able to display hotspot webs.
- Users should be able to report hotspots to the denylist directly from the Helium app / the explorer.
- Hotspot owners can be contacted directly via the Helium app by people in charge of the denylist.
- The Helium app should allow hotspot owners to take and upload pictures and videos directly from the Helium app.
- The Helium app should allow users to prove their GPS localization directly from the Helium app.
- The Helium app should be able to tell whether there are other apps running in the background, and whether a device is rooted.

# All Trust Score calculations

*A hotspot's Trust Score starts at 0. Then, points are either added or substracted depending on the hotspot's behavior in a given timeframe.*

- From **-1 to -0** for each interaction in the last 15 days with a hotspot that was added to the blockchain on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day difference  (-1 if both were added on the exact same date, -0 if they were added 30 days appart or more).
- **-1** for each location assertion in the last 365 days *(the first location assertion in a hotspot's history doesn't count)*.
- From **-1 to -0** for each interaction in the last 15 days with a hotspot whose latest location was asserted on a similar date, depending on how close the dates are, ranging from a 0 to a 30-day difference  (-1 if both were asserted on the exact same date, -0 if they were asserted 30 days appart or more).
- **-1** for each interaction in the last 15 days with a hotspot that shares at least one address
- **-1** per unique hotspot that was interacted with in the last 30 days and that shares an address in their money trail.
- From **-0 to -1** for each interaction in the last 30 days showing an SNR value above a certain threshold, ranging from an SNR value of n to n+5, with n = 16.204e^(-0.086d) - 2, with d the registered distance between both hotspots (in kilometers).
- **-1** per witness at least 2 hexes away in the last 60 days being invalid for having an RSSI too high.
- From **-1 to -0** per valid witness at least 2 hexes away in the last 60 days whose RSSI is close to the maximum allowed value, ranging from a difference of 0 to 15 between the recorded RSSI value and the maximum allowed value.
- **+n^0.5**, n being the number of unique hexes in the 7 day old web of the hotspot whose Trust Score is being calculated. **Capped at +20** *(reached at 400 hexes)*
- **+10** for a hotspot with photo and video proof taken directly from the Helium app. If the proofs are then judged insufficent, the impact on the Trust Score would become **+0** until news proofs are provided and validated.
- **+10** for a hotspot with GPS localization proof uploaded directly from the Helium app.
- **-1** for each witness in the last 90 days that was invalid for being too far.

# Drawbacks
[drawbacks]: #drawbacks

The way the Trust Score is calculated might negatively impact some honest miners that are in very specific situations. Although precautions are taken to limit this impact, by spreading the Trust Score over many types of data, there will probably some honest miners losing points on several of them *(an isolated cluster of hotspots all connected to the same VPN, belonging to the same owner, that were added to the blockchain and whose location was asserted on the same day, and whose rewards are all sent to the same wallet, for example)*. However, regardless on their Trust Score, additions to the denylist are never automatic, and even these rare cases should be able to prove their integrity directly from the Helium app.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Automatically cut (or simply lower) Proof of Coverage rewards from hotspots with a low Trust Score is a possibility. However, it is important to keep the "assumed innocent until proven guilty" ethos, which is why I designed the Trust Score to only be an indication, rather than a decisive value.

Data transfers could have been used in the calculation of the Trust Score, but they feel to easily cheated, as spoofers could simply trigger data transfers themselves.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Is the Trust Score too easily cheated ?

- Are there more types of data that can be used in its calculation ?

- Won't there be too many honest miners being negatively affected by the Trust Score for this HIP to be viable ?

- Can we really prevent cheaters from uploading fake photos, videos and GPS localization ?

- Do we really want hotspot owners to be contacted directly via the Helium app ?

# Deployment Impact
[deployment-impact]: #deployment-impact

Who will it affect, and how ?

✔️ Spoofers, who will be more susceptible to be reported and added to the denylist.

✔️ Legit hotspot owners, who should see their rewards increasing as the spoofers' share of the rewards is given back to honest miners.

❌ Honest hotspot owners in specific situations that fall through the cracks and end up with a low Trust Score, who might need to try harder to prove their integrity.

*This change is entirely backwards compatible.*

# Success Metrics
[success-metrics]: #success-metrics

- More hotspots being reported to the denylist.
- More hotspots being added to the denylist.
