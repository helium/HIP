# IoT Seat Fees for Sensors

- Author(s): @BFGNeil
- Start Date: 2025-06-16
- Category: economic
- Original HIP PR:
- Tracking Issue:
- Vote Requirements: veHNT Holders

## Summary

This HIP proposes introducing a \$1/year "seat fee" for each sensor transmitting on the Helium IoT network. This fee would be deducted from the LNS’s Data Credit (DC) balance on the first uplink of each day, averaging approximately \$0.00274 per day. The goal is to create sustainable and predictable revenue for IoT Hotspot operators without increasing per-packet costs or introducing additional friction for end users.

## Motivation

- The network currently earns too little to sustain Hotspot operations: with over 320,000 active sensors, it generates only ~\$100/day (~\$36,500/year).
- There is a misalignment between infrastructure costs and minimal usage fees.
- This proposal introduces fair compensation for Hotspot operators, encourages ongoing participation, and supports the network’s long-term viability.
- It maintains affordability for sensor owners while ensuring baseline revenue per sensor.

## Stakeholders

- **Hotspot Operators**: Benefit from more sustainable and predictable rewards.
- **Sensor Owners**: Incur minimal added cost while continuing to enjoy low-cost connectivity.
- **Network Developers**: Responsible for implementing logic for daily fee collection.
- **Token Holders**: Benefit from higher DC burn rates and improved token economics.

## Detailed Explanation

### Mechanism

- Sensors are charged a daily seat fee of \~\$0.00274 (equivalent to \$1/year or 274 DC/day).
- The fee is only charged on the first uplink of each day.
- It is treated as a prepayment of DCs, allowing up to 274 uplinks that day before incurring further costs.
- Sensors that do not transmit on a given day are not charged.

### Examples

| **Sensor Frequency**        | **Daily Cost (Current Model)** | **Yearly Cost (Current Model)** | **Daily Cost (With Seat Fee)** | **Yearly Cost (With Seat Fee)** | **Daily \$ Increase** | **Yearly \$ Increase** |
| --------------------------- | ------------------------------ | ------------------------------- | ------------------------------ | ------------------------------- | --------------------- | ---------------------- |
| Once per day                | \$0.00001 (1 DC)               | \$0.00365                       | \$0.00274 (274 DC)             | \$1.00                          | +\$0.00273            | +\$0.99635             |
| Twice per day               | \$0.00002 (2 DC)               | \$0.00730                       | \$0.00274 (274 DC)             | \$1.00                          | +\$0.00272            | +\$0.99270             |
| Four times per day          | \$0.00004 (4 DC)               | \$0.01460                       | \$0.00274 (274 DC)             | \$1.00                          | +\$0.00270            | +\$0.98540             |
| Every hour (24/day)         | \$0.00024 (24 DC)              | \$0.08760                       | \$0.00274 (274 DC)             | \$1.00                          | +\$0.00250            | +\$0.91240             |
| Every 2 minutes (\~720/day) | \$0.00720 (720 DC)             | \$2.62800                       | \$0.00720 (720 DC)             | \$2.62800                       | \$0.00                | \$0.00                 |
| Every 1 minute (1440/day)   | \$0.01440 (1440 DC)            | \$5.25600                       | \$0.01440 (1440 DC)            | \$5.25600                       | \$0.00                | \$0.00                 |



This shows that:

- **Low-frequency sensors** pay slightly more annually, but the amount remains negligible.
- **Mid-to-high-frequency sensors** benefit from the threshold.
- **Very high-frequency sensors** experience no cost increase.

## Drawbacks

- Slightly increases cost to end users (\~\$1/year).
- Requires development effort to implement in the Oracle.
- Potential for gaming via key sharing or bypassing identity.
- Will require LNS providers to explain the pricing structure to users and detail the cost in any tracking systems.

## Rationale and Alternatives

### Alternatives Considered

- **Increasing per-packet fees**: Disincentivises high-frequency use cases and still fails to generate sufficient revenue.

### Why This Design Was Chosen

- Scales equitably with actual usage without penalising high-volume traffic.
- Maintains backwards compatibility and requires no firmware changes.
- Creates a predictable and scalable revenue stream for operator incentives.

### Consequences of Inaction

- Hotspot operators remain undercompensated.
- Potential decline in operator retention and network coverage.
- Poses a risk to the economic sustainability of the Helium IoT network.

## Unresolved Questions

- Should the fee amount be dynamically adjustable based on volume or demand?
- What is the appropriate grace policy when a sensor has insufficient DC balance?
- How should roaming users be charged, especially when keys aren’t shared across networks?
- How should unspent seat fee DCs be rewarded to Hotspot operators—proportionally b[y packets serve](http://docs.helium.com)d, time connected, or via PoC mechanisms?

## Deployment Impact

- **Users**: Must ensure they maintain sufficient DC balance for the daily fee.
- **Documentation**: Updates needed on [docs.helium.com](http://docs.helium.com) under sensor billing.
- **Compatibility**: No changes required to firmware.
- **Reversibility**: This HIP can be undone by disabling the fee logic.

## Success Metrics

- Increase in daily DC burn from \~\$100/day to close to \~\$1,000/day.
- Improvement in Hotspot operator retention and participation rates.
- Positive reception from stakeholders (sensor owners, operators, token holders).
- Transparent tracking of seat-fee burn and DC usage across the network.

