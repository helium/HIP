# HIP 39: HNT Redenomination

- Author: @JMF
- Start Date: September 14, 2021
- Category: Economic
- Original PR: <https://github.com/helium/HIP/pull/275>
- Tracking Issue: <https://github.com/helium/HIP/issues/283>
- Status: In Discussion

## ​​Summary

This proposal suggests a redenomination of the conversion rate between bones and HNT. Currently there are 100,000,000 (10^8) bones per HNT and under the proposed redenomination the conversion rate would be adjusted to 100,000 (10^5) bones per HNT.

## Background/ Motivation

Stock splits have a long history in the traditional equity markets and are typically used to make stock ownership more accessible to smaller scale investors. They also have a reputation for having a positive price impact on stocks leading up to and after the split. In the cryptocurrency market, splits have mostly been replaced with ‘redenominations’, which means that the conversion between some higher level unit of measurement (HNT in this case) and lower level unit of measurement (bones) is adjusted.

There are three key motivations behind an HNT redenomination:

1. **Incentive Unit Bias:** For most of Helium’s history gateway owners have enjoyed earning mining rewards in excess of 1 HNT per day (historically much higher), but with the HIP-20 halving and a 10 fold-plus increase in gateway deployments in 2021 those earnings have been reduced to partial fractions of an HNT. Even though the market price of HNT has increased approximately 20X since August 2020 and the median $ earnings per hotspot has remained generally consistent, there has been growing discontent with the HNT earning rate. In behavioral economics, the preference for obtaining full units (or completing full tasks) is called unit bias. In general, people prefer earning rewards denominated in full units rather than partial units. As we have seen in Helium, there were very few complaints when gateway owners were earning more HNT at a lower $ daily mining rate than when they were earning partial HNT at a higher daily $ rate. The redenomination would cause individuals to earn in higher HNT increments again, even if $ earnings stayed the same.

2. **Simplification of Unit Measurements:** Anyone that has mined or transacted in BTC or ETH has dealt with earning extremely small fractions of units. This can be frustrating and cause confusion when dealing with excessively small fractions (often denominated in thousandths of a unit). A redenomination would make transactions using HNT more digestible, by decreasing the decimal places needed in the majority of transactions.

3. **Small $ Token Investment Bias:** Tokens that are priced at a low $ amount are typically seen by the market as ‘inexpensive’ regardless of the size of the project's market cap. In general high issuance tokens have benefited from this investment bias because the tokens are perceived to have more upside than higher dollar tokens. Typically, this equates to a higher overall market cap for projects and, in the case of Helium, could help increase the incentive rewards, not only in terms of HNT but also $s per gateway.

## Stakeholders

All HNT holders, hotspot owners, and HST holders will be affected by this HIP.

## Detailed Explanation

At the time of the redenomination the conversion between bones and HNT would be adjusted from 100,000,000 (10^8) bones per 1 HNT to 100,000 (10^5) bones per 1 HNT. In other words, if someone were mining 1 HNT per day with a hotspot, they would now mine 1,000 HNT per day. What’s critically important is that the number of**bones** in the system would remain unchanged.

Let’s take the example above and look at it in terms of bones:

Pre-redenomination: 1 HNT per day per hotspot x 100,000,000 bones per HNT = 100,000,000 bones per day per hotspot

Post-redenomination: 1,000 HNT per day per hotspot x 100,000 bones per HNT = 100,000,000 bones per day per hotspot

The significant advantage of a redenomination vs a ‘split’ in which new tokens are created, is that most systems that interact with the blockchain already account for transactions in terms of bones; not HNT. As a result, the adjustment should not ‘break’ most systems.

A redenomination adjustment of 10^3 (1000:1) bones per HNT was chosen because it is significant enough to benefit all three of the aforementioned motivations:

1. **Incentive Unit Bias:** At the time of writing (September 2021), most gateways are earning between 0.1 HNT and 0.5 HNT per day, meaning that post redenomination they would earn between 100 and 500 HNT per day. While that may seem excessive, we can safely assume that there will be in excess of three million gateways online in the next two years, which would, in conjunction with the second halving, bring post redenomination mining down to 2.5 to 7.5 HNT per day. If we were to do a smaller redenomination of 100:1 (10^8 down to 10^6) we would likely fall below 1 HNT per gateway per day prior to the time of the second halving (~August 2023). While it is impossible to fend off sub 1 HNT daily gateway rewards forever with a redenomination, this gives the network multiple years to develop a strong base of DC burn prior to unit bias coming into play again. Ideally, at that point the DC burn would support a significantly higher HNT price point and the impact of unit bias would be diminished.

2. **Simplification of Unit Measurements:** In line with the above, most HNT transactions would be handled without needing to count out an excessive number of decimal points. For example, if HNT’s price reached $100 with the current setup (equivalent to $0.10 post redenomination), buying 1,000 DCs would equate to 0.0001 HNT vs costing 0.1 HNT post redenomination.

3. **Small $ Token Investment Bias:** Tokens with a price point sub $1 have long benefited from the perception of being ‘inexpensive’. Whether this perception is rational or not, the impact on market cap has been consistently positive. An HNT price point of $1,000.00 under the current system would be equivalent to an HNT price point of $1.00 under the redenominated system. The jump from $20 to $1,000 is typically **perceived** as being greater than the jump from $0.02 to $1.00, leading to the belief that there is more upside in the latter.

It is important to note that the benefit of an increase in market cap is not solely to benefit existing token holders. More importantly, an increase in market cap translates to an increase in the amount of funding available to grow the network. It is well understood that the network will need a considerable amount of funding from the market to develop into a ubiquitous, multinational, omni-protocol system. Maintaining strong incentives will be vital over the next few years, while HNT earning rates steadily decline and until there is significant growth in the amount of DCs burned through legitimate wireless network data transfers. Eventually, the expectation is that the ‘revenue’ going into the system in the form of DC burn will be sufficient to maintain and grow the network, but until then, anything that derisks and/or increases the network incentives will increase the likelihood of eventual success.

## Drawbacks

The recent renominations of DOT (July/August 2020) and XEC (July 2021) have been accompanied by significant increases in market cap, and while correlation does not always equal causation, the consistency of the positive price impact on crypto-projects along with the history of price increases related to stock splits in traditional equity markets__indicates that a redenomination is more likely than not to increase market cap. That being said, the measure will be seen by some as being a ‘gimmick’ to increase market cap. Thankfully, that perception is likely to be short-lived as most individuals have a short memory of splits or redenominations once the ‘new’ system is implemented.

Another potential issue involves systems that use measurements in terms of HNT instead of bones. There could be a period when certain systems are confused by the updated relationship between HNT and bones, but there are measures that can be taken to reduce this issue, including messaging the change publicly and prior to implementation. Measures will need to be taken to communicate the change with exchanges, coin tracking systems, and crypto tax systems to minimize any negative impacts.

## Implementation

The redenomination would be implemented as a new chain variable. The Bones:HNT chain variable would be the source of truth for the conversion rate between the two units of measurement. This would also help avoid typos related to the number of “0”s in code, which has occasionally been an issue in the past.
