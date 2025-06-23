# HIP 145: Utility Probing

- Authors: [@zer0tweets](https://twitter.com/zer0tweets), [@jhiller](https://twitter.com/jhiller)
- Start Date: 2025-06-23
- Category: Economic, Technical
- Original HIP PR: [#1171](https://github.com/helium/HIP/pull/1171)
- Tracking Issue: [#1174](https://github.com/helium/HIP/issues/1174)
- Voting Requirements: veHNT holders

---

## Summary

This HIP proposes a new method for calculating Proof-of-Coverage (PoC) rewards, referred to as *utility probing*. This will be rolled out initially out in the United States and eventually expanded to include Helium Mobile Hotspots worldwide.

Under this system, all eligible (greenfield) Helium Mobile Hotspots will continuously broadcast Mobile Network Operator (MNO) compliant SSIDs. Subscribers from participating MNOs will attempt to connect, but their connections will be intentionally denied by Nova. The purpose of this process is to measure how many unique subscriber devices attempt to connect, which serves as a proxy for real-world utility. This data will be used to influence PoC rewards.

Regions such as Mexico, where subscriber offload density is low, will continue earning PoC rewards under the current model and will switch later once subscriber density from Telefónica offload reaches adequate levels in select regions.

---

## Motivation

Key goals for making this change:

- Make it easier to identify which Hotspots are useful and should be included in the carrier offload program.
- Improve reward distribution by focusing on Hotspots that truly serve users.
- Move away from relying on static data, such as foot traffic estimates from oracles.

Currently, PoC rewards depend mostly on a Hotspot’s location, but ignores critical factors such as proper antenna placement (e.g., not blocked by walls) or installation height, which affects coverage quality. As a result, some poorly performing Hotspots still earn rewards, while well-placed ones may receive fewer rewards than they deserve.

In the U.S., Helium offloads mobile data from two of the top three major carriers, giving access to a large pool of around 250 million subscribers. By counting how many devices try to connect, we can obtain a strong, real-world signal of each Hotspot’s value.

This approach not only provides a more accurate utility signal than GPS-based location but also eliminates the need for CDR verification.

---

## Stakeholders

This HIP primarily affects Helium Hotspot deployers in the United States.

---

## Detailed Explanation

- Hotspots already serving MNO subscribers and those outside the U.S. (e.g., in Mexico under Telefónica) are excluded from probing for activated offload carriers. Connections for activated carriers will be counted and rewarded following the same PoC reward algorithm.
- Greenfield Helium Hotspots (excluding self-serve Converted Networks and Helium Plus Hotspots) will be remotely updated to broadcast MNO-compliant SSIDs.
- Probing will involve:
  - MNO subscriber devices will attempt to connect, but Nova will deny the connections before they are passed along to carriers.
  - The goal is to count connection attempts and gather fronthaul performance metrics.
  - This denial will not negatively impact the user experience for genuine MNO subscribers.
- The number of connection attempts during a 24-hour period (aligned with the rewards epoch) will help determine PoC rewards for that period.

Currently, PoC rewards are based mostly on how many hexes a Hotspot covers and a multiplier based on the hex’s location quality. Under this new system, rewards will instead be based on how many connection attempts the Hotspot receives during the probing period.

Current stats show a median of approximately 50 unique MNO subscriber connections per 24 hours across all active Hotspots. The bottom 20% see about 5 connections or fewer in that period. [Detailed breakdown available here](https://docs.google.com/spreadsheets/d/15CcQQVw4ps5DZHcGNeha3w0mAU-r34qn56Ik52FRcJU/edit?usp=sharing).

To ensure fairness and prevent outliers from skewing results, a cap of 200 connections per day is proposed to achieve the maximum PoC points. Hotspots that receive between 0 and 200 connection attempts will earn PoC rewards based on a [formula shown in this spreadsheet](https://docs.google.com/spreadsheets/d/1Iu-jxdQFp8yoi1QjtSuNoJ3StjOL70h8iDPpzNSpyJ4/edit?usp=sharing).

Simultaneously, CDR requirements for U.S. Hotspots will be deprecated. Data gathered from probing (user counts and fronthaul metrics) will also accelerate the onboarding of Hotspots into the MNO offload program.

---

## Drawbacks

This change introduces the potential for new forms of gaming. That is, without CDRs, it becomes possible to fake results—for example, by placing multiple AT&T phones near a group of Hotspots to simulate activity, even if those Hotspots are poorly located or spoofed using RF techniques.

---

## Implementation

The implementation will be completed by Nova in two stages:

1. **Initial Rollout:** Run probing for 30 days to collect data and resolve any bugs or edge cases related to probing behavior.
2. **Activation:** After the 30-day period, if no major changes to the approved algorithm are needed, user counts from probing will begin to affect PoC rewards.

---

## Success Metrics

The key success indicator will be a reduction in the percentage of Hotspots located in high footfall areas that serve few or no users and merely collect PoC rewards.
