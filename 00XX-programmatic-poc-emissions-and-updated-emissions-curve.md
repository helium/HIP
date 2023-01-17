# HIP XX Initiate Programmatic PoC Emissions with an Updated Emissions Curve

- Author(s): [@zer0tweets](https://github.com/zer0tweets), [@meowshka](https://github.com/meowshka)
- Start Date: 2023-01-17
- Category: economic, technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

On November 11th, the Foundation announced the shifts in the timelines related to the Solana migration and the necessary extension of the Genesis period to accommodate the move without halting MOBILE rewarding of 5G Hotspot Owners.

Since the migration to Solana requires more time and the current balance of pre-mind MOBILE tokens in the Treasury is approximately 1.5B, which will last only until February 1st, this HIP is urgent and necessary to prevent the MOBILE rewarding halt.

This HIP proposes to un-tie programmatic treasury from Solana migration and launch a simplified version on the Helium Blockchain. Additionally, it suggests adjusting the emissions curve to accommodate changes in the timelines.


# Motivation

Moving to Solana, while instrumental to the long-term viability of the Helium network, requires careful planning, implementation, and coordination between various parties and is something that cannot be rushed. As of now, the timeline for the launch has shifted to the end of February. This shift in the migration timeline challenges the continuous rewarding of 5G Hotspot Owners. The current extension of the Genesis period, when the rewards come from the pre-mined pool of MOBILE tokens, ends on February 1st, 2023.

As a solution, this HIP proposes to un-gate the evolution of MOBILE PoC from Solana migration by initiating programmatic emissions of MOBILE tokens using Helium L1 blockchain starting February 1st, 2023.

Furthermore, given the iterative approach for evolving the PoC adopted by HIP 74, it is evident that it may take a series of HIPs and a longer than initially expected period of time to ensure that the proof of coverage algorithm used by MOBILE subDAO is sufficiently smart and secure to drive useful coverage. As such, we propose to alter the programmatic emissions curve, initially approved in HIP 53, to make it less inflationary and allow more time for MOBILE POC to evolve.


# Stakeholders

In the long run, this HIP affects all participants of the Mobile subDAO as it proposes changes to the emissions curve. This includes Subscribers, Mappers, Service Providers, Hotspot Vendors, 5G Hotspot Owners, and Oracles.

Immediately after implementation, this HIP affects 5G Hotspot Owners as it ensures continuity of MOBILE rewards past depletion of the Genesis pool of pre-mind MOBILE tokens. There will be no changes to the amount of MOBILE rewards compared to the Genesis period, and no changes to the timing of the rewards submission.

Feedback from the Community will be mainly solicited through the Helium Community Slack channels.


# Detailed Explanation

## Technical: Programmatic Treasury

This HIP proposes to launch a simplified programmatic treasury. The sole function of this treasury will be to mint MOBILE tokens on the Helium Blockchain according to the emissions schedule proposed in this HIP.

During the Genesis period, the MOBILE tokens were taken from the pre-minded MOBILE pool and distributed to the 5G Hotspot Owners based on the Mobile Oracle calculations. With the programmatic treasury MOBILE tokens will be minted directly on the Blockchain with the new type of subnetwork transaction issued by Validators.

The above described change is already implemented in the Mainnet Validator beta build v1.17.0 and requires chain var activation. To sum up, the technical part of the HIP changes the mechanics of how the MOBILE tokens come into existence.

## Economical: Changes to Emissions Curve

A more conservative emissions schedule would ensure that more MOBILE tokens are available to compensate hotspot hosts and other network participants during the later stages of network development when the MOBILE POC algorithm is more mature.

|      |       BEFORE: HIP 53 Emissions Schedule         |        AFTER: HIP XX Emissions Schedule         |
| -----| ----------------------------------------------- | ----------------------------------------------- |
| Year | MOBILE at the start of the year | MOBILE minted | MOBILE at the start of the year | MOBILE minted |
| ---- | ------------------------------- | ------------- | ------------------------------- | ------------- |
| 1    | 50B                             | 116B*         | 50B                             | 80B*          |
| 2    | 116B                            | 33B           | 80B                             | 30B           |
| 3    | 149.5B                          | 33B           | 110B                            | 30B           |
| 4    | 182B                            | 16.5B         | 140B                            | 15B           |
| 5    | 198.5B                          | 16.5B         | 155B                            | 15B           |
| 6    | 215B                            | 8.25B         | 170B                            | 7.5B          |
| 7    | 223.25B                         | 8.25B         | 177.5B                          | 7.5B          |

** 50B pre-mine *

The economic part of this HIP changes when MOBILE tokens come into existence, but it does not change the max supply of 250B MOBILE as specified in the HIP53.
The updated emissions schedule will continue emitting roughly 3B MOBILE tokens per month to 5G Hotspot Owners until the next halving, effectively preserving the economic status quo for Hotspot Owners that was established during the Genesis period.


# Drawbacks

There are no obvious drawbacks related to the implementation of this HIP.


# Unresolved Questions

This HIP proposes an implementation of the programmatic treasury that is limited in functionality. It will only emit MOBILE tokens according to the emissions curve schedule.

As specified in the HIP53, the fully featured programmatic treasury must maintain the HNT reserve and set a market-making curve. This functionality will be added after the Solana migration is complete.


# Deployment Impact

Current 5G Hotspot Owners will not see the changes to the MOBILE rewarding. It will continue at the same rate and schedule as during the Genesis Phase.

Once the HIP is approved, http://docs.helium.com will be updated with more technical details of how the programmatic treasury works and the new emissions curve.

From the technical standpoint, this HIP can be undone, but it will require approval of the changes by the Community via another HIP.


# Success Metrics

## Technical: Programmatic Treasury

The success of launching the programmatic treasury on the Helium Blockchain would be uninterrupted MOBILE rewarding of 5G Hotspot Owners with active Radios.

This is an easily measurable goal. No changes should be noticed by the 5G Hotspot Owners. The rewarding should happen at the same time, around 01:00 UTC, with the same amount of roughly 3B total MOBILE tokens per month for the whole Network.

## Economical: Changes to Emissions Curve

It’s difficult to precisely measure the benefits of changes to the emissions curve, as we cannot predict what will happen when more tokens are in circulation when the fully-featured treasury with the market-making curve is launched. The rules of supply and demand apply.
