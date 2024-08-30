# HIP Split Claimed Rewards Between Multiple Wallets

- Author: [@cipherkilledit] (https://github.com/cipherkilledit)
- Start Date: 8/30/2024 
- Category: Technical, Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

This Helium Improvement Proposal introduces the concept of splitting claimed rewards between multiple wallets. 

## Motivation

Most commercial venues want a share of the rewards, but do not possess the technical knowledge or will to deploy hardware themselves. To grow coverage of the mobile network faster, it makes sense to provide Builders a way to share rewards with Property owners. This would enable both parties to be rewarded in separate wallets at a specified percentage. Example: When claiming, Builder receives 50% and Property Owner recieves 50%. This will also reduce the gas fees paid by users who required 2 separate transactions to acheive this result manually. 

## Stakeholders

- Builders actively deploying hotspots
- Operators who manage existing hotspots 
- Property Owners hosting hotspots
- Prospective Property Owners seeking a portion of rewards post-deployment

## Detailed Explanation

In this proposal we formally introduce the concept of splitting rewards between multiple wallets. Upon approval of this HIP, hotspots would configurable to allow Builders to specify additional wallets to receive rewards and what percentage of the rewards each wallet would recieve when claiming. Example: a commercial Property Owner could allow a Builder to deploy hotspots throughout their property in exchange for 50% of the ongoing rewards. Upon claiming the rewards, the Builder and the Property Owner would each receive 50% of the claimed rewards in their respective wallets. 

## Drawbacks

Introducing rewards splits would enable the party in custody of the hotspot's NFT to change the split percentage at any time without approval from the other party.

## Rationale and Alternatives

The current approach to splitting rewards is a time-consuming process in which  the party custodying the hotspot's NFT to claim the rewards and then send the other party their portion of the rewards manually in a separate transaction.

## Unresolved Questions

What happens in the event one party makes unauthorized changes to the split percentage? Could a smart contract be implemented that requires a signature from both parties before a split percentage is changed? If one party loses access to their wallet, how would the split percentage or wallet address be revised? 

## Deployment Impact

Nova Labs will collaborate with the Helium Foundation to complete the implementation, should this HIP pass voting. Specific deployment impact details and timeframe will be filled out by engineering prior to HIP going to vote. 

## Success Metrics

This HIP has been deployed successfully when rewards are sent to multiple wallets in accordance with the defined split percentage and listed addresses upon claiming. Success can be measured by comparing the gas fees paid by users who were manually splitting rewards prior to the implementation of this HIP.
