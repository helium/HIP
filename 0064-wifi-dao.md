# HIP 64: Helium WiFi subDAO

- Authors: Karam Lakshman, Shubhendu Sharma,[@tjain-mcc](https://github.com/tjain-mcc),
  [@shayons297](https://github.com/shayons297)
- Start Date: 2022-06-01
- Category: Economic, Technical
- Original PR: <https://github.com/helium/HIP/pull/420>
- Tracking Issue: <https://github.com/helium/HIP/issues/424>

![https://lh6.googleusercontent.com/KStfb4K7ODMe4EmsovQbrzkzm7gp7YI30dw5-Y5RRsGksHyD-rg-FHgEDrC7V5ISRbHRdD7SoHOVqZ1uylbJMJf6SDtBG-bcRCNe2jjj22VBjFLMGerSJIhgUNlFAqe8GWvTDT4FeWXgwTGMNA](https://lh6.googleusercontent.com/KStfb4K7ODMe4EmsovQbrzkzm7gp7YI30dw5-Y5RRsGksHyD-rg-FHgEDrC7V5ISRbHRdD7SoHOVqZ1uylbJMJf6SDtBG-bcRCNe2jjj22VBjFLMGerSJIhgUNlFAqe8GWvTDT4FeWXgwTGMNA)

# Summary

[HIP 51: Helium DAO](https://github.com/helium/HIP/blob/main/0051-helium-dao.md) provides a general
structure for onboarding new Decentralized Network Protocols (DNPs) to the broader Helium Network.

In this proposal, we describe the structure for the Helium WiFi subDAO, also henceforth referred to
as WiFi subDAO. The aim of the WiFi SubDAO is to bring online Wifi routers to the Helium Network.
The subDAO token is proposed to be named HWIFI.

Wifi is one of the most widely used network protocols for large amounts of data consumption. It has
a high level of penetration in developed nations worldwide and has ample room to grow in developing
nations. Upcoming Wifi standards provide a roadmap for greater data transfer rates paving the way
for even higher rates of consumption as new applications take advantage of new bandwidth.

Today all WiFi networks operate as siloed and independent Hotspots. A user cannot easily roam from
one Hotspot to another. The WiFi subDAO proposes a structure whereby WiFi Hotspots can be brought
onto the Helium network thereby incentivizing the creation of a common global WiFi network that
allows for greater user access and roaming capabilities.

[HIP 53: Mobile DAO](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) proposes an offload
use case for WiFi along with its 5G implementation, wherein cellular traffic is offloaded to WiFi
Hotspots. In this proposal we expand the focus of WiFi beyond offload and to direct data consumption
from consumers and devices. Users will be able to connect to and use the Helium WiFi network just as
they use any other WiFi network but with the added benefits of roaming and using a single data
credit system across the entire network globally. Users or devices on the Mobile DAO will also be
able to roam onto Hotspots from the WiFi subDAO seamlessly.

# Stakeholders

This proposal impacts all current and future participants in the Helium Community.

# WiFi SubDao core functions

We propose to inherit the same core structure from
[HIP 53: Mobile subDAO](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md).

1. **Emissions Curve**The WiFi subDAO is responsible for all emissions, mining rewards, and
   programmatic treasury operations. The economic responsibilities around this involve managing the
   token issuance and distribution.
2. **The Treasury** The WiFi SubDao provides the prices at which the subDAO treasury provides quotes
   to holders of HWIFI who wish to redeem their holdings for underlying HNT.
3. **Oracle Specification** Oracles perform work including verifying proof of coverage and data
   transfer. The oracles are also responsible for distributing HWIFI mining rewards to the
   appropriate parties. Responsibilities here include definition of oracle software, minimum stake
   amounts, and rewards for participation.
4. **Data Transfer Mechanism and Pricing** Data transfer within subnetworks occurs via the process
   of procuring and burning data credits in the name of the Hotspot or set of Hotspots that provide
   coverage. Responsibilities here include Organizationally Unique Identifier (OUI) registration,
   state channel creation, and bandwidth capacity per data credit definition.
5. **Proof-of-Coverage Mechanism** The WiFi SubDao will use a Proof of Coverage algorithm to verify
   on an ongoing basis that Hotspots are accurately representing their location and the wireless
   network coverage they are creating from that location. Responsibilities here include
   Proof-of-Coverage challenge construction, target selection, reward scaling, and verification.
6. **Network participants** The types of network & economic participants on the WiFi SubDao will
   initially be largely the same as those of the
   [HIP 53: Mobile subDAO](https://docs.google.com/document/u/1/d/1WvldI9gyhuouK2o2nquvIZaFK3dSfQIePRx5M5ssu9g/edit).

The remainder of this proposal defines initial values for the subDAO given the aforementioned set of
responsibilities.

### Emissions Curve

There will be a max supply of 250B HWIFI.

The proposal is to have halvenings of HWIFI issuance every 2 years aligned with the HNT issuance
halvenings. This requires a 1 year “stub” period from August 1, 2022 to August 1, 2023.

We also propose that 50B HWIFI are pre-mined at the launch of the network, and distributed to the
subDAO operations fund administered by WiFi subDAO. This allocation is distributed over the course
of the stub period to live WiFi Hotspots on an epochal basis in roughly equal proportion (akin to
universal basic income).

For clarity, the emission schedule is as follows:

| Year | HWIFI at the start of the year | HWIFI minted | Hotspot PoC | Hotspot Data (excess to PoC) | Mappers | Service Providers | Oracles | veHNT Stakers |
| ---- | ------------------------------ | ------------ | ----------- | ---------------------------- | ------- | ----------------- | ------- | ------------- |
| 1    | 50B                            | 116B\*       | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |
| 2    | 116B                           | 33B          | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |
| 3    | 1495B                          | 33B          | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |
| 4    | 182B                           | 16.5B        | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |
| 5    | 198.5B                         | 16.5B        | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |
| 6    | 215B                           | 8.25B        | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |
| 7    | 223.25B                        | 8.25B        | 20%         | 40%                          | 10%     | 20%               | 4%      | 6%            |

\*50B pre-mine, 66B emitted in year 1

At the end of a given epoch, WiFi subDAO oracles relay start balance, current balance, and total
amount of HWIFI Data Credits created and relay to the L1 HNT emissions contract. The emissions
contract subsequently distributes the determined amount of HNT as per the Protocol Score to the WiFi
subDAO multi-signature wallet, the addresses of which comprise the set of oracles of the WiFi
Network.

The subDAO operations fund is intended to allow the DNP to perform bespoke operations to create and
sustain network growth. The primary use case of the operations fund is to fund all state transition
transaction fees to the L1, but can be deployed in any manner of ways as per subDAO governance. Such
incentives could include

1. Surge-pricing style dynamic multipliers based on data transfer activity for individual regions
2. Bespoke incentives for oracles and manufacturers on the basis of changing network demands

Once emissions are distributed to Hotspots and oracles, HWIFI owners can either redeem their
holdings for underlying HNT against the treasury reserve automatically, hold for redemptions at a
later time, or lock up their HWIFI for veHWIFI in a process similar to the veHNT mechanism described
in HIP 51.

Users can choose to delegate their veHWIFI for three core purposes:

1. Stakeholder staking to specific Hotspots or service providers.
2. Oracle delegation in order to earn future emissions.
3. Governance participation in subDAO proposals for core matters.

We propose to use a points and incentive structure largely similar to
[HIP 53: Mobile DAO](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md)

### Treasury Reserve DNT Market Making Curve

The subDAO sets the programmatic treasury formula in order to provide quotes to holders of HWIFI who
wish to redeem their holdings for underlying HNT. The programmatic treasury defines the floor price
for HWIFI, but holders always retain the ability to exchange at the prevailing rate on open markets.

![https://lh3.googleusercontent.com/XNJECOJF0YU9p4ywoVOjhHuqbL0Uw_u5WyvVTDsCajRFAGHb4SfFUtFOygRuCB6-5l5J89E0-Jon_470OeUjc_sbd00zPBjNLe4hoZgzmWe-BlDqKzvhWdTM1vHG4eEIqlD5Um4Meyc_2Ajwyw](https://lh3.googleusercontent.com/XNJECOJF0YU9p4ywoVOjhHuqbL0Uw_u5WyvVTDsCajRFAGHb4SfFUtFOygRuCB6-5l5J89E0-Jon_470OeUjc_sbd00zPBjNLe4hoZgzmWe-BlDqKzvhWdTM1vHG4eEIqlD5Um4Meyc_2Ajwyw)

### Oracle Operations

WiFi SubDao oracles confirm proof of coverage, data transfer, and add blocks to the WD subnetwork.
They serve state data around Proof-of-Coverage challenges and data transfer events to Hotspots.

Validation is performed by a set of rotating nodes known as the consensus group, which verifies
transactions and ordering prior to forming a block and proposing it to the L2 chain. Consensus
groups are elected once per epoch, and the number of members is given by the num_consensus_members
chain variable.

At launch, a single oracle operated by the WiFi SubDao validates data transfer and proof-of-coverage
across the network. Over time, new oracles join the network while the subDAO defines consensus rules
for the underlying protocol.

At the end of each epoch, mining rewards are distributed by the consensus group to the wallet
addresses that have earned them.

Each one of the above activities is recorded in a block using the reward transaction. At the
completion of each epoch, all the individual reward transactions are grouped in a rewards
transaction at which point all HNT mined in that epoch are distributed.

### Proof-of-Coverage Specification

The WiFi SubDao is required to constantly interrogate Hotspots using the Proof-of-Coverage challenge
mechanism to ensure that Hotspots are representing their locations and uptime accurately. The net
results of each of these challenges are relayed to the Helium L1 after being validated by their
respective consensus groups.

For WiFi SubDao we propose to separate the challenge and witness functions between the operator of a
Hotspot and a mapper device (such as a phone or a dedicated mapper) with an application that has
been authorized to perform the witness function. This approach is largely similar to the Mobile DAO
with a key difference being the usage of an application provided by the subDAO rather than a SIM for
authentication since WiFi devices do not need SIM cards in order to access the network.

Any device (first and foremost a phone) with the proper application can be a witnessing device on
the network. To witness coverage a “mapper phone” must connect to a Hotspot using an application
that has been granted mapping privileges by the service provider. Service providers will act as
“validators of witness transactions” performed by mappers by authenticating mappers.

During initial launch stages, when network density is low, to combat gaming, the WiFi SubDao will
implement a simple limiting algorithm:

1. Same mapper can witness the same Hotspot no more than once every 4 hours
2. Same cell can be witnessed by a maximum of 6 unique mappers every hour

During consequent launch stages, as the density of mappers grows, WiFi SubDao will look to implement
a more robust algorithm, similar to Helium LoRa PoC, whereby only randomly challenged Hotspots can
be witnessed. We also propose that some of the HWIFI that are pre-mined at the launch of the
network, and distributed to the subDAO operations fund is distributed over the course of the stub
period to live Hotspots on an epochal basis in roughly equal proportion (akin to universal basic
income).

### Data Transfer and Pricing Specification

Data Credits are utilized in asserting new Hotspots and their location on the chain, registering
OUIs and associated devices, and as payment for packet transfers. We propose 1GB of data at $0.01 as
the initial value price consumers will pay to access the Wifi network. We propose to use a similar
pricing mechanism defined as per
[HIP 53: Mobile subDAO](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md).

WiFi SubDao will operate a chain variable that will dictate the conversion ratio between Data
Credits and WD tokens, denominated in oracle USD price. Changes to the conversion ratios will be
conducted following Sub DAO governance specification

### Governance Specification

# The WiFi network is under the control of the subDAO. All subDAO proposals must come attached with code to be approved

We propose that veHWIFI governance is constructed in a manner largely identical to veMOBILE
governance as specified in
[HIP 51: Helium DAO](https://github.com/helium/HIP/blob/main/0051-helium-dao.md).

Users can choose to delegate their lockup power in veHWIFI to all subDAO governance proposals.
Proposals are assessed using majority and quorum thresholds defined in veHWIFI terms. Note that only
proposals with code attached can be voted on.

_Activation fee_

An activation fee of $10 will be applied to wifi Hotspot hosts when activating their devices on the
network.

_Network participants_

There are a number of real world physical entities that comprise the network and perform the
following functional and economic roles:

| Name             | Functional Role                                                                                                                                                                                                                                                                                     | Economic Role                                                                                                                        |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Subscriber       | Uses the network                                                                                                                                                                                                                                                                                    | Pays service providers to access data on the network                                                                                 |
| Mapper           | Runs a network mapping app on the phone or uses a dedicated mapper device to verify coverage provided by the Hotspot hosts. Mappers are required to be a subscriber.                                                                                                                                | Receives HWIFI mining rewards for mapping networking coverage                                                                        |
| Service Provider | Promotes network service to subscribers and mappers Runs subscriber database and authenticates inbound subscribers and mappers into the network Records data transfer transactions to state channels Maintains their flavor of the witnessing app Responds to subscriber and mapper support queries | Receives payments for data access from subscribers and mappers Burns HNT into Data Credits and settles data usage with Hotspot hosts |
| Hotspot Host     | Operates a wifi Hotspot and pays for backhaul.                                                                                                                                                                                                                                                      | Receives HWIFI mining rewards for providing coverage Receives HWIFI mining rewards for providing data access to subscribers          |
| Oracles          | Relay data to L1 emission contract Calculate incentive points for service providers and mappers                                                                                                                                                                                                     | Stake HWIFI Receive % of rewards from emissions contract                                                                             |
| Hotspot Vendor   | Builds and sells Hotspots Supports Hotspot hosts Runs software to provide updates of Hotspots Maintain integrations with service providers                                                                                                                                                          | Stakes HWIFI Receive % of rewards mined by Hotspot hosts                                                                             |

![https://lh3.googleusercontent.com/G2Ii7fH3R81A7ff69C3MxvdX-1ROtEOc_LiHQhcjTpsIirIKsLomKEvufhCRB2mEd7gzeFIibUP_Qq0ssIp-j_GU4BKMxDKahd6Lyo67o0ya4iNJcTVtt77bb1A8zR0vlUjGnCK9EG06V0cEgQ](https://lh3.googleusercontent.com/G2Ii7fH3R81A7ff69C3MxvdX-1ROtEOc_LiHQhcjTpsIirIKsLomKEvufhCRB2mEd7gzeFIibUP_Qq0ssIp-j_GU4BKMxDKahd6Lyo67o0ya4iNJcTVtt77bb1A8zR0vlUjGnCK9EG06V0cEgQ)

Rewards from the emissions contract are distributed between service providers, mappers and Hotspot
hosts as a function of the incentive points earned during a period of time. Service providers are
allowed (and encouraged) to use the pool of HWIFI emissions they get towards growing their
subscriber base by either sharing HWIFI directly with subscribers for usage via a witnessing app or
discounting data plans.

Reward calculations that trigger distribution of tokens between service providers, mappers and
Hotspot operators in the WiFi SubDao are performed by Oracles. Oracles continuously witness a stream
of events coming from various DAO participants (such as mapper/Hotspot events, data offload events,
etc.) and perform reward distribution calculation. At the end of an epoch, Oracles come to consensus
on proper distribution of HWIFI based on events witnessed during the last epoch.

**Appendix**

_Market landscape_

It's useful to think of the market for Helium WiFi in two halves. The first half is developed
nations like the US, UK, Japan, etc. where broadband internet penetration is greater than 80% and as
a result there are tens of millions of WiFi routers already in use. The second half is developing
nations like India, Brazil, Indonesia, etc where broadband internet penetration is still at single
digits - India for example is at a lowly 7% with only about 20 million broadband internet
connections.

In order to deploy a planet scale WiFi network, the subDAO has to offer a compelling proposition for
consumers with existing WiFi routers to upgrade to a Helium compatible Hotspot and at the same time
deploy new Hotspots along with underlying broadband infrastructure in growth markets like India.

The WiFi subDAO offers consumers with existing broadband connections or WiFi routers a number of
compelling reasons to upgrade their Hotspots:

1. Lower the cost of their existing internet connection by using the rewards earned by providing
   proof of coverage and helping the network grow.
2. Expand range of their existing WiFi network by connecting an additional Helium compatible WiFi
   Hotspot.
3. Providing public wifi access at a location that requires broader access like stores, restaurants,
   venues, educational institutions, etc.
4. Extend their existing LoRaWAN or 5G Helium portfolio with WiFi.

The Wifi subDAO offers service providers in developing markets compelling incentives as well:

1. Access to capital from the Helium community to deploy networks.
2. Low cost hardware stack for city scale broadband networks.
3. Additional revenue through the tokenomics of HNT and the subDAO.
4. L2 software stack to simplify authentication, access and accounting.
5. Higher network utilization as users and devices can roam across the network.

_Wifi Dabba - Launch service provider & Hotspot vendor_

[Wifi Dabba](https://www.wifidabba.com/) was founded in 2017 with a mission to bring a billion
Indians online with super fast, super cheap broadband internet. Wifi Dabba uses lasers instead of
expensive underground fiber to dramatically lower the cost of deploying city scale broadband
infrastructure.

Wifi Dabba lasers are mounted on rooftops and telecom towers across a city to form a core network
backbone that can serve millions of Hotspots. Fiber optic cable is used for last mile connectivity
wherein cables are drawn from the nearest laser to the consumer’s premises. Low cost commodity WiFi
routers running custom firmware are provided to customers that create a WiFi mesh system allowing
users to roam across the network with ease.

Wifi Dabba is building an “ISP in a box” system that is affordable and accessible and can be used by
anyone, almost anywhere in the world, to deploy a city scale broadband network in a matter of a few
months compared with traditional broadband networks that take years to deploy. This low cost
deployment system results in broadband connectivity for consumers at a price anyone can afford.

Wifi Dabba intends to provide plug and play Helium compatible WiFi routers for consumers with
existing broadband connections and the ISP in a box system for service providers.

![https://lh3.googleusercontent.com/yKGsecOPqXDdF70cLN2MfDJlPz_PwgSDnvrsqdUw4p60Htm4PvBeLwLkgIyJCAt5vs5O0C2LZ3k6eMJGKKbWJZJZSSWQ8PqIXZAAPHa1Qs2OoV0UPaU8P0Wa2jTW6g2vrrNNp66qrnRB1sD0OQ](https://lh3.googleusercontent.com/yKGsecOPqXDdF70cLN2MfDJlPz_PwgSDnvrsqdUw4p60Htm4PvBeLwLkgIyJCAt5vs5O0C2LZ3k6eMJGKKbWJZJZSSWQ8PqIXZAAPHa1Qs2OoV0UPaU8P0Wa2jTW6g2vrrNNp66qrnRB1sD0OQ)
