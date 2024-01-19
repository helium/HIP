# HIP 77: Launch Parameters for Solana Migration

- Author: [@ChewingGlass](https://github.com/ChewingGlass),[@abhay](https://github.com/abhay)
- Start Date: 2023-02-20
- Category: Infrastructure
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

This HIP describes several parameters analogous to the chain variables of the current L1. These parameters can be changed by an update authority which will be held by a wallet requiring multiple signatures (multisig) initially held by the Helium Foundation.

The HIP proposes the following initial parameters:

- Decimals for HNT: `8`
- Decimals for MOBILE: `6`
- Decimals for IOT: `6`
- Ability to bring a proposal to a vote: `Helium Foundation`
- Vote duration: `7 days`
- Quorum: `100M veHNT`
- Epoch duration: `24h from 00:00 UTC to 00:00 UTC`
- HNT Mint Circuit Breaker: `5x the epoch amount`
- MOBILE Mint Circuit Breaker: `5x the epoch amount`
- IOT Mint Circuit Breaker: `5x the epoch amount`
- MOBILE Reward Pool Circuit Breaker: `5x the epoch amount`
- IOT Reward Pool Circuit Breaker: `5x the epoch amount`
- MOBILE Treasury Circuit Breaker: `20% of epoch amount`
- IOT Treasury Circuit Breaker: `20% of epoch amount`
- IOT and Mobile Prices to be decided via a pricing oracle similar to that of HNT.
- HNT Price to be decided via a [Pyth](https://pyth.network) price oracle
- Landrush Period: `10 days` instead of the original `7` for technical / implementation reasons
- Chain halt and Solana Launch starting on April 18th, 2023 at 4:00pm UTC

Each of the proposed variables can be changed by a governance procedure.

# Motivation

HIP-70 proposed to move from the Helium L1 to Solana to scale the Helium network. To finalize the implementation of the Solana smart programs several parameters need an initial value. These parameters are similar to the chain variables of the Helium L1 and can be changed at a later date through governance. It is important that the Helium community reaches consensus on these parameters before the migration starts.

# Stakeholders

The entire Helium community will be affected by these settings.

# Detailed Explanation

## Multisig Update Authority

We propose that a multisig wallet that requires 2 out of 3 signatures will be used to initially govern Solana's programs and parameters (hereinafter `multisig`). The `multisig` will initially be controlled by the Helium Foundation. This will be expanded to a 3 out of 5 signature multisig wallet to be governed by the Helium DAO or an elected council.

The Helium Foundation will need to be able to make changes and/or upgrades to the Solana programs quickly if there are any bugs or faults uncovered. As the programs mature and stabilize these upgrades will become less time sensitive and this will allow the `multisig` to be expanded to include the Helium DAO or an elected council.

## Decimals for IOT and MOBILE

Solana uses a 64-bit unsigned integer (`u64`) to represent token amounts. The maximum value a `u64` can hold is `18,446,744,073,709,551,615`. On the Helium L1 tokens are represented by `bones` where 1 full token is defined as 10^8 `bones`. The expected maximum supply of the MOBILE subDAO is 223.25B MOBILE which is larger than the `u64` can hold with 8 decimals. The limitations of the `u64` would mean that the maximum supply would be capped at 184.46B MOBILE. To remedy this problem we propose that the amount of decimals for MOBILE and IOT tokens will be 6. Existing token balances will be bankers rounded to the nearest token with 6 decimals of precision.

We propose that the amount of decimals of a subDAO token can be autonomously decided by the subDAO with the limitation that the maximum supply must fit inside a `u64` at the proposed precision.

## Governance Parameters

### Proposals

Solana Governance has the ability to bring proposals to a vote based on VeToken holdings. We propose that initially, the Helium Foundation `multisig` is the only one able to bring proposals to a vote. This is how the DAO currently functions on the Helium L1. A future HIP can open this up to a threshold of VeToken holdings.

### Voting Time

We propose that Helium DAO governance votes will be open for 7 days. This will initially also hold for the subDAOs but the subDAOs are free to change this parameter via their own governance.

### Quorum

We propose that the initial quorum be set at 100M. This number was achieved by taking 1% of the current HNT supply and multiplying it by an average multiplier of 75x. We feel this is a reasonable initial value given the current voter participation and the 3x landrush multiplier. We propose that this quorum can be modified by the `multisig`

### Epoch Duration

Epochs are the interval within which rewards are issued to subDAOs, and during which rewards are issued to hotspots and other rewardable entities. We propose the epoch duration to be 24 hours, running from 00:00 UTC to 00:00 UTC.

### Circuit Breakers

The Helium implementation on Solana has circuit breakers in place to prevent exploits to the smart contracts. These circuit breakers act as a protection mechanism to protect the Helium network and limit the impact of potential exploits. The circuit breakers will be adjustable by the `multisig` and through the governance process. The circuit breakers may limit legitimate use but we feel that the security benefits outweigh the drawbacks. We propose several different circuit breakers that are outlined below.

#### Mint Circuit Breakers

The Mint Circuit Breakers protect the issuance of new tokens. We propose that the circuit breaker does not allow more than 5x the epoch amount be minted within a single 24h period. Because epoch rewards are automated by Clockwork there should never be a day in which more than the normal epoch amount is emitted. The initial value of 5 allows bugs to process emissions that might be backed up by a bug. There will initially be three Mint Circuit Breakers, one for HNT, one for MOBILE and one for IOT.

#### Reward Pool Circuit Breaker

The Reward Pool Circuit Breaker protect the reward pool accounts. Tokens that are minted will wait in the reward pool account until the hotspots owner claims the rewards. We propose that the circuit breaker does not allow more than 5x the epoch amount to be claimed from the reward pool account. The drawback of this limit is that a large deployer may claim a large number of tokens might trigger the circuit breaker. There will initially be two Reward Pool Circuit Breakers, one for MOBILE and one for IOT.

#### Treasury Circuit Breakers

The Treasury Circuit Breakers protect the subDAO treasuries. The subDAO treasuries allow DNT tokens to be redeemed for HNT. We propose that the circuit breaker will allow a maximum of 20% of the treasury to be redeemed in every 24-hour period. There will initially be two Treasury Circuit Breakers, one for MOBILE and one for IOT.

### Emission Schedules

The emission schedules until 2025 are codified [in the helium program library repository](https://github.com/helium/helium-program-library/tree/master/packages/helium-admin-cli/emissions). These emission values
will need to be adjusted as more rewardable entities, like mappers, are added. The values present in these json files represent the amount that will be emitted per epoch given the current set of rewardable entities.

The full token emissions schedule as of Solana Migration can be downloaded
[here](files/0077/token-emissions-as-of-solana-migration.pdf).

### Landrush Period

HIP-51 specified a 7 day landrush period. Due to the fact that the migration will likely happen between UTC days, we feel that it is better to extend the landrush period to 10 days to guarantee that everyone in every time zone has a minimum of 7 days to get the landrush bonus.

### Launch Date

We propose that the chain halt and Solana launch should start on April 18th, 2023 at 4:00pm UTC.

### Price Oracles

On Solana, we have access to a Pyth price oracle on the HNT price. This oracle includes data from multiple exchanges, as well as market makers and other publishers on the HNT token. We propose using this Oracle instead of the existing oracle approach.

Pyth is not available for MOBILE and IOT prices, and so we propose these prices should follow a similar pattern to the current HNT price oracle on the helium L1, documented [here](https://docs.helium.com/blockchain/oracles/). During the initial few weeks post-launch, Pyth price feeds will also not be available for HNT. We propose using the same pattern for the current HNT price oracle until Pyth oracles are live.

It is necessary to know the IOT and MOBILE prices for rewards calculations.

# Drawbacks

The potential drawbacks of each of the parameters has been discussed in the section where they are defined. It is important to note that these parameters can be changed through the governance process. The `multisig` will hold the authority to change the parameters and can do so without a governance procedure in case of unintended behavior.

# Frequently Asked Questions

TBD. Questions will be added as they are presented by the community.
