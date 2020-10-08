# HIP14: Proof of Coverage - Ripple Method

- Start Date: 10/01/2020
- Initial HIP PR: [#47](https://github.com/helium/HIP/pull/47)
- Tracking Issue: [#50](https://github.com/helium/HIP/issues/50)

# Summary
[summary]: #summary

The current Proof-of-Coverage allows for Virtual Machine (VM) farms or hotspot farms that have been engineered to get the maximum return of rewards. This HIP is proposing a completely different way to to determine Proof-of-Coverage than the current method. [PoC Documentation](https://developer.helium.com/blockchain/proof-of-coverage)

The current PoC model also rewards those hotspots that are in the most dense part of the network more than the edges. Resulting in over-coverage of those areas and limited expansion to new areas.

# Motivation
[motivation]: #motivation

With a new day comes a new way "bad actors" attempt to profit from the current system. To fully understand this proposal you first need to grasp the basics on how the current PoC system works. [PoC Documentation](https://developer.helium.com/blockchain/proof-of-coverage)

#### Basics of current PoC
*Note* If the following doesn't make sense please check out the above PoC documenation.

1. A challenger selects a target hotspot.
2. Once selected the challenger creates a PoC proof
    1. Starting with the target hotspot the challenger selects the next hotspot in the PoC path based on witness list and [hex](https://h3geo.org/docs) location (how the 300m limit is enforced).
    2. The challenger repeats the above step (2.i) but starting with the hotspot selected to be the next hop.
    3. This PoC path is created containing 2 - 5 hotspots (hops)
3. The initial challengee receives the PoC proof via the p2p network and decrypts the packet (envelope) it signs it and then returns it to the challenger 
4. The hotspot then broadcasts the new envelope that is now one layer less than the previous one via Radio Frequency (LoRa / RF).
5. This signal is then picked up by neighboring hotspots. The receiving hotspots have two options.
    1. The hotspot is the next hop in the PoC proof so it's able to decrypt another layer of the envelope and perform steps (4-5.i).
    2. The hotspot isn't the next hop so it signs the envelope and returns to sender (challenger) via p2p.
6. Steps 4 - 5 continue until the end of the PoC proof is reached resulting in a PoC receipt. This PoC receipt is then sent from the challenger to the Consensus Group to be validated.

#### Current Issues:
1. Due to the targeting techinque used (witness list) it's possible for farms to create isolated islands that will be picked for PoC and perform well between the hotspots in the farm but not to others.
2. The PoC path becomes very computationally extensive to validate the more dense the network is where the PoC took place.
3. All passed challengees and witnesses (up to 5 per challengee) are currently reward for a PoC receipt. Which can result in a farm receiving 20 rewards per hotspot even though only 5 PoC challenges were issued.

# Stakeholders
[stakeholders]: #stakeholders

* If this HIP is implemented it will effect everyone who owns a hotspot due to reward changes based on PoC.
* Feedback will be received via the Github `Issues` discussion and on [Discord #hips](https://discord.gg/helium)

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

## Ripple PoC Method

The network will be seperated into islands that are based on the geolocation of hotspots and their associated witness lists. 

The size of an island will be limited to the following:
* The smallest an island can be one hex
* The largest an island would be 7 hexs

The above size constraints are due to the max chain count that occurs with the `ripple` method which will be described in more detail below.

#### Definitions

* `Island` - A hex-cluster that is created by the island construction method below which visualizes the coverage of an area
* `Island Hex` - The hex used to create the island. It'll be of resolution 8 (~415m [0.25 miles] sides, ~0.447454km2 [110 acres] total area)
* `Children Hex` - The hex's found inside of the `Island Hex` of resolution 12 linked via hotspot location hex
* `Island Rating` - The overall rating of an island
* `Challenger` - The hotspot that selects the `Island` to be targeted and the `Pebble` hotspots for the challenge
* `Pebble (challengee)` - Selected by the challenger to start the *ripple*. Minimum of 2 all must be in a different `Island Hex`
* `Accpeted Chain` - Chain that starts with a `Pebble` and ends with a `Pebble` hotspot with all hotspots signatures for each hop

| Accepted Chains |
| --- | --- |
| pHi - pHo  |
| pHi - iH - pHi |
| pHi - iH1 ... iHn - pHo |

```
pHi (blue) = initial pebble hotspot
pHo (orange) = opposite pebble hotspot
iH (green) = island hotspot
iHx (grey) = island hex
```

* `Witness List` - Will be generated from the `pHi - iH - pHi` chains. This list won't incorporate hotspots within the same `Island Hex` but is included in the PoC due to the island construction
* `Cave` - A cluster of hotspots that are isolated from the rest of the island


#### Island Construction

Currently the island is constructed by selecting a random hotspot and based on it's associated hex will commence the construction of the island.

1. A random hotspot is selected
2. The hotspot's location hex string is selected
3. The island hex is found by expanding the location hex (resolution 12) to the island hex (resolution 8)
4. The island hex (resolution 8) is used to find all children hex (resolution 12)
5. The hotspots that are located in one of the children hex is add to the list of hotspots for the island
6. The list of hotspots is looped to get all witnesses to those hotspots
7. Step 2 - 5 are repeated for all witness hotspots
8. Once there are no more witness found the process ends

*The above process is only for proof of concept*

Ideally if adopted for this to be efficient as possible when a hotspot performs an `assert_location` transaction it will not only be assigned a location but also an island hex.
This will greatly speed up the process since there wouldn't need to be a re-index of hotspots to island hexs.

#### Ripple Effect

Once an `Island` is created for an area the `Challenger` will be able to perform the `ripple` method of PoC on that `Island`.

1. The `Challenger` will select the island it'll be challenging
2. Once the `Island` is selected the `Challenger` will select the `Pebble` hotspots
3. The `Challenger` will send the packet it created to the `Pebble` hotspots. Only the opposite `Pebble` of the pair can decrypt the packet received
4. The `Pebble` hotspots receive the envelope
    1. They sign the envelope with their `Island Hex` and broadcast it via RF (LoRa)
5. There are two options for the hotspots that receive that broadcasted envelope
    1. The receiving hotspot is the opposite `Pebble` hotspot, in this case the envelope will be able to be decrypted and sent back to the challenger
    2. The receiving hotspot is **not** the opposite `Pebble` hotspot, in this case it performs step (4.i)
6. This `ripple` occurs for a set timeframe or when the `Challenger` receives the expected number of chains from the `Pebble` hotspots

##### Limitations

To simplify the process and lower the packets (envelopes) received due to the `ripple` the following limitation is set. 

* If the hotspot receives an envelope that has been signed by it's island hex or an island hex it's already seen it's dropped. Forcing the packet to move outwards to the rest of the hex's in the `Island`

##### Benefits
1. Only the challenger will know which `Pebble` hotspots were selected
2. Based on the size constraint and the fact that the `Chain` is terminated if it returns to an already signed `Island Hex` results in a max number of possible ` Accepted Chains` with a max `Chain` length
3. Since it's assumed that all hotspots within an `Island` are able to communicate due to the size of the `Island Hex` and associated witness lists. Any seperation in the `ripple` and `ideal ripple` will indicate the presense of isolated hotspot(s) `Cave`. 

        Caves will be quite obvious with the `ripple` method

#### Validation Process

The validation comes from the fact that the `Pebble` hotspots will create the same number of chains and lengths as each other. The difference how ever is that the chains will be mirror copies of each other.

This is of course based on ideal conditions and an ideal `Island`, in fact there will be differences between the ideal and real results. This will result in the `Island Rating`. The closer the `ripple` of a challenge gets to the `ideal ripple` the higher the rating.

`Island Rating` Factors:
  * Did the `ripple` create the max number of chains
  * What's the longest chain received based on geolocation distance and not hop number

```
(# of chains received / Max # of Chains) + (Longest Chain / Longest Chain That Block) = 2
```

Therefore, to receive the max rating the island needs to be spread out far enough in attempt to be the longest chain per that block. When this occurs it increases the chance of hotspots that originally weren't in the selected hotspots witness list to be incorporated in the PoC of the island.

The `Island` than needs to ensure the max number of chains is received by the `Target` hotspot with all hops signed by the associated hotspot.

To be accepted the `Pebble` hotspots chains need to match (but will be mirrored)

#### Ideal `ripple` Illustrations

![Initial Pebble Hop](https://github.com/anthonyra/HIP/blob/HIP14/0014-media/initial.png?raw=true)

Figure 1-1 - Initial pebble hop

![Longest Chain Example](https://github.com/anthonyra/HIP/blob/HIP14/0014-media/longest-chain-example-tall.png?raw=true)

Figure 1-1 - Example of a Longest Chain, which results in a total 6 accepted chains

```
pH (blue) = pebble hotspot
iH (green) = island hotspot
tH (orange) = target hotspot
iHx (grey) = island hex

Max Number of Chains = # of pH * (# of iHx - # of pH)! => 2 * (7-2)! => 2 * 5! = 240
Longest Chain (length) = (# of iHx - # of pH) => (7 - 2) = 5
Max Number of Longest Chain = # of iH = 5
```

With the above equations, you can calculate the max number of chains and assocaited lengths. For a 7 hex island the resulting `ripple` would have 240 different chains that are 5 hex's in length.

#### Real Life Examples

Hotspot: big-corduroy-jaguar

Location: 8c2a32a0e5669ff

![Current Network View](https://github.com/anthonyra/HIP/blob/HIP14/0014-media/bcj-lone-wolf.png?raw=true)
Figure 2-1 - The current network view of the target hotspot (big-corduroy-jaguar)

![Ripple Island](https://github.com/anthonyra/HIP/blob/HIP14/0014-media/bcj-island.png?raw=true)

Figure 2-2 - The island that the target hotspot occupies

The island that big-corduroy-jaguar resides in contains 16 different hotspots.

* Max Number of Accepted Chains = 240
* Longest Chain = 5
* Max Number of Longest Chain = 14

## Rewards

With the drastic change in PoC design the reward system would need to be altered as well. For my initial proposal the following reward scheme should be implemented.

1. The Reward Pool divided by the sum of all island ratings.
2. The Island Reward would be divided by the # of hotspots in all of the accepted chain(s).
3. Each hotspot in each chain would receive 1 hotspot reward

```
1. Island Rewards = ( Reward Pool Size ) / ( Sum of Island Ratings ) * Island Rating

2. Hotspot Reward = Island Rewards / # of hotspots in all accepted chain(s)
```

```
Reward Pool = 10 HNT
Islands contain 7 hexs = 240 possible chains

big-corduroy-jaguar Island Rating = (240 / 240) + ( 14000m / 14000m ) = 2

1. ( 10 HNT ) / ( 2 ) * 2 = 10 HNT
2. (10 HNT) / ( 240 ) = 0.42 HNT per hotspot

-------------------------------------------------------------------------

big-corduroy-jaguar Island Rating = (240 / 240) + ( 14000m / 14000m ) = 2
Small Island Rating = (240 / 240) + ( 100m / 14000m ) = 1.007142857142857

1. big-corduroy-jaguar Island Rewards = ( 10 HNT ) / ( 3.0071... ) * 2 = 6.6508... HNT
2. (6.6508 HNT) / ( 240 ) = 0.027 HNT per hotspot

1. Small Island Rewards = ( 10 HNT ) / ( 3.0071... ) * 1.0071... = 3.3491... HNT
2. (3.3491 HNT) / ( 240 ) = 0.014 HNT per hotspot
```

# Drawbacks
[drawbacks]: #drawbacks

- It will require a lot of time coding the new model
- This could create *new* ways to game the system
- Current dense islands will not be rewarded as much

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

This is a drastic change to the current Proof-of-Coverage model. It will require extensive review and testing.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Currently None

# Deployment Impact
[deployment-impact]: #deployment-impact

This will impact everyone and turn all current documentations on end.

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- Ability to limit `Cave` participation and rewards

- Overall performance of this compared to current PoC model

- Number of possible "gaming" scenarios are limited

- Penalize "bad actors" more than highly dense "good actors"
