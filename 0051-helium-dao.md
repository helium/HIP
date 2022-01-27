# HIP51: Helium DAO

- Author: [@tjain-mcc](https://github.com/tjain-mcc), Shayon,
  [@jmfayal](https://github.com/jmfayal)
- Start Date: 2022-01-26
- Category: Economic / Technical
- Original HIP PR: [#334](https://github.com/helium/HIP/pull/334)
- Tracking Issue: `TODO`
- Status: Work In Progress

# Summary
[summary]: #summary

This proposal outlines economic and technical constructions with the aim of
scaling the Helium Network to support new users, devices, and types of wireless
network protocols.

We propose that each wireless network supported by Helium (LoRaWAN, Wifi, 5G —
referred to as wireless network protocols or WNPs) has its own subDAO with its
own token (referred to as wireless network tokens or WNTs). The key
specifications of the WNT such as proof-of-coverage rules, data credits rewards,
and consensus mechanisms are governed by each WNT DAO.

The aim is to create an economy such that the underlying HNT-Data Credit
burn-and-mint equilibrium remains undisturbed, and Proof-of-Coverage rules and
miner emission amounts are dictated by the corresponding wireless network’s
sub-token.

The technical model requires that the entire Helium Network lives at some
proposed base layer (L1). All accounts and transaction activity happens at this
L1. All subDAOs operate as economic and governance layers (L2) with their
respective WNTs acting as native tokens for this purpose. Each L2 also runs
software to calculate WNP specific items (eg: all the proof of coverage code
that exists on the current LoRaWAN network to determine hotspot rewards) and the
L2 validators who have staked WNTs come to consensus on these calculations.

# Background
[background]: #background

For the Helium Network to grow to global scale in number of active devices and
users it is necessary to develop economic and technical primitives that will
support that scale across various wireless networking technologies.

[HIP 27: CBRS 5G Support][hip27] provides a broad discussion of 5G WNP specific
data credits mechanisms, and [HIP 37: Omni-Protocol PoC][hip37] outlines an
incentive model as well as proof-of-coverage rules for the 5G Network. This is a
three-part proposal that builds on such existing work with two primary aims:

1. Provide a general structure for onboarding new WNPs to the broader Helium
   Network, with mechanisms in place to ensure that protocol-specific attributes
   such as proof-of-coverage rules, data credits pricing, and block validation
   are within control of the emergent WNT DAO.
2. Specify the implementation of the structure proposed through detailed
   onboarding proposals for the LoRaWAN and 5G networks, described in [HIP 52:
   LoRaWAN DAO][hip52] and [HIP 53: 5G DAO][hip53].

The technical and economic design decisions of the Helium Network today have
been made around the flagship LoRaWAN Wireless Network Protocol. In order to
support new networks and devices, there are two core problems to be addressed:
**blockchain scalability** and **WNP specific incentive alignment.**

This proposal outlines two constructions to address the aforementioned core
problems:

1. *Blockchain Scalability* We propose that each WNP has validators who operate
   software to calculate WNP specific items (eg: all the proof of coverage code
   that exists on the current LoRaWAN network to determine hotspot rewards).
   Validators stake WNTs and are rewarded by WNT inflation.

All non WNP specific transactions (simple transfers, burning HNT to DC, etc)
occur at some high throughput, low latency base layer chain on which the overall
Helium Network lives.

1. *WNP Specific Incentive Alignment We propose that each WNP operate as its own
   sub-DAO within the broader umbrella of the Helium DAO. WNP Sub-DAOs are able
   to issue WNTs to their stakeholders and WNT denominated governance controls
   WNP specific attributes.*

# Motivation
[motivation]: #motivation

There are three key drivers for proposing that consensus and execution for each
WNP occur at some base layer chain, while the economic and governance layer for
that WNP is separated from the native token of the overall Helium Network

1. *Scalability -* Each WNP has the ability to run its own code for WNP specific
   items
2. *Native Tokens Provide Separation of Governance Each WNP effectively governs
   its Proof-of-Coverage rules, data pricing, and rewards distribution
   mechanisms. This structure provides significantly more self-sovereignty over
   the structure and direction of the WNP.*
3. *Composability Implies Utility -* If the overall Helium DAO base-chain is
   able to support smart contracts, it is possible to imagine a variety of novel
   use cases for HNT as well as each of the WNT tokens. Some examples here are
   signaling strategies (yield aggregator DAOs that take HNT from passive
   holders and stake to specific WNPs based on market conditions) or money
   markets (liquid borrow-lend markets for greater delegation to validators or
   leveraged staking).

There are two key drivers for WNPs to operate as sub-DAOs beneath the overall
Helium Network through their corresponding WNTs

1. *Curation and risk expression* WNTs allow network participants and
   speculators to indicate support for a given network, which can inform
   distribution of emissions and developer resources. For example, if HNT
   holders bond a large number of HNT to a particular WNP, the HNT denominated
   rewards for that WNP increase and help accelerate the flywheel for that WNP.
2. *Onboarding new protocols* WNP DAOs provide an easy framework for addition of
   new wireless protocols where the broader Helium DAO delegates some portion of
   HNT emissions to each WNP DAO.

# Stakeholders
[stakeholders]: #stakeholders

This proposal impacts all current and future stakeholders in the Helium
Community.

# Construction
[construction]: #construction

We propose that each WNP operates as its own subDAO within the broader Helium
DAO, while both DAOs exist on a single base L1 chain. Each WNP has its own
economic and governance layer through its subDAO, which comprises all WNT
holders.

![subdaos][subdaos]

All subDAO specific addresses across all WNPs on the network will live on this
L1 chain. All tokens exist on the L1 chain. The L2 is for calculation and
computation purposes only.

Before we can define the WNP specific economic structures, we need to outline
how the rewards are split between WNPs and how to fund the earliest stages of
development for new WNPs.

## PoC Model Background

HIP 27 originally introduced a concept to allocate a portion of unrewarded Data
Transfer rewards (up to 30% of the DC Bonus Pool) towards Proof-of-Coverage
rewards for new wireless networks, such as 5G and Wi-Fi. The approach was
presented and discussed at the DeWi Community Call and Discord. While the
concept was generally well received, we fell short of coming up with a technical
implementation that would be sufficiently difficult to arbitrage. As a result,
we chose to truncate HIP 27 to focus on implementation of a chain variable for
DC / cellular data conversion ratio and revisit economics and implementation of
PoC for non-LoRaWan wireless network types to a future HIP.

## PoC Incentive Model for HIP 50

Currently, under HIP-27, non-LoRaWAN gateways are only rewarded based on data
transfer and those rewards are based on the 1 DC burn = 1 DC equivalent earning
principle laid out in HIP-10. That reward bucket is currently, as of January
2022, limited to 35% of total HNT issuance per epoch. Any HNT from that bucket
that is not allocated to Data Transfer rewards is reallocated to LoRaWAN PoC
rewards.

**We propose three significant changes to the reward bucket structure**

### 1. Remove division between PoC and DC reward buckets

After HIP-10, the vast majority of DC rewards are reallocated to the LoRaWAN
PoC, which has made the distinction between the buckets nominal. Given this
reality, we propose a merging of the two rewards buckets.

The value of the bucket will equal the combined value of the existing DC and PoC
buckets and will be adjusted along with all other rewards buckets on the
existing rewards schedule.

Existing reward curve by reward type:

![existing reward curve][existing-reward-curve]

The new reward bucket would be a combination of the “Network Data Transfer” and
“Proof of Coverage” rewards above.

### 2. Split PoC rewards between wireless protocols based on a quadratic equation that accounts for DCs burned and active devices per WNP

The success of the Helium network is contingent on its ability to find real
world applications that burn data credits via data transfer activity. Therefore,
the incentive model should be designed in a way that promotes wireless network
protocols (WNPs) that accomplish that goal. Additionally, the scale of each WNPs
participation network should also be taken into account, so as not to overly
disadvantage early protocols with lower DC burn rates. To accomplish this
propose the quadratic equation below:

Each protocol would be assigned a ‘score’ per epoch:

![\textup{Protocol Score} = \textup{WNP DCs Burner} * {\sqrt{\textup{WNP Active Device Count}}}](https://latex.codecogs.com/svg.image?\textup{Protocol&space;Score}&space;=&space;\textup{WNP&space;DCs&space;Burner}&space;*&space;{\sqrt{\textup{WNP&space;Active&space;Device&space;Count}}})

Once each protocol has a score, the % of total Epoch PoC rewards assigned to
each WNP will be assessed by comparing the individual score to the sum of all
scores:

![\textup{Percentage of POC Rewards per WNP} = \textup{WNP Specific Score} \div \sum (\textup{All WNP Scores})](https://latex.codecogs.com/svg.image\textup{Percentage&space;of&space;POC&space;Rewards&space;per&space;WNP}&space;=&space;\textup{WNP&space;Specific&space;Score}&space;\div&space;\sum&space;(\textup{All&space;WNP&space;Scores}))

To put this into context, if you have two networks with 50,000 and 500,000
devices each, the smaller network would need approximately 3 times the DC burn
to have a comparable protocol score to the larger network.

Most importantly, this model gives us a framework to add new WNPs in the future
without having to design reward splits on an ad-hoc basis.

### 3. Implementing a ‘cold start’ bucket to help fund early stage networks that don’t yet have meaningful DC burn

The Lorawan protocol on Helium benefitted from having a built in ‘cold start’
reward system via PoC rewards to help fund the growth of the network. Under the
new model, a network that doesn’t have any DC burn would not have any way of
rewarding it’s early users, so we are proposing a 10% ‘cold start’ reward bucket
that is carved out from the combined PoC/data rewards bucket. Under this system,
any WNP that has been live for sub 1 million epochs (approximately 2 years)
would evenly split 10% of all HNT rewards. Additionally, if a specific WNP had
enough devices or was burning enough DCs to receive 10% of the larger PoC/data
rewards bucket, it would be excluded from the ‘cold start’ rewards bucket.

If no WNP ‘qualifies’ for the cold start bucket, those rewards would be
reallocated to the regular PoC/data reward bucket.

## Definitions and calculations for Omni-Protocol PoC incentive model

- **DC burn used in PoC split calculation**: DC burn is not limited to data
  transfers per WNP. The calculation also includes fees associated with other
  actions, including, but not limited to, gateway assertions, token transfers,
  and gateway relocation fees.

- **Wireless Network Protocol (WNP)**: Wireless network type is a computer
  network that uses wireless data connections between network nodes and utilizes
  a uniform, standard set of rules that determine how data is transmitted
  between different devices in the same network. (i.e. LoRaWan, 5G, Wi-Fi,
  NB-IoT etc. all different wireless network protocols).

- **Frequency of PoC reward split recalculation**: Manually adjusted on a
  frequency at the discretion of DeWi unless and until an auto recalculation
  feature is built into the protocol

- **Active Device**: Active devices are the subDAO's definition of devices
  creating valid coverage during the epoch

## Bonding Curve Specification

WNT are issued against a bonding curve with issuance, redemption, and
transaction fee parameters set by WNT governance. Each WNT can set the shape of
its curve.

We suggest that all WNT bonding curves take the shape P = S^k where k > 1, and P
represents Price and S represents Supply. The quote currency is the WNT and the
base currency is HNT.

For a given amount of HNT deposited to or withdrawn from a given WNP bonding
curve, the increase or decrease in supply and price is given by resulting change
in the area under the curve. The integral is given by

![\int_{S_a}^{S_b} S^k = \frac{1}{k+1} (S_b^{k+1} - S_a^{k+1})](https://latex.codecogs.com/svg.image?\int_{S_a}^{S_b}&space;S^k&space;=&space;\frac{1}{k&plus;1}&space;(S_b^{k&plus;1}&space;-&space;S_a^{k&plus;1}))

The shape of the curve for k only slightly larger than 1 is as follows

![bonding curve][bonding-curve]

The main consideration  in designing this bonding curve is that it’s difficult
to balance the positives of reflexivity with potential sharp price movements in
either direction — this shape is close enough to linear to mitigate some of
those issues.

## Rewards Distribution Mechanism

We provide an end-to-end description of data transfer, proof-of-coverage, and
consensus rewards for a given WNP under the Helium Network.

*Data Transfer Process*

For each WNP, we propose that a device looking to receive coverage across the
network purchase Data Credits by **purchasing and burning HNT**.

The device **subsequently burns those Data Credits** in the name of the hotspot
or set of hotspots once data has been transferred.

The device then **relays the receipt of this transaction** to the set of
validators for the WNP.

The WNP validator set then **relays this information to the HNT emissions
contract** in order to determine the HNT amount to be distributed to the WNP
subDAO for all rewards distribution.

At the end of each epoch, the **WNP validator set prepares the distribution for
mining rewards** denominated in the WNT to each hotspot based on coverage
provided.

*Proof-of-Coverage Process*

The WNP subDAO defines the rules for proof-of-coverage challenges. In a given
epoch, Challengers, Challenges, and Witnesses **relay the results of challenges
to the WNP validator set** in order to distribute proof-of-coverage rewards
denominated in WNT to relevant devices.

*Consensus Process*

The WNP subDAO defines the rules for consensus, and **distributes a portion of
WNT emissions in a given epoch for WNP validators.**

![subDAO governance][subdao-governance]

*Emissions Calculation*

At the end of a given epoch, the HNT emissions contract **performs a tally of
the data credits transferred across WNPs**. The emissions contract subsequently
distributes the determined amount of HNT to a **WNP subDAO multi-signature
wallet**, the addresses of which comprise the set of validators of that WNP.

*WNT Issuance*

Each WNP DAO then **submits the entire amount of HNT into its bonding curve** in
order to mint new WNT for hotspots and validators participating in data transfer
and proof-of-coverage.

In a given epoch, if the WNP Hotspots were to receive some amount of HNT from
the Helium DAO, the WNP subDAO multi-signature wallet distributes a
**corresponding amount of newly minted WNT of equal market value** as per the
bonding curve to the hotspots in its network based on its mining rules.

*Note that all new issuance in the WNP bonding curve through HNT emissions are
distributed to hotspots and validators. External capital entering or exiting the
bonding curve does not post any liquidity risk to WNP devices.*

*WNT Issuance*

If a given address wishes to redeem their WNT, they can **“sell” against the
bonding curve** to receive the market rate of underlying HNT.

The transaction involves sending the required amount of WNT tokens to a **burn
address**, and receiving the determined amount of HNT tokens from the **WNP
subDAO multi-signature wallet**.

The address **relays the message of the sale to the set of WNP validators**,
which then adjust the position of the bonding curve in the following epoch after
adjusting for all other sales and any new issuance.

*Transaction Fee*

A WNP **subDAO governed transaction fee** is placed on issuance and redemption
of WNT tokens on the bonding curve. This fee is charged in HNT and we suggest
starting it at 0.3% of all transactions. This HNT fee is immediately submitted
to the WNT bonding curve.

For example in a given epoch, if the 5G bonding curve had trading volume of
100,000 HNT and brought in 300 HNT worth of transaction fees, that 300 HNT is
resubmitted to the curve increasing the price of WNT according to the equation.

## *Fair-Launch Mechanism*

The bonding curve mechanism is susceptible to bot frontrunning. We borrow from
[Strata protocol’s fair launch mechanism][strata] to ensure that early
participants in any WNP DAO are protected from this attack vector.

The fair launch mechanism described involves a gradually steepening bonding
curve such that the area underneath remains fixed with each unit increment in
time.

![fair-launch-graph][fair-launch-graph]

This ensures that bots are unable to atomically frontrun network participants. .

# Clarifications

We set the following economic constraints in order to ensure an equilibrium
within each subDAO and the overall network

1. HNT remains the unit of buy-and-burn in order to maintain the HNT flywheel.
   Data Credits are universal, in that they can be created by burning HNT and
   are usable across any WNP.
2. Mining rewards for hotspots in a given WNP are distributed in the
   corresponding WNT
3. WNTs can be traded on secondary markets but are redeemable for HNT as per the
   primary market defined by its bonding curve. New WNTs can be minted by
   depositing HNT into the bonding curves as well.
4. Each WNP can set their own WNT emission schedule and distribution.

# Open Questions

1. Should the subDAO multisig be composed of WNP validators or some delegation
   chosen by WNT holders through governance?
2. What does a migration process look like for the existing implementation onto
   the new structure outlined?
3. What governance procedure should be used to whitelist specific WNP DAOs?

[hip27]: https://github.com/helium/HIP/blob/master/0027-cbrs-5g-support.md
[hip37]: https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md
[hip52]: https://docs.google.com/document/d/1fqy3JLdoP8YgOULx-sE_24xOL1UL9esHu_Ctju4iGcg/edit
[hip53]: https://docs.google.com/document/d/1rg9VK28S8bWOeKNiKXUipsLsBxLjuHH7AnVe6TjKw4I/edit
[subdaos]: https://lh4.googleusercontent.com/KYORnsFb3X0X42t64FscUArcDZBjXyopik_AaZTN7tLvxYRL5-s1nvd1WY3X4vJA5mWe1_XN_miwDoRXhU70YV_txsO5Y_mWFbVrx6byNinT--khit2AEAYl4GMO0Vm_lL49BB05
[existing-reward-curve]: https://lh4.googleusercontent.com/aCKlXePHuivkp8IFK5-VLifO-xw8WKOpArn9OCiobOW0WjpHcPBtogNqvDBLofH8q4lcMFtnP0XZZlGq3v247AA3Syqq6RKK0Pr6-_xKjv4DTPmmbSAJ5XIrSNaLHt9Y3py8My_v
[bonding-curve]: https://lh3.googleusercontent.com/9BO0qb90HKiWDHreSWemmZhEmjSiPKJKsiEi1lMENNzV2StUtx1qiwYFPg5NDR4JZux5YgmL_ia99yjgY0O1-QUbnjvDo0qgq8G0TJTWq53AAF8XNI4xaYKKBjqpW2Y5eq7NbvuS
[subdao-governance]: https://lh3.googleusercontent.com/VIycvHCtq1nZtXyAC8haZw6xF1sBHcs8GVRPFX3-lAFtsR-HflGQyGUc7tAjs8R4VPS7HP_5A0rJRsAr_G0kiOZJSxM80t3_ukgdutd15XdQerDkrx0IZH27BJjQRbLP2oVQjZ8_
[strata]: https://www.strataprotocol.com/docs/learn/fair_launch
[fair-launch-graph]: https://lh4.googleusercontent.com/CDZiML8YFE5BOwSbjT5GUjejATCIqUpLF85XDfIjjm_semkSZOklnj9cMMG1Kd4yoGjoLbw-Gelvj4M-XI7bM77gOe6yVXRS22jxv-UZlHHIV1hF-Il15AZOPSd_1Si9ouAGb0Yp
