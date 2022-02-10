# Validator Challenges

- Author(s): @vagabond, @andymck
- Start Date: 2022-02-03
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

This HIP proposes a change to how PoC challenges are generated and submitted to
the chain to allow for further network scalability and to lower the hardware
complexity/cost of Hotspots.

# Motivation
[motivation]: #motivation

Originally Hotspots were the only kind of entity on the network, they did the
block production, the challenges/witnessing, etc. With the switch to validators
we moved beyond that model for block production, but we still have significant
complexity in challenges as a result of the old design and constraints.

This complexity has become a significant pain point, Hotspots must now keep up
with a chain that is produced on significantly more powerful hardware and they
must contend with an enormous peer to peer (p2p) network to route challenges and
witness reports around. The global chip shortages have also made it harder to
source capable hardware for building Hotspots that can meet these requirements.

To address these issues Helium has been working on design and implementation
of an alternative challenge mechanism we call Validator Challenges. In brief,
Validator Challenges move the role of generating challenges to the consensus
group. This not only allows us to free Hotspots from the burden of following the
chain but it also moves the entities doing the challenges to machines with much
more stable and predictable networking which reduces the likihood of
connectivity failures. Hotspots can use Validators to learn about chain updates,
including if they're being challenged.

# Stakeholders
[stakeholders]: #stakeholders

* Who is affected by this HIP?

Users running Hotspots or Validators.

* How are we soliciting feedback on this HIP from these stakeholders? Note that
  they may not be watching the HIPs repository or even aren't directly active in
  the Helium Community Slack channels.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Description of Current Implementation

First it is probably useful to recapitulate the current challenge process. First
refer to the Detailed Explanation section of the [H3Dex Targeting HIP](link when
merged) which describes how a challenge is constructed and submitted to the
chain.

Once the PoC request has appeared on chain and the Challengee has been selected
the Hotspot attempts to connect to it over p2p (failure point #1). If successful
it sends the challengee the data to transmit. The Challengee then consults its
ledger to see if the PoC is active (failure point #2 if the Challengee is not
synced). The Challengee then transmits the packet and sends a receipt to the
Challengeer over the same connection the Challenger dialed on (this avoids
another potential p2p failure). Any Hotspots observing the challenge packet then
consult their ledger to see if they can resolve the challenge to a Challenger
(failure point #3 if the witness is not synced). If the challenge can be
resolved to a Challenger then the Witness attempts to dial that Challenger over
p2p (failure point #4). Once the Challenger has decided enough blocks have
passed it submits the `poc_receipt` transaction to the chain to report on the
information gathered (if any) (failure point #5 if the Challenger is lagging
behind the chain and takes so long to submit the receipt that the PoC has
expired).

So, as can be seen from above there are a number of failure points in this
process. These failures are all related to the speed/size of the chain and the
size of the p2p network. When the network was smaller this was much less of an
issue, but with over 500,000 Hotspots on the network now and larger blocks these
failure points are becoming more and more common.

An important aspect of this system is that the actual challenge Entropy is kept
secret until the receipt transaction is published. This requires Hotspots to
observe the actual data from the Challenger to correctly respond to the
challenge and prevents poisoning attacks. However Hotspots can verify the
challenge information against the chain information once they see it.


### Light Gateways & GRPC

Light gateways will maintain a durable GRPC connection to a validator.  The
target validator could be random or specified.  Via this durable connection,
light gateways will be streamed chain related data, events and notifications.

Light gateways can also connect to additional validators as required.  Such
connections will be ephemeral in nature and typically for unary requests.

All message types sent to a light gateway from a validator will be wrapped in a
top level msg of the type 'gateway_resp_v1' ( see proto link below ).  This msg
type includes a signed payload of the msg and in addition the block height at
which the msg contents were valid.  Together these two fields serve as an
attestation on behalf of the sending validator.

### PoC Challenge Creation and the Consensus Group

Each block, in addition to metadata (BBA seen, timestamps, etc) and
transactions, each member of the consensus group will generate a set of
ephemeral key pairs.  A hash of the public keys will be included in the block
proposals, whilst the private key will be saved to state on the generating
validator.  Each consensus group member will propose ChallengeRate / (((N-1)/3)
* 2 ) to ensure if only 2f+1 nodes participate in the block we are able to run
ChallengeRate challenges per block.

The set of agreed on public keys hashes will then be deterministically truncated
to ChallengeRate and form part of the block metadata. 

Upon handling a block, each CG member will inspect the public keys in the block
and identify any of their own keys and for each initiate a new PoC.   In running
the PoC the public key hash will be used along with the block hash to generate
entropy via which a H3 region will be selected.  Entropy from a combination of
the associated private key hash and the block hash will then be used to identify
the target within the region and subsequently the challenge itself will be
generated.  The region, target and challenge will be persisted to disk.

### Validators & Light Gateway Communication

All validators, whether they are in consensus or not, as part of handling each
block will pull the public key hashes from the block metadata and together with
the block hash generate the same entropy as the CG members to identify the
target region.  The validators will then pull a list of all gateways within that
region and send each gateway in that region connected to them a notification msg
of type 'poc_challenge_notification_resp_v1' informing them of a challenge
within their region. The payload  provides the necessary routing data ( pubkey
and IP) to enable the light gateway to connect to the challenging validator and
in addition includes the onion key hash of the challenge.

All gateways upon receipt of a challenge notification will respond with a unary
GRPC request of type 'gateway_poc_check_challenge_target_req_v1' to the
challenging CG member to check if they are the target.

The request will be signed by the challengee and also include the onion key hash
it received from the validator.  The challenger will verify the signature of the
requesting gateway and if it is the target return it the onion payload.

Upon receipt of the challenge payload the challengee will then transmit the
challenge packet as normal.

### Observing Gateways and Witnessing

Any light gateway hearing the transmitted packet will serve as witnesses as
normal.  However rather that submit their witness report over libp2p they will
now submit over gRPC. The witness can lookup the challenging validator by the
hash of the PoC packet and deliver its witness report to it.

The challenger, after the PoC interval expires, will subsequently create a
'blockchain_txn_poc_receipts_v2' txn using the received receipts and witness
reports and publish to the chain as normal thereby completing the PoC challenge.

### Attestation and slashing enablement

As outlined above all messages which originate from a validator and sent to a
light gateway will be attested. This includes not just the messages in this
document but all messages from a validator containing an assertion about the
chain.

If a light gateway receives a message from a validator and needs to act on this
for example to contact a consensus group member, the light gateway will include
the attestation in its request to that consensus group member.  The attestation
provides evidence on behalf of the light gateway to the consensus group member
that it received the instruction and or data that resulted in the said action.

If the consensus group member determines the instruction/data was spurious in
nature, unsolicited or otherwise untrustworthy then the member can decide to act
on this which could include for example publishing the verifiably false
assertion, with the malicious validator's attestation, to the chain to allow for
slashing of the validator's stake.

Similarly light gateways themselves, if they determine the message received from a
validator is untrustworthy, can build their own untrusted list of validators.

[Proto
definitions](https://github.com/helium/proto/blob/andymck/poc-grpc-msg-defs-WIP/src/service/gateway.proto#L101)

[Message Sequence
Diagram](https://docs.google.com/drawings/d/1eVTK89ob66vlcEwwoVNi0BFaCEaU2DYki8778LIRWpA/edit)

- Introduce and explain new concepts.

- It should be reasonably clear how the proposal would be implemented.

- Provide representative examples that show how this proposal would be commonly
  used.

- Corner cases should be dissected by example.

# Drawbacks
[drawbacks]: #drawbacks

- Why should we *not* do this?

This is a fairly extensive change to the network and may be disruptive if not
executed well. This also somewhat disturbs the economics of the system by
removing the challenger rewards.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

- Why is this design the best in the space of possible designs?

Simpler designs would include retaining the hotspot doing the challenge, just
via information submitted/received via a validator. This would involve less
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

- What other designs have been considered and what is the rationale for not
  choosing them?

- What is the impact of not doing this?

# Unresolved Questions
[unresolved]: #unresolved-questions

- What parts of the design do you expect to resolve through the HIP process
  before this gets merged?

What to do with the challenger rewards.

- What parts of the design do you expect to resolve through the implementation
  of this feature?

- What related issues do you consider out of scope for this HIP that could be
  addressed in the future independently of the solution that comes out of this
  HIP?

This plan *does* consider and allow for validator slashing to the extent the
data payloads exchanged between the light gateways, the validators and the
consensus group will include data points that can enable a slashing mechanism to
be added at a later point.  It does not however propose the slashing
implementation itself, that will be done in a future HIP.

Additionally this plan does allow for an establishment of tracking which
validators Hotspots are using for their source of chain information but it does
not propose what to use that information for, that will be done in a future HIP 

Finally this plan also allows for a change to how challenges work and would
allow for multiple challengees to be involved in transmitting packets to both
reduce the scope for collusion between a challengee and witnesses but also
obtain better positional information as a result of the challenge.

# Deployment Impact
[deployment-impact]: #deployment-impact

Describe how this design will be deployed and any potential impact it may have on
current users of this project.

- How will current users be impacted?

Overall users should see more reliable challenge behaviour, less data use on the
hotspot (which makes cellular/satellite backhaul hotspots more feasible) and
more or less immediate onboarding of new hotspots (no need to sync the chain or
load a snapshot).

Hardware costs for hotspots will also be able to go down as the hardware
requirements can be relaxed to reflect the lower demands of the new challenge
model.

- How will existing documentation/knowlegebase need to be supported?

Documentation will need to be updated to explain the new model, this HIP can
serve as a reference.

- Is this backwards compatible?

The activation would be done via a chain var which would switch the system over
to this new model, before that happens we need the new code to be merged,
deployed to the fleet (routers, hotspots, validators, exchanges) and this HIP
needs to be ratified.


# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- What should we measure to prove a performance increase?

- What should we measure to prove an improvement in stability?

- What should we measure to prove a reduction in complexity?

- What should we measure to prove an acceptance of this by it's users?
