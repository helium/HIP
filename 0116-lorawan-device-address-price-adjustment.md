# HIP 116: LoRaWAN Device Address Price Adjustment

- Author(s): [@ccall48](https://github.com/ccall48), [@nowiresfil](https://github.com/nowiresfil), Members of the IoT Working Group
- Start Date: 2024-03-25
- Category: Economic
- Original HIP PR: [#948](https://github.com/helium/HIP/pull/948)
- Tracking Issue: [#959](https://github.com/helium/HIP/issues/959)
- Vote Requirements: veIOT Holders

---

## Summary

Network operators leveraging Helium LoRaWAN must provision an Organizationally Unique Identifier (OUI) to bring devices onto the network. Along with the OUI, operators without their own NetID must also purchase a block of device addresses (DevAddr) to assign to devices. The cost of purchasing a block of 8 DevAddr is currently $800 USD. This proposal seeks to reduce the cost of purchasing a block of 8 DevAddr to $100 USD.

The [Helium OUI Documentation](https://docs.helium.com/iot/run-an-lns/buy-an-oui) fully details the current costs and processes.

In addition to the DevAddr cost reduction, this proposal seeks to ultimately have OUI and DevAddr issuance paid in the subnetwork-native IOT token as an on-chain transaction. This would replace the existing process of purchasing DevAddr with DC from burned HNT.

## Motivation

The current cost of purchasing a block of 8 DevAddr is $800 USD. This cost is viewed as a barrier to entry for network operators, especially those looking to self-host their LNS. By reducing the cost of purchasing a block of 8 DevAddr to $100 USD, the Helium Network becomes more accessible to a wider range of network operators.

Transitioning payment for OUIs and DevAddrs to the IOT token ensures that the revenue of these purchases is fully captured by the IOT subnetwork.

## Stakeholders

This HIP will affect existing and future OpenLNS operators or any individual operating an OUI on the Helium IOT network by lowering the cost of entry for deployment on the IOT network.

- Future operators will see a reduced cost of entry.
- Existing operators will see a reduced cost for additional DevAddr block purchases.

Moving puchases of OUIs and DevAddrs to the IOT token will affect HNT, IOT, and indirectly MOBILE token holders. The amount of HNT burned for these purchases will decrease, and the amount of IOT burned will increase.

## Detailed Explanation

On behalf of the Helium Network, the Helium Foundation retains a 'Type 0' NetID from the LoRa Alliance, the administrator of LoRaWAN address space. The Type 0 NetID offers the largest allocation of address space (DevAddrs) for the purpose of bringing end-user LoRaWAN devices on to the network.

The Helium Foundation retains several NetIDs. However, for the purposes of this proposal, only the Type 0 NetID is considered.

NetIDs are allocated based on membership tier with the LoRa Alliance. Types range from 0 to 7. Type 1, 2, 4, and 5 NetIDs are unused and reserved for future use. This chart shows the number of DevAddr that can be allocated for each NetID type:

| NetID Type | Number of DevAddr | Comparison                                                     |
| ---------- | ----------------- | -------------------------------------------------------------- |
| –          | 8                 | Size of a single Helium allocation as part of the Type 0 NetID |
| Type 7     | 128               |                                                                |
| Type 6     | 1,024             |                                                                |
| Type 3     | 131,072           |                                                                |
| Type 0     | 33,554,432        |                                                                |

A single DevAddr can handle multiple devices through multiplexing on the LNS. The number of devices that can be multiplexed on a single DevAddr is dependent on the device throughput and the network server implementation. Additional DevAddrs become important as network servers scale to handle more devices.

### Purchasing Process

Since the Solana migration, the process for purchasing OUIs and DevAddrs has been handled off-chain and faciliated by the Helium Foundation. Work is ongoing to move this process on-chain for parity with the legacy process from the Helium L1.

As such, a change from $800 per DevAddr block to $100 per DevAddr block would be simple according to the Helium Foundation. In the iterest of working toward an on-chain transaction mechanism, this HIP proposes to only implement IOT-based payments alongside the on-chain implementation.

### Implementation Timeline

Upon approval of this HIP, all subsequent purchases of a block of 8 DevAddr will cost $100 USD. The Helium Foundation will continue to facilitate the purchase of DevAddrs for the community.

In the future, OUI and DevAddr issuance will be moved to an on-chain mechanism where IOT will be used to secure the purchase of these assets. At that point, existing OUIs and DevAddrs will be migrated to this new representation without an additional IOT fee.

## Drawbacks

Decreasing the DevAddr cost would reduce the current possible maximum revenue for address space on the Helium Network.

Existing stakeholders may feel like they were overcharged if the price is reduced for more address space.

## Rationale and Alternatives

At time of writing, the breakdown of OUIs using Helium Foundation or external NetIDs is:

```
Old Helium 000024    : 55
New Helium 00003C    : 34
Using External NetID : 22
Total OUIs           : 111
```

Only a few existing 000024 & 00003C NetID users have purchased more than 1 x 8 DevAddr block. The following is a selection of larger Helium OUIs and their DevAddr allocations. For context on these OUIs and their protocol usage on the network, see the [Data Credit Dashboard on Dune](https://dune.com/helium-foundation/helium-data-credits).

- OUI 1 (Foundation Console) 1024 DevAddr (scaled to this at peak DC gaming)
- OUI 6 (Helium IoT EU) 152 DevAddr (added in 5 blocks)
- OUI 12 (1663 Console) 32 DevAddr
- OUI 1119 (TrackPac) 128 DevAddr (via their own NetID)

In blocks of 8, there are 4,194,304 total allocations available on the Type 0 NetID. At $800 per block, the total revenue from the sale of all address space is $3,355,443,200. At $100 per block, the total revenue from the sale of all address space would be $419,430,400.

As noted in Detailed Explanation, DevAddr can be acquired as part of a NetID and LoRa Alliance membership. The tradeoff, from a financial standpoint, is that LoRa Alliance membership comes at a yearly cost. Currently, access to a Type 0 NetID requires a $50,000 USD membership fee. Access to Type 7 NetIDs are available at a $500/yr licensing fee.

### Acceptable Alternatives Could Include

1. Lower the cost to purchase a 8 DevAddr block from $800 to $80, or another value.
1. Rent device space per year at a reduced cost of around $5 per address.

## Unresolved Questions

Would it be more reasonable to move to a lower cost but more address space allocation for a one time fee? Or possibly move to a much lower cost but yearly rent on the existing address space thus helping to be more accessible and help drive up IOT usage.

## Deployment Impact

By making the Helium Network more accessible and lowering the cost to encourage IoT network usage being the main factor. We expect the deployment impact to be positive with the lowering of the cost of offering hosting to existing stakeholders I would expect this to be filtered all the way down to cost of paid hosting services, as well as lower the barrier for small scale deployments to enter and use the network being more attractive.

## Success Metrics

The goal of this proposal is to make operating an LNS more accessible by reducing the cost. The downstream effects of more operational LNSs ideally presents as an uptick in IoT devices transmitting data across the network.

## Documentation Updates

A list of known pages in the documentation that will need updating should this HIP be successful.

- Helium OUI Documentation / https://docs.helium.com/iot/run-an-lns/buy-an-oui
- Helium Data Credit Documentation / https://docs.helium.com/tokens/data-credit
