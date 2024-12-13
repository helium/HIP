# HIP XXX: Removal of Service Provider Emissions
- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 12/13/2024
- Category: Economic, Technical, Governance
- Original HIP PR: 
- Tracking Issue: 
- Voting Requirements: veMOBILE

---

## Summary
This HIP would remove the Service Provider MOBILE reward pool/emissions that are currently given Service Providers (SP) as a rebate for using the network.

## Motivation

The main SP on the MOBILE network is currently Helium Mobile (AKA Nova Labs). Through a subDAO rebate, Nova Labs effectively does not pay anything to use data on the MOBILE network, as each GB used they are rewarded in $.50 worth of MOBILE through the subDAO. As this data is effectively free, it discourages Nova Labs from preventing abuse of data usage through hotspots and subscriber plans. For example, Helium Mobile subscribers can buy a Helium Mobile hotspot, and effectively get the equivalent in MOBILE for their plan each month by cycling data through their hotspot. Nova Labs allows this because the data is effectively free on their end. However, this lowers overall daily PoC rewards for all other hotspots. Further, allowing this to occur discourages the MOBILE network to move away from PoC, and move towards a Proof of Data Usage (PoD) model.


## Stakeholders

- Service Providers will no longer receive MOBILE emissions for using data on the MOBILE network
- Mobile Hotspot Deployers who use their own hotspots and Helium Mobile plan for personal gains may no longer be rewarded for doing so

## Detailed Explanation

Upon passing, emissions to Service Providers would cease immediately. This HIP will lay the foundation for allowing future HIPs to move away from the flawed proof of coverage method, as Service Providers will need to more carefully monitor which data they want to pay for, thus, allowing the network to identify and reward real data usage. 


## Alternatives

One alternative is to instead of completely removing SP emissions, to reduce them. For example, for every GB paid for, you will only receive a rebate/emission of 50% of the cost of that data. 

## Drawbacks

One drawback of not having SP emissions is it may encourage other SPs from joining the network; however, as only 1 SP has formally joined the network, in the network's lifetime, these rewards do not appear to be a main motivator to joining the network.


## Deployment Impact

This proposal will be implemented by Helium core developers. 

## Success Metrics

This HIP is successful if Service Providers more carefully enforce which data they will pay for, effectively reducing gaming over data cycling via hotspots and subscriber plans.
