# HIP XXXX: IOT Data Pricing

- Author(s): [@bfgneil](https://github.com/bfgneil)
- Start Date: 2024-09-19
- Category: Economic
- Original HIP PR:
- Tracking Issue:
- Voting Requirements: veIOT holders

## Summary

This HIP proposes to wipe any remaining unused onboarding keys for makers not in good standing.

We are seeing gaming clusters setup 100+ hotspots in a few minutes, this leads the authors to believe they are selling keys without selling hardware.

We wish to remove any keys for makers in bad standing that have not been used, and offer a proof of purchase and delivery form to be run by the Iot working group for any users with real hardware.

## Motivation

 we have had 4 incidents in the past month of 150+ of these makers hotspots setup clusters.

 If we are to improve anti gaming efforts, we cant allow them to use these keys to create new units.


## Stakeholders

All customers (e.g., sensor owners), hosts, and operators of the Helium IOT Network.

## Detailed Explanation

Unused keys are shown below.

Bobcat        97,348
 Nebra Ltd    45,329
 Linxdot    31,688
 CalChip     23,385
 PantherX    20,198
 Milesight    8,984
 SyncroB.it    7,947
 Pisces          6,393
 COTX         5,911
 Heltec             5,515
 Dusun        3,352
 Controllino    3,246
 Midas        2,367
 OPTION    1,401
 Aitek Inc    1,158
 uG Miner    923
 Bobcat 5G     717
 Pycom        221
 KS Tech    157
 LongAP    49
 Embit        1 

 Helium foundation will remove these keys from the onboarding server, and setup a flow for users to submit proof of purchase and proof of delivery for any hotspots where physical hardware exists.


## Implementation

Helium foundation will remove the unused keys for makers not in good standing from the onboarding server


## Alternatives

- apply any outstanding keys to a watch list, and manually add them to the denylist.

## Drawbacks

- some customers have units they have never turned on.

## Unresolved Questions

-- none so far

## Deployment Impact

- users with hotspots that havn't been onboarded will need to fill out a form with proof of purchase and delivery, the iot wg will need to administer form entries and create and submit a list of valid keys for helium foundation to add back to the onboarding server.


## Success Metrics

Gaming clusters with bad makers will stop appearing