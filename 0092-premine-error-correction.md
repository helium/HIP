# HIP 92: Correcting IOT Pre-mine Calculation Errors

- Author(s): [@elontusk](https://github.com/capjbadger007), [@leogaggl](https://github.com/leogaggl)
- Start Date: 2023-07-08
- Category: Economic
- Original HIP PR: [736](https://github.com/helium/HIP/pull/736)
- Tracking Issue: [752](https://github.com/helium/HIP/issues/752)
- Vote Requirements: veIOT Holders

## Summary

Based on the specifications in [Helium Docs](https://docs.helium.com/solana/migration/hotspot-operator/#iot-premine), and in [HIP 52](https://github.com/helium/HIP/blob/main/0052-iot-dao.md) all Hotspots that were active, not on the denylist, and earned rewards from either beaconing, witnessing or passing rewardable data, were supposed to receive the IOT pre-mine at the migration.

This HIP proposes to correct for a coding error that left out all "Data Only" Hotspots, as well as an error in the selection process during the migration, which missed some active Hotspots with PoC rewards.

## Motivation

This is to correct the errors made during the calculation and payment of the IOT pre-mine to all eligible Hotspots, which the community voted for in HIP-52.

## Stakeholders

- All Hotspot owners (wallets) that have not correctly received the IOT pre-mine amount

## Detailed Explanation

The payment awarded on 20th April 2023 was 5,789.755 IOT tokens based on the calculation of 2.5 billion IOT set aside in HIP 52 and an (incorrect) number of eligible Hotspots.

This HIP proposes that the following process is followed after this HIP is approved by the community.

1. A multi-sig premine correction wallet will be created to fund awarding qualifying Hotspots that were not awarded during the IOT pre-mine.
2. Each qualifying Hotspot will be awarded 5,798.755355 (2,500,000,000 available IOT tokens / 431,127 rewarded Hotspots at migration) IOT tokens out of the multi-sig wallet and transferred to the wallet that owned the Hotspot at the time of the original pre-mine award (20th April 2023). This will be implemented by the Helium Core Developers.
3. The pre-mine correction multi-sig wallet will be able to be funded with donations from any source that chooses to add to the fund over a period of 14 epochs. As per Monthly Community Calls from June 28, 2023 and July 26, 2023 the Helium Foundation has agreed that any difference required for the full payment will be provided by the Foundation. Any extra leftover funds will be burnt, and the wallet's keys will be disposed of.
4. The pre-mine correction multi-sig wallet will require 2 out of 3 signatures to distribute funds. (Suggested signatures: Helium Foundation, two trusted community members to be confirmed).
5. The list of Hotspots that should have received the pre-mine payment will be published by an announcement by the Helium Foundation to the entire community.
6. The query and data to generate the list can be found at [this notebook](files/0092/rewards.ipynb) for community verification. Once the discussion of this HIP concludes, the final dataset used for this calculation will be added to the HIP repository as a single file. Hotspot addresses qualifying for the reward are defined as active_not_rewarded in the last file on the link above.
7. The comma-separated file containing a list of all the hotspots that were active during the qualifying period leading up to the pre-mine and did not receive the pre-mine reward can be downloaded from [here](files/0092/active_not_rewarded.csv) (including the owner wallet address and geolocation).
8. After the passage of the HIP (time of vote closure), no further claims can be made for these missed pre-mine awards.

## Drawbacks

None

## Rationale and Alternatives

After lengthy discussions, this was found to be the preferred way by the Helium Foundation to avoid complications of forcing payments from a named wallet/organisation.

## Unresolved Questions

None

## Deployment Impact

The wallets owning the qualifying 32,227 Hotspots (current number at the time of HIP issue), on the date of migration (20th April 2023) will receive an automated IOT token transfer from the network. No claim action will be required within the Helium Wallet.

## Success Metrics

All remaining qualifying Hotspots receive their rightful IOT pre-mine payment.
