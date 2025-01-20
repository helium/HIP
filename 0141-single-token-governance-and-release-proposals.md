# HIP 141: Single-Token Governance and Helium Release Proposals

- Authors: Helium Protocol Developers, [@ChewingGlass](https://github.com/ChewingGlass), [@abhay](https://github.com/abhay), [@ferebee](https://github.com/ferebee)
- Start Date: 2025-01-14
- Category: Economic, Technical, Governance
- Original HIP PR: [#1146](https://github.com/helium/HIP/pull/1146)
- Tracking Issue: [#1148](https://github.com/helium/HIP/issues/1148)
- Voting Requirements: veHNT Holders

---

## Summary and Motivation

If approved and implemented, this proposal would:

* Establish a Roadmap driven process for future Helium protocol upgrades led by the core development team, Nova Labs.  
* Simplify protocol governance by establishing a veHNT-only voting system and HNT rewards for active governance participants.  
* Unlock existing veIOT and veMOBILE positions to allow holders to convert to HNT through network treasuries.

### The Problem

The existing structure of the Helium network, with separate subnetwork voting mechanisms and a complicated DAO Utility Score, is difficult to explain, and difficult to understand. It creates multiple interlocking and conflicting incentives, and unnecessarily divides the community. Additionally, the current system of change management can introduce uncertainty for protocol developers, deployers, community members, and other participants due to the lack of a common roadmap.

### Make It Simpler

When [HIP-138][hip-138] is implemented, HNT will return as the single economic focus of the Helium ecosystem, and holders of IOT and MOBILE can exchange their tokens for HNT. Therefore, veHNT becomes a natural expression of all governance. It’s important to note that no other changes to the intrinsic mechanisms of veHNT are being proposed, specifically no changes to lockup mechanisms including Landrush.

With the introduction of Proxy Voting through [HIP-110][hip-110], veHNT holders can assign their voting power to a trusted Proxy Acount. This allows all holders of veHNT to participate in governance with minimal effort, even if they are not familiar with the detailed operation of the IoT or Mobile subnetworks.

After the return to veHNT governance, Nova Labs, as Protocol Developers of the Helium ecosystem, will establish a Proxy Account in Helium Governance alongside other Proxy Voters. By delegating veHNT to this Proxy, veHNT holders may choose to align their voting power directly with the Protocol Developers.

The Protocol Developers will publish and maintain a detailed roadmap of planned upgrades to the protocol over the coming months. The roadmap will be updated through an open process including ongoing Community Calls, and will take input from the IoT and Mobile Working Groups. 

### Votes with Code

The Helium Community will vote with veHNT on a periodic basis (initially monthly) to approve upcoming protocol upgrades proposed by the Protocol Developers. This evolution of the HIP process may be characterized as a Helium Release Process. All changes under this process must come with audited and deployable code. Each Release Vote will be kicked off using the existing Helium Monthly Community Call, and will apply to new code deployed across the Helium network. Emergency or security-related deployments that are necessary for protocol safety, as well as bug fixes, may be deployed on an ad-hoc basis, but must be announced and ratified through subsequent Release Votes.

## Stakeholders

All Helium ecosystem participants are affected by this proposal.

## Detailed Explanation

The Protocol Developers are establishing a Roadmap, to be voted on alongside this proposal, providing clarity and predictability for all network participants. Helium is one of the largest decentralized networks, with stakeholders of multiple types across two wireless protocols, and an aligned roadmap is needed to protect core Protocol Developers, builders, and token holders from uncertainty.

### January 2025 Release

As the first release under the new Helium Release Process, the Protocol Developers will release the following by February 1, 2025, once this proposal is approved and the relevant protocol and app upgrades are audited.

* Full implementation of [HIP-138][hip-138]  
  * All network rewards are issued in HNT  
  * IOT and MOBILE emissions cease
  * Rewards to HST holders cease, and the corresponding HNT is redirected to network participants  
* The DAO Utility Score is replaced by the new Protocol Score based on veHNT delegation alone
* Rewards for delegation to subnetworks are delivered from a new 6% HNT rewards pool  
* Voting activity thresholds are established for rewards to veHNT participants 
* Governance is unified under veHNT, voted directly or through a Proxy Account

The full implementation of [HIP-138][hip-138], together with the changes described below, will simplify the Helium protocol to the benefit of all participants. Further protocol upgrades are planned and are described in the section Future Releases, to be voted on at a later date.

### Completing HIP-138

[HIP-138][hip-138] intentionally left governance and the DAO Utility Score untouched pending a future proposal. This proposal aims to resolve these questions in the simplest way possible.

### Migrating to a Protocol Score Based only on Delegation

The current DAO Utility Score, if [HIP-138][hip-138] were to be implemented alone, would dramatically affect the relationship between the IoT and Mobile networks, as rational veHNT participants would chase HNT yield rather than make a market driven decision based on their actual interest in the future of one or the other network.

#### V Score Component

Under the current Utility Score, veHNT holders are economically motivated to delegate based solely on what delivers the highest return in terms of HNT, and not on what is best for the network. Depending on other factors, it can become economically infeasible to express support for IOT based on a long-term value thesis, or support for MOBILE despite its lower number of deployments.

Instead, under the current Score, the incentive becomes to maximize yield based on mathematical properties of the Utility Score, and the `V` factor does not reflect veHNT holders’ rational evaluation of the merits of the different subnetworks.

#### A and D Score Component

Active device count and Data Credit burn are backwards-looking and present-time metrics which reflect no forward-looking sentiment. For example, the IoT subnetwork is considering a change to its fee structure that could greatly increase DC burn. It also has an existing, global network ready for use. On the other hand, the Mobile network, though it has fewer active Hotspots, is growing at a higher rate. veHNT delegators should be able to weigh these factors when deciding the rewards (and therefore deployment incentives) that go to the subnetwork. It is the authors’ belief that a market driven approach, detached from the circular financial incentives of the existing Utility Score, will better decide the rewards split than the legacy model.

#### New Protocol Score

The new Protocol Score is derived from the share of veHNT delegated to each subnetwork (formerly represented by the `V` component of the DAO Utility Score), as a percentage of total delegated veHNT. It determines the subnetwork’s percentage of total subnetwork emissions.

#### Smoothing Function

To control the volatility of the Protocol Score and allow deployers to better predict their near-term earnings, a smoothing function is applied to the daily shares of veHNT delegation. Large changes in delegation will take effect gradually over a period of several months.

As a result, the implementation of this proposal will not have any large immediate effect on the HNT emission ratio between IOT and MOBILE, and the network will transition gradually from the [HIP-51][hip-51] Utility Score to the new Protocol Score.

Because all effects of delegation are gradual, governance participants can re-evaluate their delegations without time pressure as the networks evolve.

For IOT, 

- $S_{IOT}(t)$ is defined as the percentage Score of the IOT network on day $t$.
- $V_{IOT}(t)$ is defined as the veHNT delegation percentage of the IOT network on day $t$.

- $S_{IOT}(0)$ is the percentage Score of the IOT network on the day of transition, as defined by the DAO Utility Score of [HIP-51][hip-51].
- For $t>0$, let $S_{IOT}(t) = \frac{29}{30} S_{IOT}(t-1) + \frac{1}{30} V_{IOT}(t).$
- Thus, today’s Score is always $\frac{29}{30}$ of yesterday’s Score plus $\frac{1}{30}$ of today’s veHNT delegation percentage.

The Score $S_{MOBILE}(t)$ of the MOBILE subnetwork is calculated in the same way.

In this way, large swings in veHNT delegation lead to gradual changes in emissions allocation. As a rule of thumb, under the given smoothing coefficient of 30, a large change in delegation will achieve most of its effect after about 3 months.

#### HNT allocation

HNT is distributed among subnetworks similarly to the current DAO Utility Score, based on their Protocol Score as a percentage of the sum of all Protocol Scores.

### veHNT Rewards Flow

Under this proposal, rewards issued to veHNT holders will no longer be dependent on the economics of the delegated subnetwork.

Instead, all eligible holders of delegated veHNT receive a share of a new HNT Delegation Rewards Pool. This Pool is created from the 6% of subnetwork token emissions that were previously dedicated to delegation rewards in each subnetwork. Given that all subnetwork emissions are denominated in HNT with [HIP-138][hip-138], and HST emissions have ceased, the sum of all subnetwork delegation rewards as defined in [HIP-52][hip-52] and [HIP-53][hip-53] corresponds exactly to 6% of total HNT issuance.

If future HIPs adjust subnetwork emission schedules, they shall be construed to maintain this total 6% Delegation Rewards Pool unchanged, unless this provision is explicitly modified.

### Voting and Delegation Rewards

With the simplification of the Protocol Score, and the removal of extraneous economic incentives to delegate to a particular subnetwork, delegation becomes a way in which veHNT holders help decide the future of the network. In this spirit, veHNT rewards are made dependent on voting. veHNT holders can fulfill the voting requirement by voting directly, or by delegating their veHNT to a Proxy Account, provided that the Proxy votes.

Voting incentives were introduced for veIOT with [HIP-124][hip-124]. The current proposal removes independent voting with veIOT, and as a result, [HIP-124][hip-124] is repealed. The IoT Oracles rewards pool returns to its previous role.

Instead, the voting requirements defined in [HIP-124][hip-124] for veIOT will now apply to veHNT as a whole. Briefly, a delegated veHNT position will only be eligible for delegation rewards if it has voted in 2 of the last 4 veHNT votes. The following modifications apply:

1. veHNT delegation rewards that would otherwise accrue to veHNT positions which are ineligible, because they have not fulfilled their voting obligation, are burned when the position claims their rewards. These burned rewards will count towards Net Emissions, and will thus be re-emitted if below the Net Emissions threshold.
2. No Abstain vote. It is the authors’ belief that all incentivized stake must be useful. To be rewarded, a veHNT holder must either vote, or delegate veHNT stake to a Proxy Account that votes.
3. The 2-of-4 requirement only takes effect once 4 veHNT votes have occurred, beginning with the vote on this proposal.

### Stale Delegations

Under this system, there is a risk that delegations become stale. In order to prevent this, delegation choices will follow the same schedule as defined in [HIP-110][hip-110], resetting on August 1 every year. This requires participants to reassert delegations annually during the month of July in order to maintain uninterrupted delegation. Otherwise, the delegation will be deactivated, thus preventing the Protocol Score from being weighted down by stale delegations from lost or forgotten wallets.

### Releasing all veIOT and veMOBILE positions

After the passage of this proposal, no further veIOT or veMOBILE votes will occur. Therefore, the lock function on all veIOT and veMOBILE positions will be deactivated immediately, so that individual wallet holders can unlock and redeem the underlying tokens at any time, independent of lock or cooldown state.

At the time of writing, 2.89% of IOT supply and 9.54% of MOBILE supply are locked in total which represents a total of 0.078% and 0.92% of HNT supply, respectively, so the effects of these unlocks should be immaterial to HNT.

### Development Time

The provisions of this proposal, when combined with the requirements of [HIP-138][hip-138], result in significant simplifications to the entire governance and reward distribution system of Helium, when compared to the complexity of the existing system, or the implementation of [HIP-138][hip-138] on its own. This simplicity reduces the total development time required, the cost of necessary audits, and the attack surface for bad actors.

### Future Releases

As discussed above, we propose, at most, a monthly release schedule that reduces the amount of governance fatigue for network participants. At each Helium Community Call, a new Helium Release Proposal will be presented by the Protocol Developer team for the subsequent month. Each of these proposals will include an expected changelog for the next release of the protocol. Protocol Developers and community members may open Pull Requests against this proposal during the month as ideas and code are developed through Working Groups and general community discussion. Pull Requests will not be merged without audited and deployable code in relevant protocol or oracle repositories.

To provide some examples of potential future release candidates, the team has compiled a list of protocol upgrades currently under consideration for future implementation. These will be formally proposed through the Helium Release Proposal process after this HIP is approved. In no particular order:

* Cross protocol  
  * Migrate IOT and MOBILE token specific stakes/locks/fees to HNT, as recommended in [HIP-138][hip-138], such as Service Provider stakes and Hex Boosting fees  
  * Fractional rewards delegation for Hotspots or Subscribers  
  * Improved reliability of automated epoch calculations using incentivized system (i.e., “tuk tuk”)  
  * Automation of reward claims, periodic reward claims  
  * Removing the Onboarding Server  
  * Simplification of the initial onboarding and location assert transactions into one combined action to avoid partial failures  
  * Upgrade of Solana programs to use Anchor 0.30+  
* Mobile  
  * Mapping rewards adjustments based on “factors” to incentivize particular kinds of mapping  
  * Verification Mapping to create coverage map of Hotspots for Carrier planning  
  * Expanding Mapping outside of Helium Mobile subscribers  
  * Flexible pricing for data transfer based on geographies and carriers
  * Move away from asserted/checked location towards a connectivity driven “template bonus”  
* IoT  
  * Migration of denylist classifiers into an open, community managed process
  * Multi-station gateway-rs updates
  * Support for LoRaWAN 1.1 with session key filters
  * Impactful updates to IoT Proof-of-Coverage
  * Adjustment to the data pricing model for IoT based on community discussion

Note that these are all examples of potential improvements that will have an open comment period, an implementation period, and finally an approval through the Release Proposal process.

## Implementation

Given the factors described above in the section Development Time, core developers have estimated that the combined implementation of [HIP-138][hip-138] and this proposal will require less work than the implementation of [HIP-138][hip-138] alone.

### Voting

Although this proposal intends both to change the scope of veHNT governance and to remove the utility of veIOT and veMOBILE governance, this HIP will only be presented to the veHNT voting base that created the subnetwork voting systems.

That said, we believe that we should go through an open discussion process starting with the individual Working Groups as they were voted in by the IoT and Mobile communities, respectively.

It’s important to note that the DAO Utility Score has always been subject to veHNT governance, and therefore we believe that veHNT is the ultimate authority on the primary changes in this proposal.

## Alternatives

Other methods of subnetwork governance have been discussed, including the suggestion given in [HIP-138][hip-138], that would give voting power proportional to the time a veHNT delegation would be locked towards a particular subnetwork. It is the authors’ opinion that these methods would increase the complexity of the Helium ecosystem, thereby dampening voter turnout and wasting development resources.

It has also been proposed to remove the `V` score and leave everything else untouched. This would remove the ability of veHNT positions to signal their preference for a particular subnetwork, contrary to their original purpose as defined in [HIP-51][hip-51].

## Drawbacks

This proposal removes the specific voting bodies currently defined by locked subnetwork tokens. One might argue that the veHNT voting body is not as well-equipped to handle subnetwork decisions as the subnetworks themselves.

However, subnetwork voting participation has represented a small percentage of the eligible population, and Proxy Voting now provides a way for individual voters to choose which proposals they wish to focus on.

## Unresolved Questions

None

## Deployment Impact

This proposal will be implemented by Helium core developers. This proposal should be decided on prior to the implementation of [HIP-138][hip-138].

Documentation on these changes will be updated on [Helium Docs][helium-docs] by Nova Labs and Helium Foundation employees if a grant applicant to do this technical writing task is not received.

## Success Metrics

This proposal will be successful if it increases total governance participation and aligns HNT emissions to the subnetworks with the value veHNT holders place on them.

[hip-51]: ./0051-helium-dao.md
[hip-52]: ./0052-iot-dao.md
[hip-53]: ./0053-mobile-dao.md
[hip-110]: ./0110-proxy-voting.md
[hip-124]: ./0124-securing-iot-governance-through-voting-rewards.md
[hip-136]: ./0136-eliminate-iot-rewards-for-redundant-coverage.md
[hip-138]: ./0138-return-to-hnt.md
[helium-docs]: https://docs.helium.com
