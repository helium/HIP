# Launch Parameters for Solana Migration

- Author: [@ChewingGlass](https://github.com/ChewingGlass),[@abhay](https://github.com/abhay)
- Start Date: 2023-02-20
- Category: Infrastructure
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

In the course of the migration to the Solana blockchain and prior to the finality date of
2023-03-27, several parameters need to be finalized by the community. This includes everything from
governance settings, circuit breaker settings, and the number of decimals in our tokens to prevent
overflow.

The largest change proposed here is to change MOBILE and IOT tokens from 8 decimals to 6 decimals.
Solana uses the u64 data type to represent token supply, and given the hundreds of billions of
tokens in MOBILE and IOT, with 8 decimals, this would cause an overflow.

The second largest change is the formation of a multisig to govern the helium programs and
parameters. Currently, changes to the blockchain are governed by a master key that flips a chainvar
after validators have upgraded. On Solana, programs are upgradeable by an updated authority.

# Motivation

HIP-70 proposed a move to Solana to scale the helium network. Now that the implementation of this
The HIP is well underway, we should finalize the settings for when we move to the Solana network. While
most of these settings can be changed, it is important we reach consensus before flipping the
switch.

# Stakeholders

The entire Helium IOT community will be affected by these settings.

# Detailed Explanation

## Decimals for IOT and MOBILE

Solana uses a uint 64 to represent token supply. The smallest denomination of any Helium token has
been represented by “Bones,” 10^8 of which make up a full token. The u64 on Solana is used to
represent bones.

A u64 has a maximum value of `18,446,744,073,709,551,615`. Given a maximum supply of 223.25B MOBILE,
this yields 223.25B \* 10^8 = `22,325,000,000,000,000,000` bones, which will overflow the Solana
u64. This would freeze the ability to mint new tokens at the u64 maximum.

We propose redefining a “bone” as the smallest denomination of a particular token and allowing subdaos
to have different decimal denominations. We further propose delimiting IOT and MOBILE with 6
decimals on the Solana network.

For existing tokens, any wallet-owning bones cut off by this decimal will be bankers rounded to the
nearest whole bone with 6 decimals.

## Multisig Formation

We propose that a ⅔ multisig controlled by the Helium Foundation be used to initially govern Solana's
programs and important parameters. This will be expanded to a ⅗ multisig and can
eventually be governed by the DAO itself or an elected council.

In the early days of the migration, the foundation will need to be able to make changes/upgrades to
the contracts quickly, as there may be bugs that have yet to be uncovered. We expect this to happen less frequently as the programs mature and stabilize. Because of this, it is important that the
foundation hold the ability to upgrade these contracts initially.

Because these contracts hold the mint authority to all tokens, it is important that the authority is
safeguarded. Changes to this authority, whether it be to governance or an elected council, should be
taken with care, as we do not want to expose these programs to a governance attack (one individual
buying up tokens to vote to mint more tokens).

## Governance Parameters

### Proposals

Solana Governance has the ability to limit the ability to create proposals based on veToken
holdings. We propose that the two entities that may create proposals are

The Helium Foundation Multisig Any holder with more than 30m veHNT

### Voting Time

We propose that votes take course over 7 days

### Quorum

We propose starting with a 100m veHNT quorum. This number was achieved by taking 1% of the current
HNT supply, and multiplying it by an average of 75x multiplier. We feel this is reasonable given the
current voter participation and the 3x landrush multiplier.

We propose that this quorum be editable by the Helium Foundation multisig as needed to achieve a
reliable quorum.

### Epoch Length

Epochs are the interval within which rewards are issued to subdaos. The current epoch length setting
is 24 hours.

### Circuit Breakers

The Helium implementation on Solana has circuit breakers in place to prevent exploits to the smart
contracts. These breakers act as a rate limiter to keep from an entire account being drained or an
unreasonable amount of tokens from being minted. A good example of these circuit breakers is the one
on the SubDAO treasury. If a subdao treasury were to go from 100 HNT immediately down to 20 HNT,
there is a good chance the system is not functioning as intended and there is an exploit. Instead,
the circuit breaker system can dictate that not more than 20% of a treasury can leave per day.

This has a drawback in that this may delay functionality for legitimate use cases. These parameters
can be changed, but this HIP proposes the following initial parameters.

We propose that these circuit breakers also be initially governed by the Helium Foundation multisig.
This will allow us to quickly add additional limits to token flow in the case of an attack.

#### HNT Mint Circuit Breaker

This circuit breaker wraps HNT minting for rewards issued every epoch. We propose a circuit breaker
that does not allow more than 5 epochs worth of HNT to be minted within a single day. Because epoch
rewards are automated by Clockwork, there should never be a day where more than one epoch is
emitted. However, these systems could experience a bug and be backed up. Allowing 5 epochs worth
gives us time to repair and turn the cranks.

#### MOBILE and IOT Mint Circuit Breakers

This circuit breaker wraps DNT minting for rewards issued to hotspots/other rewardable entities each
epoch. We propose a circuit breaker that does not allow more than 5 epochs worth of DNT tokens to be
minted within a single day. Because epoch rewards are automated by Clockwork, there should never be
a day where more than one epoch is emitted. However, these systems could experience a bug and be
backed up. Allowing 5 epochs worth gives us time to repair and turn the cranks.

#### MOBILE and IOT Reward Pools

Once tokens are minted for MOBILE and IOT, they go into a reward pool account, awaiting the hotspot
owners to claim their rewards. This circuit breaker ensures that the account cannot be drained. We
propose a limit of 5 epochs worth of tokens per day. The drawback of this limit is that if a large
deployer claims a large number of tokens, this breaker could be thrown.

#### Treasury Circuit Breakers

These circuit breakers control the MOBILE and IOT treasuries, which allow swapping DNT tokens for
HNT.

We propose that these circuit breakers are completely closed for the first month of Helium on Solana. This will allow ample time for the subdao treasuries to fill with HNT.

After one month, we propose these treasuries be limited to 20% within 24 hours.

### Emission Schedules

The full token emissions schedule as of Solana Migration can be downloaded
[here](./HIP-solana-parameters/token-emissions-as-of-solana-migration.pdf).

# Drawbacks

Every one of these parameters has potential drawbacks, but they can be changed through either (a)
governance voting, or (b) the foundation multisig.

# Frequently Asked Questions

TBD. Questions will be added as they are presented by the community.
