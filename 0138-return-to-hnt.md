# HIP 138: Return to HNT

- Author: [@ferebee](https://github.com/ferebee), [@JMF](https://github.com/JMFayal), [@abhay](https://github.com/abhay)
- Start Date: 2024-11-08
- Category: Economic, Technical, Governance
- Original HIP PR: [#1119](https://github.com/helium/HIP/pull/1119)
- Tracking Issue: [#1120](https://github.com/helium/HIP/issues/1120)
- Voting Requirements: veHNT Holders

---

## Summary

If approved and implemented, this proposal would phase out the subnetwork tokens introduced through HIPs [51][hip-51], [52][hip-52], and [53][hip-53] (IOT and MOBILE) and the network would return to rewarding participants directly in HNT. Additionally, HNT emissions allocated to HST holders would end and be redirected to the MOBILE treasury until the next halvening (August 1, 2025). Post halvening, these rewards will be issued, like existing emissions, to Hotspot owners and other network participants via the Utility Score. Finally, unissued HNT (approximately 4.2 million) from the Helium L1 would gradually fund the MOBILE treasury.

Moving to a single token simplifies the Helium ecosystem, making it more understandable for current and future network builders and more accessible to the crypto community at large. Using HNT as the sole reward currency also corrects the imbalances created by the treasury system. Specifically, MOBILE network participants would see immediate increases in the value of their rewards, while IOT participants’ rewards would continue to be supported post-halvening as the network grows through ongoing community investment.

Overall, this proposal would increase rewards for current and future network participants of all networks.

## Motivation

### Simplicity

The current multi-token system is complex, making it challenging for new users to understand the role of each token. Members of the crypto community also find it difficult to evaluate interconnected tokens and the mechanisms through which they accrue value, which deters investment in network coverage and ecosystem growth.

Historically, the Helium ecosystem has debated the distribution of value among the various tokens, including ideas to introduce demand-side burn for MOBILE and a potential subnetwork fork from HNT. These discussions often create friction within the community and can distract potential newcomers.

[HIP-51][hip-51] introduced a guiding principle: if all networks contribute value to Helium through HNT, then all networks benefit.

In recent years, the IOT and MOBILE subnetworks have significantly contributed to Helium’s growth, with independent tokens helping the ecosystem expand beyond IOT by supporting MOBILE even during volatile market periods. Today, with the economic paths of both subnetworks becoming clearer and token volatility decreasing, a unified focus on building networks with HNT is achievable and beneficial.

### Builder Rewards

As the MOBILE network matures, it’s evident that MOBILE rewards are valued lower in HNT terms than the HNT emissions allocated to the MOBILE treasury. If MOBILE network builders received direct HNT rewards instead, their rewards would increase by about 2.5 times in HNT terms, creating a strong incentive for continued network development.

Meanwhile, IOT’s value is closely aligned with its treasury support, and it remains a vital part of the ecosystem. This proposal seeks to maintain that support.

## Stakeholders

All Helium Ecosystem participants are affected by this proposal.

## Detailed Explanation

This proposal suggests several tokenomic changes to simplify the Helium ecosystem and promote future network development.

At a high level, we propose to:

1. Discontinue HST emissions beginning with the start of “Phase 1” (defined below), redirecting HST emissions to the MOBILE treasury. This would continue until the next halvening.
2. Discontinue IOT and MOBILE Emissions at the start of “Phase 2” (also defined below) and reward participants directly in HNT based on the Utility Score.
3. Recognize the 4.2 million unissued HNT from Helium L1 after [HIP-20][hip-20] and begin emitting these tokens directly into the MOBILE treasury over time throughout “Phase 2” until the next halvening.
4. At the next halvening, Phase 2 would end. Subsequently, the HST share of emissions would be distributed among subnetwork participants according to the Utility Score.

The existing IOT and MOBILE treasuries remain operational and governed by veHNT governance. Holders of subnetwork tokens may continue to hold them, or may exchange them for HNT at any time through the treasuries. The exchange rate of the MOBILE treasury will continue to improve until the end of Phase 2 due to the supplements defined in (1) and (3) above.

The distribution schedule within each subnetwork remains under the control of subnetwork governance, and is unchanged by this proposal. All subnetwork rewards including veHNT delegations are now distributed in HNT.

Subnetwork governance remains in place using the existing tokens IOT and MOBILE, which will remain available to trade on the market, though emissions cease. A suggestion is made for a future HIP that could shift veIOT and veMOBILE to a new mechanism derived from veHNT, while promoting long-term alignment to subnetworks in a way similar to the current system. Alternative forms of subnetwork governance may be proposed by the community, to be decided by a future veHNT vote.

This proposal does not address other functions of the subnetwork tokens, which remain unchanged until addressed in future HIPs.

### Reward Payout

HNT distribution between IOT and MOBILE subnetworks continues to follow their DAO Utility Scores as per [HIP-51][hip-51] and [HIP-88][hip-88]. HNT will be rewarded directly to participants via the same claim mechanism they are familiar with, rather than deposited in the subnetwork treasuries.

Rewards will be distributed according to the existing subnetwork structure and remain subject to subnetwork governance. For example, the 6% of subnetwork token emissions rewarded to delegators will instead be rewarded as 6% of the HNT awarded to that subnetwork.

Emission shares which are unallocated (such as Oracle rewards) or partially unallocated (potentially MOBILE Service Provider rewards) will be burned unless a future HIP specifies otherwise.

### Treasuries

Treasuries retain their current HNT balances. Existing IOT and MOBILE wallet balances remain unchanged, and holders can continue to hold, or can redeem for HNT at any time at the treasury rate.

### Value Imbalances

Due to market factors, the IOT treasury is well-funded relative to IOT network contributions, whereas a large portion of early MOBILE rewards were minted without a backing of treasury HNT.

Currently, IOT trades at its treasury rate to HNT, while MOBILE trades at a speculative premium, possibly reflecting expected future value. As a result, current rewards and valuations don’t fully match the underlying HNT emissions.

1. Higher Value of IOT Emissions: IOT rewards are valued higher in HNT than the HNT emitted to the IOT network, based on Utility Score.
2. Current Strong Exchange Rate for IOT Tokens: IOT converts to HNT at a strong rate, though this may decline as MOBILE network revenue increases, and HNT emissions to IOT decrease.
3. Lower Value of MOBILE Emissions: MOBILE rewards are worth less in HNT than the HNT emitted to the MOBILE subnetwork, due to lower HNT funding of the MOBILE treasury relative to subnetwork utility.
4. Market Premium on MOBILE Tokens: MOBILE trades 1.4 times higher than its treasury rate.

If subnetwork emissions were to shift to HNT without adjustments, potential effects would be:

- IOT network builders may see reduced HNT value of rewards.
- IOT holders would benefit, with a fixed IOT:HNT treasury rate.
- MOBILE network builders would benefit, with HNT rewards valued 2.5 times current MOBILE rewards.
- MOBILE holders would lose speculative premium, reducing their holdings’ value closer to the treasury rate.

This proposal introduces provisions to counteract these potential disadvantage.

### Subnetwork Governance

Subnetwork governance remains in force, and this proposal doesn’t modify the existing system of governance using veIOT and veMOBILE, as derived from locked IOT and MOBILE tokens. While no new subnetwork tokens will be minted, participants can acquire voting rights by purchasing tokens on the open market and locking them.

Eventually, as existing IOT and MOBILE tokens are redeemed through the treasury, a new method of assigning subnetwork voting rights will become appropriate. This proposal recommends that the Helium community enact a new mechanism through a separate HIP, decided by veHNT vote. As an example, the following method is suggested.

A new form of veIOT and veMOBILE could be introduced, based on the delegation of veHNT to subnetworks. Instead of locking IOT and MOBILE tokens, delegators of veHNT could lock the delegation of their veHNT to a particular subnetwork, for a duration of between 0 and 1 year, similar to the existing lockup of the subnetwork tokens, thereby signaling their dedication to a particular subnetwork. In return, they would receive, on a linear scale, between 0 and 1 “new veIOT” or “new veMOBILE” for each veHNT whose delegation has been locked to that subnetwork. These new governance tokens could replace the existing subnetwork governance tokens when a sufficient number of them has been created.

However, in the interest of simplicity, this proposal leaves this decision up to further discussion by the community.

### Supply-side uses of IOT and MOBILE

Subnetwork tokens are currently used for various supply-side operations within subnetworks, such as hex boosting in MOBILE. While IOT and MOBILE tokens will continue to exist after the implementation of this proposal, and can therefore still be used for these purposes, subnetworks are encouraged to adjust these operations to use HNT in the future through subnetwork governance.

## Implementation

### Phased Approach

1. Phase 1 redirects HST emissions to the MOBILE treasury. As this is a fairly straightforward change, it would require light implementation and security review. It could likely be deployed within weeks of passing the HIP.
2. Phase 2 is the bulk of work for this proposal. It is expected to take less than three months of work, but requires significant security review and UX improvements. Users would need to claim rewards as they have done in the past, but would receive HNT instead of IOT or MOBILE. We propose an implementation date on or before 2025-01-15. It would be a goal of the core developers to ensure this phase could start as soon as possible.
3. The remaining changes would be implemented prior to the next halvening, which is currently scheduled for August 1, 2025.

### HST Reallocation

With discontinued treasury emissions, MOBILE holders could lose value due to the low funding rate of the MOBILE treasury. This proposal reallocates HST emissions to balance this.

By contrast, IOT holders benefit without a treasury subsidy, as their strong treasury rate is preserved when IOT emissions cease at the beginning of Phase 2.

#### MOBILE Treasury Adjustment

Given that the MOBILE treasury is underfunded by a factor of 1.4 relative to the market value of MOBILE, this proposal redirects HST emissions to the MOBILE treasury from the beginning of Phase 1 until the halvening, thereby improving the treasury rate over time. If Phase 1 were to begin on January 1, this would be a subsidy of approximately 2.6M HNT.

#### IOT Rewards Post Halvening

During Phase 2, the HNT rewarded to IOT participants may be less than the HNT value of the rewards previously emitted as IOT tokens, as long as the surplus funding of the IOT treasury has not yet been fully redeemed through treasury swaps.

To compensate for this, the additional HNT emissions from HST which are redirected towards the IOT and MOBILE ecosystem beginning with the halvening, comprising 29% of total HNT emissions in the year beginning on August 1, 2025, will be shared between the IOT and MOBILE subnetworks according to the DAO Utility Score, and the Utility Score as specified in HIP-51, including its A factor, will remain in effect.

### Unissued HNT Adjustment

Following HIP-20, Helium experienced L1 outages, leaving 4.2 million unminted HNT. This proposal gradually mints these 4.2 million HNT to the MOBILE treasury from the start of Phase 2 until the halvening.

## Alternatives

Another way to move to HNT as the single token of the Helium ecosystem would be to redeem all subnetwork tokens for HNT automatically in a single operation. While this is simpler conceptually, it would involve coordination with external entities holding MOBILE tokens, and could inconvenience holders of subnetwork tokens who face external constraints on the timing of their trades.

The community has discussed other mechanisms to improve MOBILE builder rewards in real terms, in order to encourage buildout of the MOBILE network, including forms of direct burn of MOBILE tokens. However, [HIP 51][hip-51] has established HNT burn as the sole medium of buy-and-burn as payment for demand-side operations, so that all demand-side revenue accrues first to HNT. Changing this mechanism risks damaging the confidence of current and future participants in the stability of the Helium ecosystem.

## Drawbacks

Any change to Helium tokenomics demands the attention of holders of the tokens involved. While this proposal aims to simplify the Helium ecosystem and make it more approachable in the long run, not all participants will immediately benefit to the same degree.

## Unresolved Questions

This proposal does not address uses of IOT and MOBILE that extend beyond rewards, such as subnetwork governance and supply-side operations. Subnetwork tokens remain available and may be used for these purposes temporarily.

However, it is suggested that new mechanisms for these functions, based on HNT, be implemented by future HIPs.

## Deployment Impact

This proposal will be implemented by Helium core developers. An initial investigation of the work required suggests that its phases can be completed by the proposed start dates.

## Success Metrics

This HIP is successful if the simplified tokenomic system helps to unify the community, encourage MOBILE buildout, and reduce confusion for outside observers.

[hip-20]: https://github.com/helium/HIP/blob/main/0020-hnt-max-supply.md
[hip-51]: https://github.com/helium/HIP/blob/main/0051-helium-dao.md
[hip-52]: https://github.com/helium/HIP/blob/main/0052-iot-dao.md
[hip-53]: https://github.com/helium/HIP/blob/main/0053-mobile-dao.md
[hip-88]: https://github.com/helium/HIP/blob/main/0088-adjustment-of-dao-utility-a-score.md
