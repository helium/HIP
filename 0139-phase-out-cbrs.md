# HIP 139: Phase out CBRS

- Author: [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-11-14
- Category: Technical, Economic
- Original HIP PR: [#1127](https://github.com/helium/HIP/pull/1127)
- Tracking Issue: [#1128](https://github.com/helium/HIP/issues/1128)
- Voting Requirements: veMOBILE Holders

---

## Summary

This proposal establishes a schedule to permanently end rewards for CBRS radios on the Helium Network. If this proposal passes, Nova Labs will assist CBRS owners with the transition by re-flashing their CBRS equipment to stock firmware (turning it into generic CBRS equipment) and offering free Wi-Fi Hotspots to affected Hotspot operators.

## Related Previous HIPs

* [HIP 113][hip-113]: Reward CBRS as Experimental

## Motivation

Despite the community's best efforts, we were unable to establish a user-friendly path for Helium Mobile or any of Helium’s offload partners to effectively utilize CBRS radios for data offload. There are currently approximately 4,000 CBRS radios online, accounting for about 2% of overall data on the network. At the same time:

- CBRS Hotspots receive between 10-15% of all network rewards and are expensive to maintain.
- The vast majority of support tickets filed by the community are CBRS-related.
- Hosting and maintaining a cellular network core diverts resources that could be applied more productively elsewhere.

## Stakeholders

- **Wi-Fi Hotspot Deployers** - will receive higher rewards.
- **CBRS Hotspot Deployers** - will have the opportunity to receive free Wi-Fi hardware but will eventually be required to bring their CBRS radios offline.

## Detailed Explanation

All CBRS radios that received rewards between August 1, 2024, and November 1, 2024, are eligible to receive free Wi-Fi gear as follows:

- **CBRS Indoor** - 1 Wi-Fi indoor Hotspot.
- **Nova 430 or Moso Outdoor** - 1 outdoor Wi-Fi Hotspot.
- **Nova 436 Outdoor** - 3 outdoor Wi-Fi Hotspots.

Nova Labs will publish a web form for eligible CBRS radio owners to provide a shipping address within the continental US to receive their Wi-Fi gear and validate ownership of the eligible CBRS radio.

Additionally, Nova Labs will publish instructions and firmware images for all CBRS Hotspot owners to re-flash their existing CBRS equipment to stock configuration. CBRS owners may keep their stock CBRS radios. Nova will also provide instructions for all FreedomFi gateways to re-flash the hardware into generic miniPCs.

Support for onboarding any new CBRS radios will cease immediately upon passing this HIP. All CBRS radios will go offline and stop receiving rewards by March 1, 2025. FreedomFi gateways will continue to function as IoT gateways until January 1, 2026, after which Nova will end support for the FreedomFi gateways.

## Drawbacks

Helium will lose the "cool factor" associated with operating a cellular LTE network. However, practicality sometimes outweighs novelty.

It is possible that, in the future, advancements in technology and user experience with CBRS offload could improve. If this occurs, Helium will have missed the opportunity. However, this would likely require significant advancements in cell phone hardware, as well as in Android and iOS systems. The telecom industry moves slowly, so this is unlikely in the near term.

## Rationale and Alternatives

Since CBRS rewards were limited by [HIP 113][hip-113], the number of CBRS radios online has decreased. The additional complexity of requiring CDR validation has made it very difficult for CBRS equipment to earn rewards in boosted locations. Several community proposals are already circulating to make CDR validation requirements even stricter.

Overall, the network rewards algorithm has been evolving to prioritize Hotspots that pass real data from carrier offload partners. Since CBRS radios are effectively unable to offload carrier data, it is reasonable to assume that CBRS rewards will continue to decline.

Therefore, an alternative approach would be to do nothing and let CBRS fade out naturally.

## Unresolved Questions

## Deployment Impact

## Success Metrics

- All CBRS radios are offline by March 1, 2025.
- All CBRS rewards are redirected to operators of Wi-Fi radios.

[hip-113]: ./0113-reward-cbrs-as-experimental.md
