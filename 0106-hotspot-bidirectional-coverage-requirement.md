# HIP 106: Hotspot Bidirectional Coverage Requirement

- Author(s): [@mawdegroot](https://github.com/mawdegroot)
- Start Date: 2023-12-12
- Category: Technical, Economic
- Original HIP PR: [#828](https://github.com/helium/HIP/pull/828)
- Tracking Issue: [#870](https://github.com/helium/HIP/issues/870)
- Vote Requirements: veIOT Holders

## Summary

[summary]: #summary

Hotspots that can not provide bidirectional coverage are not useful for the IOT network as well as pose gaming risks. These risks are currently mitigated by the denylist operated by Nova Labs. This proposal proposes to move the bidirectionality metric that is currently enforced by the denylist to the PoC pipeline. This will result in hotspot owners being signaled of the issue faster and subsequently will signal hotspot owners that the issue has been resolved without waiting until the next denylist iteration.

## Motivation

[motivation]: #motivation

By moving the bidirectional coverage check from the denylist to the proof of coverage pipeline it will signal a hotspot owner of a problem significantly faster. The hotspot will also be considered for rewards significantly faster after the issue has been resolved.

## Stakeholders

[stakeholders]: #stakeholders

All hotspot owners will be affected by this HIP. In particular hotspot owners that have hotspots that are unable to successfully witness or beacon. Two groups of hotspot owners are directly affected: the group of hotspot owners that is currently flagged for not being able to witness or beacon and the group of hotspot owners that experience such a failure in the future.

The hotspot owners that are currently flagged for not being able to witness or beacon successfully will have a faster recourse if this proposal passes. The current denylist cadance is roughly _7 days_ whereas this proposal will determine if a hotspot supports bidirectional coverage much faster, thus offering faster recourse and feedback if such a failure is resolved.

The hotspot owners that will experience an inability to provide bidirectional coverage in the future will have faster feedback because they will stop being rewarded after _48 hours_. After resolving the issue the hotspot owner will not have to wait for the 7 day denylist cadence but instead will have immediate feedback that the issue is resolved as PoC rewards return.

## Detailed Explanation

[detailed-explanation]: #detailed-explanation

When a hotspot beacons the oracles will perform the existing proof of coverage checks. If the beacon report is valid and has at least one witness, the oracles will record the last beacon timestamp of the beaconer as well as the last witnessed timestamp for each of the valid witnesses. After the oracle has successfully processed the proof of coverage event it will run the reciprocity checks for the beaconer and each of the witnesses. If the beaconer has not witnessed any hotspots in the last _48 hours_ the beacon will be invalidated with `GatewayNoValidWitnesses`. Similarly, for all the witnesses of the beacon the oracle will check if the witnessing hotspot has successfully beaconed another hotspot in the last _48 hours_. If a witness has not successfully beaconed in the last _48 hours_ the witness event will be invalidated with invalid reason `GatewayNoValidBeacons`.

If a hotspot has a valid witness it will update the last witnessed timestamp, even if the hotspot has its witness events invalid for `GatewayNoValidBeacons`. Similarly, if a hotspot has a valid beacon (with witnesses) but it is invalided for `GatewayNoValidWitnesses` the last beaconed time is still updated. This prevents a situation in which a hotspot can't successfully beacon for not having valid witnesses and not successfully witness for not having valid beacons.

### New invalid reasons `GatewayNoValidBeacons` and `GatewayNoValidWitnesses`

[detailed-explanation-new-invalid-reasons]: #detailed-explanation-new-invalid-reasons

There will be two new invalid reasons, `GatewayNoValidBeacons` and `GatewayNoValidWitnesses`. The invalid reason `GatewayNoValidBeacons` will signal a hotspot owner that the reason for not being considered for rewards is that the hotspot is not having valid beacons. Similarly, the invalid reason `GatewayNoValidWitnesses` will signal a hotspot owner that the hotspot is not having valid witnesses and therefore not considered for rewards.

The invalid reason `GatewayNoValidBeacons` will take precedence in the case that a hotspot is both not successfully witnessing and not successfully sending beacons. When a hotspot is coming online for the first time or after being offline for a prolonged time its witnesses will be invalid with invalid reason `GatewayNoValidBeacons` until the first successfull beacon.

## Drawbacks

[drawbacks]: #drawbacks

The main drawback of this proposal is that it increases the complexity of the `iot_verifier` oracle and the poc verification pipeline in general. As this proposal primarily moves an existing mechanism (currently as part of the denylist) to the oracle pipeline we believe that the increased complexity is less of a maintenance burden than the manual intervention needed in the denylist mechanism.

## Rationale and Alternatives

[rationale-and-alternatives]: #rationale-and-alternatives

The alternative to this solution is to maintain the status quo where a hotspot is added to the denylist for at least 7 days and will have to wait until the next denylist iteration after the issue has been resolved. We think an automated system within the PoC pipeline is a better solution because it resolves some of the problems the community currently experiences.

1. The signaling of an issue is applied much faster.
2. In case a hotspot owner resolves the issue the signaling that the fix has been succesful is faster
3. The currently denylist is largely automated but it still requires amount of manual intervention which could be avoided by this proposal

## Unresolved Questions

[unresolved-questions]: #unresolved-questions

Any denylist classifier that acts upon witness reciprocity will have to make sure that it does not list a hotspot for lack of reciprocity that is already covered by the proof of coverage pipeline.

## Deployment Impact

[deployment-impact]: #deployment-impact

When this proposal passes and is deployed the `iot_verifier` oracle will be upgraded to the version including the proposed changes. After the `iot_verifier` update is successfully deployed the denylist process will cease to include the `witness_reciprocity` metric the first denylist iteration _after_ deployment.

The explorers will have to implement the new invalid reasons `NoSuccessfullBeacons` and `NoValidWitnesses` to provide the user with correct feedback on why their hotspot is currently not considered for rewards.

The documentation will have to be changed to reflect the new invalid reasons `GatewayNoValidBeacons` and `GatewayNoValidWitnesses`. The documentation will have to include that `GatewayNoValidBeacons` takes precedence over `GatewayNoValidWitnesses` and that a hotspot becoming active after being offline for a prolonged time will have its witnesses invalidated with invalid reason `GatewayNoValidBeacons` until the first successfull beacon.

## Success Metrics

[success-metrics]: #success-metrics

The intended result of this proposal is that hotspot owners are signalled about hotspots not providing useful coverage sooner as well as enabling hotspot rewards sooner after the problem is resolved. The main success metrics for this proposal are:

1. Less manual intervention (e.g. no denylist update required)
2. Hotspot owners being informed of the broken hotspot sooner
3. Hotspot owners being rewarded sooner after they rectify the hotspot's issue.
