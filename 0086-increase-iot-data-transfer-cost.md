# HIP 86: Increase IOT Data Transfer Cost

- Author(s): [@KeithRettig](https://github.com/KeithRettig)
- Start Date: 2023-05-28
- Category: Economic
- Original HIP PR: [#698](https://github.com/helium/HIP/pull/698)
- Tracking Issue: [#703](https://github.com/helium/HIP/issues/703)
- Voting Requirements: veIOT Holders

## Summary

This HIP proposes to change the per packet cost of transferring messages on the Helium IOT Network from 1 data credit (DC) per 24-byte packet to 2 data credits (DC) per 24-byte packet to better align the price with its value to our customers.

## Motivation

The primary motivation is to align the cost of packet transfer closer to the true value of packet transfer within the IOT subDAO. While it is believed by the author that the true value of packet transfer is closer to 100 DC, it would be economically unfeasible to implement a 100-fold increase in the price in one action.

## Stakeholders

Any and all customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network.

## Detailed Explanation

The cost of packet transfer on the Helium IOT Network, is far too inexpensive. Our customers have publicly commented that the cost is too low. Due to the low cost of data transfer, a Hotspot must transfer a huge number of packets to earn meaningful revenue. The cost of packet transfer is so cheap, that this proposed change of doubling the cost is unlikely to change any behaviors of the users of the Helium IOT Network.

Currently to transfer a 24 byte packet on the Helium IOT Network, a customer must spend 1 DC. This HIP proposes to make that cost be 2 DC per 24 byte packet. This HIP does not change any mechanism on how Hotspots are paid for data transfer; if the HIP passes, a Hotspot will now earn 2 DC for each message transferred.

## Implementation

We leave the implementation of the smart contract components, verifiability, and compliance up to the Helium Core Developers to determine. It is understood that the cost function of packet transfer is implemented as a variable and thus it is believed this change should be very easy to implement in the IOT Packet Verifier. It would be ideal if the proposed increase could be appropriately scaled based on region, and thus allow for regional governance to define said increase. For instance, the community may decide to raise the price of data transfer in regions where backhaul costs are more expensive. Or they may allow a country to delay the price increase to help adoption of the service. However, since there are currently no known mechanisms for such regional policy actions, implementing such scaling will need to be left as a future feature. Therefore, regional pricing is out of scope of this HIP but is mentioned so that the developers will consider the possibilities as they code for this HIP (if there is any coding necessary).

## Drawbacks

A potential drawback is that customers will view the doubling of cost as too aggressive and not transfer as many packets in the future. It is believed that at this time, and with the current price range, the usage of packet transfer is one of relatively inelastic demand. No change in purchasing nor usage behavior is expected.
Since Data Credits are distributed to wallets first, there will be a reduction in available tokens for Proof-of-Coverage rewards. With only a doubling of the cost at this point, it is unlikely to be a significant reduction. However, some thought should be given as to this when future increases in the cost are considered.

## Unresolved Questions

There are no unresolved questions other than how our customers will respond to the price change.

## Deployment Impact

There are no known dependencies by the author. As soon as the variable has been changed, customers would pay 2 DC to transfer data rather than 1 DC.

## Success Metrics

There are two success metrics. First that the price is changed and, second, that the demand remains inelastic. Only the first is required for the HIP to be considered successful.
