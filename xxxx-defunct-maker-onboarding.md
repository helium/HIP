# HIP XX: Onboarding Defunct Maker Hotspots in Data-Only Mode

- Author(s): <!-- your GitHub @username -->
- Start Date: <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: <!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: <!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary

When IoT Hotspot makers exit the ecosystem, their maker key is revoked, however existing Hotspot stock is allowed to be onboarded, even if onboarding keys or Hotspots are acquired in bulk for farming attempts. This proposal seeks to only allow Hotspots from defunct makers to be onboarded in "Data-Only" mode, making these Hotspots ineligible for Proof of Coverage (PoC)rewards but still able to transfer data for rewards.

## Motivation

Gaming continues to be a problem, especially when bulk access to PoC-enabled Hotspots is left open. By limiting onboarding of defunct makers’ stock to Data-Only mode, the network reduces the top-of-funnel for gaming at scale. This aligns incentives with manufacturers who remain engaged and committed to long-term growth, while ensuring that users motivated by network utility can still deploy and earn through data transfer. Those seeking PoC rewards will either avoid deploying or acquire Hotspots only from aligned manufacturers, strengthening the health and sustainability of the ecosystem.

## Stakeholders

Anyone holding a Hotspot that has not been onboarded and produced by a defunct maker will no longer to be eligible to onboard it with support for PoC. Deployers seeking to install Hotspots for network coverage remain affected. Hotspots that have already been onboarded remain unaffected.

No processes change for Hotspot manufacturers. It will be communicated to Hotspot manufacturers that allowing a maker key to lapse will affect the onboarding capability of their Hotspots.


## Detailed Explanation

This proposal requires that Hotspots from defunct makers can only be onboarded in Data-Only mode. This removes the incentive to acquire onboarding keys or stock in bulk for gaming, while still allowing these devices to provide value by transferring data. The approach preserves network utility without rewarding exploitative behavior.

By making PoC rewards exclusive to active and aligned manufacturers, the proposal encourages makers to stay current and engaged. Community demand is refocused toward long-term makers, ensuring that new deployments come from trusted sources. This reduces gaming opportunities and strengthens the health of the ecosystem over time.

This HIP will be implemented by adjusting the logic of the IoT Onboarding server. The Onboarding Server will be updated to check for a current maker key associated with that Hotspot. If the maker key is current, the Hotspot will be eligible to onboard with full capability. If the maker key is revoked, the Hotspot will only be permitted to onboard in Data-Only mode. 

When onboarding in Data-Only mode, the onboarding fee ($1 paid in DC) may be deducted from any funds in the Maker account.

## Drawbacks

This change may discourage some users from deploying legitimate but older Hotspots if they are limited to Data-Only mode. Owners of defunct maker stock could feel penalized despite having purchased hardware in good faith.

Restricting PoC rewards to active manufacturers may reduce the total number of Hotspots onboarded, which could slow physical network growth. There is also a risk that implementation complexity could introduce onboarding errors or confusion for users and support teams.

## Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design space. This is
probably the most important section!

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?



## Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?
- Are there dependencies, milestones, or dates that need to be met for this HIP to succeed?

## Deployment Impact

Describe how this design will be deployed and any potential impact it may have on current users of
this project.

- How will current users be impacted?
- How will existing documentation/knowledge base need to be supported? Any content to change at
  <http://docs.helium.com>?
- Is this backwards compatible? Can this HIP be undone?
  - If not, what is the procedure to migrate?

The Onboarding Server will be updated to onboard Hotspots as Data-Only in situations when the on-chain Maker Approval is revoked. Data-Only onboarding fees will be used instead of Full Hotspot onboarding fees. The onboarding fees will be paid from the maker account in situations where the maker account has sufficient funds to pay the fees, otherwise users will have the choice to pay the fees.

## Success Metrics

What metrics can be used to measure the success of this design? Are any new ETL reports needed to
measure the success?

- What should we measure to prove a performance increase?
- What should we measure to prove an improvement in stability?
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by its users?
