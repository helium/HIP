# HIP 35: Safe RF Meta-Data Side Channel

- Author(s): [@wavesoft](https://github.com/wavesoft/), [@dmamalis](https://github.com/dmamalis)
- Start Date: 2021-07-28
- Category: Technical
- Original HIP PR: https://github.com/helium/HIP/pull/249
- Tracking Issue: https://github.com/helium/HIP/issues/250
- Status: In Discussion

# Safe extraction of RF Meta-Data

# Summary
[summary]: #summary

Large-scale IoT network operators are usually collecting analytics information from their gateways in order to check the status of their network and diagnose faults the moment they happen.

This is achieved by collecting RF meta-data from every packet received or transmitted and feeding it into an analysis stack for further processing.

Since such task typically involves tapping into the packet stream, a Helium hotspot owoner might be reluctant to allow a third-party tool to tamper with the stream, for security considerations.

Therefore, we are proposing a mechanism that would enable the extraction of packet meta-data without disclosing critical information that could be used for malicious purposes.


# Motivation
[motivation]: #motivation

Helium wants to deliver a fair, robust and secure solution to all of it's stakeholders. In order to achieve this, it requires full control over the components involved in order to minimize the chances of someone abusing the network.

This means that on an official helium gateway it's normally impossible to collect RF meta-data since it requires tampering with the most critical component: the packet forwarder. Therefore, we are proposing this HIP as the means for enabling RF meta-data collection without having to tamper with the internal components.


# Stakeholders
[stakeholders]: #stakeholders

* Professional network operators with big Helium network deployments
* Hotspot owners that want to diagnose reception issues
* Local helium communities that want to improve their coverage and overall network quality
* Hotspot manufacturers that want to provide diagnostic tools to their customers


# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## What are RF Meta-Data

Every time a packet is received, the packet forwarder includes useful information regarding it's quality. You can read the complete list of fields returned for every packet sent and received on [Semtech's packet_forwarder website](https://github.com/Lora-net/packet_forwarder/blob/master/PROTOCOL.TXT) but a short summary is the following:

Every time a packet is received (or scheduled for transmission) the following information are transferred:

* RF Quality (RSSI/SNR)
* RF Channel and Frequency
* RF Modulation and Encoding information
* GPS Timestamp (When the gateway is equipped with a GPS receiver)
* The packet data payload

In addition, the gateway is periodically pushing [summary statistics](https://github.com/Lora-net/packet_forwarder/blob/master/PROTOCOL.TXT#L206) that includes:

* Number of packets sent/received
* Number of packets rejected transmission or received with bad CRC
* Percentage of upstream datagrams that were acknowledged

All this information are obviously needed by the LoRaWAN core to function correctly, but they can also be proven helpful when you are trying to diagnose an issue in your network. For example: if you measure the average RSSI of the packets received over time and you see a degradation, then you might be having an issue with our antenna.


## Payload Considerations

As you can already see, most of the information above are just meta-data and announcing them to a third-party component will have negligible security side-effects. However, the contents of the `data` payload might contain sensitive information that must not be shared.

For example, consider a case where `data` holds a PoC payload: if this message gets shared with a third-party, it could be maliciously used to simulate more witnesses than in reality.

Therefore, we should consider the `data` payload _Unsafe_ and replace it with another representation that is safe, but still holds the valuable meta-data information needed. For example:

* Payload length in bytes
* Payload checksum (eg. ADLER32)
* The LoRaWAN MAC header bytes

And the justification is the following:

* The _Payload Length_ is enough for identifying cases where wrong spreading factors are used.
* The _Payload Checksum_ is used to de-duplciate the same packet when received by multiple gateways in a short period of time. Note that it does not need to be cryptographically secure (eg. SHA sums) and simpler checksums, with smaller impact on the processing time could be used. The ADLER32 is suggested as a good trade-off between speed, memory usage and randomness of the result.
* The LoRaWAN MAC header holds useful information to diagnose LoRaWAN issues and must be included intact into the meta-data. This header is found in the first 8 bytes of the payload and it does not hold any application-level information (eg. the contents of the PoC message). 


## Analytics Side-Channel Proposal

We are proposing the introduction of an _Analytics Side-Channel_ that can be used by the stakeholders to consume analytics of the incoming messages in a secure and reliable manner.

```
 +------------------+  Semtech UDP  +----------------+
 | Packet Forwarder | ------------> | Hotspot Client | ----> Helium Network
 +------------------+               +----------------+
                                            | Analytics Side-Channel
                                            v
                                   . . . . . . . . . . .
                                   . Analytics Client  .
                                   . . . . . . . . . . .
```

The proposed solution should:

1. Induce minimum overhead to the client
2. Be easy to integrate into the client codebase
3. Allow existing solutions to be easily adapted to the new interface

Considering that:

1. The Analytics Side-Channel should be implemented using a connection-less protocol such as UDP, since we don't care about reliability and back-pressure from the consumer must not affect the producer.
2. The amount of processing power must be reduced to the minimum, therefore an ADLER32 checksum is recommended for the payload instead of the computational-intensive cryptographic hashes.
3. The serialization overhead of the message should be kept to minimum, in which case Google Protobuf can be used. However, since interoperatiblity with existing solutions might be a concern, JSON is a valid trade-off.
4. Since this is an opt-in feature, it should be enabled via an external flag (eg. using an environment variable).
5. To further reduce the processing demand, the analytics data are NOT processed inside the hotspot client. Instead they are relayed to a third-party _Analytics Client_. This could be a simple proxy, or a more elaborate statistics aggregator. The implementation details are not important as part of this HIP.
6. Since the analytics meta-data are stripped-off of any risky information, an analytics datagram could be sent outside of the gateway even without encryption. This allows us to consider that the _Analytics Client_ is either a local OR a remote process.


## Side-Channel Protocol Description

The analytics side-channel emits 3 different kinds of messages. Each message is sent as a UDP datagram, encoded with the aggreed serialization format (JSON or Protobuf), and always have exactly one receipient.

The fields present in these messages are very similar to the fields defined in the [Semtech UDP Forwarder PROTOCOL.TXT](https://github.com/Lora-net/packet_forwarder/blob/master/PROTOCOL.TXT#L206), but they are adapted for faster consumption and for the security concerns explained above.

Note that the compact naming of the fields can be used when encoding the analytics data with JSON, in order to keep the overall message size to minimum, and therefore fit in a single datagram.
 
### 1. Uplink Messages

An uplink message is sent every time a packet is received from the packet forwarder. It contains the following fields:

<table>
  <thead>
    <tr>
      <th>#</th>
      <th>Compact Name</th>
      <th>Verbose Name</th>
      <th>Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td><code>tmms</code></td>
      <td><code>timeGps</code></td>
      <td><code>int64</code></td>
      <td>The UNIX timestamp (in milliseconds) when the message arrived in the concentrator.</td>
    </tr>
    <tr>
      <th>2</th>
      <td><code>gpsu</code></td>
      <td><code>timeGpsUs</code></td>
      <td><code>uint16</code></td>
      <td>The microseconds fraction of the unix timestamp above as a number between 0 - 999.</td>
    </tr>
    <tr>
      <th>3</th>
      <td><code>tmst</code></td>
      <td><code>timeFinished</code></td>
      <td><code>int64</code></td>
      <td>The UNIX timestamp (in milliseconds) of the local system when the message was received.</td>
    </tr>
    <tr>
      <th>4</th>
      <td><code>freq</code></td>
      <td><code>frequency</code></td>
      <td><code>float</code></td>
      <td>RX central frequency in MHz (Hz precision).</td>
    </tr>
    <tr>
      <th>5</th>
      <td><code>chan</code></td>
      <td><code>ifChannel</code></td>
      <td><code>uint8</code></td>
      <td>Concentrator "IF" channel used for RX.</td>
    </tr>
    <tr>
      <th>6</th>
      <td><code>rfch</code></td>
      <td><code>rfChain</code></td>
      <td><code>uint8</code></td>
      <td>Concentrator "RF chain" used for RX.</td>
    </tr>
    <tr>
      <th>7</th>
      <td><code>stat</code></td>
      <td><code>crcStatus</code></td>
      <td><code>enum</code></td>
      <td>CRC status: "OK", "Fail" or "NoCRC".</td>
    </tr>
    <tr>
      <th>8</th>
      <td><code>modu</code></td>
      <td><code>modulation</code></td>
      <td><code>enum</code></td>
      <td>Modulation identifier ("LORA" or "FSK").</td>
    </tr>
    <tr>
      <th>9</th>
      <td><code>datr</code></td>
      <td><code>fskDataRate</code></td>
      <td><code>uint32</code></td>
      <td>FSK datarate in bits per second. Used only when modulation is "FSK".</td>
    </tr>
    <tr>
      <th>10</th>
      <td><code>drls</code></td>
      <td><code>loraSf</code></td>
      <td><code>enum</code></td>
      <td>Spreading factor component of LoRa DataRate (eg. "SF12"). Used only when modulation is "LORA".</td>
    </tr>
    <tr>
      <th>11</th>
      <td><code>drlb</code></td>
      <td><code>loraBandwidth</code></td>
      <td><code>enum</code></td>
      <td>Bandwidth component of LoRa DataRate (eg. "BW500"). Used only when modulation is "LORA".</td>
    </tr>
    <tr>
      <th>12</th>
      <td><code>codr</code></td>
      <td><code>loraCodingRate</code></td>
      <td><code>enum</code></td>
      <td>LoRa ECC coding rate identifier.</td>
    </tr>
    <tr>
      <th>13</th>
      <td><code>rssi</code></td>
      <td><code>rssi</code></td>
      <td><code>float</code></td>
      <td>RSSI in dBm.</td>
    </tr>
    <tr>
      <th>14</th>
      <td><code>rssi</code></td>
      <td><code>rssi</code></td>
      <td><code>float</code></td>
      <td>Lora SNR ratio in dB (signed float, 0.1 dB precision).</td>
    </tr>
    <tr>
      <th>15</th>
      <td><code>size</code></td>
      <td><code>size</code></td>
      <td><code>int8</code></td>
      <td>RF packet payload size in bytes.</td>
    </tr>
    <tr>
      <th>16</th>
      <td><code>data</code></td>
      <td><code>data</code></td>
      <td><code>int8</code></td>
      <td>The 8 first bytes of the data payload (Holding the LoRaWAN MAC header).</td>
    </tr>
    <tr>
      <th>17</th>
      <td><code>csum</code></td>
      <td><code>dataChecksum</code></td>
      <td><code>uint32</code></td>
      <td>The ADLER32 checksum of the entire RF packet payload.</td>
    </tr>
  </tbody>
</table>

### 2. Downlink Messages

An downlink message is sent every time the system has just pushed a downlink message to the packet forwarder. It contains the following fields:

<table>
  <thead>
    <tr>
      <th>#</th>
      <th>Compact Name</th>
      <th>Verbose Name</th>
      <th>Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td><code>tmms</code></td>
      <td><code>timeGps</code></td>
      <td><code>int64</code></td>
      <td>The UNIX timestamp (in milliseconds) when the message should be sent (when set to '0' means "immediately").</td>
    </tr>
    <tr>
      <th>2</th>
      <td><code>tmst</code></td>
      <td><code>timeWall</code></td>
      <td><code>int64</code></td>
      <td>The UNIX timestamp (in milliseconds) of the local system when the message should be sent (when set to '0' means "immediately").</td>
    </tr>
    <tr>
      <th>3</th>
      <td><code>freq</code></td>
      <td><code>frequency</code></td>
      <td><code>float</code></td>
      <td>Tx central frequency in MHz (Hz precision).</td>
    </tr>
    <tr>
      <th>4</th>
      <td><code>rfch</code></td>
      <td><code>rfChain</code></td>
      <td><code>uint8</code></td>
      <td>Concentrator "RF chain" used for TX.</td>
    </tr>
    <tr>
      <th>5</th>
      <td><code>powe</code></td>
      <td><code>txPower</code></td>
      <td><code>float</code></td>
      <td>TX output power in dBm.</td>
    </tr>
    <tr>
      <th>6</th>
      <td><code>ncrc</code></td>
      <td><code>noCRC</code></td>
      <td><code>bool</code></td>
      <td>If true, disable the CRC of the physical layer.</td>
    </tr>
    <tr>
      <th>7</th>
      <td><code>modu</code></td>
      <td><code>modulation</code></td>
      <td><code>enum</code></td>
      <td>Modulation identifier ("LORA" or "FSK").</td>
    </tr>
    <tr>
      <th>8</th>
      <td><code>datr</code></td>
      <td><code>fskDataRate</code></td>
      <td><code>uint32</code></td>
      <td>FSK datarate in bits per second. Used only when modulation is "FSK".</td>
    </tr>
    <tr>
      <th>9</th>
      <td><code>fdev</code></td>
      <td><code>fskFreqDev</code></td>
      <td><code>uint16</code></td>
      <td>FSK frequency deviation in Hz.</td>
    </tr>
    <tr>
      <th>10</th>
      <td><code>drls</code></td>
      <td><code>loraSf</code></td>
      <td><code>enum</code></td>
      <td>Spreading factor component of LoRa DataRate (eg. "SF12"). Used only when modulation is "LORA".</td>
    </tr>
    <tr>
      <th>11</th>
      <td><code>drlb</code></td>
      <td><code>loraBandwidth</code></td>
      <td><code>enum</code></td>
      <td>Bandwidth component of LoRa DataRate (eg. "BW500"). Used only when modulation is "LORA".</td>
    </tr>
    <tr>
      <th>12</th>
      <td><code>codr</code></td>
      <td><code>loraCodingRate</code></td>
      <td><code>enum</code></td>
      <td>LoRa ECC coding rate identifier.</td>
    </tr>
    <tr>
      <th>13</th>
      <td><code>ipol</code></td>
      <td><code>inversePolarity</code></td>
      <td><code>bool</code></td>
      <td>Lora modulation polarization inversion.</td>
    </tr>
    <tr>
      <th>14</th>
      <td><code>prea</code></td>
      <td><code>preamble</code></td>
      <td><code>number</code></td>
      <td>RF preamble size.</td>
    </tr>
    <tr>
      <th>15</th>
      <td><code>size</code></td>
      <td><code>size</code></td>
      <td><code>int8</code></td>
      <td>RF packet payload size in bytes.</td>
    </tr>
    <tr>
      <th>16</th>
      <td><code>data</code></td>
      <td><code>data</code></td>
      <td><code>int8</code></td>
      <td>The 8 first bytes of the data payload (Holding the LoRaWAN MAC header).</td>
    </tr>
    <tr>
      <th>17</th>
      <td><code>csum</code></td>
      <td><code>dataChecksum</code></td>
      <td><code>uint32</code></td>
      <td>The ADLER32 checksum of the entire RF packet payload.</td>
    </tr>
  </tbody>
</table>

### 3. Statistics Messages

A statistics message is sent every time the respective `stat` message is received from the packet forwarder. This message is blindly forwarded without further processing and it has the following fields.

(Note that the statistic counters reset to zero every time a stat message is sent)

<table>
  <thead>
    <tr>
      <th>#</th>
      <th>Compact Name</th>
      <th>Verbose Name</th>
      <th>Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td><code>addr</code></td>
      <td><code>hotspotAddress</code></td>
      <td><code>byte[]</code></td>
      <td>The address of the hotspot.</td>
    </tr>
    <tr>
      <th>2</th>
      <td><code>time</code></td>
      <td><code>timeWall</code></td>
      <td><code>int64</code></td>
      <td>The UNIX timestamp (in milliseconds) of the local system.</td>
    </tr>
    <tr>
      <th>3</th>
      <td><code>lati</code></td>
      <td><code>gpsLatitude</code></td>
      <td><code>float</code></td>
      <td>GPS latitude of the gateway in degree (float, N is +).</td>
    </tr>
    <tr>
      <th>4</th>
      <td><code>long</code></td>
      <td><code>gpsLongitude</code></td>
      <td><code>float</code></td>
      <td>GPS latitude of the gateway in degree (float, E is +)</td>
    </tr>
    <tr>
      <th>5</th>
      <td><code>alti</code></td>
      <td><code>gpsAltitude</code></td>
      <td><code>float</code></td>
      <td>GPS altitude of the gateway in meters.</td>
    </tr>
    <tr>
      <th>6</th>
      <td><code>rxnb</code></td>
      <td><code>packetsRx</code></td>
      <td><code>uint32</code></td>
      <td>Number of radio packets received.</td>
    </tr>
    <tr>
      <th>7</th>
      <td><code>rxok</code></td>
      <td><code>packetsRxOk</code></td>
      <td><code>uint32</code></td>
      <td>Number of radio packets received with a valid PHY CRC.</td>
    </tr>
    <tr>
      <th>8</th>
      <td><code>rxfw</code></td>
      <td><code>packetsRxFw</code></td>
      <td><code>uint32</code></td>
      <td>Number of radio packets forwarded.</td>
    </tr>
    <tr>
      <th>9</th>
      <td><code>ackr</code></td>
      <td><code>ackRatio</code></td>
      <td><code>float</code></td>
      <td>Percentage of upstream datagrams that were acknowledged.</td>
    </tr>
    <tr>
      <th>10</th>
      <td><code>dwnb</code></td>
      <td><code>packetsTxReq</code></td>
      <td><code>float</code></td>
      <td>Number of downlink datagrams received.</td>
    </tr>
    <tr>
      <th>11</th>
      <td><code>txnb</code></td>
      <td><code>packetsTx</code></td>
      <td><code>float</code></td>
      <td>Number of packets emitted.</td>
    </tr>
  </tbody>
</table>


## Use Case Examples

### 1. Example 1

Alice has a DIY hostspot built using a packet forwarder and a light client. She is having reception issues with her devices and she wants to debug.

She has built her own log processing stack that runs on the cloud and she wants to feed the packet analytics down to it.

1. She then adjust the environment variables for `gateway-rs` and sets `HELIUM_ANALYTICS_CLIENT="my.cloud.service:12345`.
4. Once the client restarts, she starts seeing data.

### 2. Example 2

Bob, a professional LoRaWAN network operator, has deployed 1,000 Helium hotspots in an area and he wants to make sure his services are reliable. He is using production miners bought from one of the official suppliers.

He is already using a centralized analytics aggregation system on his deployment that already consumes data in Semtech UDP format.

We are assuming that once this HIP has landed, the gateway manufacturer will enable a new option on their UI called `Helium Analyltics Client`.

1. Bob simply goes to the UI configures the helium analytics client to point to the cloud infrastructure that he is already using.
2. He will already receive 80% of the interesting data from day 0 and he will only have to do minor adjustments to the protocol in order to accommodate the new fields.


# Drawbacks
[drawbacks]: #drawbacks

* We are kind of duplicating the stream of incoming data, but at the same time we cannot really forward them without processing, because we are risking exposing critical information.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

The most obvious and straightforward way of solving this issue is by introducing a man-in-the-middle UDP forwarder between the packet forwarder and the Hotspot Client (Light or Full) as seen below:

```
 +------------------+  Semtech UDP   +-----------------+  Semtech UDP   +----------------+
 | Packet Forwarder | -------------> | Analytics Proxy | -------------> | Hotspot Client | --> Helium Network
 +------------------+                +-----------------+                +----------------+
                                              |
                                              v
                                     RF Meta-Data Stream
```

This solution is trivial to integrate and requires no further modification to the Helium core components. **However** it requires that the Analytics Proxy is a trusted component and it does not disclose sensitive information to third parties.


# Unresolved Questions
[unresolved]: #unresolved-questions

* We need to decide weather we go with JSON (and therefore creating a backwards-compatible interface, similar to the semtech UDP packet itself), or we go with Protobuf, and therefore breaking any existing solution.
* Some discussion might be needed to further clean-up the fields in the analytics protocol. More specifically, if there is any smart alternative to encode the different fields for LORA or FSK encoding.

# 8. Deployment Impact
[deployment-impact]: #deployment-impact

We are not expecting any considerable impact on the deployment once this solution is applied. Both the processing power and the overall size footprint should be left relataively intact.

Plus, this is an opt-in feature so it wan't affect the user experience by default.

# Success Metrics
[success-metrics]: #success-metrics

Any stakeholder reporting a successful usage of this system to diagnose a problem they are having.
