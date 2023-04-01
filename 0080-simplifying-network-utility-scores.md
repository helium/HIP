# HIP 80: Simplifying Network Utility Scores

- Author: [@ferebee](https://github.com/ferebee), [@jmfayal](https://github.com/jmfayal), [@rawrmaan](https://github.com/rawrmaan)
- Start Date: 2023-03-29
- Category: Economic, Technical
- Original HIP PR: 
- Tracking Issue: 

# Summary

[HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model) specifies the DAO Utility Score (referenced hereon as 'Network Utility Score'), which determines the distribution of HNT among the Helium IOT, MOBILE, and future networks.

The Network Utility Score's purpose is to incentivize current and future networks to grow the value of their services provided through the Helium Network, while also protecting the investment of the LoRa Hotspots that participated from the start to launch the Helium network of networks.

As the implementation of HIP-70 has progressed, multiple theoretical and practical drawbacks of the Network Utility Score as specified in HIP-51 have become apparent, threatening the interests of the existing IOT and MOBILE networks, possible future networks, and the Helium project as a whole.

To solve these problem, HIP-80 proposes a new, simplified Network Utility Score, which is easier to understand and protects the interests of all participants.

The new Score no longer considers the number of Hotspots and their onboarding fees, instead using only the square root of the product of DC Burn and delegated veHNT.

The IOT Network receives an explicit guarding factor to ensure its continued funding.

As the Hotspot onboarding fee is no longer relevant to the new Score, all network onboarding fees are reduced universally to $5 per Hotspot. A Hotspot must burn an onboarding fee towards each network in which it participates.

# Motivation

The existing definition of Network Utility Score as specified in HIP-51 is ambiguous and difficult to understand. Simplifying it will make it more approachable and reduce the probability of unintended consequences.

In addition, certain intents of HIP-51 are not fully realized by the existing Score definition.

On the one hand, due to an oversight in the implementation of HIP-53, no onboarding fees have ever been burned towards the MOBILE Network. Therefore, at launch, the Network Utility Score of the MOBILE Network as defined in HIP-51 would be eclipsed by the IOT Network, so that much less HNT than intended would initially be distributed to the MOBILE Network. This could limit the growth of MOBILE, which is important to the further development of the Helium Flywheel, and thus to IOT as well.

On the other hand, calculations show that the IOT Network risks being marginalized by the MOBILE Network in the medium term under the existing Score, if current trends continue. This could cause nearly all HNT to be distributed to the network treasury of the MOBILE Network, which would run counter to the intent of HIP-51 and could limit the further development of IOT. This threatens the health of the Helium Network as a whole, as IOT is expected to deliver a significant contribution to the Helium Network over the longer term.

With its V factor, the existing Network Utility Score gives far more weight to the amount of veHNT delegated to a network than to any other factor. This would enable a single large investor to favor a single network disproportionately with a large veHNT delegation, and would prioritize economic incentives for delegation while marginalizing the importance of network growth and utility.

Finally, if a new Network Utility Score can be defined that does not rely on the number of Hotspots in a network and their onboarding fees, the onboarding fee itself loses most of its importance. New types of low-cost Hotspots have been proposed for both IOT and MOBILE. The traditional onboarding fee of $40 would make up a large portion of the retail cost of these Hotspots. Reducing the onboarding fee can significantly reduce their cost and encourage the adoption of these new devices, contributing to the success of both networks.

# Stakeholders

This proposal is relevant to all participants in the Helium Network.

- Existing and future IOT and MOBILE Hotspot owners are affected by the reduction in fees and/or the changes to Network Utility Scores.
- The cost to Manufacturers for onboarding fees will be reduced.
- New networks will receive a different share of HNT emissions.

# Discussion of HIP-51 Utility Score

## Utility Scores of IOT and MOBILE

HIP-51 introduces the Network Utility Score as the [DAO Utility Score](https://github.com/helium/HIP/blob/main/0051-helium-dao.md#omni-protocol-poc-incentive-model), which determines the proportion of HNT emissions distributed to each network, and defines it as:

$\text{Legacy Network Utility Score per HIP-51} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

HIP-53 describes a [$40 onboarding fee](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview) and $10 location assertion fee, analogous to the traditional fees assessed for IOT Hotspots. However, the gateways developed by FreedomFi and used to launch the MOBILE network, as well as models introduced by other manufacturers, include both IOT and MOBILE Hotspot functions, which operate independently. In the existing implementation, the IOT Hotspot component is onboarded in the same way as all other Helium IOT Hotspots, with a $40 onboarding fee and optionally a $10 location assert. However, the MOBILE Hotspot component itself currently performs no onboarding operation of its own, but it is treated as if it were onboarded nonetheless.

As a result, the *A* component of the Score is currently 1 for the MOBILE Network, as no onboarding fees (a. k. a. Activation Fees) have yet been burned to the MOBILE Network.

Due to this implementation oversight, the Network Utility Score of MOBILE as defined by HIP-51 is slated to launch far below its intended value, which would impair the incentive for participants to deploy new MOBILE Hotspots for Helium 5G. The buildout of Helium 5G is essential for the upcoming launch of Helium Mobile and therefore the growth of the Helium Network as a whole.

On the other hand, if the MOBILE Network is successful, it is expected to burn a large volume of DC per Hotspot in the medium term, as it is providing network coverage for a device class (smartphones) that is already ubiquitous and consumes large amounts of bandwidth. The IOT Network is expected to follow a slower growth path, as it is providing coverage for entirely new applications that are still being developed and are expected to be rolled out in the next several years as technology matures.

Therefore, under the existing model, the Network Utility Score of the IOT Network could be eclipsed by MOBILE in the medium term, such that almost no HNT is distributed to the IOT treasury. This would endanger the health of the IOT network and prevent it from achieving and maintaining the necessary coverage until the demand for the network reaches its potential.

## Influence of veHNT

Independent of the installed Hotspots and the Data Transfer and DC burn they contribute, the *V* component of the Network Utility Score as defined in HIP-51 considers the veHNT delegated to the various networks. This is intended as a way for network participants to signal their preference for a particular network. By encouraging participants to lock their HNT for veHNT, it also contributes to the stability of the Helium Network and its governance.

While the *A* component, which counts Hotspots and their onboarding fees, is counted by its fourth root, and the *D* component, which counts Data Transfer, is counted by its square root, the *V* component is counted linearly.

This gives inordinate weight to the delegation of veHNT. For example, 10 times the amount of delegated veHNT would have the same weight as 100 times the DC burn from Data Transfer, or 10,000 times the number of Hotspots.

Modeling has shown that this favors a winner-takes-all scenario. Once one network has received a large majority of delegated veHNT, the *V* component of the Network Utility Score dominates the Score to such an extent that it becomes economically unattractive to delegate to any other network, considering the delegation rewards that are available in the different networks, as valued through the treasury exchange rate to HNT. Another network, even if it provides network coverage and DC burn that are valuable to the Helium Network as a whole, could be unable to attract sufficient veHNT delegation to reward its participants appropriately.

## Onboarding Fee

In the Helium network as originally designed, prior to HIP-25, blockchain consensus ran on the LoRa Hotspots themselves. This was a main reason for the $40 Hotspot onboarding fee, which was designed to provide resistance against Sybil attacks, in which illegitimate Hotspots could endanger the security of the blockchain itself. Ever since HIP-25, blockchain security has been provided by Helium validators, and with the implementation of HIP-70, blockchain security will be provided by Solana. Therefore, onboarding fees are no longer needed for Sybil resistance.

Meanwhile, given recent advances in hardware, the traditional fee of $40 per Hotspot has become a significant component of total Hotspot deployment cost. Manufacturers are ready to offer LoRa Hotspots for the IOT Network below $100, and low-cost short-range Wi-Fi Hotspots have been proposed for the MOBILE Network, complementing longer-range LTE and 5G deployments, which could potentially also reach prices below $100.

For these devices, the traditional $40 onboarding fee is a significant barrier to wide-scale deployment, and hampers the growth of both IOT and MOBILE networks and thereby the success of the Helium Network as a whole.

The remaining justification for an onboarding fee is to prevent nuisance attacks, such as a bad actor spamming the network with large numbers of invalid Hotspots, which could happen if a Maker key were compromised. For that, a nominal fee would be sufficient.

# Utility Score Proposal

In response the issues outlined above, HIP-80 proposes a new definition of the Network Utility Score, replacing the definition from HIP-51 with the following:

$\text{Network Utility Score} = V \times D$

where

$V = \text{max}(1, \sqrt{veHNT_{DNP}})$

$D = \text{max}(Floor, \sqrt{\text{DNP DCs burned per epoch in USD}})$

and *Floor* is 1 for all networks except for the IOT Network.

*Floor* shall be 50 for the IOT Network until the fourth halvening of HNT emissions, which is currently scheduled to occur on 1 August 2027. Then, it shall revert to 1.

# Discussion of HIP-80 Utility Score

## DC Burn

HIP-51 recognizes that the participants of the IOT Network jumpstarted the Helium Network with a large investment in hardware despite challenges in the supply chain, and have decided to invite the MOBILE Network and future networks into the Helium Network while anticipating that they would be able to share in the joint success of all future networks.

The *A* factor of the Network Utility Score as proposed in HIP-51, which counts the number of active Hotspots multiplied by their onboarding fees, was intended to respect this contribution by giving an initial advantage to the IOT Network.

To respect this intent while simplifying the calculation, HIP-80 proposes to give the IOT Network an explicit—but limited—advantage by setting its *Floor* to 50.

The effect of this is to treat the IOT Network as if

$\sqrt{\text{IOT DCs burned per epoch in USD}} = 50,$ which is equivalent to

$\text{IOT DCs burned per epoch in USD} = 50 \times 50 \text{USD} = 2,500 \text{USD,}$ which is equivalent to

$\text{IOT DCs burned per 30 days in USD} = 75,000 \text{USD.}$

This special treatment of IOT shall last until the fourth halvening of HNT emissions, which is scheduled for 1 August 2027, when *Floor* for IOT shall revert to 1.

In other words, as soon as the IOT Network achieves a monthly DC burn of $75,000, its founder’s bonus will become irrelevant. If it cannot achieve this burn by 1 August 2027, it will have to succeed or fail on its own merits.

As was proposed in the discussions leading up to HIP-51, this will ensure that the IOT Network has the opportunity to receive a majority share of total HNT emissions as long as other networks are not contributing significant DC burn.

On the other hand, once Helium Mobile and possibly other service providers begin moving data over Helium 5G, the MOBILE Network may quickly begin burning significantly more DC than the notional $75,000/month floor attributed to the IOT Network, so the MOBILE Network may then be able to capture a larger share of total HNT emissions, while also contributing the greater value to the Helium Network and thus to HNT itself by virtue of its greater rate of DC burn. This in turn will benefit the IOT Network as well.

## *A* Factor

As discussed above, HIP-80 eliminates the *A* factor of the Network Utility Score entirely, replacing the implicit advantage at launch it would grant the IOT Network with an explicit guaranteed minimum DC burn factor.

By eliminating the dependence on the number of active Hotspots and the onboarding fees charged by networks, the new Utility Score introduced by HIP-80 greatly simplifies calculations that would otherwise need to be performed by Oracles and/or smart contracts of the Helium Network.

Furthermore, it eliminates the incentive for networks to artificially inflate their Hotspot count or their onboarding fees.

## veHNT Delegation

The Score proposed in HIP-51 gives such a high weight to veHNT delegation, which is considered as a linear factor, that an unequal distribution of veHNT between networks could fully dominate all other components of the Score. Thus, either the IOT Network (despite its network size) or the MOBILE Network (despite its expected DC burn) could be completely marginalized by a single large delegation of veHNT. This could allow economic interests of investors to override all other contributions of network participants in deciding the distribution of HNT.

Therefore, the new Network Utility Score proposed by HIP-80 considers veHNT delegation and DC burn equally, by multiplying together the square root of each.

# New Onboarding Fee 

The Utility Score proposed in HIP-80 eliminates the incentive for networks to compete for HNT emissions through the onboarding fees charged to their Hotspots, as fees are no longer relevant to the Score and thus the share of HNT emissions to each network.

The sole remaining purpose of onboarding fees is to protect the Helium Network from nuisance attacks caused by onboarding an arbitrary number of invalid Hotspots.

Therefore, the Helium Network, with HIP-80, sets the onboarding fee for all networks universally to $5, to be modified in the future as needed through Helium Network governance. A Hotspot participating in multiple networks shall burn a separate fee to each network independently.

As a one-time exception, all MOBILE Hotspots onboarded prior to the implementation of HIP-70 through the legacy onboarding procedure, which was introduced in the implementation of HIP-53, shall be considered to have been onboarded to both the MOBILE and the IOT Network.

# Drawbacks

This proposal may require some network participants to revisit their evaluations of veHNT delegation strategies.

# Benefits

- The simplified Network Utility Score introduced by this proposal is easier to evaluate and model. By giving equal weight to economic investment and network deployment and usage, it is anticipated to deliver stabler economic incentives for all participants.
- The existing MOBILE Hotspots can be properly onboarded without the need to secure additional funding for the missing onboarding fees.
- The IOT Network is guaranteed a predictable minimum incentive to continue network buildout and maintenance, protecting its opportunity to realize its potential.

# Deployment Impact

The calculation of Utility Score will need to be adjusted. Based on feedback from the HIP 70 implementation team, this is possible within the existing development framework and requires updating prior to the Solana Migration on April 18th. 

# Clarifications

- Networks may continue to assess location assertion fees, which are determined by network governance.
- The Helium Network HNT emissions contract distributes HNT to HST holders as specified in HIP-20.
- In clarification of HIP-51, all remaining HNT is distributed between all networks in proportion to their relative Network Utility Scores.

# Success Metrics

- This HIP is succesful if simplifying the Network Utility Score lends itself to increased incentives and more utility for each network.
