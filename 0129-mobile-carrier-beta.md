# HIP 129: MOBILE Carrier Beta

- Author: [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-07-22
- Category: Economic, Technical
- Original HIP PR: [#1057](https://github.com/helium/HIP/pull/1057)
- Tracking Issue: [#1058](https://github.com/helium/HIP/issues/1058)
- Vote Requirements: veMOBILE Holders

---

## Summary

This Helium Improvement Proposal introduces the concept of a "Beta Carrier" and proposes that all MOBILE Wi-Fi Hotspots be remotely opted in to service Beta Carrier subscribers, with the ability of the Hotspot operator to opt out thereafter. This HIP specifically and uniquely contravenes the restriction placed on Hotspot firmware manufacturers requiring that unrewarded traffic must be intentionally enabled by Hotspot operators for the purpose of expanding the service.

## Motivation

Helium Mobile, the first Service Provider on the MOBILE subnetwork, is currently in active beta trials with three Tier-1 mobile network operators (MNOs) to provide carrier Wi-Fi offload services. With only 24 hotspots voluntarily opting in to participate in the beta, the Helium Network has seen thousands of unique connections per day and significant data traffic, which so far has been unpaid. MNOs have indicated that they would eventually be willing to pay for some of the traffic in some locations, but:

- They would need to retain control over when and how much they pay for specific locations.
- They would need exposure to a larger fleet of Hotspots that they can connect to and offload data to on-demand, to make the Helium Network relevant to them.

We believe that opening up the rest of the Hotspots in the Helium Network to MNOs will accelerate beta evaluations by carriers and allow Hotspot owners to start monetizing MNO data traffic sooner.

## Stakeholders

Wi-Fi Hotspot operators will have their Wi-Fi Hotspots opted-in to serve Beta Carrier traffic, irrespective of that traffic being paid, and they will have the option to opt-out at any point via the Hotspot dashboard or Helium Mobile Builder app.

## Detailed Explanation

In this proposal, we formally introduce the Beta Carrier program. Service Providers can onboard any carrier of reasonable scale (determined by the Service Provider's internal processes) as a Beta Carrier without the need for a community vote. Beta Carriers can choose where and how much they pay for Wi-Fi data offload through their relationship with the Service Provider, including the ability not to pay at all. However, Beta Carriers will only get access to the Hotspots that are opted in to serve Beta Carriers through their firmware and management applications. Abuse of the Beta Carrier program can lead to the Mobile Working Group or community recommending a slashing of the Service Provider's locked MOBILE stake and confirmed via community vote.

In order to ensure that Hotspot operators may control how Beta Carriers expand services through the Helium network, certain expectations are set for Hotpot firmware and application developers. Upon approval of this HIP, Hotspot firmware may be updated to enable this new class of traffic (for Beta Carriers) and may be deployed in a matter where Hotspots are automatically opted into this feature with reasonable notification via typical communication channels between Hotspot manufacturers and their customers. Hotspot operators must still have the option to opt-out of serving Beta Carriers and opt back in at a later date. We recommend that firmware manufacturers enable visibility of which carriers are connected to them each day, the number of connections they are serving, and the amount of data being used for this subset of traffic. This will allow Hotspot operators to determine whether they want to continue to serve this traffic.

This HIP proposes no changes to Proof-of-Coverage or Service Provider (non Beta Carrier) data pricing at this time, but we imagine that the data from these trials will provide public visibility into how the program is progressing across carriers and potentially influence future changes in the network.

## Drawbacks

Some Hotspot operators who are not actively following the network may not realize that their Hotspot is opted in to service free data traffic by default and may be caught by surprise. To mitigate this, Wi-Fi Hotspot manufacturers will provide ample warnings through various means (notifications on the dashboard, emails, etc.) to ensure that everyone who wants to opt out of the beta has the ability to do so.

Hotspots that serve a lot of Beta Carriers for free and those that opt out will earn the same POC and data rewards. To mitigate this, it is suggested to display a public dashboard that will praise beta participants and shame the “reward squatters,” laying the groundwork for an eventual POC change, if required.

## Rationale and Alternatives

One alternative is to attempt to proceed with [HIP 126](0126-flexible-data-pricing-for-mobile-network.md), as originally planned, and change the pricing scheme for the entire network, allowing Hotspot operators to dynamically adjust pricing. This change, however, is harder to get community consensus behind and harder to implement.

## Unresolved Questions

Some community members have voiced the opinion that limits to data access should be implemented along with this change, such as throttling the data to a certain level and/or setting upper limits on the amount of data that can be used by Beta Carriers. Implementing such throttling will take time. We, therefore, suggest that this be implemented at a later stage when and if it becomes clear that such controls are required.

## Deployment Impact

Should this HIP pass, Nova Labs will complete the implementation and will collaborate with the Helium Foundation on deploying any required on-chain changes.  

## Success Metrics 

The total aggregate amount of data (both paid and unpaid) should increase by at least 10x no later than six months after HIP deployment, and the total amount of paid data should at least double.
