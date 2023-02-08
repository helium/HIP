# HIP-XXX Location Assertion Requirement

- Author(s): [@tanny](https://github.com/ilovespectra)
- Start Date: 2023-02-05
- Category: Technical
- Original HIP PR:
- Tracking Issue:
- Code PR:

# Summary

[summary]: #summary

This HIP will change deployment guidelines to contain specific rules pertaining to location assertion. In order for a hotspot
to earn from both Proof of Coverage and Data Transfer, the hotspot will need to have the location asserted. This will apply to
Data Only hotspots as well. The Helium Network is reliant upon the accurate assertion of hotspots; To contribute to the network,
a hotspot will need to have its location asserted in order for the Rssi Table to be applied in order to determine validity
of witnesses. <b>ALL miners deployed on the network must assert their location in order to earn.</b>

# Motivation

[motivation]: #motivation

The motivation for this change is to provide instantly-asserted locations for hotspots on the network, and to reduce
the concern many community members have developed that Data Only hotspots are being used to acquire illegitimate DC
rewards. The assertion of hotspots is reliant upon an honor code system dependent on the honesty of participants.
There is no way to enforce this honesty, but rather verification methods in place to determine assertion legitimacy.
This proposal is to help refine these verification methods by additionally complicating geo-spoofing.
The presence of DC gaming would result in a clear accounting discrepancy that would be obvious, as more
DC would be rewarded to hotspots than is being paid for with HNT. This doesn't appear to be happening,
nonetheless many community members still feel concerned about the rewards for these data transfers. Requiring an
asserted location in order to mine both PoC and Data Transfer should be a requirement because the validity of the
network is determined through trilateration through analyzing predictable radio patterns.

# Stakeholders

[stakeholders]: #stakeholders

The impact this has on Stakeholders is having the potential to improve reputation of the network by clarifying the rules
for deploying hotspots, which should eliminate some doubt in the rewards mechanism pertaining to Data Transfer. This directly 
impacts Data Only hotspots and DO hotspot deployers.

# Detailed Explanation

[detailed-explanation]: #detailed-explanation

The 'Proof of Coverage' that The Helium Network is reliant upon is based on predictable properties of radio waves, which allow an automated
validation system to determine the approximate location of a hotspot through trilateration in order to determine rewards eligibility.
Without a location asserted, there is no other way to validate the location of the hotspot. Going forward, in order for a hotspot to
participate in Data Transfer rewards, it will need a location asserted.

Upon setting up a hotspot, the owner will be presented with a new disclaimer displaying the need to assert their location in order to
mine. In the event they do not assert their location, rewards will not be provided to the hotspot until they have done so. This concern
has been brought to the Helium community before, but there is no way to investigate this concern while preserving the autonomy of the
end-user, and permissionless nature of using the network. The only way to impact this mining behavior, which is perceived to be gaming by
many, is to make it more difficult on the network end. Requiring a location assertion complicates manipulating PoC and DC
rewards through geo-spoofing.

There is currently no miner or sensor deployment methodology that would require a location not be asserted, and legitimate hotspots
should not be greatly impacted. This HIP would immediately put into effect a need for all hotspots to have an asserted location. Hotspots
without a location asserted, whether Full, Light, or DO [Data Only], will immediately cease receiving Data Transfer mining rewards 
until their location has been asserted.

<b>NEW DEPLOYMENT GUIDELINE:</b>

LOCATION MUST BE ASSERTED- This includes DO, Light, and Full hotspots. In order to earn HNT from both PoC and Data Transfer, a hotspot 
will need to have the location asserted. A hotspot will not be considered deployed and will be ineligible for rewards until 
asserted.

# Implementation 

COMING SOON - IN DRAFT STAGE


# Drawbacks

[drawbacks]: #drawbacks

This could impact legit deployments who are in need of earnest relocating, because in hosting and setup, it is customary to
deploy a hotspot before it reaches its permanent location. This would remove the ability to 'test' a hotspot for free
at a residence before deployment, because much activity may be invalid depending on the distance from a
deployment location, requiring the end user to pay-to-reassert in the event they are prepared to deploy the unit. This inconvenience
however is outweighed by the potential benefit to the network from accurately asserted miners.

# Success Metrics

[success-metrics]: #success-metrics

Success will result in reduced suspicion of DC rewards, more accurately asserted hotspots on the network, a more reliable rewards
validation system, and an improved perception of the Helium Network's response to alleged gaming.
