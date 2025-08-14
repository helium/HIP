# HIP 146: IoT Seat Fees for Sensors

- Author: [@BFGNeil](https://github.com/BFGNeil)
- Start Date: 2025-06-23
- Category: Economic
- Original HIP PR: [#1173](https://github.com/helium/HIP/pull/1173)
- Tracking Issue: [#1175](https://github.com/helium/HIP/issues/1175)
- Vote Requirements: veHNT Holders

---

## Summary

This HIP proposes introducing a $1/year "seat fee" for each sensor transmitting on the Helium IoT network. This fee would be deducted from the LoRaWAN Network Server’s Data Credit (DC) balance on the first uplink of each day, averaging approximately $0.00274 per day. The goal is to create sustainable and predictable revenue for IoT Hotspot operators without increasing per-packet costs or introducing additional friction for end users.

## Motivation

- The network currently earns too little to sustain Hotspot operations: with over 320,000 active sensors, it generates only around $108/day ($40,000/year).
- There is a misalignment between infrastructure costs and minimal usage fees.
- This proposal introduces fair compensation for Hotspot operators, encourages ongoing participation, and supports the network’s long-term viability.
- It maintains affordability for sensor owners while ensuring baseline revenue per sensor.
- Increase the rewards emitted to Hotspots for Data Transfer

## Stakeholders

- **Hotspot Operators**: Benefit from more sustainable and predictable rewards.
- **Sensor Owners**: Incur minimal added cost while continuing to enjoy low-cost connectivity.
- **Network Developers**: Responsible for implementing logic for daily fee collection.
- **Token Holders**: Benefit from higher DC burn rates and improved token economics.

## Detailed Explanation

### Mechanism

- Data Credit (DC) cost remains at 100,000 per 1 USD
- The network would charge a daily seat fee (in DC) based on individual SKFs (Session Key Filters) observed by a Helium Packet Router. The seat fee is $1 per year, the daily cost would be approximately $0.00273973 or 274 DC.
- Additionally, this fee would include a daily data allowance of 274 DC per device, with any usage beyond this limit charged at the standard rate.
- To ensure that devices sending data multiple times per day are not charged multiple seat fees, SKFs will need to be updated. A unique ID (provided by the LNS operator) will be added to each SKF, allowing devices to be recognized by their ID. This approach ensures that devices joining and powering on multiple times in a day are only charged once per day.


### Examples using 1 DC per uplink

| **Sensor Frequency**      | **Daily Cost (Current Model)** | **Yearly Cost (Current Model)** | **Daily Cost (With Seat Fee)** | **Yearly Cost (With Seat Fee)** | **Daily \$ Increase** | **Yearly \$ Increase** |
|---------------------------|--------------------------------|---------------------------------|--------------------------------|---------------------------------|-----------------------|------------------------|
| Once per day              | $0.00001 (1 DC)                | $0.00365                        | $0.00274 (274 DC)              | $1.0000                         | +$0.00273             | +$0.99635              |
| Twice per day             | $0.00002 (2 DC)                | $0.00730                        | $0.00274 (274 DC)              | $1.0000                         | +$0.00272             | +$0.99270              |
| Four times per day        | $0.00004 (4 DC)                | $0.01460                        | $0.00274 (274 DC)              | $1.0000                         | +$0.00270             | +$0.98540              |
| Every hour (24/day)       | $0.00024 (24 DC)               | $0.08760                        | $0.00274 (274 DC)              | $1.0000                         | +$0.00250             | +$0.91240              |
| Every 30 minutes (48/day) | $0.00048 (48 DC)               | $0.17520                        | $0.00274 (274 DC)              | $1.0000                         | +$0.00226             | +$0.82490              |
| Every 15 minutes (96/day) | $0.00096 (96 DC)               | $0.35040                        | $0.00274 (274 DC)              | $1.0000                         | +$0.00178             | +$0.64970              |
| Every 5 minutes (288/day) | $0.00288 (288 DC)              | $1.05120                        | $0.00288 (288 DC)              | $1.0512                         | $0.00                 | $0.00                  |
| Every 2 minutes (720/day) | $0.00720 (720 DC)              | $2.62800                        | $0.00720 (720 DC)              | $2.6280                         | $0.00                 | $0.00                  |
| Every 1 minute (1440/day) | $0.01440 (1440 DC)             | $5.25600                        | $0.01440 (1440 DC)             | $5.2560                         | $0.00                 | $0.00                  |

This shows that:

- **Low-frequency sensors** pay slightly more annually, but the amount remains negligible.
- **Mid-to-high-frequency sensors** benefit from the threshold.
- **Very high-frequency sensors** experience no cost increase.

## How roaming users are charged, especially when keys aren’t shared across networks.

Roaming users will be charged a 12× multiplier on standard Data Credit (DC) costs.  
This surcharge reflects the added complexity and reduced visibility in routing packets from sensors not provisioned on the local network, especially when keys are not shared across network operators. It also discourages "roaming-only" deployments that attempt to avoid contributing to infrastructure.

## How unspent seat fee DCs are rewarded to Hotspot operators.

Unspent seat fee DCs will be shared pro rata with the specific Hotspots that served that sensor’s data on a given day.  
This reward will be allocated based on actual packet delivery from the sensor, ensuring Hotspots are fairly compensated for supporting active devices. This approach aligns with incentives and ensures the seat fee does not go to waste.

## Drawbacks

- Slightly increases cost to end users (~$1/year).
- Requires development effort to implement in the Oracle.
- Potential for gaming via key sharing or bypassing identity.
- Will require LoRaWAN Network Server providers to explain the pricing structure to users and detail the cost in any tracking systems.

## Rationale and Alternatives

### Alternatives Considered

- **Increasing per-packet fees**: Disincentivises high-frequency use cases and still fails to generate sufficient revenue.

### Why This Design Was Chosen

- Scales equitably with actual usage without penalising high-volume traffic.
- Maintains backwards compatibility and requires no firmware changes.
- Creates a predictable and scalable revenue stream for operator incentives.

### Consequences of Inaction

- Hotspot operators compensation reduces over time.
- Potential decline in operator retention and network coverage.
- Poses a risk to the economic sustainability of the Helium IoT network.

## Deployment Impact

- **Users**: Must ensure they maintain sufficient DC balance for the daily fee.
- **LNS Operators**: Updates needed to Helium-to-Chirpstack bridges (Disk91/Bones/Custom) to support the new SKF changes.
- **Documentation**: Updates needed on [docs.helium.com](http://docs.helium.com) under sensor billing.
- **Compatibility**: No changes required to firmware.
- **Reversibility**: This HIP can be undone by disabling the fee logic.

## Success Metrics

- Meaningful contribution of Data Transfer rewards towards the revenue of active Hotspots. Meaningful contribution and active Hotspots to be defined and monitored by the IoT Working Group.
- Improvement in Hotspot operator retention and participation rates.
- Positive reception from stakeholders (sensor owners, operators, token holders).
- Transparent tracking of seat-fee burn and DC usage across the network.

