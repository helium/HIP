# HIP 129: Carrier Beta Default Opt-In

- Author: [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-07-22
- Category: Economic, Technical
- Original HIP PR: [#1057](https://github.com/helium/HIP/pull/1057)
- Tracking Issue: [#1058](https://github.com/helium/HIP/issues/1058)
- Vote Requirements: veMOBILE Holders

---

## Summary

This Helium Improvement Proposal introduces the concept of a “Beta Carrier” and proposes that all MOBILE Wi-Fi Hotspots be opted in to service Beta Carrier subscribers by default, with the option to opt out at any time by the Hotspot operator.

## Motivation

Helium Mobile, the first Service Provider on the MOBILE subnetwork, is currently in active beta trials with three Tier-1 mobile network operators (MNOs) to provide carrier Wi-Fi offload services. With only 24 hotspots voluntarily opting in to participate in the beta, the Helium Network has seen thousands of unique connections per day and significant data traffic, which so far has been unpaid. MNOs have indicated that they would eventually be willing to pay for some of the traffic in some locations, but:

- They would need to retain control over when and how much they pay for specific locations.
- They would need exposure to a larger fleet of Hotspots that they can connect to and offload data to on-demand, to make the Helium Network relevant to them.

We believe that opening up the rest of the Hotspots in the Helium Network to MNOs will accelerate beta evaluations by carriers and allow Hotspot owners to start monetizing MNO data traffic faster.

## Stakeholders

Wi-Fi Hotspot operators will have their Wi-Fi Hotspots opted in to serve Beta Carrier traffic, irrespective of that traffic being paid, but they will have the option to opt-out at any point via the Hotspot dashboard or Helium Mobile Builder app.

## Detailed Explanation

- We formally introduce the Beta Carrier program.
- Any carrier with 5 million or more active subscribers can join the Beta Carrier program without the need for a community vote to become a Service Provider.
- Beta Carriers can unilaterally choose where and how much they pay for Wi-Fi data offload, including the ability not to pay at all.
- However, Beta Carriers only get access to a limited number of Hotspots that are opted in to serve Beta Carriers.
- Upon approval of this HIP, all Wi-Fi hotspots will be opted in to serve Beta Carriers. Any new Wi-Fi hotspots that come online will also be opted in to serve Beta Carriers by default.
- Hotspot operators can opt in or out of serving Beta Carriers in the Helium Mobile Builder app or Helium Mobile dashboard at any time. Hotspot operators will also see data on which carriers are connecting to them each day and how much data they are using in the app and dashboard, allowing them to decide whether to stay opted in.
- The Helium Mobile Network Planner will add a dashboard showing Hotspot ranking based on unique connections served during the trailing seven days, plus Proof-of-Coverage and data earnings for said Hotspots. Hotspots that earn a lot of POC rewards but serve no Beta Carriers (and vice versa) will be publicly visible.
- This HIP proposes no changes to POC or data pricing for now, but the dashboard will provide public visibility into how the beta is progressing across carriers.

## Drawbacks

Some Hotspot operators who are not actively following the network may not realize that their Hotspot is opted in to service free data traffic by default and may be caught by surprise. To mitigate this, Wi-Fi Hotspot manufacturers will provide ample warnings through various means (notifications on the dashboard, emails, etc.) to ensure that everyone who wants to opt out of the beta has the ability to do so.

Hotspots that serve a lot of Beta Carriers for free and those that opt out will earn the same POC and data rewards. To mitigate this, it is suggested to display a public dashboard that will praise beta participants and shame the “reward squatters,” laying the groundwork for an eventual POC change, if required.

## Rationale and Alternatives

One alternative is to attempt to proceed with [HIP 126](0126-flexible-data-pricing-for-mobile-network.md), as originally planned, and change the pricing scheme for the entire network, allowing Hotspot operators to dynamically adjust pricing. This change, however, is harder to get community consensus behind and harder to implement.

## Unresolved Questions

Some community members have voiced the opinion that limits to data access should be implemented along with this change, such as throttling the data to a certain level and/or setting upper limits on the amount of data that can be used by Beta Carriers. Implementing such throttling will take time. We, therefore, suggest that this be implemented at a later stage when and if it becomes clear that such controls are required.

## Deployment Impact

Nova Labs will complete the implementation, should this HIP pass voting.

## Success Metrics 

The total aggregate amount of data (both paid and unpaid) should increase by at least 10x no later than six months after HIP deployment, and the total amount of paid data should at least double.
