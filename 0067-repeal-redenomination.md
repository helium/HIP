# HIP 67: Repeal Redenomination

- Author(s): [@edballou](https://github.com/edballou)
- Start Date: 2022-06-20
- Category: Economic
- Original HIP PR: <https://github.com/helium/HIP/pull/455>
- Tracking Issue: <https://github.com/helium/HIP/issues/456>
- Status: In Discussion

# Summary

First and foremost, this HIP acknowledges the community's vote in favor of [HIP-39 Redenomination](https://github.com/helium/HIP/blob/main/0039-hnt-redenomination.md). Since then, the community has passed [HIP 51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md), which solves some of the central issues motivating HIP 39 (Incentive Unit Bias) through the introduction of subtokens. Since HIP39 was passed, additional complexities and complications have also come to light that have changed the difficulty and economic motivation to implement HIP39 on or before August 2022. We believe that it is no longer necessary to implement HIP 39 (Redenomination) at this time and propose to cancel HIP 39 if the community agrees.

As there was no timeline in HIP 39, the testing and proposed implementation took longer than expected while other economic HIPs were passed. To address the tension around this lag in implementation, [HIP 52](https://github.com/helium/HIP/blob/main/0052-iot-dao.md) and [HIP 53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) include a mandate that code must be included in order for the HIP to be voted on.

# Motivation

HIP 39’s authors stated three key motivations behind the introduction of HIP 39, some of which may be partially remedied by the subtokens introduced by HIPs 51-53:

1. Incentive Unit Bias

    The HIP 39 authors argued that, the massive growth in Helium LoRaWAN hotspot numbers and the resulting reduction of daily earnings to fractional amounts of HNT, hotspot operators were less content to earn part of a token rather than a whole token (actual value in bones or fiat aside). With the implementation of HIP 51, all new subDAOs will be able to set their token supply caps individually and can design their tokenomics with the incentive unit bias in mind going forward, since subDAO participant earnings are received as that subDAO’s token rather than HNT. HIP 52 (IoT subDAO) and HIP 52 (Mobile subDAO) already do this and use high subtoken max supply caps. HIP 52 proposes a max cap of 200 billion IOT tokens, and HIP 52 proposes a max cap of 250 billion MOBILE tokens.

2. Simplification of Unit Measurements

    HIP 39 aimed to address the frustration and confusion when dealing with excessively small fractions which is currently the case when discussing average daily HNT rewards 0.x or 0.0x, and smaller witness rewards of 0.00x-0.000x with many leading zeros for decimal places that need to be typed accurately when discussed. The majority of Helium miners and subDAO participants, however, will be primarily interacting with the subDAO tokens, so there is no longer as strong of a need to simplify HNT by redenominating it to a bigger number for most users. Data credit users and HNT holders may still benefit from the simplification of unit measurements by redenominating HNT.

3. Small $ Investment Bias

    The HIP 39 authors suggested that tokens priced at low $ amounts were more appealing to the market and sought to attract market interest in HNT by redenominating HNT. This may still be a valid reason to redenominate HNT, though the subDAO tokens could attract market interest independently of HNT through this mechanism.

The implementation of HIP 39 requires significant core developer and Helium Foundation resources to coordinate and execute. In addition to the development work required from the core developers and the Helium Foundation to implement redenomination, significant effort is also required to coordinate these changes across all parties interacting with HNT. These include but are not limited to: subDAO treasuries, Oracle operators, Console operators, Data Credit users, wallet providers, token exchanges, asset custodians, and Helium community application creators. It is proposed that these resources be spent on more network-critical tasks at the moment, especially since HIP 51 already solves some of the same challenges.

# Stakeholders

This HIP affects all users and entities who hold or interact with HNT. Since it seeks to revoke HIP 39 and maintain the current rate of 10^8 bones to per 1 HNT, users and stakeholders will not need to take any action.

# Drawbacks

- The existing HIPs 51-53 do not fully resolve the second motivation of “Simplification of Unit Measurements for HNT” for HNT token transactions, but does reduce the problem. Fewer transactions are expected of excessively small values HNT as smaller mining income is first stored in MOBILE and IOT tokens. Mining participants will primarily directly interact with the MOBILE and IOT tokens rather than HNT.
- HIPs 51-53 do not resolve the third motivation of “Small $ Token Investment Bias” for the HNT token as the HNT price would continue at the relatively high $ amount.

# Deployment Impact

- The code written to implement HIP 39 will not be activated but will still be present.
- The chain variable to redefine the number of bones will not be changed.
- Crypto exchanges, custodians, and hard wallet providers will not have to interrupt their operations to redenominate HNT held on their wallets.

# Success Metrics

- HIP 39 is closed and the discord discussion channel archived.
- The community may bring up a HIP in the future to vote on redenomination again if it desires. This HIP does not preclude future discussion of redenomination. If redenomination of HNT specifically is still desired by the Helium community now or at any point in the future, we propose that a new redenomination HIP should be created that references and accounts for the new subDAOs, subtokens, and the full impact of the technical, economic and governance changes this new HIP would have on all Helium tokens and subDAOs including Data Credit Tokens and the additional stakeholders.
