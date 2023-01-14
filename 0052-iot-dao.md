# HIP 52: IOT subDAO

- Author: [@tjain-mcc](https://github.com/tjain-mcc), [@shayons297](https://github.com/shayons297),
  [@jmfayal](https://github.com/jmfayal), [@abhay](https://github.com/abhay)
- Start Date: 2022-01-04
- Category: Economic, Technical
- Original PR: <https://github.com/helium/HIP/pull/335>
- Tracking Issue: <https://github.com/helium/HIP/issues/338>
- Status: Draft

## Summary

[HIP 51: Helium DAOs](https://github.com/helium/HIP/blob/main/0051-helium-dao.md) provides a general
structure for onboarding new Decentralized Network Protocols (DNPs) to the broader Helium Network,
with mechanisms in place to ensure that protocol-specific attributes such as Proof-of-Coverage
rules, Data Credit pricing, and consensus-driven rules are within control of the emergent DNP DAO.

In this proposal, we specify the implementation of the structure proposed through a detailed
onboarding proposal for the Helium IoT Network. We propose initial configurations of the Helium IoT
economics layer as well as governance mechanisms within the DAO through Helium IoT (IOT) token
voting.

## Stakeholders

This proposal impacts all current and future participants in the Helium IoT Community.

## IoT subDAO core jobs-to-be-done

We proposed in HIP 51 that each DNP subDAO operate as a sovereign economics and governance layer.
The Helium IoT subDAO has six core functions

1. **Emissions Curve** The Helium IoT subDAO handles all IOT emissions, mining rewards, and
   programmatic treasury operations. The economic responsibilities around this involve managing the
   token issuance and distribution.
2. **Treasury Reserve DNT Market Making Curve** subDAOs have full control over the prices at which
   the subDAO treasury provides quotes to holders of DNT who wish to redeem their holdings for
   underlying HNT. This can be a flat bid or a more complex curve.\*\*
3. **Oracle Specification** perform work including verifying proof of coverage and data transfer.
   The oracles are also responsible for distributing DNT mining rewards to the appropriate parties.
   Responsibilities here include definition of oracle software, minimum stake amounts, and rewards
   for participation.
4. **Data Transfer Mechanism and Pricing** Data transfer within subnetworks occurs via the process
   of procuring and burning data credits in the name of the Hotspot or set of Hotspots that provide
   coverage. Responsibilities here include Organizationally Unique Identifier (OUI) registration,
   state channel creation, and bandwidth capacity per data credit definition.
5. **Proof-of-Coverage Mechanism** Most subnetworks will utilize a Proof of Coverage algorithm to
   verify on an ongoing basis that Hotspots are accurately representing their location and the
   wireless network coverage they are creating from that location. Responsibilities here include
   Proof-of-Coverage challenge construction, target selection, reward scaling, and verification.
   Note that subnetworks can choose to skip this mechanism, but must provide reasoning in their
   subDAO proposal as to why it is not necessary for proper functioning of the subnetwork.
6. **Governance Structure** subDAOs retain control over critical components of the network, and
   subDAO members can propose and vote for changes to core parameters and mechanisms.
   Responsibilities here include specification of a formal on-chain voting process that is resistant
   to attacks.

The remainder of this proposal defines initial values for the subDAO given the aforementioned set of
responsibilities.

### Emissions Curve

There will be a max supply of 200,000,000,000 IOT.

The proposal is to have halvenings of IOT issuance every 2 years aligned with the HNT issuance
halvenings. This requires a 1 year “stub” period from August 1, 2022 to August 1, 2023. We also
propose a veIOT airdrop to Helium Validators as of the date of launch. This airdrop is required to
transition the current Helium Validators into IoT subDAO Oracles.

For clarity, the emission schedule is as follows:

| Year | IOT at the start of the year | IOT minted | % to Proof of Coverage (+ any extra from Data Transfer) | % to Data Transfer (excess to Proof of Coverage) | % to Oracles | Operations Fund | veHNT Stakers |
| ---- | ---------------------------- | ---------- | ------------------------------------------------------- | ------------------------------------------------ | ------------ | --------------- | ------------- |
| 1    | 5B                           | 65B        | 30%                                                     | 50%                                              | 7%           | 7%              | 6%            |
| 2    | 70B                          | 32.5B      | 28.5%                                                   | 51.5%                                            | 7%           | 7%              | 6%            |
| 3    | 102.5B                       | 32.5B      | 27%                                                     | 53%                                              | 7%           | 7%              | 6%            |
| 4    | 135B                         | 16.25B     | 25.5%                                                   | 54.5%                                            | 7%           | 7%              | 6%            |
| 5    | 151.25B                      | 16.25B     | 24%                                                     | 56%                                              | 7%           | 7%              | 6%            |
| 6    | 167.5B                       | 8.125B     | 22.5%                                                   | 57.5%                                            | 7%           | 7%              | 6%            |
| 7    | 175.625B                     | 8.125B     | 21%                                                     | 59%                                              | 7%           | 7%              | 6%            |

At launch of the IoT subnetwork, 2.5% of the total supply of IOT tokens (5B tokens) are issued and
airdropped to oracles and Hotspots on the existing IoT network. This airdrop is intended to
bootstrap the network, and is distributed to oracles and validators in the following proportion:

Oracles: 50% of 5B tokens, distributed in proportion to HNT staked at the snapshot

Hotspots: 50% of 5B tokens, distributed to all active Hotspots (rewarded in the past 30 days) and
not on the denylist at the time of snapshot

At the end of a given epoch, the IoT subnetwork oracles relay start balance, current balance, and
total amount of IOT Data Credits created and relay to the L1 HNT emissions contract. The emissions
contract subsequently distributes the determined amount of HNT as per the Protocol Score to the IoT
subDAO multi-signature wallet, the addresses of which comprise the set of oracles of the IoT
Network.

The subDAO operations fund is intended to allow the DNP to perform bespoke operations to create and
sustain network growth. The primary use case of the operations fund is to fund all state transition
transaction fees to the L1, but can be deployed in any manner of ways as per subDAO governance. Such
incentives could include

1. One-time DNT bonuses for Hotspots providing continuous coverage in new regions deemed to be
   economically valuable by governance
2. Bonus rewards for Hotspots and OUIs that are consistent in network activity and meet certain good
   actor conditions such as surge-pricing style dynamic multipliers based on data transfer activity
   for individual regions or bespoke incentives for oracles and manufacturers on the basis of
   changing network demands.

Once emissions are distributed to Hotspots and oracles, IOT owners can either redeem their holdings
for underlying HNT against the treasury reserve automatically, hold for redemptions at a later time,
or lock up their IOT for veIOT in a process similar to the veHNT mechanism described in HIP 51.

A user’s veIOT lockup power is determined by 1) the amount of IOT they lock up with, and 2) the
amount of time they commit to locking up their IOT. The structure applies a linear multiplier of
time to the amount of HNT locked up in the voting contract. For the maximum period of four years,
users receive 100x the veIOT. For the minimum period of six months, users receive 1x the veIOT. Note
that veIOT is **non-transferable**, and represented as a non-fungible coupon in the user’s IOT
address.

Users can choose to delegate their veIOT for three core purposes:

1. _Oracle Delegation_: veIOT holders can delegate their holdings to oracles as per the reward
   agreements set in order to earn future emissions.
2. _Governance_: veIOT can be used to participate in subDAO proposals that impact core protocol
   parameters, mechanisms, and operating procedures.

### Treasury Reserve DNT Market Making Curve

The IoT subDAO sets the programmatic treasury formula in order to provide quotes to holders of DNT
who wish to redeem their holdings for underlying HNT. The programmatic treasury defines the floor
price for IOT, but holders always retain the ability to exchange at the prevailing rate on open
markets.

We propose a constant function market making formula for the IoT subDAO programmatic treasury
defined as per the following specification.

$H: \text{HNT in Reserve}$

$S: \text{Outstanding Supply of IOT}$

$P: \text{Price of IOT}$

At epoch T, we denote the value of H, S, and P as $H_T$, $S_T$, and $P_T$. The programmatic treasury
formula at epoch T is a function in two variables, HT, ST defined as follows:

$P_T = \frac{H_T}{S_T}$

For example, consider at epoch #125, the total outstanding supply of tokens for the IoT subDAO is
3.275B IOT and the total amount in the treasury reserve is 2M HNT. The programmatic treasury formula
is given as follows

$$P_{125} = \frac{H_{125}}{S_{125}} = \frac{2,000,000}{3,275,000,000} = 0.00061068702$$

This implies that at epoch #125, any number of IOT can be redeemed at a unit price of 0.00061068702
HNT.

Now consider at epoch #225, the total outstanding supply of tokens for the IoT subDAO is 3.5B IOT
and the total amount in the treasury reserve is 2.025M HNT. The programmatic treasury formula is
given as follows

$$P_{225} = \frac{H_{225}}{S_{225}} = \frac{2,025,000}{3,500,000,000} = 0.00057857142$$

This implies that at 100 epochs after #125 at #225, any number of IOT can be redeemed at a unit
price of 0.00057857142 HNT.

In epoch #225, the total outstanding supply of IOT has increased, and given inflows to the treasury
reserve in HNT the resulting unit price has decreased. If the rate at which HNT flows into the
treasury reserve outpaces the emission of IOT tokens, the unit price of IOT increases.

Between epoch #125 and #225, a similar repricing takes place in each individual epoch given the
amount of HNT in the treasury reserve and the outstanding supply of IOT tokens.

Clarifications:

- The supply of IOT tokens for the purposes of calculating the IOT/HNT price includes all locked
  veIOT tokens.
- The subDAO updates the limit order price every epoch **before** any new IOT are distributed out to
  stakeholders for their activity during that epoch.

### Oracle Operations

IoT oracles confirm proof of coverage, data transfer, and add blocks to the IoT subnetwork. They
serve state data around Proof-of-Coverage challenges and data transfer events to light and data only
Hotspots.

Validation is performed by a set of rotating nodes known as the consensus group, which verifies
transactions and ordering prior to forming a block and proposing it to the subnetwork chain.
Consensus groups are elected once per epoch, and the number of members is given by the
num_consensus_members chain variable (currently set at 43).

- The Helium Consensus Protocol is based on a variant of the HoneyBadgerBFT (HBBFT) protocol. HBBFT
  is based on a body of research originally kicked off by Andrew Miller and the team at the
  University of Illinois, Urbana-Champaign.
- HBBFT is an asynchronous atomic broadcast protocol designed to enable a group of known nodes to
  achieve consensus over unreliable links. In Helium’s implementation, a consensus group of
  [elected Validators](https://explorer-beta.helium.com/validators) receives encrypted transactions
  as inputs and proceeds to reach common agreement on the ordering of these transactions before
  forming a block and adding it to the blockchain.

- HBBFT relies on a scheme known as threshold encryption. Using this scheme, transactions are
  encrypted using a shared public key, and are only decryptable when the elected consensus group
  works together to decrypt them. The usage of threshold encryption enables the Helium Consensus
  Protocol to achieve censorship-resistant transactions.
- At the end of each epoch, mining rewards are distributed by the consensus group to the wallet
  addresses that have earned them.
- Each one of the above activities is recorded in a block using the reward transaction. At the
  completion of each epoch, all the individual reward transactions are grouped in a rewards
  transaction at which point all HNT mined in that epoch are distributed.

veIOT holders can choose to delegate their holdings to oracles of their choice or run their own
oracles.

### Proof-of-Coverage Specification

The IoT subDAO is required to constantly interrogate Hotspots using the Proof-of-Coverage challenge
mechanism to ensure that Hotspots are representing their locations accurately. The net results of
each of these challenges are relayed to the Helium L1 after being validated by their respective
consensus groups.

IoT Challenges involve three distinct roles:

1. Challenger - The Hotspot that constructs and issues the POC Challenge. Hotspots issue challenges
   approximately once per every 360 blocks. We propose moving this role to IoT oracles.
2. Transmitter - Sometimes called "Challengee". This Hotspot is the target of the POC challenge and
   is responsible for transmitting (or "beaconing") challenge packets to potentially be witnessed by
   geographically proximate Hotspots.
3. Witness - Hotspots that are geographically proximate to the Transmitter and report the existence
   of the challenge packet after it has been transmitted.

### Data Transfer and Pricing Specification

Data Credits are utilized in asserting new Hotspots and their location on the chain, registering
OUIs and associated devices, and as payment for packet transfers.

With the activation of
[HIP 10](https://github.com/helium/HIP/blob/master/0010-usage-based-data-transfer-rewards.md),
Hotspot operators receive HNT emissions up to 32.5% per epoch and are rewarded at 1:1 rate based on
dollar value of Data Credits transfers as per the
[HNT Price Oracle](https://docs.helium.com/blockchain/oracles). This proposal scales Data Credits
rewards based on actual activity on the network, and disincentivizes arbitrageurs from taking
advantage of more arbitrary distribution mechanisms for rewards.

**[HIP 37](https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md) proposed the removal
of a division between proof-of-coverage and data credits rewards entirely at the date of the second
HNT halving (8/1/2023). We propose this removal happen from the launch of the IoT subDAO. As shown
in the emissions schedule, this is reflected in the IOT subDAO.**

At present, every 24 bytes sent in a packet cost 1 DC, priced at $0.00001. Data Credits are
generated by burning the requisite amount of HNT as per the Helium price oracle.

The transaction is as follows:

1. A Miner receives a packet and determines who it belongs to
2. The Miner reaches the appropriate Helium IoT Network Server / Router and offers the packet
3. The Helium Router expresses interest in the packet and accepts delivery
4. The Miner provides the packet under the promise that the Helium Router will spend a Data Credit
   in the name of the Miner

Note that it is possible to support both metered and unmetered networks. For an unmetered network,
an OUI can choose to pay a fixed rate for an indefinite period of time which involves the purchase
and burn of some number of data credits per minute, and attribution to Hotspots after consumption
occurs pro rata network traffic under the unmetered plan.

### Governance Specification

The IoT Network is under the control of the subDAO. All subDAO proposals must come attached with
code to be approved.

We propose that veIOT governance is constructed in a manner identical to veHNT governance as
specified in HIP51.

Users can choose to delegate their lockup power in veIOT to all IoT DAO governance proposals.
Proposals are assessed using majority and quorum thresholds defined in veIOT terms, initially
proposed to be 67% and 100M IOT respectively.
