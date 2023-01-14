# HIP 55: Validator Challenges

- Author(s): [@Vagabond](https://github.com/Vagabond), [@andymck](https://github.com/andymck),
  [@abhay](https://github.com/abhay)
- Start Date: 2022-02-03
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/359>
- Tracking Issue: <https://github.com/helium/HIP/issues/362>
- Status: In Discussion

# Summary

This HIP proposes a change to how Proof-of-Coverage (PoC) Challenges are generated and submitted to
the Helium blockchain to allow for further network scalability and to lower the hardware
complexity/cost of Hotspots. Specifically, it moves the responsibility of PoC Challenge creation to
Validators and consequently proposes moving the economic reward for creating Challenges to this
group as well.

# Motivation

Originally Hotspots were the only kind of entity on the network; they were responsible for block
production, Challenges/Witnesses, etc. With the switch to Validators we moved beyond that model for
block production, but we still have significant computational overhead and complexity on Hotspots as
a result of the old design and constraints of Proof-of-Coverage.

This complexity has become a significant pain point, Hotspots must now keep up with a blockchain
that is produced on significantly more powerful hardware and they must contend with an enormous
peer-to-peer (p2p) network to route Challenges and witness reports. The global chip shortage have
also made it harder to source capable hardware for building Hotspots that can meet these
requirements.

To address these issues the core developers have been working on design and implementation of an
alternative PoC Challenge mechanism we call Validator Challenges. In brief, Validator Challenges
move the role of generating Challenges to the Validator pool. This not only allows us to free
Hotspots from the burden of following the blockchain but it also moves the entities initiating
Challenges to machines with much more stable and predictable networking which reduces the likelihood
of connectivity failures. Hotspots can become clients of Validators to learn about blockchain
updates in general, whether or not they're currently being challenged, and where to deliver Witness
receipts.

# Stakeholders

Hotspot and Validator owners/operators.

# Detailed Explanation

## Description of Current Implementation

It is useful to recapitulate the current challenge process. First refer to the Detailed Explanation
section of [HIP 54: H3Dex-based PoC Targeting][hip54] which describes how a challenge is constructed
and submitted to the blockchain.

1. Once the PoC Request has appeared on the blockchain and the Challengee has been selected, the
   Hotspot attempts to connect to it over p2p (potential failure point). If successful it sends the
   challengee the data to transmit.
2. The Challengee then consults its local blockchain ledger to see if the PoC is active. This is
   another potential failure point if the Challengee is not synced.
3. The Challengee then transmits the packet and sends a receipt to the Challenger over the same
   connection from the Challenger. This is another potential p2p failure.
4. Any Hotspots observing the challenge packet then consults their local blockchain ledger to see if
   they can find the Challenger based on the packet they received and Challenge data on the
   blockchain. This is another potential failure point if the witness is not in sync with the
   blockchain.
5. If the Challenger is found, the Witnessing Hotspot attempts to dial them over p2p, another
   potential failure point.
6. Once the Challenger has decided enough blocks have passed it submits the `poc_receipt`
   transaction to the blockchain to report on the information gathered (if any). The final,
   potential failure point is if the Challenger is lagging behind the blockchain and takes so long
   to submit the receipt that the PoC has expired.

So, as can be seen from above there are a number of potential failure points in this process. These
failures are all related to the speed/size of the blockchain and the size of the p2p network. When
the network was smaller this was much less of an issue, but with over 500,000 Hotspots on the
network now and larger blocks, these failures are becoming more and more common.

An important aspect of this system is that the actual challenge entropy is kept secret until the
receipt transaction is published. This requires Hotspots to observe the actual data from the
Challenger to correctly respond to the challenge and prevents poisoning attacks. However Hotspots
can verify the challenge information against the blockchain once they see it.

## Light Hotspots & gRPC

Light Hotspots will maintain a durable gRPC (Google Remote Procedure Call) connection to one (or
many) Validators. The target Validator(s) could be random or specified. Via the first durable
connection, Light Hotspots will be streamed chain related data, events and notifications. Additional
connections can be considered ephemeral and used for lookup requests if needed.

All messages sent to a Light Hotspot from a Validator will be wrapped in a top level message
(Protocol buffer schema provided below). This message includes metadata which serves as an
attestation on behalf of the sending Validator. The attestation data includes:

- Signed payload of the message
- Block age, height, and time when the payload was signed

### PoC Challenge Creation and the Consensus Group

Today, each block on the blockchain includes metadata (BBA seen, timestamps, etc) and transactions.
With this change, each Validator will generate a set of ephemeral key pairs and a hash of the public
keys will be included in Validator heartbeat txns whilst the private key will be saved to local
state on the generating Validator. During absorb of a heartbeat txn, if the proposed keys do not
belong to a Consensus Group member they will be added to a local cache 'poc_key_proposals'. We
propose a fixed `poc_challenge_rate` parameter to be added to the chain that defines the target
number of Challenges per block. Each Consensus Group member will deterministically select a certain
number of keys from the 'poc_key_proposals' cache in order to ensure that we will meet this target.
Assuming there are a minimum of `2f+1` nodes participating in a block, we are able to reach
`poc_challenge_rate` if each Validator in the Group can select enough Challenges to fulfill this
formula:

![\frac{\text{PoC Challenge Rate}}{\frac{N-1}{3}* 2}][poc-challenge-rate]

The set of agreed on public keys hashes will then be deterministically truncated (in case there are
more than `2f+1` participating to `poc_challenge_rate` and form part of the block metadata. Selected
keys will be removed from the 'poc_key_proposals' cache. The advantage of a fixed
`poc_challenge_rate` is that regardless of Hotspot growth, this value can remain fixed unless
changed through governance and can be adjusted based on the ability for Validators to serve the
capacity needs of the network. This avoids the need for periodic changes to `poc_challenge_interval`
as we do today in order to reduce load on the network.

Upon handling a block, each Validator will inspect the public keys in the block, identify any of
their own keys, and for each, initiate a new PoC. The public key hash will be used with the block
hash to generate entropy to generate an H3 region for the Challenge. Entropy from a combination of
the associated private key hash and the block hash will then be used to identify the target within
the region to generate the Challenge itself. The region, challenge, and target will be persisted
locally on the Challenger Validator.

### Validators & Light Hotspot Communication

All Validators, whether they are in consensus or not, sync blocks normally to keep up with the
blockchain. As a part of normal processing, they will pull the public key hashes from the block
metadata and, with the block hash, generate the same entropy as the Challenger Validator to identify
the target H3 region. The Validators will then pull a list of all Hotspots within that region and
send each Hotspot connected to them a notification message informing them of a challenge within
their region. The notification provides the onion key hash of the Challenge and, more importantly,
the necessary routing data (public key and IP) to enable the Light Hotspot to connect to the
Challenger Validator.

All Hotspots, upon receipt of a challenge notification, will send a request over gRPC to the
Challenger Validator to check if they are the target.

The request will be signed by the Challengee and also include the onion key hash it received from
their Validator. The Challenger will verify the signature of the requesting Hotspot and, if it is
indeed the target, a Challenge onion payload will be returned.

Upon receipt of the Challenge payload, the Challengee will then transmit the Challenge packet as
described above and as currently exists in the Helium network.

### Observing Hotspots and Witnessing

Any Light Hotspot hearing the transmitted packet will serve as a Witness as we have today on the
Helium network. However, rather that submit their Witness report over libp2p, they will now submit
over gRPC. The Witnessing Hotspot uses the Validator(s) they are connected to as a client to lookup
the Challenger Validator by the hash of the PoC packet. The Light Hotspot then uses this routing
information to directly submit the Witness receipt to the Challenger. Please see the Attestation
section below on how the Validator providing data to Light Hotspots can be verified.

The Challenger, after the `poc_timeout` number of blocks, will create a
`blockchain_txn_poc_receipts_v2` transaction, using received Challengee receipts and Witness
reports, and submit it to the blockchain thereby completing the PoC challenge.

### Attestation and Slashing enablement

All messages originating from a Validator containing an assertion about the blockchain will be
attested. This includes messages not described in this document.

If a Light Hotspot receives a message from a Validator and needs to act on it (e.g., contacting a
Challenger Validator to submit receipts) the Light Hotspot will include the attestation in its
request to that Challenger Validator. The attestation provides evidence on behalf of the Light
Hotspot to the Challenger Validator that it received the instruction and/or data that resulted in
the said action.

If the Challenger Validator member determines the instruction/data was spurious in nature,
unsolicited, or otherwise untrustworthy then the member can decide to act on this. This allows for
future implementations where the verifiably false assertion is published, with the malicious
Validator's attestation, to allow for slashing of the Validator's stake.

Similarly, Light Hotspots themselves, if they determine the message received from a Validator is
untrustworthy, can build their own untrusted list of Validators.

### PoC Challenger Rewards

Today, the Hotspots creating PoC Challenges and submitting receipts to the blockchain are rewarded
with 0.9% of HNT rewarded per epoch. We propose that this subsidy be moved to the Validator
Challenger that is creating and collecting Challenge data and submitting this information to the
blockchain. We don't recommend any other changes at this time as it would increase the scope of
implementation. Please refer to [HIP 10][hip10] or [docs.helium.com][docs] for the details of the
current reward scheme for PoC and specifically for Challengers.

We believe that there could be a future iteration of Validator Challengers that could introduce a
separate group responsible for Challenges only but this is also too complex as an initial design.
This would also remove the ability to piggy back Challenges onto existing block production (which
will massively lower the blockchain's transaction rate).

### New Chain Variables

- `poc_challenger_type`: This chain variable allows us to control if Validators are responsible for
  creating challenges on the network. Activating this HIP requires setting this value to
  `validator`.
- `poc_challenge_rate`: This chain variable represents the target number of challenges per block. We
  propose an initial value of: `TODO`
- `poc_timeout`: This chain variable represents the number of blocks a Challenger will wait before
  collecting all available Challengee and Witness data and submitting a receipt transaction to the
  blockchain. We propose an initial value of `TODO`
- `poc_receipts_absorb_timeout`: This chain variable represents the number of blocks after the
  timeout where public PoC data will remain on the local ledger of Validators. This allows
  Validators to garbage collect this data so it can conserve space for future Challenges but ensures
  that the information is available to allow sufficient time for absorbing the transaction. We
  propose an initial value of `TODO`

### Additional Documentation

- [Protocol Buffer definitions][proto]
- [Message Sequence Diagram][message-sequence]

# Drawbacks

This is a fairly extensive change to the network and may be disruptive if not executed well. This
also somewhat disturbs the economics of the system by moving the Challenger rewards (currently 0.9%
of rewards) from Hotspots to Validators. By moving PoC Challenges away from the Hotspots, we also
lose a potential "liveness" check that can be used to determine whether or not a Hotspot is online
and instead we must rely solely on Data Transfer and PoC activity.

# Rationale and Alternatives

Simpler designs would include retaining the Hotspot initiating the Challenge, just via information
submitted/received via a Validator. This would involve less change but it would not remove the
reliance on p2p routing.

Other designs include proposals like "self beaconing" but those create a significantly weaker
security model and enables more opportunity for collusion. Such a design also would not allow for
further enhancements to how PoC packets are transmitted.

# Unresolved Questions

This plan _does_ consider and allow for Validator slashing to the extent the data payloads exchanged
between the Light Hotspots and the Validators will include attestation data. This can enable a
slashing mechanism. It does not however propose the slashing implementation itself, that could be
proposed in a future HIP.

This plan also allows for an establishment of tracking which Validators that Hotspots are using for
their source of blockchain information but it does not propose what to use that information for,
like affinity or delegation. We leave this for a future proposal as well.

This plan, finally, allows for a change to how Challenges work and would allow for multiple
challengees to be involved in transmitting packets. This could reduce the scope for collusion
between a Challengee and Witnesses and also obtain better positional information as a result of the
Challenge. This has been described in other forums as "Region" or "Multi-Hotspot" Challenges. This
is out of scope for this HIP but we imagine future work in this direction could be possible.

# Deployment Impact

Overall users should see more reliable Challenge behaviour, less data use on the Hotspot (which
makes cellular/satellite backhaul Hotspots more feasible) and effectively immediate onboarding of
new Hotspots (no need to sync the chain or load a snapshot in order to participate in PoC or
transfer Data on the Helium Network).

Hardware costs for Hotspots could potentially go down as the hardware requirements can be relaxed to
reflect the lower demands of the new challenge model.

## How will existing documentation/knowlegebase need to be supported?

Documentation will need to be updated to explain the new model, this HIP can serve as a reference.

## Is this backwards compatible?

The activation would be done via a set of chain variables which would switch the system over to this
new model, before that happens we need the new code to be merged, deployed to the fleet (routers,
hotspots, validators, node users) and this HIP needs to be ratified.

[hip54]: https://github.com/helium/HIP/blob/main/0054-h3dex-targeting.md
[proto]:
  https://github.com/helium/proto/blob/andymck/poc-grpc-msg-defs-WIP/src/service/gateway.proto#L101
[message-sequence]:
  https://docs.google.com/drawings/d/1eVTK89ob66vlcEwwoVNi0BFaCEaU2DYki8778LIRWpA/edit
[poc-challenge-rate]:
  https://user-images.githubusercontent.com/75/153673071-550eb970-4ab6-44e0-b9fc-e9b04e1b4dad.png
[hip10]: https://github.com/helium/HIP/blob/main/0010-usage-based-data-transfer-rewards.md
[docs]: https://docs.helium.com/blockchain/mining#hnt-distributions-per-epoch
