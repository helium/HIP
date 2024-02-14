# HIP 102: Helium Educational LNS - Unrewarded Trial Network

- Author(s): [@jthiller](https://github.com/jthiller)
- Start Date: 2023-12-06
- Category: Economic
- Original HIP PR: [#820](https://github.com/helium/HIP/pull/820)
- Tracking Issue: [#835](https://github.com/helium/HIP/issues/835)
- Vote Requirements: veIOT Holders

## Summary

This proposal seeks to introduce a dedicated LoRaWAN Network Server (LNS) for educational and trial use on the Helium IoT Network, operating under the Helium Foundation's Type 6 NetID (0xC00053). The key feature of this LNS is to offer free data transfer services for educational, trial, and experimental purposes, with a critical operational distinction: these data transfers will not be rewarded to Hotspots, thus preventing the exploitation of the network. This initiative aims to provide a secure and controlled learning environment for users, without compromising the integrity and economic model of the main Helium Network.

## Motivation

The goals of the changes proposed in this HIP are to foster learning and experimentation within the Helium IoT Network. Operating under the Helium Foundation's Type 6 NetID (0xC00053), this new LNS would offer a unique educational and trial platform. It would allow free data transfers for educational and experimental purposes but with a key difference: these transfers will not yield rewards for Hotspots, ensuring the network's integrity and preventing potential exploitation. This approach seeks to balance the need for an open, accessible learning environment with the maintenance of the economic and operational stability of the main Helium Network.

As a broad overview, these bulleted sections highlight the impact areas and opportunities.

**Future of Foundation Console**

- Foundation Console will continue to operate. However, no new accounts will be added. Existing users will be able to continue to fund their accounts and operate up to 10 devices. The operation of Foundation Console remains under the purview of the Helium Foundation.
- The home page of Console will be restyled to serve as an index of other known public LNSs in the ecosystem, leveraging the list maintained at [docs.helium.com](https://docs.helium.com/iot/find-a-lns-provider).
- Moving the community past Foundation Console drives growth across the broader ecosystem of LNS operators.

**Continued Trial & Educational Access**

- A new LNS is created using ChirpStack since the platform drives the underlying infrastructure of current public LNS offerings. It is configured for simple sign up and devices are permitted to operate for one day.
  - Eventually, this offering can grow into an ecosystem of trial services, such as instances of ThingPark Community or others, all following the same trial model as outlined for ChirpStack.
- The new LNS offering, sitting on top of the Helium Foundation Type 6 NetID, would not issue rewards to Hotspots responsible for data transfer.

## Stakeholders

This HIP affects all participants of the Helium IoT Network. The two most greatly impacted stakeholders are explained below.

### Network Users

Network users, as stakeholders in the new LNS, will benefit from a dedicated space for learning and testing. This LNS, which does not offer rewards for data transfer, aims to prevent misuse and maintain the network's integrity. Users will need to understand its different rules and purpose compared to the main Helium Network and adapt to its use limitations, including temporary device blocking. Their feedback will be important in shaping the future of this educational platform.

### Hotspot Operators

Data traffic passed through the special LNS would not be rewarded to Hotspots or their operators. However, the core intent of this service is to drive more users to the network. If successful, this would drive greater traffic for Hotspots and their operators.

## Detailed Explanation

The primary objective of this proposal is to establish a free-to-use LoRaWAN Network Server (LNS) dedicated to educational and trial purposes. This LNS will operate under the Helium Foundation's Type 6 NetID, distinctly separate from OUIs issued using the Type 0 NetID. The initiative is driven by the need to provide a secure, controlled environment for users to learn, experiment, and test without the risks associated with the main network, particularly the exploitation of free Data Credits.

To achieve this, we propose configuring the Helium Packet Router in such a way that it reports the packets, but the Packet Verifier ignores packets attributed to the Foundation Type 6 NetID. This configuration is crucial to ensure that data transfer through the free service is not rewarded to Hotspots, thus eliminating the incentive for exploitation, while maintaining metrics and insight.

In addition, the LNS will be set up with specific operational rules to further safeguard network operations. Initially, devices will be allowed to operate on the LNS for one day. Following this, they will be automatically removed and blocked from the service for one week. This measure is designed to prevent continuous use of the network by a single user or device, thereby discouraging attempts to use this free service to exploit network coverage available on Helium. It also reinforces the utility of the Helium network for deployment-based use cases.

The presence of a closely managed free route in the ecosystem introduces numerous opportunities including but not limited to: interactive educational materials, coverage mapping platforms, and other initiatives.

## Drawbacks

Data transfer through the Helium Foundation Type 6 NetID would not be rewarded to Hotspots (and their operators) nor would it be accounted for in the Network Utility Score. However, by the design of this HIP, free network traffic should be relatively insignificant in contrast to paid traffic. Furthermore, the intent of this change is to onboard more network users, and subsequently more traffic through Hotspots.

## Rationale and Alternatives

Broadly, the content of this HIP should demonstrate the importance placed on providing access to developers in the LoRaWAN ecosystem. Past efforts to provide free or zero-profit access have proven to present numerous challenges. We feel that the passthrough of free data exclusively for trial and educational purposes is the best design for the long-term success of the network. Not making this change at this time would leave a void for developers and deployers curious to step into using the network.

In our current scenario where no new users can create accounts on Foundation Console, some alternative approaches do exist. However, we feel that this HIP proposes the best-case outcome.

- **Converting Foundation Console into a paid service.**  
  The conversion of Foundation Console into a paid service unnecessarily competes with the growing ecosystem of developers already providing these services. Furthermore, Foundation efforts are best focused on the protocol, advocacy, and other defined goals.
- **Leaving educational efforts to third-party providers.**  
  Foundation stands as the steward of the network. While third-party providers may offer trial or demo accounts, having a central entity that allows developers and deployers to trial the network means that any walkthrough or other educational material may point to the Helium Foundation for access to the most accurate and up-to-date experience. It does not need to be the responsibility of the network operator to offer these services.
- **Creating an application process (KYC) for access to Console.**  
  Implementing KYC for each user creates significant overhead and eliminates the ease of use that should be delivered for new users looking to test the network.
- **Setting limits on accounts, users, or devices.**  
  When Console was established, there were no limits on usage. Ultimately a 10-device cap was instituted per organization. However, for bad actors, this was an insignificant hurdle. Additionally, there was an allocation of Data Credits granted to each new user account, however, this allocation of free Data Credits was also abused. Setting limits on accounts only serves to force bad actors to broaden their efforts.

An alternative implementation of free & unrewarded traffic exists, which is to specify an exact OUI rather than a NetID. For reference, the existing Foundation Console operates on OUI 1. This solution is unfavorable – Specifying a single OUI limits the opportunity to expand educational tools to alternate LNSs.

## Unresolved Questions

While associated with this change, the ongoing operational plan for the existing Foundation Console is out of scope for this proposal and continues to operate under the guidance of the Helium Foundation. This proposal is concerned primarily with the updated treatment of the Foundation Type 6 NetID.

Initial timeframes for device aliveness and disallowment are initially proposed at 1 day and 1 week, respectively. These values feel to be appropriate time periods for a user to experiment with the network, but the community may offer additional insight on what these initial values should be set to. In the long term, the Helium Foundation should make changes to these values as-needed, and without additional governance.

## Deployment Impact

The Type 6 NetID was used for testing during the development of Helium Packet Router. The OUIs 60, 61, 62, and their DevAddr slabs have been disabled and are unaffected by this change.

On documentation, previous educational materials would need to be updated to detail processes in Chirpstack. As an exciting opportunity, the ability to provision a non-rewarded device means that device provisioning can happen directly through docs, creating opportunities for new interactive learning materials.

As an additional detail, docs currently serves the list of public LNS operators as a community reference. This list would be utilized to inform users looking for long-term LNS services at console.helium.com.

## Success Metrics

This HIP can be deemed successful if the limited access to free and unrewarded data transfer on the Helium IoT Network enables developers to better understand the Helium LoRaWAN opportunity. Success comes with an easing of learning curves, the ability for other LNS operators to attract new users, and for the network to see more adoptions from developers.

Metrics from the OUIs operating on the Foundation Type 6 NetID will all be recorded in Oracle data stores. As a means to offer transparency to the community, a dashboard will be created to represent metrics such as the number of distinct devices, traffic metrics, Hotspots used, etc.
