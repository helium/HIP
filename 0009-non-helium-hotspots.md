- Start Date: 19/02/2020 14:17
- HIP PR:
- Tracking Issue:

# Summary
[summary]: #summary

How to grow the network with non-helium hotspots

# Motivation
[motivation]: #motivation

- Why are we doing this?

In order to grow the network we need to allow non-helium hotspots to be
able to join the network.

- What use cases does it support?

3rd party manufactured hotspots and/or DIY hotspot builders should be
able to join and grow the network.

- What problems does it solve?

The most important problem that lies with allowing external hotspots to
join and/or grow the network is establishing trust.

- What is the expected outcome?

Any hotspot builder and/or manufacturer other than Helium should be able
to join the network and help it grow.

# Stakeholders
[stakeholders]: #stakeholders

- 3rd party hotspot manufacturers
- DIY hotspot builders

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

- Introduction

The fundamental problem we're trying to solve here is that we need the
ability to allow non-helium manufactured hotspots to be able to
successfully join the network. This however necessitates that we
establish a level of trust for these new hotspots.

In order to do so, we define the following new terms:

- External Agent

An external authority which allows regular hotspots to gain "anchor"
status.

- Anchor Hotspots

These are the hotspots which have been deemed to have full trust on the
network by the external agent. Thereby allowing full PoC priviledges
including challening and being a challengee.

- Probationary Mode

When a new hotspot joins the network, it does so in "probationary mode".
While this mode is active the PoC activity a hotspot is limited to only
witnessing other hotspots.

- Active Mode

Once a hotspot witnesses any other hotspot directly or indirectly
connected to an anchor hotspot, it gains full PoC priviledges and
transitions from probationary mode to active mode.


# Drawbacks
[drawbacks]: #drawbacks

- This proposal requires external input in the form of "external
  agents", that's a manual process, which may hinder fast network
  growth.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

- Why an external agent?

As far as we are aware, there currently exists no known solution for
network growth where there is absolutely no trust information. This
problem is exacerbated by the fact that we want to allow 3rd party
manufacturers and DIYers to be able to join the network.

The external agent solves this problem as a "trust authority".
Furthermore, this authority can be delegated to other manufacturers.
This is akin to the [X.509](https://en.wikipedia.org/wiki/X.509)
standard for defining the format of public key certificates, wherein a
browser would accept SSL certificates from issuing authorities like
LetsEncrypt as long as they adhere to the standard.

- Anchor hotspots

    - Hotspots which have been issued a trust badge (we can track this
      in the ledger) by the external agent can essentially gain full PoC
      priviledge.
    - Any hotspot witnessing the anchor hotspot automatically gains full
      PoC priviledge.

- Network growth without anchor

    - If there exists a network where no hotspot has any n-hop
      connection to a anchor hotspot, we assume no trust for such a
      network.
    - Every single hotspot in this network acts in probationary mode.
    - In order for the network to gain trust and subsequently full PoC
      priledges, an anchor hotspot must be introduced in this network.

- Network growth with anchor

    - If there exists a network with an anchor hotspot, any hotpot which
      has an n-hop path to the anchor hotspot is promoted from
      probationary mode to active mode.
    - Any new hotspot which joins such a network and can witness an
      active hotspot is automatically promoted to active mode.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Who acts as external agents?

- Can we build a web-of-trust by perusing the external agent and anchor
  hotspots?

# Deployment Impact
[deployment-impact]: #deployment-impact

- Current users may be downgraded to probationary status, if they are
  part of a sub-network where there is no anchor hotspot.

# Success Metrics
[success-metrics]: #success-metrics

NA
