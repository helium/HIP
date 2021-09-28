# HIP 20: HNT Max Supply

- Author: @jmfayal (jmf), @tjain-mcc (tushar), @rawrmaan
- Start Date: November 4, 2020
- Category: Economic
- Tracking Issue: [#73](https://github.com/helium/HIP/issues/73)
- Status: Deployed ([audit](https://github.com/helium/miner/blob/master/audit/var-79.md))

# Summary

This proposal suggests the introduction of halvings in net HNT issuance every 2 years (based on block height) to establish a max supply of HNT.

# Motivation

The most common question when new members join the Helium community is, “what is the max supply of HNT?” This is because many crypto protocols took inspiration from Bitcoin’s 21M fixed supply cap; however, the Helium protocol was originally designed with a [Burn-and-Mint Equilibrium](https://multicoin.capital/2018/02/13/new-models-utility-tokens/) (BME) model, which does not feature a hard supply cap for HNT. The community has consistently suggested that this issue be revisited and re-evaluated in order to make Helium more understandable to a wider group of participants. This proposal builds on those conversations and seeks to advance it by formally proposing a HIP.

To ensure the network continues to function properly, the Helium protocol incentivizes Hotspot operators with HNT mining rewards. If there is no HNT left to be mined, Hotspot owners have no incentive to operate their Hotspots. Currently, the Helium protocol mints 5 million HNT in perpetuity in order to adequately incentivize Hotspot owners for providing wireless coverage and transmitting IOT data.

This proposal lays out a new crypto-economic innovation that addresses the fixed cap issue while also ensuring that Hotspot operators are still adequately incentivized in perpetuity to mine HNT (and support the network).This innovation is called “Net Emissions.” Net Emissions is a breakthrough economic construction. It has been discussed in abstract by other crypto communities and is inspired by the work of researchers in the Bitcoin community. If adopted, Helium would be the first protocol to implement this crypto-economic innovation.

With the introduction of a hard cap on HNT supply, Helium’s token-economics would become more understandable to the broader crypto community at large. It would also create future scarcity and a new incentive to hold HNT. If there is more demand for HNT, miners will have additional incentive to deploy Hotspots. If miners deploy more Hotspots, the network will continue to grow its coverage, which will ultimately help meet the demands of end users and customers who use the network.

# Stakeholders

All HNT holders, Hotspot owners, and HST holders will be affected by this HIP. 

There will be no change to the cost to transfer data because the cost of Data Credits is fixed in USD terms.

# Detailed Explanation

The proposal is to have halvenings of net HNT issuance every 2 years on the anniversary of genesis. This means the first halvening will be on August 1st, 2021 and net HNT issuance will be reduced to 2.5M HNT per month.

The HNT mining split amongst stakeholders will not change from the [current schedule](https://www.helium.com/hnt#distribution):

| Year| HNT at start of year | Total HNT Minted | % to Proof of Coverage (+ any extra from Data Transfer) | % to Data Transfer (excess to Proof of Coverage) | % to Founders Reward | % to Consensus |
|-|-|-|-|-|-|-|
| 1 | 0 | 60,000,000.0 | 29.00% | 30.00% | 35.00% | 6.00% |
| 2 | 60,000,000 | 60,000,000.0 | 27.50% | 32.50% | 34.00% | 6.00% |
| 3 | 120,000,000 | 30,000,000.0 | 26.00% | 35.00% | 33.00% | 6.00% |
| 4 | 150,000,000 | 30,000,000.0 | 24.50% | 37.50% | 32.00% | 6.00% |
| 5 | 180,000,000 | 15,000,000.0 | 23.00% | 40.00% | 31.00% | 6.00% |
| 6 | 195,000,000 | 15,000,000.0 | 21.50% | 42.50% | 30.00% | 6.00% |
| 7 | 210,000,000 | 7,500,000.0 | 20.00% | 45.00% | 29.00% | 6.00% |
| 8 | 217,500,000 | 7,500,000.0 | 18.50% | 47.50% | 28.00% | 6.00% |
| 9 | 225,000,000 | 3,750,000.0 | 17.00% | 50.00% | 27.00% | 6.00% |
| 10 | 228,750,000 | 3,750,000.0 | 15.50% | 52.50% | 26.00% | 6.00% |
| 11 | 232,500,000 | 1,875,000.0 | 14.00% | 55.00% | 25.00% | 6.00% |
| 12 | 234,375,000 | 1,875,000.0 | 12.50% | 57.50% | 24.00% | 6.00% |
| 13 | 236,250,000 | 937,500.0 | 11.00% | 60.00% | 23.00% | 6.00% |
| 14 | 237,187,500 | 937,500.0 | 9.50% | 62.50% | 22.00% | 6.00% |
| 15 | 238,125,000 | 468,750.0 | 8.00% | 65.00% | 21.00% | 6.00% |
| 16 | 238,593,750 | 468,750.0 | 6.50% | 67.50% | 20.00% | 6.00% |
| 17 | 239,062,500 | 234,375.0 | 5.00% | 70.00% | 19.00% | 6.00% |
| 18 | 239,296,875 | 234,375.0 | 3.50% | 72.50% | 18.00% | 6.00% |
| 19 | 239,531,250 | 117,187.5 | 2.00% | 75.00% | 17.00% | 6.00% |
| 20 | 239,648,438 | 117,187.5 | 0.50% | 77.50% | 16.00% | 6.00% |
| 21 | 239,765,625 | 58,593.8 | 0.00% | 79.00% | 15.00% | 6.00% |
| 22 | 239,824,219 | 58,593.8 | 0.00% | 79.00% | 15.00% | 6.00% |
| 23 | 239,882,813 | 29,296.9 | 0.00% | 79.00% | 15.00% | 6.00% |
| 24 | 239,912,109 | 29,296.9 | 0.00% | 79.00% | 15.00% | 6.00% |
| 25 | 239,941,406 | 14,648.4 | 0.00% | 79.00% | 15.00% | 6.00% |
| 26 | 239,956,055 | 14,648.4 | 0.00% | 79.00% | 15.00% | 6.00% |
| 27 | 239,970,703 | 7,324.2 | 0.00% | 79.00% | 15.00% | 6.00% |
| 28 | 239,978,027 | 7,324.2 | 0.00% | 79.00% | 15.00% | 6.00% |
| 29 | 239,985,352 | 3,662.1 | 0.00% | 79.00% | 15.00% | 6.00% |
| 30 | 239,989,014 | 3,662.1 | 0.00% | 79.00% | 15.00% | 6.00% |
| 31 | 239,992,676 | 1,831.1 | 0.00% | 79.00% | 15.00% | 6.00% |
| 32 | 239,994,507 | 1,831.1 | 0.00% | 79.00% | 15.00% | 6.00% |
| 33 | 239,996,338 | 915.5 | 0.00% | 79.00% | 15.00% | 6.00% |
| 34 | 239,997,253 | 915.5 | 0.00% | 79.00% | 15.00% | 6.00% |
| 35 | 239,998,169 | 457.8 | 0.00% | 79.00% | 15.00% | 6.00% |
| 36 | 239,998,627 | 457.8 | 0.00% | 79.00% | 15.00% | 6.00% |
| 37 | 239,999,084 | 228.9 | 0.00% | 79.00% | 15.00% | 6.00% |
| 38 | 239,999,313 | 228.9 | 0.00% | 79.00% | 15.00% | 6.00% |
| 39 | 239,999,542 | 114.4 | 0.00% | 79.00% | 15.00% | 6.00% |
| 40 | 239,999,657 | 114.4 | 0.00% | 79.00% | 15.00% | 6.00% |
| 41 | 239,999,771 | 57.2 | 0.00% | 79.00% | 15.00% | 6.00% |
| 42 | 239,999,828 | 57.2 | 0.00% | 79.00% | 15.00% | 6.00% |
| 43 | 239,999,886 | 28.6 | 0.00% | 79.00% | 15.00% | 6.00% |
| 44 | 239,999,914 | 28.6 | 0.00% | 79.00% | 15.00% | 6.00% |
| 45 | 239,999,943 | 14.3 | 0.00% | 79.00% | 15.00% | 6.00% |
| 46 | 239,999,957 | 14.3 | 0.00% | 79.00% | 15.00% | 6.00% |
| 47 | 239,999,971 | 7.2 | 0.00% | 79.00% | 15.00% | 6.00% |
| 48 | 239,999,979 | 7.2 | 0.00% | 79.00% | 15.00% | 6.00% |
| 49 | 239,999,986 | 3.6 | 0.00% | 79.00% | 15.00% | 6.00% |
| 50 | 239,999,989 | 3.6 | 0.00% | 79.00% | 15.00% | 6.00% |

This leads to a theoretical max supply of 240M HNT. However, due to the slow block times in Year 1 of the network, there were fewer HNT created than the allotted 60M. This means that there will be ~17M fewer HNT.

The true max supply is 223M HNT.

As the system gets older it runs into a problem. By the year 2064 the protocol gets down to only 1 HNT being minted per month. This would start to break the system because HNT is not divisible enough to be used as an effective medium of exchange at that point. As the system starts running out of HNT rewards miners would start to lose the incentive to transmit data. Consensus rules can also start to break down if there are not sufficient mining rewards and the protocol cannot rely on transaction fees alone to secure consensus. In essence, the Helium protocol requires perpetual HNT mining to ensure a healthy and robust network.

Net Emissions is the solution to this problem. It allows the Helium protocol to have both (1) a hard cap on the number of HNT that can exist, and (2) perpetual HNT mining to ensure the network functions properly. Let’s explore how it works.

### Net Emissions

At the current 5M HNT/month issuance, there is a fixed 3,424 HNT minted per epoch. With Net Emissions, the system would target a net HNT mined per epoch, up to a cap. The key difference is targeting a fixed number of HNT minted per epoch vs targeting a net number of HNT minted per epoch.

In its simplest implementation, this would mean that the system monitors how many HNT were burnt for Data Credits that epoch and adds them to the number of HNT to be minted that epoch. So in this simple implementation, if 10 HNT were burned for Data Credits in an epoch, the system would mint 3,434 HNT instead of 3,424 HNT.

Net Emissions give the protocol enough HNT to reward consensus group members and reward data transmitters in perpetuity. Net Emissions make sure the Helium Protocol never runs out of HNT.

These Net Emissions do not add to the amount of HNT outstanding and therefore do not violate the max supply. Net Emissions also don’t have any impact on Data Credits (DC) customers and users.

There is a downside to uncapped Net Emissions. Uncapped Net Emissions do not allow for the net burning of HNT, and therefore eliminate deflationary pressure. The Helium protocol uses Burn-and-Mint Economics (BME), which depends on deflationary pressure to support HNT value. Without deflation, BME ceases to function as an effective token economic system.

To allow BME and Net Emissions to work in harmony, the proposal introduces a cap to Net Emissions of 34.24 HNT per epoch (1% of current issuance). This is implemented by capping out how much the Net Emissions Pool can be increased per epoch. This means that if greater than 34.24 HNT are burned in a given epoch, the BME system can kick in again to deflate HNT supply and increase its price back to equilibrium. This rate will be set via a chain variable expressing the limit in bones and will not be affected by halving events.  If the rate is found too be too high or too low, it can be adjusted later via standard governance mechanisms.

Under this HIP, the cap on Net Emissions would be made a chain var which can be adjusted via subsequent HIPs as the Helium community gets more data about market conditions in the future.

HNT burns are spiky and users of the Helium protocol often burn a large amount of HNT at once to build up a balance of data credits to use over time. To smooth out Net Emissions, the proposal also creates a “Net Emissions Pool,” which is increased by the amount of HNT that is burnt during an epoch. Then the Net Emissions Pool contributes 1/336th (there are 336 epochs per week) of its value to the next epoch’s mining rewards. This reduces the variability of HNT mining from epoch to epoch. We propose that this emission rate from the Net Emissions Pool be governed by a chain variable which is initially set to 336.

# Drawbacks

Reduced HNT issuance might reduce further network growth if the HNT price does not increase by a commensurate amount to incentivize new miners.

The Net Emissions Pool design may not adequately smooth rewards. It is impossible to forecast this until we have more real world data on HNT burning patterns, at which time the chain vars controlling the Net Emissions Pool can be adjusted.

# Rationale and Alternatives

The simplest alternative is to leave the system unchanged. The current system with a fixed 5M HNT minted per month is simple and also comes to an equilibrium as described in Burn-and-Mint Economics. However this equilibrium might be at an HNT price too low to incentivize people to buy Hotspots to join the network, thus slowing or halting network growth.

The main downside of the status quo is the psychological effect an uncapped supply has on the market. The crypto market understands and values scarcity and fixed-supply economics immensely and HNT’s current uncapped supply causes many market participants to discount the Helium Protocol’s economic viability.

Another alternative is to have a gradual decrease in HNT emissions rather than a defined halvening event. However, building on the point above, halvening events are already well known and understood by the market. In fact, they are extremely powerful psychological events and schelling points for the community at large. A gradual and smooth decrease in HNT emissions is likely to be less understood, or perhaps even ignored completely. There is sufficient evidence of the power of halvenings from systems like Bitcoin that the Helium community can learn from and build on.

There are many alternative HNT emission schedules which were considered as a part of the research that went into this proposal. The halvenings could be every 3 years instead of every 2 years. The halvenings could be quarterings. This HIP proposes halvenings every two years to align with the cost decrease cycle of Hotspots – Hotspot costs will likely decrease by at least 50% every two years for the foreseeable future. The network started with $500 Hotspots, by the 4th anniversary of genesis (2023) there will be $125 Hotspots for sale and by the 6th anniversary (2025) there will be $65 Hotspots. These assumptions are conservative and it is plausible that Hotspot costs will decline even faster but then plateau at a $50-$65 level due to base material costs.

There are also alternatives to our proposed cap on Net Emissions of 34.24 HNT per epoch (1% of current emissions). This number was chosen as the minimum emissions required to keep the protocol functioning in a mature steady state. If Net Emissions are set too high, the protocol requires more HNT to be burnt for BME to kick in and support the price through deflation. If Net Emissions are set too low, the protocol is at risk of running out of HNT to reward network participants as described above. It is impossible to forecast the precise market conditions 10 years in the future, that is why the proposal is that the cap on Net Emissions be made a chain var that can be adjusted as the Helium community gets more data about market conditions in the future.

Another alternative to the proposed cap on Net Emissions is to make the Net Emissions 1% of HNT burned rather than a fixed HNT cap. This would also have the effect of preserving BME but would offer slightly different economic implications.

# Deployment Impact

Once the halvening occurs, there will be a meaningful impact on all Hotspot owners and HST holders equally. There is no code deployment necessary until the first halvening which is on August 1st, 2021. 

Net Emissions will impact HNT mining as soon as they are implemented. However the cap on Net Emissions is a very small percentage of the current HNT mining, therefore we expect this impact to be minimal. 

This HIP would require changes to Helium Protocol documentation and education of the community regarding the new emissions schedule.
