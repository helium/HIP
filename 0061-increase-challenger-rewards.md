# HIP61: Increase Challenger Rewards

- Author(s): @Wazzy95
- Start Date: 2022-05-24
- Category: Economic
- Original HIP PR: <https://github.com/helium/HIP/pull/413>
- Tracking Issue: <https://github.com/helium/HIP/issues/421>

# Summary

With PoC challenges being issued by Validators, following HIP55, there needs to be more incentive for Validators to optimise their systems and remain up-to-date, to ensure PoC runs effectively. The proposal is to reduce the Consensus rewards slice to increase the Challenger rewards slice, so that Validators are more invested in PoC.

# Motivation

HIP55 has resulted in challenges being submitted by Validators, whereas previously they were submitted by Hotspots. Validator owners do not have the same interest in maintaining and optimising the network for PoC as Hotspot owners, as their rewards for participating in PoC through challanging are relatively small in comparison to the consensus rewards. This results in some Validators not investing time and effort to optimise their systems and implement PoC critical updates in a timely manner, resulting in loss of, or unstable rewards for Hotspot owners. In addition to this, network instability may also be observed, due to longer block times, especially on reward blocks.

# Stakeholders

Hotspot owners and Validators are affected by this HIP.
Hotspot owners should see an improvement in PoC activity, as Validators pay more interest in PoC.
Validators will recieve higher rewards for challenges and therefore the optimised and up-to-date Validators will recieve more consistant rewards (not only when in Consensus).

# Detailed Explanation

This HIP aims to reduce the rewards for Consensus and increase rewards for Challenges by the same amount, therefore if all Validators remain interested in PoC the amount rewards for Validators should go mainly unchanged, however Validators will benefit from a more consistant stream of rewards from Challanging.

Below is the proposal for the new rewards pie, a reduction of Consensus rewards by 1% of the total rewards pool and an increase in Challenger rewards by 1% of the total rewards pool:

![image](https://user-images.githubusercontent.com/106148327/169998666-99854fdb-4339-4708-91b0-f5c1e1a50241.png)

# Drawbacks

With Consesnus rewards reduced, some focus may be detracted from Consensus. However, post HIP55 the state of the network is strongly linked to the performance of PoC and therefore block/epoch times are also closely tied with PoC performance.

# Rationale and Alternatives

Alternatives may include:

1) Changing the proposed redistribution of rewards to better suit network focus (e.g. reduce Consensus rewards by 0.5% to increase Challange rewards by 0.5% of the total rewards pool, as opposed to 1% previously mentioned)
2) Apply "penalties" or a PoC performance scale factor to Validators, however punitive measures should always be used with caution.
3) Remove poorly performing Validators from the PoC functionality, however this may not solve the problem as other validators will need to pick up the work.

# Unresolved Questions

The level of impact of Validator performance on PoC, and whether greater gains can be found elsewhere in the network.

# Deployment Impact

Validators will recieve less rewards if they perform poorly at PoC activities or don't keep up-to-date with the latest updates to optimise PoC.
As Validators readjust focus to PoC, Hotspots will see improved PoC stability and rewards.

# Success Metrics

1) PoC challange to reciept success rates will be higher post-HIP than pre-HIP over a given timeframe.
2) Validators will update quicker than before to implement PoC optimisations.
3) Block times during reward blocks will be reduced for a given PoC rate.
