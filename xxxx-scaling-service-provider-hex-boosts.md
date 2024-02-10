 # HIP XXX: Scaling Service Provider Hex Boosts

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) 
- Contributor: J Hella
- Start Date: 2024-01-26
- Category: Economic, Technical
- Original HIP PR:
- Tracking Issue:
- Vote Requirements: veMOBILE Holders

## Summary:

This Helium Improvement Proposal (HIP) proposes changing the minimum size hex that can be boosted from res12 hex to res10 hex, scaling the price to boost, and limiting the maximum boost to 50X. 

## Prior Related HIPs

- [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.

## Motivation:
In instances where Service Providers identify areas where they have high demand for data, they are able to burn MOBILE to provide a boost in those hexes, as defined in [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md). Currently, when a Service Provider wants to boost a hex, they are required to burn $.005 worth of MOBILE per res12 hex for one month by 1x. Since the launch of boosted hexes, the MOBILE subnetwork has experienced slow growth in boosted hexes, which may be attributed to small hex sizes.


## Stakeholders:

The stakeholders of this proposal are:
- Service Providers will be able to boost larger areas at a cheaper cost than previously
- Deployers should see an increase in boosted hexes

## Detailed Explanation:
Under this HIP, the minimum size hex a Service Provider can boost is one res10 hex (approximately 9.350 meters sq.), while the minimum duration remains at 6 months. It also provides tiered pricing to make boosting more hexes with a lower multiplier more attractive and cheaper, and boosts with a higher multiplier more expensive. Please note, per HIP 103, all hexes automatically have a Service Provider Hex Boost value of 1X. The cost to boost one res10 hex per month per 1X under this HIP is as followed:


| Final Multiplier | Per Month and Per 1X Increase |
|------------------|-------------------------------|
|2-10X             | $0.05                         |
|11-20X            | $0.10                         |
|21-30X            | $0.20                         |
|31-40X            | $0.40                         |
|41-50X            | $0.80                         |

In instances where the Service Provider boosts more than 10X, the price of the first 9 boosts will be $.05 per month, per 1x increase, and the next 11-20X at $0.10.

Below is a chart that illustrates the pricing costs per HIP 84, and what this HIP would change them to:

| Final Multiplier | HIP 84 Cost | New Cost |
|------------------|-------------|----------|
|2-10X             | $13.23      | $2.70    |
|11-20X            | $27.93      | $8.70    |
|21-30X            | $42.63      | $20.70   |
|31-40X            | $57.33      | $44.70   |
|41-50X            | $72.03      | $92.70   |



## Drawbacks:
Service Providers will now not be able to fine tune boosts down to the res12 hex size, which might result in coverage being deployed in areas that are close to the res12 hex where they want boosted, but not close enough to provide coverage.  

Further, Service Providers will no longer be able to boost past 50X; however, with having current hex boosts at 100X, the MOBILE subnetwork has experienced an increase in gaming in those hexes.

## Rationale
Currently, with hexes being boosted at the res12 level, deployers have found it hard to be able to provide coverage within those defined res12 hexes due to the small hex size. Therefore, expanding the hex size and lowering the cost to apply the boost will encourage more widespread boosts, which will allow more deployers to benefit from Service Provider hex boosting.

## Deployment Impact
TBD


## Success Metrics
This HIP will be considered successful if Service Providers boost larger and more areas that need coverage. 



