# HIPxx: Approval Process For Third-Party Manufacturers

- Author(s): @jamiedubs, @georgica, @philltran
- Start Date: 2020-11-14
- Category: Meta
- Original HIP PR: TK
- Tracking Issue: TK

# Summary

This proposal seeks to lay out requirements for third-party manufacturers to be approved by the community, and a process by which onboarding keys can be issued by Helium, Inc to those manufacturers.


# Motivation

In order to succeed, the Helium network will require ubiquitous, worldwide coverage. To achieve that level of coverage, we will need a large number of hotspots. As of writing, there are 12k hotspots online. At true global scale, this required number of hotspots is estimated to be in the millions.

Helium Inc have indicated they will no longer produce their original hotspots. Currently, RAK Wireless of Shenzhen, CN is the only approved third-party hotspot manufacturer.

Additional hotspot manufacturers would provide redundancy, competition, and the opportunity for novel designs that could improve on security, cost, usability, portability and more.

Helium Inc is currently the only party that can issue the keys required to add a new hotspot to the blockchain. They have indicated they would be willing to follow the community's lead for approving new manufacturers. This document attempts to outline (a) requirements expected from third-party manufacturers (b) a rough process by which codes could be publicly issued to manufacturers.

Importantly, this proposal does not contemplate granting direct key issuance authority to any third-parties. While desirable, we believe that proposal and its potential consequences should be evaluated in a separate HIP. This process solely aims to add more third-party manufacturers, in addition to RAK Wireless.

# Stakeholders

Almost everyone involved in the Helium ecosystem, but especially:

- Prospective third-party hotspot manufacturers
- Existing third-party manufacturers, like RAK Wireless
- Prospective hotspot owners, who might have been deterred by cost, features or lack of availability
- Current hotspot owners, whose earnings will be further diluted as the network grows
- Network end-users, who desire broader coverage


# Detailed Explanation

For an initial launch, we propose favoring:

- Known community members with demonstrated experience in hardware design and manufacturing
- Large production batch sizes (10s of thousands of hotspots), rather than prototypes or smaller production runs
- Hardware designs that emphasize security and reliability rather than novel designs with more unknowns

Since this is a brand-new initiative and there is potential for abuse or failure to deliver, we seek to minimize risk. Over time, we would like to open this up to hobbyists, new entrants, and more experimental designs.

## Application Requirements

Prospective manufacturers would be expected to provide:

- Detailed hardware designs, including relevant parts, supply chain sources
- A list of potential risks and issues
- Demonstrated experience with manufacturing hardware projects
- Evidence of a functioning prototype. A lesson learned from Kickstarter is the danger of photorealistic renderings.
- Proof of reliable software configuration for the devices. This would include remote updates and the ability for hosts to change wifi settings, via Helium's official app or otherwise.

Additionally:

- Proof of identity for individuals owning 25% or more of the manufacturer, per typical KYC/AML procedure. This could be provided privately to trusted parties like Helium Inc employees or DeWi board members and publicly confirmed.
- A production budget, to further demonstrate progress and expertise with manufacturing.
- Proof of the capital necessary to fund that budget. Ideally we would not be approving vendors who are solely reliant on presales or crowdfunding.
- Willingness to engage with the community and provide ongoing customer support

While we recognize that much of this information could be considered sensitive or proprietary, it is imperative to build trust with the initial set of manufacturers that are brought in through this process. We ask more of this initial set of manufacturers than we might from later approvals.

## Issuing Keys & Paying Staking Fees

In order to join the blockchain, every hotspot requires an onboarding code. This code is validated by a staking server and used to onboard a hotspot and pay the $40 staking fee. Currently, these codes are exclusively issued by Helium Inc and validated by their staking server at &lt;staking.helium.foundation>.

Currently, RAK Wireless acquires codes from Helium Inc via a manual process, with records of serial numbers or MAC addresses presumably kept by Helium Inc.

We propose Helium Inc move RAK and other manufacturers to a new system with public record-keeping.

For the time being, we recommend Helium Inc continue to keep control of issuing onboarding codes. Trusting third-parties with key issuance is a complex and potentially dangerous issue and deserves its own proposal.

Several ideas for how a manufacturer could acquire onboarding codes from Helium Inc (FIXME: this needs help)

1.  The manufacturer could submit a $40 blockchain payment (equivalent to the staking fee) to a known Helium Inc wallet address, with the manufacturer name and serial number as a memo. Helium Inc would then separately transmit the onboarding code back to the manufacturer using &lt;placeholder magic> (???)
2.  Helium Inc could provide a private Console-like dashboard where approved manufacturers can issue keys on-demand. This dashboard would submit a signed transaction to the blockchain publicly memorializing the serial number and which manufacturer received it.
3.  A better idea that requires a minimum of code and no private handshake services

## Apps, Software Updates & Customer Support

Currently, Helium Inc handles all software updates and customer support for both their official hotspots and hotspots sold by RAK Wireless.

Third-party manufacturers would be expected to manage:

-   Onboarding devices via web interface, mobile app or otherwise
-   Over-the-air (OTA) software updates to deployed hotspots
-   Customer support for sold hotspots, generally via email

It is unreasonable to expect Helium Inc to maintain software for other manufacturers’ hotspots in perpetuity. If possible, we suggest Helium Inc open-source as much of the software around this process as possible, so future manufacturers don’t need to reinvent the wheel.

The official Helium mobile app is the primary interface for onboarding a new hotspot. It was recently (Nov 12, 2020)[released as open-source](https://github.com/helium/hotspot-app) and could presumably be updated or forked by a third-party manufacturer:

Both Helium and RAK hotspots are (presumably) running the same miner software as available on GitHub, but software updates are handled by a proprietary process. Additionally, there is remote access that can be used by Helium staff to diagnose and resolve issues. Both of these are closed-source and undocumented. If not open-sourced, third-party manufacturers would need to develop their own provably-reliable alternative.

## How To Apply

For the sake of simplicity, interested manufacturers would submit a Helium Improvement Proposal (HIP) containing all the info mentioned above for public scrutiny and discussion. Approval would follow the same “rough consensus” process outlined in HIP7.

Sensitive information like financials or proofs of identity could be furnished to members of both Helium Inc. and the Decentralized Wireless Alliance (DeWi) and attested publicly, via the HIP document, GitHub comments, or otherwise.  

# Drawbacks

-   Third-party manufacturers could fail to deliver devices as-promised
-   Devices could be built and delivered, but are poorly managed, impossible to modify due to security features, and become essentially worthless
-   A third-party manufacturer could take all the keys they are issued and just run a cheatnet themselves
-   Keys issued to third-party manufacturers could be compromised by another third-party

# Rationale and Alternatives

-   Continue to rely solely on RAK Wireless to produce hotspots. They have a track record, and are shipping and maintaining reliable devices. However, they represent a single point of failure, and having a single manufacturer limits the amount of design innovation we can introduce to the ecosystem.
-   Open up to anyone (open up the DIY program). There are well-known attack vectors for cheating in the network, constrained only by the cost and difficulty of acquiring swarm_keys via authorized resellers. Being able to spin up an unlimited number of keys means the network requires only one bad actor to bring it down. We do not feel the network is ready for open DIYs.
-   Additional manufactures can provide a variety of form factors for hotspots. Currently, all the hotspots (except for DIY) are basically the same setup. It would be beneficial to have form factors that move mining to a cloud instance. This would allow for lighter weight hotspots requiring lower bandwidth needs for remote or off grid deployments. Additional form factors could fit specific use cases such as marine deployments.

# Unresolved Questions

-   How are manufacturers who fail to live up to expectations kicked out of the program? Just stop key issuance? Who decides?


# Deployment Impact

-   More devices on the network means more potential for abuse by bad-actors. This is already a serious issue with the 10k/month RAKspots they are estimated to ship each month, and those feature essentially zero security. This HIP would likely improve the situation by allowing manufacturers with more-secure designs, which could potentially function as \[golden gateways](...)


# Success Metrics

-   Number of approved third-party manufacturers
-   Number of actual devices produced and sold
-   Subjective quality of said devices

  
  


