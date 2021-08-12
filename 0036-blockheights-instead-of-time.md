# HIP 36: Blockheight for (variable) activation on blockchain

- Author(s): [@BFX](http://github.com/Bx64/)
- Start Date: 2021-08-06
- Category: Technical
- Original HIP PR: [257](https://github.com/helium/HIP/pull/257)
- Tracking Issue: [260](https://github.com/helium/HIP/issues/260)
- Status: In Discussion

# Summary
[summary]: #summary

At the time of writing, most (if not all) blockchain variables and implementations are activated manually by the Helium team, requiring active intervention from the team and have a time-based activation. The active intervention can, for the greatest part, be avoided by enabling auto-activation of variables at certain blockheights. This has been the standard for most blockchain projects. One example is the bi-yearly halving of HNT rewards agreed to in HIP20 which should be integrated with blockheights rather than be defined by moment in time for its activation - and in the future, hopefully any change of blockchain variables can be defined that way.

# Motivation
[motivation]: #motivation

The use of blockheights for activation of on-chain features has been the standard for blockchain projects since the inception of Bitcoin over a decade ago. By following suit, not only will variable activation no longer require manual intervention, but future changes to these variables can be implemented already to be activated at a later blockheight, reducing workload and possible points of failure for the team and community. Blockheights are indifferent to timezones, which is an additional advantage as it provides clarity for users around the globe.

# Stakeholders
[stakeholders]: #stakeholders

This change will not affect any current Hotspot owners, HNT holders, validators or other community members. The Helium team and community developers will have to start using blockheights to determine activation periods, but besides this point there should be no significant change for anyone.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Blockchains are made up of blocks that follow up one another, creating a chain of blocks - hence the name. The first block is generally called 'genesis' and has the index, or height, zero or one. Each subsequent block in the blockchain has a blockheight one higher than the block before. Blockheight therefore refers to a certain block (be it in the past, future or the most recent block) in the blockchain.

The generation of new blocks is governed by a consensus protocol, and in the case of Helium they are now produced by validators. The consensus protocol aims for an average creation time of 60 seconds per block, or 1440 blocks per day, or 525600 per (non-leap) year. The individual blocktimes can differ slightly, but generally blocks are created at an average of 60 seconds per block. The consensus protocol and averaging of blocktimes means anyone can calculate at what time a certain future blockheight will be reached, which gives an additional benefit of not having to work with timezones prevent ambiguity of activation times for network participants in different regions of the world.

As any chain variable needs to be activated on-chain through a transaction, using time-based activation is counter-intuitive since - due to the slight variation of individual blocktimes - a time cannot be confirmed with certainty beforehand, whilst a blockheight can. Additionally, a benefit of using blockheights means future changes to variables can already be included in the initial activation transaction. The halving schedule could be setup to half rewards at blockheights with increments of 1051200 blocks (2 * 365d * 24h * 60m). 

# Drawbacks
[drawbacks]: #drawbacks

None at this time.

# Unresolved Questions
[unresolved]: #unresolved-questions

None at this time.

# Deployment Impact
[deployment-impact]: #deployment-impact

Existing chain variables may need to be re-coded to allow for blockheight activation. Current (non-closed) HIPs are not affected, with the exception of HIP 20. Adjustments to this HIP should be (not accounting for leap years, which could be ignored completely):
```
'Yearly minted amount'   to   'minted each 525600 blocks' 
'Halving each 2 years'   to   'halving each 1051200 blocks'
Start of block-based halving schedule at block 1997932 (which is 1051200 blocks after the most recent halving at block 946732)
```

# Success Metrics
[success-metrics]: #success-metrics

The implementation will be considered succesful if accepted and subsequently used as good practice by the team and community developers.

# Sources
None, but many examples exist of blockchains using blockheight instead of time for activation of on-chain variables and metrics.
