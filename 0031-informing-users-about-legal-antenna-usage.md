# HIP 31: Require manufacturers selling antennas to inform the users about the legality.

- Author(s): [@timcooijmans](http://github.com/timcooijmans) HeNet B.V.
- Start Date: 2021-05-22
- Category: Technical
- Original HIP PR: [#180](https://github.com/helium/HIP/pull/180)
- Tracking Issue:
- Status: In Discussion (2021-05-22)

# Summary
[summary]: #summary

In a search for increasing coverage (and earnings) hotspot operators are 
increasingly looking at installing antennas with an increased gain. To accomodate 
for those needs some hotspot manufacturers are selling high-gain
antennas as an optional accessory for their hotspots. Many buyers are not 
aware that using the combination of the sold hotspot with the sold antenna is
illegal in most regulatory domains. They expect anything sold together to be legal, 
while this in most cases not the case. Staying legal is of cricical importance for the Helium 
network. While manufacturers cannot prevent the usage of illegal antennas, they at least should inform
the users. Failure to do should (temporarly) ban them from being a HIP-19 approved manufacturer by 
(temporarly) revoking access to the DeWi-onboarding server.

# Motivation
[motivation]: #motivation

In a search for increasing coverage (and earnings) hotspot operators are 
increasingly looking at installing antennas with an increased gain. Using an antenna(+cable) with an
increased gain compared to the stock antenna is illegal in most, if not all, regulatory domains. 

In our opinion manufacturers at the moment are not informing buyers (enough) about the legality of using a
certain increased gain antenna with their hotspot both sold in the same sale channel. Buyers assume that the
 combination of hotspot and antenna sold in the same sale channel is legal. 

It's critical for the Helium network to stay legal, and while Helium Inc. or DeWi are not responsible
for the installations hotspot owners are using, situations where the Helium network is forbidden because most 
hotspot-operators are not following the rules should be absolutely avoided. Also situations where operators are
fined or even jailed because they are unknownly operating an illegal combination should be avoided.

This HIP doesn't ban hotspot operators from using high-gain antenna's because that is simply not possible. It only
enforces HIP-19 approved manufacturers to inform their buyers about the legality of antenna's sold in the same sale
channel as their hotspots for each regulatory domain their hotspot is approved in. 


# Stakeholders
[stakeholders]: #stakeholders

HIP-19-approved or to be approved manufacturers: All manufacturers are following the HIP repo and/or can be informed. 

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

For each non-stock antenna a HIP-19 approved manufacturer is selling (or providing for free) in the same sales channel (i.e. webshop). 
The manufacturer must state, for each hotspot, for each regulatory domain that the hotspot is certified in, if the combination of 
the hotspot and antenna is legal, under what conditions and optionally what steps should be taken to keep it legal 
(with a link to documentation how to perform those steps)

An (fictional) example of such information:

>**Item for sale:** LongAP 6 dBi antenna
>
>**Description:**
>
>*Regulatory information on using this antenna.* 
>
>Please consult the table below to ensure that you can use this antenna legally within your area:
>
>|Hotspot|Regulatory domain|Information|
>|-------|-----------------|------------|
>|LongAP One|CE| You are only allowed to use this antenna with a connecting cable that has a loss of 3 dBm or higher |
>|LongAP Pro|CE| Please select the antenna in the setup screen of LongAP Pro to reduce the transmission power, instructions can be found here|
>|LongAP Pro|FCC| FCC forbids the usage of higher-gain antennas|

HIP-19 Manufacturers have 4 weeks after the approval of this HIP to include the required information on their sales channels. 

Failure to do so, leads to the refusal of new hotspots to be onboarded by the DeWi onboarding server. This doesn't affect already produced hotspots that are 
already supplied to customers. 


# Drawbacks
[drawbacks]: #drawbacks

- None

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

We considered proposing enforcement of legal antenna gains by refusing assert-location-v2 transactions based on the location of the hotspot.
But this is difficult to maintain and doesn't consider regulatory domains where reducing the transmission power after sale is allowed. 

# Unresolved Questions
[unresolved]: #unresolved-questions

- Does the DeWi onboarding server have a way of temporarly refusing onboarding?
- Is the DeWi capable (staffing for example) of and willing to enforcing this HIP?

# Deployment Impact
[deployment-impact]: #deployment-impact

HIP-19 Manufacturers have 4 weeks after the approval of this HIP to include the required information on their sales channels. 

# Success Metrics
[success-metrics]: #success-metrics

- Hotspot operators are not fined or jailed for operating illegal antenna+hotspot combinations
- The Helium network is considered as legal and non-disruptive. 
