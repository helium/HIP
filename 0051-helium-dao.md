# HIP51: Helium DAO

- Author: [@tjain-mcc](https://github.com/tjain-mcc),
  [@shayons297](htts://github.com/shayons297),
  [@jmfayal](https://github.com/jmfayal)
- Start Date: 2022-01-26
- Category: Economic / Technical
- Original HIP PR: [#334](https://github.com/helium/HIP/pull/334)
- Tracking Issue: [#336](https://github.com/helium/HIP/issues/336)
- Status: Draft

# Summary
[summary]: #summary

This proposal outlines economic and technical constructions with the aim of
scaling the Helium Network to support new users, devices, and types of wireless
network protocols.

We propose that each wireless network supported by Helium (LoRaWAN, Wifi, 5G —
referred to as Decentralized Network Protocols or DNPs) has its own subDAO with its
own token (referred to as Decentralized Network Tokens or DNTs). The key
specifications of the DNT such as Proof-of-Coverage rules, data credits rewards,
and consensus mechanisms are governed by each DNT DAO.

The aim is to create an economy such that the underlying HNT-Data Credit
burn-and-mint equilibrium remains undisturbed, and Proof-of-Coverage rules and
miner emission amounts are dictated by the corresponding wireless network’s
sub-token.

The technical model requires that the entire Helium Network lives at some
proposed base layer (L1). All accounts and transaction activity happens at this
L1. All subDAOs operate as economic and governance layers (L2) with their
respective DNTs acting as native tokens for this purpose. Each L2 also runs
software to calculate DNP specific items (e.g.: all the Proof-of-Coverage code
that exists on the current LoRaWAN network to determine Hotspot rewards) and the
L2 Validators who have staked DNTs come to consensus on these calculations.

# Background
[background]: #background

For the Helium Network to grow to global scale in number of active devices and
users it is necessary to develop economic and technical primitives that will
support that scale across various wireless networking technologies.

[HIP 27: CBRS 5G Support][hip27] provides a broad discussion of 5G DNP specific
data credits mechanisms, and [HIP 37: Omni-Protocol PoC][hip37] outlines an
incentive model as well as proof-of-coverage rules for the 5G Network. This is a
three-part proposal that builds on such existing work with two primary aims:

1. Provide a general structure for onboarding new DNPs to the broader Helium
   Network, with mechanisms in place to ensure that protocol-specific attributes
   such as Proof-of-Coverage rules, data credits pricing, and block validation
   are within control of the emergent DNT DAO.
2. Specify the implementation of the structure proposed through detailed
   onboarding proposals for the LoRaWAN and 5G networks, described in [HIP 52:
   LoRaWAN DAO][hip52] and [HIP 53: 5G DAO][hip53].

The technical and economic design decisions of the Helium Network today have
been made around the flagship LoRaWAN Decentralized Network Protocol. In order to
support new networks and devices, there are two core problems to be addressed:
**blockchain scalability** and **DNP specific incentive alignment.**

This proposal outlines two constructions to address the aforementioned core
problems:

1. *Blockchain Scalability*: We propose that each DNP has Validators who operate
   software to calculate DNP specific items (eg: all the Proof-of-Coverage code
   that exists on the current LoRaWAN network to determine Hotspot rewards).
   Validators stake DNTs and are rewarded by DNT inflation.

   All non DNP specific transactions (simple transfers, burning HNT to DC, etc)
   occur at some high throughput, low latency base layer chain on which the
   overall Helium Network lives.   
2. *DNP Specific Incentive Alignment*: We propose that each DNP operate as its
   own sub-DAO within the broader umbrella of the Helium DAO. DNP Sub-DAOs are
   able to issue DNTs to their stakeholders and DNT denominated governance
   controls DNP specific attributes.

# Motivation
[motivation]: #motivation

There are three key drivers for proposing that consensus and execution for each
DNP occur at some base layer chain, while the economic and governance layer for
that DNP is separated from the native token of the overall Helium Network

1. *Scalability:* Each DNP has the ability to run its own code for DNP specific
   items
2. *Native Tokens:* Provide Separation of Governance Each DNP effectively governs
   its Proof-of-Coverage rules, data pricing, and rewards distribution
   mechanisms. This structure provides significantly more self-sovereignty over
   the structure and direction of the DNP.
3. *Composability Implies Utility:*  If the overall Helium DAO base-chain is
   able to support smart contracts, it is possible to imagine a variety of novel
   use cases for HNT as well as each of the DNT tokens. Some examples here are
   signaling strategies (yield aggregator DAOs that take HNT from passive
   holders and stake to specific DNPs based on market conditions) or money
   markets (liquid borrow-lend markets for greater delegation to Validators or
   leveraged staking).


# Stakeholders
[stakeholders]: #stakeholders

This proposal impacts all current and future stakeholders in the Helium
Community.

# Construction
[construction]: #construction

We propose that each DNP operates as its own subDAO within the broader Helium
DAO, while both DAOs exist on a single base L1 chain. Each DNP has its own
economic and governance layer through its subDAO, which comprises all DNT
holders.

![subdaos][subdaos]

All subDAO specific addresses across all DNPs on the network will live on this
L1 chain. All tokens exist on the L1 chain. The L2 is for calculation and
computation purposes only.

New DNPs are added to the network through Helium Improvement Proposals with HNT 
denominated voting as per governance by token lock standards defined in HIP 51.

Before we can define the DNP specific economic structures, we need to outline
how the rewards are split between DNPs and how to fund the earliest stages of
development for new DNPs.

## Proof-of-Coverage Incentive Model for HIP 51

### Background

Currently, under HIP-27, non-LoRaWAN gateways are only rewarded based on data
transfer and those rewards are based on the 1 DC burn = 1 DC equivalent earning
principle laid out in HIP-10. That reward bucket is currently, as of January
2022, limited to 35% of total HNT issuance per epoch. Any HNT from that bucket
that is not allocated to Data Transfer rewards is reallocated to LoRaWAN PoC
rewards.

**We propose two significant changes to the reward buckets**

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
“Proof-of-Coverage” rewards above.

### 2. Split PoC rewards between wireless protocols based on a quadratic equation that accounts for DCs burned and active devices per DNP

The success of the Helium network is contingent on its ability to find real
world applications that burn data credits via data transfer activity. Therefore,
the incentive model should be designed in a way that promotes wireless network
protocols (DNPs) that accomplish that goal. Additionally, the scale of each DNPs
participation network should also be taken into account, so as not to overly
disadvantage early protocols with lower DC burn rates. To accomplish this
propose the quadratic equation below:

Each protocol would be assigned a ‘score’ per epoch:

![\textup{Protocol Score} = \sqrt\textup{{DNP DCs Burned}} * {\sqrt[4]{\textup{DNP Active Device Count} * \textup{Unit DC Onboarding Cost}}} *](https://latex.codecogs.com/gif.latex?%5Ctextup%7BProtocol%20Score%7D%20%3D%20%5Csqrt%5Ctextup%7B%7BDNP%20DCs%20Burned%7D%7D%20*%20%7B%5Csqrt%5B4%5D%7B%5Ctextup%7BDNP%20Active%20Device%20Count%7D%20*%20%5Ctextup%7BUnit%20DC%20Onboarding%20Cost%7D%7D%7D)

Once each protocol has a score, the % of total Epoch PoC rewards assigned to
each DNP will be assessed by comparing the individual score to the sum of all
scores:

![\textup{Percentage of POC Rewards per DNP} = \frac{\textup{DNP Specific Score}}{\sum (\textup{All DNP Scores})}](https://latex.codecogs.com/png.image?\dpi{110}%20\textup{Percentage%20of%20POC%20Rewards%20per%20DNP}%20=%20\frac{\textup{DNP%20Specific%20Score}}{\sum%20(\textup{All%20DNP%20Scores})})

To put this into context, if you have two networks with 50,000 and 500,000 devices each, the smaller network would need approximately 3.16 o r (10^(¼))^2 times the DC burn to have a comparable protocol score to the larger network. 

Most importantly, this model gives us a framework to add new DNPs in the future
without having to design reward splits on an ad-hoc basis.

### 3. Implement a ‘cold start’ bucket to help fund early stage networks that don’t yet have meaningful DC burn

The Lorawan protocol on Helium benefitted from having a built in ‘cold start’
reward system via PoC rewards to help fund the growth of the network. Under the
new model, a network that doesn’t have any DC burn would not have any way of
rewarding it’s early users, so we are proposing a 10% ‘cold start’ reward bucket
that is carved out from the combined PoC/data rewards bucket. Under this system,
any DNP that has been live for sub 1 million blocks (approximately 2 years)
would evenly split 10% of all HNT rewards. Additionally, if a specific DNP had
enough devices or was burning enough DCs to receive 10% of the larger PoC/data
rewards bucket, it would be excluded from the ‘cold start’ rewards bucket.

If no DNP ‘qualifies’ for the cold start bucket, those rewards would be
reallocated to the regular PoC/data reward bucket.

## Definitions and calculations for Omni-Protocol PoC incentive model

- **DC burn used in PoC split calculation**: DC burn is not limited to data
  transfers per DNP. The calculation also includes fees associated with other
  actions, including, but not limited to, gateway assertions, token transfers,
  and gateway relocation fees.

- **Decentralized Network Protocol (DNP)**: Wireless network type is a computer
  network that uses wireless data connections between network nodes and utilizes
  a uniform, standard set of rules that determine how data is transmitted
  between different devices in the same network. (i.e. LoRaWan, 5G, Wi-Fi,
  NB-IoT etc. all different Decentralized Network Protocols).

- **Frequency of PoC reward split recalculation**: Manually adjusted on a
  frequency at the discretion of DeWi unless and until an auto recalculation
  feature is built into the protocol

- **Active Device**: Active devices are the subDAO's definition of devices
  creating valid coverage during the epoch

## Programmatic Treasury Specification

DNT are issued against a Programmatic Treasury with issuance, redemption, and
transaction fee parameters set by DNT governance. Each DNT can set the shape of the curve which governs its programmatic treasury.

We suggest that all DNT Programmatic Treasurys take the shape P = S^k where k > 1, P
represents Price, and S represents Supply. The quote currency is the DNT and the
base currency is HNT.

For a given amount of HNT deposited to or withdrawn from a given DNP bonding
curve, the increase or decrease in supply and price is given by resulting change
in the area under the curve. The integral is given by

![\int_{S_a}^{S_b} S^k = \frac{1}{k+1} (S_b^{k+1} - S_a^{k+1})](https://latex.codecogs.com/svg.image?\int_{S_a}^{S_b}&space;S^k&space;=&space;\frac{1}{k&plus;1}&space;(S_b^{k&plus;1}&space;-&space;S_a^{k&plus;1}))

The shape of the curve for k only slightly larger than 1 is as follows

![Programmatic Treasury][bonding-curve]

It is \textbf{critical to note that the programmatic treasury proposed is one-way for all network stakeholders other than the HNT minting contract at the L1}. This implies that inflows into a given subDAO’s programmatic treasury are only possible through epochal HNT emissions, and no other participant can deposit HNT into the curve. TokenDNT holders can, however, withdraw from the curve at any time.

Since DNTs are fungible assets that can be listed on secondary markets, miners will have multiple sources of liquidity for their earned tokens at any time. This mechanism ensures that miners receive a steady, predictable stream of revenues as per the shape of the programmatic treasury instead of being subject to compounding forms of market risk through speculation driven inflows into the curve. 


## Rewards Distribution Mechanism

We provide an end-to-end description of data transfer, Proof-of-Coverage, and
consensus rewards for a given DNP under the Helium Network.

*Data Transfer Process*

For each DNP, we propose that a device looking to receive coverage across the
network purchase Data Credits by **purchasing and burning HNT**.

The device **subsequently burns those Data Credits** in the name of the Hotspot
or set of Hotspots once data has been transferred.

The device then **relays the receipt of this transaction** to the set of
Validators for the DNP.

The DNP Validator set then **relays this information to the HNT emissions
contract** in order to determine the HNT amount to be distributed to the DNP
subDAO for all rewards distribution.

At the end of each epoch, the **DNP Validator set prepares the distribution for
mining rewards** denominated in the DNT to each Hotspot based on coverage
provided.

*Proof-of-Coverage Process*

The DNP subDAO defines the rules for Proof-of-Coverage challenges. In a given
epoch, Challengers, Challenges, and Witnesses **relay the results of challenges
to the DNP Validator set** in order to distribute Proof-of-Coverage rewards
denominated in DNT to relevant devices.

*Consensus Process*

The DNP subDAO defines the rules for consensus, and **distributes a portion of
DNT emissions in a given epoch for DNP Validators.**

![subDAO governance][subdao-governance]

*Emissions Calculation*

At the end of a given epoch, the HNT emissions contract **performs a tally of
the data credits transferred across DNPs**. The emissions contract subsequently
distributes the determined amount of HNT to a **DNP subDAO multi-signature
wallet**, the addresses of which comprise the set of Validators of that DNP.

*DNT Issuance*

Each DNP DAO then **submits the entire amount of HNT into its Programmatic Treasury** in
order to mint new DNT for Hotspots and Validators participating in data transfer
and Proof-of-Coverage.

In a given epoch, if the DNP Hotspots were to receive some amount of HNT from
the Helium DAO, the DNP subDAO multi-signature wallet distributes a
**corresponding amount of newly minted DNT of equal market value** as per the
Programmatic Treasury to the Hotspots in its network based on its mining rules.

*Note that all new issuance in the DNP Programmatic Treasury through HNT emissions are
distributed to Hotspots and Validators.*

*DNT Issuance*

If a given address wishes to redeem their DNT, they can **“sell” against the
Programmatic Treasury** to receive the market rate of underlying HNT.

The transaction involves sending the required amount of DNT tokens to a **burn
address**, and receiving the determined amount of HNT tokens from the **DNP
subDAO multi-signature wallet**.

The address **relays the message of the sale to the set of DNP Validators**,
which then adjust the position of the Programmatic Treasury in the following epoch after
adjusting for all other sales and any new issuance.

*Transaction Fee*

A DNP **subDAO governed transaction fee** is placed on redemption
of DNT tokens on the Programmatic Treasury. This fee is charged in HNT and we suggest
starting it at 0.3% of all transactions. This HNT fee is immediately submitted
to the DNT Programmatic Treasury.

For example in a given epoch, if the 5G Programmatic Treasury had trading volume of
100,000 HNT and brought in 300 HNT worth of transaction fees, that 300 HNT is
resubmitted to the Treasury increasing the price of DNT according to the equation.

## *Fair-Launch Mechanism*

The Programmatic Treasury mechanism is susceptible to bot frontrunning. We borrow from
[Strata protocol’s fair launch mechanism][strata] to ensure that early
participants in any DNP DAO are protected from this attack vector.

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
   are usable across any DNP.
2. Mining rewards for Hotspot in a given DNP are distributed in the
   corresponding DNT
3. DNTs can be traded on secondary markets but are redeemable for HNT as per the
   primary market defined by its Programmatic Treasury. New DNTs can be minted by
   depositing HNT into the Programmatic Treasurys as well.
4. Each DNP can set their own DNT emission schedule and distribution.

# Open Questions

1. What does a migration process look like for the existing implementation onto
   the new structure outlined?
2. What governance procedure should be used to whitelist specific DNP DAOs?

[hip27]: https://github.com/helium/HIP/blob/master/0027-cbrs-5g-support.md
[hip37]: https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md
[hip52]: https://docs.google.com/document/d/1fqy3JLdoP8YgOULx-sE_24xOL1UL9esHu_Ctju4iGcg/edit
[hip53]: https://docs.google.com/document/d/1rg9VK28S8bWOeKNiKXUipsLsBxLjuHH7AnVe6TjKw4I/edit
[subdaos]: https://lh4.googleusercontent.com/KYORnsFb3X0X42t64FscUArcDZBjXyopik_AaZTN7tLvxYRL5-s1nvd1WY3X4vJA5mWe1_XN_miwDoRXhU70YV_txsO5Y_mWFbVrx6byNinT--khit2AEAYl4GMO0Vm_lL49BB05
[existing-reward-curve]: https://lh4.googleusercontent.com/aCKlXePHuivkp8IFK5-VLifO-xw8WKOpArn9OCiobOW0WjpHcPBtogNqvDBLofH8q4lcMFtnP0XZZlGq3v247AA3Syqq6RKK0Pr6-_xKjv4DTPmmbSAJ5XIrSNaLHt9Y3py8My_v
[bonding-curve]: https://lh3.googleusercontent.com/9BO0qb90HKiWDHreSWemmZhEmjSiPKJKsiEi1lMENNzV2StUtx1qiwYFPg5NDR4JZux5YgmL_ia99yjgY0O1-QUbnjvDo0qgq8G0TJTWq53AAF8XNI4xaYKKBjqpW2Y5eq7NbvuS
[subdao-governance]: https://lh3.googleusercontent.com/VIycvHCtq1nZtXyAC8haZw6xF1sBHcs8GVRPFX3-lAFtsR-HflGQyGUc7tAjs8R4VPS7HP_5A0rJRsAr_G0kiOZJSxM80t3_ukgdutd15XdQerDkrx0IZH27BJjQRbLP2oVQjZ8_
[strata]: https://www.strataprotocol.com/docs/learn/fair_launch
[fair-launch-graph]: https://lh4.googleuserco
