# HIP-75: MOBILE PoC - Initiate Programmatic Minting with an Updated Emissions Curve

- Author(s): [@zer0tweets](https://github.com/zer0tweets), [@meowshka](https://github.com/meowshka)
- Start Date: 2023-01-17
- Category: Economic, Technical
- Original HIP PR: [#525](https://github.com/helium/HIP/pull/525)
- Tracking Issue: [#526](https://github.com/helium/HIP/issues/526)

# Summary

On November 11th, the Foundation announced the shifts in the timelines related to the Solana
migration and the necessary extension of the Genesis period to accommodate the move without halting
MOBILE rewarding of 5G Hotspot Owners.

Since the migration to Solana requires more time and the current balance of pre-mined MOBILE tokens
in the Treasury is approximately 1.5B, which will last only until February 1st, this HIP is urgent
and necessary to prevent the MOBILE rewarding halt.

This HIP proposes to un-tie programmatic minting from Solana migration and launch it on the Helium
Blockchain. Additionally, it suggests adjusting the emissions curve to accommodate changes in the
timelines.

# Motivation

Moving to Solana, while instrumental to the long-term viability of the Helium network, requires
careful planning, implementation, and coordination between various parties and is something that
cannot be rushed. As of now, the timeline for the launch has shifted to the end of February, and
remains an unconfirmed date. This shift in the migration timeline challenges the continuous
rewarding of 5G Hotspot Owners. The current extension of the Genesis period, when the rewards come
from the pre-mined pool of MOBILE tokens, ends on February 1st, 2023.

As a solution, this HIP proposes to un-gate the evolution of MOBILE PoC from Solana migration by
initiating programmatic minting of MOBILE tokens using Helium L1 blockchain starting February
1st, 2023.

Furthermore, given the iterative approach for evolving the PoC adopted by HIP-74, it is evident that
it may take a series of HIPs and a longer than initially expected period of time to ensure that the
proof-of-coverage algorithm used by MOBILE subDAO is sufficiently smart and secure to drive useful
coverage. As such, we propose to alter the programmatic emissions curve, initially approved in
HIP-53, to make it less inflationary and allow more time for MOBILE PoC to evolve.

# Stakeholders

In the long run, this HIP affects all participants of the Mobile subDAO as it proposes changes to
the emissions curve. This includes Subscribers, Mappers, Service Providers, Hotspot Vendors, 5G
Hotspot Owners, and Oracles.

Immediately after implementation, this HIP affects 5G Hotspot Owners as it ensures the continuity of
MOBILE rewards past the depletion of the Genesis pool of pre-mined MOBILE tokens. There will be no
changes to the amount of MOBILE rewards compared to the Genesis period and no changes to the timing
of the rewards submission.

Feedback from the Community will be mainly solicited through the Helium Community Discord channels.

# Detailed Explanation

## Technical: Programmatic Minting

This HIP proposes to start programmatic minting of MOBILE tokens according to the new emissions
schedule proposed in this HIP.

During the Genesis period, the MOBILE tokens were taken from the pre-minded MOBILE pool and
distributed to the 5G Hotspot Owners based on Mobile Oracle calculations. With the programmatic
minting, MOBILE tokens will be minted directly on the Helium L1 Blockchain with a new type of
subnetwork transaction issued by Validators.

The above-described change is already implemented in the Mainnet Validator beta build v1.17.0 and
requires a chain variable activation.

To sum up, the technical part of the HIP changes the mechanics of how the MOBILE tokens come into
existence.

## Economic: Changes to Emissions Curve

A more conservative emissions schedule would ensure that more MOBILE tokens are available to
compensate 5G Hotspot hosts and other network participants during the later stages of network
development when the MOBILE POC algorithm is more mature.

<table>
  <tr>
    <th> </th>
    <th colspan="2">BEFORE: HIP-53 Emissions Schedule</th>
    <th colspan="2">AFTER: HIP-75 Emissions Schedule</th>
  </tr>
  </tr>
    <td>Year</td>
    <td>MOBILE at the start of the year</td>
    <td>MOBILE minted</td>
    <td>MOBILE at the start of the year</td>
    <td>MOBILE minted</td>
  </tr>
    <td>1</td>
    <td>50B</td>
    <td>116B*</td>
    <td>50B</td>
    <td>80B*</td>
  </tr>
  </tr>
    <td>2</td>
    <td>116B</td>
    <td>33B</td>
    <td>80B</td>
    <td>30B</td>
  </tr>
  </tr>
    <td>3</td>
    <td>149.5B</td>
    <td>33B</td>
    <td>110B</td>
    <td>30B</td>
  </tr>
  </tr>
    <td>4</td>
    <td>182B</td>
    <td>16.5B</td>
    <td>140B</td>
    <td>15B</td>
  </tr>
  </tr>
    <td>5</td>
    <td>198.5B</td>
    <td>16.5B</td>
    <td>155B</td>
    <td>15B</td>
  </tr>
  </tr>
    <td>6</td>
    <td>215B</td>
    <td>8.25B</td>
    <td>170B</td>
    <td>7.5B</td>
  </tr>
  </tr>
    <td>7</td>
    <td>223.25B</td>
    <td>8.25B</td>
    <td>177.5B</td>
    <td>7.5B</td>
  </tr>
</table>
<b>* 50B pre-mine</b>

Full emissions schedule of HIP53 and HIP75 can be downloaded
[here](files/0075/mobile-emissions-schedule-HIP53-vs-HIP75.pdf).

The economic part of this HIP changes when MOBILE tokens come into existence, and the max supply of
250B MOBILE that was specified in the HIP53. With new schedule the max supply of tokens will be 200B
MOBILE.

The updated emissions schedule will continue emitting roughly 3B MOBILE tokens per month to 5G
Hotspot Owners until the next halving, effectively preserving the economic status quo for Hotspot
Owners that was established during the Genesis period.

If this change is not implemented and we start emitting tokens based on the schedule proposed in
HIP53, 5G Hotspot Owners will earn 6.6B MOBILE tokens per month beginning February 1st. The rewards
will more than double compared to the Genesis period, but the PoC algorithm will stay the same. We
think that rewards should reflect the maturity and evolution of the technical aspects of the
Network, and adjusting the emissions curve is necessary to reflect the shifts in PoC timelines.

# Drawbacks

There are no obvious drawbacks related to the implementation of this HIP.

# Unresolved Questions

This HIP proposes an implementation of the programmatic minting of MOBILE tokens according to the
emissions curve schedule.

It does not propose the implementation of the fully-featured programmatic treasury as specified in
HIP53 on the Helium Blockchain. Features like maintaining of the HNT reserve and a market-making
curve will be implemented after migration to Solana is complete.

# Deployment Impact

Current 5G Hotspot Owners will not see the changes to the MOBILE rewarding. It will continue at the
same rate and schedule as during the Genesis Phase.

Once the HIP is approved, http://docs.helium.com will be updated with more technical details of how
the programmatic minting works and the new emissions curve.

From the technical standpoint, this HIP can be undone, but it will require approval of the changes
by the Community via another HIP.

# Success Metrics

## Technical: Programmatic Minting

The success of launching the programmatic minting on the Helium Blockchain would be uninterrupted
MOBILE rewarding of 5G Hotspot Owners with active Radios.

This is an easily measurable goal. 5G Hotspot Owners should notice no changes. The rewarding should
happen at the same time, around 01:00 UTC, with the same amount of roughly 3B total MOBILE tokens
per month for the whole Network.

## Economic: Changes to Emissions Curve

It’s difficult to precisely measure the benefits of changes to the emissions curve, as we cannot
predict what will happen when more tokens are in circulation when the fully-featured treasury with
the market-making curve is launched. The rules of supply and demand apply.
