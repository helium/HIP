# HIP 52: LoRaWAN subDAO

- Authors: [@tjain-mcc](https://github.com/tjain-mcc), Shayon
- Start Date: 2022-01-04
- Category: Economic, Technical
- Original PR: https://github.com/helium/HIP/pull/335
- Tracking Issue: https://github.com/helium/HIP/issues/338
- Status: Draft

# Summary
[summary]: #summary

This proposal includes a specification of the LoRaWAN Wireless Network Protocol
as per the DAO model and L2 implementation outlined in [HIP 51][hip51].

In HIP 51, we provide a general structure for onboarding new WNPs to the broader
Helium Network, with mechanisms in place to ensure that protocol-specific
attributes such as Proof-of-Coverage rules, data credits pricing, and block
validation are within control of the emergent WNT DAO.

In this proposal, we specify the implementation of the structure proposed
through a detailed onboarding proposal for the LoRaWAN Network. We propose
initial configurations of the LoRaWAN economics layer as well as governance
mechanisms within the DAO through LoRaWAN (LRW) token voting.

# Stakeholders
[stakeholders]: #stakeholders

This proposal impacts all current and future participants in the Helium LoRaWAN
Community.

# Detailed Description
[detailed-description]: #detailed-description

We proposed in HIP 51 that each WNP subDAO operate as a sovereign economics and
governance layer. The LoRaWAN subDAO has five core functions

1. *Economics*: The LoRaWAN subDAO handles all bonding curve operations, and by
   extension all LRW emissions to hotspots and purchases or sales from
   third-parties. The economic responsibilities around this involve parameter
   selection for the curve and all associated fees, as well as liquidity risk
   management.

2. *Validator Operations*: LoRaWAN Validators perform consensus group work
   including verifying Proof-of-Coverage and adding new blocks to the Lorawan L2
   chain. Responsibilities here include definition of Validator software,
   minimum stake amounts, and rewards for participation.

3. *Proof-of-Coverage Mechanisms*: The LoRaWAN network utilizes a Proof of
   Coverage work algorithm to verify on an ongoing basis that hotspots are
   accurately representing their location and the wireless network coverage they
   are creating from that location. Responsibilities here include
   Proof-of-Coverage challenge construction, target selection, reward scaling,
   and verification.

4. *Data Transfer Mechanism and Pricing*: Data transfer across the LoRaWAN
   network occurs via the process of procuring and burning data credits in the
   name of the hotspot or set of hotspots that provide coverage.
   Responsibilities here include Organizationally Unique Identifier (OUI)
   registration, state channel creation, and bandwidth capacity per data credit
   definition.

5. *Governance*: The LoRaWAN subDAO retains full control over all components of
   the network, and DAO members can propose and vote for changes to core
   parameters and mechanisms. Responsibilities here include specification of a
   formal on-chain voting process that is resistant to attacks.

The remainder of this proposal defines initial values for the subDAO given the
aforementioned set of responsibilities.

## Economics Specification

In the notation provided below, P represents Price and S represents Supply. The
quote currency is LRW (LoRaWAN Token) and the base currency is HNT (Helium
Token).

We propose that the LoRaWAN bonding curves take the following shape:

![P = S^{1.1} \times
10^{-8}](https://latex.codecogs.com/png.image?\dpi{110}%20P%20=%20S^{1.1}%20\times%2010^{-8})

For a given amount of HNT deposited to or withdrawn from the LoRaWAN bonding
curve, the increase or decrease in LRW supply and price is given by resulting
change in the area under the curve. The integral is given by

![\int_{S_a}^{S_b} S^{1.1}\times 10^{-8} = \frac{1}{2.1\times10^8}(S_b^{2.1} -
S_a^{2.1})](https://latex.codecogs.com/png.image?\dpi{110}%20\int_{S_a}^{S_b}%20S^{1.1}\times%2010^{-8}%20=%20\frac{1}{2.1\times10^8}(S_b^{2.1}%20-%20S_a^{2.1}))

The curve looks as follows:

![lrw token price][lrw-token-price]

For an approximation of this curve in terms of HNT deposited and issuance of
newly minted LRW tokens, the following table and graph are helpful:

**[TODO table goes here]**

![lrw token supply][lrw-token-supply]

At the end of a given epoch, the L1 HNT emissions contract performs a tally of
the data credits transferred across the LoRaWAN Network. The emissions contract
subsequently distributes the determined amount of HNT to the LoRaWAN subDAO
multi-signature wallet, the addresses of which comprise the set of Validators of
the LoRaWAN Network.

For more background on interpreting bonding curves, [Strata protocol
documentation](https://www.strataprotocol.com/docs/learn/bonding_curves) is
extremely instructive.

## Validator Operations

LoRaWAN Validators confirm transactions and add blocks to the Lorawan L2 chain.
They serve state data around Proof-of-Coverage challenges and data transfer
events to light and data only hotspots.

Validation is performed by a set of rotating nodes known as the consensus group,
which verifies transactions and ordering prior to forming a block and proposing
it to the L2 chain. Consensus groups are elected once per epoch, and the number
of members is given by the num_consensus_members chain variable (currently set
at 40).

The Helium Consensus Protocol is based on a variant of the HoneyBadgerBFT
(HBBFT) protocol. HBBFT is based on a body of research originally kicked off by
Andrew Miller and the team at the University of Illinois, Urbana-Champaign.

HBBFT is an asynchronous atomic broadcast protocol designed to enable a group of
known nodes to achieve consensus over unreliable links. In Helium’s
implementation, a consensus group of [elected Validators][elected-validators]
receives encrypted transactions as inputs and proceeds to reach common agreement
on the ordering of these transactions before forming a block and adding it to
the blockchain.

HBBFT relies on a scheme known as threshold encryption. Using this scheme,
transactions are encrypted using a shared public key, and are only decryptable
when the elected consensus group works together to decrypt them. The usage of
threshold encryption enables the Helium Consensus Protocol to achieve
censorship-resistant transactions.

At the end of each epoch, mining rewards are distributed by the consensus group
to the wallet addresses that have earned them.

Each one of the above activities is recorded in a block using the reward
transaction. At the completion of each epoch, all the individual reward
transactions are grouped in a rewards transaction at which point all HNT mined
in that epoch are distributed.

## Proof-of-Coverage Specification

The LoRaWAN subDAO is required to constantly interrogate hotspots using the
Proof-of-Coverage challenge mechanism to ensure that hotspots are representing
their locations accurately. The net results of each of these challenges are
relayed to the Helium L1 after being validated by their respective consensus
groups.

LoRaWAN Challenges involve three distinct roles:

1. Challenger - The Hotspot that constructs and issues the POC Challenge.
   Hotspots issue challenges approximately once per every 360 blocks. We propose
   moving this role to LoRaWAN Validators.
2. Transmitter - Sometimes called "Challengee". This Hotspot is the target of
   the POC challenge and is responsible for transmitting (or "beaconing")
   challenge packets to potentially be witnessed by geographically proximate
   Hotspots.
3. Witness - Hotspots that are geographically proximate to the Transmitter and
   report the existence of the challenge packet after it has been transmitted.

HIP 15 and 17 defined rules for scaling rewards to hotspots based on placement
as per target density of hotspots in a given geographic area as well as number
of witnesses to challenges participated in.

Once the Challenger has the complete set of receipts from the POC Witnesses and
Transmitter, or the elapsed time since the challenge was issued has passed the
upper time bound, the POC Challenge is considered complete. At this point, the
Challenger then submits the proof receipt as a transaction to the blockchain to
be verified by the current consensus group. Because the steps taken by the
Challenger to construct and complete the proof are deterministic and easily
reproduced, members of the consensus group can verify the legitimacy of the
proof. Specifically the Challenger reveals the secret ephemeral key it used for
both obtaining the original PoC request and for encrypting each layer of the
challenge packet. This crucial information, which has been hidden until the
receipt is published, allows the re-creation of the deterministic entropy.

## Data Transfer and Pricing Specification

Data Credits are utilized in asserting new hotspots and their location on the
chain, registering OUIs and associated devices, and as payment for packet
transfers.

With the activation of [HIP 10][hip10], hotspot operators receive HNT emissions
up to 32.5% per epoch and are rewarded at 1:1 rate based on dollar value of Data
Credits transfers as per the [HNT Price Oracle][oracles]. This proposal scales
Data Credits rewards based on actual activity on the network, and
disincentivizes arbitrageurs from taking advantage of more arbitrary
distribution mechanisms for rewards.

[HIP 37][hip37] proposed the removal of a division between Proof-of-Coverage and
data credits rewards entirely at the date of the second HNT halving (8/1/2023).
We propose this removal happen from the launch of the LoRaWAN subDAO.

We propose that the LoRaWAN DAO distributes LRW in the following proportion
after minting the given number of tokens per epoch if the Notional Value of Data
Credits burned (X% of Hotspot emissions) across the LoRaWAN Network is Less than
Market Value of LRW Tokens Allocated to Hotspots/Validators.

![lrw distribution below market value][lrw-distribution-below-market-value]

We propose that the LoRaWAN DAO distributes LRW in the following proportion
after minting the given number of tokens per epoch if the Notional Value of Data
Credits Transfer across the LoRaWAN Network is Greater than Market Value of LRW
Tokens Allocated to Hotspots.

![lrw distribution above market value][lrw-distribution-above-market-value]

*Note that all manufacturers within the network must stake a minimum of
1,000,000 LRW tokens in order to be whitelisted to receive rewards. If at any
point, a manufacturer gives ownership of maintenance and firmware upgrades to a
third party, all future manufacturer rewards flow to this new entity. The new
hotspot onboarding fee and location assertion fee should remain the same.*

At present, every 24 bytes sent in a packet cost 1 DC, priced at $0.00001. Data
Credits are generated by burning the requisite amount of HNT as per the Helium
price oracle.

The transaction is as follows:

1. A Miner receives a packet and determines who it belongs to
2. The Miner reaches the appropriate Helium LoRaWAN Network Server and offers
   the packet
3. The Helium LoRaWAN Network Server expresses interest in the packet and
   accepts delivery
4. The Miner provides the packet under the promise that the LoRaWAN Network
   Server will “burn a DC” in the name of the Miner

*Note that it is possible to support both metered and unmetered networks. For an
unmetered network, an OUI can choose to pay a fixed rate for an indefinite
period of time which involves the purchase and burn of some number of data
credits per minute, and attribution to hotspots after consumption occurs pro
rata network traffic under the unmetered plan.*

A subDAO governed transaction fee is placed on issuance and redemption of LRW
tokens on the bonding curve. This fee is charged in HNT and we propose starting
it at 0.3% of all transactions. This HNT fee is immediately submitted to the LRW
bonding curve.

*Note that a given WNP subDAO is not necessarily required to distribute the
entirety of HNT it receives into the curve, or distribute the entirety of WNTs
minted in the process to stakeholders. The subDAO can manage and allocate HNT
inflows from the overall network as it sees fit in order to support growth in
bespoke areas through incentives for new stakeholders.*

## Governance Specification

Every aspect of the LoRaWAN Network is under the control of the subDAO. All
subDAO proposals must come attached with code to be approved.

We propose the following governance mechanism borrowed from HIP-41 in order to
impose enough of a cost on voting that only committed participants would vote to
influence the direction of the network, while ensuring that the barrier to entry
is low enough for all small holders to participate should they choose.

The core primitive of this proposal is “voting power”, the unit of support for
either side in a given vote.

Network participants can deposit LRW tokens to a “governance staking contract”,
which are locked and delegated to one or many Validators of their choosing.
Users have control over the number of tokens they choose to stake, and the
period they choose to stake them for.

The minimum lockup period is 250,000 blocks (roughly 87 days) and the maximum
lockup period is 2,500,000 blocks (roughly 870 days). Note that these values can
be changed retroactively via this governance mechanism.

A user’s voting power is determined by 1) the amount of LRW they vote with, and
2) the amount of time they commit to locking up their tokens. The structure
applies a linear multiplier of time to the amount of HNT locked up in the voting
contract. For the maximum amount of 2,500,000 blocks, users receive 50x the
voting power. For the minimum amount of a 250,000 block lockup, users receive 1x
the voting power.

As a simple example, let’s imagine Alice, Bob, and Charlie all have 100 LRW:

1. Alice chooses to lock up her tokens for the minimum required 250,000 blocks,
   and thus her voting power is 100
2. Bob commits to locking up his tokens for 1,375,000 blocks, and thus his
   voting power is 25 * 100 = 2,500
3. Charlie commits to locking up his tokens for 2,500,000 blocks, and thus his
   voting power is 50 * 100 = 5,000

![voting power][voting-power]

As the lockup burns down, so does the voting power. For example, if Charlie
locked up his 100 tokens for 2,500,000 blocks and 1,125,000 blocks have passed
then Charlie would have 2,500 vote power.

Governance proposals can be called to a formal vote with a minimum of 1,000,000
voting power (“vote minimum”), and users will be able to participate in each
vote for a period of 7 days (“voting period”). These thresholds are placed to
mitigate risk of DDoS attacks, but both parameters will be tunable by this same
voting process at any time.

Note that the voting power used to call a vote is eligible to vote, so the user
that calls for a proposal to be voted upon can allocate their stake to either
side. At the end of the voting period, the governance staking contract looks at
how many tokens a voter has and how long they are locked for. Voters can always
extend their lockup period just prior to voting. Locked tokens can vote as many
times as they want, and all earnings from staking are earned by voters as normal
staking rewards.

One of the challenges with the locking mechanism proposed here is that most
participants will wait until the last minute to vote. This is because there is a
cost—namely, giving up liquidity—to vote. As such, if a vote is going someone’s
way, they may not want to participate and lock up tokens.

In order to incentivize honest voting and maximal participation, we propose that
LoRaWAN DAO governance adopt a commit-and-reveal scheme. With this feature,
votes would be submitted in a concealed fashion. Upon the completion of the
voting period, we propose a 3 day reveal period in which voters can review the
results of the vote, including who voted.

Commit-and-reveal can be implemented by having voters hash together their
address, vote, and salt. Once the reveal period begins, voters can reveal their
votes by publishing the unhashed data. If voters don’t reveal their vote before
the reveal period, their vote is not counted.

The result of this should be maximal participation for important decisions
because voters won’t know whether their vote will matter or not.

# Open Questions
[open-questions]: #open-questions

1. What does a migration process look like for the existing implementation onto
   the new structure outlined?

[hip51]: https://github.com/helium/HIP/blob/master/0051-helium-dao.md
[lrw-token-price]: https://lh5.googleusercontent.com/eXGVDYw39LrYXrkZDw7MHeE3XOdzALq3iSmjaaRE_AzMn1Pm0GGljBdAc5xgJZU45vKn9KMGebNVKF-UoYWhfindhLXlXU00aKyjxU-7VF7yUr9v3sWWd3b5Ie-C-OxQPrdkPKRW
[lrw-token-supply]: https://lh6.googleusercontent.com/mKQssPALS7ztV7oAKGLDffCx104YGpffvmGMvlaaXa58936ALYkFulvg0rI_8Ym4AMuVnqoWp5zxzs0ohlhrzf_scml-EWII_bcEVG-fXuYVVnbPPvrWtR3ynWEeaNHqc6_I-reG
[elected-validators]: https://explorer.helium.com/validators
[hip10]: https://github.com/helium/HIP/blob/master/0010-usage-based-data-transfer-rewards.md
[oracles]: https://docs.helium.com/blockchain/oracles
[hip37]: https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md
[lrw-distribution-below-market-value]: https://lh3.googleusercontent.com/j_W1yuRMJS2pr-2dVWtravgfKBdasFU8PxD8cmS_IaUTJrKXbcd5wyuJNPcPnGYtJtuqVIAle8CUyoyRj-5l0FOHbHPmZKivcSMsRJuY0TReUXp1aJWCU2JnqfT1kmZPmeRGFFVm
[lrw-distribution-above-market-value]: https://lh5.googleusercontent.com/_ptVDTD-lYzqEQJYDU_5iY6Agwnu2bhNJWfarDIQ5xqR5uqoCvv9ooEbtDynkRaN_-7UMZnDlBvJ5mXx5UgSUGLxZJBLyHXusBdEt8QLutil9CmIA1bLZYPv_8eTVaZSaUzaCKY0
[voting-power]: https://lh5.googleusercontent.com/P1ceqD0x7A6cFUW1KbLuqvjZdmbCKrgeWdgU4LNLbEL-zUBXjy14PReOn-j_bSKO--4CvZdyS1iQxhyHoCJCGA-wlrDp4-DlG84NMJ9SofZhQscrwOfjBwdPRTxB3uqw9VF6GwJF
