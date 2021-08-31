# HIP 37: Omni-Protocol PoC on Helium Network

- Authors: @zer0tweets (FreedomFi), @JMF, @hashc0de
- Start Date: August 28th, 2021
- Category: Technical
- Status: In Discussion
- Original HIP PR: https://github.com/helium/HIP/pull/269
- Tracking Issue: https://github.com/helium/HIP/issues/271
- Discord channel: `#hip-37-omniprotocol-poc` on https://discord.gg/helium

## Summary

This document is an follow-up to HIP 27, tackling economic incentives to implement proof-of-coverage (PoC) for cellular and Wi-Fi data and recommending a technical implementation that includes adding a new device type to the Helium network.

## Background

[HIP 27 originally introduced](https://docs.google.com/document/d/1E_D-8mU8vdwSOLxrzeA4lTtLtisESBc52tBWhnQUL2I/edit) a concept to allocate a portion of unrewarded Data Transfer rewards (up to 30% of the DC Bonus Pool) towards Proof-of-Coverage rewards for new wireless networks, such as 5G and Wi-Fi. The approach was presented and discussed at the DeWi Community Call and Discord. While the concept was generally well received, we failed short of coming up with a technical implementation that would be sufficiently difficult to arbitrage. As a result, we chose to truncate HIP 27 to focus on implementation of a chain variable for DC / cellular data conversion ratio and revisit economics and implementation of PoC for non-LoRaWan wireless network types to a future HIP.

To make the proposed changes easier to understand, we are splitting this HIP into two interrelated sections:

-   Economics Proposal for Proof-of-Coverage for New Wireless Network Types
-   Implementation Proposal for Proof-of-Coverage for 5G and Wi-Fi

## Stakeholders

All Helium Network stakeholders are affected by this HIP.

## PoC Incentive Model for Omni-Protocol Network

Currently, under [HIP-27](https://github.com/helium/HIP/blob/master/0027-cbrs-5g-support.md), non-LoRaWAN gateways are only rewarded based on data transfer and those rewards are based on the 1 DC burn = 1 DC equivalent earning principle laid out in [HIP-10](https://github.com/helium/HIP/blob/master/0010-usage-based-data-transfer-rewards.md). That reward bucket is currently, as of August 2021, limited to 35% of total HNT issuance per epoch. Any HNT from that bucket that is not allocated to Data Transfer rewards is reallocated to LoRaWAN PoC rewards.

We propose two significant changes to the reward bucket structure:

1.  ### Remove division between PoC and DC reward buckets

After [HIP-10](https://github.com/helium/HIP/blob/master/0010-usage-based-data-transfer-rewards.md), the vast majority ofDC rewards are reallocated to the LoRaWAN PoC, which has made the distinction between the buckets nominal. Given this reality, we propose a merging of the two rewards buckets at the date of the second halving (around 8/1/2023). Under this model, DC rewards will be allocated up to the level of DC usage and all remaining rewards in the bucket will be used for PoC rewards.

The value of the bucket will equal the combined value of the existing DC and PoC buckets and will be adjusted along with all other rewards buckets on the existing rewards schedule.

Existing reward curve by reward type:

![](https://lh6.googleusercontent.com/Vc3Sdv-PUCAFlx_fJgdk9ls7ycLCGNszVeBS05j--MsEtx7w1mZc-tbrejGmFemi8m71-F31eA9CKUGfLCR7Cys4ISXLmz_EvsCVDXwvl-MNwN7_21HYuPYEEYojR6HAZH-0O8cq=s0)

The new reward bucket would be a combination of the “Network Data Transfer” and “Proof of Coverage” rewards above.

2.  ### Split PoC rewards between wireless protocols based on the proportion of DCs burned by each protocol

The success of the Helium network is contingent on its ability to find real world applications that burn data credits via data transfer activity. Therefore, the incentive model should be designed in a way that promotes wireless network protocols (WNPs) that accomplish that goal. We propose aligning the reward structure with the network’s goal by splitting PoC rewards between WNPs with each WNP receiving a % of the entire PoC reward bucket equivalent to the % of DCs burned by the WNP.

For example, if there are 1,000,000 HNT available for PoC rewards and WNP #1 accounts for 25% of the entire networks data transfer related DC burn and WNP #2 accounts for 75% of the same burn, than WNP #1 will receive 250,000 HNT and WNP #2 will receive 750,000 HNT for PoC rewards.

Until the two reward buckets are combined at the second halving date, the PoC rewards dedicated to non-Lorawan WNPs would be limited to the HNT being reallocated from the DC reward bucket (AKA the “DC bonus pool”). That gives the Lorawan network additional time to grow without needing to compete for PoC rewards against new WNPs.

Most importantly, this model gives us a framework to add new WNPs in the future without having to design reward splits on an ad-hoc basis.

### Definitions and calculations for Omni-Protocol PoC incentive model

DC burn used in PoC split calculation: DC burn tied specifically to data transfers per WNP. The calculation does not include fees associated with accilory actions, including, but not limited to, gateway assertions, token transfers, and gateway relocation fees.

Wireless Network Protocol (WNP): Wireless network type is a computer network that uses wireless data connections between network nodes and utilizes a uniform, standard set of rules that determine how data is transmitted between different devices in the same network. (i.e. LoRaWan, 5G, Wi-Fi, NB-IoT etc. all different wireless network protocols).

Unique WNP PoC rewards calculation: (Total DC burn of the unique WNP / total DC burn for all WNPs) * total PoC rewards per period

Frequency of PoC reward split recalculation: Manually adjusted on a frequency at the discretion of DeWi unless and until an auto recalculation feature is built into the protocol

Model (Tab 1): [https://docs.google.com/spreadsheets/d/1C8G06_MgFYPrttVKp4KrgKSPalTZ1L8ausymPxnQh6A/edit#gid=1169066097](https://docs.google.com/spreadsheets/d/1C8G06_MgFYPrttVKp4KrgKSPalTZ1L8ausymPxnQh6A/edit#gid=1169066097)

## Implementation Proposal for Proof of Coverage for 5G and Wi-Fi

Helium’s current implementation of PoC is based on wireless coverage being verified through hotspots issuing “challenges” to “challengees” and “witnessing” over the air interface. However, for 5G wireless protocol, radios cannot both challenge and witness the packets over the air, as the protocol stack is designed for the radio to interact with a UE (such as cell phone) vs another radio. Moreover, because the use case we are pursuing is not to build a stand-alone network that will blanket the world (like in IoT case) but to create an offload network that can effectively complement macro network of an operator, the usefulness of the cell is determined by a) number of UEs in proximity that are capable of connecting to it; b) comparative RSSI of offload operator macro-cells in proximity. Usefulness should not be a function of location relative to another cell on the Helium network, as is the case with LoRa.

We propose to separate the challenge and witness function(s) for 5G PoC between the operator of a hotspot and an iOS/Android app (aka eSIM app), as follows:

-   All hotspots on the network (regardless of wireless protocol) will continue to perform “the challenger” function by issuing randomly targeted challenges. However, instead of all challenges always targeting LoRaWan hotspots, every N blocks challengers would also target alternative protocols, starting with 5G. This role may change in the future as Validators take on the role of challenge generation.

-   5G Hotspot operators will perform the role of challengee/transmitter by picking up 5G challenges and transmitting them to witness cell phones that attach to the hotspot

-   All 5G Hotspots will come equipped with the LoRa concentrator and will also participate in the LoRa PoC. In the spirit of minimizing deviations from existing PoC mechanisms, location attestation for 5G hotspots will continue to be performed using existing, LoRa-based algorithms.

-   Cell phone owners with the eSIM app installed will “witness” that the hotspot is, indeed, active and radiating signal, and submit the confirmation back to the blockchain.

Following the completion of the above, both the 5G hotspot operator and the cell phone owner with the eSIM app will receive their respective “challenge” and “witness” rewards.

From the implementation standpoint, we’ll attempt to stay as close to the existing proof-of-coverage mechanism as possible. Table below shows the mapping between steps in current PoC mechanism and their cellular counterpart.

<table class="c27"><tbody>
<tr><td colspan="1" rowspan="1"><p><span class="c19 c11"></span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c22"><span class="c11 c19">LoRa PoC </span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c30"><span class="c11 c25">Cellular &amp; Wi-Fi* </span><span class="c19 c11">PoC </span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">1.</span></p><p class="c0 c3"><span class="c12 c11"></span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Challenger, that can be any node on the network, writes a transaction on chain as a request. Currently happens once every 480 blocks</span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">Same as LoRa, except challenger can now also issue a cellular challenge every N blocks, in addition to LoRa challenge</span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">2.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Challengee tries to decrypt all requests from chain and notices they&rsquo;re being challenged</span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">Same as LoRa, except challengee is a 5G miner with cellular radio attached</span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">3.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Challengee sends receipt to challenger via libp2p </span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">Challengee waits for a period of N blocks for a phone with eSIM app to come in range and attempt to attach. When a witness phone attaches to the challengee cell, challenger cell sends a receipt to the challenger via gRPC and appends witness IMEI </span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">4.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Challengee sends beacon over radio.</span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">Challengee accepts the attach request(s) from a witness phone running an eSIM app. Challengee sends the challenge packet to the witness over the air, immediately following the attach</span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">5.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Witness sees packet over radio</span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">Witness phone with eSIM app receives packet from the challengee over radio </span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c11 c12">6.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Witness finds matching &ldquo;onion&rdquo; in a recent request transaction</span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">eSIM app appends it&rsquo;s IMEI, and witness key to the challenge packet </span></p><p class="c8 c3"><span class="c1"></span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">7.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Witness sends receipt to challenger via libp2p </span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">eSIM app sends above data + receipt to challenger over gRPC, once it is no longer attached to the challengee cell </span></p></td></tr><tr><td colspan="1" rowspan="1"><p class="c0"><span class="c12 c11">8.</span></p></td><td class="c2" colspan="1" rowspan="1"><p class="c0"><span class="c1">Challenger combines receipts and writes receipt on chain</span></p></td><td class="c15" colspan="1" rowspan="1"><p class="c8"><span class="c1">Same as Lora, challenger combines receipts and writes receipt on chain</span></p></td></tr>
</tbody></table>

*The example above provides step-by-step detail, specifically for cellular (vs. Wi-Fi) use case. However, the general flow for Wi-Fi offload will work very similar, assuming sim based authentication (EAP-AKA/EAP-AKA’) is used and cellular CBRS radios are replaced with enterprise grade Wi-Fi hotspots that support the above.

# Why is eSIM Important?

Until recently, most cell phones (particularly in the US) had a single, physical SIM card slot, occupied by the sim card issued by the main carrier operator. However, most newer phones (iPhones, Samsung, Pixel etc.) come with the eSIM (electronic SIM) available in addition to the physical sim card slot and have, what’s referred to as dual-sim, dual-standby (DSDS) capability. This enables owners of such phones to augment service from their main telecom carrier embedded in the physical sim with the secondary data services. DSDS capable phones can automatically prioritize connecting to and offloading data into the eSIM based service vs. the primary sim card. An emerging ecosystem of MNOs and MVNOs is now embracing eSIM.

The app we are proposing to implement will rely on the eSIM standard and will program the eSIM of the phone to attach to one of the PLMNs broadcasted by the 5G hotspot operators to witness a challenge. eSIM approach would further allow us to circumvent issues with limited control of the iOS apps over the connection control functions of the phone.

## Open Source Library Implementation Approach

Helium community may choose to initially launch a Helium branded end-to-end implementation of the app to kickstart and test the app-based approach to PoC for cellular data. Longer term, however, this app should be implemented as an open source software library that existing MNOs and MVNOs looking to offload into the Helium network can re-use to launch their own eSIM data services with the capability to offload the data onto the Helium network. This will empower cellular operators to run “buy my service, earn HNT crypto” campaigns and incentivize their subscribers to download the app, thus bringing more data to the network. This will be particularly attractive to faster moving, challenger MVNOs.

## Active / Passive Mode

It is fair to assume that as we roll out 5G and Wi-Fi coverage on the Helium network, initially the coverage will be very spotty and likely the quality of service will not be up to “carrier grade” standards, which introduces additional challenges to get a large number of MNOs and MVNOs to actually use the network for mobile data offload. With the app based approach we can enable two modes of offload:

-   Passive - in this mode the eSIM app will merely serve as a phone based miner of “witness” rewards and will only send mock data packets to the offload network. The app will collect data on performance of hotspots. That same data can also be later used to adjust PoC challenge incentives, skewing rewards towards 5G hotspots placed in areas with the greatest need for coverage. Finally, passive mode will allow operators to gauge savings and test the network prior to actually offloading any data that would affect end user experience

-   Active - in this mode the app will also actively offload the traffic into the Helium network. The operator will have the ability to specify on an individual eSIM basis, which of the eSIMs are authorized to offload into which of the Helium operated hotspots, thus optimizing the savings and user experience for the customer, balancing between macro network and offload network

Switching between active and passive modes can be done remotely by the operator, without requiring the end user to update the SIM card or app software.

## Security Considerations

Key consideration in the design for the modified PoC approach is susceptibility to potential attacks and abuse schemes. To minimize new potential exploits, our overarching philosophy in implementing a new PoC is to minimize deviations from the existing security mechanisms already present and proven by the LoRaWan network.

Below we outline 6 exploit scenarios and how the current implementation protects against those. However, we’d like to solicit further feedback from the Helium community on possible security design flaws in the system and propose additional scenarios we may not have thought about.

-   Faking presence of cellular radio
-   Spoofing / Faking location
-   Faking a witness
-   Filtering out non-PoC Traffic
-   Phone farming
-   Unlimited plan gaming

### Faking presence of cellular radio

This exploit involves a malicious actor purchasing a miner (such as FreedomFi Gateway) and running a virtualized radio front end instead of buying and plugging in a real cellular radio.

This exploit was possible in the original HIP 27 proposal where witness <> challengee interaction wasn’t performed over the air interface. Current proposed implementation moves the witness function into an eSIM app and closely mimics the over the air witnessing flow of the current LoRa network. This exploit is no longer possible with the current proposed design as the physical presence of the radio, capable of accepting witness attach requests, is required to complete proof of coverage challenges.

### Spoofing / Faking Location

This exploit involves falsifying the location of a hotspot by asserting a location that is different from the actual physical location.

Current hardware design for omni-protocol hotspots (such as FFi gateway) includes a LoRa concentrator in the hotspot. This affords us with the opportunity to re-use existing mechanisms implemented for LoRa to be able to verify location using LoRa signal strength and SNR and without relying on GPS or CBRS specific mechanisms. We propose that the presence of a LoRa concentrator remains a standard requirement for all non-LoRaWan gateways for the foreseeable future.


### Faking a witness

Faking a witness involves somebody running a virtual machine with Android OS and an eSIM app and writing fake witness transactions to the block chain. To prevent the possibility of faking a witness, we propose to re-use the mechanism of DeWi-issued keys that’s already been proven in the LoRa deployment to preclude the possibility of faking a LoRa hotspot.

-   All witnesses that mine on mainnet will be required to sign transactions with a witness key, generated as part of the DeWi onboarding process.

-   Operators that use eSIM app SDK to augment their existing apps to perform witnessing function on mainnet will be subject to passing the app audit (similar to hardware audit performed by the manufacturing committee)

-   Onboarding keys will be mapped to phone IMEI (International Mobile Equipment Identity) - a unique identity associated with each handset, maintained and issued by GSM. Only 1 key per 1 IMEI will be allowed

-   Similar to the LoRa gateway onboarding process, to onboard an eSIM app, the operator of an eSIM back-end (generally a service provider / MVNO) will submit a phone IMEI to the onboarding server during eSIM issuance using the same API that current manufacturers use to submit hotspot hardware credentials such as mac addresses.

-   Onboarding keys will be generated and stored in a secure key storage module of a phone - iOS Keychain or Android Keystore - similar to how they are stored in the ECC or TPM chip of a miner.

Today all devices capable of mining on Helium MainNet are a) build by a vendor, explicitly approved by the manufacturer oversight committee; b) contain a security key issued by DeWi, associated with the mac address of the unit that was provided to DeWi by the approved manufacturer, thereby ensuring KYC compliance. To ensure that the integrity of the above model does not get compromised by the introduction of eSIM app and a phone, we propose to stick to a similar procedure for authenticating witness apps.

<table class="c27"><tbody><tr class="c13"><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">Vendor allowed to build hardware is approved by MOC, which includes testing miner code on the manufacturer&rsquo;s hardware </span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">Operator of the eSIM infrastructure (usually offload operator) is approved by DeWi, which includes testing their eSIM app </span></p></td></tr><tr class="c13"><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">Each device manufactured by the approved vendor has mac address verified by the vendor &nbsp;</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">Each phone has both - mac address and IMEI. Additionally, IMEI is used by eSIM infrastructure operators to create a unique eSIM profile. Spoofing/changing IMEI post eSIM provisioning invalidates the eSIM </span></p></td></tr><tr class="c13"><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">Manufacturer provides DeWi with mac address of the devices, so each DeWi issued key can be mapped to mac address </span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">eSim infrastructure operator provides IMEI, which was used to create an eSIM profile. </span></p></td></tr><tr class="c13"><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">DeWi approves a mining key against the mac address provided by the manufacturer &nbsp;</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">DeWi approves a witness key against the IMEI, validated by eSIM infrastructure operator</span></p></td></tr><tr class="c13"><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">DeWi approved key is stored in ECC or TPM module of the device, so it cannot be extracted or transferred</span></p></td><td class="c6" colspan="1" rowspan="1"><p class="c8"><span class="c1">DeWi approved key is stored iOS keychain or Android Keystore, so it cannot be extracted or transferred </span></p></td></tr></tbody></table>

### Filtering Out Non-PoC Traffic


This exploit involves tweaking access control lists in a firewall behind the hotspot, such that only PoC related traffic is passed, but no other internet traffic is allowed. This allows one to collect PoC rewards without passing any data traffic.

This exploit is also currently relevant for the LoRa network, however, it becomes more acute for other streaming protocols where volume of data and associated backhaul costs are much higher.

To verify back-haul connectivity current software installed on FFi gateways will perform random iperf tests to check ping and bandwidth against a randomly selected set of endpoints pushed into Magma AGW software (running on the gateway) from Magma Orchestrator. Hotspots failing to verify backhaul will be automatically removed from the pool of valid offload points and will have their Non-Lora RF interface turned off until cured.

Granted this mechanism both a) relies on centralized controls b) is potentially hackable, we believe it provides sufficient barrier during the initial stages of rollout to minimize the possibility of this exploit.

Longer term, there are a number of options for implementing trust-less bandwidth verification that could involve validators. We propose to limit the scope of this HIP to over the air proof of coverage for non-lorawan protocols and explore trust-less bandwidth verification options as a subject for subsequent HIPs.

### Phone Farming

This exploit involves malicious actors setting up a farm of 5G hotspots and many cheap (potentially used) real phones with valid IMEIs and properly onboarded eSIM Apps in proximity to each other. The goal of the malicious actor is to emulate a highly popular data offload location and collect unfairly large PoC rewards, whereas in reality the entire setup is located in their basement.

In the spirit of reusing the existing community know-how, we propose to apply witness reward scaling implemented as part of HIP 15 to address this. Granted we may want to adjust the number of witnesses required to get max reward to a number higher than 4 and evolve that into a protocol-specific chain variable, we believe that the same concepts of managing witness oversaturation addressed by HIP 15 for LoRa apply for most other wireless protocols.

### Unlimited Plan Gaming

This exploit involves a user subscribing to some large number of unlimited data plans (such as AT&T unlimited elite) provided by an operator that is also a Helium network customer then placing all 10 phones to stream Netflix next to the Helium CBRS hotspot that they themselves set up. That way the malicious actor can be paying a capped amount of $80/month for 10 unlimited plans, yet collecting an uncapped amount of rewards at $.5/Gb on all artificially generated data passed through the very offload hotspot they are operating. I.e. effectively an operator will be paying the user through the Helium network any difference between the fixed fee the operator is charging the user and the actual cost of data that the user artificially generated through their CBRS cell.

This exploit is not specific to Helium offload use case, but is generic to any operator offload and assumes that the operator is unable to manage their own cost of bits. All operators (and particularly nationwide MNOs offering unlimited data) run sophisticated BSS systems that understand the cost of data and dynamically and intelligently manage roaming/offload tonnage, including policing any potential exploits or bad behavior.

However, for an added layer of security, we propose to address the above by implementing a chain variable that would allow setting an upper limit on data transfer for each UE <> CBRS on a per operator basis.

# Summary of Benefits

-   Just as hack-proof as current LoRa based proof of coverage, since challenge/witness PoC will be done over the air vs. IP network

-   Will work for Wi-Fi and 5G/LTE

-   Can collect intelligence on network coverage gaps, which can later be used to adjust incentives for placing 5G and Wi-Fi hotspots in most sought after places

-   Passive mode can enable MVNOs to run experiments and estimate the potential savings from offloading data into Helium, prior to actually enabling offload, hence decreasing barrier to entry

-   Introduces lightweight way for people to start participating in the Helium network i.e. earn rewards with an eSIM capable phone

-   Open source library implementation approach creates incentive for MNOs and MVNOs to just whitelabel it and use for their eSIM service
