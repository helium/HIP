# HIP 25: Validators

- Author(s): @evanmcc, Helium Team
- Start Date: 2021-01-11
- Category: economic, technical
- Original HIP PR: [#110](https://github.com/helium/HIP/pull/110)
- Tracking Issue: [#111](https://github.com/helium/HIP/issues/111)
- Frequently Asked Questions: [FAQ](https://github.com/helium/HIP/blob/master/0025-validators.md#frequently-asked-questions)
- Status: Deployed ([audit](https://github.com/helium/miner/blob/master/audit/var-70.md))

## Summary
[summary]: #summary

Add a new class of actors to the network, called Validators.  These will be staked actors, with the intention being to run them on stronger hardware with better network connections than the current Hotspots.  They will serve the dual purpose of being eligible for block production and also, in the future, acting as proxies for lightweight (non-chain-following) gateways.

## Motivation
[motivation]: #motivation

At the current rate of growth, running block production directly on the Hotspot network is rapidly becoming unsustainable.  Gossip network usage grows linearly with the size of the network, and slow addressing updates are a common cause of long block interval times.

Legacy hardware power and size also put sharp limits on the size of the group (and hence its security).  The fact that addresses aren't static also makes it difficult to reconnect when a Block Producer crashes, also leading to longer block times.  Low powered hardware on consumer-grade internet backhaul is much more subject to DoS attacks than high-end servers on cloud-grade connections.

There are also several sub-optimal measures the core team has had to take in order to keep block times consistent on the current hardware, such as a timeout on PoC transaction validation and adjusting the PoC challenge interval, that have led to undesirable side effects.

Lastly, the network is today heavily dependent on our libp2p implementation and its ability to navigate consumer firewalls, proxies and NAT configurations. Given the complexity and variety of these setups, as well as the design of the PoC system, this has led to an appreciable percentage of all PoC challenges failing to have a corresponding receipt. While not all of these can be attributed to this situation, we believe a significant number of them are. By moving to the Validator model (and eventual changes to PoC challenge construction), Hotspots will no longer be dependent on delivering PoC receipts to other Hotspots via libp2p.

## Stakeholders
[stakeholders]: #stakeholders

While this HIP affects everyone in the network, the only real effect is that ordinary Hotspots will not be able to participate in block production, leading to a loss of the “random” HNT flow (6% of total HNT mined) to the Hotspot pool.  The participants most affected by this change are those interested in running Validators.

We also expect the Testnet process, wherein we will stand up a separate network of Validators for testing purposes and to allow Validator runners to gain operational experience, to generate interest from outside of the community, as there exist professional Staking and Validator Pools for other blockchains.

## Detailed Explanation
[detailed-explanation]: #detailed-explanation


#### Ledger changes
To make this happen, we would make a new ledger entry type for the Validators.  This entry would have the Validator's stake level and the owning account, and any other required metadata.  All HNT earned by the Validator will automatically go into the owning account and is immediately liquid.

#### Transactions
We will add 5 new transactions:
  * `gen_validator_v1`: validator pubkey, owner pubkey, stake: genesis-only txn creating a validator for testing.
  * `stake_validator_v1`: validator pubkey, owner pubkey, stake. Owner account is the funding account and description is a short public string that can be used to identify the validator., creates the validator
  * `transfer_validator_stake_v1`: new validator pubkey, old validator pubkey, old owner pubkey, new owner pubkey, stake, payment: moves a stake from validator to validator and optionally a new owner and payment
  * `unstake_validator_v1`: validator pubkey, owner pubkey, stake, release height: this starts the unlock process for the stake, returning it to the owner's account after some withdrawal period.  The validator is immediately unable to join block production groups
  * `validator_heartbeat_v1`: validator pubkey, height, version: this provides the participants in the chain information about an individual validator's version and online status
  
#### Primary Chain Variables

These chain variables are used to govern the qualifications of validators on the Helium blockchain:

  * Validator Version (`validator_version`): This version variable will be used to control the roll out of validators. Initially this value will be `1` in order to allow staking transactions to be accepted by the blockchain in advance of activating validators. When this version is updated to `2`, validators will be selected as Block Producers and this HIP is officially launched. We propose that the transition from version `1` to version `2` be the _longer_ of 2 weeks or the period needed to have at least 100 validators staked and producing heartbeats.
  * Stake (`validator_minimum_stake`): the amount of HNT that needs to be staked for the Validator to be considered for Block Producer elections. This value will initially be fixed at **10,000 HNT** and there will be no benefit of over or under staking.
  * Stake Withdrawal Period (`stake_withdrawal_cooldown`): This will be the minimum number of blocks after unstaking when the stake will be returned to the owner's account. This will be set to **250,000 blocks** at the launch of staking (at `validator_version` = `1`) and a block height deadline needs to be provided by the validator owner at unstaking. An additional variable (`stake_withdrawal_max`) will also be available to prevent validator operators to set their withdrawal deadline too far in the future.

#### Operational Chain Variables

These variables are tuning parameters that will be used to manage validators during and after launch. They primarily manage liveness and penalties for poor performance that will be taken into account during elections:

* `validator_liveness_interval`
* `validator_liveness_grace_period`
* `validator_penalty_probability_factor`
* `penalty_history_limit`
* `dkg_penalty`
* `tenure_penalty`

Details about these variables will be provided in [developer documentation](https://docs.helium.com).

#### Staking in depth ...

Stake is unlimited, however in the current proposal there are no benefits to overstaking. Overstaking and other features such as delegation will be subject to the HIP community approval process.

Please see open questions for how overstake may be applied to returns. We expect a discussion in the community to help resolve exactly how this should work and will update the HIP to reflect that discussion.

#### Hardware and Networking

Validator nodes will need large disks for storing the chain and the ledger, and strong (but relatively modest by modern server standards) CPUs and RAM.  An AWS T2.large or xlarge should work fine.

The node will need to have a static IP and few ports (currently 2154 and eventually port 443) open to the internet.  A DNS resolvable hostname is strongly recommended.   Networking speed is variable, but load is largely symmetrical when producing blocks, so good upstream is recommended.  Most cloud machines will be fine, but e.g. a cable modem might struggle.  We don't recommend running these machines on consumer network connections.

## Drawbacks
[drawbacks]: #drawbacks

While this does lock "average" users out of the block producer's pool of returns, that pool shrinks, relative to each individual spot, as the network grows.

Realistically, there is no alternative that allows for large network growth other than getting block production onto bigger and more secure CPUs.

## Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

- What other designs have been considered and what is the rationale for not
  choosing them?

Other designs:
  * Cloud Miners: Each Hotspot has a proxy in the cloud that is responsible for running its block production responsibilities and watching the chain for PoC responsibilities.  Since each cloud validator is rarely in the consensus group, this leads to weird provisioning scenarios and multi-tenancy issues.  If a miner can assume that it will be in the group relatively regularly, it's easier to cost out and simpler to do capacity planning for (and avoids collisions where an overcommitted cloud miner cluster gets too many members at once).
  * Most DIY Hotspot setups follow the same model as Cloud Miners
  * Switching to another chain to run on has been determined to be currently infeasible due to limitations on storage and private computation 

- Why is this design the best in the space of possible designs?

  * I've added some details in the above section, but in addition to those benefits, this also leads to a very clean separation of responsibilities between spot owners and validator runners, whose jobs do not look especially similar.
  * Allows us to scale the network better as more light gateways and full nodes get added to the network.



- What is the impact of not doing this?

More and more resources will need to be poured into the P2P aspect of the design, and we'll eventually need to add a layer of "stronger" validators in any case to keep up with transaction scaling.  Since we're always going to be held back by slow/lower memory group members, we will be limited in the complexity of the features that we can add and the stability of the network will continue to suffer.

## Unresolved Questions
[unresolved]: #unresolved-questions

- How does overstake affect election chances?  Linearly?  Diminishing returns? etc.
- What are the most desirable evolutions for this feature that are too complicated for the initial version?
- Do we want to limit (at least initially) the number of nodes in order to put a floor under earnings?  We could link this to the on-chain oracle price, potentially.

## Deployment Impact
[deployment-impact]: #deployment-impact

Deployment impact will be minimal, other than an increase in the stability of block times.

## Success Metrics
[success-metrics]: #success-metrics

We should see an increase in the stability of block times.

We should be able to increase the number of validators in the block production group without disruption.

We should see people eagerly staking new validators as a measure of the appeal of the idea.

## Frequently Asked Questions
[faq]: #faq

### Q: How will Validators impact existing Hotspot owner rewards?

A: In the current proposal Validator nodes will earn the 6% rewards for consensus group participation. This is the same percentage that Hotspots/Gateways currently earn for performing the same work. 

### Q: Does this mean as a Hotspot owner I'm losing out of those 6% rewards?

A: Technically yes, but practically it is increasingly unlikely your Hotspot would have been chosen among the 16 out of the entire pool of Hotspots. With the current pool there's a 0.034% chance and this percentage decreases as the network continues to grow. Also, with the Validators block production becomes more stable which means mining rewards are allocated on a more consistent basis.  

### Q: What’s the minimum number of Validators needed? Is there a cap?

A: The current proposal is 100 with no cap to the maximum number of Validators that can participate. We will have a separate chain var that we will activate Consensus Group election via Validator that can be manually activated after we reach the proposed threshold.

### Q: How much HNT does it require to stake and become a Validator?

A: The current proposal is 10,000 HNT. 

### Q: Is overstaking permitted? If so, what’s the benefit?

A: Initially there will be no overstaking. We'll decide at a later time via the community process if there's overstaking, what kind we'd allow, and what it will mean.

### Q: How long is the cooldown period (the length of time the staking amount is locked)?

A: The current proposal is for 250,000 blocks which is approximately 5 months.

### Q: How many HNT rewards can a Validator earn?

A: It depends on the number of Validators and how often a Validator is randomly chosen to participate in the consensus group. 

### Q: After staking and the block cooldown period would the Validator need to restake the 10k HNT to keep operating?

A: The stake for a validator is perpetual rather than periodically renewed. Unstaking requires submitting an unstake transaction, after which the cooldown period begins.  After the cooldown period, the initial stake is returned to the owners account.

### Q: How quickly will I receive rewards from staking?

A: Rewards are not locked up and if your Validator node is elected into the Consensus Group, the rewards will be allocated at the end of the epoch.

### Q: How will Validators be chosen to participate in the consensus group? How many?

A: Validators will be randomly chosen similarly to how Hotspots/Gateways are chosen. For the initial mainnet launch there will be 16 but this number will quickly increase. 

### Q: Can multiple Validators be associated with (staked from) a single wallet?

A: Yes.

### Q: How can I participate and host a Validator node? Join the testnet?

A: Stay tuned we will have signup and instructions in the coming weeks.

### Q: How can I prepare to run a Validator node on the testnet?

A: Check out the miner software and run it on the server you want to use. Note you'll also need a recent Rust and a C/C++ tool chain. Currently supported erlang version, OTP 22.
- Miner software [here](https://github.com/helium/miner#installing-miner-from-source). 
- Instructions on how to run a miner [here](https://docs.helium.com/mine-hnt/build-a-packet-forwarder/#run-the-miner).

### Q: What do I need to run a Validator node?

A: Running a Validator node will be up to the user to choose to DIY, either on premise or in the cloud. We will learn more after running the testnet, but based on early tests at least:
- an AWS EC2 instance T2 large or xlarge
- Stable IP and few ports (currently 2154 and eventually port 443) open to internet
- DNS resolvable hostname strongly recommended
- Running on stable network connections (without things like proxies, NAT, firewalls, etc.), load is largely symmetrical when producing blocks, so good upstream recommended. 
- It is not suitable or recommended to attempt to run from a home internet connection.
