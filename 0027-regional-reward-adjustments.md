# HIP27: Regional reward adjustments

- Author(s): @mj0lken (Malcolm Horal | Galiot)
- Start Date: 2021-02-06
- Category: Technical/RF
- Original HIP PR: <https://github.com/helium/HIP/pull/XYZ>
- Tracking Issue: <https://github.com/helium/HIP/issues/XYZ>

## Summary

___
[summary]: #summary
This porposal suggests the addition of a regional reward scaling chain variables to cope with different regional output regulation for the LoRa protocol.

## Motivation

___
[motivation]: #motivation
Much of the work done by Helium and the community has been made to optimize the network development. Recent changes in the RAK miner firmware have revealed that the current PoC system and token allocation lacks fidelity that takes regional ISM band regulations into account. This leads to an unequal depoloyment incentive comparing regions with higher and lower

## Stakeholders

___
[stakeholders]: #stakeholders

Anyone hosting a Helium gateway/miner will be affected by this change. Probability of hotspot owners in regions with lower RF power outputs will see higher token reward and vice versa.

Feedback and discussion on this change will be solicited & heard through the existing HIP discussion channel(s) (primarily Discord, in the respective channel),
and as usual through any git repo commentary.

## Detailed Explanation

___
[detailed-explanation]: #detailed-explanation

### Definitions

To better describe the proposal, I will introduce some terms and variable names.
Note these may be formatted differently in formulas:

**Density_tgt**: Target number of hotspots in target hex resolution (example = 1).  Density in a target resolution hex will be clipped at this number unless certain conditions are met.  This would be a chain variable for each resolution of interest.

**Density_max**: maximum number of hotspots to consider for target resolution any density beyond this will be clipped under any conditions.  (Example= 4) This would be a chain variable for each resolution of interest.

**N**: number of neighboring hex’s that must meet **Density_tgt** before clipping will be raised above **Density_tgt**. (Example =2).  This would be a chain variable for each resolution of interest.

**Interactive Hotspot**: an active hotspot that has also recently had a transmission witnessed.  Lone wolves are active but not interactive.

**Occupied Hex**: hex where at least one interactive hotspot is present.  This can apply to any resolution of interest.  It also implies that if we know a certain hex is occupied, all parents of that hex up to resolution 0 are also occupied.

**Hex Whitelist**: a list of hex’s that are eligible for rewards, these could be specified at any level but in general should be as low a resolution (largest area) as possible.  If this feature is not desired, you can assume all resolution 0 hexs are in the whitelist.  This would be a chain variable.

## Drawbacks

___
[drawbacks]: #drawbacks

- This does not in any regard change the Lone Wolf edge case.

## Rationale and Alternatives

___
[alternatives]: #rationale-and-alternatives

- Not caring about regional differences: Adopting the **Keeping It Stupid, Simply** instead of the **Keep It Simple, Stupid** principle.
- Asserting a scale factor directly to Hotspot during location assert procedure.

## Unresolved Questions

___
[unresolved]: #unresolved-questions

- Balancing scaling factor for each resolution
- Scaling in regards to regional frequency differences.

## Deployment Impact

___
[deployment-impact]: #deployment-impact

## Success Metrics

___
[success-metrics]: #success-metrics

<!-- ! OLD -->
Noteworthy changes would include additional overhead in terms of data sent over the network as part of these additional payment transactions. Generally feedback from
the Helium community would be solicited as to whether the new functionality was proving to be helpful and/or whether there were drawbacks in performance or user experience
that result from the new abilities. It would also be of note to monitor performance of the network (blocktimes etc) to ensure that the performance was not significantly overall.
