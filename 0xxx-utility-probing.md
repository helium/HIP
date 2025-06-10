# HIP XX: Utility Probing

**Author(s):** [@zer0tweets](https://twitter.com/zer0tweets), [@jhiller](https://twitter.com/jhiller)  
**Start Date:** 2025-05-20  
**Category:** Economic, Technical  
**Original HIP PR:** [Link to PR]  
**Tracking Issue:** [Link to Issue]  
**Voting Requirements:** veHNT holders  

---

## Summary

This HIP proposes a new method for calculating Proof-of-Coverage (PoC) rewards, referred to as *utility probing*. It is proposed that this be initially rolled out in the United States and eventually expanded to include hotspots worldwide.

Under this system, all eligible (greenfield) Helium Hotspots will continuously broadcast MNO-compliant SSIDs. Subscribers from participating MNOs will attempt to connect, but their connections will be intentionally denied by Nova. The purpose of this process is to measure how many unique subscriber devices attempt to connect, which serves as a proxy for real-world utility. This data will be used to influence PoC rewards.

Regions such as Mexico, where subscriber offload density is low, will continue earning PoC rewards under the current model and will switch later, once subscriber density from Telefónica offload reaches adequate levels in select regions.

---

## Motivation

Key goals for making this change:

- Make it easier to identify which hotspots are actually useful and should be permanently included in the carrier offload program  
- Improve how rewards are given by focusing on hotspots that are truly serving users  
- Move away from relying on static data, such as foot traffic estimates from oracles  

Currently, Proof-of-Coverage (PoC) rewards depend mostly on a hotspot’s location—but this ignores critical factors like proper antenna placement (e.g., not blocked by walls) or installation height, which affects coverage quality. As a result, some poorly performing hotspots still earn rewards, while well-placed ones may receive less than they deserve.

In the U.S., Helium offloads mobile data from two of the top three major carriers, giving access to a large pool of around 250 million subscribers. By counting how many devices try to connect, we can obtain a strong, real-world signal of each hotspot’s value.

This approach not only provides a more accurate utility signal than GPS-based location but also eliminates the need for CDR verification.

---

## Stakeholders

This HIP primarily affects Helium hotspot deployers in the United States.

---

## Detailed Explanation

- Hotspots already serving MNO subscribers and those outside the U.S. (e.g., in Mexico under Telefónica) are excluded.  
- Greenfield Helium hotspots (excluding brownfield and Helium Plus Hotspots) will be remotely updated to broadcast MNO-compliant SSIDs.  
- Probing will involve:
  - MNO subscribers attempting to connect, but their connections will be denied by Nova.
  - The goal is to count connection attempts and gather fronthaul performance metrics.  
  - This will not negatively impact user experience for real MNO subscribers due to connection denials.  
- The number of connection attempts during a 24-hour period (aligned with the rewards epoch) will help determine PoC rewards for that period.  

Currently, PoC rewards are based mostly on how many hexes a hotspot covers and a multiplier based on the hex’s location quality. Under this new system, rewards will instead be based on how many connection attempts the hotspot receives during the probing period.

Current stats show a median of ~50 unique MNO subscriber connections per 24 hours across all active hotspots. The bottom 20% see ~5 connections or fewer in that period. [Detailed breakdown available here](https://docs.google.com/spreadsheets/d/15CcQQVw4ps5DZHcGNeha3w0mAU-r34qn56Ik52FRcJU/edit?usp=sharing).

To ensure fairness and prevent outliers from skewing results, a cap of 200 connections per day is proposed to achieve the maximum PoC points. Hotspots that receive between 0 and 200 connection attempts will earn PoC rewards based on a [formula shown in this spreadsheet](https://docs.google.com/spreadsheets/d/1Iu-jxdQFp8yoi1QjtSuNoJ3StjOL70h8iDPpzNSpyJ4/edit?usp=sharing).

Simultaneously, CDR requirements for U.S. hotspots will be deprecated. Data gathered from probing (user counts and fronthaul metrics) will also accelerate the onboarding of hotspots into the MNO offload program.

---

## Drawbacks

This change introduces the potential for new forms of gaming. That is, without CDRs, it becomes possible to fake results—for example, by placing multiple AT&T phones near a group of hotspots to simulate activity, even if those hotspots are poorly located or spoofed using RF techniques.

---

## Implementation

The implementation will be completed by Nova in two stages:

1. **Initial Rollout:** Run probing for 30 days to collect data and resolve any bugs or edge cases related to probing behavior.  
2. **Activation:** After the 30-day period, if no major changes to the approved algorithm are needed, user counts from probing will begin to affect PoC rewards.

---

## Success Metrics

The key success indicator will be a reduction in the percentage of hotspots located in high-footfall areas that serve few or no users and merely collect PoC rewards.
