# HIP12: Remote Location Assert

- Start Date: 2020-06-18
- Original HIP PR: <https://github.com/helium/HIP/pull/30>
- Tracking Issue: <https://github.com/helium/HIP/issues/39>

# Summary


Hotspot owners, especially Patrons, have a frequent need to update hotspots' asserted locations when changing their physical locations. This can currently only be done when the hotspot owner has physical access to the hotspot.

This HIP proposes a new transaction, `assert_location_v2`, which will allow a hotspot's location to be asserted remotely without physical access to the hotspot.

# Motivation


Asserting a new location with the `assert_location_v1` currently requires a signature from the hotspot, which requires physical access (Bluetooth connection) to obtain.

This poses a massive operational headache for owners and Patrons who have deployed hotspots at remote locations, and leaves them with no options other than:

- a) travel to the hotspot's current location
- b) have the hotspot temporarily shipped back
- c) share their private key with hotspot hosts to perform the assertion

All of these options are costly and/or dangerous.

# Stakeholders


Any Helium hotspot owner who has deployed at least one remote hotspot.

The Helium blockchain engineering team.

# Detailed Explanation


## Implement a new transaction, `assert_location_v2`, and optionally deprecate the previous `assert_location_v1`

This new transaction would require the owner's private key, hotspot public key and h3 index of the new desired location. It would replace the hotspot's existing location, and charge the same assert fee (in DC) as `assert_location_v1`.

## Create a simple UI for asserting hotspot location in the Helium mobile app

This UI would be the same as the current pin-drop UI, centering the map on either the hotspot's current location, or the phone's current location if the hotspot has no location.

It would need to be easy to find. It could be exposed as a new button next to the gear-icon button that is currently used to bring up the Bluetooth connection UI, or possibly as a separate section on the Bluetooth connection modal, where it's made clear that a direct connection to the hotspot isn't required to use this function.

If the hotspot's current asserted location is far (>1km) from the user's current GPS location, they should be warned that they are changing the location for a remote hotspot and picking the wrong location could have an impact on that hotspot's earnings.

# Drawbacks


It will add a new type of transaction which will have to be maintained and considered in all parts of the codebase where the current `assert_location_v1` transaction is considered.

# Rationale and Alternatives


This is a simple and straightforwad solution that will save hotspot owners time, effort and frustration.

Not making this change could deter current and future owners from making remote deployments, which could be viewed as too much of an operational hassle. This could hurt the growth of the network.

It will generally reduce operational friction.

# Deployment Impact


It can be deployed in a routine hotspot update. It will also need support in the Helium mobile app for the easiest and safest experience. However, if this requires too much bandwidth from the Helium team, it can be supported in the CLI as a temporary measure to at least make remote assertion possible. In this case, @rawrmaan could make a guide to help the less tech-savvy hotspot owners do some remote assertions in a safe way.

# Success Metrics


- Number of hotspot locations asserted with `assert_location_v2`
- Hotspot owner & Patron complaints in chat channels reducing to zero
