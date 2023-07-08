# Pre-mine Calculation Error Correction

- Author(s): [@elontusk](https://github.com/capjbadger007), [@gradoj](https://github.com/gradoj), [@leogaggl](https://github.com/leogaggl)
- Start Date: 2023-07-08
- Category: economic
- Original HIP PR: [736](https://github.com/helium/HIP/pull/736)
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT Holders

## Summary

Based on the specifications in [https://docs.helium.com/solana/migration/hotspot-operator/#iot-premine](https://docs.helium.com/solana/migration/hotspot-operator/#iot-premine), all hotspots that were active and earned rewards from either beaconing, witnessing or passing rewardable data, were supposed to receive the pre-mine.

This HIP is to correct for a coding error that left out all "Data Only" hotspots, as well as an error in the selection process during the migration, which missed some active hotspots with PoC rewards from the pre-mine rewards.

## Motivation

This is to correct the errors made during the calculation and payment of the IOT pre-mine to all eligible hotspots, which the community voted for in HIP-51.

## Stakeholders

- All hotspot owners (wallets) that have not rightfully received the IOT pre-mine payment
- Helium Foundation

## Detailed Explanation

The payment awarded on 20th April 2023 was 5789.755 IOT tokens based on the calculation of 2.5 billion IOT and the (incorrect) number of eligible hotspots.

1. A multi-sig pre-mine correction wallet will be created to fund awarding qualifying hotspots that were not awarded during the IOT pre-mine.
2. Each qualifying hotspot will be awarded 5789.755 IOT tokens out of the multi-sig wallet and transferred to the wallet that owned the hotspot at the time of the original pre-mine award (20th April 2023).
3. The pre-mine correction multi-sig wallet will be able to be funded with donations from any source that chooses to add to the fund over a period of 14 epochs. Any difference required for the full payment will be funded by the Helium Foundation. Any extra leftover funds will be burnt, and the wallet's keys will be disposed of.
4. The pre-mine correction multi-sig wallet will require 2 out of 3 signatures to distribute funds. (Suggested signatures: Helium Foundation, two trusted community members to be confirmed).
5. The list of hotspots that should have received the pre-mine payment will be published by an announcement by the Helium Foundation in the following locations:
   1. Helium Wallet notification
   2. Helium Discord announcement
   3. Helium Foundation blog
6. The query and data to generate list can be found at [https://gist.github.com/gradoj/fa29aac39b34de05fba8f6bc5e7d8948](https://gist.github.com/gradoj/fa29aac39b34de05fba8f6bc5e7d8948) for community verification.
   Hotspot addresses qualifying for the reward are defined as active_not_rewarded in the last file on the link above
7. After the passage of the HIP (time of vote closure), no further claims can be made for these missed pre-mine awards.

## Drawbacks

None

## Rationale and Alternatives

After lengthy discussions, this was found to be the preferred way by the Helium Foundation to avoid complications of forcing payments from a named wallet/organisation.

## Unresolved Questions

None

## Deployment Impact

The wallets owning the qualifying 25,996 hotspots (current number at the time of HIP issue), on the 20th April will receive an automated 
IOT token transfer transaction from the multi-sig wallet. No claim action will be required within the Helium Wallet.

## Success Metrics

All remaining qualifying hotspots receive their rightful IOT pre-mine payment.
