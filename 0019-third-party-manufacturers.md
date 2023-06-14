# HIP19: Approval Process For Third-Party Manufacturers

- Author(s): @jamiew (jamiedubs), @georgica, @philltran, @cokes, [@sophi](https://github.com/Sophi)
- Start Date: 2020-11-14
- Amended Date: 2021-02-16
- Category: Meta
- Original HIP PR: <https://github.com/helium/HIP/pull/86>
- Tracking Issue: <https://github.com/helium/HIP/issues/87>

## Light Hotspots

HNT staking using Validators will be discontinued in 2023 Q1 with the
[implementation of HIP-70](https://docs.helium.com/mine-hnt/validators/validators-and-voting-power/#how-will-staking-rewards-change).

## Motivation

In order to succeed, the Helium IOT Network will require ubiquitous, worldwide coverage. To achieve
that level of coverage, we will need a large number of hotspots. As of writing, there are
approximately 980,000 hotspots onboarded. At true global scale, the required number of hotspots is
estimated to be in the millions.

At the time of this writing, there are over 60 manufacturers (often called Makers) creating IOT
Hotspots running on LoRaWAN for the Helium Network. There are a few manufacturers creating 5G
Hotspots running on CBRS in the HIP-19 process.

Additional Hotspot manufacturers would provide redundancy, competition, and the opportunity for
novel designs that could improve on security, cost, usability, portability and more. A highly secure
design could be a potential candidate for the "Golden Gateways" concept that has been discussed in
other HIPs.

The Helium Foundation is currently the only party that can issue the keys required to onboard a new
Hotspot to the blockchain. Approval of new manufacturers is by the Manufacturing Compliance
Committee (MCC), who meets regularly to discuss manufacturers, blockchain security, and growth of
the Helium Network.

Importantly, this proposal does not contemplate granting direct key issuance authority to any
third-parties. We believe that the above proposal and its potential consequences should be evaluated
in a separate HIP.

## Stakeholders

Almost everyone involved in the Helium ecosystem, but especially:

- Prospective third-party Hotspot manufacturers.
- Existing third-party manufacturers.
- Prospective Hotspot owners
- Current Hotspot owners, whose earnings will be further diluted as the Helium Network grows.
- Network end-users, who desire broader coverage.

## Detailed Explanation

This document outlines:

- Requirements and process for applications by third-party manufacturers.
- A process for the Helium Foundation to issue onboarding codes to those manufacturers.
- Expectations for software maintenance and customer support from those manufacturers.

We propose favoring:

- Known community members with demonstrated experience in hardware design and manufacturing.
- Large production batch sizes (10s of thousands of Hotspots), rather than prototypes or smaller
  production runs.
- Hardware designs that emphasize security and reliability rather than novel designs with more
  unknowns.

Since there is potential for abuse or failure to deliver, we seek to minimize risk.

## Application Requirements

Prospective manufacturers would be expected to provide:

- Detailed hardware designs, including relevant parts and supply chain information.
- Demonstrated experience with manufacturing hardware projects.
- Evidence of a functioning prototype. A lesson learned from Kickstarter is the danger of
  photorealistic renderings.
- Proof of reliable software configuration for the devices. This would include remote updates and
  the ability for hosts to change wifi settings, via manufacturer official apps or otherwise.
- A list of other potential risks and issues.

Devices approved under this proposal must be reasonably secure and resistantto tampering. We propose
that applicants are required to include:

- Encrypted/locked-down firmware.
- Encrypted storage of the miner swarm_key, either via disk encryption or hardware measures like an
  ECC chip.
- Willingness to submit a prototype for audit, and sharing those audit results publicly (pass or
  fail).
- Optionally, encrypted buses, potting and other anti-tampering measures.

Helium 5G/ Mobile Hotspots must only run authenticated firmware that has been provided by the
manufacturer. This authentication process ensures that the Hotspot can be trusted by the rest of the
network. This is especially important in the 5G network because Hotspots make observational reports
on behalf of the entire network, such as:

- UE attachment events
- Signal strength (RSSI, RSRP, RSRQ)
- Upstream bandwidth measurements

Applicants wishing to manufacture Light Hotspots with packet forwarding capability-only (often
called Data-Only Hotspots) will not need to fulfill the secured chip requirement. Light Hotspots
participating in PoC, Witnessing, and Challenging will be subject to the ECC608 chip or other
security implementation requirement.

Lastly, manufacturers are expected to provide:

- Proof of identity for individuals owning 25% or more of the manufacturer, per typical KYC/AML
  procedure. This could be provided privately to trusted parties like the Helium Foundation
  employees or Helium Foundation board members and publicly confirmed.
- A production budget, to further demonstrate progress and expertise with manufacturing.
- Proof of the capital necessary to fund that budget. Ideally we would not be approving vendors who
  are solely reliant on presales or crowdfunding, to help account for delays, production issues,
  returns, and other known-unknowns.
- Willingness to engage with the community and provide ongoing customer support.
- While we recognize that much of this information could be considered sensitive or proprietary, we
  believe it is imperative to build trust with manufacturers that are brought in through this
  process.

## Light Hotspot Requirements (Amendment)

With off-chain Proof of Coverage (PoC), the Network no longer requires compute-intensive Hotspots to
run Consensus Groups. This reduces the requirements for Hotspots such that they become "Light
Hotspots". Light Hotspots are a new class of trusted Hotspots on the Network, able to participate in
PoC, Witness, and create Challenges. In addition to PoC activities, they can transfer Data Packets.
Light Hotspots will earn IOT for these activities.

Light Hotspots will not participate in Consensus and block production.

The reduced compute requirements will enable a new class of lower-cost Hotspots to enter the market.

Light Hotspots will not be expected to pass the Audit and Compute requirements to run and
participate in consensus. Their block absorption rate may be documented as a comparison to other
blockchain following miners.

## 5G Hotspot Requirements (Amendment)

Historically many mobile networks are built top-down by service providers (e.g., AT&T and Verizon in
the United States). The Helium model decentralizes these costs and enables communities to
participate in building reliable, high-bandwidth networks using technologies like
[CBRS](https://docs.helium.com/5g-on-helium/cbrs-radios) and] Wi-Fi. We see service providers as a
critical component of this ecosystem rather than replacing service providers altogether.

A general structure for onboarding new Decentralized Network Protocols (DNPs) to the broader Helium
Network was created with the passing of
[HIP-51: Helium DAOs](https://github.com/helium/HIP/blob/main/0051-helium-dao.md). The Helium Mobile
DAO with 5G Hotspots is the first step in the evolution of the Helium ecosystem.

The requirements for 5G manufacturers are stringent. Helium 5G/ Mobile Hotspots must have several
security features in order to participate in the Helium Network and receive network rewards. These
include a secure boot process and a secure element feature for managing the cryptographic keys which
identify the 5G Hotspot on the Network. Raspberry Pis, which were used ubiquitously in LoRaWAN
Hotspots, do not have this capability. At this time, manufacturers are required to use
[Magma](https://magmacore.org/), an open source mobile core solution, to organize their cellular
networks, as well as holding their own Orchestrator (orc8r).

Manufacturers may review the hardware requirements
[here](https://www.notion.so/heliumfoundation/5G-Hotspot-Hardware-Specifications-for-the-Helium-network-1b936ad87c244c2785ff281fa39fb99c).

## HIP19 Addendum for 5G

- hardware specs
- security specs

Makers must propose their method for secure firmware (secure boot and a secure update process), and
adhere to these standards:

### Secure Boot Requirements

To be effective, the secure boot process you propose must meet these requirements:

- There must be a secure hardware boundary encompassing:
  - A boot CPU
  - A one-time programmable memory area capable of storing:
    - A trusted public key (or hash of such a key) for authenticating external boot code.
    - A device-unique secret key
  - A cryptographic hardware element capable of public key and private key cryptography.
  - An unalterable (fused or masked) boot ROM.
  - A static RAM.
- The buss(es) within the secure hardware boundary must be protected.
  - Activity on the bus cannot be inspected nor altered by any entity outside of the boundary.
  - No outside entity shall be able to inspect the device-unique secret key in unencrypted format.
  - No outside entity shall be able to alter the contents of the memory elements (SRAM, boot ROM,
    OTP memory) inside the boundary.

### Secure Update Process

- A manufacturer-controlled process encompassing:
  - The external boot code signing key (private portion).
  - A process for securely managing access to the signing key.

## Issuing Keys & Paying Staking Fees

In order to join the blockchain, every Hotspot requires an onboarding code. This code is validated
by an Onboarding Oracle and used to onboard a Hotspot and pay the $40 staking fee. Currently, these
codes are exclusively issued by the Helium Foundation and validated by their Onboarding Oracle at
<staking.helium.foundation>.

Currently, manufacturers acquire codes from the Helium Foundation via a proprietary, manual process,
with records of serial numbers or MAC addresses presumably kept by the Helium Foundation.

For the time being, we strongly recommend the Helium Foundation continue to keep control of issuing
onboarding codes. Trusting third-parties with key issuance is a complex and potentially dangerous
issue and deserves its own independent proposal.

## Revoking Manufacturer Approvals

Currently, the Manufacturing Compliance Committee may vote to remove a manufacturer’s key for cause
at the MCC’s discretion.

Removing any Hotspots associated with that manufacturer is not currently possible. Consideration and
approval of this is left to a separate proposal, as it is both technically and philosophically
complex.

For consideration, there is not currently a way to unstake a Hotspot on the Helium network. There is
denylist support, which may be used to implement community-led blocking of known bad actors. A
mechanism for revoking access could potentially be built alongside the key-issuance system mentioned
above, but again, this is explicitly left to a future proposal.

## Apps, Software Updates & Customer Support

Makers are responsible for developing their own mobile applications using the provided SDKs and
example apps. Makers are also responsible for customer support for the Hotspots they manufacture,
including software updates for the life of the product.

Third-party manufacturers would be expected to manage:

- Onboarding devices via web interface, mobile app or otherwise
- Over-the-air (OTA) software updates to deployed Hotspots
- Customer support for sold hotspots, generally via email

It is unreasonable to expect the Helium Foundation to maintain software for other manufacturers’
Hotspots in perpetuity. If possible, we suggest the Helium Foundation open-source as much of the
software around this process as possible, so future manufacturers don’t need to reinvent the wheel.

As of February 2022, manufacturers must have their own mobile or web app as the primary interface
for onboarding a new Hotspot. Helium released an example app
[as open source](https://github.com/helium/hotspot-app) which can be updated or forked by a third
party manufacturer.

Manufacturers are (presumably) running the same miner software as available on GitHub. Software
updates must be handled by the manufacturer.

## How To Apply

Interested manufacturers should visit the
[dewi-alliance/hotspot-manufacturers](https://github.com/dewi-alliance/hotspot-manufacturers/)
repository, which contains instructions on how to submit an application and tracking issues for
in-progress applications.

- Make a copy of the TEMPLATE.md file
- Fill it out; if you have questions or concerns about a particular question, just leave it blank
  and ask on GitHub or on Discord.
- Submit a GitHub pull request
- Discussion and approval would follow the same "rough consensus” process used by HIPs generally, as
  outlined in [HIP7](https://github.com/helium/HIP/blob/master/0007-managing-hip-process.md).

Sensitive information like financials or proofs of identity could be furnished to members of both
the Helium Foundation and attested publicly, via the HIP document, GitHub comments, or otherwise.

## Summary of Application Process

1. Submit application
2. Helium Foundation KYC/B
3. FCC/CE or other application radio certification
4. Hardware audit
5. Onboarding integration
6. Manufacturing Compliance Committee approval
7. Pre-orders

_note: items 3-4 can occur simultaneously_

## Drawbacks

- Third-party manufacturers could fail to deliver devices as-promised
- Devices could be built and delivered, but are poorly managed, impossible to modify due to security
  features, and become essentially worthless
- A third-party manufacturer could take all the keys they are issued and just run a cheatnet
  themselves
- Keys issued to third-party manufacturers could be compromised by another third-party

## Rationale and Alternatives

- Continue to rely solely on third party manufacturers to produce Hotspots. They have a track
  record, and are shipping and maintaining reliable devices. However, they represent a single point
  of failure, and having a single manufacturer limits the amount of design innovation we can
  introduce to the ecosystem.
- Open up to anyone (open up the DIY program). There are well-known attack vectors for cheating in
  the network, constrained only by the cost and difficulty of acquiring swarm_keys via authorized
  resellers. Being able to spin up an unlimited number of keys means the network requires only one
  bad actor to bring it down. We do not feel the network is ready for open DIYs.
- Additional manufacturers can provide a variety of form factors for Hotspots. Currently, all the
  Hotspots (except for DIY) are basically the same setup. It would be beneficial to have form
  factors that move mining to a cloud instance. This would allow for lighter weight hotspots
  requiring lower bandwidth needs for remote or off grid deployments. Additional form factors could
  fit specific use cases such as marine deployments.

## Unresolved Questions

- Details of key issuance and/or revocation systems, as highlighted above. These are deferred to
  future proposals.

## Deployment Impact

- More devices on the network means more potential for abuse by bad-actors. This HIP would likely
  improve the situation by allowing manufacturers with more-secure designs, which could potentially
  function as golden gateways.

## Success Metrics

- Number of approved third-party manufacturers
- Number of actual devices produced and sold
- Subjective quality of said devices
