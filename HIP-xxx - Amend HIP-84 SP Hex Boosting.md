# HIP-xxx - Amend HIP-84 Service Provider Hex Boosting.md

- Author(s): [@mrfizzy99](https://github.com/mrfizzy99) (Fizzy99 - Fiz-Tech.net) 
- Start Date: 2024/02/19
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

HIP-84 Service Provider Hex Boosting as it is written, provides to much unilateral control over where rewards are distributed to any service provider at the expense of the network PoC distribution pool.
If a service provider decides to hex boost all of Miami, the rewards distributed on behalf of the network is disproportionate to the amount burned and disincentivizes the remaining nationwide deployments on the network for the sole purpose of that service provider, ultimately dictating areas where majority of rewards should go.
While this author understands that the first service provider on the network is key to the networks success for future service providers to join, it should not be at the detriment of the network's natural expansion nationwide into other cities, and internationally. 
With this in mind, there are also a few other amendments in this HIP that will also benefit the Service Provider in regards to HIP-84. 

## Prior Related HIPs

HIP-84 created Service Provider Hex Boosting.


## Motivation

TBW

## Stakeholders

- The MOBILE Subdao


## Detailed Explanation

This HIP aims to do three things to amend HIP-84 Service Provider Hex Boosting.  

1.  Service Provider Hex Boosting rewards to be taken out of the Service Provider Bucket. 
HIP-84 is by title, is Service Provider Hexboosting, and this should come out of the rewards distributed to Service Provider. 
This would incentivize Service Providers to think more carefully about where, for how long, and by how much a hex is boosted as it comes out of their own reward bucket. Incidentally, this also eliminates the need for limiting hex boosting multipliers while still allowing the Service Provider to boost 10x, 50x, 100x and beyond.  As the service provider takes the risk of their own rewards are taken advantage of, and is incentive to further police dishonest placements that they have deemed as high value.

2. Reduce the minimum time for Service Provider Hex Boosting to 3 months. 
Currently set to 6 months minimum, reducing this to 3 months allows Service Providers more flexibility in boosting a hex that they may be unsure if has value. Given if that this HIP passes and will be out of their own reward bucket, this will allow the Service Provider to further reduce the risk if the location or deployments in said location do not end up being beneficial to that Service Provider.

3. Staking a hotspot NFT to a Boosted Hex location. A Hotspot is unable to reassert once asserted into a boosted hex, and will be unable to reassert for the same amount of epochs that are remaining after the boosted has expired if they decide to stake for the boost. Due to the stake, the hotspots NFT will be unable to be transferred to any other wallet. When the hotspot asserts their location in a boosted hex, they will be prompted if they would like to stake the hotspot for x amount of epochs in order the receive boosted rewards. If they choose not to stake, they will receive no boosted rewards, and of course be able to reassert their hotspot at any time. 
By doing this, the network will demotivate hotspots operators from chasing boosted hexes only for the boosted rewards, making deals or contracts that solely revolve around the boosted hex time, and then moving out of the Boosted Hexes after the boosted hex has expired. This will benefit the service provider as it will ask for an equal amount of epoches of deployment time from the deployer without the boost as the incentive. 

For CBRS, the FreedomFi is the NFT, while the radios are what determines the coverage and ultimately the rewards given. This HIP proposes locking the radio IDs to that freedomfi gateway during the stake time. This will prevent the deployer from reutilizing the radios in another deployment with a new FreedomFi after the hex boosting has ended, but the staking time has not. 

Examples: 
- If a Service Provider boosts a hex for 6 months and the boosted hex has not yet been activated, the asserting hotspot will be asked if they would like to stake thier hotspot for a total of 12 months in order to receive the boosted rewards.  
- For a boosted hex that has already been activated for 3 months, the hotspot assertion will ask if they are willing to stake their hotspot for a total of 6 months to gain the boosted rewards.  
- For a boosted hex that only has 1 month of epochs left, that hotspot will only be asked to stake for a total of 2 months to receive boosted rewards.


## Drawbacks

After the hex boosting has ended, a hotspot deployer could just unplug/dismantle their hotpost setup and closet the hotspot until their staking time has ended. This would only benefit them if the costs of being at that location outweigh the rewards, forcing the operator to retire that hotspot until the staking has expired. 


## Rationale and Alternatives

TBW

## Unresolved Questions

TBW

## Deployment Impact

TBW

## Success Metrics

TBW


