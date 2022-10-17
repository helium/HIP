# HIP62: PoC Witness IP Check

- Author(s): [@H-Baguette](https://github.com/h-baguette)
- Start Date: 2022-05-24
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/414>
- Tracking Issue: <https://github.com/helium/HIP/issues/422>

# Summary

Prevent spoofing by checking each witness's IP address against the beacon's IP address and other witnesses' IP addresses, while still allowing witnesses sharing the same IP address as the beacon to be considered valid under specific yet rather accessible conditions.
Additionally, prevent spoofing farms from hiding a miner's IP behind a VPN by heavily restricting the use of VPNs on Helium hotspots.

# Motivation

Spoofed hotposts steal a share of honest hotspot owners by cheating the system, and thus disincentivise the spread of the network by new and existing users. This also poorly affects the reputation of the Helium network.
This HIP aims to solve both of these problems.

# Stakeholders

- All hotspot owners are affected by this proposal (those using a VPN moreso than others)

# Detailed Explanation

- # IP checking

**irregular** : A witness is considered irregular if it shares its IP address with either the beacon or another witness of that beacon.

**balanced** : An irregular witness is balanced when the presence of a valid witness for the same beacon allows it to be considered valid itself.

A witness sharing its IP with the beacon it is witnessing OR with another witness of the beacon it is witnessing is considered
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

- # VPN restrictions

IP checking can be a powerful tool against spoofing. However, on its own, this solution comes with a major weakness. Indeed, spoofing farms can easily hide their miners behind VPNs, allowing them to show different IPs while still being connected to the same internet connection. This proposal thus comes with a second part, focused around the restriction of VPN usage.

Prior to the light hotspot update, many hotspots owners were *required* to use a VPN in order to open their 44158 port. Restricting the use of VPNs back then was therefore absolutely out of the question.
The light hotspot update removed this necessity entirely, as port forwarding is no longer required, making VPN restrictions a viable solution.

In addition to checking whether a hotspot shares its IP with another hotspot within the same beaconing event, a hotspot's IP should be checked against its alleged location on the explorer. If a witness's IP's **country** does not match the registered location on the explorer, then that witness must be invalidated.

- # Example

- Beacon's IP  : A
- Witness 1 IP : A
- Witness 2 IP : A
- Witness 3 IP : B
- Witness 4 IP : B
- Witness 5 IP : C
- Witness 6 IP : D
- Witness 7 IP : E
- Witness 8 IP : F

First, we tag these witnesses as either irregular, valid, or invalid :

- Beacon's IP  : A
- Witness 1 IP : A (irregular)
- Witness 2 IP : A (irregular)
- Witness 3 IP : B (irregular)
- Witness 4 IP : B (irregular)
- Witness 5 IP : C (valid)
- Witness 6 IP : D (valid)
- Witness 7 IP : E (invalid, too close to the beacon)
- Witness 8 IP : F (invalid, IP is in a different country than the hotspot's registered location)

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
- Witness 8 IP : F (invalid, IP is in a different country than the hotspot's registered location)

With the initial value of the chain variable, if there were more valid witnesses than irregular witnesses (as it should be in most legit cases), then all irregular witnesses would be considered valid.

~

*"irregular" can be changed to "redundant" or "suspicious".*

# Drawbacks

Despite all precautions introduced with the irregular status balancing mechanic, and despite the fact that solutions exist for affected miners (changing IP, changing location, adding new hotspots), it is still technically possible that some legit hotspots witnessing each other and sharing the same IP might have no solution to fix or balance their irregular status. Preventing people from cheating the system at the cost of a few honest isolated miners losing their rewards might be considered unfair by some.
Additionally, some people (namely in the US) feel obligated to use a VPN in order to hide their mining activity from their internet provider. Some internet providers forbid the use of their connection for business-related purposes. Hotspot owners affected by this might need to find alternative solutions, like changing their internet provider, upgrading to a plan allowing business-related usage, or checking their local law to ensure that mining HNT does not fall in the business category.

# Rationale and Alternatives

A simpler design would have been to simply invalidate witnesses with the same IP as the beacon. This, however, would have had a much bigger impact on honest miners sharing the same IP. This HIP aims to reduce that impact to a minimum, while still affecting as many spoofers as possible.

Other ideas which involve GPS tracking are both too complex to implement and too easily cheated.

The impact of not implementing this HIP would be a gradual decrease in rewards for honest miners, and therefore also a decrease of the spread of the network's coverage, as well as a decline in the reputation of the Helium network as spoofers keep filling their pockets cheating the system.

Regarding VPN restrictions, another, more restricting method, would be to check the distance between the IP's estimated location and the hotspot's location on the explorer, and invalidate the witness if the distance is greater than a fixed value, say 100km. However, this is highly imperfect, as locating a device solely on its IP is far from being precise. Additionally, CGNAT connections would result in constantly invalid witnesses, as the IP could direct to a location hundreds of kilometers away from the hotspot, even though it is neither spoofing or using a VPN. Checking only the country greatly limits the risk of wrongfully invalidating witnesses, while still impacting spoofing farms.

# Unresolved Questions

- Are honest miners who happen to share their IP address with others sufficiently protected by all the precautions introduced in this HIP ?

- Are there cases of honest miners being poorly affected by this HIP that were not thought of ?

- Will this be enough to prevent spoofing ? Could spoofing farms still use VPNs while conforming to this proposal's requirements ?

- Is it acceptable to combat spoofing at the cost of possibliy penalizing a few honest miners that don't fall within the precautions introduced in this proposal ?

- How could we better restrict VPNs without risking honest miners losing their rewards, especially CGNAT connections ?

# Deployment Impact

Who will it affect, and how ?

✓ Spoofers, who will lose most if not all of their rewards

✓ Legit hotspot owners, who will see their rewards increasing

× Hotspot owners putting their legitimately spread hotspots on the same IP through a VPN for practical reasons. Although these are quite rare, I've heard that they exist, and therefore matter. These would have to find another way for the benefit of the network.

× Widely spread hotspots' owners using CGNAT connections sharing the same IP. Having access to a variety of witnesses should suffice in most cases, as irregular witnesses caused by CGNAT should be balanced by nearby valid witnesses. But there might be a few cases of CGNAT connected hotspots mostly witnessing other CGNAT connected hotspots with the same IP, without enough valid witnesses to balance their irregular status. As the irregular status is visible on the explorer, owners would realize the issue and could consider moving their hotspot to another location, changing their IP, or encourage new hotspots to cover their area, thus enabling their irregular status to be balanced (and spreading the coverage of the network as a consequence, which is what Proof of Coverage is all about).

× Legitimately spread hotspots sharing the same connection. Hotspots can be 300+ meters appart while still sharing the same connection. Much like in the case described above, having access to a variety of valid witnesses should be enough to balance their irregular status. Again, in the few cases where it is not possible, the visible irregular status on the explorer could tell these hotspots' owners to either change their connection, change their location, or encourage the birth of new hotspots in their area.

× Hotspot owners using a VPN to hide their mining activity from their internet service provider. They would first have to check whether mimning HNT really is forbidden. If it is not, then the use of a VPN would no longer be required. Otherwise, they would have to either upgrade to a plan allowing HNT mining, or change their internet service provider altogether.

This change is entirely backwards compatible.

# Success Metrics

- Rewards of hotspots on the denylist decreasing

- Rewards of other known spoofed hotspots decreasing

- Number of hotspots with IP in different country than their location decreasing

- Legit hotspots' rewards increasing

- People sharing their respectful spoofing-related criticism on Reddit decreasing
