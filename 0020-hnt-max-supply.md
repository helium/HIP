# HIP 20: HNT Max Supply

- Author: @jmfayal (jmf), @tjain-mcc (tushar), @rawrmaan
- Start Date: November 4, 2020
- Category: Economic
- Tracking Issue: [#73](https://github.com/helium/HIP/issues/73)

# Summary

This proposal suggests the introduction of halvings in net HNT issuance every 2 years (based on block height) to establish a max supply of HNT.

# Motivation

The most common question when new members join the Helium community is, “what is the max supply of HNT?” This is because many crypto protocols took inspiration from Bitcoin’s 21M fixed supply cap; however, the Helium protocol was originally designed with a [Burn-and-Mint Equilibrium](https://multicoin.capital/2018/02/13/new-models-utility-tokens/) (BME) model, which does not feature a hard supply cap for HNT. The community has consistently suggested that this issue be revisited and re-evaluated in order to make Helium more understandable to a wider group of participants. This proposal builds on those conversations and seeks to advance it by formally proposing a HIP.

To ensure the network continues to function properly, the Helium protocol incentivizes Hotspot operators with HNT mining rewards. If there is no HNT left to be mined, Hotspot owners have no incentive to operate their Hotspots. Currently, the Helium protocol mints 5 million HNT in perpetuity in order to adequately incentivize Hotspot owners for providing wireless coverage and transmitting IOT data.

This proposal lays out a new crypto-economic innovation that addresses the fixed cap issue while also ensuring that Hotspot operators are still adequately incentivized in perpetuity to mine HNT (and support the network).This innovation is called “Net Emissions.” Net Emissions is a breakthrough economic construction. It has been discussed in abstract by other crypto communities and is inspired by the work of researchers in the Bitcoin community. If adopted, Helium would be the first protocol to implement this crypto-economic innovation.

With the introduction of a hard cap on HNT supply, Helium’s token-economics would become more understandable to the broader crypto community at large. It would also create future scarcity and a new incentive to hold HNT. If there is more demand for HNT, miners will have additional incentive to deploy Hotspots. If miners deploy more Hotspots, the network will continue to grow its coverage, which will ultimately help meet the demands of end users and customers who use the network.

# Stakeholders

All HNT holders, Hotspot owners, and HST holders will be affected by this HIP. Users of the network will see no change to data transmission pricing.

# Detailed Explanation

The proposal is to have halvenings of net HNT issuance every 2 years on the anniversary of genesis. This means the first halvening will be on 8/1/2021 and net HNT issuance will be reduced to 2.5M HNT per month.

The HNT mining split amongst stakeholders will not change from the [current schedule](https://dl.dropboxusercontent.com/s%2Ffyn62o2ea8k1l41%2FScreen%2520Shot%25202020-10-31%2520at%252009-46-50%2520The%2520New%2520Wireless%2520Economy.%2520.png):

|Year|HNT at start of year | Total HNT Minted | % to Proof of Coverage (+ any extra from Data Transfer) | % to Data Transfer (excess to Proof of Coverage) | % to Founders Reward | % to Consensus |
|-|-|-|-|-|-|-|
| 1 | 0 | 5,000,000.0 | 29.00% | 30.00% | 35.00% | 6.00% |
| 2 | 5,000,000 | 5,000,000.0 | 27.50% | 32.50% | 34.00% | 6.00% |
| 3 | 10,000,000 | 2,500,000.0 | 26.00% | 35.00% | 33.00% | 6.00% |
| 4 | 12,500,000 | 2,500,000.0 | 24.50% | 37.50% | 32.00% | 6.00% |
| 5 | 15,000,000 | 1,250,000.0 | 23.00% | 40.00% | 31.00% | 6.00% |
| 6 | 16,250,000 | 1,250,000.0 | 21.50% | 42.50% | 30.00% | 6.00% |
| 7 | 17,500,000 | 625,000.0 | 20.00% | 45.00% | 29.00% | 6.00% |
| 8 | 18,125,000 | 625,000.0 | 18.50% | 47.50% | 28.00% | 6.00% |
| 9 | 18,750,000 | 312,500.0 | 17.00% | 50.00% | 27.00% | 6.00% |
| 10 | 19,062,500 | 312,500.0 | 15.50% | 52.50% | 26.00% | 6.00% |
| 11 | 19,375,000 | 156,250.0 | 14.00% | 55.00% | 25.00% | 6.00% |
| 12 | 19,531,250 | 156,250.0 | 12.50% | 57.50% | 24.00% | 6.00% |
| 13 | 19,687,500 | 78,125.0 | 11.00% | 60.00% | 23.00% | 6.00% |
| 14 | 19,765,625 | 78,125.0 | 9.50% | 62.50% | 22.00% | 6.00% |
| 15 | 19,843,750 | 39,062.5 | 8.00% | 65.00% | 21.00% | 6.00% |
| 16 | 19,882,813 | 39,062.5 | 6.50% | 67.50% | 20.00% | 6.00% |
| 17 | 19,921,875 | 19,531.3 | 5.00% | 70.00% | 19.00% | 6.00% |
| 18 | 19,941,406 | 19,531.3 | 3.50% | 72.50% | 18.00% | 6.00% |
| 19 | 19,960,938 | 9,765.6 | 2.00% | 75.00% | 17.00% | 6.00% |
| 20 | 19,970,703 | 9,765.6 | 0.50% | 77.50% | 16.00% | 6.00% |
| 21 | 19,980,469 | 4,882.8 | 0.00% | 80.00% | 15.00% | 6.00% |
| 22 | 19,985,352 | 4,882.8 | 0.00% | 80.00% | 15.00% | 6.00% |
| 23 | 19,990,234 | 2,441.4 | 0.00% | 80.00% | 15.00% | 6.00% |
| 24 | 19,992,676 | 2,441.4 | 0.00% | 80.00% | 15.00% | 6.00% |
| 25 | 19,995,117 | 1,220.7 | 0.00% | 80.00% | 15.00% | 6.00% |
| 26 | 19,996,338 | 1,220.7 | 0.00% | 80.00% | 15.00% | 6.00% |
| 27 | 19,997,559 | 610.4 | 0.00% | 80.00% | 15.00% | 6.00% |
| 28 | 19,998,169 | 610.4 | 0.00% | 80.00% | 15.00% | 6.00% |
| 29 | 19,998,779 | 305.2 | 0.00% | 80.00% | 15.00% | 6.00% |
| 30 | 19,999,084 | 305.2 | 0.00% | 80.00% | 15.00% | 6.00% |
| 31 | 19,999,390 | 152.6 | 0.00% | 80.00% | 15.00% | 6.00% |
| 32 | 19,999,542 | 152.6 | 0.00% | 80.00% | 15.00% | 6.00% |
| 33 | 19,999,695 | 76.3 | 0.00% | 80.00% | 15.00% | 6.00% |
| 34 | 19,999,771 | 76.3 | 0.00% | 80.00% | 15.00% | 6.00% |
| 35 | 19,999,847 | 38.1 | 0.00% | 80.00% | 15.00% | 6.00% |
| 36 | 19,999,886 | 38.1 | 0.00% | 80.00% | 15.00% | 6.00% |
| 37 | 19,999,924 | 19.1 | 0.00% | 80.00% | 15.00% | 6.00% |
| 38 | 19,999,943 | 19.1 | 0.00% | 80.00% | 15.00% | 6.00% |
| 39 | 19,999,962 | 9.5 | 0.00% | 80.00% | 15.00% | 6.00% |
| 40 | 19,999,971 | 9.5 | 0.00% | 80.00% | 15.00% | 6.00% |
| 41 | 19,999,981 | 4.8 | 0.00% | 80.00% | 15.00% | 6.00% |
| 42 | 19,999,986 | 4.8 | 0.00% | 80.00% | 15.00% | 6.00% |
| 43 | 19,999,990 | 2.4 | 0.00% | 80.00% | 15.00% | 6.00% |
| 44 | 19,999,993 | 2.4 | 0.00% | 80.00% | 15.00% | 6.00% |
| 45 | 19,999,995 | 1.2 | 0.00% | 80.00% | 15.00% | 6.00% |
| 46 | 19,999,996 | 1.2 | 0.00% | 80.00% | 15.00% | 6.00% |
| 47 | 19,999,998 | 0.6 | 0.00% | 80.00% | 15.00% | 6.00% |
| 48 | 19,999,998 | 0.6 | 0.00% | 80.00% | 15.00% | 6.00% |
| 49 | 19,999,999 | 0.3 | 0.00% | 80.00% | 15.00% | 6.00% |
| 50 | 19,999,999 | 0.3 | 0.00% | 80.00% | 15.00% | 6.00% |

This leads to a theoretical max supply of 240M HNT. However, due to the slow block times in Year 1 of the network, there were fewer HNT created than the allotted 60M. This means that there will be ~17M fewer HNT.

The true max supply is 223M HNT.

As the system gets older it runs into a problem. By the year 2064 the protocol gets down to only 1 HNT being minted per month. This would start to break the system because HNT is not divisible enough to be used as an effective medium of exchange at that point. As the system starts running out of HNT rewards miners would start to lose the incentive to transmit data. Consensus rules can also start to break down if there are not sufficient mining rewards and the protocol cannot rely on transaction fees alone to secure consensus. In essence, the Helium protocol requires perpetual HNT mining to ensure a healthy and robust network.

Net Emissions is the solution to this problem. It allows the Helium protocol to have both (1) a hard cap on the number of HNT that can exist, and (2) perpetual HNT mining to ensure the network functions properly. Let’s explore how it works.

### Net Emissions

At the current 5M HNT/month issuance, there is a fixed 3,424 HNT minted per epoch. With Net Emissions, the system would target a net HNT mined per epoch, up to a cap. The key difference is targeting a fixed number of HNT minted per epoch vs targeting a net number of HNT minted per epoch.

In its simplest implementation, this would mean that the system monitors how many HNT were burnt that epoch and adds them to the number of HNT to be minted that epoch. So in this simple implementation, if 10 HNT were burned in an epoch, the system would mint 3,434 HNT instead of 3,424 HNT.

Net Emissions give the protocol enough HNT to reward consensus group members and reward data transmitters in perpetuity. Net Emissions make sure the Helium Protocol never runs out of HNT.

These Net Emissions do not add to the amount of HNT outstanding and therefore do not violate the max supply. Net Emissions also don’t have any impact on Data Credits (DC) customers and users.

There is a downside to uncapped Net Emissions. Uncapped Net Emissions do not allow for the net burning of HNT, and therefore eliminate deflationary pressure. The Helium protocol uses Burn-and-Mint Economics (BME), which depends on deflationary pressure to support HNT value. Without deflation, BME ceases to function as an effective token economic system.

To allow BME and Net Emissions to work in harmony, the proposal introduces a cap to Net Emissions of 34.24 HNT per epoch (1% of current issuance). This is implemented by capping out how much the Net Emissions Pool can be increased per epoch. This means that if greater than 34.24 HNT are burned in a given epoch, the BME system can kick in again to deflate HNT supply and increase its price back to equilibrium.

Under this HIP, the cap on Net Emissions would be made a chain var which can be adjusted via subsequent HIPs as the Helium community gets more data about market conditions in the future.

HNT burns are spiky and users of the Helium protocol often burn a large amount of HNT at once to build up a balance of data credits to use over time. To smooth out Net Emissions, the proposal also creates a “Net Emissions Pool,” which is increased by the amount of HNT that is burnt during an epoch. Then the Net Emissions Pool contributes 1/336th (there are 336 epochs per week) of its value to the next epoch’s mining rewards. This reduces the variability of HNT mining from epoch to epoch.

# Drawbacks

Reduced HNT issuance might reduce further network growth if the HNT price does not increase by a commensurate amount to incentivize new miners.

# Rationale and Alternatives

The simplest alternative is to leave the system unchanged. The current system with a fixed 5M HNT minted per month is simple and also comes to an equilibrium as described in Burn-and-Mint Economics. However this equilibrium might be at an HNT price too low to incentivize people to buy Hotspots to join the network, thus slowing or halting network growth.

The main downside of the status quo is the psychological effect an uncapped supply has on the market. The crypto market understands and values scarcity and fixed-supply economics immensely and HNT’s current uncapped supply causes many market participants to discount the Helium Protocol’s economic viability.

Another alternative is to have a gradual decrease in HNT emissions rather than a defined halvening event. However, building on the point above, halvening events are already well known and understood by the market. In fact, they are extremely powerful psychological events and schelling points for the community at large. A gradual and smooth decrease in HNT emissions is likely to be less understood, or perhaps even ignored completely. There is sufficient evidence of the power of halvenings from systems like Bitcoin that the Helium community can learn from and build on.

There are many alternative HNT emission schedules which were considered as a part of the research that went into this proposal. The halvenings could be every 3 years instead of every 2 years. The halvenings could be quarterings. This HIP proposes halvenings every two years to align with the cost decrease cycle of Hotspots – Hotspot costs will likely decrease by at least 50% every two years for the foreseeable future. The network started with $500 Hotspots, by the 4th anniversary of genesis (2023) there will be $125 Hotspots for sale and by the 6th anniversary (2025) there will be $65 Hotspots. These assumptions are conservative and it is plausible that Hotspot costs will decline even faster but then plateau at a $50-$65 level due to base material costs.

There are also alternatives to our proposed cap on Net Emissions of 34.24 HNT per epoch (1% of current emissions). This number was chosen as the minimum emissions required to keep the protocol functioning in a mature steady state. If Net Emissions are set too high, the protocol requires more HNT to be burnt for BME to kick in and support the price through deflation. If Net Emissions are set too low, the protocol is at risk of running out of HNT to reward network participants as described above. It is impossible to forecast the precise market conditions 10 years in the future, that is why the proposal is that the cap on Net Emissions be made a chain var that can be adjusted as the Helium community gets more data about market conditions in the future.

Another alternative to the proposed cap on Net Emissions is to make the Net Emissions 1% of HNT burned rather than a fixed HNT cap. This would also have the effect of preserving BME but would offer slightly different economic implications.

# Deployment Impact

There will be no immediate impact on users of the network as the first halvening event would be 9 months away. Once the halvening occurs, there will be a meaningful impact on all Hotspot owners and HST holders equally.

This HIP would require changes to Helium Protocol documentation and education of the community regarding the new emissions schedule.
