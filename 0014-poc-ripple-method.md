# HIP14: Proof of Coverage - Ripple Method

- Authors: @anthonyra
- Start Date: 10/01/2020
- Category: Technical
- Initial HIP PR: [#47](https://github.com/helium/HIP/pull/47)
- Tracking Issue: [#50](https://github.com/helium/HIP/issues/50)

# Summary

<!-- TODO: Link sections that resolve issues here !-->

The current Proof-of-Coverage (PoC) - Onion Packet method has the following issues that this
proposal is meant to resolve:

1. The data used to validate coverage can be easily modified or spoofed
   1. RF - RSSI, SNR
   2. GPS
   3. Assert Location
2. Current rewards associated to PoC is heavily favored in areas with high Hotspot density
   (over-coverage)
   1. Modesto, CA
   2. New York City, NY
   3. Port Huron, MI
3. The selection process even though based on randomness can be selective due to the nature of the
   witness list. Since a group of Hotspots can be engineered or placed to only witness themselves
   this approach allows for isolated groups. This makes it easy to build Virtual Machine (VM) or RF
   based Hotspot farms. [This issue will be resolved with how the Ripple Effect
   functions][ripplebenefits]

# Motivation

With a new day comes a new way "bad actors" attempt to profit from the current system. To fully
understand this proposal you first need to grasp the basics of the current PoC system.

#### Basics of Current PoC

1. A challenger selects a target Hotspot.
2. Once selected the challenger creates a PoC proof
   1. Starting with the target Hotspot the challenger selects the next Hotspot in the PoC path based
      on witness list and [hex](https://h3geo.org/docs) location (how the 300m limit is enforced).
   2. The challenger repeats the above step (2.i) but starts with the Hotspot selected to be the
      next hop.
   3. The PoC path is created containing 2 - 5 Hotspots (hops)
3. The initial challengee receives the PoC proof via the p2p network and decrypts the packet
   (envelope) it signs it and then returns it to the challenger
4. The Hotspot then broadcasts the new envelope that is now one layer less than the previous one via
   Radio Frequency (LoRa / RF).
5. This signal is then picked up by neighboring Hotspots. The receiving Hotspots have two options.
   1. The Hotspot is the next hop in the PoC proof so it's able to decrypt another layer of the
      envelope and perform steps (4-5.i).
   2. The Hotspot isn't the next hop so it signs the envelope and returns to sender (challenger) via
      p2p.
6. Steps 4 - 5 continue until the end of the PoC proof is reached resulting in a PoC receipt. This
   PoC receipt is then sent from the challenger to the Consensus Group to be validated.

For more details go to:
[PoC Documentation](https://developer.helium.com/blockchain/proof-of-coverage)

# Stakeholders

- If this HIP is implemented it will effect everyone who owns a Hotspot due to reward changes based
  on the new PoC method.
- Feedback will be received via the Github `Issues` discussion and on
  [Discord #hips](https://discord.gg/helium)

# Detailed Explanation - Ripple PoC Method

#### Definitions

[definitions]: #definitions

- `Island` - A hex-cluster that is created by the island construction method below which visualizes
  the coverage of an area.
- `Island Hex` - The hex used to create the island ( h3 resolution 8 hex: ~0.45km2 [110 acres] )
- `Hotspot Hex` - The hex associate with Hotspot location currently in the blockchain
- `Island Rating` - The overall rating of an island based on total # of chains received and longest
  chain in meters
- `Challenger` - The Hotspot that selects the `Island` to be targeted and the `Pebble` Hotspots for
  the challenge
- `Pebble (challengee)` - Selected by the challenger to start the _ripple_. There are two types of
  pebbles, the `initial` and `opposite`. The initial pebble receives the packet from challenger and
  the opposite pebble is the _target_ for that packet. Each must be in a different `Island Hex`
- `Accpeted Chain` - A chain that starts with a `Pebble` and ends with a `Pebble` Hotspot with all
  Hotspots signatures for each hop

|                                                   Accepted Chains                                                    |
| :------------------------------------------------------------------------------------------------------------------: |
|                                                      pHi => pHo                                                      |
|                                                   pHi => iH => pHi                                                   |
|                                              pHi => iH1 ... iHn => pHo                                               |
|                                                                                                                      |
| pHi (blue) = Initial Pebble Hotspot <br /> pHo (orange) = Opposite Pebble Hotspot <br /> iH (green) = Island Hotspot |

- `Witness List` - Will be generated from the `pHi => iH => pHi` chains. This list won't incorporate
  Hotspots within the same `Island Hex` but is included in the PoC due to the island construction
- `Cave` - A cluster of Hotspots that are isolated from the rest of the island

#### Island Construction

The network will be seperated into islands that are based on the geolocation of Hotspots and their
associated witness lists initially. Once the network is divided into Islands any new Hotspots will
just be added to existing [`Island`][definitions]. If the Hotspot is added to a location without a
current `Island` or the `Island` is less than 7 hexs in size. The original founder (Hotspot) for
that `Island` will expand the `Island` based on it's witness list.

1. The oldest Hotspot based on block age will start the first island
2. The witnesses of that Hotspot will be ranked based on block age
3. The oldest witness with a different `Island Hex` will select the next `Island Hex` for the island
4. Steps 2 - 3 will repeat until the max `Island` size of 7 is reached or no more witnesses exist
5. The next oldest Hotspot is then selected and either added to an existing island or creates a new
   one repeating steps 2 - 4 above.
6. This is performed until all Hotspots have an associated `Island` and `Island Hex`

<!-- Still working on converting current network to Islands for this data

<p align="center">
    🚧 Data was collected on 10/21/2020 - Network Size: 10,510 🚧
</p>

|   Size      |      #       |
|    :--:     |     :-:    |
|      1      |      80  <br /> 🐺 3716 |
|      2      |      614     |
|      3      |      307     |
|      4      |      154     |
|      5      |      102     |
|      6      |      62      |
|      7      |      356     |

🐺 are Islands that only consist of one hex with one Hotspot in them and no witnesses

!-->

## Ripple Effect

1. The [`Challenger`][definitions] selects the [`Island`][definitions] to be challenged
2. Then it selects the [`Pebble`][definitions] Hotspots within that `Island`
3. Once the `Pebble` Hotspots are selected, the `Challenger` will initiate the `ripple`. The packet
   being sent will have the challenger information and the expected hexs that packet will pass
   through to reach maximum chain length. Only the opposite `Pebble` of the pair can decrypt the
   packet received to then send back to challenger or Consensus Group
4. The `Pebble` Hotspots receive the packet
   1. They sign the packet in the spot for their [`Island Hex`][definitions] and broadcast it via RF
      (LoRa)
5. There are two options for the Hotspots that receive this broadcasted packet
   1. If, the receiving Hotspot is the opposite `Pebble` Hotspot, in this case the envelope will be
      able to be decrypted and sent back to the challenger
   2. If, the receiving Hotspot is **not** the opposite `Pebble` Hotspot it will perform step (4.i)
      above
6. This "ripple" occurs for a set timeframe or when the `Challenger` receives the expected number of
   chains from the `Pebble` Hotspots

##### Chain Limitations

[chainlimitation]: #chainLimitation

To simplify the process and lower the packets (envelopes) "broadcast storm" that the island
experiences due to the `ripple` the following limitation will be set.

1. Based on the island there will be only `N` number of hexs that the packet can travel. Because of
   this the packet will have `N` number of segments that can only be signed by a Hotspot that is
   found in that `Island Hex`.
2. If the packet is received by a Hotspot in a hex, where the hex has already been signed for by a
   different Hotspot the packet would be dropped.
3. The Hotspot records all the chains that it's seen. If the Hotspot receives a packet from a chain
   it's already has seen it drops that packet.

An example for limitation 3 above, if the Hotspot has seen and signed a packet with the following
chain `pHo => iH1` it will then drop all following packets that have that same chain. Since it's
possible for multiple Hotspots to reside in the same hex. This limitation is meant to limit the size
of the "broadcast storm" but if it's determined that it wouldn't be that constraining this could be
removed.

##### Benefits

[ripplebenefits]: #rippleBenefits

1. Only the challenger will know which `Pebble` Hotspots were selected
2. Based on the island size constraint and the fact that the chain is terminated based on the above
   [`Chain Limitations`][chainlimitation] results in a max number of possible
   [`Accepted Chains`][definitions] with a specific max chain length
3. Since it's assumed that all Hotspots within an `Island` are able to communicate due to the size
   of the `Island Hex` and associated witness lists. Any seperation in the `ripple` and
   `ideal ripple` will indicate the presense of an isolated Hotspot(s) a `Cave`.

#### Validation Process

The validation comes from the fact that the `Pebble` Hotspots will create the same number of chains
and lengths as each other. The difference how ever is that the chains will be mirror copies of each
other.

This is of course based on ideal conditions and an ideal `Island`, in fact there will be differences
between the ideal and real results. Because of these difference an `Island Rating` will be
implemented. The closer the `ripple` of a challenge gets to the `ideal ripple` the higher the
rating.

`Island Rating` Factors:

- Did the `ripple` create the max number of chains
- What's the longest chain received based on geolocation distance and not hop number

```
(# of chains received / Max # of Chains) + (Longest Chain / Longest Chain That Block) = 2
```

Therefore, to receive the max rating the `Island` needs to be spread out far enough in attempt to be
the longest chain per that block. When this occurs it increases the chances of Hotspots that
originally weren't in the selected Hotspots witness list to be incorporated in the PoC of the
island.

The `Island` than needs to ensure the max number of chains is received by the `Target` Hotspot with
all hops signed by the associated Hotspot.

To be accepted the `Pebble` Hotspots chains need to match (but will be mirrored)

#### Ideal `ripple` Illustrations

![Initial Pebble Hop](https://github.com/helium/hip/blob/master/0014-poc-ripple-method/initial.png?raw=true)

Figure 1-1 - Initial pebble hop

![Longest Chain Example](https://github.com/helium/hip/blob/master/0014-poc-ripple-method/longest-chain-example-tall.png?raw=true)

Figure 1-1 - Example of a Longest Chain, which results in a total of 6 accepted chains

```
pH (blue) = pebble Hotspot
iH (green) = island Hotspot
tH (orange) = target Hotspot
iHx (grey) = island hex

Max Number of Chains = # of pH * (# of iHx - # of pH)! => 2 * (7-2)! => 2 * 5! = 240
Longest Chain (length) = (# of iHx - # of pH) => (7 - 2) = 5
Max Number of Longest Chain = # of iH = 5
```

With the above equations, you can calculate the max number of chains and associated lengths. For a 7
hex island the resulting `ripple` would have 240 different chains that are 5 hex's in length.

#### Real Life Examples

Hotspot: big-corduroy-jaguar

Location: 8c2a32a0e5669ff

![Current Network View](https://github.com/helium/hip/blob/master/0014-poc-ripple-method/bcj-lone-wolf.png?raw=true)
Figure 2-1 - The current network view of the target Hotspot (big-corduroy-jaguar)

![Ripple Island](https://github.com/helium/hip/blob/master/0014-poc-ripple-method/bcj-island.png?raw=true)

Figure 2-2 - The island that the target Hotspot occupies

The island that big-corduroy-jaguar resides in contains 16 different Hotspots.

- Max Number of Accepted Chains = 240
- Longest Chain = 5
- Max Number of Longest Chain = 14

## Rewards

With the drastic change in PoC design the reward system would need to be altered as well. For my
initial proposal the following reward scheme should be implemented.

1. The Reward Pool divided by the sum of all island ratings.
2. The Island Reward would be divided by the # of Hotspots in all of the accepted chain(s).
3. Each Hotspot in each chain would receive 1 Hotspot reward

```
1. Island Rewards = ( Reward Pool Size ) / ( Sum of Island Ratings ) * Island Rating

2. Hotspot Reward = Island Rewards / # of Hotspots in all accepted chain(s)
```

```
Reward Pool = 10 HNT
Islands contain 7 hexs = 240 possible chains

big-corduroy-jaguar Island Rating = (240 / 240) + ( 14000m / 14000m ) = 2

1. ( 10 HNT ) / ( 2 ) * 2 = 10 HNT
2. (10 HNT) / ( 240 ) = 0.42 HNT per Hotspot

-------------------------------------------------------------------------

big-corduroy-jaguar Island Rating = (240 / 240) + ( 14000m / 14000m ) = 2
Small Island Rating = (240 / 240) + ( 100m / 14000m ) = 1.007142857142857

1. big-corduroy-jaguar Island Rewards = ( 10 HNT ) / ( 3.0071... ) * 2 = 6.6508... HNT
2. (6.6508 HNT) / ( 240 ) = 0.027 HNT per Hotspot

1. Small Island Rewards = ( 10 HNT ) / ( 3.0071... ) * 1.0071... = 3.3491... HNT
2. (3.3491 HNT) / ( 240 ) = 0.014 HNT per Hotspot
```

## Bounties

#### Island Bounties

With the rewards structured to payout to the `Island` you're able to provide the ability for
external sources to added additional funds to that `Island` to incentives it's growth.

# Drawbacks

- It will require a lot of time coding the new model
- This could create _new_ ways to game the system
- Current dense islands will not be rewarded as much

# Rationale and Alternatives

This is a drastic change to the current Proof-of-Coverage model. It will require extensive review
and testing.

HIP15 combined with HIP17 are alternatives to this proposal keeping to a lot of the same mechinisms
that are in place.

# Unresolved Questions

- Currently None

# Deployment Impact

This will impact everyone and turn all current documentations on end.

# Success Metrics

What metrics can be used to measure the success of this design?

- Ability to limit `Cave` participation and rewards

- Overall performance of this compared to current PoC model

- Number of possible "gaming" scenarios are limited

- Penalize "bad actors" more than highly dense "good actors"
