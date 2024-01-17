# HIP 95: Self-Onboard Hotspots After Maker Exit

- Author(s): [@shawaj](https://github.com/shawaj), [@Sophi](https://github.com/sophi), [@ke6jjj](https://github.com/ke6jjj)
- Start Date: 2023-07-15
- Category: Economic, Technical
- Original HIP PR: [#744](https://github.com/helium/HIP/pull/744)
- Tracking Issue: [#775](https://github.com/helium/HIP/issues/775)
- Vote Requirements: veHNT holders

## Summary

There are three types of hotspots available when manufacturers leave the network (regardless of whether updates and support are taken over by another business):

1. Onboarded hotspots that have had location asserted.
2. Onboarded hotspots that have not had their locations asserted.
3. Un-onboarded hotspots in customer or reseller possession.

The onboarding fee is collected as a part of the hotspot price by the manufacturer, but the onboarding and assert fees are not collected from the maker-wallet when the hotspot is shipped, but are delayed and collected when the hotspot is onboarded by the user. This allows for the manufacturer to sell a hotspot and not have DC available to pay for the onboarding.

This HIP proposes a mechanism to improve the onboarding experience for hotspot users whose makers have left the network either through bankruptcy, business closure, failure for compliance, involuntary loss of staking key, the former business being taken over by a new business owner or any other reason. Currently, if a maker leaves the network and they have run out of onboarding DC credits, users are left with only cumbersome or risky ways to onboard their devices to the network. This proposal seeks to change this in a way that lets users onboard their devices in a self-service manner if their hotspot maker has left the ecosystem.

This proposal excludes data-only hotspots as their owners can already onboard using their own wallet.

## Motivation

Over the last year, as the number of manufacturers has increased, so have the number of hotspots in the market. Some manufacturers find that they are no longer able to stay in business due to financial issues, and others are removed from the network for non-compliance. When a manufacturer exits the network, they may leave sold hotspots in the hands of customers who are then unable to onboard the hotspots to the network and/or assert the hotspot’s location.

The IOT location assertion and onboarding fee (Currently total $45 paid in DC) and MOBILE location assertion and onboarding fee (Currently total $50 paid in DC) in most cases have already been paid by the hotspot owner as part of the cost of purchasing the hotspot. Currently, when a manufacturer leaves the network, if these fees haven't been paid the hotspot owner is required to pay these fees if the maker account lacks funding for these fees.

There is currently no safe mechanism ([see below for further details](#detailed-explanation)) for hotspot owners to directly pay those fees from their wallet.

Therefore the key motivations for this proposal are as follows:

- an easier and safer onboarding experience for hotspot owners who have purchased from makers that have left the ecosystem and have run out of onboarding credits
- avoiding situations whereby hotspot hardware is left idle and obsolete due to inability/difficulty in onboarding, thereby reducing unnecessary e-waste

## Stakeholders

- Hotspot Manufacturers: if they leave the network, this gives their customers a path to still onboard the hardware, minimising the hardship for their customers
- Hotspot Owners: if a user has purchased a hotspot from a maker that has subsequently left the ecosystem and has run out of onboarding credits they will now be able to onboard their devices more easily
- Helium MCC: there will likely have to be some flag in the onboarding server to determine whether a maker is active or not. Helium Foundation will likely need to be in charge of managing this
- Network Users: it is bad for coverage if we have perfectly good hardware in the field which can't be onboarded
- Hotspot App Developers/Creators: will need to implement changes in the app for the option to pay from the customers wallet

## Detailed Explanation

Currently, if a maker leaves the network (for whatever reason) and subsequently runs out of onboarding credits, users are left with two sub-optimal methods for onboarding new hotspots from this maker:

- using their own HNT to burn the required amount of DC to the maker wallet in question and then switching to the maker app and onboarding using the standard process. Whilst this is currently easily possible via the Helium Wallet app, it is not ideal or safe because if you burn DC to the maker wallet in this way it is not exclusively available to you for the onboarding. It is quite possible that someone else can onboard their hotspot in the interim time period between when you burn and when you try to onboard - putting your own funds at risk. The user-experience is also not nice because it requires several manual steps back and forth between different apps.
- if there is a third-party firmware for the makers devices, it is possible to get another maker in the ecosystem to "re-key" the miner (i.e. creating a new public key on the ECC) and adding it to the onboarding server under their maker as a new entry. This is safer than the option above, as you can essentially guarantee a sucessful onboard with the "new" maker. However it is also slow due to requiring a fair few manual steps by the maker (including checking that the hotspot was legitimately purchased for example), more expensive as the maker will need to charge the IOT 4.5M DC/45$ (Plus 5M DC/50$ for MOBILE) onboarding fee as well as likely some amount for their work, and it also skews the on-chain data somewhat (for example a Syncrobit hotspot hardware rekeyed by Nebra would now show on chain as a Nebra hotspot, even though it is not). As in the above option, it is also a pretty terrible onboarding experience for the user.

However, onboarding/ assertion fees can be deducted from the hotspot owner’s wallet instead of the maker wallet. This could use the same mechanism by which data only Hotspots are onboarded and the Helium Wallet App can assert IOT or MOBILE locations paying from the owner's wallet not the maker wallet.

**Currently the onboarding process looks like this:**

- Maker uploads records containing many Hotspots and info about them.
- These records tie the Hotspots to the specific maker
- User purchases Hotspot
- Via the onboarding process (via QR code or app), which inititially creates the Hotspot NFT
- This happens by having the hotspot generate and sign a transaction, which is used to verify physical possession of the hotspot.
- Onboarding server validates that the hotspot key signed belongs to the set of hotspots specified by the maker.
- User onboards Hotspot by paying the Onboarding Fee(s). Currently the maker pays the DC fees to onboard. This could be changed to the initiating wallet for makers that have exited.

**Assumptions:**

- We trust the hotspots that are in the database for the hotspot manufacturer (if we don't, such as in the case of Deeper, there are already mechanisms to deal with this - such as Denylist and suspending the maker)
- That the manufacturer and not a bad actor actually added those hotspots to the database (again, this is probably outside the scope of this HIP)

**This HIP proposes to solve this issue by some fairly minor changes to the current process:**

- currently, if a maker leaves the ecosystem (such as Pycom, Syncrobit, Controllino have) the Helium Foundation may suspend their maker key or stop them from adding more records to the onboarding server. As part of this process, a flag should be added to the onboarding server marking this maker as defunct. When that flag is flipped, the transaction that is returned for onboarding has the hotspot owner as the payer
- when onboarding, the Helium SDK / wallet app / maker apps can then look at this flag, and if a maker is found to be defunct/suspended/inactive and additionally has 0 onboarding credits left, it informs the user of this and allows them to optionally select to use their own HNT, performs an implicit burn to DC and onboards their hotspot all in a single action from the maker-app during onboarding
- it is proposed that the MCC / Helium Foundation are in charge of the flag and deciding when it should be flipped
- it is proposed that the flag only be flipped if a maker explicitly leaves the network and requests this from the MCC/Foundation, or if they run out of onboarding credits and do not respond to the MCC/Helium Foundation for at least 30 days after being prompted
- once flipped, it is proposed that this typically be a non-reversible action. If for example if the maker is subsequently bought out and therefore needs to rejoin the network, this could be left up to the MCC/Foundation to decide whether the maker can be reinstated or whether they would need to create a new HIP-19 application.

## Drawbacks

The only drawbacks to this situation are as follows:

- There is a chance that it makes makers more likely to leave the ecosystem, however this is unlikely as it would go along with their maker key being suspended meaning they cant add/sell new hotspots
- If the Makers don't implement the changes required in their app, the process this HIP is designed to resolve will not be implemented for that Maker.
- It adds a small additional effort on the Helium Foundation when suspending a maker key

Both of these drawbacks are determined to be small and not blockers to this proposal.

## Rationale and Alternatives

The only real alternative is the status-quo, which is not ideal whatsoever.

Whilst no options in the scenario of a maker leaving the ecosystem are particularly ideal, the priority should be to ensure the least-possible interruption to hardware onboarding and user participation in the network.

The impact of not doing this is a sub-par onboarding experience for people who are already in the unfortunate situation of a maker that has let them down and left the network. Part of the reason the Helium Network has been so sucessful is the ease of onboarding and the great user experience - any ways of improving the onboarding user experience should be welcomed to ensure maximum possible uptake and to avoid perfectly capable hardware being left unused and obsolete due to a maker exiting the ecosystem.

## Unresolved Questions

- If a maker does not have a working app, a hotspot owner could have lost the means of accessing the onboarding process. However, if the maker was using the main foundation onboarding server, in this scenario the hotspot owners would likely to be able to use another third party app by another provider. If this is not the case, or it is a private onboarding server, a grant could be provided by the Helium Foundation to take over the app and/or to move the onboarding records to the main onboarding server.

## Deployment Impact

**Who will implement the changes:**

- Helium Foundation or Nova Labs to make changes to Helium SDK / onboarding server / wallet app / maker-starter-app to allow for this functionality
- Maker app creators to pull through and implement the necessary changes to their individual apps
- Helium Foundation / MCC to manage the process of flagging the necessary maker wallets in the onboarding server

This will be deployed via updates to the Helium SDK, the onboarding server, wallet app and maker starter app.

Current users will not be impacted on any existing capabilities other than a much easier onboarding method in the scenario described.
Makers will have to deploy a new version of their App which is compatible with this HIP.

This HIP is backwards compatible and can be undone or stopped entirely as it is proposed to be governed by a flag in the onboarding server.

## Success Metrics

This proposal is deemed sucessful if it improves the speed and ease with which hotspot users can onboard their hotspots to the network if their maker has left the ecosystem and has run out of onboarding credits.
