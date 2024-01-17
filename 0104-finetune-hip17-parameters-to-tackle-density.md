# HIP 104: Finetune HIP-17 Parameters to Tackle Density

- Author(s): [@mawdegroot](https://github.com/mawdegroot), [@riobah](https://github.com/riobah)
- Start Date: 2023-12-20
- Category: Technical
- Original HIP PR: [#830](https://github.com/helium/HIP/pull/830)
- Tracking Issue: [#838](https://github.com/helium/HIP/issues/838)
- Networks affected: IOT
- Vote Requirements: veIOT Holders

## Summary

This proposal aims to modify the IOT LoRaWAN Networks HIP17's hex density-based transmit reward scaling, focusing on addressing the increased hotspot density in urban areas. The key objective is to enhance the share of rural areas in the reward pool, with the broader goal of improving the overall coverage of the Helium network. This adjustment is intended to respond to the evolving distribution of IOT hotspots, ensuring a more balanced and widespread network deployment.

## Motivation

The motivation for revising HIP17 stems from the evolving landscape of the Helium network, particularly the rapid growth in the number of hotspots, especially in urban areas. When [HIP17 was initially implemented](https://docs.helium.com/devblog/2020/12/09/blockchain-release-hip-17/), its parameters were designed to scale down IOT Proof of Coverage (PoC) rewards with increasing hotspot density, allowing a certain level of redundant coverage. However, as the network has expanded over the years, these parameters have not been updated to reflect the changing dynamics. Consequently, this has led to an imbalance, with city centers, now densely populated with hotspots, garnering a larger share of PoC rewards. This disproportionate reward distribution is not conducive to expanding network coverage into rural areas, as it provides little incentive for deployers to install hotspots outside urban centers.

The proposed adjustments to HIP17 seek to address this issue by recalibrating its parameters, thereby aiming to enhance the share of rural areas in the PoC reward pool and encouraging a more evenly distributed network growth.

## Stakeholders

This HIP impacts all IOT hotspot owners by revising the transmit scaling algorithm, which in turn affects the distribution of PoC rewards. It is anticipated that areas with higher hotspot density, typically city centers, will experience more significant scaling down of rewards. This change aims to shift the balance, potentially increasing PoC rewards in less dense, rural areas.

## Detailed Explanation

HIP17 employs a layered scaling approach, where each hex resolution has a target number of hotspots. This count can be increased to a specified maximum when a certain number of neighboring hexes reach the target density. These 'target' and 'max' terms are HIP17's configuration parameters, applicable across resolutions from res-4 to res-13.

Density at all hex resolution levels is checked, contributing to the final scaling factor as each level's scale is multiplied. A hotspot's scale might be reduced due to another hotspot in its res-12 hex or excessive hotspots at the city level in a res-4 hex.

This approach, using neighbor density to increase scaling limits up to the 'max' value, allows for redundancy in coverage, particularly important in urban areas up to a certain level.

### Proposal

The current [HIP17 parameters](https://github.com/helium/HIP/blob/main/0017-hex-density-based-transmit-reward-scaling.md) present two primary challenges in the context of the existing network:

1. Excessive redundancy in urban areas is allowed.
2. There is overly sharp scaling at lower-resolution hexes, such as res-4, leading to pronounced changes at res-4 boundaries. This can result in significantly different transmit scales for adjacent res-8 hexes, as depicted in the provided image.

![Image - SF - Impact of res-4 boundary](files/0104/sf-res4-boundary.jpg)

To address these issues, we propose the following adjustments:

- To reduce redundancy:
  - Limit Res8 hexes (each covering only 0.78 sq km) to a single hotspot.
  - Lower the hotspot limit, `max`, which is applied when more neighboring hexes become occupied.
  - Increase the number of occupied neighboring hexes required to reach higher limits.
- To avoid unnecessary scaling in large areas and reduce sharp discrepancies:
  - Increase the limit for res-4.

Here are the current and proposed sets of parameters:

```
          +---------------------------+----------------------------+
          |     As-is Parameters      |    Proposed Parameters     |
+---------+-----------+--------+------+-----------+--------+-------+
| Hex Res | Neighbors | Target | Max  | Neighbors | Target | Max   |
|         | Occupied  |        |      | Occupied  |        |       |
+---------+-----------+--------+------+-----------+--------+-------+
| 4       | 1         | 250    | 800  | <2        | <500   | <1000 |
| 5       | 1         | 100    | 400  | <4        | 100    | >200  |
| 6       | 1         | 25     | 100  | <4        | 25     | >50   |
| 7       | 2         | 5      | 20   | <4        | 5      | >10   |
| 8       | 2         | 1      | 4    | 2         | 1      | >1    |
| 9       | 2         | 1      | 2    | 2         | 1      | >1    |
| 10      | 2         | 1      | 1    | 2         | 1      | 1     |
| 11      | 2         | 1      | 1    | 2         | 1      | 1     |
| 12      | 2         | 1      | 1    | 2         | 1      | 1     |
| 13      | 2         | 1      | 1    | 2         | 1      | 1     |
+---------+-----------+--------+------+-----------+--------+-------+
< indicates where the proposed value has increased
> indicates where the proposed value has decreased
```

### How to Evaluate the Performance

To assess the effectiveness of the new parameter set compared to the existing ones, we've created a website that displays scales for different hex resolutions on a map. This tool allows users to observe changes in various cities and areas and understand the scaling of hexes and hotspots. The site is accessible at:

- Existing parameter set: https://heliumgeek.com/maps/hip17.html?p=default
- Proposed parameter set: https://heliumgeek.com/maps/hip17.html?p=t1

The maps demonstrate that urban areas generally experience more significant scaling down, and the previously sharp edges at res-4 boundaries are less pronounced. Example images are included at the document's end to illustrate this effect.

Furthermore, we propose assessing the distribution of rewards per hex. Addressing the density issue requires a more uniform reward distribution across different hexes. This metric facilitates a more objective comparison. We analyzed the reward units per hex for both current and proposed parameters, finding the proposed changes yield a more evenly distributed reward pattern. Histograms depicting these reward units are also provided for reference.

The vertical axis indicates the number of Hexes with the corresponding value in reward units on the Horizontal axis.

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/Histogram_of_Res4_Hex_Reward_Units_as-is.png" alt="Histogram of Res4 Hex Reward Units as-is" />
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/Histogram_of_Res4_Hex_Reward_Units_test1.png" alt="Histogram of Res4 Hex Reward Units proposed" />
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/Histogram_of_Res5_Hex_Reward_Units_as-is.png" alt="Histogram of Res5 Hex Reward Units as-is" />
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/Histogram_of_Res5_Hex_Reward_Units_test1.png" alt="Histogram of Res5 Hex Reward Units proposed" />
    </div>
</div>

_PS: To estimate the reward distribution among hexes, we assume each active hotspot beacons regularly and is witnessed by an equal number of hotspots for simplification. This assumption allows us to propose that the sum of the transmit scales for hotspots within a hex is proportional to the reward units allocated to that hex._

## Drawbacks

Adjusting HIP17 parameters will alter the reward distribution among hotspot owners. While deemed essential for the network's long-term sustainability, some owners might view these changes unfavorably, potentially leading to dissatisfaction.

## Rationale and Alternatives

The rationale for the proposed changes is detailed in earlier sections.

Alternatives include maintaining current parameters, which could exacerbate hotspot density imbalances, or introducing a new algorithm, potentially causing more disruption. We believe that refining the existing parameters is a more manageable, less disruptive solution, allowing for future modifications with greater ease.

## Unresolved Questions

While we offer a new set of parameters as a solution to the issues identified, it's possible that different parameters may better address various aspects of these problems. We view the proposed parameters as a solid starting point but remain open to suggestions and improvements. This approach allows flexibility and invites collaborative refinement.

## Deployment Impact

This proposal does not necessitate new code implementation, only an update to the parameter set in the rewards oracle. The deployment process is straightforward, as the new parameters can be directly applied to the existing oracle system. There will be a need to update existing HIP17 documentation to accurately reflect these changes. Additionally, should the need arise, reverting to the original parameters can be easily achieved through a new deployment of the oracle.

## Success Metrics

The primary indicator of success for these changes is increased network coverage. However, since this is a gradual process, we suggest using the distribution of rewards per hex across the network as a more immediate and objective metric of success. This metric allows for measurable assessments even before the implementation of the changes. For reference, sample data illustrating this measurement for a specific date is included in the sections above.

## Appendix - Examples

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/nyc-default.png" alt="NYC - existing params" />
        <p>NYC - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/nyc-t1.png" alt="NYC - proposed params" />
        <p>NYC - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/sf-default.png" alt="SF - existing params" />
        <p>SF - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/sf-t1.png" alt="SF - proposed params" />
        <p>SF - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/la-default.png" alt="LA - existing params" />
        <p>LA - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/la-t1.png" alt="LA - proposed params" />
        <p>LA - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/washington-default.png" alt="Washington - existing params" />
        <p>Washington - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/washington-t1.png" alt="Washington - proposed params" />
        <p>Washington - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/philadelphia-default.png" alt="Philadelphia - existing params" />
        <p>Philadelphia - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/philadelphia-t1.png" alt="Philadelphia - proposed params" />
        <p>Philadelphia - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/chicago-default.png" alt="Chicago - existing params" />
        <p>Chicago - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/chicago-t1.png" alt="Chicago - proposed params" />
        <p>Chicago - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/orlando-default.png" alt="Orlando - existing params" />
        <p>Orlando - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/orlando-t1.png" alt="Orlando - proposed params" />
        <p>Orlando - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/colorado-default.png" alt="Colorado - existing params" />
        <p>Colorado - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/colorado-t1.png" alt="Colorado - proposed params" />
        <p>Colorado - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/dallas-default.png" alt="Dallas - existing params" />
        <p>Dallas - existing params</p>
    </div>
    <div style="width: 10px;"></div> 
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/dallas-t1.png" alt="Dallas - proposed params" />
        <p>Dallas - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/san-antonio-default.png" alt="San Antonio - existing params" />
        <p>San Antonio - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/san-antonio-t1.png" alt="San Antonio - proposed params" />
        <p>San Antonio - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row;">
    <div style="flex: 1; text-align: center; margin: 0 auto;">
        <img src="files/0104/./portland-default.png" alt="Portland - existing params" />
        <p>Portland - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center; margin: 0 auto;">
        <img src="files/0104/./portland-t1.png" alt="Portland - proposed params" />
        <p>Portland - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./seattle-default.png" alt="Seattle - existing params" />
        <p>Seattle - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./seattle-t1.png" alt="Seattle - proposed params" />
        <p>Seattle - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./toronto-default.png" alt="Toronto - existing params" />
        <p>Toronto - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./toronto-t1.png" alt="Toronto - proposed params" />
        <p>Toronto - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./london-default.png" alt="London - existing params" />
        <p>London - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./london-t1.png" alt="London - proposed params" />
        <p>London - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./paris-default.png" alt="Paris - existing params" />
        <p>Paris - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./paris-t1.png" alt="Paris - proposed params" />
        <p>Paris - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./vienna-default.png" alt="Vienna - existing params" />
        <p>Vienna - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./vienna-t1.png" alt="Vienna - proposed params" />
        <p>Vienna - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./budapest-default.png" alt="Budapest - existing params" />
        <p>Budapest - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./budapest-t1.png" alt="Budapest - proposed params" />
        <p>Budapest - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./berlin-default.png" alt="Berlin - existing params" />
        <p>Berlin - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./berlin-t1.png" alt="Berlin - proposed params" />
        <p>Berlin - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./rotterdam-default.png" alt="Rotterdam - existing params" />
        <p>Rotterdam - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./rotterdam-t1.png" alt="Rotterdam - proposed params" />
        <p>Rotterdam - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/barcelona-default.png" alt="Barcelona - existing params" />
        <p>Barcelona - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/barcelona-t1.png" alt="Barcelona - proposed params" />
        <p>Barcelona - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./rome-default.png" alt="Rome - existing params" />
        <p>Rome - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./rome-t1.png" alt="Rome - proposed params" />
        <p>Rome - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./madrid-default.png" alt="Madrid - existing params" />
        <p>Madrid - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./madrid-t1.png" alt="Madrid - proposed params" />
        <p>Madrid - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./lisbon-default.png" alt="Lisbon - existing params" />
        <p>Lisbon - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./lisbon-t1.png" alt="Lisbon - proposed params" />
        <p>Lisbon - proposed params</p>
    </div>
</div>

<div style="display: flex; flex-direction: row; margin: 0 auto;">
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./istanbul-default.png" alt="Istanbul - existing params" />
        <p>Istanbul - existing params</p>
    </div>
    <div style="width: 10px;"></div>
    <div style="flex: 1; text-align: center;">
        <img src="files/0104/./istanbul-t1.png" alt="Istanbul - proposed params" />
        <p>Istanbul - proposed params</p>
    </div>
</div>
