# HIP 74: MOBILE PoC - Modeled Coverage Rewards

- Author(s): [@thehardbits](https://github.com/thehardbits),
  [@zer0tweets](https://github.com/zer0tweets),
  [@jpad-freedomfi](https://github.com/jpad-freedomfi), [@meowshka](https://github.com/meowshka)
- Start Date: 2022-11-29
- Category: Technical & Economic
- Original HIP PR: [#501](https://github.com/helium/HIP/pull/501)
- Tracking Issue: [#504](https://github.com/helium/HIP/issues/504)

# Summary

HIP-74 lays the groundwork to start rewarding Helium Mobile Hotspot operators based on actual
coverage provided vs. mere existence. Specifically:

- It proposes a framework to count coverage using res 12 hexes;
- It proposes a framework for incorporating external data sources (aka Oracles) to calculate and/or
  coverage;
- It proposes Obstruction Data Oracle as the first such external data source.

We expect this to be the first in a series of HIPs that will incorporate other data sources, such as
zoning and population density, feedback from carrier members of the MOBILE DAO, network users and
mappers, etc. Our aim is to make future HIPs smaller and more easily consumable.

This HIP affects only the Helium 5G network and has no impact on IoT rewards.

Once implemented, Modeled Coverage will be a significant milestone in introducing the
Proof-of-Coverage concept in the Mobile Network. The blog post
[MOBILE Proof-of-Coverage: The Road Ahead](https://blog.helium.com/mobile-proof-of-coverage-the-road-ahead-73a25601a13d)
provides a detailed MOBILE PoC Roadmap. Combined with other parameters like uptime and backhaul,
Obstruction Data allows for more fair rewards and incentivizes high-quality deployments of Radios.

# Motivation

Building the MOBILE Network began with the Genesis Phase, during which 5G Hotspot Owners with Radios
were rewarded for keeping the radios online vs. providing useful coverage. This was a necessary
starting point to kickstart the deployments. However, to be successful, any MOBILE Network must be
reliable, always available, and meet the expectations of its users. Using Modeled Coverage is an
important step to measure the quality of coverage beyond self-reported data. In the future, it will
be complemented and cross-checked by the data provided by Mobile Mappers.

Additionally, Modeled Coverage lays a foundation to introduce more data sources like zoning and
population density to measure the usefulness of coverage and motivate deployments in places where it
matters the most. With Modeled Coverage, location-based incentive points in the Mobile Rewards
calculations will also be possible.

# Stakeholders

HIP-74 affects only the MOBILE SubDAO, particularly 5G Hotspot Owners with Radios and users of the
MOBILE Network. HIP-74 does not impact the IOT Hotspots or IOT Rewards.

5G Hotspot Owners with Outdoor Radios must meet new Quality Coverage requirements to maximize
potential MOBILE Rewards earnings. Some Owners may need to modify their Outdoor Radio locations,
orientations, or both to optimize for Quality Coverage. Additionally, environmental obstacles that
are impossible to mitigate may reduce the maximum Rewards a Radio can earn. HIP-74 also proposes
rewarding deployers among the first to provide quality coverage in a given hex.

There will be three possible outcomes for owners of Radios:

1. Increase in earnings. Because some Radios on the MOBILE Network won't be able to meet minimum
   quality requirements, part of the MOBILE Rewards will be re-distributed proportionally to those
   who qualify based on all PoC criteria.
2. Earnings will stay the same.
3. Less or no earnings.

5G Hotspot Owners can evaluate their performance with the Modeled Coverage map. Depending on the
location and time of deployment in the particular hex, there might be an opportunity to improve
coverage and earn more. Changing the location and orientation of a Radio requires resubmission of
the CPI Registration. In addition to compliance, Modeled Coverage data calculations use this updated
registration.

# Detailed Explanation

HIP-74 replaces the current algorithm for MOBILE Rewards that was based on Radio Type multipliers
with a new algorithm that uses the location of the Radio to calculate Rewards based on the hexes the
Radio covers, as modeled by the Obstruction Data Oracle. Below is a detailed explanation of the
proposed rewards algorithm and new requirements for scaling MOBILE Rewards based on the Modeled
Coverage data.

# Reward Mechanics

## Hex Size

With HIP-74, we propose to use res12 as defined by
[H3](https://h3geo.org/docs/core-library/restable/) for Hex sizes. The H3 geo coordinates system has
proven to perform well and provide all the necessary features in the IOT Network. You can read how
the IOT Network uses H3 data in
[The Helium Blog](https://blog.helium.com/mapping-the-world-with-hexagons-49f57d8b3df5).

Analysis of the coverage by a single Outdoor Radio with Modeled Coverage data showed that the res8
hex currently used in the IOT Network is too large to represent a Radio's coverage. Res12 hexes
better align with what an Outdoor Radio can reasonably cover, with an average area of 0.0003071 km²
and an edge length of 9.4 m, slightly bigger than an average single-family home.

HIP-74 introduces a fundamental difference in using hexes for the Mobile Network compared to the IOT
Network. In the IOT Network, hexes determine the locations and number of Hotspots within the given
hex. In the Mobile NETWORK, hexes determine where the coverage exists. Modeled Coverage data allows
us to un-tie a Radio's location from its signal strength and propagation.

To summarize:

- Hexes in the MOBILE Network identify the level of coverage from all the different Radios providing
  coverage to each hex.
- A Radio can provide coverage for a hex it is not located within.
- A Radio can earn rewards by providing coverage in multiple hexes.

To help visualize the significant difference between these two resolutions, below is a map with
green hex res8 and a small dot inside it - purple hex with res12.

![Figure 1. Hex res12 and hex res8 map overlay.](./0074-mobile-poc-modeled-coverage-rewards/hex-12-and-hex-8-comparison.png)

**Figure 1.** Hex res12 and res8 map overlay

## Reward Tiers

In addition to uptime and backhaul requirements, the MOBILE Rewards Oracle will calculate a coverage
model for each Radio. This Radio coverage model will consider the physical location, antenna
direction, radio max transmit power, and Obstruction Data Oracle inputs to calculate the number of
res12 hexes receiving coverage from each Radio.

Depending on the number of res12 hexes and the resulting signal power in each, the MOBILE Rewards
Oracle will allot coverage points to a given Radio for calculating its MOBILE Rewards instead of
assuming a fixed Radio Type multiplier Reward.

## Outdoor Radios

HIP-74 proposes to replace Radio Type multipliers with coverage points represented by four tiers of
potential signal power as modeled by the Obstruction Data Oracle - High, Medium, Low, and None.

Table of reference signal received power and corresponding reward multipliers for Outdoor Radios:

|                               | Tier 1        | Tier 2                     | Tier 3                      | Tier 4           |
| ----------------------------- | ------------- | -------------------------- | --------------------------- | ---------------- |
| **Potential Signal Power**    | $P > -95 dBm$ | $-95 dBm \ge P > -105 dBm$ | $-105 dBm \ge P > -115 dBm$ | $P \le -115 dBm$ |
| **Potential Signal Level**    | High          | Medium                     | Low                         | None             |
| **Estimated coverage points** | 16            | 8                          | 4                           | 0                |

**Table 1.** Signal power tiers, corresponding signal strength, and estimated coverage points for
Outdoor Radios.

## Indoor Radios

Like Outdoor, Indoor Radios can collect MOBILE Rewards by providing coverage in multiple hexes.

The Obstruction Data Oracle cannot evaluate coverage by Indoor Radios are no sufficient and reliable
data sources about obstacles in indoor spaces. Instead, we propose to use an approximation based on
the data gathered while testing certified Indoor Radios in various indoor settings.

Based on the test data, we assume the hex in which an Indoor Radio is physically located receives
maximum signal strength coverage, and all adjacent hexes receive lower signal strength. Therefore,
our algorithm errs on generosity to ensure equitable potential MOBILE Rewards for Indoor Radio
coverage.

The reward tiers will be as follows:

|                               | Tier 1     | Tier 2             |
| ----------------------------- | ---------- | ------------------ |
| **Location**                  | Inside hex | All adjacent hexes |
| **Potential Signal Level**    | High       | Low                |
| **Estimated coverage points** | 400        | 100                |

**Table 2.** Signal power tiers, corresponding signal strength, and estimated coverage points for
Indoor Radios.

Estimated per-hex coverage points for Indoor Radios are intentionally significantly higher than the
per-hex coverage points awarded to Outdoor Radios to balance the importance of Indoor Radios in the
MOBILE Network with their relatively smaller coverage footprints.

These values we chosen by taking all the Outdoor Radios in an example area and analyzing the
distribution of estimated coverage points per Radio resulting from the algorithm described in
HIP-74. We then chose estimated coverage point values that result in Indoor Radios getting roughly
¼th the estimated coverage points as the 95th percentile Outdoor Radios and about ½ the points of
the average Outdoor Radio.

These results align with the current Radio Type Multiplieres approach `1:2.5:4` for Indoor Radios,
Outdoor Radios, and High-Power Outdoor Radios. Figure 2 below is the cumulative distribution
function plot of the sample market Outdoor Radio estimated coverage points.

![Figure 2. The cumulative distribution function of Outdoor Radio estimated coverage points for 904 Radios in the L.A. market area.](./0074-mobile-poc-modeled-coverage-rewards/propagation_point_cdf.png)

**Figure 2.** Cumulative distribution function of Outdoor Radio estimated coverage points for 904
Radios in the L.A. market area.

## Reward Algorithm

The proposed new algorithm for MOBILE Reward calculation in the MOBILE Rewards Oracle is as follows:

1. Supply the declared transmitter power of each Radio and its location to the Obstruction Data
   Oracle.
2. Get all hexes that have coverage from Outdoor Radios based on the information from the
   Obstruction Data Oracle.
3. Based on the location of Indoor Radios, get all hexes with Indoor coverage and all adjacent
   hexes.
4. Use projected signal loss information from the Obstruction Data Oracle to determine the potential
   signal strength of each Outdoor Radio in each hex.
5. For each hex, get at most 5 Outdoor Radios with the top signal strength of the same level. If
   there are more than 5 Radios with the same signal strength level, use the `coverage_claim_time`
   value to determine the top 5 oldest installations where `coverage_claim_time` is the timestamp
   when the Radio received the spectrum access grant for the first time. To prevent rewarding "dead"
   Radios, we propose to reset `coverage_claim_time` if the Radio was not generating a Heartbeat for
   more than 72 hours and use the time of the last Heartbeat as the new `coverage_claim_time`.
6. Get max 5 Indoor Radios using the same approach as above for Outdoor Radios.
7. Based on Table 1 and Table 2, sum up all estimated coverage points earned by each Radio in all
   hexes and multiply that by `speedtest_multiplier` for each Radio.
8. Divide the total number of MOBILE Rewards emitted during the Rewards Period by the sum of
   multiples of `estimated_reward_point` and `speedtest_multiplier` for each Radio to determine
   MOBILE Rewards per `estimated_reward_point` for Radio with a passing Speed Test.
9. Multiply the MOBILE per `estimated_reward_point` by the sum of each Radio's reward points to
   determine the MOBILE Rewards for each Radio.

The new formula for Reward calculation per Radio:

$$
W = k_H \times k_S \times C_E \times W_p
$$

| Variable | Description                      |
| -------- | -------------------------------- |
| $W$      | Total rewards                    |
| $k_H$    | Heartbeat multiplier             |
| $k_S$    | Speedtest multiplier             |
| $C_E$    | Estimated coverage points        |
| $W_p$    | Epoch rewards per coverage point |

## Calculation Example

For simplicity, assume that the total MOBILE Rewards per period is 10,000.

| Radio       | Heartbeat | Heartbeat multiplier $k_H$ | Speed Test | Speedtest Multiplier $k_S$ | Hex 1 - Hex 10 | Hex 11 - Hex 20 | Hex 21 - Hex 220 | Total Coverage Points | Total Reward Points |
| ----------- | --------- | -------------------------- | ---------- | -------------------------- | -------------- | --------------- | ---------------- | --------------------- | ------------------- |
| 1 (Outdoor) | Ok        | 1                          | Acceptable | 1                          | 160            | 80              | 800              | 1,040                 | 1,040               |
| 2 (Outdoor) | Ok        | 1                          | Poor       | 0.25                       | 80             | 40              |                  | 120                   | 30                  |
|             |           |                            |            |                            |                |                 |                  | Points                | 1,070               |

**Table 3.** Simplified data for two Outdoor Radios with Heartbeat, Speed Test, and Estimated
Coverage Points for one Reward Period.

| Radio      | Heartbeat | Heartbeat multiplier $k_H$ | Speed Test | Speedtest Multiplier $k_S$ | Hex 1 | Hex 2 | Hex 3 | Hex 4 | Total Coverage Points | Total Reward Points |
| ---------- | --------- | -------------------------- | ---------- | -------------------------- | ----- | ----- | ----- | ----- | --------------------- | ------------------- |
| 3 (Indoor) | Ok        | 1                          | Degraded   | 0.5                        | 100   | 100   | 100   | 400   | 700                   | 350                 |
|            |           |                            |            |                            |       |       |       |       | Points                | 350                 |

**Table 4.** Simplified data for one Indoor Radio with Heartbeat, Speed Test, and Estimated Coverage
Points for one Reward Period.

$$
R  \times (1 \times 1 \times 1040 + 1 \times 0.25 \times 120 + 1 \times 0.5 \times 700) = 10,000
$$

Where R is the reward per one estimated coverage point.

$$
R = 6.54
$$

|                   | Total MOBILE Rewards        |
| ----------------- | --------------------------- |
| Radio 1 (Outdoor) | = 6.54x1x1x1040 = 6,806.3   |
| Radio 2 (Outdoor) | = 6.54x1x0.25x120 = 903.14  |
| Radio 3 (Indoor)  | = 6.54x1x0.5x700 = 2,290.58 |

# Data Visualization

All members of the MOBILE SubDAO need to see real-life coverage provided by 5G Radios. Modeled
Coverage data will play a key role in providing information to visualize it, with more data added as
additional external sources (e.g., Mobile Mappers) come into play.

HIP-74 proposes the creation of a new Mobile Explorer dedicated exclusively to the MOBILE Network as
adding more features and data for MOBILE Rewards to the IOT Network Explorer becomes practically
impossible as the MOBILE Network grows. The first iteration of the MOBILE Explorer proposes a basic
map overlay of 5G data coverage with signal strength.

Below is the visualization of signal propagation for the Outdoor Radio, directed along the street
and installed on a pole on the two-story building roof.

![Figure 3. A Baicells Outdoor Radio 430 installed on a two-story roof.](./0074-mobile-poc-modeled-coverage-rewards/baicells-outdoor-430.jpeg)
**Figure 3.** A Baicells Outdoor Radio 430 installed on a two-story roof.

![Figure 4. Modeled coverage of the Radio pictured in Figure 3.](./0074-mobile-poc-modeled-coverage-rewards/baicells-outdoor-430-modeled.png)
**Figure 4.** Modeled coverage of the Radio shown in Figure 3.

# Implementation Timeline

To make sure the transition to the new PoC system, which replaces static, power-based multipliers,
is smooth, Hotspot owners can evaluate the coverage they provide before the switch takes effect. We
propose to show Mapped Coverage information in the Mobile Explorer for at least four weeks before
switching to the new PoC model.

# Drawbacks

Setting a maximum of 5 Indoor Radios might not work for multi-story or high-rise buildings. In
contrast to Outdoor Radios, no data is accessible about the elevation of Indoor Radios, and no other
data sources are available immediately to model such information.

By adding more external sources like zoning and population density to PoC in the future, we will be
able to evaluate the usefulness of coverage provided by Indoor Radios more precisely. In the
meantime, 5 Indoor Radios in a given hex are sufficient to cover up to a ten-story building, making
Multi-Dwelling Unit deployments feasible under the current limits while we work on further
improvements.

# Rationale and Alternatives

MOBILE PoC requires many external sources of information to evaluate uniqueness, usefulness, and
quality of coverage. Any improvable product requires a solid foundation from which changes can be
quickly implemented and have immediate impacts.

While initially intended as the primary source of MOBILE PoC coverage verification, Mobile Mappers
will require more time and resources to have enough devices to effectively map all areas with
coverage.

To avoid stalling the progress of PoC development, we've decided to evaluate Obstruction Data
sources to model the MOBILE PoC coverage.

While analyzing the results, Obstruction Data was determined to complement information scanned by
Mobile Mappers to cross-check and confidently verify signal levels while immediately helping
evaluate the quality of MOBILE coverage and Radio deployments.

# Deployment Impact

HIP-74 affects only MOBILE SubDAO, particularly 5G Hotspot owners with Radios and users of the
MOBILE Network. It does not impact the IoT Network or IoT Rewards.

HIP 74 is the start of programmatic emissions. This will update a new chain variable that mints
rather than draws from the premine.

## Impact on Rewards

There will be three possible outcomes for owners of Radios:

1. Increase in earnings. Because some Radios on the MOBILE Network won't be able to meet minimum
   quality requirements, part of the rewards will be re-distributed proportionally to those who
   qualify based on all PoC criteria.
2. Earnings will stay the same.
3. Less or no earnings.

HIP-74 proposes to limit the five oldest Radio deployments with the highest signal strength in a
given hex for reward eligibility. The MOBILE Rewards Oracle will calculate the deployment duration
based on the time of the latest SAS grant received. Please see the Rewards Algorithm section for
more details.

Determining the signal strength of the Indoor Radios will use an approximation based on the data
gathered during the testing of certified Indoor Radios due to the lack of reliable data sources
regarding obstacles in the indoor spaces. Please see the Reward Tiers section for more information.

The Reward Tiers section of HIP-74 contains detailed information about proposed reward points.

# Mobile Explorer

HIP-74 proposes the launch of a new Mobile Explorer to display Modeled Coverage and other data of
the MOBILE Network. Before the launch of Modeled Coverage data in the Rewards calculation, Radio
owners can view the signal strength and hex coverage by their Radios in the new Mobile Explorer. We
propose to give at least four weeks from the launch of the new Mobile Explorer for any necessary
adjustments to the Radio locations before we consider Modeled Coverage data in the Rewards
calculations.

Eligibility for MOBILE Rewards related to HIP-74 will require no actions aside from potential Radio
location adjustments.

Barebones Modeled Coverage Map has already been launched to give a first glance at how each Radio
performs based on the Modeled Coverage data: https://coverage-explorer.herokuapp.com/. The first
version shows how many hexes the Radio covers, at which signal levels, and what are other competing
Radios in that hex. With the passing of this HIP, more features will be added to evolve this map
into a full-scale Mobile Network Explorer.

# Proof-of-Coverage Roadmap

HIP-74 is one of the critical milestones in the MOBILE PoC Roadmap. It lays the foundation for
adding other external data sources to evaluate the usefulness of coverage HIPs that propose to use
zoning, population density, and allow location-based optimization is coming as the next steps. You
can check out the MOBILE PoC Roadmap
[here](https://blog.helium.com/mobile-proof-of-coverage-the-road-ahead-73a25601a13d/)

# Unresolved Questions

Finding reliable sources of information about indoor obstruction data is challenging. Until we
incorporate data like population density and zoning to better understand the unique specifics of
Indoor Radios locations, we will approximate res 12 hexes covered by Indoor Radios using a hardcoded
algorithm and assign higher value to indoor hexes as described above. Still, we will have a limit of
five rewardable Indoor Radios per hex. In addition, Indoor Radios will need to continue meeting
Heartbeat and Speed Test requirements but will receive increased rewards.

# Success Metrics

The primary success metric will be improvements to MOBILE coverage. We expect to see more
distributed coverage and less clusterization of Outdoor Radios as their owners improve placements to
optimize for maximum MOBILE rewards.

Improvements to coverage will be measured by the number of effectively covered hexes and the change
in that number over time.

At a glance, changes to coverage can be easily visualized by comparing snapshots of the Modeled
Coverage map for different periods. Mobile Explorer might include the functionality to retrieve
snapshots at a given time.
