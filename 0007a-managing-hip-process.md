# HIP7: Managing Helium Improvement Proposals (HIP)

- Start Date: 2020/05/28 
- Original HIP PR: [#22](https://github.com/helium/HIP/pull/22)
- Tracking Issue: Pull Request (PR) comments
- Authors: [@jamiew](https://github.com/jamiew), [@anthonrya](https://github.com/anthonyra)

- Category: Meta / Process
- Premission Level: Idea
- Status: Draft

# Summary
[summary]: #summary

Defines an initial process for proposing, discussing, and finalizing improvements to the Helium blockchain using Helium Improvement Proposals (HIPs).

_"How a bill becomes a law"_


# Motivation
[motivation]: #motivation

As Helium Inc begins to share control over the development and management of the Helium Network, it's become clear we need a community-driven process for making changes to the protocol, network configuration, and other shared concerns. Fortunately, we are not the first to this problem, and this document draws heavily on the the Improvement Proposal processes of [Ethereum](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1.md), [Zcash](https://github.com/zcash/zips/blob/master/zip-0000.rst), [Rust](https://github.com/rust-lang/rfcs) and others.

This document aims to outline a process that is transparent and inclusive while remaining as efficient and pragmatic as possible.

We do not aim to adjudicate routine technical changes to miner software or the day-to-day dealings of Helium Inc. We expect that any change that could have significant impact on the functioning of the Helium Network would be vetted through the HIP process. This will be discussed in more detail below in the categories of HIP.

# Stakeholders
[stakeholders]: #stakeholders

We plan to circulate this proposal in [Discord #hips](https://discord.gg/helium) and on the [Helium community forum](https://community.helium.com). We will also solicit specific individuals for feedback, from both within the Helium community and other crypto and open-source projects. 

Specifically we aim to achieve rough consensus around this process with Helium Inc (as the primary developer of nearly all core Helium software), hotspot owners, and the newly-formed [DeWi Alliance](https://dewi.org), which plans to commit time & money to community governance in the Helium ecosystem.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Overview

The HIP process generally starts with an idea for improving the Helium protocol or modifications to blockchain configuration (chainvars). HIPs can also cover improvements to Helium, like this meta-HIP. 

The HIP's author is responsible for building support and consensus for their proposal.

There are four primary categories of proposals:
* *Technical* – network and protocol upgrades
* *Blockchain Performance* - the overall status of the blockchain (ie. block times, and stales)
* *Economic* – modifications to rewards or incentive structures (generally via chainvars)
* *Meta/Process* – changes to the HIP process itself; presumably would also include processes like the selection of committee members and the induction of core developers

Each primary category can have sub-categories:
* *Technical* - Proof-of-Coverage (PoC), The Helium Consensus Protocol, Transactions, Reward Pool Rules etc
* *Economic* - Reward Pool Allocations, Tokens, etc.
* *Meta/Process* - Goverance, etc.

## Permission Levels for Actions

The permission levels for the three primary categories are:
* *Technical* – Idea, Concern, Urgent (Techinical issues can fall under any of the three permission levels)
* *Blockchain Performance* - Concern, Urgent (Blockchain peformance will always require swift action to correct)
* *Economic* – Idea, Concern (Economic issues should require the most governance. *NOTE* HIP10 which was driven via the Economic category actually was in the Techinical category)
* *Meta/Process* – Idea (There's no immediate threat to the blockchain or the economy of Helium with these changes meaning they don't have a required timeline allowing for finer control)

Permission Level
* *Idea* - This level requires the most permission because of the requirement to get a consensus with the majority of the Helium community.
* *Concern* - This level also requires the most permission but it can be upgraded to the urgent permission level if further investigation pins it to that level.
* *Urgent* - This requires no consensus from the community before actions need to be taken. The reason is that the issue is viewed as blockchain/Helium threatening. Example would be HIP10 with the arbitrage of DC. *This is the only permission level that doesn't require a HIP prior to action being taken*

The permission level will be suggested from the original Pull Request author. Upon review the HIP the permission level can be changed by only a *HIP Editor* the reason for said change will be detailed by the *HIP Editor*

## Status of HIP

HIP's can have the following statuses:
* *Draft* - PR is submitted but HIP Editor hasn't reviewed it yet.
* *Discussion* - PR is accepted by HIP Editor and discussion is open in either `Issues` or the PR comments
* *Approved* - PR has a [rough consensus](https://en.wikipedia.org/wiki/Rough_consensus) and running code
* *Deployed* - PR is deployed to the blockchain / Helium
* *Rejected / Closed* - PR is no longer active or HIP Editor has rejected

## Submitting a HIP

In the earliest phases it's best to vet an idea with the Helium community [Discord #hips](https://discord.gg/helium) or on the [Helium community forum](https://community.helium.com). This is a good way to see if there is initial support for the idea, or if it's been discussed before. Even though this is the recommended first step it's not required.

The next step is to write it up using this markdown-format [HIP template](https://github.com/helium/HIP/blob/master/0000-template.md) and submit it as a pull request to this repository (`helium/hip`).

How to submit a pull request:

* Fork this repository (e.g. using the GitHub "Fork" button top-right) and checkout your fork
* Add your file using the next available number in the existing filename convention for an Original HIP, e.g. `0004-data-credits.md`
* If the HIP is a PR on an Original HIP then you'd add your file with the following filename convention, e.g. `0004a-data-credits.md`
* The status of all inital PR will be *Draft*
* Commit your changes (`git commit [filename] -m "Description of your changes"`) and push them to your fork (`git push origin master`)
* Submit your change as a [pull request](https://github.com/helium/hip/pulls)

Within a reasonable timeframe after you've submitted your PR, a HIP Editor will review your pull request. 

The PR will be merged if it adheres to the standards outlined in this document, which formally opens it up for consideration. 
If there are issues, the HIP Editor will provide feedback. The feedback at this stage is intended to be logistical, rather than on the actual contents of the proposal this will include Permission Level changes.

## Discussion and Approval Process

_TODO this could use more detail; feedback & contributions very welcome_

1. Submit Pull Request (PR)
2. HIP Editor reviews PR and provides feedback and potential change for Permission Level
3. Accepting the PR
    1. If the HIP is an Original it will be added to the `helium/hip master/branch` as the Running PR
    2. If the HIP is a PR on an Original / Running PR it will remain a PR until a [rough consensus](https://en.wikipedia.org/wiki/Rough_consensus) is reached
4. Providing feedback or discussing any issues with the propsal
    1. If the HIP is an Original / Running PR it will have an open discussion in the `Issues` section of the `master/branch`
    2. If the HIP is a PR on an Original / Running PR then any disscussion or comments will be under the PR comments
        1. If the new PR of an Original / Running PR is favored via a [rough consensus](https://en.wikipedia.org/wiki/Rough_consensus) it will be commited to the `master/branch`
    3. Discussion can be performed in the [Discord #hips](https://discord.gg/helium) however, the issues should be recorded in Github for ease of access during process
5. Helium Engineers estimate for implementation or a PR with running code is available for the HIP. If the permission level is an *Idea* or *Concern* the final [rough consensus](https://en.wikipedia.org/wiki/Rough_consensus) for deployment will be via a community call. If the permission level is *Urgent* it can be deployed as soon as this is met.
6. If a HIP doesn't change status from *Discussion* to *Approved* within 6 months for `Idea` or 3 months for `Concern` it should be closed via a [rough consensus](https://en.wikipedia.org/wiki/Rough_consensus) during the final months community call. The HIP can also be closed immediately based on the original Authors approval.

## HIP Editors

As mentioned above, we'll need people to help organize and facilitate the HIP process. This is an administrative role, and Editors are not arbiters of what does or does not get approved.

Editors would be responsible for: 

* Reviewing new HIPs submitted to the GitHub repository
* Updating Permission Level based on HIP
* Flagging issues related to formatting and structure, but not commentary on its substance; that should be reserved until after the HIP's pull request has actually been merged.
* Evaluating community consensus and updating HIP statuses accordingly

## Review Committees

We expect different stakeholders to be more interested in Technical vs. Economic proposals, and so we suggest the formation of Review Committees for each of those tracks. 

Review Committees would be expected to meet regularly and discuss HIPs falling into their area, and in conjunction with HIP Editors, help keep the improvement process moving.

The committee is an informal group and anyone can join one of the calls and make their voice heard.

Since there relatively few HIPs and no clear members for any given committes, the newly launched Helium community calls can serve as a catch-all for reviewing proposals.

# Unresolved questions

* How are Review Committee members selected? Open to anybody or elected or other?
* How are HIP Editors nominated and selected? (Related: Who currently has write access to `helium/hip`?)
* How do community calls work? It's assumed in this document these will occur regularly and be open to the public
* Who are the current core developers? Who has the ability to merge code into core repositories? What are those core repositories?
* Who has the ability to deploy changes to the blockchain, and the related responsibility for its uptime?
* How long should a HIP be allowed to remain in a given state?
* Should we encourage people just to leave comments on GitHub, rather than trying to track GitHub, Slack and the forum?
