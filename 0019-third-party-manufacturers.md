# HIP19: Approval Process For Third-Party Manufacturers

- Author(s): @jamiew (jamiedubs), @georgica, @philltran, @cokes
- Start Date: 2020-11-14
- Amended Date: 2021-02-16
- Category: Meta
- Original HIP PR: https://github.com/helium/HIP/pull/86
- Tracking Issue: https://github.com/helium/HIP/issues/87
- Status: Approved

# Summary

This proposal seeks to lay out requirements for third-party manufacturers to be approved by the community, and a process by which onboarding keys can be issued by Helium, Inc to those manufacturers.

For Light Hotspots to be added to the Network, Validators must be a network participant to handle consensus. Shipping to consumers cannot happen until HIP25 is implemented in production.


# Motivation

In order to succeed, the Helium network will require ubiquitous, worldwide coverage. To achieve that level of coverage, we will need a large number of hotspots. As of writing, there are approximately 13,000 hotspots online. At true global scale, this required number of hotspots is estimated to be in the millions.

Helium Inc have indicated they will no longer produce their original hotspots. Currently, RAK Wireless of Shenzhen is the only approved third-party hotspot manufacturer, and relies on Helium Inc's firmware, staking servers, and customer support. The RAK hotspots have also been criticized for having minimal security precautions – swarm_keys stored in files, easily removed SD cards - which makes it easier for bad actors to cheat.

Additional hotspot manufacturers would provide redundancy, competition, and the opportunity for novel designs that could improve on security, cost, usability, portability and more. A highly secure design could be a potential candidate for the "Golden Gateways" concept that has been discussed in other HIPs.

Helium Inc is currently the only party that can issue the keys required to add a new hotspot to the blockchain. They've indicated they would be willing to follow the community's lead for approving new manufacturers and issuing them onboarding keys, and this proposal attempts to outline a process for that community approval.

Importantly, this proposal does not contemplate granting direct key issuance authority to any third-parties. While desirable, we believe that proposal and its potential consequences should be evaluated in a separate HIP.


# Stakeholders

Almost everyone involved in the Helium ecosystem, but especially:

- Prospective third-party hotspot manufacturers
- Existing third-party manufacturers, like RAK Wireless
- Prospective hotspot owners, who might have been deterred by cost, features or lack of availability
- Current hotspot owners, whose earnings will be further diluted as the network grows
- Network end-users, who desire broader coverage


# Detailed Explanation

This document attempts to outline:

1. Requirements and process for applications by third-party manufacturers (including Light Hotspot manufacturers)
2. A rough process for Helium Inc to issue onboarding codes to those manufacturers
3. Expectations for software maintenance and customer support from those manufacturers

For an initial launch, we propose favoring:

- Known community members with demonstrated experience in hardware design and manufacturing
- Large production batch sizes (10s of thousands of hotspots), rather than prototypes or smaller production runs
- Hardware designs that emphasize security and reliability rather than novel designs with more unknowns

Since this is a brand-new initiative and there is potential for abuse or failure to deliver, we seek to minimize risk. Over time, we would like to open this up to hobbyists, new entrants, and more experimental designs.


## Application Requirements

Prospective manufacturers would be expected to provide:

- Detailed hardware designs, including relevant parts and supply chain information
- Demonstrated experience with manufacturing hardware projects
- Evidence of a functioning prototype. A lesson learned from Kickstarter is the danger of photorealistic renderings.
- Proof of reliable software configuration for the devices. This would include remote updates and the ability for hosts to change wifi settings, via Helium's official app or otherwise.
- A list of other potential risks and issues

Additionally, we want devices approved under this proposal to be reasonably secure and resistant to tampering. The original Helium hotspots used an ECC chip to house the  `swarm_key` using a secure ECC chip, which was significantly more secure than the external SD card and unencrypted file storage used by the current RAKspots. We propose that applicants are required to include:

- Encrypted/locked-down firmware
- Encrypted storage of the miner `swarm_key`, either via disk encryption or hardware measures like an ECC chip
- Willingness to submit a prototype for audit, and sharing those audit results publicly (pass or fail)
- Optionally, encrypted buses, potting and other anti-tampering meaures.

Applicants wishing to manufacture Light Hotspots with packet forwarding capability-only will not need to fulfill the secured chip requirement. **Light Hotspots participating in PoC, Witnessing, and Challenging will be subject to the ECC chip requirement.**

Lastly, manufacturers are expected to provide:

- Proof of identity for individuals owning 25% or more of the manufacturer, per typical KYC/AML procedure. This could be provided privately to trusted parties like Helium Inc employees or DeWi board members and publicly confirmed.
- A production budget, to further demonstrate progress and expertise with manufacturing.
- Proof of the capital necessary to fund that budget. Ideally we would not be approving vendors who are solely reliant on presales or crowdfunding, to help account for delays, production issues, returns, and other known-unknowns.
- Willingness to engage with the community and provide ongoing customer support

While we recognize that much of this information could be considered sensitive or proprietary, we believe it is imperative to build trust with the initial set of manufacturers that are brought in through this process. Thus we ask more of this initial set of manufacturers than we might from later approvals.


### Light Hotspot Requirements (Amendment)
With the incoming launch of Validators (HIP25), the network no longer requires compute-intensive Hotspots to run consensus groups. This reduces the requirements for Hotspots such that they become "Light Hotspots". Light Hotspots are a new subclass of trusted Hotspots on the Network, able to participate in PoC, Witness, and create Challenges. In addition to PoC activities, they can transfer Data Packets. Light Hotspots will earn HNT for these activities. 

Light Hotspots will **not** participate in Consensus and will be flagged as such on the Blockchain. They will not mine HNT for participating in Consensus.

The reduced compute requirements will enable a new class of lower-cost Hotspots to enter the market.

Light Hotspots will not be expected to pass the Audit and Compute requirements to run and participate in consensus. Their block absorption rate may be documented as a comparison to other blockchain following miners. 

## Issuing Keys & Paying Staking Fees

In order to join the blockchain, every hotspot requires an onboarding code. This code is validated by a staking server and used to onboard a hotspot and pay the $40 staking fee. Currently, these codes are exclusively issued by Helium Inc and validated by their staking server at &lt;staking.helium.foundation>.

Currently, RAK Wireless acquires codes from Helium Inc via a proprietary, manual process, with records of serial numbers or MAC addresses presumably kept by Helium Inc.

For the time being, we strongly recommend Helium Inc continue to keep control of issuing onboarding codes. Trusting third-parties with key issuance is a complex and potentially dangerous issue and deserves its own independent proposal.

We suggest that Helium Inc move RAK and other third-party manufacturers to a new key issuance system that includes public record-keeping on the blockchain. The specifics of this system are still to be determined. We believe this proposal could be approved and a solution developed independently. Applicants that would otherwise be approved should be able to move forward with the process


## Revoking Manufacturer Approvals

We suggest a similar HIP-style "rough consensus" process in the case that the community wants to cease issuing codes to an approved manufacturer.

Removing any hotspots associated with that manufacturer is not currently possible. Consideration and approval of this is left to a separate proposal, as it is both technically and philosophically complex.

For consideration, there is not currently a way to unstake a hotspot on the Helium network. There is also no denylist support, which could be used as to implement community-led blocking of known bad actors. A mechanism for revoking access could potentially be built alongside the key-issuance system mentioned above, but again, this is explicitly left to a future proposal.


## Apps, Software Updates & Customer Support

Currently, Helium Inc handles all software updates and customer support for both their official hotspots and hotspots sold by RAK Wireless.

Third-party manufacturers would be expected to manage:

- Onboarding devices via web interface, mobile app or otherwise
- Over-the-air (OTA) software updates to deployed hotspots
- Customer support for sold hotspots, generally via email

It is unreasonable to expect Helium Inc to maintain software for other manufacturers’ hotspots in perpetuity. If possible, we suggest Helium Inc open-source as much of the software around this process as possible, so future manufacturers don’t need to reinvent the wheel.

The official Helium mobile app is the primary interface for onboarding a new hotspot. It was recently (Nov 12, 2020) [released as open-source](https://github.com/helium/hotspot-app) and could presumably be updated or forked by a third-party manufacturer:

Both Helium and RAK hotspots are (presumably) running the same miner software as available on GitHub, but software updates are handled by a proprietary process. Additionally, there is remote access that can be used by Helium staff to diagnose and resolve issues. Both of these are closed-source and undocumented. If not open-sourced, third-party manufacturers would need to develop their own provably-reliable alternative.

## How To Apply

Interested manufacturers should visit the [dewi-alliance/hotspot-manufacturers](https://github.com/dewi-alliance/hotspot-manufacturers/) repository, which contains instructions on how to submit an application and tracking issues for in-progress applications.

* Make a copy of the `TEMPLATE.md` file
* Fill it out; if you have questions or concerns about a particular question, just leave it blank and ask on GitHub or on Discord.
* Submit a GitHub pull request
* Discussion and approval would follow the same "rough consensus” process used by HIPs generally, as outlined in [HIP7](https://github.com/helium/HIP/blob/master/0007-managing-hip-process.md).

Sensitive information like financials or proofs of identity could be furnished to members of both Helium Inc. and the Decentralized Wireless Alliance (DeWi) and attested publicly, via the HIP document, GitHub comments, or otherwise.

## Summary of Application Process

1. Submit application
2. DeWi KYC/B
3. FCC/CE or other application radio certification
4. Hardware audit
5. Onboarding integration
6. Manufacturing Oversight Committee approval
7. Pre-orders

*note: items 3-4 can occur simultaneously*

# Drawbacks

- Third-party manufacturers could fail to deliver devices as-promised
- Devices could be built and delivered, but are poorly managed, impossible to modify due to security features, and become essentially worthless
- A third-party manufacturer could take all the keys they are issued and just run a cheatnet themselves
- Keys issued to third-party manufacturers could be compromised by another third-party

# Rationale and Alternatives

- Continue to rely solely on RAK Wireless to produce hotspots. They have a track record, and are shipping and maintaining reliable devices. However, they represent a single point of failure, and having a single manufacturer limits the amount of design innovation we can introduce to the ecosystem.
- Open up to anyone (open up the DIY program). There are well-known attack vectors for cheating in the network, constrained only by the cost and difficulty of acquiring swarm_keys via authorized resellers. Being able to spin up an unlimited number of keys means the network requires only one bad actor to bring it down. We do not feel the network is ready for open DIYs.
- Additional manufactures can provide a variety of form factors for hotspots. Currently, all the hotspots (except for DIY) are basically the same setup. It would be beneficial to have form factors that move mining to a cloud instance. This would allow for lighter weight hotspots requiring lower bandwidth needs for remote or off grid deployments. Additional form factors could fit specific use cases such as marine deployments.

# Unresolved Questions

- Details of key issuance and/or revocation systems, as highlighted above. These are deferred to future proposals.

# Deployment Impact

- More devices on the network means more potential for abuse by bad-actors. This is already a serious issue with the 10k/month RAKspots they are estimated to ship each month, and those feature essentially zero security. This HIP would likely improve the situation by allowing manufacturers with more-secure designs, which could potentially function as \[golden gateways](...)


# Success Metrics

- Number of approved third-party manufacturers
- Number of actual devices produced and sold
- Subjective quality of said devices
