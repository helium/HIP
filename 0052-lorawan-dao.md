# HIP 52: LoRaWAN subDAO

- Authors: [@tjain-mcc](https://github.com/tjain-mcc), [@shayons297](htts://github.com/shayons297)
- Start Date: 2022-01-04
- Category: Economic, Technical
- Original PR: https://github.com/helium/HIP/pull/335
- Tracking Issue: https://github.com/helium/HIP/issues/338
- Status: Draft
**Summary**

In [HIP 51: Helium DAOs](https://docs.google.com/document/d/1ibFE2DI8fkd4uOSnIT00C7JiRYsZExg164_KtDzz-YI/edit#), we provide a general structure for onboarding new Decentralized Network Protocols (DNPs) to the broader Helium Network, with mechanisms in place to ensure that protocol-specific attributes such as proof-of-coverage rules and data transfer pricing are within control of the DNT DAOs.

In this proposal, we specify the implementation of the structure proposed through a detailed onboarding proposal for the Helium LoRaWAN Network. We propose initial configurations of the Helium LoRaWAN economics layer as well as governance mechanisms within the DAO through Helium LoRaWAN (HLT) token voting.

# **Stakeholders**

This proposal impacts all current and future participants in the Helium LoRaWAN Community.

# **LoRaWAN subDAO core jobs-to-be-done**

We proposed in HIP 51 that each DNP subDAO operate as a sovereign economics and governance layer. The Helium LoRaWAN subDAO has six core functions

1. **Emissions Curve**The HeliumLoRaWAN subDAO handles all HLT emissions, mining rewards, and programmatic treasury operations. The economic responsibilities around this involve managing the token issuance and distribution.
2. **Treasury Reserve DNT Market Making Curve subDAOs have full control over the prices at which the subDAO treasury provides quotes to holders of DNT who wish to redeem their holdings for underlying HNT. This can be a flat bid or a more complex curve.**
3. **Oracle Specification**

Oracles ****perform work including verifying proof of coverage and data transfer. The oracles are also responsible for distributing DNT mining rewards to the appropriate parties. Responsibilities here include definition of oracle software, minimum stake amounts, and rewards for participation.

1. **Data Transfer Mechanism and Pricing**

Data transfer within subnetworks occurs via the process of procuring and burning data credits in the name of the hotspot or set of hotspots that provide coverage. Responsibilities here include Organizationally Unique Identifier (OUI) registration, state channel creation, and bandwidth capacity per data credit definition.

2. **Proof-of-Coverage Mechanism**

Most subnetworks will utilize a Proof of Coverage algorithm to verify on an ongoing basis that hotspots are accurately representing their location and the wireless network coverage they are creating from that location. Responsibilities here include Proof-of-Coverage challenge construction, target selection, reward scaling, and verification. Note that subnetworks can choose to skip this mechanism, but must provide reasoning as to why it is not necessary for proper functioning of the subnetwork.

3. **Governance Structure**

subDAOs retain control over critical components of the network, and subDAO members can propose and vote for changes to core parameters and mechanisms. Responsibilities here include specification of a formal on-chain voting process that is resistant to attacks.

The remainder of this proposal defines initial values for the subDAO given the aforementioned set of responsibilities.

### *Emissions Curve*

There will be a max supply of 250B HLT.

The proposal is to have halvenings of HLT issuance every 2 years. The emission schedule is as follows:

| Year | HLT at the start of the year | HLT minted | % to Proof of Coverage (+ any extra from Data Transfer) | % to Data Transfer (excess to Proof of Coverage) | % to Oracles | Operations Fund |
|------|------------------------------|------------|---------------------------------------------------------|--------------------------------------------------|--------------|-----------------|
| 1    | 0                            | 62.5B      | 30%                                                     | 50%                                              | 10%          | 10%             |
| 2    | 62.5B                        | 62.5B      | 28.5%                                                   | 51.5%                                            | 10%          | 10%             |
| 3    | 125B                         | 31.25B     | 27%                                                     | 53%                                              | 10%          | 10%             |
| 4    | 156.25B                      | 31.25B     | 25.5%                                                   | 54.5%                                            | 10%          | 10%             |
| 5    | 175B                         | 15.625B    | 24%                                                     | 56%                                              | 10%          | 10%             |
| 6    | 190.625B                     | 15.625B    | 22.5%                                                   | 57.5%                                            | 10%          | 10%             |
| 7    | 206.25B                      | 7.8125B    | 21%                                                     | 59%                                              | 10%          | 10%             |

Alternately, we can consider the following supply curve defined as follows with (N as Year)

![https://lh4.googleusercontent.com/VhuVEMlICag6AEYE41HWeCyS61A4Xu-MHadFVeNc_NTVcgHGa7H0aBB6SEXdiouRIIlb2KJRoapb8AkGEGJAhOI0lItthS7eXpxhi7S4vHnydaodKHPleDLPXTgiwT8GX1ewLFgk](https://lh4.googleusercontent.com/VhuVEMlICag6AEYE41HWeCyS61A4Xu-MHadFVeNc_NTVcgHGa7H0aBB6SEXdiouRIIlb2KJRoapb8AkGEGJAhOI0lItthS7eXpxhi7S4vHnydaodKHPleDLPXTgiwT8GX1ewLFgk)

Emissions in a given year are distributed equally across all epochs in that year, and the max supply of 250B is maintained. The table looks as follows:


| Year | HLT at the start of the year | HLT minted     | % to Proof of Coverage (+ any extra from Data Transfer) | % to Data Transfer (excess to Proof of Coverage) | % to Oracles | Operations Fund |
|------|------------------------------|----------------|---------------------------------------------------------|--------------------------------------------------|--------------|-----------------|
| 1    | 50,000,000,000               | 50,000,000,000 | 30%                                                     | 50%                                              | 10%          | 10%             |
| 2    | 78,853,900,818               | 28,853,900,818 | 28.50%                                                  | 51.50%                                           | 10%          | 10%             |
| 3    | 97,058,685,350               | 18,204,784,533 | 27%                                                     | 53%                                              | 10%          | 10%             |
| 4    | 111,485,635,759              | 14,426,950,409 | 25.50%                                                  | 54.50%                                           | 10%          | 10%             |
| 5    | 123,912,334,450              | 12,426,698,691 | 24%                                                     | 56%                                              | 10%          | 10%             |
| 6    | 135,074,546,981              | 11,162,212,531 | 22.50%                                                  | 57.50%                                           | 10%          | 10%             |
| 7    | 145,352,513,829              | 10,277,966,847 | 21%                                                     | 59%                                              | 10%          | 10%             |
| 8    | 154,970,480,768              | 9,617,966,939  | 19.50%                                                  | 60.50%                                           | 10%          | 10%             |
| 9    | 164,072,873,034              | 9,102,392,266  | 18.00%                                                  | 62.00%                                           | 10%          | 10%             |
| 10   | 172,758,762,672              | 8,685,889,638  | 16.50%                                                  | 63.50%                                           | 10%          | 10%             |
| 11   | 181,099,410,501              | 8,340,647,828  | 15.00%                                                  | 65.00%                                           | 10%          | 10%             |
| 12   | 189,148,002,589              | 8,048,592,088  | 13.50%                                                  | 66.50%                                           | 10%          | 10%             |
| 13   | 196,945,427,494              | 7,797,424,905  | 12.00%                                                  | 68.00%                                           | 10%          | 10%             |
| 14   | 204,523,891,127              | 7,578,463,634  | 10.50%                                                  | 69.50%                                           | 10%          | 10%             |
| 15   | 211,909,278,589              | 7,385,387,461  | 9.00%                                                   | 71.00%                                           | 10%          | 10%             |
| 16   | 219,122,753,793              | 7,213,475,204  | 7.50%                                                   | 72.50%                                           | 10%          | 10%             |
| 17   | 226,181,876,270              | 7,059,122,477  | 6.00%                                                   | 74.00%                                           | 10%          | 10%             |
| 18   | 233,101,401,396              | 6,919,525,125  | 4.50%                                                   | 75.50%                                           | 10%          | 10%             |
| 19   | 239,893,866,834              | 6,792,465,438  | 3.00%                                                   | 77.00%                                           | 10%          | 10%             |
| 20   | 246,570,030,848              | 6,676,164,014  | 1.50%                                                   | 78.50%                                           | 10%          | 10%             |

We further propose a modified version of the net emissions model defined in HIP-20 to ensure that stakeholders within the subnetwork are rewarded in perpetuity.

In a given epoch, the value of HNT burnt to produce data credits for use within the LoRaWAN network corresponds to a fixed amount of HLT as per the rate set by the programmatic treasury reserve. Provided a fixed cap of 10% of total epochal emissions, this amount of HLT is removed from the net new outstanding supply of HLT and placed in a net emissions reserve.

Note that hotspots, oracles, and the operations fund do not receive the incremental supply allocated for the net emissions reserve in that given epoch. The reserve is earmarked for incentives once standard emissions reach their limit in year 20.

For example, consider epoch #125 in which

1. 100 HNT worth of data credits are burned within the LoRaWAN subnetwork
2. The programmatic treasury formula provides a HLT price of 0.0006 HNT
3. Emissions for epoch #125 as per the supply schedule at 2.5M HLT

The net emissions reserve receives 100/0.0006 = 166,666.67 HLT. Hotspots, oracles, and the operations fund in this epoch then receive a total of 2,500,000 - 166,667 = 2,333,333.34 HLT.

Note that if 200 HNT worth of data credits were burnt (implied HLT value at 333,333.34), the HLT allocation would exceed the net emissions cap of 250,000 HLT in that epoch. In this case, only 250,000 HLT would be allocated to the net emissions reserve, and hotspots, oracles, and the operations fund would receive a total of 2,250,000 HLT.

Once the standard emissions curve reaches its endpoint in Year 20, the net emissions reserve follows an identical supply curve and cap percentage. The incentive curve for the subsequent 20-year period is as follows, given the net emissions reserve is X at the end of the standard emissions curve, and p is the exponent when X is represented in scientific notation

![https://lh6.googleusercontent.com/pNqUS62QpRzhm0lHmM7OPzffi6COYCiU6mS1jPMaYFQCMaMzUSlLfqbRIUN5Xt5QZiWzRbg9cND__frIIcGmdzNB2p8aipnhfxMqJvkvBFiwnRoaK32_9FChg2q6q_DYgnlDHJvL](https://lh6.googleusercontent.com/pNqUS62QpRzhm0lHmM7OPzffi6COYCiU6mS1jPMaYFQCMaMzUSlLfqbRIUN5Xt5QZiWzRbg9cND__frIIcGmdzNB2p8aipnhfxMqJvkvBFiwnRoaK32_9FChg2q6q_DYgnlDHJvL)

Note that given the same capped net emissions reserve model applied to this supply schedule, the process can be repeated ad infnitum.

At launch of the LoRaWAN subnetwork, 1% of the total supply of HLT tokens (2.5B tokens) are issued and airdropped to oracles and hotspots on the existing LoRaWAN network. These tokens are taken out of the operations fund, which implies that over the course of the remainder of the year, the operations fund only receives (10%*62.5B) - 2.5B = 3.75B tokens in emissions. This airdrop is intended to bootstrap the network, and is distributed to oracles and validators in the following proportion:

Oracles: 50% of 2.5B tokens, distributed in proportion to number of mined blocks at timestamp

Hotspots: 50% of 2.5B tokens, distributed in proportion to data credits burned at timestamp

At the end of a given epoch, the LoRaWAN subnetwork oracles relay start balance, current balance, and total amount of HLT Data Credits created and relay to the L1 HNT emissions contract. The emissions contract contract subsequently distributes the determined amount of HNT as per the Protocol Score to the LoRaWAN subDAO multi-signature wallet, the addresses of which comprise the set of oracles of the LoRaWAN Network.

The subDAO operations fund is intended to allow the DNP to perform bespoke operations to create and sustain network growth. The primary use case of the operations fund is to fund all state transition transaction fees to the L1, but can be deployed in any manner of ways as per subDAO governance. Such incentives could include

1. One-time DNT bonuses for hotspots providing continuous coverage in new regions deemed to be economically valuable by governance
2. Bonus rewards for hotspots and OUIs that are consistent in network activity and meet certain good actor conditions (surge-pricing style dynamic multipliers based on data transfer activity for individual regions, bespoke incentives for oracles and manufacturers on the basis of changing network demands, etc.)

An example use case for the operations use fund is as follows:

HIP 15 and 17 defined rules for scaling rewards to hotspots based on placement as per target density of hotspots in a given geographic area as well as number of witnesses to challenges participated in.

HIP-17 specified a rewards mechanism to incentivize hotspots in distinct locations representing a larger area of network coverage as opposed to devices in close proximity to each other. In order to incentivize greater land coverage of hotspots in new areas, we propose that for each new H7 hex in which a set of hotspots is deployed, a one-time 500K HLT bonus is allocated for the first hotspot that successfully responds to 150 consecutive challenges. Note that this bonus is funded by the subDAO operations fund. If the hotspot goes offline at any time prior to the completion of 150 challenges, the counter is reset and any other hotspot may complete the task to receive the bonus.

Consider three hotspots deployed simultaneously in a hex that has not previously been covered by the LoRaWan network. Each hotspot to be deployed in that hex is eligible to receive the bonus.

If there is an interruption in coverage in two of the hotspots at a time prior to the completion of the 150 consecutive challenges, the remaining hotspot receives the bonus.

If there is an interruption in coverage in one of the hotspots at a time prior to the completion of the 150 consecutive challenges, the remaining hotspots split the bonus equally. If all three hotspots complete the 150 consecutive challenges, they split the bonus equally.

If all three hotspots experience interruptions prior to the completion of the challenge, the counter resets and the first hotspot to complete 150 consecutive challenges receives the bonus.

Once emissions are distributed to hotspots and oracles, HLT owners can either redeem their holdings for underlying HNT against the treasury reserve automatically, hold for redemptions at a later time, or lock up their HLT for veHLT in a process similar to the veHNT mechanism described in HIP 51.

A user’s veHLT lockup power is determined by 1) the amount of HLT they lock up with, and 2) the amount of time they commit to locking up their HLT. The structure applies a linear multiplier of time to the amount of HNT locked up in the voting contract. For the maximum period of four years, users receive 100x the veHLT. For the minimum period of six months, users receive 1x the veHLT. Note that veLRW is **non-transferable**, and represented as a non-fungible coupon in the user’s HLT address.

Users can choose to delegate their veHLT for three core purposes:

1. Hotspot Self-Staking: Hotspots are able to delegate veHLT in their own name in order to apply a multiplier effect on future emissions. 10% of all hotspots emissions in a given epoch are carved out for the “hotspot staker leaderboard”, in which new HLT emissions are distributed pro-rata total amount of HLT staked.
2. Oracle Delegation: veHLT holders can delegate their holdings to oracles as per the reward agreements set in order to earn future emissions.
3. subDAO Treasury Reserve Staking: Holders can choose to stake their veHLT directly to the subDAO treasury reserve, which in turn takes the underlying HNT and delegates veHNT to impact the protocol score positively. This implies greater HNT distribution to the subDAO, and by proxy greater value for the HLT token.
4. Governance: veHLT can be used to participate in subDAO proposals that impact core protocol parameters, mechanisms, and operating procedures.

### *Treasury Reserve DNT Market Making Curve*

The LoRaWAN subDAO sets the programmatic treasury formula in order to provide quotes to holders of DNT who wish to redeem their holdings for underlying HNT received through. Note that at launch of the subnetwork prior to any HNT emissions from the minting contract as per the protocol score, the Helium Foundation will make a donation of 10,000 HNT into the subDAO treasury reserve in order to collateralize the airdrop specified in the emissions section.

We propose a constant function market making formula for the LoRaWAN subDAO programmatic treasury defined as per the following specification.

![https://lh4.googleusercontent.com/eGilH3SYe_CQLJOr3ISKc-xHlvNE_YUpsTMcyepOm2L7g_s5H0HRu-4zN0YCVcFKTBeCgRIA2GBlQhY-qW6bhDF727Rfv1Uz7DuJkFuA1xZJVrHE9t6nQsSJj5ZR-hSZ9jTl5Esw](https://lh4.googleusercontent.com/eGilH3SYe_CQLJOr3ISKc-xHlvNE_YUpsTMcyepOm2L7g_s5H0HRu-4zN0YCVcFKTBeCgRIA2GBlQhY-qW6bhDF727Rfv1Uz7DuJkFuA1xZJVrHE9t6nQsSJj5ZR-hSZ9jTl5Esw)

At epoch T, we denote the value of H, S, and P as HT, ST,  and PT. The programmatic treasury formula at epoch T is a function in two variables, HT, ST defined as follows:

![https://lh3.googleusercontent.com/7P_5Bha1KNPmQl2wWBHPoB6ojHfFKdnSaD208DR1vFUE2ybnAopqA6X-sVMzhHqiH5DeeDDKMY5hxKOe74j_PVcEBCoXjwetlytpeS241lgrEy_TmapfPiWUjEzyhp72kyvLiEJA](https://lh3.googleusercontent.com/7P_5Bha1KNPmQl2wWBHPoB6ojHfFKdnSaD208DR1vFUE2ybnAopqA6X-sVMzhHqiH5DeeDDKMY5hxKOe74j_PVcEBCoXjwetlytpeS241lgrEy_TmapfPiWUjEzyhp72kyvLiEJA)

For example, consider at epoch #125, the total outstanding supply of tokens for the LoRaWAN subDAO is 3.275B HLT and the total amount in the treasury reserve is 2M HNT. The programmatic treasury formula is given as follows

![https://lh6.googleusercontent.com/J_34HUWBuZl_YxNOnMv_fVkgvJKVeWtNLdZ9eZfKjYOFVjvv9LqjyB-pMmBaqpgFykNb4YcKfE7CuHDC6aX1WQORR2vlyyg4hyb_38ACZqDMjUrwVKHUhYeZYVj1QYceVwL-z3gR](https://lh6.googleusercontent.com/J_34HUWBuZl_YxNOnMv_fVkgvJKVeWtNLdZ9eZfKjYOFVjvv9LqjyB-pMmBaqpgFykNb4YcKfE7CuHDC6aX1WQORR2vlyyg4hyb_38ACZqDMjUrwVKHUhYeZYVj1QYceVwL-z3gR)

This implies that at epoch #125, any number of HLT tokens can be redeemed at a unit price of 0.00061068702 HNT.

Now consider at epoch #225, the total outstanding supply of tokens for the LoRaWAN subDAO is 3.5B HLT and the total amount in the treasury reserve is 2.025M HNT. The programmatic treasury formula is given as follows

![https://lh5.googleusercontent.com/JzoHFD4OcK-YbK8aqiR2VjsBtN8mxRK6oEae_57KhoeoXp1TGKbRWGF7NkfRByITdTcfEAAkPSkKPMfz604aTcqhNlBJ2o7YJ6TjpAUxvGJSBcUgyH4o8iDmJRQ8ejcqaa8kvK9e](https://lh5.googleusercontent.com/JzoHFD4OcK-YbK8aqiR2VjsBtN8mxRK6oEae_57KhoeoXp1TGKbRWGF7NkfRByITdTcfEAAkPSkKPMfz604aTcqhNlBJ2o7YJ6TjpAUxvGJSBcUgyH4o8iDmJRQ8ejcqaa8kvK9e)

This implies that at 100 epochs after #125 at #225, any number of HLT tokens can be redeemed at a unit price of 0.00057857142 HNT.

In epoch #225, the total outstanding supply of HLT has increased, and given inflows to the treasury reserve in HNT the resulting unit price has decreased. If the rate at which HNT flows into the treasury reserve outpaces the emission of HLT tokens, the unit price of HLT increases.

Between epoch #125 and #225, a similar repricing takes place in each individual epoch given the amount of HNT in the treasury reserve and the outstanding supply of HLT tokens.

It is possible to represent the programmatic treasury formula as a surface in euclidean space using the following vector notation in two variables:

![https://lh3.googleusercontent.com/PNzok9G-6EnVEVVWri06NcbbRffoF_f9M5eHo9ain25TT4OoG9zAFnIAowTtWqTNyI9RFC98lICBCONmQqS6uqlQXpDcXXzieywg1IXizx9YgLpzAtOUGTvDXde5Qb0U6ds-7smt](https://lh3.googleusercontent.com/PNzok9G-6EnVEVVWri06NcbbRffoF_f9M5eHo9ain25TT4OoG9zAFnIAowTtWqTNyI9RFC98lICBCONmQqS6uqlQXpDcXXzieywg1IXizx9YgLpzAtOUGTvDXde5Qb0U6ds-7smt)

Where

![https://lh5.googleusercontent.com/jAuWiuhQ3qmQCs6c4OXx7m2KsnGa7kfl6SD2ZTxlMQWdKZYuQ3uidkZm0fp7KcWQu_VbyR3GIy5JII4-Q-F9AgINVLGJAcEKA1Gzwz0DX41SvNlCei1amkaP9bSJDvl3bVBXuyT4](https://lh5.googleusercontent.com/jAuWiuhQ3qmQCs6c4OXx7m2KsnGa7kfl6SD2ZTxlMQWdKZYuQ3uidkZm0fp7KcWQu_VbyR3GIy5JII4-Q-F9AgINVLGJAcEKA1Gzwz0DX41SvNlCei1amkaP9bSJDvl3bVBXuyT4)

With S represented along the X-axis, P represented along the Y-axis, and H represented along the Z-axis, the surface looks as follows

![https://lh6.googleusercontent.com/6yhW5CXx9RReMjgPmWfhDu3vuCmgfU57tsdU8LwOTEvkErT9YDBM7GQr2xTyMiInfHV5x_WGkmPiGFez6LKZPV2ywwXMXKv3bdbIHVW33N8ll7IUT5kIAAlOtY-DGwmf8o3s-os2](https://lh6.googleusercontent.com/6yhW5CXx9RReMjgPmWfhDu3vuCmgfU57tsdU8LwOTEvkErT9YDBM7GQr2xTyMiInfHV5x_WGkmPiGFez6LKZPV2ywwXMXKv3bdbIHVW33N8ll7IUT5kIAAlOtY-DGwmf8o3s-os2)

Note that the supply of HLT tokens includes all locked veHLT tokens.

### *Oracle Operations*

LoRaWAN oracles confirm transactions and add blocks to the LoRaWAN subnetwork. They serve state data around Proof-of-Coverage challenges and data transfer events to light and data only hotspots.

Validation is performed by a set of rotating nodes known as the consensus group, which verifies transactions and ordering prior to forming a block and proposing it to the subnetwork chain. Consensus groups are elected once per epoch, and the number of members is given by the num_consensus_members chain variable (currently set at 4340).

*The Helium Consensus Protocol is based on a variant of the HoneyBadgerBFT (HBBFT) protocol. HBBFT is based on a body of research originally kicked off by Andrew Miller and the team at the University of Illinois, Urbana-Champaign.*

*HBBFT is an asynchronous atomic broadcast protocol designed to enable a group of known nodes to achieve consensus over unreliable links. In Helium’s implementation, a consensus group of [elected Validators](https://explorer-beta.helium.com/validators) receives encrypted transactions as inputs and proceeds to reach common agreement on the ordering of these transactions before forming a block and adding it to the blockchain.*

*HBBFT relies on a scheme known as threshold encryption. Using this scheme, transactions are encrypted using a shared public key, and are only decryptable when the elected consensus group works together to decrypt them. The usage of threshold encryption enables the Helium Consensus Protocol to achieve censorship-resistant transactions.*

*At the end of each epoch, mining rewards are distributed by the consensus group to the wallet addresses that have earned them.*

*Each one of the above activities is recorded in a block using the reward transaction. At the completion of each epoch, all the individual reward transactions are grouped in a rewards transaction at which point all HNT mined in that epoch are distributed.*

veHLT holders can choose to delegate their holdings to oracles of their choice or run their own oracles.

### *Proof-of-Coverage Specification*

The LoRaWAN subDAO is required to constantly interrogate hotspots using the Proof-of-Coverage challenge mechanism to ensure that hotspots are representing their locations accurately. The net results of each of these challenges are relayed to the Helium L1 after being validated by their respective consensus groups.

LoRaWAN Challenges involve three distinct roles:

1. Challenger - The Hotspot that constructs and issues the POC Challenge. Hotspots issue challenges approximately once per every 360 blocks. We propose moving this role to LoRaWAN oracles.
2. Transmitter - Sometimes called "Challengee". This Hotspot is the target of the POC challenge and is responsible for transmitting (or "beaconing") challenge packets to potentially be witnessed by geographically proximate Hotspots.
3. Witness - Hotspots that are geographically proximate to the Transmitter and report the existence of the challenge packet after it has been transmitted.

### *Data Transfer and Pricing Specification*

Data Credits are utilized in asserting new hotspots and their location on the chain, registering OUIs and associated devices, and as payment for packet transfers.

With the activation of [HIP 10](https://github.com/helium/HIP/blob/master/0010-usage-based-data-transfer-rewards.md), hotspot operators receive HNT emissions up to 32.5% per epoch and are rewarded at 1:1 rate based on dollar value of Data Credits transfers as per the [HNT Price Oracle](https://docs.helium.com/blockchain/oracles)**.** This proposal scales Data Credits rewards based on actual activity on the network, and disincentivizes arbitrageurs from taking advantage of more arbitrary distribution mechanisms for rewards.

# [HIP 37](https://github.com/helium/HIP/blob/master/0037-omni-protocol-poc.md) proposed the removal of a division between proof-of-coverage and data credits rewards entirely at the date of the second HNT halving (8/1/2023). We propose this removal happen from the launch of the Lorawan subDAO. As shown in the emissions schedule, this is reflected in the HLT subDAO.

At present, every 24 bytes sent in a packet cost 1 DC, priced at $0.00001. Data Credits are generated by burning the requisite amount of HNT as per the Helium price oracle.

The transaction is as follows:

1. A Miner receives a packet and determines who it belongs to
2. The Miner reaches the appropriate Helium LoRaWAN Network Server and offers the packet
3. The Helium LoRaWAN Network Server expresses interest in the packet and accepts delivery
4. The Miner provides the packet under the promise that the LoRaWAN Network Server will “burn a DC” in the name of the Miner

Note that it is possible to support both metered and unmetered networks. For an unmetered network, an OUI can choose to pay a fixed rate for an indefinite period of time which involves the purchase and burn of some number of data credits per minute, and attribution to hotspots after consumption occurs pro rata network traffic under the unmetered plan.

Note that all manufacturers within the LoRaWAN subDAO must **stake a minimum of 100M veHLT**. The purpose of this requirement is to increase the security of the network. In exchange for this stake, manufacturers earn 2% of HLT mined by hotspots they sold and maintain. The intention is to create incentives for manufacturers to build high quality hotspots which maximize mining output and to continue to support previously sold hotspots into the future. If at any point, a manufacturer gives ownership of maintenance and firmware upgrades to a third party, all future manufacturer rewards flow to this new entity.

### *Governance Specification*

# LoRaWAN Network is under the control of the subDAO. All subDAO proposals must come attached with code to be approved.

We propose that veHLT governance is constructed in a manner identical to veHNT governance as specified in HIP51.

Users can choose to delegate their lockup power in veHLT to all LoRaWAN DAO governance proposals. Proposals are assessed using majority and quorum thresholds defined in veHLT terms, initially proposed to be 70% and 100,000 HLT respectively.

Note that only proposals with code attached can be voted on. There are broadly three ways to use voting power within the Helium DAO.

# **Open Questions**

1. What does a migration process look like for the existing implementation onto the new structure outlined?
