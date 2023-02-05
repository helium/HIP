# HIP-XXX Location Assertion Requirement

- Author(s): [@tanny](https://github.com/ilovespectra)
- Start Date: 2023-02-05
- Category: Technical
- Original HIP PR:
- Tracking Issue:
- Code PR:

# Summary

[summary]: #summary

This HIP will change deployment guidelines to contain specific rules pertaining to location assertion.
The first assertion is paid for by the manufacturer at no expense to the end user. In order for a hotspot
to earn from Proof of Coverage or Data Transfer, the hotspot will need to have the location asserted. This will apply to
data only hotspots as well. The Helium Network is reliant upon the accurate and honest deployment and assertion
of hotspots; To contribute to the network, your hotspot will need to have its location asserted
in order for the Rssi Table to be applied in order to determine validity of witnesses. <b>Miners deployed on the
network must assert their location in order to earn.</b>

# Motivation

[motivation]: #motivation

The motivation for this change is to provide instant accurate locations for hotspots on our network, and to reduce
the concern many community members have developed that Data Only hotspots are being used to acquire illegitimate DC
rewards. The presence of DC gaming would result in a clear accounting discrepancy that would be obvious, as more
DC would be rewarded to hotspots than is being paid for with HNT. This would be obvious, and doesn't appear to be happening,
nonetheless many community members still feel concerned about the rewards for these data transfers. Requiring an
asserted location in order to mine PoC or DC from data transfer should be a requirement because the validity of our
network is determined through GPS triangulation through analyzing predictable radio patterns.

# Stakeholders

[stakeholders]: #stakeholders

The only impact this has on Stakeholders is having the potential to improve reputation of the network by clarifying the rules
for deploying hotspots, which should eliminate some doubt in the rewards mechanism pertaining to Data Transfer.

# Detailed Explanation

[detailed-explanation]: #detailed-explanation

The 'Proof of Coverage' that The Helium Network is reliant upon is based on predictable properties of radio waves, which allow an automated
validation system to determine the approximate location of a hotspot through triangulation in order to determine rewards eligibility.
Without a location asserted, there is no other way to validate the location of the hotspot. Going forward, in order for your hotspot to 
participate in 'proof', it will need a location asserted.

Upon setting up a hotspot, the owner will be presented with a new disclaimer displaying the need to assert their location in order to
mine. In the event they do not assert their location, rewards will not be provided to the hotspot until they have done so. This concern
has been brought to the Helium community before, but there is no way to investigate this concern while preserving the autonomy of the
end-user, and permissionless nature of using the network. The only way to impact this mining behavior, which is perceived to be gaming by
many, is to make it more difficult on the network end. Requiring a location assertion eliminates the ability to manipulate PoC and DC
rewards through geo-spoofing.

There is currently no miner or sensor deployment methodology that would require a location not be asserted, and legitimate hotspots
should not be greatly impacted. This HIP would immediately put into effect a need to have an accurately asserted location. Hotspots
without a location asserted, whether Full, Light, or DO [Data Only], will immediately cease receiving mining rewards until their location has
been asserted.

<b>NEW DEPLOYMENT GUIDELINES:</b>

LOCATION MUST BE ASSERTED- This includes DO, Light, and Full hotspots. In order to earn HNT from PoC or Data Transfer, your hotspot will need to have
the location asserted. Your hotspot will not be considered deployed until then and will be ineligible for rewards until you've done so.

# Drawbacks

[drawbacks]: #drawbacks

This could impact legit deployments who are in need of earnest relocating, because in hosting and setup, it is customary to
deploy a hotspot before it reaches its permanent location. This would remove the ability to 'test' a hotspot for free
at your residence before deployment, because much activity may be invalid depending on the distance from your
deployment location, requiring the end user to pay-to-reassert in the event they are prepared to deploy the unit. This inconvenience
however is outweighed by the potential benefit to the network from accurately asserted miners.

# Success Metrics

[success-metrics]: #success-metrics

Success will result in reduced suspicion of DC rewards, more accurately asserted hotspots on the network, a more reliable rewards
validation system, and an improved perception of the Helium Network's response to alleged gaming.

