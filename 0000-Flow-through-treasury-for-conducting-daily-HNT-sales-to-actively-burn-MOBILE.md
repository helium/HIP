# HIP ####: Flow Through Treasury that Conducts Daily HNT Auctions for MOBILE Burning to Increase Investment in the MOBILE Network

- Author(s): incrementis7
- Start Date: 2024-11-06
- Category: Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veMOBILE Holders

## Summary

The proposal is to use the emissions of HNT into the MOBILE treasury for automated daily auctions. The daily automated auctions sell HNT for MOBILE. All MOBILE purchased by the treasury in this way are subsequently burned. The proposed volume of the daily auctions is 100% of the HNT emissions from the most recent epoch and a portion (e.g., 0.25%) of the total remaining treasury account.  

## Motivation

The fundamental motivation is to improve and maintain the growth prospects of the MOBILE network by actively burning MOBILE using HNT in the treasury and daily emissions of HNT. Thie intent is to spur network growth by increasing the incentives for builders to build.

The Helium MOBILE treasury currently follows a ‘floor-price’ model for pricing MOBILE to Helium Network Token (HNT) redemption. The ‘floor-price’ model is the source of many problems for MOBILE tokenomics. The problems include the implied pessimism problem, the supply ossification problem, and the treasury raiders problem. These problems lead to chronic under-investment in MOBILE network infrastructure. This under-investment blunts growth of both MOBILE and HNT. The problems can be solved by transitioning the MOBILE treasury to a ‘flow-through’ model. In a ‘flow-through’ model the treasury performs market burns of MOBILE daily using the daily HNT emissions. Such a change would spur explosive growth in both MOBILE and HNT.


## Stakeholders

- The primary stakeholders include all MOBILE token holders and MOBILE token earners.
- Since this HIP includes the selling of HNT from the treasury, HNT holders may also be affected. Concerns from HNT holders regarding the scale of HNT sales have influenced discussions about treasury run-off volumes. 

## Detailed Explanation

This HIP involves using HNT from the MOBILE treasury to buy MOBILE through daily auctions. Any MOBILE purchased is to be immediately burnt.

The proposed volume of HNT to be sold in the daily auctions is [100% of the daily emissions of HNT to the MOBILE treasury from the previous epoch] plus [a portion of the treasury reserve]. 

The proposed portion of the treasury reserve to be included in the daily HNT auction is the lesser of [0.25% of the treasury balance or 5x the previous day DC burn by MOBILE]. This provision is to control the speed at which HNT is sold from the treasury thereby mitigating risks to HNT price.

It is further proposed that the auctions are conducted with a reserve price equal to 3*[(HNT emitted to MOBILE treasury in last epoch} / (MOBILE added to total supply)]. This provision is to avoid spending down the treasury when the market has a very high price of MOBILE relative to HNT.

## Implementation



## Drawbacks

-	Risk to HNT price due to selling HNT from the treasury. This issue is mitigated by controlling the daily rate at which treasury HNT are auctioned off. 
-	Risk of bad actors gaming the price when HNT are being sold off. Careful design should be able to avoid this problem. Using an auction style sale of the treasury HNT should avoid this problem. 


## Rationale and Alternatives

The ‘floor-price’ model currently used by the MOBILE treasury is holding back growth and investment in the MOBILE network. Furthermore, it opens up the network to significant risks from the intrinsic pessimism problem, the supply ossification problem, the the treasury raider problem. The ‘flow-through’ treasury management model described herein solves all these problems and would unleash a torrent of investment in the MOBILE network. The investment in the MOBILE network would spur growth for MOBILE and HNT.

### How the Legacy (HIP-53) Mobile Treasury Generally Works:

Each Epoch (day) a number of HNT are minted and distributed to HST holders (early investors and founders), the IOT treasury, and the MOBILE treasury. The percent of tokens to each recipient is determined in part by a utility score. The utility score is based at least partially on how much DC is spent through each of the networks.

HIP-53 created MOBILE as a subDAO and defined the initial treasury management scheme. Each day the MOBILE treasury defines a redemption price (floor price) at which MOBILE can be redeemed. A redemption allows users to exchange MOBILE for HNT, the HNT provided from the treasury. Any MOBILE redeemed to the treasury are burned. The price set for MOBILE to HNT redemption is defined in HIP-53 as:

![image](https://github.com/user-attachments/assets/b0566eb7-a538-4e2c-88c8-d11a826db7e3)

HIP-53 defines the redemption price as the number of HNT in the treasury divided by the total MOBILE supply.

Here is a figure to show how this all fits together. Please look over the diagram. Legacy (HIP-53) ‘floor-price’ treasury management leads to some important problems. These problems will tend the network towards under-investment. The problems are laid out below the figure.

![image](https://github.com/user-attachments/assets/055fd7e0-dcc0-45f7-b8f1-0a7a480d7503)

MOBILE tokenomics diagram with legacy (HIP-53) ‘floor-price’ treasury management.

The ‘floor-price’ model for treasury management is flawed. Fortunately HIP-53 specifically explained that MOBILE holders are responsible for how treasury management works and are free to change it. It is proposed that a ‘flow-through’ treasury model be adopted to replace the legacy ‘floor-price’ model.

### How a Proposed Flow-Through Treasury Generally Works:

In a ‘flow-through’ treasury the daily emissions of HNT to the treasury would be immediately used to perform daily ~market burns of MOBILE. This would mean that each day all the HNT emitted to the treasury are used to buy MOBILE at the prevailing price. The means of the purchase is still to be finalized. All MOBILE purchased in this way is burnt. This would immediately communicate the value of the MOBILE network to the market. The market would price in the value of the daily burns. This would raise the price of MOBILE and therefore increase the incentive to mine it (via network participation) leading to a virtuous cycle for MOBILE and HNT. Furthermore, the currently accumulated HNT in the treasury should be gradually run-off to facilitate additional daily burns. The run-off rate should be around 0.1–1% of treasury holdings daily.

Daily emissions of HNT to the MOBILE treasury in November 2024 are running at around 20,000 HNT daily. The treasury in November 2024 holds around 7,000,000 HNT. HNT price is around $6.50 USD. Therefore, adopting this approach would mean daily MOBILE burns worth around (assuming an example run-off rate of 0.5% daily) (7,000,000*0.005 + 20,000)*$6.50 = $357,500. At the market MOBILE price on November 1, 2024 of around $0.0007 this would be a burn rate of 500,000,000 MOBILE per DAY! Equating to around 0.5% of total MOBILE supply per day. Currently the market is failing to price in how much potential MOBILE burn is available.

![image](https://github.com/user-attachments/assets/3daad164-f59d-44ac-9be0-b63e01445690)

MOBILE tokenomics diagram with proposed ‘flow-through’ treasury management.

### Problems Created by ‘Floor Price’ Treasury Management artificially hold MOBILE price down and lead to under-investment in the MOBILE network

#### Intrinsic Pessimism Problem:

When the treasury uses the floor price model, the demand signal from the treasury always signals pessimism about the growth prospects of the network. Logically, the value of a MOBILE token can be expressed as the sum of the ‘Floor-price’ defined above plus the value of future HNT emissions to the treasury that the MOBILE token is entitled to.

![image](https://github.com/user-attachments/assets/b7264486-7e58-443b-a279-b37a911f53c4)

Which can be rewritten more precisely as:

![image](https://github.com/user-attachments/assets/3da43b99-144b-489c-bd55-6bbfd58b1140)

Expanded math and proof that delta floor price [i] is always positive are provided in the appendix of the previously circulated medium article. Based on the delta floor price always being positive it is known that the Value of future emissions to which a MOBILE token is entitled is also always positive. Therefore the ‘floor-price’ treasury always under-values MOBILE because it assumes future emissions have no value.

That is to say, implicit in the ‘floor price’ model is that the value to each MOBILE token of future emissions is zero. Not only is this obviously false, it is also self defeating because it leads to under-investment. The ‘floor-price’ model prevents the market from properly pricing MOBILE since it cuts off the feedback loop between the treasury income (i.e. HNT emissions) and the market price of MOBILE.

This problem would not exist if MOBILE used a ‘flow-through’ treasury model. In a ‘flow-through’ treasury the price is determined by market forces including the value of daily emissions of HNT to the MOBILE treasury. The ‘flow-through’ treasury makes no assumptions about the fair value of MOBILE.

#### Supply Ossification problem:

The ‘floor price’ treasury ensures that unless growth goes negative, burning of MOBILE by the treasury is unlikely (the ‘floor-price’ is always under-priced as explained above) and therefore MOBILE will not be burned in substantial amounts unless the network is shrinking. The result is that an ever-greater proportion of MOBILE is not recently mined. That is to say, the proportion of MOBILE going to miners versus the amount of MOBILE held will drop. This will become all the more true once the next halvening occurs.

All the revenue (e.g., DC burn) is generated by the miners, but their rewards keep dropping as the profits (HNT emissions) are split between all token holders. This will gradually erode value going to miners and therefore miners will start dropping out starting a destructive end to the network. Token burns solve this problem, since each burn increases the ratio of newly issued tokens to previously issued tokens. However, ‘floor price’ burns are insufficient because, as noted above, the floor price is always less than the Value (i.e. fair price) of MOBILE.

Switching to a ‘flow-through’ treasury solves this problem because it would introduce daily burns at the market price of MOBILE. This would introduce a consistent reduction in MOBILE supply. Since new emissions are fixed this would increase the ratio between newly minted MOBILE and already minted MOBILE and reduce/eliminate the supply ossification problem. Furthermore it would increase the price of MOBILE thereby incentivizing new participants to join the MOBILE network.

#### Treasury Raiders Problem:

When the MOBILE treasury has >0 balance the current holders of MOBILE have an incentive to issue all treasury HNT proportionally to themselves. This incentive increases as the treasury accumulates HNT. If MOBILE holders did this they would be entitled to all the current treasury HNT and would not need to share the treasury with future token holders (i.e. miners). Still the current holders would maintain a claim to future emissions.

However, doing so would dramatically undermine the value of future MOBILE emissions to miners. If a raid ever happens the incentive to mine will drop dramatically and the network will implode. Thus, the floor price model management of the treasury creates an incentive for MOBILE holders to raid the treasury and destroy the network. The more value the treasury builds up, the greater the incentive to conduct a treasury raid becomes.

As proposed in the ‘flow-through’ treasury, proactively spending the HNT in the treasury to burn MOBILE tokens would eliminate this problem. Furthermore, using future HNT emissions to the treasury for daily burns of MOBILE would prevent this problem from arising again. Both these actions would also support network growth.

## Unresolved Questions

-	The reserve price if any.
-	The rate at which to draw down the treasury. 
-	The details of how to technically conduct the auctions. 

## Deployment Impact

-	This HIP will decrease the supply of MOBILE, increase the price of MOBILE, and support the growth of the network. Current and future builders will have an increased incentive to build. 
-	Documentation regarding MOBILE treasury management will need to be updated. 
-	Undoing this HIP would require reverting the treasury management technique. Of course, any spent HNT would remain spent, and burnt MOBILE would stay burnt. 

## Success Metrics

An indicator of success would be an increase in the rate of hotspot deployment. However, conclusive measurement showing a causal connection between the rate of hotspot deployment and this HIP will be difficult to quantify. 
