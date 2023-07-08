# Pre-mine Calculation Error Correction

- Author(s): [@elontusk](https://github.com/capjbadger007), [@gradoj](https://github.com/gradoj), [@leogaggl](https://github.com/leogaggl)
- Start Date: 2023-07-08
- Category: economic
- Original HIP PR:
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: <!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary

Based on the specifications in [https://docs.helium.com/solana/migration/hotspot-operator/#iot-premine](https://docs.helium.com/solana/migration/hotspot-operator/#iot-premine), all hotspots that earned rewards from either beaconing, witnessing or passing rewardable data, were supposed to receive the pre-mine.

This HIP is to correct for a coding error that left out all "Data Only" hotspots, as well as an error in the selection process during the migration, which missed some hotspots with PoC rewards from the pre-mine rewards.

## Motivation

This is to correct the errors made during the calculation and payment of the IOT pre-mine to all eligible hotspots which the community voted for in HIP-51.

## Stakeholders

- All hotspot owners (wallets) that have not rightfully received the IOT premine payment
- Helium Foundation

## Detailed Explanation

The payment awarded on 20th April 2023 was 5789.755 IOT tokens based on the calculation of 2.5 billion IOT and the (incorrect) number of eligible hotspots.

1. A multi-sig pre-mine correction wallet will be created to fund awarding qualifying hotspots that were not awarded during the IOT pre-mine.
2. Each qualifying hotspot will be awarded 5789.755 IOT tokens out of the wallet transferred to the wallet that owned the hotspot at the time of the original pre-mine award (20th April 2023).
3. The pre-mine correction wallet will be able to be funded with donations from any source that chooses to add to the fund over a period of 14 epochs. Any difference required for the full payment will be funded by the Helium Foundation. Any extra funds left over will be burnt, and the wallet's keys will be disposed of.
4. The pre-mine correction multi-sig wallet will require 2 out of 3 signatures to distribute funds. (Suggested signatures: Helium Foundation, two trusted community members to be confirmed).
5. The list of hotspots that should have received teh pre-mine payment will be published by announced by the Helium Foundation in the following locations:
   1. Helium Wallet notification
   2. Helium Discord announcement
   3. Helium Foundation blog
6. The query and data to generate list can be found at [https://gist.github.com/gradoj/fa29aac39b34de05fba8f6bc5e7d8948](https://gist.github.com/gradoj/fa29aac39b34de05fba8f6bc5e7d8948) for community verification.
7. After the passage of the HIP (time of vote closure), no further claims can be made for these missed pre-mine awards.

## Drawbacks

None

## Rationale and Alternatives

After lengthy discussions, this was found to be the preferred way by the Helium Foundation to avoid complications of forcing payments from a named wallet/organisation.

## Unresolved Questions

None

## Deployment Impact

None - automated transaction from multisig wallet to all recipients' IOT wallets.

## Success Metrics

All remaining qualifying hotspots receive their rightful IOT pre-mine payment.
