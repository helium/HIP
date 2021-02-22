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

- **LOS**: Line Of Sight, Rx visible from Tx.
- **GW**: Short for gateway aka. hotspot, miner, etc.
- **Tx**: Transmitting gateway.
- **Fade Margin**: Calculation artifact for potential environmental obsticles and other conditions
- **Density_tgt**: Target number of hotspots in target hex resolution (example = 1).  Density in a target resolution hex will be clipped at this number unless certain conditions are met. This would be a chain variable for each resolution of interest.
- **Density_max**: maximum number of hotspots to consider for target resolution any density beyond this will be clipped under any conditions. (Example= 4) This would be a chain variable for each resolution of interest.
- **N**: number of neighboring hex’s that must meet **Density_tgt** before clipping will be raised above **Density_tgt**. (Example =2). This would be a chain variable for each resolution of interest.
- *Interactive Hotspot**: an active hotspot that has also recently had a transmission witnessed. Lone wolves are active but not interactive.
- **Occupied Hex**: hex where at least one interactive hotspot is present. This can apply to any resolution of interest.  It also implies that if we know a certain hex is occupied, all parents of that hex up to resolution 0 are also occupied.
- **Hex Whitelist**: a list of hex’s that are eligible for rewards, these could be specified at any level but in general should be as low a resolution (largest area) as possible. If this feature is not desired, you can assume all resolution 0 hexs are in the whitelist. This would be a chain variable.
- **Region Scaling** TBD...

## Description

___
[detailed-explanation]: #detailed-explanation

This proposal will build upon [Hip-17] and introduce scaling in regards to signal fading at different Tx. The [Jan 27 firmware update] revealed a greate inequality in the network deployment incitament. The current effect difference of 27 dBm vs 14 dBm is equivalent to Tx of 500 mW vs 25 mW, which is a 20 fold difference.

The following table shows the different signal range  and area coveragefor Europe and USA for different fade margins at receiver sensitivity -126 dBm ([SF8125kHz]):

| Fade margin (dB) | Range @14dBm/🇪🇺  (km) | Range @27dBm/🇺🇸  (km) | Range difference factor | Area Coverage @14dBm/🇪🇺  (km^2) | Area Coverage @27dBm/🇺🇸  (km^2) | Area difference factor | Comments |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 0 | 273 | 1220 | 4.5 | 234 140 | 4 675 947 | 20 | LOS, no building or obstacles |
| 25 | 15.4 | 68.6 | 4.5 | 745 | 14 784 | 20 | ~1 obscuring building (Tx on rooftop, Rx inside a building) |
| 40 | 2.7 | 12.2 | 4.5 | 23.4 | 468 | 20 | - |
| 50 | 3.86 | 3.89 | 3.2 | 2.3 | 46.8 | 20 | ~2 obscuring building (Tx in building, Rx inside a building) |

With a range factor of 4.5 and an area coverage factor of 20 this gives the Helium Gateway owners vastly mixed signals about 

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
[Jan 27 firmware update]: https://engineering.helium.com/2021/01/27/hotspot-firmware-power-updates.html
[SF8125kHz]: https://www.semtech.com/products/wireless-rf/lora-transceivers/sx1276
