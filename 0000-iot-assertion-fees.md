# IoT Assertion Fees Update

- Author(s): @charlesfayal
- Start Date: 2023-5-19
- Category: economic
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

The fee to assert (aka onboard) an IoT gateways is currently 4,000,000 DC ($40) and the fee to assert a gateway's location is 1,000,000 DC ($10). This HIP proposes changing these fees down to $5 for onboarding, and $5 for location assertions. This will result in cheaper gateways which will help the IoT network to continue to expand and increase it's utility.

# Motivation
[motivation]: #motivation

The price of gateways have come down to as low as $99. With $50 of assertion fees included (onboarding + first location) this means that ~50% of the cost of the gateways is from the cost of these fees, demonstrating that these fees are unnecessarily high. The cheaper that gateways become the more use cases open up and the more the network will expand.

The original reason for the fees is to prevent [Sybil attacks](https://en.wikipedia.org/wiki/Sybil_attack). This was only relevant when gateways performed the PoC logic. If an attacker created a bunch of fake gateways they could control the blockchain. This is no longer relevant since gateways do not perform the blockchain logic anymore.

# Stakeholders
[stakeholders]: #stakeholders

Gateway Manufacturers - cheaper assertion fees enables them to sell gateways with the fees included at lower prices.

Coverage Providers - cheaper gateways should enable them to deploy gateways less expensively.

Network Users - cheaper gateways should enable more applications.

Investors - cheaper gateways should increase the cost to utility ratio of the network which increases its value.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Their are no new concepts to this HIP. The only change would be that the assertion fees would be adjusted to the proposed amounts via chain variable adjustments.

There would be no blockchain code changes for this HIP, however, any documentation or apps that use the assertion fees will need to be updated to reflect the new fees.

# Drawbacks
[drawbacks]: #drawbacks

With the current DAO utility score equation this would mean the IoT utility score would increase incrementally less than it would have per gateway with higher assertion fees.

A decrease in the location assertion fee could result in gateways to be logically moved to better score locations even if the gateway isn't actually moved. Since this fee is only halved, this should have a minimal impact. Furthermore, bad assertions should be policed in other ways such as with anti-gaming algorithms.

A decrease in the assertion fees could also mean a decrease in the DC burn rate for the network. However, this should never have been a main driver of economic driver for a network.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

The alternatives are maintaining the current assertion fee rates, or creating a dynamic assertion fee cost. The flat rate has been chosen due to ease of implementation to move this HIP through quicker.

The impact of not doing this is maintaining a barrier to cheaper gateways which reduces the potential of the network.

# Unresolved Questions
[unresolved]: #unresolved-questions

Waiting to determine if we can adjust the DAO utility score to either not include the onboarding fee, or make the utility score the sum of historical assertion fees paid rather than the current cost of assertion fees. This may need to be resolved in a separate HIP.

# Deployment Impact
[deployment-impact]: #deployment-impact

Helium's documentation would need to be adjusted to reflect the new rates. For example, https://docs.helium.com/blockchain/transaction-fees/

This will be backwards compatible with 

# Success Metrics
[success-metrics]: #success-metrics

The main metric would be the cost of gateways post merge. For example for the $99 gateway, we'd hope to see a $59 price tag.

We should see an increase in gateway sales as the price decreases, although this has a number of other macro factors.

The decrease in the location reassertion fee could result in an increase of gateway locations changes.