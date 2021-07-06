# HIP33: Regional Reward Adjustments

- Author(s): @mj0lken (Malcolm Horal | Galiot) + XYZ.
- Start Date: 2021-02-06
- Category: Technical, Economic
- Original HIP PR: https://github.com/helium/HIP/pull/210
- Tracking Issue: https://github.com/helium/HIP/issues/222
- Status: In Discussion

## Summary

[summary]: #summary
This proposal suggests the addition of a regional reward scaling chain variables to deal with different regional output regulation for the LoRa protocol in order to create an equal deployment incentive over the world.

## Motivation

[motivation]: #motivation
Much of the work done by Helium and the community has been made to optimize the network development. Recent changes in the RAK miner firmware have revealed that the current PoC system and token allocation lacks resolution in taking regional LoRa band regulations into account. This leads to an unequal deployment incentive comparing regions with different TX Max Power. The US 27dBm Tx Max Power to covers 20 times the area compared to the EU output of 24dBm.

## Stakeholders

[stakeholders]: #stakeholders

Anyone hosting a Helium gateway/miner and anyone using the network will be affected by this change.

Feedback and discussion on this change will be solicited & heard through the existing HIP discussion channel(s) (primarily Discord, in the respective channel),
and as usual through any git repo commentary.

## Definitions

[detailed-explanation]: #detailed-explanation

- **LOS**: Line Of Sight, Rx visible from Tx
- **GW**: Short for gateway aka hotspot, miner etc
- **SFN**: Spreading Factor N
- **Tx**: Transmitting gateway
- **PoC**: Proof of Coverage
- **Fade Margin**: Calculation artifact for potential environmental obsticles and other conditions
- **Density_tgt**: Target number of hotspots in target hex resolution (example = 1).  Density in a target resolution hex will be clipped at this number unless certain conditions are met. This would be a chain variable for each resolution of interest.
- **Density_max**: maximum number of hotspots to consider for target resolution any density beyond this will be clipped under any conditions. (Example= 4) This would be a chain variable for each resolution of interest.
- **N**: number of neighboring hex’s that must meet **Density_tgt** before clipping will be raised above **Density_tgt**. (Example =2). This would be a chain variable for each resolution of interest.
- *Interactive Hotspot**: an active hotspot that has also recently had a transmission witnessed. Lone wolves are active but not interactive.
- **Occupied Hex**: hex where at least one interactive hotspot is present. This can apply to any resolution of interest.  It also implies that if we know a certain hex is occupied, all parents of that hex up to resolution 0 are also occupied.
- **Hex Whitelist**: a list of hex’s that are eligible for rewards, these could be specified at any level but in general should be as low a resolution (largest area) as possible. If this feature is not desired, you can assume all resolution 0 hexs are in the whitelist. This would be a chain variable.
- **Region Scaling** TBD...

## Description

[detailed-explanation]: #detailed-explanation

### Current situation
This proposal will build upon [Hip-17] and introduce scaling in regards to signal fading at different Tx. The [Jan 27 firmware update] revealed a greate inequality in the network deployment incitament. The current Tx effect difference of 27 dBm vs 14 dBm, which is a 20x difference. To further complicate the situation EU Hotspots sends their PoC at SF12 whearas in the rest of the world uses SF8 which accounts for a difference of 7,5 dB. The total effect difference is that of 5,5 dBm at the moment.

The following table shows the theoretical different signal range and area coverage for Europe and North America for different fade margins at receiver sensitivity -126 dBm ([SF8125kHz]):

| Fade margin (dB) | Range @14dBm/🇪🇺  (km) | Range @27dBm/🇺🇸  (km) | Range difference factor | Area Coverage @14dBm/🇪🇺  (km^2) | Area Coverage @27dBm/🇺🇸  (km^2) | Area difference factor | Comments |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 0| 273 | 1220 | 4.5 | 234 140 | 4 675 947 | 20 | LOS, no building or obstacles |
| 25 | 15.4 | 68.6 | 4.5 | 745 | 14 784 | 20 | ~1 obscuring building (Tx on rooftop, Rx inside a building) |
| 40 | 2.7 | 12.2 | 4.5 | 23.4 | 468 | 20 | - |
| 50 | 0.86 | 3.89 | 4.5 | 2.3 | 46.8 | 20 | ~2 obscuring building (Tx in building, Rx inside a building) |

<!-- TODO: Change Factor -->
With an area coverage factor of 20  this gives the Helium Gateway owners vastly mixed signals about how and where to deploy hotspots optimaly and for what purpose.

### PoC Purpose

The Helium Network is not build for the sake of just building it, but mainly using it. PoC should reflect the coverage and usage for devices and nothing else. The attempt ([Miner PR #613]) to make EU GWs use the 9th 27 dBm channel simply does not reflect the fact that there is only one (?Source) Semtech chip supporting a Tx of up to 20 dBm. This proposal 

## Drawbacks

[drawbacks]: #drawbacks

- This does not Take into account 
- This does not in any regard change the Lone Wolf edge case.

## Rationale and Alternatives

[alternatives]: #rationale-and-alternatives§

- Not caring about regional differences: Adopting the **Keeping It Stupid, Simply** instead of the **Keep It Simple, Stupid** principle.
- Asserting a scale factor directly to Hotspot during location assert procedure.
- Capping Hotspot Tx universally at 14 dBm

## Unresolved Questions

[unresolved]: #unresolved-questions

- Balancing scaling factor for each resolution
- Scaling in regards to regional frequency differences.

## Deployment Impact

[deployment-impact]: #deployment-impact

This deployment will effect all hotspot owners. Hotspot owners in EU will likely see a significant change in earnings (either up or down) based on the new reward methodology.
It will also require significant documentation update on how proof-of-coverage is performed and rewarded.

## Success Metrics

[success-metrics]: #success-metrics


<!-- References -->

[scale-fading-n-net-deployment]: http://www.sis.pitt.edu/prashk/inf1072/Fall16/lec5.pdf
[hip-17]: https://github.com/helium/HIP/blob/master/0017-hex-density-based-transmit-reward-scaling.md
[Jan 27 firmware update]: https://engineering.helium.com/2021/01/27/hotspot-firmware-power-updates.html
[SF8125kHz]: https://www.semtech.com/products/wireless-rf/lora-transceivers/sx1276
[Miner PR #613]: https://github.com/helium/miner/pull/613
