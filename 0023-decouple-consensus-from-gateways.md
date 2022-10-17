# HIP 23: Decouple Consensus From Gateways

- Author(s): @cvolkernick
- Start Date: 2020-12-15
- Category: Technical
- Original HIP PR: https://github.com/helium/HIP/pull/97
- Tracking Issue: https://github.com/helium/HIP/issues/101
- Status: Closed

# Summary
[summary]: #summary

Changes the structure & process involved in forming consensus on the network - primarily by separating concerns of miners (providing verifiable coverage) and consensus group (securing the network / block formation).

# Motivation
[motivation]: #motivation

In its current state, consensus takes place onboard miners, or in the cloud in the case of "light gateways" with cloud-based miners. This HIP proposes moving away from the former and toward the latter as a standard, by moving consensus away from miners and onto dedicated cloud-based or otherwise privately operated server farms. By separating the concerns of miners (involved in tandem with gateways/packet forwarders) and consensus group, the two can be better optimized to perform their respective duties.

Presently, there is a compromise of optimization, as hardware and software needs are at odds with one another; the most optimized approach for gateways/miners (coverage providers) and consensus group (security / data integrity providers) are distinct and different. Considerations for each are as follows:

Gateways (presumed as onboard miners):

- Lightweight; both in form factor & design complexity
- Economic; lowest cost to achieve the same outcome optimally
- Security; inability to compromise and/or repurpose hardware for malicious purposes (gaming)

Consensus Group:

- Performant; performs necessary compute tasks at peak efficacy/efficiency (fastest, low compute overhead, most energy/cost efficiency)
- Reliability; maintains highest uptime, least timeouts, least dropped/failed transaction confirmations
- Security; robust against potential gaming, attacks, etc., and does not allow for powerful and/or bad actors to compromise the system at scale or via brute force.

# Stakeholders
[stakeholders]: #stakeholders
  
All current and future hotspot owners will be affected by this change. Miner owners will be given a new option to opt-in to stake & participate in CG for a marginal staking fee (opted-out by default).

There will also be a new class or "role" of operator created -- validator pools/nodes. These operators will obviously have stake, as they are brought into existence via this HIP.

Community debate / discussion will be solicited via Discord in the respective hip-23-move-consensus-off-miners channel, and here in git comments.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Each miner on the network is a "constituent", with independent interests. Constituent miners can delegate their vote ("stake") in the collective network to a delegated pool entity "representative". There is no monetary cost to do so; the only potential cost is the net effect of your chosen delegate pool's election being less rewarding than another potential pool's. As an alternative approach, miners can be given the option to "opt-in" to a per-epoch stake, and then provided a list of available validator pools to delegate their votes to. From a UX standpoint this would look something like the following:

1) User opens app to "Hotspots" page.
2) User selects a particular miner's settings as currently exists (gear option on the miner panel).
3) User is presented a toggle on this settings page, which opts-in/opts-out from staking to participate in CG.
4) Any miners opted-out would not participate in CG nor receive CG awards as a result (opt-out is default when a new miner is onboarded or existing miner is transferred to a new owner).
5) Any miners opted-in would be "billed" a staking fee from the owner wallet each epoch, which would in turn be delegated to the consensus pool of chosing (explanation follows).
6) When opting-in, user would be presented a list of available staking pools, along with any relevant metrics for making the delegation decision. Some examples might be:

- Average Rewards Paid Per Epoch
- Pool Uptime (% of the time actively available to participate in elections)
- Success Rate (% of elected cycles without dropping due to performance-related reasons, e.g. timeouts, stalls, dropped transactions, etc).

Reallocation of delegate votes is allowed once per epoch, but you are not eligible for election in the epoch you change your vote in, for obvious reasons.

Alternatively, a user could be presented a "global configuration" page for stake, such that they select which miners are opted-in and which aren't, and can even delegate some miners to one pool and other miners to another.

Delegate pools represent their constituents interests (to the degree they wish to continue to maintain and/or expand their constituency), and therefore are free to incentivize staking with rewards distributions as they see fit. This creates competitive forces within the market of available delegate pools and incentivizes each pool to be the most generous, performant, and reliable.

Each delegate pool stakes an amount to be determined more or less arbitrarily (say here e.g. 10,000 HNT) to enter the Validator Congress (Consensus Group). These pools would operate similarly to how "scores" previously did; the delegate pool would be heavily incentivized to operate on more high-compute machines, as important factors such as uptime, successful consensus (not timing out, etc.), and other reliability metrics can be used to score a pool's performance and hence determine it's likelihood to enter the Validator Congress and participate in consensus "duties".

Slashing techniques (partial or full loss of stake) may be employed, if this reliability score falls below a certain threshold, or for other reasons not considered here.

**Staking Elaboration**

There are technically two separate and distinct stakes here:

1) Validator Pool (Node) Entry Stake - this is required of a new pool to begin obtaining delegates and participating in CG. This pool is not involved in rewards; it simply is "locked" for as long as the validator wishes to participate in CG elections. It may also be desired to layer on some complexity here to incentivize pool operators to be consistent, reliable, and predictable (such as a "cool down" period required once a stake has been placed, so they are required to participate a certain duration before recalling stake, or requiring a waiting period before re-staking).

2) Constituent / Delegate Stake - this is required of individual constituent miners who are opting-in to staking and delegating their stake to validator pools / nodes. If a miner does not opt-in, they will not be charged a staking fee each epoch, and will not be eligible to receive CG rewards as a result. If miners opt-in, they will be billed the epoch stake at the initiation of each epoch period, and paid out any respective reward if their delegated stake is elected to and successfully participates in CG. These collections will constitute the reward pool for the elected pools (and by extension, their constituent delegator miners). Because of this, the rewards pool will grow and shrink respectively according on participation levels. If more miners stake, there is a greater stake at play. If less, then the opposite. This allows the reward pool to remain scaled to the current level of involvment and reward appropriately relative to "risk" or "chance".

# Drawbacks
[drawbacks]: #drawbacks

- There has been concern around consensus as a whole that it may become "exclusive", in the sense that the "average Joe" miner may lose the ability to be competitive in a stake-based pool where earning opportunity is closely correlated to earning capacity (i.e. the more miners one has, the more influence they have on the ability to join CG).
- There may be unforeseen opportunities to game CG introduced not covered or considered here. It is the author's perspective that because delegate votes are tightly coupled 1:1 with miner population, this should provide a check on concentration of influence, as there is a material cost to acquiring and operating additional miners required to obtain additional "directly-controlled" votes (as opposed to needing to "pitch" or "campaign" to delegate voters to obtain others' vote(s)).

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Decoupling of consensus from miners is likely inevitable, as there are a variety of negative impacts caused by running consensus on low-powered devices (primarily raspberry pis). There is also a great deal of discussion around light gateways, and of course the existing implementations of semi-light gateways ("regular" gateways with their miners decoupled away in the cloud). These two likely evolutions are quite synergistic when considered together, and there are other proposals which would further enhance this architecture design, e.g. [Move PoC challenge construction to Consensus Group](https://github.com/helium/HIP/pull/41).

Without this decoupling of miners and CG, the network performance is likely to suffer, as again, the optimal configurations of miner/gateways and performance of CG are directly at odds. Miner owners will likely prefer to highest cost/benefit of cheaper miners doing the same job as the more expensive counterparts, while consensus is a highly computationally intense process that is not well-suited for this arrangement -- each has different priorities, and hence cannot be optimized in the current tightly-coupled state.

# Unresolved Questions
[unresolved]: #unresolved-questions
  
  - Economic incentives : There are many up for debate but likely comes down to opinion and popularity. The initial thoughts here are intended to inspire debate and constructive criticism and elicit improvements in all areas suggested.
  - Technical implementation details : The considerations herein ane mainly from a "brainstorming" perspective that takes place at a high conceptual level. These considerations are made in the macro sense, but are inadequate for technical level implementation details. More expert knowledge on the current technical workings of Consensus and it's compatibility with the suggested methods is desired / welcome.
  - There are many potential second and third order effects / changes that may be inspired or caused / necessary with this large-scale and quite fundamental change to the system-level design of consensus group functioning. Some examples have been cited above -- light gateways, moving certain responsibilties to CG (such as challenge construction).
  - Staking : Staking is not necessarily a monolith, so alternative methods could be proposed or supplemented/exchanged in place of the methods briefly discussed here.
  - Effects on Consensus Group Rewards : CG rewards currently account for 6% of all reward distributions per epoch. It's to be determined how the rewards pool will be impacted.

Consensus Group currently 

# Deployment Impact
[deployment-impact]: #deployment-impact

- Current users will be granted a new ability to stake earnings. As staking is involved, and the process is now opt-in as opposed to default (e.g. "random consensus group election"), any network partipants who do not wish to participate (opt-in) to staking will no longer be involved in the consensus process.
- It's currently unclear as to what existing functionality will be "backwards compatible" here, as a lot will hinge on the specific implementation details that are hashed out.
- Existing documentation will almost certainly need to be overhauled to the extent that it exists, as the process of consensus will potentially fundamentally change.

# Success Metrics
[success-metrics]: #success-metrics

Success for this HIP can be measured in several ways. First, improved consensus performance overall should be emphasized. This can be measured by improvement of CG participants dropping / timing out, material reduction in consensus group stalls, and perhaps even reduction in block times (if this is so desired...it is the author's understanding that there is a desire to hold block times as close to ~60s as possible, pending correction). Given there are also issues of individual miners crashing due to being underpowered and being elected to CG, it would follow that a successful implementation of cloud / distributed consensus would cause less of these problems to occur.

It should also be considered that there are potential economic implications to this change, as well. HIP 16 implementing random consensus selection appears to be widely popular within the community due to more equity of opportunity and more widely distributed rewards. Among these considerations are lone wolves, who rightfully have concerns about any changes that would result in them being at an inherent disadvantage. A successful implementation of these changes to consensus should ensure that these concerns are considered and that consensus group election considerations do not adversely effect the changes implemented successfully in HIP 16.

Fundamentally, success should be tightly-coupled with roughly the same metrics that this HIP proposes validator pools are judged by. Some potential metrics to collect/report on:

- Uptime (% of the time pool is online and operational; this will obviously affect its ability to be elected and participate effectively in CG).
- % or # of timeouts or otherwise failing to succesfully confirm a transaction / form blocks
- Rewards paid to delegates (there are a couple of ways you could go with this...you could either base this on a formula from performance metrics to determine validator payout, which is in turn distributed accordingly 1:1 to constituent / delegate miners, or allow the flexibility to enable validators to model their own pay structures, which is yet another way for validator pools to politick and appeal to constituents / garner votes.
