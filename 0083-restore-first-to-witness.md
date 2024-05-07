# HIP 83: Restore First to Respond Witness Rewarding

- Author(s): [@BFGNeil](https://github.com/BFGNeil), [@mawdegroot](https://github.com/mawdegroot)
- Start Date: 2023-05-05
- Category: Economic, Technical
- Original HIP PR: [#605](https://github.com/helium/HIP/pull/605)
- Tracking Issue: [#632](https://github.com/helium/HIP/issues/632)
- Voting Requirements: veIOT Holders

## Summary

Currently, the Proof-of-Coverage Oracles collect all the witnesses for a beacon and randomly reward a selection of 14 witnesses. This HIP proposes to revert to rewarding the first 14 Hotspots responding to a beacon, incentivizing the most useful Hotspots to sensor traffic by prioritizing the low latency connections that sensors need for uplinks, downlinks, and join requests to work correctly.

## Motivation

Rewarding witnesses that are the first to respond will incentivize Hotspots to provide the low-latency connection that the sensors desperately need.

Sensors use uplinks to transfer their data over the Helium network. For a sensor to join the Helium network, it must perform a handshake that requires both an uplink and a downlink. As a power-saving measure, a sensor often has a limited time window to listen for the downlink.

Because the sensor only listens for the downlink for a limited time, the Helium LNS and the Hotspots must minimize latency to ensure the Hotspot can deliver downlinks to sensors within the narrow sensor listening window.

The Helium network originally rewarded the fastest witnesses and moved to a random selection for several technical reasons that no longer apply to the Oracle-based POC architecture introduced as part of HIP 70.

Technical limitations included, but are not limited to:

- Regular retransmissions on the libp2p network left Hotspot unable to deliver witness reports.
- Hotspots struggled to sync the Helium blockchain before Validators and needed more time to
  determine which challenger to deliver a witness to.

## Stakeholders

Both Hotspot Operators and network users will be affected by this change as it will incentivize Hotspot deployments that are more beneficial to network users.

## Detailed Explanation

When a Hotspot transmits a beacon, it first fetches entropy from the Entropy Oracle to create the beacon data and construct the beacon.

The Hotspot broadcasts the constructed beacon and transmits a beacon report to the Ingest Oracle, which then attaches the current time in the `receivedTimestamp` field of the beacon report.

When a Hotspot witnesses a beacon, it signs the witness report and sends it to the Ingest Oracle, which attaches the current time in the `receivedTimestamp` field of the witness report.

The Verifier will invalidate witness reports with a `receivedTimestamp` value outside the entropy validity window (currently 3 minutes).

The Verifier Oracle will fetch a beacon report from the Ingester Oracle output together with all the corresponding witnesses of that beacon.

Currently, the Verifier Oracle will shuffle the witnesses and randomly selects 14 witnesses to reward for their work. **This HIP proposes ordering the witnesses by the `receivedTimestamp` field and selecting the 14 Hotspots with the lowest `receivedTimestamp` values instead.**

_NB: The amount of witnesses that is selected per beacon is currently set to 14, but can be reconfigured in the [oracles](https://github.com/helium/oracles/blob/1.1.0/iot_verifier/src/settings.rs#L39)_

## Drawbacks

There are several potential drawbacks to rewarding the fastest Hotspots to respond:

- Some network connections inherently have lower latency than others (e.g., fiber has lower latency than 4G).
- Though the vast majority of Hotspots use the same method to secure Hotspot identity, several other security methods are in use which may be faster or slower than the majority use case. Though given the minority position, this drawback should be limited.
- Approximately 600 DIY-Hotspots are using file-based keys and thus can sign witness reports faster than those with an ECC-based key.

## Rationale and Alternatives

Sensors require Hotspots to have a low latency connection to the Helium LNS for confirming uplinks, downlinks, and join requests to work correctly. If the latency is too high, the Hotspot will not be in time to transmit the downlink to the sensor, which may be sleeping and unable to receive the downlink. The rationale behind this HIP is that it incentivizes Hotspot owners to create a low latency setup and thereby reward those Hotspots that are most useful for sensors.

The most viable of the several considered alternatives is limiting the entropy validity window, with witness reports received outside the window automatically invalidated by the Verifier Oracle. This approach has a similar but dampened effect and will not affect witness stuffing, contrary to rewarding the first to respond.

The most crucial reason for proposing rewarding the first witnesses to respond above this alternative is to make witness stuffing much harder. Witness stuffing introduces delays, meaning the witness is less likely to arrive among the first 14 witnesses.

## Unresolved Questions

- Which hotspots are faster than others, and which hotspots are slower.

With the help of [HeliumGeek](https://heliumgeek.com/) a tool has been created to visualize what the proposed change means for individual hotspots.

[HeliumGeek HIP 83 tool](https://heliumgeek.com/maps/hip83.html).

"_The data displayed here represents a 7-day period and is updated once or twice a day. Please note that the presented Reward Units reflect the rewards earned specifically from witnessing activities. It's important to remember that hotspots are also rewarded for beaconing. Therefore, if the [Reward Units](https://heliumgeek.com/faq/what-is-a-reward-unit.html) shown here increase, it does not necessarily mean that the actual IOT rewards will increase by the same amount._"

## Deployment Impact

The deployment of this proposal is minimal as it is a relatively simple change to the Verifier Oracle with the added benefit of being easily reverted by rolling back Verifier Oracle code changes. This deployment is supported by staged code and can be viewed [here](https://github.com/helium/oracles/compare/main...mawdegroot:oracles:mg/first-to-respond-witnessing).

## Success Metrics

Successful deployment means that:

- Hotspots too slow to serve sensors will receive fewer rewards.
- Legitimate Hotspots receive more rewards in areas where witness stuffing is active.
- Hotspots handling data traffic receive more rewards than those that are consistently too slow.
