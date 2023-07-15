# HIP xx: allow a wallet user to onboard with own funds if maker leaves network

- Author(s): @shawaj
- Start Date: 2023-07-15
- Category: technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veHNT holders

## Summary

This HIP proposes a mechanism to improve the onboarding experience for hotspot users whose makers have left the network either voluntarily or through bankruptcy. Currently, if a maker leaves the network and has run out of onboarding credits, the users are left with only cumbersome or risky ways to onboard their devices to the network. This proposal seeks to change this in a way that lets users onboard their devices in a self-service manner if their hotspot maker has left the ecosystem.

## Motivation

The key motivations for this proposal are as follows:

- an easier and safer onboarding experience for hotspot owners who have purchased from makers that have left the ecosystem and have run out of onboarding credits
- avoiding situations whereby hotspot hardware is left idle and obsolete due to inability/difficulty in onboarding, thereby reducing unnecessary e-waste

## Stakeholders

- Hotspot Owners: if a user has purchased a hotspot from a maker that has subsequently left the ecosystem and has run out of onboarding credits they will now be able to onboard their devices more easily
- Helium MCC: there will likely have to be some flag in the onboarding server to determine whether a maker is active or not. Helium Foundation will likely need to be in charge of managing this.

## Detailed Explanation

Currently, if a maker leaves the network (for whatever reason) and subsequently runs out of onboarding credits, users are left with two sub-optimal methods for onboarding new hotspots from this maker:

- using their own HNT to burn the required amount of DC to the maker wallet in question and then switching to the maker app and onboarding using the standard process. Whilst this is currently easily possible via the Helium Wallet app, it is not ideal or safe because if you burn DC to the maker wallet in this way it is not exclusively available to you for the onboarding. It is quite possible that someone else can onboard their hotspot in the interim time period between when you burn and when you try to onboard - putting your own funds at risk. The user-experience is also not nice because it requires several manual steps back and forth between different apps.
- if there is a third-party firmware for the makers devices, it is possible to get another maker in the ecosystem to "re-key" the miner (i.e. creating a new public key on the ECC) and adding it to the onboarding server under their maker as a new entry. This is safer than the option above, as you can essentially guarantee a sucessful onboard with the "new" maker. However it is also slow due to requiring a fair few manual steps by the maker (including checking that the hotspot was legitimately purchased for example), more expensive as the maker will need to charge the $50 onboarding fee as well as likely some amount for their work, and it also skews the on-chain data somewhat (for example a Syncrobit hotspot hardware rekeyed by Nebra would now show on chain as a Nebra hotspot, even though it is not). As in the above option, it is also a pretty terrible onboarding experience for the user.

This HIP proposes to solve this issue by some fairly minor changes to the current process:

- currently, if a maker leaves the ecosystem (such as Pycom, Syncrobit, Controllino have) the Helium Foundation suspends their maker key to stop them from adding more records to the onboarding server. As part of this process, a flag should be added to the onboarding server marking this maker as "suspended" or "inactive" - this could always be a reversible action (for example if the maker is subsequently bought out or rejoins the network)
- when onboarding, the Helium SDK / wallet app / maker apps can then look at this flag, and if a maker is found to be suspended and additionally has 0 onboarding credits left, it informs the user of this and allows them to optionally select to use their own HNT, performs an implicit burn to DC and onboards their hotspot all in a single action from the maker-app during onboarding

## Drawbacks

The only drawbacks to this situation are as follows:

- There is a chance that it makes makers more likely to leave the ecosystem, however this is unlikely as it would go along with their maker key being suspended meaning they cant add/sell new hotspots
- It adds a small additional effort on the Helium Foundation when suspending a maker key

Both of these drawbacks are determined to be pretty small and not blockers to this proposal.

## Rationale and Alternatives

The only real alternative is the status-quo, which is not ideal whatsoever. 

Whilst no options in the scenario of a maker leaving the ecosystem are particularly ideal, the priority should be to ensure the least-possible interruption to hardware onboarding and user participation in the network. 

The impact of not doing this is a sub-par onboarding experience for people who are already in the unfortunate situation of a maker that has let them down and left the network. Part of the reason the Helium Network has been so sucessful is the ease of onboarding and the great user experience - any ways of improving the onboarding user experience should be welcomed to ensure maximum possible uptake and to avoid perfectly capable hardware being left unused and obsolete due to a maker exiting the ecosystem.

## Unresolved Questions

The main unresolved question is whether this should be done based on a flag (i.e. only for a suspended maker as mentioned above) or should be allowed in ANY scenario where there are 0 onboarding credits left. I do not, personally, think it makes sense to allow it in a general sense as this incentivises makers to let their onboarding credits run out and hope that users pay for the onboarding themselves. This is a dangerous situation so I think it makes sense to restrict this to only suspended makers. 

The only other unresolved questions here relates to who will implement the changes:

- Helium Foundation or Nova Labs to make changes to Helium SDK / onboarding server / wallet app / maker-starter-app to allow for this functionality
- maker app creators to pull through the necessary changes to their individual apps
- Helium Foundation to manage the process of flagging the necessary maker wallets in the onboarding server

## Deployment Impact

This will be deployed via updates to the Helium SDK, the onboarding server, wallet app and maker starter app. 

Current users will not be impacted on any existing capabilities other than a much easier onboarding method in the scenario described.

This HIP is backwards compatible and can be undone or stopped entirely as it is proposed to be governed by a flag in the onboarding server.

## Success Metrics

This proposal is deemed sucessful if it improves the speed and ease with which hotspot users can onboard their hotspots to the network if their maker has left the ecosystem and has run out of onboarding credits.
