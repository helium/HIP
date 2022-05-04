# HIP 52: LoRaWAN subDAO

- Author: [@tjain-mcc](https://github.com/tjain-mcc), [@shayons297](https://github.com/shayons297), [@jmfayal](https://github.com/jmfayal), [@abhay](https://github.com/abhay)
- Start Date: 2022-01-04
- Category: Economic, Technical
- Original PR: https://github.com/helium/HIP/pull/335
- Tracking Issue: https://github.com/helium/HIP/issues/338
- Status: Draft

## Summary

In [HIP 51: Helium DAOs](https://github.com/helium/HIP/blob/main/0051-helium-dao.md), we provide a general structure for onboarding new Decentralized Network Protocols (DNPs) to the broader Helium Network, with mechanisms in place to ensure that protocol-specific attributes such as proof-of-coverage rules and data transfer pricing are within control of the DNT DAOs.

In this proposal, we specify the implementation of the structure proposed through a detailed onboarding proposal for the Helium LoRaWAN Network. We propose initial configurations of the Helium LoRaWAN economics layer as well as governance mechanisms within the DAO through Helium LoRaWAN (HLT) token voting.

## Stakeholders

This proposal impacts all current and future participants in the Helium LoRaWAN Community.

## LoRaWAN subDAO core jobs-to-be-done

We proposed in HIP 51 that each DNP subDAO operate as a sovereign economics and governance layer. The Helium LoRaWAN subDAO has six core functions

1. **Emissions Curve** The HeliumLoRaWAN subDAO handles all HLT emissions, mining rewards, and programmatic treasury operations. The economic responsibilities around this involve managing the token issuance and distribution.
2. **Treasury Reserve DNT Market Making Curve** subDAOs have full control over the prices at which the subDAO treasury provides quotes to holders of DNT who wish to redeem their holdings for underlying HNT. This can be a flat bid or a more complex curve.**
3. **Oracle Specification** perform work including verifying proof of coverage and data transfer. The oracles are also responsible for distributing DNT mining rewards to the appropriate parties. Responsibilities here include definition of oracle software, minimum stake amounts, and rewards for participation.
4. **Data Transfer Mechanism and Pricing** Data transfer within subnetworks occurs via the process of procuring and burning data credits in the name of the hotspot or set of hotspots that provide coverage. Responsibilities here include Organizationally Unique Identifier (OUI) registration, state channel creation, and bandwidth capacity per data credit definition.
5. **Proof-of-Coverage Mechanism** Most subnetworks will utilize a Proof of Coverage algorithm to verify on an ongoing basis that hotspots are accurately representing their location and the wireless network coverage they are creating from that location. Responsibilities here include Proof-of-Coverage challenge construction, target selection, reward scaling, and verification. Note that subnetworks can choose to skip this mechanism, but must provide reasoning in their subDAO proposal as to why it is not necessary for proper functioning of the subnetwork.
6. **Governance Structure** subDAOs retain control over critical components of the network, and subDAO members can propose and vote for changes to core parameters and mechanisms. Responsibilities here include specification of a formal on-chain voting process that is resistant to attacks.

The remainder of this proposal defines initial values for the subDAO given the aforementioned set of responsibilities.

### Emissions Curve

There will be a max supply of 200,000,000,000 HLT.

The proposal is to have halvenings of HLT issuance every 2 years aligned with the HNT issuance halvenings. This requires a 1 year “stub” period from August 1, 2022 to August 1, 2023. We also propose a veHLT airdrop to Helium Validators as of the date of launch. This airdrop is required to transition the current Helium Validators into LoRaWAN subDAO Oracles.

For clarity, the emission schedule is as follows:

| Year | HLT at the start of the year | HLT minted | % to Proof of Coverage (+ any extra from Data Transfer) | % to Data Transfer (excess to Proof of Coverage) | % to Oracles | Operations Fund | veHNT Stakers |
|------|------------------------------|------------|---------------------------------------------------------|--------------------------------------------------|--------------|-----------------|---------------|
| 1    | 5B                           | 65B        | 30%                                                     | 50%                                              | 7%           | 7%              | 6%            |
| 2    | 70B                          | 32.5B      | 28.5%                                                   | 51.5%                                            | 7%           | 7%              | 6%            |
| 3    | 102.5B                       | 32.5B      | 27%                                                     | 53%                                              | 7%           | 7%              | 6%            |
| 4    | 135B                         | 16.25B     | 25.5%                                                   | 54.5%                                            | 7%           | 7%              | 6%            |
| 5    | 151.25B                      | 16.25B     | 24%                                                     | 56%                                              | 7%           | 7%              | 6%            |
| 6    | 167.5B                       | 8.125B     | 22.5%                                                   | 57.5%                                            | 7%           | 7%              | 6%            |
| 7    | 175.625B                     | 8.125B     | 21%                                                     | 59%                                              | 7%           | 7%              | 6%            |

At launch of the LoRaWAN subnetwork, 2.5% of the total supply of HLT tokens (5B tokens) are issued and airdropped to oracles and hotspots on the existing LoRaWAN network. This airdrop is intended to bootstrap the network, and is distributed to oracles and validators in the following proportion:

Oracles: 50% of 5B tokens, distributed in proportion to HNT staked at the snapshot

Hotspots: 50% of 5B tokens, distributed to all active hotspots (rewarded in the past 30 days) and not on the denylist at the time of snapshot

At the end of a given epoch, the LoRaWAN subnetwork oracles relay start balance, current balance, and total amount of HLT Data Credits created and relay to the L1 HNT emissions contract. The emissions contract subsequently distributes the determined amount of HNT as per the Protocol Score to the LoRaWAN subDAO multi-signature wallet, the addresses of which comprise the set of oracles of the LoRaWAN Network.

The subDAO operations fund is intended to allow the DNP to perform bespoke operations to create and sustain network growth. The primary use case of the operations fund is to fund all state transition transaction fees to the L1, but can be deployed in any manner of ways as per subDAO governance. Such incentives could include

1. One-time DNT bonuses for hotspots providing continuous coverage in new regions deemed to be economically valuable by governance
2. Bonus rewards for hotspots and OUIs that are consistent in network activity and meet certain good actor conditions such as surge-pricing style dynamic multipliers based on data transfer activity for individual regions or bespoke incentives for oracles and manufacturers on the basis of changing network demands.

Once emissions are distributed to hotspots and oracles, HLT owners can either redeem their holdings for underlying HNT against the treasury reserve automatically, hold for redemptions at a later time, or lock up their HLT for veHLT in a process similar to the veHNT mechanism described in HIP 51.

A user’s veHLT lockup power is determined by 1) the amount of HLT they lock up with, and 2) the amount of time they commit to locking up their HLT. The structure applies a linear multiplier of time to the amount of HNT locked up in the voting contract. For the maximum period of four years, users receive 100x the veHLT. For the minimum period of six months, users receive 1x the veHLT. Note that veLRW is **non-transferable**, and represented as a non-fungible coupon in the user’s HLT address.

Users can choose to delegate their veHLT for three core purposes:

1. *Hotspot Self-Staking*: Hotspots are able to delegate veHLT in their own name in order to increase the frequency of challenges to that hotspot.

Users are able to stake either “for” or “against” hotspots. At the end of each epoch, hotspots have a net veHLT score in which “for” staked amounts are added, and “against” staked amounts are subtracted from the running total.

Hotspot veHLT scores are considered within a range of -10M and 10M. For the maximum amount of 10M veHLT staked, hotspots receive 10x the probability of being selected for a challenge within an epoch. For the default amount of zero veHLT staked, hotspots receive 1x the probability of being selected for a challenge within an epoch. For the minimum amount of -10M, hotspots receive zero challenges. In either direction across zero from the y-axis, the challenge probability multiplier varies linearly with the veHLT staked.

Users that delegate veHLT to hotspots receive 50% of any incremental earnings through increased challenge completion.

![challenge-multiplier-vs-vehnt-delegated](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/d60c7241-a481-407a-b58e-fceca4692de2/Screen_Shot_2022-05-04_at_10.35.07_AM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220504%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220504T143702Z&X-Amz-Expires=86400&X-Amz-Signature=503709360231f900a0de4d000135a39ff4a84bef9d1e9791882244cf4d8fd5eb&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Screen%2520Shot%25202022-05-04%2520at%252010.35.07%2520AM.png%22&x-id=GetObject)

Hotspots that are found to be gaming or cheating proof-of-coverage rewards are blacklisted from the network, and delegated veHLT is distributed as follows:

1. 50% of delegated veHLT is burned
2. 50% of delegated veHLT is distributed to users who staked against the hotspot

For example, consider the following closed system with Hotspot A, Hotspot B, User X, and User Y.

X delegates 1M veHLT “for” hotspot A and 4M veHLT “against” hotspot B.

Y delegates 5M veHLT “for” hotspot A and 2M veHLT “for” hotspot B.

Tallying both scores, we have a net score of 6M veHLT “for” hotspot A and -2M veHLT “against” hotspot B.

In this epoch, hotspot A is expected to receive 6x the challenges it would be eligible for under normal circumstances, and hotspot B is expected to receive 0.8x the challenges it would be eligible for under normal circumstances.

If hotspot A were to receive 120K HLT through proof-of-coverage emissions in an epoch, we could expect that it would have received 20K HLT under normal circumstances. User X would receive 50% of 1/6 of the incremental amount (8.34K HLT) and the hotspot owner would receive 50% of 5/6 of the incremental amount (41.665K HLT), while the remaining 50K is distributed to hotspot A.

If hotspot B were convicted of gaming proof-of-coverage rewards, 3M of the total veHLT would be sent to a burn address, whereas the underlying HLT within the 3M veHLT would be distributed to user X. If there were other users who staked against Hotspot B, this would be distributed pro-rata.


2. *Oracle Delegation*: veHLT holders can delegate their holdings to oracles as per the reward agreements set in order to earn future emissions.
3. *Governance*: veHLT can be used to participate in subDAO proposals that impact core protocol parameters, mechanisms, and operating procedures.

### Treasury Reserve DNT Market Making Curve

The LoRaWAN subDAO sets the programmatic treasury formula in order to provide quotes to holders of DNT who wish to redeem their holdings for underlying HNT. Note that at launch of the subnetwork prior to any HNT emissions from the minting contract as per the protocol score, the Helium Foundation will make a donation of 50,000 HNT into the subDAO treasury reserve in order to collateralize the airdrop specified in the emissions section.

We propose a constant function market making formula for the LoRaWAN subDAO programmatic treasury defined as per the following specification.

![market-making-components](https://lh6.googleusercontent.com/nzEaWc5B055nckKgEIv-kFyNwP9dG3O2pZIfA_yJlwM6Q4XpqP-RTWA9lehb1yXRV7aRD-U0Isq_0p8hYHEyzDU_J6UHOB_sk5skER-k04VGsQ3DrDeKGnJdiWw86zWvHNX8qWCA)

At epoch T, we denote the value of H, S, and P as HT, ST, and PT. The programmatic treasury formula at epoch T is a function in two variables, HT, ST defined as follows:

![market-making-formula](https://lh3.googleusercontent.com/7P_5Bha1KNPmQl2wWBHPoB6ojHfFKdnSaD208DR1vFUE2ybnAopqA6X-sVMzhHqiH5DeeDDKMY5hxKOe74j_PVcEBCoXjwetlytpeS241lgrEy_TmapfPiWUjEzyhp72kyvLiEJA)

For example, consider at epoch #125, the total outstanding supply of tokens for the LoRaWAN subDAO is 3.275B HLT and the total amount in the treasury reserve is 2M HNT. The programmatic treasury formula is given as follows

![example-redemption](https://lh6.googleusercontent.com/J_34HUWBuZl_YxNOnMv_fVkgvJKVeWtNLdZ9eZfKjYOFVjvv9LqjyB-pMmBaqpgFykNb4YcKfE7CuHDC6aX1WQORR2vlyyg4hyb_38ACZqDMjUrwVKHUhYeZYVj1QYceVwL-z3gR)

This implies that at epoch #125, any number of HLT can be redeemed at a unit price of 0.00061068702 HNT.

Now consider at epoch #225, the total outstanding supply of tokens for the LoRaWAN subDAO is 3.5B HLT and the total amount in the treasury reserve is 2.025M HNT. The programmatic treasury formula is given as follows

![example-redemption-2](https://lh5.googleusercontent.com/JzoHFD4OcK-YbK8aqiR2VjsBtN8mxRK6oEae_57KhoeoXp1TGKbRWGF7NkfRByITdTcfEAAkPSkKPMfz604aTcqhNlBJ2o7YJ6TjpAUxvGJSBcUgyH4o8iDmJRQ8ejcqaa8kvK9e)

This implies that at 100 epochs after #125 at #225, any number of HLT can be redeemed at a unit price of 0.00057857142 HNT.

In epoch #225, the total outstanding supply of HLT has increased, and given inflows to the treasury reserve in HNT the resulting unit price has decreased. If the rate at which HNT flows into the treasury reserve outpaces the emission of HLT tokens, the unit price of HLT increases.

Between epoch #125 and #225, a similar repricing takes place in each individual epoch given the amount of HNT in the treasury reserve and the outstanding supply of HLT tokens.

It is possible to represent the programmatic treasury formula as a surface in euclidean space using the following vector notation in two variables:

![programmatic-treasury-formula](https://lh3.googleusercontent.com/PNzok9G-6EnVEVVWri06NcbbRffoF_f9M5eHo9ain25TT4OoG9zAFnIAowTtWqTNyI9RFC98lICBCONmQqS6uqlQXpDcXXzieywg1IXizx9YgLpzAtOUGTvDXde5Qb0U6ds-7smt)

Where

![programmatic-treasury-formula-components](https://lh6.googleusercontent.com/UqiNgjY8LVN6lzT1zgM4D-J3GJfxAeYomOjFirG4YION8tF0ZvrJmWQWKl2kL6XTAPWUhGMJnv_SZHIhXyvST7TJy4vm9AuRUy_a686QbT1gLoHpwhTZauml3G20FBw_qM1XCeX6)

Clarifications:

- The supply of HLT tokens for the purposes of calculating the HLT/HNT price includes all locked veHLT tokens.
- The subDAO updates the limit order price every epoch **before** any new HLT are distributed out to stakeholders for their activity during that epoch.

### Oracle Operations

LoRaWAN oracles confirm proof of coverage, data transfer, and add blocks to the LoRaWAN subnetwork. They serve state data around Proof-of-Coverage challenges and data transfer events to light and data only hotspots.

Validation is performed by a set of rotating nodes known as the consensus group, which verifies transactions and ordering prior to forming a block and proposing it to the subnetwork chain. Consensus groups are elected once per epoch, and the number of members is given by the num_consensus_members chain variable (currently set at 43).

* The Helium Consensus Protocol is based on a variant of the HoneyBadgerBFT (HBBFT) protocol. HBBFT is based on a body of research originally kicked off by Andrew Miller and the team at the University of Illinois, Urbana-Champaign.
* HBBFT is an asynchronous atomic broadcast protocol designed to enable a group of known nodes to achieve consensus over unreliable links. In Helium’s implementation, a consensus group of [elected Validators](https://explorer-beta.helium.com/validators) receives encrypted transactions as inputs and proceeds to reach common agreement on the ordering of these transactions before forming a block and adding it to the blockchain.

* HBBFT relies on a scheme known as threshold encryption. Using this scheme, transactions are encrypted using a shared public key, and are only decryptable when the elected consensus group works together to decrypt them. The usage of threshold encryption enables the Helium Consensus Protocol to achieve censorship-resistant transactions.
* At the end of each epoch, mining rewards are distributed by the consensus group to the wallet addresses that have earned them.
* Each one of the above activities is recorded in a block using the reward transaction. At the completion of each epoch, all the individual reward transactions are grouped in a rewards transaction at which point all HNT mined in that epoch are distributed.

veHLT holders can choose to delegate their holdings to oracles of their choice or run their own oracles.

### Proof-of-Coverage Specification

The LoRaWAN subDAO is required to constantly interrogate hotspots using the Proof-of-Coverage challenge mechanism to ensure that hotspots are representing their locations accurately. The net results of each of these challenges are relayed to the Helium L1 after being validated by their respective consensus groups.

LoRaWAN Challenges involve three distinct roles:

1. Challenger - The Hotspot that constructs and issues the POC Challenge. Hotspots issue challenges approximately once per every 360 blocks. We propose moving this role to LoRaWAN oracles.
2. Transmitter - Sometimes called "Challengee". This Hotspot is the target of the POC challenge and is responsible for transmitting (or "beaconing") challenge packets to potentially be witnessed by geographically proximate Hotspots.
3. Witness - Hotspots that are geographically proximate to the Transmitter and report the existence of the challenge packet after it has been transmitted.

### Data Transfer and Pricing Specification

Data Credits are utilized in asserting new hotspots and their location on the chain, registering OUIs and associated devices, and as payment for packet transfers.

With the activation of [HIP 10](https://github.com/helium/HIP/blob/master/0010-usage-based-data-transfer-rewards.md), hotspot operators receive HNT emissions up to 32.5% per epoch and are rewarded at 1:1 rate based on dollar value of Data Credits transfers as per the [HNT Price Oracle](https://docs.helium.com/blockchain/oracles). This proposal scales Data Credits rewards based on actual activity on the network, and disincentivizes arbitrageurs from taking advantage of more arbitrary distribution mechanisms for rewards.

**[HIP 37](https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md) proposed the removal of a division between proof-of-coverage and data credits rewards entirely at the date of the second HNT halving (8/1/2023). We propose this removal happen from the launch of the Lorawan subDAO. As shown in the emissions schedule, this is reflected in the HLT subDAO.**

At present, every 24 bytes sent in a packet cost 1 DC, priced at $0.00001. Data Credits are generated by burning the requisite amount of HNT as per the Helium price oracle.

The transaction is as follows:

1. A Miner receives a packet and determines who it belongs to
2. The Miner reaches the appropriate Helium LoRaWAN Network Server / Router and offers the packet
3. The Helium Router expresses interest in the packet and accepts delivery
4. The Miner provides the packet under the promise that the Helium Router will spend a Data Credit in the name of the Miner

Note that it is possible to support both metered and unmetered networks. For an unmetered network, an OUI can choose to pay a fixed rate for an indefinite period of time which involves the purchase and burn of some number of data credits per minute, and attribution to hotspots after consumption occurs pro rata network traffic under the unmetered plan.

### Governance Specification

The LoRaWAN Network is under the control of the subDAO. All subDAO proposals must come attached with code to be approved.

We propose that veHLT governance is constructed in a manner identical to veHNT governance as specified in HIP51.

Users can choose to delegate their lockup power in veHLT to all LoRaWAN DAO governance proposals. Proposals are assessed using majority and quorum thresholds defined in veHLT terms, initially proposed to be 67% and 100M HLT respectively.
