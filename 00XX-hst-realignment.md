# HIP ##: HST Realignment

- Start Date: 2023/05/11
- Original HIP PR: [#XX](https://github.com/helium/HIP/pull/XX)
- Tracking Issue: [#XX](https://github.com/helium/HIP/issues/XX)
- Authors: [@seidenbergerscott](https://github.com/seidenbergerscott), [@sokolalec](https://github.com/sokolalec)

# Summary

_"Aligning HST Distribution for the next wave of Helium adoption."_

This HIP addresses the misalignment in the distribution of HNT emissions skewed by HST. This HIP 
proposes that HST emissions be reduced to 5% of HNT emissions. In doing so, a larger and more
inclusive share of HNT will be emitted to current and future subDAOs, the primary engine of 
the Helium Network of Networks. 

# Motivation

The initial token distribution was decided when Helium first began in 2013. Ten years later,
Helium and its community has grown and evolved to be a highly functional, self-governing community.
Early ventures require some form of capital incentive in order to attract talented core developers
who can turn a vision into reality. The Helium community at-large is grateful and committed to the
core development teams that have propelled the People's Network to becoming the world's largest,
permissionless, decentralized network of networks. However, the HST token distribution which rewarded early builders and investors currently hinders its continued growth. 

The Helium network is now separated from the original corporate entity, Helium Inc., and is now run
by the Helium Foundation, which is charged with maintaining an equitable Helium ecosystem for all
of its stakeholders. In the [original HNT emission distribution](https://www.helium.com/token), 
early investors and Helium Inc. were allocated 35% as compensation for managing blockchain operation and governance. Today, governance is in the hands of the People, alongside the Helium Foundation. Therefore, it is no longer
necessary, nor appropriate, to continue emitting over a third of HNT to HST holders.

Governance capture is a significant risk to the health of the network. Sufficient decentralization and
fair distribution of voting power is key to mass adoption and acceptance of Helium as a legitimate 
community-run network. The concentration of HNT that flows to HST holders currently allows a few concentrated
players to have effective control over governance by converting their HNT into veHNT. 

This HIP outlines the changes required to reduce the share of HNT emissions to HST holders to 5%,
thereby putting more HNT into the wallets of those currently building the network while still 
adequately compensating the early teams that helped to build Helium.

# Stakeholders

This HIP affects all Helium network stakeholders. Most directly, it affects subDAO coverage providers, 
veHNT delegators, and HST holders. 

# Threats to the Helium Network

## 1. Avoiding designation as a security

Helium is a global, decentralized network that shouldn't change core network policies to comply with a
specific jurisdiction's securities or digital asset laws. However, core to the growth of this network
is its continued decentralization and acceptance within the larger economy. This HIP does not make legal
arguments, however, generally accepted definitions of a security involve ["Reliance on the Efforts of Others"](https://www.sec.gov/corpfin/framework-investment-contract-analysis-digital-assets).
The split of Helium, Inc. (now Nova Labs) to create the Helium Foundation was an [effort to demonstrate that](https://www.coindesk.com/business/2022/03/30/helium-becomes-nova-labs-after-raising-200m-in-fresh-capital/)
the Helium network can stand on its own as a public utility layer upon which for-profit
entities can build products and services.
Now that the network does indeed function autonomously, token distributions should reflect this.

While other successful blockchain networks should not necessarily be used as a template for the governance of Helium, they do serve as solid reference points.
Ethereum, alongside Bitcoin, has been deemed sufficiently decentralized in the eyes of global regulators.
While Ethereum began with a significant and controversial premine, [only 10% was given to core developers](https://www.galaxy.com/research/insights/breakdown-of-ethereum-supply-distribution-since-genesis/).
The Ethereum Foundation has granted or sold off most of its share of ETH, and no single individual or the original core team holds greater than 1% of the supply by the [account list](https://etherscan.io/accounts/1).
Contrast that with Helium, where initial founders, investors, and core team (totalling only 47 unique wallets) receive HNT at a rate which settles at 15% after two decades, for perpetuity.
From Helium's main net launch in 2019 through the end of 2025, those 47 wallets will have received 30.26% of all HNT (65,825,000HNT).
It will take 40 years since the creation of Helium before investors will hold less than 20% of the total supply, and that's assuming that they only hold these rewards without any additional purchasing.

The initial concentration of HNT and its continued concentration via emissions, along with even the name "Helium
Security Token (HST)" signals externally that the Helium Network is a proxy for a private company to launch its products
and services. 
The amount of HNT that has flowed to the initial team (~54,500,000HNT) is enough to sufficiently compensate the teams that have built the Helium Network to this point.
The widely circulated [Forbes article](https://www.forbes.com/sites/sarahemerson/2022/09/23/helium-crypto-tokens-peoples-network/?sh=6e9c96a73166)
highlights many of these concerns in the community.

Now that Helium has successfully migrated to Solana and does not rely on a custom-built and maintained L1 blockchain, the Helium Foundation is well capitalized to run off-chain oracles for additional rewards (a future HIP is needed to propose an implementation for community-run, decentralized oracles). 

## 2. Governance Capture

A current area of research and iterative improvement around web3 is governance.
Decentralized governance is a core feature of the Helium Network as it continues to grow; however, with the current token distribution, there is significant and growing risk that community stakeholders would be unable to [resist malicious governance capture](https://lido.fi/scorecard).
If HST holders stake their HNT to create veHNT, they could have significant ability to control the governance process.
Staking their HNT then further rewards them emissions from subDAOs, putting those at risk of governance capture as well.

Based on historical voting records, the total supply of HNT involved in the [vote is around 10%](https://discord.com/channels/404106811252408320/1093953561970352309/1096572615088427088), which means that HST holders have governance control over the network whenever they choose due to their control of the circulating supply.
HST affiliated wallets have so far declined to participate in votes as a matter of principle, and so if they choose to participate in this specific vote, that will be strong evidence to indicate that governance has already been captured.

## 3. Incentives for Infrastructure Providers (Miners)

The real value in a DePIN (Decentralized Physical Infrastructure Network) comes from economic incentives to deploy the infrastructure.
At the time of writing, both the IOT and MOBILE subDAO deployed infrastructure is only about 40% online, declining over time and correlated with a drop in the fiat denominated value of HNT. While the network should be prudent and avoid reacting to short-term, fiat-denominated price fluctuations, ignoring the incentive mechanisms that drive physical infrastructure deployment is dangerous. There
must be good faith that the network prioritizes the infrastructure providers, as they are the foundation of the Helium
value chain.

By enacting the proposed distribution change, the amount of HNT flowing to the subDAO treasuries to reward miners would increase by
about 36,205HNT per day, or 13,215,000HNT per year starting with the halving [beginning August 2023](https://github.com/helium/HIP/blob/main/HIP-solana-parameters/token-emissions-as-of-solana-migration.pdf).

# Implementation

## Prior HIPs

[HIP-20](https://github.com/helium/HIP/blob/main/0020-hnt-max-supply.md) addressed many of the
concerns and existential risk to the network in not properly incentivizing miners to provide wireless 
coverage. Without sufficient emissions allocated to miners, when the price of HNT drops, the economic
incentives to continue mining become strained. This damages the core value proposition of the network.
However, Net Emissions specifically does not address the overall distribution among stakeholders. 

[HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md) was the foundational HIP that has led
to the creation of the Network of Networks model that is the current evolution of the Helium network. It too
fails to address the distribution HNT emissions and maintains that HST holders are on equal footing as entire
subDAOs. 


## Technical

The technical implementation of this HIP would involve modifying the [`hst_emission_schedule: Option<Vec<PercentItem>>`](https://github.com/helium/helium-program-library/blob/6e2071035a16d419a5f581cb016a94a3cc479f04/programs/helium-sub-daos/src/instructions/update_dao_v0.rs#L9)
in the `update_dao_v0.rs` instruction within the `helium-program-library`. The value would have to be updated to
reflect the new 5% emission for HST holders.