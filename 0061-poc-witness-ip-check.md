# HIP 61 : PoC Witness IP Check

- Author(s): [@H-Baguette](https://github.com/h-baguette)
- Start Date: 2022-05-24
- Category: Technical
- Original HIP PR:
- Tracking Issue:

# Summary
[summary]: #summary

Prevent spoofing by checking each witness's IP address against the beacon's IP address and other witnesses' IP addresses, while still allowing witnesses sharing the same IP address as the beacon to be considered valid under specific yet rather accessible conditions.

# Motivation
[motivation]: #motivation

Spoofed hotposts steal a share of honest hotspot owners by cheating the system, and thus disincentivise the spread of the network by new and existing users. This also poorly affects the reputation of the Helium network.
This HIP aims to solve both of these problems.

# Stakeholders
[stakeholders]: #stakeholders

* All hotspot owners are affected by this proposal.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

**irregular** : A witness is considered irregular if it shares its IP address with either the beacon or another witness of that beacon.

**balanced** : An irregular witness is balanced when the presence of a valid witness for the same beacon allows it to be considered valid itself.

A witness sharing its IP with the beacon it witnessing OR with another witness of the beacon they are witnessing is considered
**irregular**.
In order to be considered valid, an irregular witness needs to be **balanced** with a valid witness of the same beacon sharing their IP address with neither the beacon or another witness of that beacon.
Each valid witness can only balance one irregular witness. If a beacon has X valid witnesses, only X irregular witnesses will be considered valid (chosen randomly).

An irregular witness will be tagged as such on the explorer (whether ultimately considered valid or not) in order for hotspot owners to better understand their situation and fix it if necessary.

This change would come with a new chain variable *irregular_to_valid_ratio*.
- If set to 1 (its initial value), then each irregular witness would require a unique valid witness in order to become valid, as described above.
- If set to 0.5, each irregular witness would require two valid witnesses in order to be considered valid.
- If set to 2, each valid witness could balance two irregular witnesses.
- If set to 0, irregular witnesses would always be considered invalid.
- ⚠️ Setting it to a negative value should skip all the technical changes introduced in this HIP, allowing the network to easily revert back to the state it was before this HIP was implemented, if required (for testing or fixing bugs for example).

This chain variable could then be modified through future HIP to fit the needs of the people's network.

Example :

- Beacon's IP  : A
- Witness 1 IP : A
- Witness 2 IP : A
- Witness 3 IP : B
- Witness 4 IP : B
- Witness 5 IP : C
- Witness 6 IP : D
- Witness 7 IP : E

First, we tag these witnesses as either irregular, valid, or invalid :

- Beacon's IP  : A
- Witness 1 IP : A (irregular)
- Witness 2 IP : A (irregular)
- Witness 3 IP : B (irregular)
- Witness 4 IP : B (irregular)
- Witness 5 IP : C (valid)
- Witness 6 IP : D (valid)
- Witness 7 IP : E (invalid, too close to the beacon)

Then we check if the chain variable *irregular_to_valid_ratio* is negative. If it is, all irregular witnesses that are not yet considered invalid are marked as valid. This is the network's behavior before this HIP is implemented.
Making this check at this stage allows hotspots to still be marked as irregular on the explorer, thus informing their owner.

Otherwise, we multiply the number of valid witnesses (2) by the value of the global variable *irregular_to_valid_ratio* (initially 1) ;
2 * 1 = 2 👩‍🏫
This gives us the number of irregular witnesses that can be randomly selected to be considered valid :

- Beacon's IP  : A
- Witness 1 IP : A (irregular, valid)
- Witness 2 IP : A (irregular, invalid)
- Witness 3 IP : B (irregular, invalid)
- Witness 4 IP : B (irregular, valid)
- Witness 5 IP : C (valid)
- Witness 6 IP : D (valid)
- Witness 7 IP : E (invalid, too close to the beacon)

With the initial value of the chain variable, if there were more valid witnesses than irregular witnesses (as it should be in most legit cases), then all irregular witnesses would be considered valid.

~

*"irregular" can be changed to "redundant" or "suspicious".*

# Drawbacks
[drawbacks]: #drawbacks

Despite all precautions introduced with the irregular status balancing mechanic, and despite the fact that solutions exist for affected miners (changing IP, changing location, adding new hotspots), it is still technically possible that some legit hotspots witnessing each other and sharing the same IP might have no solution to fix or balance their irregular status. Preventing people from cheating the system at the cost of a few honest isolated miners losing their rewards might be considered unfair by some.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

A simpler design would have been to simply invalidate witnesses with the same IP as the beacon. This, however, would have had a much bigger impact on honest miners sharing the same IP. This HIP aims to reduce that impact to a minimum, while still affecting as many spoofers as possible.

Other ideas which involve GPS tracking are both too complex to implement and too easily cheated.

The impact of not implementing this HIP would be a gradual decrease in rewards for honest miners, and therefore also a decrease of the spread of the network's coverage, as well as a decline in the reputation of the Helium network as spoofers keep filling their pockets cheating the system.

# Unresolved Questions
[unresolved]: #unresolved-questions

- Are honest miners who happen to share their IP address with others sufficiently protected by all the precautions introduced in this HIP ?

- Are there cases of honest miners being poorly affected by this HIP that were not thought of ?

- Will this be enough to prevent spoofing ?

# Deployment Impact
[deployment-impact]: #deployment-impact

Who will it affect, and how ?

✓ Spoofers, who will lose most if not all of their rewards

✓ Legit hotspot owners, who will see their rewards increasing

✓ Hotspot buyers. As spoofers realize they don't make enough money, if at all, they will sell their now useless miners. Thousands of miners hitting the market at once should drive the prices of hotspots down.

× Hotspot sellers, for the reason stated above.


× Hotspot owners putting their legitimately spread hotspots on the same IP through a VPN for practical reasons. Although these are quite rare, I've heard that they exist, and therefore matter. These would have to find another way for the benefit of the network.

× Widely spread hotspots' owners using CGNAT connections sharing the same IP. Having access to a variety of witnesses should suffice in most cases, as irregular witnesses caused by CGNAT should be balanced by nearby valid witnesses. But there might be a few cases of CGNAT connected hotspots mostly witnessing other CGNAT connected hotspots with the same IP, without enough valid witnesses to balance their irregular status. As the irregular status is visible on the explorer, owners would realize the issue and could consider moving their hotspot to another location, changing their IP, or encourage new hotspots to cover their area, thus enabling their irregular status to be balanced (and spreading the coverage of the network as a consequence, which is what Proof of Coverage is all about).

× Legitimately spread hotspots sharing the same connection. Hotspots can be 300+ meters appart while still sharing the same connection. Much like in the case described above, having access to a variety of valid witnesses should be enough to balance their irregular status. Again, in the few cases where it is not possible, the visible irregular status on the explorer could tell these hotspots' owners to either change their connection, change their location, or encourage the birth of new hotspots in their area.

This change is backwards compatible. A single change to the chain variable *irregular_to_valid_ratio* is all it takes to revert it entirely.

# Success Metrics
[success-metrics]: #success-metrics

- Rewards of hotspots on the denylist decreasing

- Rewards of other known spoofed hotspots decreasing

- Number of spoofed hotspots decreasing, as these are sold to honest users and become legit

- Number of hotspots with IP in different country than their location decreasing

- Number of hotspots witnessing hotspots with the same IP decreasing

- Legit hotspots' rewards increasing

- Hotspots' retail prices decreasing

- People sharing their respectful spoofing-related criticism on Reddit decreasing
