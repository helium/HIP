# HIP7: Managing Helium Improvement Proposals

- Start Date: 2020/05/28
- Original HIP PR: [#22](https://github.com/helium/HIP/pull/22)
- Tracking Issue: [#26](https://github.com/helium/HIP/issues/26)
- Authors: [@jamiew](https://github.com/jamiew)

# Summary

Defines an initial process for proposing, discussing, and finalizing improvements to the Helium
blockchain using Helium Improvement Proposals (HIPs).

_"How a bill becomes a law"_

# Motivation

As Helium Inc begins to share control over the development and management of the Helium Network,
it's become clear we need a community-driven process for making changes to the protocol, network
configuration, and other shared concerns. Fortunately, we are not the first to this problem, and
this document draws heavily on the the Improvement Proposal processes of
[Ethereum](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1.md),
[Zcash](https://github.com/zcash/zips/blob/master/zip-0000.rst),
[Rust](https://github.com/rust-lang/rfcs) and others.

This document aims to outline a process that is transparent and inclusive while remaining as
efficient and pragmatic as possible.

We do not aim to adjudicate routine technical changes to miner software or the day-to-day dealings
of Helium Inc. We expect that any change that could have significant impact on the functioning of
the Helium Network would be vetted through the HIP process.

# Stakeholders

We plan to circulate this proposal in
[Discord #hip-open-discussion channel](https://discord.gg/helium). We will also solicit specific
individuals for feedback, from both within the Helium community and other crypto and open-source
projects.

Specifically we aim to achieve rough consensus around this process with Helium Inc (as the primary
developer of nearly all core Helium software), Hotspot owners, and the newly-formed
[DeWi Alliance](https://dewi.org), which plans to commit time & money to community governance in the
Helium ecosystem.

On-the-record comments should be made on this HIP's [associated GitHub issue](TODO). As described in
this document, that issue would be opened automatically after this HIP's initial pull request has
been merged by a HIP Editor. That role is also described below.

# Detailed Explanation

## Overview

The HIP process generally starts with an idea for improving the Helium protocol or modifications to
blockchain configuration (chainvars). HIPs can also cover improvements to the Helium, like this
meta-HIP.

The HIP's author is responsible for building support and consensus for their proposal.

There are three major types of proposals:

- _Technical_ – network and protocol upgrades
- _Economic_ – modifications to rewards or incentive structures (generally via chainvars)
- _Meta/Process_ – changes to the HIP process itself; presumably would also include processes like
  the selection of committee members and the induction of core developers

We propose the creation of several roles to help facilitate this process: _HIP Editors_, who
administer the HIP process, and _Review Committees_, who serve as specialists for technical vs.
economic proposals and operate as a first line of feedback.

## Submitting a HIP

In the earliest phases it's best to vet an idea with the Helium community
[via Discord](https://discord.gg/helium). This is a good way to see if there is initial support for
the idea, or if it's been discussed before.

After vetting the idea, please write it up using this markdown-formatted
[HIP template](https://github.com/helium/HIP/blob/master/0000-template.md) and submit it as a pull
request to this repository (`helium/hip`). The current template is geared towards technical
proposals, but can be adapted for economic or meta proposals.

How to submit a pull request:

- Fork this repository (e.g. using the GitHub "Fork" button top-right) and checkout your fork
- Add your file and give it a title but do not allocate a number, e.g. `HIP-data-credits.md`
- Commit your changes (`git commit [filename] -m "Description of your changes"`) and push them to
  your fork (`git push origin master`)
- Submit your change as a [pull request](https://github.com/helium/hip/pulls)

Within a reasonable timeframe after you've submitted your PR, a HIP Editor will review your pull
request.

The PR will be merged it if it adheres to the standards outlined in this document, which formally
opens it up for consideration.

If there are issues, the HIP editor will provide feedback. The feedback at this stage is intended to
be logistical, rather than on the actual contents of the proposal.

## Discussion and approval process

_TODO this could use more detail; feedback & contributions very welcome_

- When ready, HIP is scheduled for discussion on a community call.
- Comments should be put on the HIP's associated GitHub issue, and/or
  [Helium Discord Community](https://discord.gg/helium)
- Approval is achieved through
  [rough consensus and running code.](https://en.wikipedia.org/wiki/Rough_consensus)
- HIPs have a status: _Draft, In Discussion, Approved, Deployed, Rejected_
- If a HIP goes stale and discussion is dormant, it should be closed.
- When rough consensus is achieved, a HIP is marked `approved`
- When a HIP has been merged and deployed, it is marked `deployed`.
- HIP Editors are responsible for keeping `helium/hip` repository groomed and well-organized.

## HIP Editors

As mentioned above, we'll need people to help organize and facilitate the HIP process. This is an
administrative role, and Editors are not arbiters of what does or does not get approved.

Editors would be responsible for:

- Reviewing new HIPs submitted to the GitHub repository
- Flagging issues related to formatting and structure, but not commentary on its substance; that
  should be reserved until after the HIP's pull request has actually been merged.
- Evaluating community consensus and updating HIP statuses accordingly

## Review Committees

We expect different stakeholders to be more interested in Technical vs. Economic proposals, and so
we suggest the formation of Review Committees for each of those tracks.

Review Committees would be expected to meet regularly and discuss HIPs falling into their area, and
in conjunction with HIP Editors, help keep the improvement process moving.

The committee is an informal group and anyone can join one of the calls and make their voice heard.

Since there relatively few HIPs and no clear members for any given committes, the newly launched
Helium community calls can serve as a catch-all for reviewing proposals.

# Unresolved questions

- How are Review Committee members selected? Open to anybody or elected or other?
- How are HIP Editors nominated and selected? (Related: Who currently has write access to
  `helium/hip`?)
- How do community calls work? It's assumed in this document these will occur regularly and be open
  to the public
- Who are the current core developers? Who has the ability to merge code into core repositories?
  What are those core repositories?
- Who has the ability to deploy changes to the blockchain, and the related responsibility for its
  uptime?
- How long should a HIP be allowed to remain in a given state?
- Should we encourage people just to leave comments on GitHub, rather than trying to track GitHub or
  Discord?
