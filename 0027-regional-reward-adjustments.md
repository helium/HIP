# HIP27: Regional reward adjustments

- Author(s): @mj0lken (Malcolm Horal | Galiot)
- Start Date: 2021-02-06
- Category: Technical/RF
- Original HIP PR: <https://github.com/helium/HIP/pull/XYZ>
- Tracking Issue: <https://github.com/helium/HIP/issues/XYZ>

## Summary

___
[summary]: #summary
This porposal suggests the addition of a regional reward scaling chain variables to deal with different regional output regulation for the LoRa protocol in order to create an equal deployment incentive over the world.

## Motivation

___
[motivation]: #motivation
Much of the work done by Helium and the community has been made to optimize the network development. Recent changes in the RAK miner firmware have revealed that the current PoC system and token allocation lacks resolution in taking regional ISM band regulations into account. This leads to an unequal deployment incentive comparing regions with different TX Max Power. The US 27dBm Tx Max Power to covers 20 times the area compared to the EU output of 24dBm.

## Stakeholders

___
[stakeholders]: #stakeholders

Anyone hosting a Helium gateway/miner will be affected by this change.

Feedback and discussion on this change will be solicited & heard through the existing HIP discussion channel(s) (primarily Discord, in the respective channel),
and as usual through any git repo commentary.

## Definitions

___
[detailed-explanation]: #detailed-explanation

- **GW**: Short for gateway aka. hotspot, miner, etc.
- **Tx**: Transmitting gateway.
- **Density_tgt**: Target number of hotspots in target hex resolution (example = 1).  Density in a target resolution hex will be clipped at this number unless certain conditions are met. This would be a chain variable for each resolution of interest.
- **Density_max**: maximum number of hotspots to consider for target resolution any density beyond this will be clipped under any conditions. (Example= 4) This would be a chain variable for each resolution of interest.
- **N**: number of neighboring hex’s that must meet **Density_tgt** before clipping will be raised above **Density_tgt**. (Example =2). This would be a chain variable for each resolution of interest.
- *Interactive Hotspot**: an active hotspot that has also recently had a transmission witnessed. Lone wolves are active but not interactive.
- **Occupied Hex**: hex where at least one interactive hotspot is present. This can apply to any resolution of interest.  It also implies that if we know a certain hex is occupied, all parents of that hex up to resolution 0 are also occupied.
- **Hex Whitelist**: a list of hex’s that are eligible for rewards, these could be specified at any level but in general should be as low a resolution (largest area) as possible. If this feature is not desired, you can assume all resolution 0 hexs are in the whitelist. This would be a chain variable.

## Detailed Explanation

___
[detailed-explanation]: #detailed-explanation

This proposal will build upon [Hip-17] and introduce scaling in regards to signal fading at different Tx. This issue was introduced

Signal Range
![signal range](/0027-regional-reward-adjustments/signal-range.png)
<!-- TODO: Build native table -->

Signal Range
![signal area](/0027-regional-reward-adjustments/signal-area.png)
<!-- TODO: Build native table -->

## Drawbacks

___
[drawbacks]: #drawbacks

- This does not in any regard change the Lone Wolf edge case.

## Rationale and Alternatives

___
[alternatives]: #rationale-and-alternatives

- Not caring about regional differences: Adopting the **Keeping It Stupid, Simply** instead of the **Keep It Simple, Stupid** principle.
- Asserting a scale factor directly to Hotspot during location assert procedure.
- Capping Hotspot Tx universally at 14 dBm

## Unresolved Questions

___
[unresolved]: #unresolved-questions

- Balancing scaling factor for each resolution
- Scaling in regards to regional frequency differences.

## Deployment Impact

___
[deployment-impact]: #deployment-impact

This deployment will effect all hotspot owners. Hotspot owners in EU will likely see a significant change in earnings (either up or down) based on the new reward methodology.
It will also require significant documentation update on how proof-of-coverage is performed and rewarded.

## Success Metrics

___
[success-metrics]: #success-metrics

<!-- ! OLD -->
Noteworthy changes would include additional overhead in terms of data sent over the network as part of these additional payment transactions. Generally feedback from
the Helium community would be solicited as to whether the new functionality was proving to be helpful and/or whether there were drawbacks in performance or user experience
that result from the new abilities. It would also be of note to monitor performance of the network (blocktimes etc) to ensure that the performance was not significantly overall.

<!-- References -->

[scale-fading-n-net-deployment]: http://www.sis.pitt.edu/prashk/inf1072/Fall16/lec5.pdf
[hip-17]: https://github.com/helium/HIP/blob/master/0017-hex-density-based-transmit-reward-scaling.md
