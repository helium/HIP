# HIP-xxx - Amend HIP-84 Service Provider Hex Boosting

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
With this in mind, there are also a few other amendments in this HIP that will also benefit the Service Provider in regards to HIP-84. One of which is changing the minium boost time to 3 months, and the other is staking the hotspot in order to receive the boosted rewards. 

## Prior / Related HIPs

[HIP-84 Service Provider Hex Boosting](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.
[HIP-109 Hex Boosting by Deployment](https://github.com/helium/HIP/blob/main/0109-hex-boosting-by-deployment.md) modifys hex boosting to allow Service Providers to specify a radio type. 

## Motivation

This HIP is being proposed to address some concerns about the original implementation of HIP-84. 


## Stakeholders

- The MOBILE Subdao


## Detailed Explanation

This HIP aims to do four (4) things to amend HIP-84 Service Provider Hex Boosting.  

1.  Service Provider Hex Boosting rewards to be taken out of the Service Provider Bucket first. 
HIP-84 is by title, is Service Provider Hex Boosting, and this should come out of the rewards distributed to the Service Provider. If there is not enough MOBILE allocated for the Service Provider bucket to cover the boosted hexes in a single epoch, the remainer would then come out of the networks regular PoC bucket. 
This would incentivize Service Providers to think more carefully about where, for how long, and by how much a hex is boosted as it comes out of their own reward bucket.

2. Reduce the minimum time for Service Provider Hex Boosting to 3 months. 
Currently set to 6 months minimum, reducing this to 3 months allows Service Providers more flexibility in boosting a hex that they may be unsure if has value. Given if that this HIP passes and will be out of their own reward bucket, this will allow the Service Provider to further reduce the risk if the location or deployments in said location do not end up being beneficial to that Service Provider.

3. Limit boosting to a maximum of 10x. 
Currnetly uncapped, we as a community have come to the conclusion that the 100x boosted hexes only breeds reward chasing and attempted gaming of PoC. This can be proven as there were very few people (if not no one) deploying within boosted hexes prior to the value oracle of MOBILE changing drastically late 2023. It is this authors opinion that boosted hexes should incentivise a longer term depoyment strategy, and the deployer should have their goals aligned with that in mind. With the current mutiplers that can be set, the goals of the depoyments in these are not for long term, and only short term.  This multiper would only reduce the maximum for any future hex boosting, and not change any current boosted hexes once passed. 

4. Staking a hotspot NFT for Boosted Hex rewards.
In order to receive boosted rewards from a boosted hex that is being covered, the operator will need to stake their hotspot NFT after they are deemed eligable (more on that below) for a period of time. The stake time will vary and depending on the amount of epochs that are remaining within those boosted hexes (averaged out if the hotspot covers multiple hexes), and multiplied by 2x. The hotspot operator will be asked if they are willing to stake for x amount of epochs in order the receive those boosted rewards, which again is double of the averaged out remaining epoche time on those boosted hexes covered. Once the hotspot is staked for boosted hex coverage rewards, the hotspot will be unable to reassert for the duration of the stake and the NFT will also be non-transferrable to any other wallet. If they choose not to stake, they will receive no boosted rewards, and of course be able to reassert or transfer their hotspot at any time.
By doing this, the network will demotivate hotspots operators from chasing boosted hexes only for the boosted rewards, making deals or contracts that solely revolve around the boosted hex time, and then moving out of the Boosted Hexes after the boosted hex has expired. This will benefit the service provider as it will ask for an equal amount of epoches for deployment time from the deployer without the boost as an incentive.
It is also expected that all current deployments that cover boosted hexes would be required and asked to stake their hotspot to their location in order to receive the boosted hex rewards. Once fully implemented, there will be NO 'Grandfathered' hotspots that receive boosted hexes rewards without staking.

For CBRS, the FreedomFi is the NFT, while the radios are what determines the coverage and ultimately the rewards given. This HIP proposes locking the radio IDs to that freedomfi gateway during the stake time. This will prevent the deployer from reutilizing the radios in another deployment with a new FreedomFi after the hex boosting has ended, but the staking time has not. 

Staking Eligibility for Boosted Hex Rewards: 
- For both Wifi and CBRS, the hotspot asserted or has modeled coverage overlapping a boosted hex location will need to go through 3 full epochs/days with a total of atleast 48 valid heartbeats. 
- In the case of WiFi, they will also have to pass skyhook validation for that area in order to be eligible to stake their hotspot to receive hex boosting rewards. If the hotspot does not pass skyhook validation, they will not be eligible to proceed with staking their hotspot due to the inaccuracy. 

Examples of stake duration: 
- If a Service Provider boosts a hex for 6 months and the boosted hex has not yet been activated, the asserting hotspot will be asked if they would like to stake their hotspot for a total of 12 months in order to receive the boosted rewards.  
- For a boosted hex that has already been activated for 4 months of a total 6 month boost with 2 months left, the hotspot assertion will ask if they are willing to stake their hotspot for a total of 4 months to gain the boosted rewards. 
- For a boosted hex that only has 1 month of epochs left, that hotspot will only be asked to stake for a total of 2 months to receive boosted rewards.

Examples of use when assterting and staking prompts: 
- When the hotspot asserts their location in a boosted hex, or within a Resoultion 6 hex of a boosted area, they will get a prompt after the assertion that they could be eligible for boosted hex rewards. They will be told that it will take 72 hours to validate coverage if they meet the eligibility requirements and will need to stake their hotspot NFT in order to receive the boosted rewards, lastly to check back in 72 hours for a new prompt on the status of such. 
Once the 72 hours have passed, if the hotspot meets eligibility requirements, they will have a prompt to begin the hotspot NFT stake, with a few prompts explaining the implications of staking, and a total time their hotspot will be staked for in order to start receiving those boosts hex rewards. A hotspot could be ineligible for various reasons, and should also give short feedback on why they are not eligible. This could range from something such as the modeled coverage not extending into a boosted hex, to a skyhook inaccuracy flag.


Phase 1:
The first phase of this implementation would be Parts 1, 2, and 3 stated above, as these should take relatively little time for implementation.

Phase 2:
The second phase of this implementation would be Part 4 stated above, as this could take longer for the coding of the staking mechanism. 




## Drawbacks

After the hex boosting has ended, a hotspot deployer could just unplug/dismantle their hotspot setup and closet the hotspot until their staking time has ended. This would only benefit them if the costs of being at that location outweigh the rewards, forcing the operator to retire that hotspot until the staking has expired. 


## Rationale and Alternatives

There are a few alternatives to HIP-84 that are being discussed; however, the most prominent topic discussed is where the allocation of rewards comes from, which this HIP addresses. 


## Unresolved Questions

Will add as they come up in discussion. 


## Deployment Impact

This will impact all hotspots currently asserted that cover boosted hexes by having them stake their hotspot NFT for x amount of time/epochs in order to continue to receive boosted hex rewards. This will also require all future asserting hotspots to stake their hotspot if their coverage is within a boosted hexes.  

This will also impact the emissions allocation for boosted hexes, switching from the PoC bucket to the Service Provider bucket.


## Success Metrics

With the success of this HIP we should see more dedicated deployments within Hex Bossted areas, as operators take more risk of staking their hotspot into that area. 


