# HIP19a: Amendment to the Approval Process For Third-Party Manufacturers (Light Hotspots)

- Author(s): @cokes518 (cokes)
- Start Date: 2021-02-09
- Category: Meta
- Original HIP PR: 
- Tracking Issue: 
- Status: 

# Summary

This proposal is an amendment to HIP 19 (Approval process for Third-Party Manfucturers) to include requirements for trusted Light Hotspots to participate in the network.

For Light Hotspots to be added to the Network, Validators must be a network participant to handle consensus. Shipping to consumers cannot happen until HIP25 is implemented in production.

# Motivation

With the incoming launch of Validators (HIP25), the network no longer requires compute-intensive Hotspots to run consensus groups. This reduces the requirements for Hotspots such that they become "Light Hotspots". Light Hotspots are a new subclass of trusted Hotspots on the Network, able to participate in PoC, Witness, and create Challenges. In addition to PoC activities, they can transfer Data Packets. Light Hotspots will earn HNT for these activities. 

Light Hotspots will **not** participate in Consensus and will be flagged as such on the Blockchain. They will not mine HNT for participating in Consensus.

The reduced compute requirements will enable a new class of lower-cost Hotspots to enter the market.

# Stakeholders

Almost everyone involved in the Helium ecosystem, but especially:

- Prospective third-party Light Hotspot manufacturers
- Prospective hotspot owners, who might have been deterred by cost, features or lack of availability
- Current hotspot owners, whose earnings will be further diluted as the network grows
- Network end-users, who desire broader coverage


# Detailed Explanation

This amendment to HIP19 will maintain all application requirements of Hotspots, but removes the audit and compute requirement to run and participate in consensus.