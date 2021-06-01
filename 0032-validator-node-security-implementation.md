# HIP 32: Validator Node Security Implementation(s)

- Author(s): [@BFX](http://github.com/Bx64/), [@cryptomaniac](https://github.com/cryptomaniac79/)
- Start Date: 2021-06-01
- Category: Technical
- Original HIP PR: not filed yet
- Tracking Issue: not filed yet
- Status: to be filed

# Summary
[summary]: #summary

Currently, validator node IPs are public and the testnet explorer show not only location, ISP and region but the API also discloses the IPs of validators, as can be seen [in the testnet explorer](https://explorer.helium.wtf/validators) and [testnet API](https://testnet-api.helium.wtf/v1/validators/elected). These IPs are also traceable on the network. This poses a security risk for network participants that choose to run a validator. Malicious actors can reap benefits by attacking benevolent actors in the validator pool, for instance by targetting a majority of validators and modifying their blocks to forge new coins to addresses they control, or by mounting DDoS attacks and increasing the chance of their validators being elected into CG, subsequently increasing their own earnings at the cost of other actors in the network. One does not need to target the nodes in the current consensus group, but can take out the competition (other validators waiting to be elected) and significantly increase the chances of having their own nodes elected. Due to the significant gains that can be made this way, it should be considered a critical issue and therefore be addressed as quickly as possible.

# Motivation
[motivation]: #motivation

As validators will take over all activities regarding consensus on the Helium network, the pool of actors in charge of validating transactions and creating blocks is significantly reduced from the current situation (46K+ hotspots and growing fast) to a small pool of (expected) several hundreds of nodes, which significantly decreases the targets that need to be interfered with in order to impact consensus in one's own favor. Having these nodes be publicly visible, traceable and targetable on the Helium network therefore poses a significantly increased security risk compared to the current situation. 

# Stakeholders
[stakeholders]: #stakeholders

This change will not affect any current Hotspot owners or HNT holders as it is aimed at the validator node CG implementation. For testnet validator operators, a series of private and/or public tests should be considered. If it is needed to increase activity or participation, it may be possible to consider bounties for finding security vulnerabilities in the implementation.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

.......

# Drawbacks
[drawbacks]: #drawbacks

The implementation of security improvements to the current protocol and codebase can incur a delay in the projected release of validators on mainnet, which was slated for Q2 2021. The importance of having a solid and secure implementation outweighs this aspect, in our opinion.

In case of sentry nodes (or a similar solution to the problem described), operator cost may increase due to the fact of having to setup several nodes instead of just one. However, earnings should still outweigh these costs and validators should be aware that downtime due to SVs or malicious actors will mean they would earn far less rewards, or none at all.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

.......

# Unresolved Questions
[unresolved]: #unresolved-questions

.......

# Deployment Impact
[deployment-impact]: #deployment-impact

.......

# Success Metrics
[success-metrics]: #success-metrics

.......
