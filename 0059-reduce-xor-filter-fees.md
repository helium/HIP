# HIP-59 Reduce XOR filter fees

- Author(s): [@macpie](https://github.com/macpie), [@jdgemm](https://github.com/jdgemm)
- Start Date: 2022-04-19
- Category: Technical
- Original HIP PR: [https://github.com/helium/blockchain-core/pull/1303](https://github.com/helium/blockchain-core/pull/1303)
- Tracking Issue: [https://github.com/helium/HIP/issues/391](https://github.com/helium/HIP/issues/391)
- Status: In Discussion

# Summary

Helium community members who host a Router instance use on-chain XOR filters to  process traffic from known devices in order to significantly improve performance. This is an integrated component of a Router instance, and allows Routers and Packet Purchasers on the network to avoid spending resources on join packets from unknown devices.

This HIP proposes a change for how fees are calculated when doing a XOR filter update with the goal of reducing these fees and enabling more updates to XOR filters.

## Motivation

The Helium Network benefits if non-incumbent organizations (like the Helium Foundation and Nova Labs, Inc.) host Console and Router instances that buy packets on the Helium Network. This will encourage more usage on the network driving the demand side of the Helium Flywheel. Open source users can choose to host their own instances to provide a commercial offering for others to leverage or for their own devices.

Console and Router hosting requires costs for both initial setup (OUI, Devaddrs), and ongoing including hosting services and operational costs related to the blockchain.

XOR filter fees are operational costs related to maintaining OUIs on the blockchain. With the current implementation these fees can become a big part of the cost of running a Router instance, the core developers have identified a way to reduce those costs which benefit anyone who chooses to host an Router instance.

## Stakeholders

All Console/Router open-source operators are directly affected by this proposal.

## Detailed Explanation

On the Helium blockchain fees are calculated based on the `byte_size` of the transaction. See [here](https://github.com/helium/blockchain-core/blob/master/include/blockchain_txn_fees.hrl) for more info.

As more devices get added to the filter, it grows. Meaning that any update is calculated based on the full size of the filter. This can increase the cost of an XOR filter update to tens of thousands of Data Credits (DC). This is obviously not sustainable as the network grows.

The proposal is to not account for the full size of the XOR filter every time but only the difference compared to the previous update. For example: if the previous XOR had a size of 100 bytes and the update is 110 bytes then fees would be calculated on the difference: (`110 - 100 = 10`) 10 bytes.

This approach increases the commercial viability for community members to host a Console/Router instance, only the difference of the XOR filter will be calculated vs paying for the entire amount each time.
It’s useful to provide some context on how device data is routed on the Helium network to understand why this is a useful addition to the network.

Today, a device attempts a new join via XOR filter  [XOR Filter](https://github.com/mpope9/exor_filter) associated with the paired OUI. The OUI includes a set of Device Addresses (DevAddrs) that will be assigned to newly joined devices (note these DevAddrs do not need to be unique for each device, the combination of application key is used to avoid conflicts).

An `OUI` can have up to 5 XOR filters, controlled by a chain variable: `max_xor_filter_num`.

New devices are assigned to a DevAddr which are handed out based on the OUI. The `app_eui`, and `dev_eui` are hashed together and added to the XOR filter which is then written to the blockchain (added to a block and propagated to miners).

XOR Filters are manipulated via a transaction called `blockchain_txn_routing_v1`.

The Hotspot can then look up in the filters and find out the appropriate Router to send the join packet to. This process could take up to 20 mins.

Hotspots use device `app_eui`, `dev_eui` to query the blockchain via XOR filter to identify which OUI to send join packets.

Router which belongs to the OUI receives the  join request, sends down a join accept, and assigns the NwkAddr.

For future uplinks, gateways use a device’s devaddr to identify which router/oui to send to which is significantly quicker.

## Drawbacks

No significant drawbacks can be seen.

## Deployment Impact

All Console/Router open-source operators will see a reduction in size of XOR filters and a decrease in associated blockchain fees.

Normal Console end users should not expect to see a measurable impact.

## Success Metrics

The success of this design can be verified by community members that host Router instances. Community members can verify that the ongoing amount of Data Credits needed to operate Router decreases and is only accounting for the difference between XOR filter updates and not for the full size.
