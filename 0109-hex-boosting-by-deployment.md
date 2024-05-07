# HIP 109: Hex Boosting by Deployment

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) &  [Max Gold](https://github.com/maxgold91)
- Start Date: 2024-01-27
- Category: Economic, Technical
- Original HIP PR: [#884](https://github.com/helium/HIP/pull/884)
- Tracking Issue: [#888](https://github.com/helium/HIP/issues/888)
- Vote Requirements: veMOBILE Holders

## Summary:

This Helium Improvement Proposal (HIP) allows Service Providers to specify what types of deployments their hex boosting can be applied to (i.e. CBRS vs Wi-Fi, and indoor vs outdoor).

## Prior Related HIPs

- [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md) created Service Provider Hex Boosting.

## Motivation:
In instances where Service Providers identify areas where they have high demand for data, they are able to burn MOBILE to provide a boost in those hexes, as defined in [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md). However, they aren’t able to specify which types of deployments they want to provide a boost in. 


## Stakeholders:

The stakeholders of this proposal are:
- **Service Providers** will be able to fine tune what types of deployments they want and where
- **Deployers** may not receive hex boosting if the equipment they deploy isn’t what the Service Provider needs.

## Detailed Explanation:
Whenever a Service Provider burns MOBILE to boost hexes, they will be allowed to choose which types of deployments (i.e. indoor CBRS, outdoor CBRS, indoor Wi-Fi, Outdoor Wi-Fi) their boost will apply to. This selection may be one, or all deployment types (note, the more deployment types selected, the more MOBILE will be required to burn). The selection needs to be made when the initial burn occurs, and cannot be changed after the initial selection. 

For example, if a Service Provider burns MOBILE to boost a hex and specifies the boost to only apply towards outdoor Wi-Fi, any indoor Wi-Fi and CBRS deployments covering that boosted hex will not receive the boost, but still will be rewarded for PoC.

In instances where the Service Provider wants to boost both CBRS and Wi-Fi in a hex, the cost will be $0.005 per res12 hex, per month, per deployment type (Wi-Fi vs CBRS). For example, if a Service Provider wanted to boost one hex to 10X for one month for both CBRS and Wi-Fi, the Service Provider will be required to burn $0.05 in MOBILE for Wi-Fi boost and $0.05 MOBILE for the CBRS boost. 

In instances where the Service Provider wants to boost both indoor and outdoor of the same deployment type (CBRS or Wi-Fi), they can do so for an additional $.0025 per res12 hex.


In instances where MOBILE already has been burned to boost hexes, and deployments are currently providing coverage to those hexes, those hexes will remain as boosted hexes for all deployment types (i.e. indoor CBRS, outdoor CBRS, indoor Wi-Fi, Outdoor Wi-Fi) for the duration of the boost.

For any boosted hexes that do not contain coverage, the Service Provider will have the option to choose what type of deployment the boosts will apply to at no extra cost.


## Drawbacks:
None

## Rationale
Since Service Providers are paying for boosts, they should be able to select what types of deployments they would like to see in those boosted areas. 


## Success Metrics
The primary success metric will greater fine tuned coverage in boosted hexes. 


