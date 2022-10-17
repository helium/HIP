# HIP38: Validator Oracles

- Author(s): @cvolkernick
- Start Date: 2021-09-06
- Category: Economic / Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/272>
- Tracking Issue: <https://github.com/helium/HIP/issues/282>

# Summary

From Helium Docs:

>HNT converts to Data Credits at a rate pegged to $.00001 , and so the blockchain requires a canonical HNT/$USD price for this conversion. Beginning in June 2020, the Helium blockchain started using a system of decentralized price oracles to supply the $USD to HNT price used for on-chain for burn transactions. (This system is inspired by the Maker Foundation's Oracle usage.)
>
>To find this price, nine oracles (***this number may change in the future***) periodically submit HNT/$USD prices. Once the blockchain has enough new price data, it will calculate a new HNT/$USD price that will remain valid until enough new, valid oracle inputs are submitted, triggering a new price revision.

This HIP proposes not only changing this number, but also expanding the pool of those who are able to make submissions. It proposes empowering any staked validators with the existing `price_oracle_submission` & allowing them to commit price oracle submissions as chain-blessed Oracles.

# Motivation

This change improves upon the original foundation of decentralized pricing of the Helium Network as a whole by extending the pool of respected Oracles in a way that does not comprimise the security of the network or any of its participants. The more participants involved in the pricing of a market, the more acurrately said price reflects the true value of the network to all that particpate in it.

# Stakeholders

- *Who is affected by this HIP?*

Anyone using the network is affected by this change. The price oracle is a key heuristic in price discovery & the reflection of network utility value. However, the principle affected parties would be current price Oracles & any individuals or organizations currently staking validators or looking to do so in the near to long term.

- *How are we soliciting feedback on this HIP from these stakeholders?*

The usual community discourse (discord, github, social media platforms, etc) should be sufficient, as it aligns with the general principle of the proposed change that those participating most actively in the network & who are the most invested - finanically or otherwise - will have the most refined & acurrate impressions of the true network value / utility.

# Detailed Explanation

The summary & motivations above effectively communicate the entirety of the proposed changes. There are no new concepts introduced, as the required changes should only change who is able to make price submissions, not fundamentally how the submissions [or the rest of the price Oracle process] function.

# Drawbacks

- *Why should we* ***not*** *do this?*

An argument could be made that being financially invested in the network while having direct input into the network token pricing may be a conflict of interest. However, this same argument in reverse could be said to *support* the change, as having a high degree of investment in the network as a whole should incentivize for proper valuations to secure the stability & maturation of the network as opposed to short-term gains (validators are already required to be staked for a long period of time to begin with).

# Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

- *Why is this design the best in the space of possible designs?*

1) It is the most aligned with the core mission values of decentralized governance. Expanding the pool of pricing particpants only serves to diverisfy perspectives & come to consensus around true value.
2) It requires the least amount direct human involvement (trust proxy), in terms of governance & oversight. Submissions are done on-chain & can only be submitted by heavily-staked network participants (validators).
3) It requires the least amount of change & disruption. The only technical changes required [to my knowledge] would be to expand the existing `price_oracle_submission` to any staked validators.

- *What other designs have been considered and what is the rationale for not
  choosing them?*

Another alternative would be using an off-chain chain of authority governance -- e.g. empowering someone like DeWi to govern a federation of Oracles & decide through some other, also off-chain process who can & can not contribute to price Oracle data. This seems to be a less than ideal approach, as it involves a lot of human biases & gatekeeping, as opposed to an objective, uniform standard.

- *What is the impact of not doing this?*

Keeping the existing (extremely small) group of Oracles & price submissions is antithetical to the culture of "The People's Network"; at time of writing there are 150,000+ hotspots & 2,000+ validators on the network, yet only *9* price Oracles, the majority of which are completely unknown (by design, to credit). This is less aligned with the transparency of the blockchain on-chain methods provide.

# Unresolved Questions

- *What parts of the design do you expect to resolve through the HIP process
  before this gets merged?*

  - The amount of transparency that is desired and/or should be involved in who price Oracles are, and where their vested interests lie, both inside & outside of the Helium network itself.
  - Any unconsidered benefits / drawbacks to expanding the pool of price discovery agents.
  - Any unconsidered technical limitations .

- *What parts of the design do you expect to resolve through the implementation
  of this feature?*

Any additional complexities involved in a more fine-grained on-chain pricing process that may not have been foreseen (e.g. arbitrage implications).

- *What related issues do you consider out of scope for this HIP that could be
  addressed in the future independently of the solution that comes out of this
  HIP?*

These changes could potentially be expanded upon at a later date with amendments, providing an ability to scrutinize parties submitting price data; a system similar to maker accounts could be implemented to audit/identify price Oracles (perhaps any KYC-related enhancement(s) could be Oracle-specific, meaning making Oracle submissions opt-in for validators). However, it could simply be the case that anonymity is preferred and more ideal, for reasons communicated in the current price Oracles documentation.

# Deployment Impact

- *How will current users be impacted?*

Current users will only be impacted indirectly as a function of any implications downstreal of price. Validators will gain the option to contribute price Oracle submissions. Current oracles should theoretically be unaffected, as their inputs would simply migrate to this new process. They may lose relative impact as their voting weight is diluted by addtional pricing participants (more Oracles).

- *How will existing documentation/knowlegebase need to be supported?*

Existing documentation should simply need to be updated to reflect the additional oracle participants & the process of staking validator(s) & opting in to Oracle status; the rest of the Oracle pricing process should remain more or less the same.

- *Is this backwards compatible? If not, what is the procedure to migrate?*

The process should be fairly straightforward to roll back as the added validator priviledges could be revoked & the "legacy" Oracle process should remain unaffected; current Oracles may simply continue to participate via validator staking.

# Success Metrics

- *What metrics can be used to measure the success of this design?*

The first obvious sign of success would be a significantly increased number of Oracle price submissions, along with a much larger group of submission participants. This also should add increased visibility into involved parties & their submissions in a way that can be freely & openly visualized by third parties or directly in Helium Explorer.
