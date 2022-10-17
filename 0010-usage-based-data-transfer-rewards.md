# HIP10: Usage-based Data Transfer Rewards

- Start Date: 2020/08/18
- HIP PR: [#31](https://github.com/helium/HIP/pull/31)
- Tracking Issue: [#32](https://github.com/helium/HIP/issues/32)
- Author: [@abhay](https://github.com/abhay)

# Summary

Token distribution, as it currently is deployed, favors gamification of rewards generation through mining Data Credits (DC). Since DC costs are fixed and the rewards are proportional, an arbitrageur is incentivized to create artificial traffic through their own Hotspots.

This HIP proposes a scheme that adjusts rewards to Hotspot hosts proportional at a 1:1 ratio to the HNT value of the DC they transfer.

# Stakeholders

I plan to circulate this proposal in [Discord #hips](https://discord.gg/helium) and on the [Helium community Reddit](https://reddit.com/r/heliumnetwork). I will also solicit specific individuals for feedback, from both within the Helium community and other crypto and open-source projects.

Specifically I would like to achieve rough consensus around this process with Hotspot owners, Helium Inc (as the primary developer of nearly all core Helium software), and the newly-formed [DeWi Alliance](https://dewi.org), which plans to commit time & money to community governance in the Helium ecosystem.

On-the-record comments should be made on this HIP's [associated GitHub issue](https://github.com/helium/HIP/issues/32).

# Detailed Explanation

## Overview

On the Helium network new HNT is created at a rate of approximately 5 million HNT per month. This is a fixed number always emitted by the network every month, and it is distributed to stakeholders in the Helium network as follows:

|                 | %      | HNT       |
|-----------------|--------|-----------|
| PoC Challengers |   0.95 |    47,500 |
| PoC Witnesses   |   8.55 |   427,500 |
| Poc Challengees |  18.00 |   900,000 |
| Consensus Group |   6.00 |   300,000 |
| Data Credits    |  32.50 | 1,625,000 |
| HST Holders     |  34.00 | 1,700,000 |
| Total           | 100.00 | 5,000,000 |

The problem with this scheme, as the Helium Community has very clearly articulated over the last several days, is that if there is insufficient natural Data Credit demand the 32.5% of tokens is actually acting as a disincentive to continue to grow the network. There is an enormous arbitrage opportunity, as sensor owners can buy Data Credits cheaply and reap an enormously inversely proportional reward. The most extreme example on the network today is a specific Hotspot which has earned approximately $21,000 worth of HNT by purchasing $145 worth of DC.

It would instead be in the networks best interest to grow the coverage footprint as large as possible to encourage natural utility of the network by users with sensor data, and reward Hotspots who transfer data in a more organic way.

## A new scheme

Instead of issuing 32.5% HNT to the DC group regardless of how much data is transferred, I propose that we instead issue *up to* 32.5% of the HNT to that group. The HNT should be rewarded at a 1:1 rate with the value of DC delivered through that Hotspot, until the amount of DC being transferred over the network exceeds the 32.5% of HNT (1,625,000) at which point it should be distributed proportionally. The remainder of the unspent rewards shold be distributed pro-rata to the PoC Challengers, Witnesses, and Challengees to further encourage network growth

To illustrate, here are a a couple of scenarios:

- 10,000,000 DC are transferred across the network through various Hotspots. The HNT oracle price is $2. In this scenario the total HNT value of DC being transferred is 50 HNT (10,000,000 DC * $0.0001 DC fixed priced divided by the $2 oracle price). 50 HNT would be split proportionally to the Hotspots who did the work, and the remaining 1,624,950 HNT from the DC allocation would be distributed ratably among the Challengers, Witnesses and Challengees.

In this scenario the monthly allocation would look like this:

|                 | %        | HNT       |
|-----------------|----------|-----------|
| PoC Challengers |   2.0727 |   103,635 |
| PoC Witnesses   |  18.6542 |   932,710 |
| Poc Challengees |  39.2721 |   193,605 |
| Consensus Group |   6.0000 |   300,000 |
| Data Credits    |   0.0010 |        50 |
| HST Holders     |  34.0000 | 1,700,000 |
| Total           | 100.0000 | 5,000,000 |

- The HNT oracle price is still $2. 400,000,000,000 DC is transferred across the network. Because this amount of DC exceeds the value of the 1,625,000 HNT allocated to DC it is not possible to distribute rewards on a 1:1 basis, so the Hotspots who did the work receive a proportional share of the 1,625,000 HNT. Because the amount of DC spent exceeds the 32.5% allocation, the rewards table looks like as it does today:

|                 | %      | HNT       |
|-----------------|--------|-----------|
| PoC Challengers |   0.95 |    47,500 |
| PoC Witnesses   |   8.55 |   427,500 |
| Poc Challengees |  18.00 |   900,000 |
| Consensus Group |   6.00 |   300,000 |
| Data Credits    |  32.50 | 1,625,000 |
| HST Holders     |  34.00 | 1,700,000 |
| Total           | 100.00 | 5,000,000 |

## The outcome of the new scheme

This new scheme accomplishes the following goals:

- continues to reward Hotspots for delivering data packets and providing functionality
- makes arbitrage, at best, a zero-sum activity, as the best possible outcome is to spend 1 HNT to earn 1 HNT
- may slightly disincentivize arbitrage due to transaction fees
- scales DC rewards based on actual activity on the network, as arbitrage is now unprofitable
- increases rewards to Proof of Coverage participants, continuing to incentivize network build out
- does not adjust the PoC challenger rewards

## Level of engineering effort

I am told by the core engineering team that the level of effort required to implement this scheme is extremely low, on the order of hours.

## Downsides

- HNT net inflation is increased until sufficient utility exists to control it
- the reward scheme deviates from the original outlined at <https://helium.com/tokens>
