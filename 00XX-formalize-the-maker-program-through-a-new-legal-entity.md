# HIP 99: Formalize the Maker Program through a New Legal Entity

- Author(s): [Scott Sigel](https://github.com/scottsigel), [Helium Foundation](https://github.com/dewi-alliance)
- Start Date: 2023-10-25
- Category: Governance
- Original HIP PR: [#796](https://github.com/helium/HIP/pull/796)
- Tracking Issue: [#801](https://github.com/helium/HIP/issues/801)
- Vote Requirements: veHNT holders

## Summary

Creates a formal and sustainable structure to oversee and manage the Maker Program as originally inspired by HIP-19. To date, Hotspot manufacturer management has been driven primarily by the Manufacturing Compliance Committee (MCC) which was composed of full-time Helium Foundation employees and supportive volunteers from stakeholder organizations in the Helium Network as well as individual contributors.

The current MCC mandate is to ensure the sustainability of the Helium network by (1) establishing the rules under which Hotspot manufacturers will operate; (2) providing mechanisms for enforcement of those rules; and (3) performing audits of the hardware produced by manufacturers to ensure that technical, security, and ethical standards are met before hotspots can be on-boarded onto the Helium Network.
In order to sustain the Maker Program, this HIP authorizes the Helium Foundation to establish a distinct legal entity as the management arm of the Maker Program. The entity would receive funding from the Network through grants and be financially accountable for all work performed.

The new entity would establish formal commercial terms with Makers, compensate program contributors, and oversee the security audit process. The responsibility of the current MCC will pass to the new entity, with authority sitting with the Helium Foundation. The Foundation may hire program managers until such time as new bylaws for the entity may transfer authority to an elected committee (of community members and Network stakeholders). This HIP explicitly delegates authority over the Maker Program to this subsidiary to perform the mandate established by the current MCC, and supplants the standards and practices defined in HIP-19.

## Motivation

The Helium community has built the largest and fastest growing IoT network in history, and is scaling up one of the largest community-built cellular networks. Much of the Network’s growth is attributable to HIP-19 and the community of 3rd party manufacturers (AKA Makers) who played an integral role in scaling the supply side of the Helium Network. To build a sustainable decentralized network, stakeholders must agree on a shared ambition and act ethically in its service. This can include upholding commitments to customers, preventing malicious threats to the network, and otherwise contributing to the shared objective of network growth and sustainability. In the long-run, this work ideally moves ‘on chain’ by creating mechanics that can be enforced without the involvement of external governance. However, blockchain mechanics are not sufficient if the hardware itself cannot be trusted. Until the protocol can adequately account for and prevent malicious activity in the Helium ecosystem, maintaining contractual obligations and economic accountability for Makers is the most pragmatic approach to safeguard the Helium Network and its community from organizations that may take advantage of the Helium rewards scheme or financially harm consumers for their own commercial gain.

The MCC’s current mandate is to verify that manufacturers and their respective Hotspots meet the minimum functional requirements for a device to participate on the Network. This includes blockchain-related transactions, a check on relevant regulatory requirements for all radio hardware, and that the devices meet the minimum authentication, encryption, and security standards needed to protect the network.

The current process has some significant drawbacks: the MCC does not currently test for or enforce general product quality standards, ensure the overall quality of the product, customer service, or the manufacturing process. Nor does the MCC currently test products for optimized RF performance; only location configurations are reviewed.

Currently, the sole power the MCC wields is a very blunt instrument: the MCC can bestow or withdraw onboarding privileges to “Maker Keys”. In layman’s terms, Maker Keys are the passcodes that allow a manufacturer to add a unit to the blockchain. This is a blunt and weak instrument by design; no one unit or entity should be able to hold the entire ecosystem hostage. The downside is that revoking a Maker Key is a restrictive accountability measure and has negative implications for end-customers. Conversely, an escrow agreement between a Maker and an entity representing the Network’s interests creates a more balanced means of accountability and provides better protection for end-customers.

This HIP proposes a new structure to solve the same underlying problem addressed by HIP-19, a HIP encompassing requirements and processes for applications by third-party manufacturers.

This new structure reflects the significant growth and maturity of the Helium ecosystem. A volunteer committee is no longer sustainable and engagement on the MCC has waned over time. The Maker Program must be financially sustainable, more accountable, more flexible, and provide better enforcement mechanisms.

The new structure creates a legal entity as the point of management for the Maker Program. The entity should be funded from the Network and provide transparency over the use of proceeds. Authority over the new entity will initially sit with the Helium Foundation who may hire contractors and/or vendors to manage the hardware audit process, establish new commercial terms with Makers, and author bylaws with the option of a new elected committee to assume authority over the Maker Program.

As it will be funded by the Network, the new entity will be subject to checks and balances on its authority and must seek public comment before making changes to its own rules. The community will also retain the right to revoke or narrow the authority delegated to the new entity at any time through the HIP process.

## Stakeholders

Almost everyone involved in the Helium ecosystem is a stakeholder affected by this proposal, but especially:

- Prospective third-party Hotspot manufacturers.
- Existing third-party manufacturers.
- Prospective Hotspot owners
- Current Hotspot owners, whose earnings will be further diluted as the Helium Network grows.
- Network end-users, who desire broader coverage.

## Detailed Explanation

### Legal Entity

This HIP authorizes and instructs the Helium Foundation to create a legal entity (e.g. Limited Liability Corporation) which will serve as the legal infrastructure through which the Maker Program will operate. Creating a legal entity will do all of the following, none of which are possible with the informal volunteer structure created by HIP-19:

1. Provide a legal liability shield for any future committee member. Under this proposed structure, all legal risk is borne by the entity and the individual members cannot be sued directly.
1. Sign formal contracts with manufacturers and enforce those contracts through formal legal processes. The new entity will still be able to revoke a maker’s key, if appropriate, but will have the full panoply of legal options available and can sign bilateral agreements.
1. Open a bank account, pay stipends to members for their service, pay contractors to perform mission critical work, and take in auditing income to fund its operations. The new entity will also be able to formalize these relationships with contracts and issue relevant tax documents to members, manufacturers, contractors, and partners.

To summarize, by creating a legal structure, any committee member or contractor supporting the Maker Program would be shielded from liability, able to enforce rules, hold manufacturers accountable, commission engineering and software development work that will benefit its mission, and do so in a manner that is legally compliant, protecting the Network from unnecessary risk.

### Delegation of Authority

This HIP formally delegates to the new entity (by way of the Helium Foundation) the power to:

1. Write and amend its own bylaws;
1. Establish procedures for the qualification, nomination, selection, election, and removal of committee members;
1. Create a formal contract with manufacturers to replace the existing “ethics” document; mandate that existing manufacturers sign that contract to continue to operate; and enforce that contract with on-chain actions and off-chain legal enforcement;
1. Formalize a rulemaking process that will govern manufacturers’ actions, the committee’s internal processes, and any other rules necessary to perform the Maker Program mandate; any rulemaking process must involve (a) the entity publishing proposed rules for public comment, (b) responding to any such comments, (c) publishing a proposed final rule, and (d) affording the community an opportunity to veto the proposed rule through the formal HIP process, or something substantially similar;
1. Formalize the original HIP19 process, including:
   1. Establishing, maintaining and updating minimum hardware specifications for Hotspots on the Helium network.
   1. Establishing requirements and procedures by which third-party manufacturers apply to become Makers, including KYC.
   1. Establishing and administering a hardware audit process for Makers’ Hotspot models.
   1. Establishing the procedure by which access to the DeWi onboarding server is granted to those Makers, if they so choose.
   1. Establishing expectations for anti-gaming, software maintenance, and customer support from those Makers.

### Capitalization and Transparency

The new Maker Program entity is intended to be a fully transparent entity with authority and financial resources delegated to it by the community to perform work on behalf of the community. The funding will come from an Operations Fund as a carve out from protocol rewards.

The community retains the right to revoke or narrow the delegation of authority to the entity at any time through the HIP process. The Helium Foundation’s role in the entity includes initial legal establishment, hires or initial appointments, and controlling the legal structure under which the entity operates. Program managers within the entity will maintain and manage the Maker Program with publicly accessible financial reporting. If determined to be necessary, a committee may be established including bylaws articulating a nomination process, elections, terms of members, removal and so forth. The entity will publish a quarterly report of its finances and a summary of operations during that quarter.

## Drawbacks

- Third-party manufacturers may not agree to contract with the new entity leaving the relationship in limbo.

## Rationale and Alternatives

- There are limited accountability measures for Makers other than natural market forces
- A separate entity creates a legal shield for future contributors and/or committee members
- A volunteer committee is not sustainable for a program of this magnitude

## Unresolved Questions

- Scope of budget
- How will the entity finance itself and its operations?

## Success Metrics

- Reduction in failed onboards
- Financial remedy for the Network for lost rewards from any future bad actor
- Improved customer response times from Makers
