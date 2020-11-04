# HIP 20: HNT Max Supply

Author: @JMF, @Tushar, @rawrmaan
Start Date: November 4, 2020
Category: Economic
Tracking Issue: N/A

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

![|672x556](https://lh3.googleusercontent.com/wTISjqJrP_kLzAjgVN8YqWEAszUJ3BoMGBpdMzevXa92FL0HfmQwlS9E4hZXCFhHw8iv2KTcfpc5cy-MdwOEREsWNN4Uwtp13dMXNHI-qpXTSMcka6EgGSrLqhQlX2wY_FU2NwA)

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
