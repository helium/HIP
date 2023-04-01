# XX Restore first to respond witness rewarding

- Author(s): @BFGNeil, @mawdegroot
- Start Date: 2023-03-23 <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: economic, technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

The Proof-of-Coverage oracles collect all the witnesses for a beacon and randomly select 14 witnesses that will be rewarded. This HIP proposes to revert back to rewarding the first 14 hotspots that respond to a beacon. By rewarding the first 14 witnesses to respond to a beacon we incentivize the hotspots that are most useful to sensor traffic. It is important to note that sensors need low latency hotspots in order to successfully downlink and join the Helium network.

## Motivation

Sensors use uplinks to transfer their data over the Helium network. In order for a sensor to join the Helium network it must perform a handshake that requires both an uplink and a downlink. To save power a sensor has a limited time window in which it listens for the downlink. Because the sensor only listens for the downlink for such a limited time it is crucial that the latency between the Helium LNS and the hotspot is small because the hotspot will not be able to deliver the downlink in time without it.

The Helium network originally only rewarded the fastest witnesses but this was changed to a random selection due to several reasons. One of the biggest reasons was that the libp2p network that hotspots used to communicate required regular retransmissions which meant that hotspots were unable to deliver the beacons that they witnessed. Another reason was that hotspots had such a hard time syncing the block chain they sometimes needed more time to succesfully figure out which challenger to deliver their witness to. Both these reasons no longer apply because the off chain PoC architecture that was introduced as part of HIP70 have made PoC much more manageable for hotspots.

By switching back to rewarding witnesses that are the first to respond we incentivize hotspots that provide the low latency connection that the sensors desperately need.

## Stakeholders

Every hotspot owner will be affected by this change. Besides hotspots the network users will be affected as this change will incentivize hotspot deployments more beneficial to network users.

## Detailed Explanation

When a hotspot beacons it first fetches entropy from the entropy oracle. The entropy is used to create the beacon data and construct the beacon. The constructed beacon is broadcasted and a beacon report is transmitted to the ingest oracle. Upon receiving the beacon report the ingest oracle attaches the current time to the report in the `receivedTimestamp` field of the beacon report.

When a hotspot witnesses a beacon it signs the witness report and sends it to the ingest oracle. Similar to the beacons, the ingest oracle will attach the current time to the witness report in the `receivedTimestamp` field of the witness report. The verifier will invalidate any witnesses that have a `receivedTimestamp` that is larger than the entropy validity window (currently 3 minutes).

The verifier oracle will fetch a beacon report from the ingester oracle output together with all the corresponding witnesses of that beacon. Currently the verifier oracle will shuffle the witnesses and randomly pick 14 witnesses that will be rewarded for their work. **This HIP proposes to instead order the witnesses by the `receivedTimestamp` field and select the 14 hotspots with the lowest `receivedTimestamp`.**

## Drawbacks

There are several drawbacks to rewarding the fastest hotspots. Some network connections inherently have a lower latency than others (e.g. fiber has a lower latency than 4G). Another drawback is that there are approximately 600 DIY-hotspots that will have a file-based key and thus will be able to sign the witness report faster than those with an ECC based key. Besides file-based keys there are several other security methods to secure the hotspot identity that may be faster or slower than what the majority uses. The vast majority of hotspots uses the same security method so this drawback should be limited.

## Rationale and Alternatives

As listed in the motivation sensors require hotspots to have a low latency connection to the Helium LNS in order for confirmed uplinks, downlinks and join requests to work correctly. If the latency is too high the hotspot will not be in time to transmit the downlink to the sensor and the sensor will be sleeping, unable to receive the downlink. The rationale behind this HIP is that it incentivizes hotspot owners to create a low latency setup and thereby reward those hotspots that are most useful for sensors.

Several alternatives were considered. One of the most viable alternatives we considered was limiting the entropy validity window. Witnesses that are received outside entropy validity window are automatically invalidated by the verifier oracle. This would have a similar but dampened effect but contrary to rewarding first to respond will not affect witness stuffing. The most important reason for proposing that we reward the first witnesses to respond above this alternative is that it makes witness stuffing much harder. Witness stuffing introduces delays and those delays will mean the witness is less likely to arrive among the first 14 witnesses.

## Unresolved Questions

Which hotspots are faster than others, which ones are slower (data to follow)

## Deployment Impact

The deployment of this proposal is minimal as it is a relatively simple change to the verifier oracle. The change can be easily reverted by reverting the verifier oracle code changes.

## Success Metrics

The success of this HIP is hard to quantify, nevertheless a successful deployment of this HIP means that hotspots that are too slow to serve sensors will receive less rewards. Success also means that in areas where witness stuffers are active more legitimate hotspots are rewarded. A third success metric is determining (via mappers or otherwise) that the hotspots that are handling data traffic are receiving more rewards than those that are consistently too slow.
