# HIP 132: Scaling MOBILE Mappers

- Author: [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-09-27
- Category: Economic, Technical
- Original HIP PR: [#1086](https://github.com/helium/HIP/pull/1086)
- Tracking Issue: [#1092](https://github.com/helium/HIP/issues/1092)
- Voting Requirements: veMOBILE Holders

---

## Summary
Currently, discovery and verification mapping is limited to subscribers of a service provider approved by the MOBILE community. Since Helium Mobile is the only provider at the moment, this creates a barrier to becoming a mapper and slows down the expansion of the network. This proposal seeks to boost the number of Wi-Fi mappers by eliminating the requirement for mappers to be customers of a service provider.

## Related Previous HIPs
* [HIP 79](https://github.com/helium/HIP/blob/main/0079-mobile-poc-mappers-rewards.md) established a general framework of discovery and verification mapping and related MOBILE reward pools
* [HIP 118](https://github.com/helium/HIP/blob/main/0118-verification-mapping.md) established the framework for verification mapping

## Motivation
As the MOBILE community increasingly relies on verification mapping, and hotspot rewards become tied to verification mapping events (as outlined in HIPs 118 and 131), it's crucial to lower the entry barriers for becoming a mapper, enabling rapid growth in the number of MOBILE mappers. By removing the requirement for a subscription with a mobile service provider, the pool of potential mappers will expand. This change will also make it possible to integrate mapping functionality into third-party apps, such as crypto wallets and DePin project apps. 
Additionally, it will pave the way for the MOBILE network’s international growth by allowing Hotspot locations to be verified without needing a local service provider partner.

## Stakeholders

- Mappers - anybody will be able to become a Wi-Fi mapper by burning MOBILE tokens. The number of mappers will increase and, at the same time, the amount of rewards that each individual mapper receives will proportionally decrease.  
- Wi-Fi Hotspot Deployers - will have a higher chance of having their hotspots verified, due to the larger number of MOBILE mappers around.
- Crypto Wallet/ DePIN App developers - allowing the mapping capability in their Apps 


## Detailed Explanation
It is proposed that an on-chain mechanism be implemented that allows anybody to burn $5 worth of MOBILE tokens and become a discovery mapper for a period of 30 days. Members of the community can build user-friendly interfaces to make the above operation easy, using credit card, PayPal etc. and are free to charge users extra for the service (i.e. Nova Labs could integrate such functionality in the black Helium Wallet and charge some small processing fee for every transaction). 


Any discovery mapper will automatically get auto-upgraded to a verification mapper, following the criteria already laid out in HIP 118. Verification mappers can earn verification mapping rewards. 

If a discovery mapper is not a customer of a service provider and cannot confirm their advertised GPS location through carrier tower data, it’s proposed that they can still be auto-upgraded to a verification mapper by passing a series of random location checks. Tower correlation verifications, available to service provider customers, will remain the preferred method for confirming verification mappers, and those mappers won’t need to undergo the additional tests outlined below.
- **Variability in historic location data:** Oracles will analyze the past 30 days of a mapper's location data and compare it to the data from other mappers on the network. This will generate a probability score, determining whether the data is genuine or the result of an artificial GPS playback loop. If the score falls below a certain threshold, the mapper won’t be automatically upgraded to a verification mapper.
- **Random Skyhook check:** Mappers must grant the app Wi-Fi permission. The app will perform periodic, random Skyhook checks to see if the Skyhook location aligns with the phone’s GPS. If there’s a mismatch in the last 7 days, the mapper won’t be automatically upgraded to a verification mapper. 
- **Location trust of Hotspots being verified:** Hotspots with high location trust scores, verified by mappers or tower correlations, will serve as anchors to verify the mapper's location. If a mapper connects to a high-trust Hotspot but reports a different location, they’ll be banned from an automatic upgrade to verification mapper until the next 30-day cycle, after burning another $5.

To enable mappers to perform their function, all mappers get access to all Hotspots on the Helium Mobile network, limited to a low per session data cap, like 5Mb per session or rate limited to a low data rate that is useful for mapping but not much else. The data used by a mapper is **not** rewardable to the Hotspot it transits. But mappers will receive a share of the mapping reward emissions.

## Drawbacks
Currently, the only way to become a mapper is by subscribing to a service provider. Removing this requirement might make the role of becoming a voted service provider on the network less appealing. However, most service providers are unable to handle or receive crypto due to regulatory uncertainty in many regions, so this issue seems less relevant in the short to medium term.

By eliminating the need for mappers to be service provider customers, GPS confirmation through tower correlations can no longer be the primary security method for validating mappers. At the same time, the reliability of the proposed alternative random tests in this HIP is not fully proven. It’s likely that new methods for gaming the system may emerge, requiring future mitigation.

Additionally, it’s unclear whether many users will be willing to burn $5 of MOBILE tokens each month just for the right to map. After launch, this requirement might need to be adjusted. Potential solutions could include modifying the fee, changing the frequency of payments, or offering some amount of usable data on the MOBILE network for mappers.

## Rationale and Alternatives
One alternative would be for an existing network service provider, like Helium Mobile, to introduce a $5 paid plan that includes a small amount of data on the Helium Mobile network alongside mapping privileges. However, this approach doesn't allow third-party entities, such as crypto wallet providers or app developers, to contribute to the proliferation of mappers, which, if they could, would lead to a more centralized network.

## Unresolved Questions
It’s still unclear how to create a fully open-source, community-curated SDK for mapping that allows: (a) Anyone to integrate it into their app; (b) It to remain secure and resistant to gaming.

Initially, trusted entities like Nova Labs may need to curate the first few integrations. Moving forward, the community may need to develop a staking and voting system, similar to HIP 19, for parties looking to integrate and promote mapping functionality.

## Deployment Impact
It is proposed that Nova Labs will oversee the implementation of this HIP. This will require updates to Oracles and at least one app (such as the Helium Wallet app or the Helium Mobile app) to enable mapping without requiring a service provider subscription. The estimated implementation time is roughly X months, depending on approval and whether any substantial changes arise from community discussions.

## Success Metrics 
This HIP will be deemed successful if, six months post-deployment, 80% of the Wi-Fi radios on the network are verified by a mapper every 14 days, and at least $100K of MOBILE tokens are burned by mappers each month.
