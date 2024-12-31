# HIP Template (Give it a title here but do not allocate a number, maintainer will allocate a number)

- Author(s): @madninja 
- Start Date: 2024-12-31
- Category: technical, economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: <!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary

This HIP proposes to adjust the boost eligibility qualifiers in a boosted hex to be purely based on the HIP134 ongoing unique connections. 
This would remove the ability for a hotspot in a boosted hex to qualify for boosted rewards based on a CDR (HIP133) and/or by passing data (HIP84).  
A hotspot would earn non-boosted PoC rewards in a boosted hex using HIP133 rules, and only receive boost rewards when it has enough ongoing unique offload connections. 

## Motivation

When a hotspot is placed in a boosted hex it is expected to get significant offload. There are hundreds of hotspots at the time of writing of this HIP that are in boosted hexes that earn boosted PoC while selected for offload which have no or very little offload at all. These hotspots are basically in boosted hexes to farm boosted PoC and achieve this by gaming their location and one time CDR requirements as set out by HIP134 

## Stakeholders

- Wi-Fi Hotspot deployers - will receive higher rewards due to reduced boosted rewards gaming
- Service Providers and the network overall - will get value for remaining boosted hexes by only paying for PoC when a hotspot is actually offloading data. 

## Detailed Explanation


Hotspots that assert in a boosted hex
* Qualify for non-boosted PoC rewards if they qualify per HIP133 CDR/disco mapping rules.
* Qualify for boosted rewards with 25+ unique offload connections over an ongoing 7 day window as specified in HIP134 the hotspot receives boosted rewards for the boosted hex. Note that this is an ongoing requirement and not a one time threshold.

On approval and after implementation this HIP will activate for the US, followed by MX as carrier offload is activated there. 

The HIP84 3 unique device requirement is deprecated and no longer applicable when this HIP is approved and activated 


## Drawbacks

If a hotspot is in a boosted hex and never selected for carrier offload it is, at the time of the writing of this HIP, unlikely it will see enough unique connections to qualify for boosted rewards. While this can be seen as a drawback it’s also an expectation of the network and offload carrier that the hotspot will be selected and transit significant traffic in a boosted hex. 

## Rationale and Alternatives

When a hex is boosted it is expected to see significant subscriber traffic. The reason the service provider boosts is to encourage and reward hotspots for providing offload in that area. Limiting boost rewards to only hotspots that do so, enforces that expectation.

## Unresolved Questions


## Deployment Impact

Nova is committed to implementing this HIP


## Success Metrics

Hotspots in boosted hexes earn (boosted) PoC rewards when actually providing useful offload service for carriers.This means the number of hotspots in boosted hexes and that are selected for carrier offload but with no actual data offload will drop to 0.
