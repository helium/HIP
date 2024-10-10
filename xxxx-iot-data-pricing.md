# HIP XXXX: IOT Data Pricing

- Author(s): [@rawrmaan](https://github.com/rawrmaan), [@jthiller](https://github.com/jthiller)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR:
- Tracking Issue:
- Voting Requirements: veIOT holders

## Summary

This HIP proposes to increase the base cost of transferring messages on the Helium IOT Network. This would be done via an increase of the floor "multibuy"[<sup>[Definition 1]</sup>](#1) value for each message as well as a simplification of payload pricing.

This HIP outlines four main actions:

- Increase the multibuy value to 10 for all devices, ensuring up to 10 sets of payload metadata are returned for each message.
- Charge a minimum of 10 Data Credits (DC) for each message, regardless of the number of participating Hotspots.
- Split the data transfer reward for these messages across all participating Hotspots.
- Eliminate the 24 byte pricing tiers for payloads sent through the network. All messages may be sent for 10 DC, regardless of size.

## Motivation

Separate from the actions outlined in the summary, there are four objectives this HIP seeks to achieve.

The primary motivation of this proposal is to realize and capture the true value of data transfer delivered by the IOT subnetwork, the largest public LoRaWAN network in the world. Despite seeing widespread adoption and consistent growth, the IOT Network's revenue from data transfer has been slow to meet expectations. This is largely due to the very low cost of data transfer on the network; put simply, $ 1{,}000\ \text{messages} \ / \ \$1.00\ \text{USD}$ (1,000 Data Credits) at a base message size.

Next, when sending LoRaWAN downlinks[<sup>[Definition 2]</sup>](#2), prior receipt of verbose payload metadata is critical for LoRaWAN Network Servers (LNSs) to select the best Hotspot to broadcast the message for delivery to the device in the field. This metadata are retrieved when devices send uplinks[<sup>[Definition 3]</sup>](#3) and are reported by Hotspots. The number of Hotspots included in these reports is gated by the multibuy value.  
The current design of the network leaves the selection of the multibuy value up to the network operator, which has proven to be a generally confusing attribute for existing LPWAN operators who expect a full set of this metadata. Enforcing a base multibuy value ensures all operators receive a minimum set of available metadata to ensure successful downlink delivery.

Furthermore, in conjunction with the raise in base cost for messages, it becomes unnecessary to meter payloads based on 24 byte increments. LoRaWAN devices generally benefit from the smallest payload size possible in the interest of preserving battery life. The LoRaWAN specification generally limits payloads to 255 bytes. Due to spreading factors[<sup>[Definition 4]</sup>](#4), these limits do not directly correlate to time on air.

Lastly, by splitting the 10 DC reward among participating Hotspots, a greater incentive is offered to rural Hotspots which may be rewarded in greater proportion than more densely deployed, generally urban Hotspots.

## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network. This HIP notes special consideration to voters that the most heavily impacted party, sensor operators, are not strongly represented from a token voting standpoint. Voters are encouraged to consider all stakeholder perspectives.

### Hivemapper

Hivemapper leverages the Helium Network as a location verification check in its HDC and HDC-S high-precision dashcams for mapping.

> Helium has a pricing problem. @Hivemapper uses the Helium network for location verification, and its pricing model undervalues the service it provides.
> \- [@aseidman](#a)

### WeatherXM

WeatherXM operates a suite of weather sensing devices, including a product line which leverages Helium LoRaWAN exclusively for data transfer.

> Thank you for reaching out to us regarding the proposed increase in DC pricing. As one of the largest users of the Helium IoT network, responsible for ~17% of the network's earnings, we take this matter very seriously.  
> To be clear, we are not in favour of any price increase, as even a modest change could impact our network's operations. However, we understand that some adjustments may be necessary. While a 30-50% increase would be challenging, it’s something we could potentially adapt to. A 10x increase, on the other hand, would be entirely unsustainable for us and would greatly undermine our ability to continue leveraging the network.  
> We hope that any decision or proposal finalised takes into account the realities of users like us who significantly contribute to the network's success.

** Add additional stakeholder comments **

## Detailed Explanation

The cost of packet transfer on the Helium IOT Network is far too inexpensive. Some customers have even publicly commented that the cost is too low.[<sup>[A]</sup>](#a) Due to the low cost of data transfer, a Hotspot must transfer a huge number of messages to earn meaningful revenue. If an individual Hotspot can't earn sustainable revenue, it's probable that the network as a whole cannot sustain itself.

Currently, transferring a 24 byte packet on the Helium IOT Network through a single Hotspot costs a customer 1 DC. This HIP proposes to change that cost to 10 DC and to remove the 24 byte constraint associated with message size billing.

-> expand on importance of metadata

24 byte increments act as a proxy for airtime controls, but do not effectively ensure any particular usage patterns. As a crude example, a 24 byte payload sent using SF12 takes 452ms. A 242 byte payload at SF7 takes 399ms. Despite the large gap in payload sizes, both messages use approximately the same airtime.

-> expand on opportunity to grow rural coverage

In the interest of supporting a transitional period for network users, a one-time issuance of DC will be made into the escrow accounts of the Organizationally Unique Identifiers[<sup>[Definition 5]</sup>](#5) (OUIs) on the network. This issuance will be 1 year of additional DC based on a snapshot of the previous usage over 90 days from the close of a vote, minus any anomalous usage. Specifically, it will cover 9 times the usage at the current rate for two years, calculated using the average usage of the preceding three months. These funds are to be paid from the IOT Operations Fund as a swap to HNT.

### Example Impacts

Excluding the one-time emission of Data Credits to operator's escrow accounts, let's evaluate the cost impacts to network operators given a number of device deployment scenarios.

| Scenario                                                                                   | Before Cost | After Cost |
| ------------------------------------------------------------------------------------------ | ----------- | ---------- |
| Operator runs 5000 devices sending a 40 byte payload every 3 minutes with no multibuy.     | $XX/year    | $XX/year   |
| Operator runs 10 devices sending a 24 byte payload every 30 minutes with a multibuy of 4.  | $XX/year    | $XX/year   |
| Operator runs 1 device sending a 24 byte payload every minute with a multibuy value of 50. | $XX/year    | $XX/year   |

## Implementation

- base cost
- dc split
- DC airdrop
  - computation of rate
- eliminate 24b tiers

The multibuy value will be set to 10, ensuring up to 10 Hotspots are included for all messages's metadata. Network operators reserve the right to set this value higher, but only the floor of 10 are required to be paid for each message. For example, if a user sets their multibuy value to 20 and their device is reported through 15 Hotspots, 15 DC are used.

In scenarios where fewer than 10 copies of a message are delivered to the LNS, the cost of the message will still be calculated as if 10 copies were delivered, and the data transfer reward will be divided among the reporting Hotspots.

## Alternatives

- Per-device pricing is a common approach in the LoRaWAN industry, but it's not feasible for Helium due to its multi-LNS architecture. If Helium controlled all devices through a single network server and had no roaming users, this approach would be cleanly feasible.

- Regional pricing could be explored as a future option, as different regions may have varying price sensitivities.

### Selection of Multiplier

The HIP explores a 10x multiplier. However, the range of suggested increases vary from 2x to 1000x. These proposed values can be viewed as an optimization problem, wherein the vectors include attrition across active devices, continued network growth, protocol revenue, and distribution across the global fleet of Hotspots.

## Drawbacks

- A significant price increase may deter customers from using the network, potentially reducing message volume.

- Increased DC usage could lead to a reduction in available tokens for Proof of Coverage rewards.

## Unresolved Questions

The main unresolved question is how Helium IOT customers will respond to the price change. This HIP is being submitted in hopes of gaining that feedback.

## Deployment Impact

- Public LNS operators will need to understand this change and possibly communicate it to their customers, depending on how their customer relationships work

- When the variable is changed, data consumers will immediately begin paying the new rate. Hotspots will immediately begin receiving rewards in accordance with the 10 DC message base and multibuy sharing.

- The two-year supplemental issuance of DC will be deployed on the day of activation, ensuring existing device operations are uninterrupted.

## Success Metrics

There are two success metrics. First that the price is changed and, second, that the demand remains inelastic (users don't leave the network). Only the first is required for the HIP to be considered successful.

## Definitions

<a id="1">**Multibuy**</a>: Refers to the number of Hotspots and their corresponding metadata that are reported to the LNS for a specific device payload. This value is also known as "max copies" or "microdiversity," indicating the maximum number of Hotspot records that can be included for each transmission.

<a id="2">**Uplink**</a>: Payloads sent from deployed devices through Hotspots to the LNS.

<a id="3">**Downlink**</a>: Payloads sent from LNSs through Hotspots to deployed devices.

<a id="4">**Spreading Factor**</a>: Ranging from SF7 (fastest) to SF12 (slowest), spreading factor controls data transmission speed. Devices adjust spreading factors to balance time on air, battery consumption, and distance the message may be received.

<a id="5">**Organizationally Unique Identifier**</a>: Registered by network operators, the OUI designates the operator's network server's configurations and DC balances. An OUI may be held by an individual network operator or roaming user. Each OUI has one DC escrow account.

## References

<a id="a">Ariel Seidman, Hivemapper</a> X.com. (n.d.). X (Formerly Twitter). https://x.com/aseidman/status/1614445419693740033

## Figures

```mermaid
xychart-beta
    title "Payload counts per payload size"
    y-axis "Payload Size"
    x-axis [12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,152,153,157,158,160,161,163,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,197,198,199,200,202,203,204,205,206,207,209,211,213,216,218,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255]
    y-axis "Payload Count"
    bar [29203,289258,345051,383781,231811,539311,823438,617232,775772,1591992,1131444,2270260,6372140,1331779,857912,760598,462103,2448916,1634261,885981,472049,243092,371983,490358,359471,114542,132260,1254105,5731535,234444,258907,63715,2395237,569519,179801,192758,104405,250171,39313,125010,24758,88421,119739,714938,59174,41131,63967,18565,104381,64924,234630,113106,230763,71529,1011715,9704,1777,4828,30431,733,1952,1014,634,1446,5305,5331,13490,3950,3068,1442,751,1184,6764,2393,17889,1101,1835,70,192,493,845,78,60,39,858,3008,14,92,6,23,7,78,7,41701,3790,16675,3070,40933,177,104,13,11,15,10,1130,78,201,100,307,27,38,27,32,315,208,2965,103577,30,356,253,366,73,452,153,10,70,23,2401,1,732,141,2206,103,137,53,6,36,40,1,1,1,1,9,1,1,1,5747,31,3,240,379,1718,909,853,1511,1876,1231,137,144,33,164,155,5,7,1362,102,3079,829,2741,497,327,507,364,90,152,3,506,821,1,27,1,61,76,103,47,16,45,7,6,8,5,54,167,4,188,19,219,506,1297,1391,1287,977,846,974,1377,1924,1696,1298,493,106797,1427,2050,1935,1056,465,308,116,71,687,53,101,2,2,1142,9,1,5,99]
```
