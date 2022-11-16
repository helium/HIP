# HIP 49: LoRaWAN Sub-region Max EIRP Limit

- Author(s): [@beaky98](https://github.com/beaky98) [@resyncX](https://github.com/resyncX) [@AnhTuDo1998](https://github.com/AnhTuDo1998) [@Trinitrophenol81](https://github.com/Trinitrophenol81) [@ubiru](https://github.com/ubiru)
- Start Date: 2021-12-20
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/325>
- Tracking Issue: <https://github.com/helium/HIP/issues/327>

# Summary

This proposal suggests adopting a LoRaWAN subregion config for max EIRP limit which will allow individual countries within an RF region i.e. AS923 to define max EIRP limit based on each country’s local regulation instead of a single max EIRP limit across the entire AS923 as a result of PoCv11.

# Motivation

Helium aims to provide coverage as the people’s network and we are trying to help by restoring the coverage area in countries where the respective max EIRP limits are higher than the 16dBm (40mW) currently set for the entire AS923 region via PoCv11. It has since reduced the coverage area significantly and the effects can be seen clearly with a drop in the number of witnesses and witnessed by others before and after the implementation of PoCv11.

For countries in the AS923 region where their local regulatory max EIRP limit that's between 25-27dBm, we can expect to see an increase of coverage area probably close to the same level as before PoCv11 (as the previous hardcoded EIRP limit was 27dBm) if this is implemented.

This implementation can be extended to other regions as well if needed.

# Stakeholders

Hotspots owners in AS923 region where the local regulatory EIRP limit is higher than the current 16dBm EIRP limit set will benefit from this proposal. And this can be extended to regions that are affected.

We have started to reach out to people in Helium discord regional channels: hk-hong-kong, id-indonesia, jp-japan, my-malaysia, ph-philippines, sg-singapore, th-thailand, tw-taiwan.

As this issue has been raised in this: <https://github.com/helium/miner/issues/1105>, we will be contacting them via GitHub to solicit feedback on this HIP.

# Detailed Explanation

[detailed-explanation]: #detailed-explanation

To implement country-specific EIRP limits via LoRaWAN subregions settings. Individual country EIRP max limit can be defined within the LoRaWAN subregion instead of a fixed value for the entire region.

For countries that do not have a subregion max EIRP limit value defined, it should then fall back to the default regional max EIRP limit value (i.e. 16dBm).
This can be extended to any region outside of AS923 for that matter.

The software probably needs to be written to the core blockchain. Software update deployed to all Hotspots, Validators, etc to support the new rules. This is consensus affecting so it needs to be a full deployment.

The LoRaWAN committee of the DeWI needs to propose and manage the subregion settings. They could also propose initial chain variables. These variables should be maintained by the LoRaWan committee on an ongoing basis.

# Drawbacks

TBD

# Rationale and Alternatives

We have explored the possibility of including this as part of HIP45 as it is the closest HIP with regards to country-specific values.

However, considering HIP45 is addressing the frequency plan selection for different countries rather than max EIRP limits, it may further complicate things/the deployment process and might not be the best way to implement this hence we have drafted this new HIP for consideration/implementation.

# Unresolved Questions

Under the [detailed-explanation], how can we support the LoRaWAN committee of DeWI?

- Such as by giving them the initial supporting links and official documents needed for the sub-region max EIRP.

# Deployment Impact

The subregion config will be transparent to existing users just like PoCv11.

Users in countries with local regulatory EIRP limits higher than 16dBm with the LoRaWan subregion max EIRP values defined will experience improved coverage in general.

There will be an update required to document the LoRaWAN subregion max EIRP limits for the impacted countries in the region

This should be backward compatible, as this could simply revert back to the 16dBm limit previously set by the LoRaWan committee.

# Success Metrics

To verify whether there is an increase in performance, we have to see:

- Increased in the coverage area
- Increase in number of witnesses and witnessed others with the same existing setup

To prove an improvement of stability, this will be similar to how it is done with PoCv11

A poll could be raised to prove an acceptance of this by users
