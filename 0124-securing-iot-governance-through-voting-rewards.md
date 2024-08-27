# HIP 124: Securing IOT Governance Through Voting Rewards

- Authors: [BFGNeil](https://github.com/BFGNeil), [Siegfried-B](https://github.com/Siegfried-B), [ferebee](https://github.com/ferebee)
- Start Date: 2024-05-13
- Category: Economic, Governance
- Original HIP PR: [#1011](https://github.com/helium/HIP/pull/1011)
- Tracking Issue: [#1013](https://github.com/helium/HIP/issues/1013)
- Vote Requirements: veIOT

---

## Summary

This Helium Improvement Proposal (HIP) aims to increase IOT HIP voting turnout by offering rewards to participants who are active in IOT governance. Wallets that sufficiently participate in voting will receive IOT rewards proportional to the percentage of veIOT they control. To qualify for daily rewards, wallets must have participated in at least 2 out of the last 4 votes (including Working Group elections). Participation can be direct (the wallet owner votes) or indirect (the [HIP-110][hip-110] proxy a wallet has delegated to votes).

All future IOT votes must offer an ABSTAIN option. Voting for the ABSTAIN option qualifies as participating in a vote.
  
Voting rewards will be discontinued permanently once rewarded veIOT staking to decentralized Oracles is implemented as defined in [HIP-52][hip-52].

## Declaration

The authors of this HIP hold veIOT positions.

## Motivation

Voting on the IOT network requires veIOT, which is obtained by locking IOT tokens. Locked IOT cannot be transferred, which creates an opportunity cost of voting. This disincentive may discourage potential voters from acquiring voting power, leading to lower voter turnout.

[HIP-52][hip-52] specifies an Oracle bucket of 7% of total IOT emissions, to be shared between decentralized Oracles and the veIOT delegated to these Oracles. As specified in [HIP-70][hip-70], this bucket is currently unused, and the tokens are burned instead. The Oracles currently run by Nova Labs on behalf of Helium Foundation are unrewarded.

Once decentralized Oracles are implemented and pay IOT rewards to the veIOT holders who delegate to them, the cost of locking IOT will be offset by these delegation rewards, mitigating the current disincentive for those participating in HIP votes.

Until then, we propose to reduce the opportunity cost of acquiring veIOT voting power by paying rewards to locked IOT positions whose holders have voted in the last 2 of 4 votes. IOT Working Group elections will count towards this, as will votes cast indirectly through a proxy.

The availability of rewards is anticipated to encourage more individuals to lock more IOT for longer periods. As a result, more participants who are long-term aligned with the success of the IOT subnetwork will hold more veIOT, strengthening the network’s resistance to potential governance attacks.

This HIP requires that all future IOT votes must provide an ABSTAIN option, so that voters may fulfill their voting requirement under this HIP even if they do not wish to commit to a YES or NO vote.

## Stakeholders

All current and future holders of IOT and veIOT are stakeholders in this proposal. Participants who lock IOT benefit from rewards, and all IOT holders benefit from the long-term health and stability of the network promoted by greater governance participation.

## Detailed Explanation

1. **Emissions Apportionment:**
	- Implement a sliding scale for emissions allocated to voting rewards for IOT based on the total amount of veIOT in existence in the current epoch:
        - **0.5%** of emissions is assigned as a base level.
        - **1%** of emissions if **total veIOT** is at least **35 billion.**
        - **2%** of emissions if **total veIOT** is at least **50 billion.**
        - **3%** of emissions if **total veIOT** is at least **75 billion.**
        - **4%** of emissions if **total veIOT** is at least **100 billion.**
	- This may be implemented via a chain variable/config that is modified by the program multisig. Alerting should be established that allows the multisig to be aware of a need to modify this variable and it is expected that the change will be made within 4 epochs of passing a defined threshold.
	- With each future halvening, the tier limits are reduced by half accordingly. For example, from the 2025-08-01 halvening, the voting reward allocation shall be 1% if total veIOT is at least 17.5 billion.
	- This allocation will be sourced from the reward bucket assigned to Oracles in HIP-52, which is currently not distributed.
	- Post the implementation of decentralized Oracles, this allocation will revert to Oracle rewards, providing veIOT holders with the opportunity to earn rewards by staking to Oracles.
    
2. **Distribution:**
	- Each epoch, qualified veIOT positions are determined. A position is qualified if it has voted in at least 2 of the last 4 IOT votes. (Until 4 votes have occurred after the implementation of HIP-124, a position is qualified if it has voted in 2 votes since implementation.)
	- The IOT epoch emissions allocated to veIOT voting rewards are distributed among all qualified veIOT positions in proportion to the sizes of the positions.

3. **Existing lockups:**
	- All existing lockups stay as is. Functions for unlocking, locking, choosing decaying/constant, vote weight and unlocking remain the same.

4. **ABSTAIN vote:**
 	- Every IOT vote must include ABSTAIN as the first vote option presented. This includes IOT Working Group elections. 
	- ABSTAIN votes are not counted in the tally, so a vote will pass with 66.67% of all votes other than ABSTAIN. However, ABSTAIN votes count towards quorum.

## Drawbacks
- Rewards emitted daily to veIOT holders will contribute to the dilution of the IOT supply. While this may pose a challenge to holders of unlocked IOT, the benefits of increased voting participation are anticipated to outweigh the disadvantages of increased supply.
- Each halvening will reduce the amount of IOT allocated to voting rewards by half. If necessary, a future HIP could increase voting rewards up to the full 7% allocated to Oracles in HIP-52.

## Rationale and Alternatives

No Alternatives proposed.

## Unresolved Questions

None at this time.

## Deployment Impact

Total daily IOT emissions will increase by the amount of rewards emitted to qualified veIOT holders.

Helium Foundation has committed to developing and implementing the code required by this HIP.

### Documentation Updates

Documentation regarding staking with Helium Vote will need to be updated to reflect that staking IOT may now earn rewards.

https://docs.helium.com/governance/staking-with-helium-vote/

### User Impact

Current and future veIOT stakers will receive rewards for their lockups if and when they fulfill the voting requirements. They can decay/unlock their positions as previously.

## Success Metrics

This HIP will be considered successful if veIOT used for voting increases by at least 200% on average over the next 6 months after implementation.

[hip-52]: https://github.com/helium/HIP/blob/main/0052-iot-dao.md
[hip-70]: https://github.com/helium/HIP/blob/main/0070-scaling-helium.md
[hip-110]: https://github.com/helium/HIP/blob/main/0110-proxy-voting.md
