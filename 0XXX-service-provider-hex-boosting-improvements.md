# Service Provider Hex Boosting Improvements 

- Author(s): @zer0tweets, [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2024-03-06
- Category: Economic, Technical
- Original HIP PR:
- Tracking Issue: 
- Vote Requirements: veMOBILE Holders

## Summary

This Helium Improvement Proposal (HIP) introduces a requirement for service providers to physically audit all new boosted hexes using trusted mappers, until verification mapping is implemented on chain. It also proposes that Service Providers get the option to make boost specific to radio technology i.e. CBRS vs. Wi-Fi, burning separate fees for each radio type (aka RAT-aware boosting)

## Motivation

In instances where Service Providers identify areas where they have high demand for data, they are able to burn MOBILE to provide a boost in those hexes, as defined in [HIP-84](https://github.com/helium/HIP/blob/main/0084-service-provider-hex-boosting.md). Currently, when a Service Provider wants to boost a hex, they are required to burn $.005 worth of MOBILE per res12 hex for one month by 1x. Since the launch of boosted hexes, service providers have boosted a number of areas to very high boost levels, resulting in outsized incentives for gamers to create fake deployments in boosted locations.  

This HIP aims to curtail gaming of boosted locations until verification mapping is implemented by a) forcing Service Providers to be more intentional about choosing what to boost by making it more expensive; b) creating temporary requirement for physical audits of deployments in boosted locations; c) empowering Service Providers to suspend hotspots that are gaming boosted locations

## Stakeholders

-   Hotspot owners deploying in boosted hexes will become subsject to audits by trusted mappers and have their rewards suspended, if misrepresenting the location
-   Service providers will be obligated to audit boosted locations until verification mapping is implemented
    

## Detailed Explanation

The following changes to the originally adopted Service Provider Hex Boosting framework (HIP84) are proposed.

### Temporary Halt on Boosting

Following passing of this HIP, it is proposed that Service Providers are temporarily prohibited from boosting additional hexes, until completion of physical audit of the existing locations and on chain implementation of the proposed hex boosting price increase (see below).

### Service Provider Enforcement of Boosted Location Gaming  

Service providers are required to diligently monitor any attempts to game hexes that were boosted by the said service provider. Provided reasonable evidence that gaming of boosted hexes is happening, service providers are empowered with a privilege to temporarily suspend all POC rewards for such hotspots for up to 10 days. Reason for suspension to be publicly broadcasted to the rewards oracle. When and if HIP 107 passes, it’s framework for hotspot suspension will supersede the proposal in this HIP and this section will no longer apply.


### One Time Audit and Removal of Existing Boosts

Boosted location is a contiguous area of adjacent res12 hexes, boosted by a service provider.

Trusted mapper is an individual designated by the service provider to complete a physical verification of coverage at a given location, following a prescribed list of instructions, requiring such individual to visit the location and attempt to complete a connection to a radio (Wi-Fi or CBRS).

Fourteen calendar days following approval of this HIP, Service Providers must audit all boosted locations by physically verifying connectivity at such locations using trusted mappers.

Following the audit, service providers will provide a publicly accessible list of boosted locations where boosts should be either decreased or removed completely, that will include the following categories of locations:

-   All boosted locations with boost higher than 25x that have not yet received coverage
-   All boosted locations with existing coverage that have failed physical verification
-   Any additional boosted locations that have been previously boosted, but have relatively light foot traffic per aggregated data from discovery mapping; boost removal for such locations to be proposed at service provider’s discretion

The list will be published in a public discord channel and open for any objections from community members. Any locations that have not received objections, will be updated per the published proposal.

### Ongoing Verification using Trusted Mappers
Until automated verification mapping is implemented on-chain that enables trustless location validation, it is proposed that Service Providers become responsible for physical validation of all boosted locations using trusted mappers. It is the responsibility of a Service Provider to ensure availability of trusted mappers at the locations of boosted hexes. No longer than 14 days following the appearance of coverage in a boosted hex, Service Providers must coordinate with trusted mappers to validate the physical presence of coverage.

### RAT-Aware Boosting
Whenever a Service Provider burns MOBILE to boost hexes, they will be allowed to choose which types of deployments (i.e. indoor CBRS, outdoor CBRS, indoor Wi-Fi, Outdoor Wi-Fi) their boost will apply to. This selection may be one, or all deployment types (note, the more deployment types selected, the more MOBILE will be required to burn). The selection needs to be made when the initial burn occurs, and cannot be changed after the initial selection.

For example, if a Service Provider burns MOBILE to boost a hex and specifies the boost to only apply towards outdoor Wi-Fi, any indoor Wi-Fi and CBRS deployments covering that boosted hex will not receive the boost, but still will be rewarded for PoC.

In instances where the Service Provider wants to boost both CBRS and Wi-Fi in a hex, the cost will be $0.005 per res12 hex, per month, per deployment type (Wi-Fi vs CBRS). For example, if a Service Provider wanted to boost one hex to 10X for one month for both CBRS and Wi-Fi, the Service Provider will be required to burn $0.05 in MOBILE for Wi-Fi boost and $0.05 MOBILE for the CBRS boost.

In instances where the Service Provider wants to boost both indoor and outdoor of the same deployment type (CBRS or Wi-Fi), they can do so for an additional $.0025 per res12 hex.

In instances where MOBILE already has been burned to boost hexes, and deployments are currently providing coverage to those hexes, those hexes will remain as boosted hexes for all deployment types (i.e. indoor CBRS, outdoor CBRS, indoor Wi-Fi, Outdoor Wi-Fi) for the duration of the boost.

For any boosted hexes that do not contain coverage, the Service Provider will have the option to choose what type of deployment the boosts will apply to at no extra cost.

### Remove Discovery Mapping Data Requirement to Trigger Rewards

HIP 84 originally proposed that "creation of coverage will be considered to have been confirmed when at least three unique phones with discovery mapping enabled have successfully connected and passed at least 1MB of data at the location of coverage (as evidenced by the Mobile Oracle)" 

This requires that all service providers on the network implement discovery mapping capability for their subscribers. We have since learned that due to uncertain regulatory climate surrounding cryptocurrency in various geographies this may raise the barrier to entry for new service providers. For instance, Telefonica is not currently able to implement discovery mapping for it's subscribers in Mexico. We, therefore, propose that this requirement be removed and the threshold be changed from 3 subscribers to 1 subscriber. I.e. any one subscriber, regardless of discovery mapping being enabled, passing 1Mb of data should trigger the start of boosted reward earnings for a hotspot. Coverage location will be confirmed through skyhook + audit trusted mappers audits and, later, verification mapping. 

## Drawbacks

Manual auditing process proposed here is labor intensive and doesn’t scale.

RAT-aware boosting, yet again, adds further complexity to reward mechanisms.

## Rationale and Alternatives

Manual mechanism of hex boost audits using trusted mappers proposed here makes it possible to continue boosting and minimize hex boosting gaming without needing to wait for any algorithmic on-chain solution to the problem.

An alternative would be to wait until implementation of verification mapping to boost any more hexes.

## Unresolved Questions

This HIP does not provide specificity as to the process of becoming a trusted mapper. The assumption is that the community will trust service providers on the network to exhibit some degree of diligence to ensure trusted mappers are indeed trusted. Since manual audit is a temporary process that will become largely irrelevant, following the implementation of verification mapping, it is proposed that we don’t overthink this issue.

## Deployment Impact

Implementation of manual audits will require no code changes. RAT-aware boosting will require updates to rewards oracle and MOBILE-burn mechanism for boosting hexes. The implementation to be done by Nova in collaboration with the foundation. It is proposed that implementation can be rolled out in stages. Specific stages and dates to be proposed by the engineering teams.

## Success Metrics

This HIP will be considered successful if the ratio of POC rewards to data rewards for hotspots covering boosted hexes has increased by at least 50%.
