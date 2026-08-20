# Supporting notes: venue groups and measurements

Background for the Mobile deployer prioritization HIP. Nothing here is part of the
proposal. It exists so a deployer can judge whether its own location is worth an
application, and so a reader can check the figures the HIP cites.

## How venues are likely to be grouped at the start

Nova Labs maintains this grouping and can revise it as venue data improves. It
produces candidates, not entitlements.

- **Likely near the maximum.** Extreme peak concurrency and burst traffic, high
  reputational exposure if service degrades, national or regional visibility,
  excellent quality of service required: airports, stadiums and arenas, concert
  venues, convention centers, transit hubs, casinos, major attractions.
- **Likely a smaller multiplier.** Large daily populations and long dwell,
  significant consumption, tolerance for adequate rather than excellent service:
  big box retail, hotels, colleges and universities, school districts, municipal
  and government sites, corporate campuses.
- **Likely none, earning the unchanged base pay rate.** Low concurrency, predictable
  usage, minimal congestion impact: everything else, including restaurants and
  bars, smaller retail, small hotels, small commercial and private
  non-residential sites, gyms and recreation venues, and residential.

Four things about the grouping matter more than the lists themselves.

- The lists are indicative, not exhaustive. A category's absence means nothing.
- Venue category is one input among several. Expected traffic, density and
  concurrency, backhaul and radio configuration, deployment complexity, and
  strategic value all bear on the negotiated multiplier.
- Size separates locations inside a category. A large hotel and a small one are
  not the same location for this purpose, and neither are a corporate campus and
  a single small office.
- No category entitles a location to a multiplier or to any particular value of
  one, and no group is a rejection. Any location can apply, and every location
  without a multiplier earns the unchanged base pay rate.

## Measurements the HIP cites

From the reward oracle manifest for 2026-08-02 to 2026-08-11, and network session
data for the seven days to 2026-08-11.

| Quantity | Value |
|---|---|
| Base pay rate, as of writing | $0.10/GB |
| Rewarded volume | ≈91,600 GB/day |
| Realized deployer earnings | $0.0502/GB, every day in the window |
| Rewarded volume in high-value candidate categories | ≈3.3% |
| Rewarded volume in mid-value candidate categories | ≈12.2% |
| Aggregate uplift at full enrollment of both | ≈1.19x on payer spend and on deployer pay |

Deployer earnings pinned at $0.0502/GB against a target of 50% of the $0.10 base
pay rate confirm the HIP 149 target minimum is the binding constraint today, which is
the regime in which multipliers are self-funding.

The base pay rate, the volume and which data is rewardable move independently of the
proposal. These are the conditions the mechanism was measured against, not a
projection.

## Distribution of daily volume by venue group

Per-location-day rewardable GB, seven days to 2026-08-11, all payers. Percentiles
are exact rather than approximated.

| Group | Locations | 25th | Median | 75th | 99th | Mean |
|---|---|---|---|---|---|---|
| High-value | 412 | 0.02 | 0.67 | 3.99 | 175.2 | 9.18 |
| Mid-value | 1,577 | 0.09 | 1.04 | 5.65 | 112.8 | 8.33 |
| Base-rate | 13,575 | 0.15 | 1.24 | 5.54 | 85.8 | 6.66 |

High-value venues have both the lowest median and the highest tail: a mean day 14
times the median, because a few large venues carry the average while the typical
one is quiet. That is the burst pattern the multiplier is meant to pay for, and it
is why volume alone does not identify a demanding location.
