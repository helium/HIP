- Start Date: 2020-06-18
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

Since the GPS location assertion check will soon be enforced, more than 1500 hotspots will need to be adjusted in some way in order to have a good GPS fix and continue participating in Proof of Coverage (see current hotspot `gps_fix_quality` states below). For many hotspots, this will require updating the asserted location to accurately reflect the hotspot's latest location, which can currently only be done with physical access to the hotspot.

```
gps_fix_quality | count 
----------------+-------
good_fix        |  2275
no_fix          |  1090
bad_assert      |   514
```

This HIP proposes a new transaction, `assert_location_v2`, which will allow a hotspot's location to be asserted remotely without physical access to the hotspot.

# Motivation
[motivation]: #motivation

Asserting a new location with the `assert_location_v1` currently requires a signature from the hotspot, which requires physical access (Bluetooth connection) to obtain.

This poses a massive operational headache for owners and Patrons who have deployed hotspots at remote locations, and leaves them with no options other than:

- a) travel to the hotspot's current location
- b) have the hotspot temporarily shipped back
- c) share their private key with hotspot hosts to perform the assertion

All of these options are costly and/or dangerous, and options a & b prevent iteration on the hotspot's location to get it "just right" within the GPS fix tolerance range. Iteration is important because a consistent GPS fix can take hours or days to measure.

# Stakeholders
[stakeholders]: #stakeholders

Any Helium hotspot owner who has deployed at least one remote hotspot. The issue of not being able to assert location remotely has caused a large outcry within the hotspot owner community on Slack and Telegram.

The Helium blockchain engineering team.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Implement a new transaction, `assert_location_v2`, and optionally deprecate the previous `assert_location_v1`

This new transaction would require the owner's private key, hotspot public key and lat/long coords of the new desired location. It would be submitted to the blockchain to replace the hotspot's existing location, and charge the same assert fee (in DC) as `assert_location_v1`.

## Create a simple UI for asserting hotspot location in the Helium mobile app

This UI would be the same as the current pin-drop UI, centering the map on either the hotspot's current location, or the phone's current location if the hotspot has no location.

It would need to be easy to find. It could be exposed as a new button next to the gear-icon button that is currently used to bring up the Bluetooth connection UI, or possibly as a separate section on the Bluetooth connection modal, where it's made clear that a direct connection to the hotspot isn't required to use this function.

If the hotspot's current asserted location is far (>1km) from the user's current GPS location, they should be warned that they are changing the location for a remote hotspot and picking the wrong location could have an impact on that hotspot's earnings.

# Drawbacks
[drawbacks]: #drawbacks

It will add a new type of transaction which will have to be maintained and considered in all parts of the codebase where the current `assert_location_v1` transaction is considered.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

This is a simple and straightforwad solution that will save hotspot owners time, effort and frustration. It will reduce the amount of chatter and complaints clogging up the chat channels about how frustrating it is to not be able to do this.

Not making this change could deter current and future owners from making remote deployments, which could be viewed as too much of an operational hassle. This could hurt the growth of the network.

Hotspot owners could be upset if they aren't able to update a far-away hotspot before the GPS assertion check is enforced and they lose their earnings until they can access it.

It will generally reduce operational friction, and friction in the community.

# Unresolved Questions
[unresolved]: #unresolved-questions

Are there any security, privacy or other implications of allowing location to be remotely asserted with only the account holder's private key and not the hotspot's signature?

How will this be implemented? (Seriously, I don't know Erlang, help!) (...but I will do my best if nobody can help get this done quickly)

# Deployment Impact
[deployment-impact]: #deployment-impact

It can be deployed in a routine hotspot update. It will also need support in the Helium mobile app for the easiest and safest experience. However, if this requires too much bandwidth from the Helium team, it can be supported in the CLI as a temporary measure to at least make remote assertion possible. In this case, @rawrmaan could make a guide to help the less tech-savvy hotspot owners do some remote assertions in a safe way.

# Success Metrics
[success-metrics]: #success-metrics

- Number of hotspot locations asserted with `assert_location_v2`
- Hotspot owner & Patron complaints in chat channels reducing to zero
- Reduction in `bad_assert` hotspots to nearly zero
