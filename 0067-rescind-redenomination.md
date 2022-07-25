# HIP67: Rescind Redenomination

- Author(s): [@edballou](https://github.com/edballou)
- Start Date: 2022-06-20
- Category: Economic
- Original HIP PR: [https://github.com/helium/HIP/pull/XXX](https://github.com/helium/HIP/pull/XXX)
- Tracking Issue: [https://github.com/helium/HIP/issues/XXX](https://github.com/helium/HIP/issues/XXX)

# Summary

First and foremost, this HIP acknowledges the community's vote in favor of [HIP-39 Redenomination](https://github.com/helium/HIP/blob/main/0039-hnt-redenomination.md). Since then, the community has passed HIP 51, which solves some of the central issues motivating HIP 39 (Incentive Unit Bias) through the introduction of subtokens. Since HIP39 was passed, additional complexities and complications have also come to light that have changed the difficulty and economic motivation to implement HIP39 on or before August 2022. We believe that it is no longer necessary to implement HIP 39 (Redenomination) at this time and propose to cancel HIP 39 if the community agrees.

As there was no timeline in HIP 39, the testing and proposed implementation took longer than expected while other economic HIPs were passed. To address the tension around this lag in implementation, HIPs 52 & 53 include a mandate that code must be included for the HIP to be voted on.

# Motivation

HIP 39’s authors stated three key motivations behind the introduction of HIP 39, some of which may be partially remedied by the subtokens introduced by HIPs 51-53:

1. Incentive Unit Bias
    
    The HIP 39 authors argued that, the massive growth in Helium LoRaWAN hotspot numbers and the resulting reduction of daily earnings to fractional amounts of HNT, hotspot operators were less content to earn part of a token rather than a whole token (actual value in bones or fiat aside). With the implementation of HIP 51, all new subDAOs will be able to set their token supply caps individually and can design their tokenomics with the incentive unit bias in mind going forward, since subDAO participant earnings are received as that subDAO’s token rather than HNT. HIP 52 (IoT subDAO) and HIP 52 (Mobile subDAO) already do this and use high subtoken max supply caps. HIP 52 proposes a max cap of 200 billion IOT tokens, and HIP 52 proposes a max cap of 250 billion MOBILE tokens.
    
2. Simplification of Unit Measurements
    
    The majority of Helium miners and subDAO participants will be primarily interacting with the subDAO tokens, so there is no longer as strong of a need to simplify HNT by redenominating it to a bigger number for most users. Data credit users and HNT holders may still benefit from the simplification of unit measurements by redenominating HNT.
    
3. Small $ Investment Bias
    
    The HIP 39 authors suggested that tokens priced at low $ amounts were more appealing to the market and sought to attract market interest in HNT by redenominating HNT. This may still be a valid reason to redenominate HNT, though the subDAO tokens could attract market interest independently of HNT through this mechanism.
    

The implementation of HIP 39 requires significant core developer and Helium Foundation resources to coordinate and execute. I believe that these resources would be better spent on more network-critical tasks at the moment, especially since HIP 51 already solves some of the same challenges.

- Describe the known and unknown of economic conditions at the time of the vote and now
    - If token price falls below a certain threshold, some token pairs (example: HNT/BTC)  can be removed automatically from some exchanges. Recent market movements could have
    seen this happen.
- Describe what happened from a development perspective which demanded focus away from redenomination implementation
    - Finishing PoCv11, Light Hotspot implementation
- Describe why now is a better time to seek alternative methods for implementation of HIP 39 and how it will be done
    - The code is now written and has been for some time, it's just coordinating it to happen at the correct time.

# Stakeholders

- Nova Labs:
- Helium Foundation:
- Helium HIP39 Community discussion and voting participants in HIP39:
    - All previous interested parties who discussed or voted will have a stake in the previous decision and may or may not have changed their opinion on HIP39 after HIP51-53.
    - View conversation on HIP 39 here: [https://discord.com/channels/404106811252408320/892226716737634345](https://discord.com/channels/404106811252408320/892226716737634345)
- Exchanges:
    - Exchanges need to know if redenomination will take place to either implement or not implement HNT transfer lockdown periods to avoid possible unfair arbitrage opportunities on an envisaged redenomination date of Aug 1st 2022
- All HNT and HST token holders:
    - However much communication is undertaken a change in value will be noticed by more holders than those who have paid attention for the reason for the change in value.
- All Helium Oracle and Console operators:
    - Oracle and Console operators need to know any changes to validate the correct price of Data Transfer Tokens upon purchase

# Detailed Explanation

- [A] Known and unknown economic conditions
    1. When token prices fall below thresholds, exchanges can
    automatically or by choice, delist tokens. As our only viable means of
    investing in Helium and the current loss of 85% of top price since HIP
    39 was approved, this could have meant huge ramifications for $HNT or specifically crypto pairs as mentioned earlier.
- [B] Development roadmap headwinds
    1. PoCv11 set up necessary improvements to the network to
    address valid coverage, institutional & isolated gaming, and pave
    way for more Light Hotspot support.
    2. Light Hotspot support came at a crucial time when the
    network was struggling to stay up as the nodes and blockchain size
    became more unwieldy. Even still, some validators are struggling with
    proof of coverage analysis. It is expected that Light Hotspot support
    will continue, perhaps even toward upcoming offloading of proof of
    coverage validation.
    3. Referring back to [A.2], binding all development
    activities back to one token could cause unforeseen loss of integrity,
    gaming, etc. In order to nimbly implement omni-protocol support,
    developers need HIPs 51-53 to protect protocol-specific changes and
    eliminate abstraction overhead.
 - [C] Other economic HIPs in process
    1. HIP 51:
[https://github.com/helium/HIP/blob/main/0051-helium-dao.md#construction](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#construction)
    2. HIP 52:
[https://github.com/helium/HIP/blob/main/0052-iot-dao.md#emissions-curve](https://github.com/helium/HIP/blob/main/0052-iot-dao.md#emissions-curve)
    3. HIP 53:
[https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#emissions-curve](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#emissions-curve)

# Drawbacks

- This HIP would NOT solve the second motivation of Simplification of Unit Measurements for HNT, for HNT token transactions. But less transactions are expected of excessively small values HNT as smaller mining income is first stored in MOBILE and IOT tokens.
- This HIP would NOT solve the third motivation for Small $ Token Investment Bias for the HNT token as the HNT price would continue at the relatively high $ amount with less upside. But investors could invest in IOT or MOBILE if they desire to invest in Helium networks using small $ Tokens.

# Rationale and Alternatives

HIP39 had three key motivations behind an HNT redenomination and its proposed below how these three motivations are met by the activation of HIPs 51-53 and therefore reason that HIP39 can be rescinded.  

1. **Incentive Unit Bias** As covered in HIP39, In behavioral economics, the preference for obtaining full units (or completing full tasks) is called unit bias. In general, people prefer earning rewards denominated in full units rather than partial units. Currently in mid 2022 the average daily earnings in HNT for a hotspot gateway is below 0.1 HNT and is approaching 0.05 in 2023. With the HIP52 implementation the average daily earnings for a hotspot in IOT would be over 100 in 2023, and remaining as full units even after 7 years if the IOT Hotspot network continued to grow at its peak recent rate and accounting for token halvings.
    
         65B IOT distributed in Year 1 to estimated 1.5M hotspots = > 118 per day
    
    8.125B IOT distributed in Year 7 to estimated 5M hotspots = > 4 per day
    
    Thus the Incentive Unit Bias requirement of HIP39 is met with the MOBILE emissions curve implemented in HIP 52 as explorer and apps will change to show mining earnings of whole numbers in IOT not fractions of HNT.
    
    The task units per day for MOBILE are much higher with hotspot quantities in the low 000’s and the MOBILE emissions being twice that of IOT. So this motivation is also met for MOBILE Token.
    
    Hotspot gateway mining of HNT will no longer be possible so changing the Incentive Unit Bias for hotspot activity is now not applicable.
    
2. **Simplification of Unit Measurements:** This described the frustration and confusion when dealing with excessively small fractions which is currently the case when discussing average daily HNT rewards 0.x or 0.0x, and smaller witness rewards of 0.00x-0.000x with many leading zeros for decimal places that need to be typed accurately when discussed.
    
    With HIP52 and HIP53 hotspots will be earning with IOT and MOBILE which as mentioned above will be in full unit numbers as daily figures for several years, so will negate any frustration and confusion dealing with smaller and smaller fractions.
    
3. **Small $ Token Investment Bias:** This was stated in HIP39 as lower price tokens are perceived to have more upside than higher dollar tokens. The IOT and MOBILE tokens will have a higher issuance than HNT and thus have an “inexpensive” lower $ amount for those who value this possible upside. 
    
    The total token emissions for HNT are less than 223 Million with a burn and mint process using Data Credits that means the total number of HNT Tokens can get lower but never higher.
    
    - IOT (HIP52) has an issuance of 200 Billion Tokens
    - MOBILE (HIP53) has an issuance of 250 Billion Tokens
    - HWIFI (HIP64) has an issuance of 250 Billion Tokens
    
    All the new tokens therefore roughly meet the scale of the 1000:1 HNT denomination proposal in HIP39. And as the new tokens share the issuance of HNT to all subDAOs this ratio will be greater than 1000:1.
    
    Both IOT and MOBILE will be able to be traded on platforms outside the Helium wallet along with HNT and will not be fixed price linked with HNT or each other and follow their own upside. IOT and MOBILE can be exchanged within the Helium Wallet for higher value HNT tokens and will continue to be traded on platforms outside the Helium Wallet.
    

A further reason for not implementing HIP39 as it is described is that HIP39 is not aware of the new tokens and subDAOs implemented in HIP51 and later subDAOs treasuries and so new technical, economic and governance issues created from this HIP implementation are not addressed or considered within HIP39.  

The development work on implementing HIP39, other later HIPs and the changes in responsibility between Nova and the Helium Foundation has indicated additional stakeholders would be affected. These include but are not limited to, subDAO treasuries, Oracle operators, Console operators, Token Exchanges and Helium community application creators.

If redenomination of HNT specifically is still required it is proposed that a new HIP should be created that references the newer tokens and subDAOs and the impact of technical, economic and governance changes this new HIP would have on all Tokens and subDAOs including Data Credit Tokens and the additional stakeholders.

### Alternatives

- HIP 39 could still be moved forward and implemented or pushed to a later specific date. Pushing the implementation date out further would mean additional development work and resources required from Nova that could be better deployed in implementing other HIPs. HIP 39 would need to be updated to consider additional stakeholders and impact on other Tokens an subDAOs.
- An alternative would be to do nothing at present but market entities such as exchanges that buy and sell would need to know if/when a date will be set as they have to undertake effort at their cost to implement denomination. Market confidence in the ability of Helium to set a token roadmap could be undermined if no decision date is set.

### Unresolved Questions

- Could a further HIP be created to implement a small or bigger scope of HIP 39?

# Deployment Impact

- The code written to implement HIP 39 will not be activated but will still be present
- The chain variable to redefine the number of bones will not be changed
- Crypto Exchanges and Hard Wallets will not interrupt their operations to redenominate HNT held on their wallets.

# Success Metrics

- HIP 39 is closed and the discord discussion channel archived
- HIP XX is closed
