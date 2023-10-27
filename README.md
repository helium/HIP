# Helium Improvement Proposals (HIP)

Helium Improvement Proposals are the core unit of change in the Helium Network.

_"How a bill becomes a law"_

More details on process and how to participate can be found in HIP 7, ["A Process For Managing Helium Improvement Proposals"](0007-managing-hip-process.md).

If you have questions or feedback, please see the [Discussion](https://github.com/helium/HIP/discussions) section of this Repo, where you can open forums to propose changes, provide feedback, and discuss ideas on how to make Helium Governance better.

**Looking for HIP19 hotspot manufacturer applications?** Those have moved to their own dedicated repository: [dewi-alliance/hotspot-manufacturers](https://github.com/dewi-alliance/hotspot-manufacturers)

## Index of proposals

<!-- prettier-ignore -->
| ID | Title | Status |
| :---: | :--- | :-- |
| 1 | [Longfi and LoRaWAN](0001-longfi-and-lorawan.md) | <img src="https://img.shields.io/badge/Status-Deployed-blue"></img> |
| 2 | [Sign miner](0002-sign-miner.md) | <img src="https://img.shields.io/badge/Status-Deployed-blue"></img> |
| 4 | [Expensing Data Credits for LoRaWAN Traffic](0004-expensing-data-credits-for-lorawan.md) | <img src="https://img.shields.io/badge/Status-Deployed-blue"></img> |
| 5 | [PoC fairness/epoch challenge limit](0005-poc-fairness.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/24#issuecomment-705308809) |
| 6 | [Ramp-up period for data transfer rewards](0006-reward-ramp-for-packets.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/pull/20) |
| 7 | [Process for managing Helium Improvement Proposals](0007-managing-hip-process.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/26) |
| 8 | [XOR filter for LoRaWAN packet routing tables](0008-lorawan-routing.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/pull/9) |
| 9 | [Ensuring trust for non-Helium hotspots (DIY gateways)](0009-non-helium-hotspots.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/pull/15) |
| 10 | [Proportional reward scheme for data transfers](0010-usage-based-data-transfer-rewards.md) | <img src="https://img.shields.io/badge/Status-Deployed-blue"></img> |
| 11 | [Amendment to proportional data transfer reward scheme](0011-usage-based-rewards-structure.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/pull/49#issuecomment-705306806) |
| 12 | [Remote location assertion](0012-remote-location-assert.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/39) |
| 13 | [Transfer hotspot](0013-transfer-hotspot.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/43) |
| 14 | [PoC Ripple Method](0014-poc-ripple-method.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/50) |
| 15 | [Beaconing Rewards](0015-beaconing-rewards.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/blockchain-core/pull/662) |
| 16 | [Remove Score from Consensus Group Elections](0016-random-consensus-group-election.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/55) |
| 17 | [Hex Density-based Transmit Reward Scaling](0017-hex-density-based-transmit-reward-scaling.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/blockchain-core/pull/677) |
| 18 | [Remove Oracle Forecast for DC Burn](0018-remove-oracle-forecast-for-dc-burn.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/60) |
| 19 | [Approval Process For Third-Party Manufacturers](0019-third-party-manufacturers.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/87) |
| 20 | [HNT Max Supply](0020-hnt-max-supply.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/73) |
| 21 | [PoC Link Layer Upgrades](0021-poc-link-layer.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/78) |
| 22 | [DIY Concentrators (f/k/a Golden or Anchor Gateways)](0022-diy-concentrators.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/94) |
| 23 | [Decouple Consensus From Gateways](0023-decouple-consensus-from-gateways.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/101) |
| 24 | [Transfer Percentage of Hotspot](0024-reward-splitting.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/105) |
| 25 | [Validators](0025-validators.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/111) |
| 26 | [Payment Notes](0026-payment-notes.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/125) |
| 27 | [Support CBRS 5G](0027-cbrs-5g-support.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/pull/133) |
| 28 | [Consensus Reward Adjustments](0028-consensus-reward-adjustments.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/140) |
| 29 | [Multi-signature Keys](0029-multisignature-keys.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/157) |
| 30 | [BLS12-381 for Threshold Cryptography](0030-update-threshold-cryptography.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/158) |
| 31 | [Governance by Token Lock](0031-governance-by-token-lock.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/183) |
| 32 | [Split DCs Among All Transferers](0032-split-dcs.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/221) |
| 33 | [Regional Reward Adjustments](0033-regional-reward-adjustments.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/222) |
| 34 | [Validator Node Security](0034-validator-node-security.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/223) |
| 35 | [RF Metadata Sidechannel](0035-safe-rf-metadata-side-channel.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/250) |
| 36 | [Blockheight Chainvar Activation](0036-blockheights-instead-of-time.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/260) |
| 37 | [Omni-Protocol PoC](0037-omni-protocol-poc.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/271) |
| 38 | [Validator Oracles](0038-validator-oracles.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/282) |
| 39 | [HNT Redenomination](0039-hnt-redenomination.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/283) |
| 40 | [Validator Denylist](0040-validator-denylist.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/285) |
| 41 | [Governance by Token Lock V2](0041-governance-by-token-lock-v2.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/302) |
| 42 | [Beacon/Witness Ratio - Witness Reward Limit](0042-beacon-witness-ratio-witness-reward-limit.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/303) |
| 43 | [Software Release Guidelines](0043-software-release-guidelines.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/309) |
| 44 | [Witness Reward Decay](0044-witness-decay.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/310) |
| 45 | [LoRaWAN Frequency Plan Selection](0045-lorawan-frequency-plan-selection.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/311) |
| 46 | [LoRaWAN NetID Routing](0046-lorawan-netid-routing.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/312) |
| 47 | [Increase DKG Failure Penalty](0047-increase-dkg-penalty.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/313) |
| 48 | [IP-over-LoRaWAN](0048-ip-support.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/319) |
| 49 | [LoRaWAN Sub-region Max EIRP Limit](0049-max-eirp-adjustment.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/327) |
| 50 | [Display All Potential Witness Beacons](0050-display-all-potential-beacon-witnesses.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/331) |
| 51 | [Helium DAO](0051-helium-dao.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/336) |
| 52 | [IoT subDAO](0052-iot-dao.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/338) |
| 53 | [Mobile subDAO](0053-mobile-dao.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/345) |
| 54 | [H3Dex-based PoC Targeting](0054-h3dex-targeting.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/347) |
| 55 | [Validator Challenges](0055-validator-challenges.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/362) |
| 56 | [Improved State Channel Disputes](0056-state-channel-dispute-strategy.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/369) |
| 57 | [PoC Rewards Establishment Period](0057-poc-rewards-establishment-period.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/376) |
| 58 | [PoC Distance Limit](0058-poc-distance-limit.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/384) |
| 59 | [Reduce XOR filter fees](0059-reduce-xor-filter-fees.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/391) |
| 60 | [Entity-Weighted Vote](0060-entity-weighted-vote.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/399) |
| 61 | [Increase Challenger Rewards](0061-increase-challenger-rewards.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/421) |
| 62 | [PoC Witness IP Check](0062-poc-witness-ip-check.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/422) |
| 63 | [Helium Hub](0063-helium-hub.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/423) |
| 64 | [WiFi subDAO](0064-wifi-dao.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/424) |
| 65 | [Vendor HNT Lockup](0065-vendor-token-lockup.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/437) |
| 66 | [Trust Score & Denylist Convenience](0066-trust-score-and-denylist-convenience.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/438) |
| 67 | [Repeal Redenomination](0067-repeal-redenomination.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/456) |
| 68 | [Open Service Subdao](0068-open-service-subdao.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/457) |
| 69 | [Re-assertion Fee Reduction](0069-reassertion-fee-reduction.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/458) |
| 70 | [Scaling the Helium Network](0070-scaling-helium.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/471) |
| 71 | [Scaling the Network with Governance & Hedera](0071-scaling-with-governance-hedera.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/480) |
| 72 | [Secure Concentrators](0072-secure-concentrators.md) | [<img src="https://img.shields.io/badge/Status-Rejected-red"></img>](https://github.com/helium/HIP/issues/489) |
| 73 | [Consensus Deselection Weighting](0073-consensus-deselection-history-weight.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/491) |
| 74 | [Mobile PoC - Modeled Coverage Rewards](0074-mobile-poc-modeled-coverage-rewards.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/504) |
| 75 | [Initiate Programmatic PoC Emissions with an Updated Emissions Curve](0075-mobile-poc-initiate-programmatic-minting-and-updated-emissions-curve.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/526) |
| 76 | [Simplify Lockup Curve and veTokens](0076-linear-lockup-curve.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/560) |
| 77 | [Launch Parameters for Solana Migration](0077-solana-parameters.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/573) |
| 78 | [Mobile SubDAO Onbaording Fees](0078-mobile-subdao-onboarding-fees.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/582) |
| 79 | [Mobile PoC Mobile Mappers](0079-mobile-poc-mappers-rewards.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/592) |
| 80 | [Simplifying the DAO Utility Score](0080-simplifying-dao-utility-score.md) | [<img src="https://img.shields.io/badge/Status-Rejected-red"></img>](https://github.com/helium/HIP/issues/599)  |
| 81 | [Minimum Device Onboarding Fees](0081-minimum-onboarding-fee.md) | [<img src="https://img.shields.io/badge/Status-Rejected-red"></img>](https://github.com/helium/HIP/issues/612)  |
| 82 | [Add Helium Mobile as a Service Provider to the Helium Mobile subDAO](0082-helium-mobile-service-provider.md)  | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/628)  |
| 83 | [Restore First to Respond Witness Rewarding](0083-restore-first-to-witness.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/632)  |
| 84 | [Service Provider Hex Boosting](0084-service-provider-hex-boosting.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/638)  |
| 85 | [MOBILE Hex Coverage Limit](0085-mobile-hex-coverage-limit.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/673)  |
| 86 | [Increase IOT Data Transfer Cost](0086-increase-iot-data-transfer-cost.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/703)  |
| 87 | [Proportional Service Provider Rewards](0087-proportional-service-provider-rewards.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/704)  |
| 88 | [Adjustment of DAO Utility A Score](0088-adjustment-of-dao-utility-a-score.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/707)  |
| 89 | [MOBILE Network Onboarding Fees](0089-mobile-network-onboard-fees.md) | [<img src="https://img.shields.io/badge/Status-Deployed-blue"></img>](https://github.com/helium/HIP/issues/714)  |
| 90 | [Indefinitely Reduce IOT Location Assertion Cost](0090-reduce-iot-location-assert-cost-indefinitely.md) | [<img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>](https://github.com/helium/HIP/issues/735)  |
| 91 | [Data-Driven Extension: Continuation of Reduced IOT Location Assertion Cost](0091-data-driven-extension-reduced-iot-assertion-cost.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/743)  |
| 92 | [Correcting IOT Pre-mine Calculation Errors](0092-premine-error-correction.md) | [<img src="https://img.shields.io/badge/Status-Rejected-red"></img>](https://github.com/helium/HIP/issues/752)  |
| 93 | [Addition of Wi-Fi Access Points to the Helium Mobile SubDAO](0093-addition-of-wifi-aps-to-mobile-subdao.md) | [<img src="https://img.shields.io/badge/Status-Approved-green"></img>](https://github.com/helium/HIP/issues/754)  |
| 94 | [Response Time Windows for Witness Rewarding](0094-response-time-windows-for-witness-rewarding.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/764)  |
| 95 | [Self-Onboard Hotspots After Maker Exit](0095-self-onboard-hotspots-after-maker-exit.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/775)  |
| 96 | [WiFi AP Onboarding Structure](0096-wifi-ap-onboarding-structure.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/785)  |
| 97 | [Redefining MOBILE DAO Location Assertion Fees](0097-redefining-mobile-dao-location-assertion-fees.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/795)  |
| 98 | [MOBILE SubDAO Quality of Service Requirements](0098-mobile-subdao-quality-of-service-requirements.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/797)  |
| 99 | [Formalize the Maker Program through a New Legal Entity
](0099-formalize-the-maker-program-through-a-new-legal-.md) | [<img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img>](https://github.com/helium/HIP/issues/801)  |


## Status Key

| Status        | Label                                                                        | Summary                                                                                               |
| :------------ | :--------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------- |
| Draft         | <img src="https://img.shields.io/badge/Status-Draft-yellow"></img>           | HIP is in process of being written; author is not yet soliciting feedback from the community at large |
| In Discussion | <img src="https://img.shields.io/badge/Status-In%20Discussion-orange"></img> | HIP is under active consideration by the community                                                    |
| Voting Open   | <img src="https://img.shields.io/badge/Status-Voting_Open-cyan"></img>       | HIP is currently being voted on
| Approved      | <img src="https://img.shields.io/badge/Status-Approved-green"></img>         | HIP has been approved by rough consensus, and pending development and testing                         |
| Deployed      | <img src="https://img.shields.io/badge/Status-Deployed-blue"></img>          | Code to implement HIP has been merged and deployed to the network                                     |
| Rejected      | <img src="https://img.shields.io/badge/Status-Rejected-red"></img>           | HIP did not pass voting                                                                               |
| Closed        | <img src="https://img.shields.io/badge/Status-Closed-lightgrey"></img>       | HIP abandoned, rendered obsolete by other changes, or otherwise withdrawn by the author               |
