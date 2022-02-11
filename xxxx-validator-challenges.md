# Validator Challenges

- Author(s): [@Vagabond](https://github.com/Vagabond),
  [@andymck](https://github.com/andymck), [@abhay](https://github.com/abhay)
- Start Date: 2022-02-03
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Status: Draft

# Summary
[summary]: #summary

This HIP proposes a change to how Proof-of-Coverage (PoC) challenges are
generated and submitted to the Helium blockchain to allow for further network
scalability and to lower the hardware complexity/cost of Hotspots. Specifically,
it moves the responsibility of PoC challenge creation to Validators and
consequently, moves economic reward to this group as well.

# Motivation
[motivation]: #motivation

Originally Hotspots were the only kind of entity on the network; they were
responsible for block production, challenges/witnessing, etc. With the switch to
Validators we moved beyond that model for block production, but we still have
significant computational overhead and complexity on Hotspots as a result of the
old design and constraints of Proof-of-Coverage.

This complexity has become a significant pain point, Hotspots must now keep up
with a chain that is produced on significantly more powerful hardware and they
must contend with an enormous peer to peer (p2p) network to route challenges and
witness reports around. The global chip shortages have also made it harder to
source capable hardware for building Hotspots that can meet these requirements.

To address these issues the core developers have been working on design and
implementation of an alternative challenge mechanism we call Validator
Challenges. In brief, Validator Challenges move the role of generating
challenges to the Consensus Group. This not only allows us to free Hotspots from
the burden of following the chain but it also moves the entities doing the
challenges to machines with much more stable and predictable networking which
reduces the likihood of connectivity failures. Hotspots can become clients of
Validators to learn about chain updates, including if they're being challenged.

# Stakeholders
[stakeholders]: #stakeholders

Users running Hotspots or Validators.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Description of Current Implementation

First it is probably useful to recapitulate the current challenge process. First
refer to the Detailed Explanation section of [HIP53: H3Dex Targeting][hip53]
which describes how a challenge is constructed and submitted to the chain.

Once the PoC request has appeared on chain and the Challengee has been selected,
the Hotspot attempts to connect to it over p2p (potential failure point #1). If
successful it sends the challengee the data to transmit. The Challengee then
consults its ledger to see if the PoC is active. This is another potential
failure point (#2) if the Challengee is not synced. The Challengee then
transmits the packet and sends a receipt to the Challenger over the same
connection the Challenger dialled on. Tthis avoids another potential p2p failure.
Any Hotspots observing the challenge packet then consults their ledger to see if
they can resolve the challenge to a Challenger. This is another potential
failure point (#3) if the witness is not in sync with the chain. If the
challenge can be resolved to a Challenger then the Witness attempts to dial that
Challenger over p2p, another potential failure point (#4). Once the Challenger
has decided enough blocks have passed it submits the `poc_receipt` transaction
to the chain to report on the information gathered (if any). The final,
potential failure point (#5) is if the Challenger is lagging behind the chain
and takes so long to submit the receipt that the PoC has expired.

So, as can be seen from above there are a number of potential failure points in
this process. These failures are all related to the speed/size of the chain and
the size of the p2p network. When the network was smaller this was much less of
an issue, but with over 500,000 Hotspots on the network now and larger blocks,
these failure points are becoming more and more common.

An important aspect of this system is that the actual challenge Entropy is kept
secret until the receipt transaction is published. This requires Hotspots to
observe the actual data from the Challenger to correctly respond to the
challenge and prevents poisoning attacks. However Hotspots can verify the
challenge information against the chain information once they see it.


### Light Hotspots & GRPC

Light Hotspots will maintain a durable GRPC connection to a Validator.  The
target Validator could be random or specified.  Via this durable connection,
Light Hotspots will be streamed chain related data, events and notifications.

Light Hotspots can also connect to additional Validators as required.  Such
connections will be ephemeral in nature and typically for unary requests.

All message types sent to a Light Hotspot from a Validator will be wrapped in a
top level message of the type `gateway_resp_v1` (Protocol buffer schema provied
below).  This message type includes metadata which serves as an attestation on
behalf of the sending Validator. The attestation data includes:

- Signed payload of the message
- Block age, height, and time when the payload was signed

### PoC Challenge Creation and the Consensus Group

Today each block on the chain includes metadata (BBA seen, timestamps, etc) and
transactions. With this change, each member of the Consensus Group will generate
a set of ephemeral key pairs.  A hash of the public keys will be included in the
block proposals, whilst the private key will be saved to state on the generating
Validator. We propose a fixed `poc_challenge_rate` parameter to be added to the
chain that defines the target number of challenges per block. Each Consensus
Group member will propose a certain number of keys in order to ensure that we
will meet this target. Assuming there are a minimum of `2f+1` nodes
participating in a block, we are able to reach `poc_challenge_rate` if each
Validator in the Group generates enough challenges to fulfill this formula:

```
\frac{\text{PoC Challenge Rate}}{\frac{N-1}{3}* 2}
```

The set of agreed on public keys hashes will then be deterministically truncated
(in case there are more than `2f+1` participating to `poc_challenge_rate` and
form part of the block metadata.

Upon handling a block, each CG member will inspect the public keys in the block
and identify any of their own keys and for each initiate a new PoC. In running
the PoC the public key hash will be used along with the block hash to generate
entropy via which a H3 region will be selected.  Entropy from a combination of
the associated private key hash and the block hash will then be used to identify
the target within the region and subsequently the challenge itself will be
generated.  The region, target and challenge will be persisted to disk.

### Validators & Light Gateway Communication

All Validators, whether they are in consensus or not, sync blocks normally to
keep up with the blockchain. As a part of normal processing, they will pull the
public key hashes from the block metadata and, with the block hash, are able to
generate the same entropy as the Consensus Group members to identify the target
h3 region. The Validators will then pull a list of all Hotspots within that
region and send each gateway connected to them a notification message informing
them of a challenge within their region. The notification provides the onion key
hash of the Challenge and, more importantly, the necessary routing data (public
key and IP) to enable the Light Hotspot to connect to the challenging Validator.

All gateways upon receipt of a challenge notification will send a request over
GRPC to the challenging Validator to check if they are the target.

The request will be signed by the challengee and also include the onion key hash
it received from their Validator.  The challenger will verify the signature of
the requesting gateway and if it is indeed the target, an challenge onion
payload will be returned.

Upon receipt of the challenge payload the Challengee will then transmit the
challenge packet as described above and as currently in the Helium network.

### Observing Gateways and Witnessing

Any Light Hotspot hearing the transmitted packet will serve as a Witness as we
have today on the Helium network. However rather that submit their witness
report over libp2p they will now submit over gRPC. The witness uses the
Validator(s) they are connected to as a client to lookup the challenging
Validator by the hash of the PoC packet. The Light Hotspot then uses this
routing information to directly submit the witness receipt to the Challenger.
Please see the Attestation section below on how the Validator providing data to
Light Hotspots can be verified.

The Challenger, after the `poc_timeout` number of blocks, will create a
`blockchain_txn_poc_receipts_v2` txn using received receipts and witness reports
and publish it to the chain thereby completing the PoC challenge.

### Attestation and Slashing enablement

All messages which originate from a Validator and sent to a Light Hotspot will
be attested. This includes not just the messages in this document but all
messages from a validator containing an assertion about the chain.

If a Light Hotspot receives a message from a Validator and needs to act on this,
for example to contact a Consensus Group member to submit receipts, the Light
Hotspot will include the attestation in its request to that Consensus Group
member.  The attestation provides evidence on behalf of the Light Hotspot to the
Consensus Group member that it received the instruction and/or data that
resulted in the said action.

If the Consensus Group member determines the instruction/data was spurious in
nature, unsolicited or otherwise untrustworthy then the member can decide to act
on this which could include, for example publishing the verifiably false
assertion, with the malicious Validator's attestation, to the chain to allow for
slashing of the validator's stake.

Similarly Light Hotspots themselves, if they determine the message received from
a Validator is untrustworthy, can build their own untrusted list of Validators.

* [Proto definitions][proto]
* [Message Sequence Diagram][message-sequence]

# Drawbacks
[drawbacks]: #drawbacks

This is a fairly extensive change to the network and may be disruptive if not
executed well. This also somewhat disturbs the economics of the system by
removing the Challenger rewards (currently 0.95% of rewards) from Hotspots and
giving it to Validators. By moving PoC Challenges away from the Hotspots, we
also lose a potential "liveness" check that can be used to determine whether or
not a Hotspot is online and instead we must rely solely on Data Transfer and PoC
activity.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Simpler designs would include retaining the Hotspot doing the challenge, just
via information submitted/received via a Validator. This would involve less
change but it would not remove the reliance on p2p routing.

Another design would be to have a separate group do the challenges, and indeed
that may be a further evolution of this design, but was deemed too complex as an
initial design. This would also remove the ability to piggy back challenges onto
existing block production (which will massively lower the chain's transaction
rate).

Other designs include proposals like "self beaconing" but those remove a lot of
the separation of concerns that make collusion harder and would be significantly
weaker. Such a design also would not allow for further enhancements to how PoC
packets are transmitted.

# Unresolved Questions
[unresolved]: #unresolved-questions

We initially propose that the Challenger reward moves to the Validators
initiating the challenge. Although this is a relatively small change, as it
constitutes only 0.95% of all rewards today and decreases over time through the
yearly token emissions adjustments, we still believe it's important to note and
debate. Validators will be taking on more responsibility of the network and more
work that simply cannot scale on Hotspot hardware so our proposal makes an
opinionated choice.

This plan *does* consider and allow for validator slashing to the extent the
data payloads exchanged between the Light Hotspots, the Validators and the
Consensus Group will include data points that can enable a slashing mechanism to
be added at a later point.  It does not however propose the slashing
implementation itself, that will be done in a future HIP.

Additionally this plan does allow for an establishment of tracking which
Validators that Hotspots are using for their source of chain information but it
does not propose what to use that information for, that could be used in a
future improvement.

Finally this plan also allows for a change to how challenges work and would
allow for multiple challengees to be involved in transmitting packets to both
reduce the scope for collusion between a challengee and witnesses but also
obtain better positional information as a result of the challenge. This has been
described in other forums as "Region" or "Multi-Hotspot" Challenges. This is out
of scope for this HIP but we imagine future work in this direction could be
possible.

# Deployment Impact
[deployment-impact]: #deployment-impact

Overall users should see more reliable challenge behaviour, less data use on the
Hotspot (which makes cellular/satellite backhaul hotspots more feasible) and
more or less immediate onboarding of new Hotspots (no need to sync the chain or
load a snapshot in order to participate in PoC or transfer Data on the Helium
Network).

Hardware costs for hotspots could potentially go down as the hardware
requirements can be relaxed to reflect the lower demands of the new challenge
model.

- How will existing documentation/knowlegebase need to be supported?

Documentation will need to be updated to explain the new model, this HIP can
serve as a reference.

- Is this backwards compatible?

The activation would be done via a set of chain variable changes which would
switch the system over to this new model, before that happens we need the new
code to be merged, deployed to the fleet (routers, hotspots, validators, node
users) and this HIP needs to be ratified.

[hip53]: https://github.com/helium/HIP/blob/main/0054-h3dex-targeting.md
[proto]: https://github.com/helium/proto/blob/andymck/poc-grpc-msg-defs-WIP/src/service/gateway.proto#L101
[message-sequence]: https://docs.google.com/drawings/d/1eVTK89ob66vlcEwwoVNi0BFaCEaU2DYki8778LIRWpA/edit
