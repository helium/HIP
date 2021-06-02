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

The risk of sharing node IP addresses is well documented, a large number of different chains (DPoS & PoS) have approached protecting the delegate/validator nodes IP address from being published.  A validator node can be attacked using the Distributed Denial of Service method. The validator node has a fixed IP address and it opens a XXXXX port facing the Internet.

One recommended way to mitigate these risks is for validators to carefully structure their network topology in a so-called sentry node architecture.

Validator nodes should only connect to full-nodes they trust because they operate them themselves or are run by other validators they know socially. A validator node will typically run in a data center. Most data centers provide direct links the networks of major cloud providers. The validator can use those links to connect to sentry nodes in the cloud. This shifts the burden of denial-of-service from the validator's node directly to its sentry nodes, and may require new sentry nodes be spun up or activated to mitigate attacks on existing ones.

Sentry nodes can be quickly spun up or change their IP addresses. Because the links to the sentry nodes are in private IP space, an internet based attacked cannot disturb them directly. This will ensure validator block proposals and votes always make it to the rest of the network.

# Drawbacks
[drawbacks]: #drawbacks

The implementation of security improvements to the current protocol and codebase can incur a delay in the projected release of validators on mainnet, which was slated for Q2 2021. The importance of having a solid and secure implementation outweighs this aspect, in our opinion.

In case of sentry nodes, operator cost may increase due to the fact of having to setup several nodes instead of just one. However, earnings should still outweigh these costs and validators should be aware that downtime due to SVs or malicious actors will mean they would earn far less rewards, or none at all.

While sentry nodes can improve validator security, there are multiple trade-offs involved.

The notion of sentry nodes adds complexity to both the node implementation itself as well as the overall network topology. One example concerns any component using the DHT. When publishing a validators addresses the authority discovery module on a validator node can not do so directly, but has to forward the signed addresses to one of its sentry nodes for it to publish them on the DHT.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Use of Sentry Nodes: 
The validator is only going to talk to the sentry nodes, while sentry nodes have the ability to talk to the validator node on the private channel and talk to public nodes elsewhere on the Internet. However, they could be set up to talk to each other on the private network too.

TCP proxy front end: All operators of validator nodes are required to make the TCP port of the P2P protocol of their validator nodes routable via the public internet. The TCP port of the RPC endpoint should stay unchanged and protected.

While the P2P protocol port of a validator node needs to be publicly routable, one can still protect the endpoint on layer 4 (TCP) and downwards. Depending on your required security level you might want to put a mature TCP proxy in-front of your validator (e.g. Nginx). You can operate a stateful firewall yourself or use a hosted firewall / DOS protection service by your favorite cloud provider. You can consider reaching out to a large CDN. ...

Once supported, we recommend using remote signing, doing all relevant cryptographic operations not on the validator node itself, but on a separate node. There might be an intermediate feature version allowing cryptographic operations to happen in a different OS process on the same machine.

Follow operational best practices. Only expose a minimal amount of ports. Make sure to record logs. Setup monitoring for each machine and application involved. Configure alerting software. ...

# Unresolved Questions
[unresolved]: #unresolved-questions

.......

# Deployment Impact
[deployment-impact]: #deployment-impact

The extra hop for all traffic destined for a validator behind sentry nodes adds latency. This latency is not to be confused with the latency a commodity layer-4 proxy would introduce. Instead, as the sentry node operates as a full node, the additional latency does not only involve packet forwarding or transport-layer-security de- and encryption, but also things like block validation.

# Success Metrics
[success-metrics]: #success-metrics

.......

# Sources
Links to various articles..
