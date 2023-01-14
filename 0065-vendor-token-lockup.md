# HIP 65: Vendor HNT Lockup

- Category: Economic, Technical
- Original PR: <https://github.com/helium/HIP/pull/428>
- Tracking Issue: <https://github.com/helium/HIP/issues/437>
- Status: In Discussion

# Addendum to HIP-19

## Summary

This HIP seeks to discourage manufacturers from participating in or supporting large-scale cheating
Hotspot deployments.

Manufacturers will be required to deposit Helium Network Tokens (HNT) in an escrow account in
proportion to the rate at which they add new Hotspots to the network. These deposited tokens can be
forfeited if the manufacturer is found to have been complicit in a scheme to receive network rewards
for dishonest deployments, or returned to the manufacturer on a regular schedule after a waiting
period in good standing.

\*HIP-19 is the process by which manufacturers of Helium Hotspots can apply for and receive
cryptographic permission to add new gateways (Hotspots) to the Helium network.

## Motivation

The Helium Network has provided a globally successful economic incentive for distributed wireless
network propagation, far outpacing the growth rate of any traditional wireless infrastructure
provider**.** Since its inception in 2019, the Network has grown from an initial core of 24 Hotspots
to over 820,000 (as of May 2022), and at the same time, the HNT token has achieved a market
capitalization of over $3 billion dollars.

The network achieves its value from its ability to offer global wireless networking coverage of
various forms to current and future users. In order to maintain this value, the network must
continuously demonstrate its ability to provide ubiquitous and reliable coverage, which is
incentivized through a reward scheme known as _Proof-of-Coverage (POC)_.

POC rewards have very successfully bootstrapped global coverage through what has been a majority of
honest hosts setting up legitimate Hotspot placements. However, the POC scheme has been subject to
dishonest actors who “game” rewards for their own selfish pursuits rather than providing legitimate
coverage. This harms the majority of the community, users of the network, and undermines the Helium
community’s mission of worldwide open wireless networks.

Over the past few months as the number of manufacturers has increased, so has the evidence that some
manufacturers use their powers to obtain rewards fraudulently. ~~Manufacturers are able to obtain
rewards more quickly than other network participants, as such, they wield enormous power on the
Helium network.~~ This HIP introduces a _Token Lockup_ to counteract that power and further align
their interests with network success and disincentivize attempts to fraudulently earn POC rewards
themselves or with a coordinated party.

## Stakeholders

- Manufacturers of Helium-compatible Hotspots
- Long-term holders of the Helium Network Token
- Consumers of the Helium Network coverage (e.g. sensors)
- Volunteer committees (i.e. POCSWG and MCC)

## Detailed Explanation

Manufacturers of Helium Hotspots are given the privilege to induct Proof-of-Coverage earning
Hotspots into the network in exchange for undergoing an extensive proposal and audit process managed
by the Manufacturing Compliance Committee. This process seeks to ensure that a potential
manufacturer has the technical ability to build and deliver Hotspots with sufficient security
controls for the network.

A dishonest manufacturer can use its privilege to onboard Hotspots rapidly and deploy them in a
manner that reaps Proof-of-Coverage rewards while providing no real coverage for the network. This
process is informally known as _gaming_.

The temptation to “game” is a perverse incentive with a material economic value. As such, it can be
combated in part with an upfront, revocable deposit known as \*Token Lockup**\*.**

## The deposit scheme

Under this proposal, manufacturers must deposit **1 HNT\* (TBD)** for every Hotspot they onboard.
The deposit is returned to the manufacturer for good behavior over the course of ~~24~~ 12 months.

### Batching and Catch-up

To keep the scheme practical, deposits must be made in advance and must be made in batches of
~~1_000 HNT\*~~ \*_\*\*10,000 Hotspots minimum. Manufacturers whose approval pre-dates the deposit
scheme will be required to make a one-time catch-up deposit of 1 HNT_ for every Hotspot they have
already deployed, capping at 10_000 HNT\* total.

To keep the deposit scheme effective, manufacturers must make deposits in step with their onboarding
rates and may not onboard any further Hotspots when their deposit balance reaches zero.
Manufacturers who continue to onboard in this condition are technically _in arrears_ and are subject
to immediate suspension of their ability to onboard new Hotspots.

\*(TBD)

### Refund Timing

So long as a manufacturer remains in good standing, its deposits will be refunded at a rate of ~~25%
every sixth month after the date of deposit. The deposit will be fully refunded after two years.~~
50% every sixth month after the date of the first Hotspot onboarded from that batch.

### Deposit Accounts

Each manufacturer shall make its deposits into an individually-established account that is
controlled by a multi-signature wallet that is held by the Foundation (TBD).

Alternatively, the manufacturer will have the option to make HNT deposits into an escrow account
managed by a 3rd party staking provider.  This will allow the manufacturer to earn HNT rewards while
their HNT is being held in escrow.  The manufacturer must independently establish an agreement with
a 3rd party staking provider and submit a proposal to the Foundation for approval which
specifies the method providing custodial control of HNT funds to the foundation. The funds must be
in wallets and validator nodes that are 100% dedicated to supporting a manufacturer's token lock-up
requirements. All existing requirements for staking must be adhered to which may further delay when
the Manufacture has access to their HNT beyond the specific requirements of the HNT Lock-up period.

### Refund Forfeiture

If a manufacturer is found to have abused their onboarding privileges, the entire balance of the
manufacturer’s outstanding deposits will be _forfeited_ and will not be returned. Forfeitures will
be accomplished by token burn or token payment, under the direction of the Manufacturing Compliance
Committee.

## The Tribunal Structure

It is in the interests of the entire Helium community to recognize that token forfeiture is a
drastic act and decisions about it must be made openly and rationally. To this aim, we propose the
following tribunal structure in the hopes that it removes dangerous concentrations of power from any
single decision-making group and defuses the inherent biases that investigative groups accumulate
when pursuing allegations of wrongdoing.

Forfeiture shall occur only after a suitable trial. One group, representing _the prosecuting body,_
and another group, representing the _defending body (the manufacturer),_ must present the evidence
for their respective cases in front of the _judicial body_, who shall make the final ruling of
forfeiture only upon supermajority consent (TBD).

This division of roles ensures that each group vigorously pursues their own agenda while freeing the
judicial group to remain impartial and responsible for determining the final action.

### Prosecuting Body

The right to bring forth an action under this proposal belongs _solely_ to the Proof-of-Coverage
Security Working Group*; a separate, community-organized body. The group shall use whatever criteria
it deems appropriate to investigate allegations of wrongdoing and when ready, bring the case forward
to the*judicial body\* to begin a trial.

### Defending body

In all cases, the manufacturer accused of wrongdoing shall have the right to represent itself as the
_defending body_ at the trial. Manufacturers representing themselves will have a minimum of three
full business days (72 hours) to prepare.

### Judicial Body

The _judicial body_ shall be composed of the current standing members of the Manufacturing
Compliance Committee and shall be in charge of running the proceedings and making the final ruling
in a case.

### Evidence

During a trial, the prosecution and defense may only make statements and presentations that refer to
evidence that has been shared with the opposing party ahead of time (TBD). The judicial body may
interrupt with questions at any time.

## Principles and Standards for Judgement

- No _double jeopardy_

Once brought forth and decided, any case covering the same material allegations may not be brought
again. This prevents endless attempts to gain a favorable ruling by simply repeating a trial.

- Misbehavior is scoped to violations of _Manufacturer Ethics_

A case has merit only if it alleges a manufacturer has violated a clause of the _Manufacturer Ethics
Agreement_. Allegations of wrongdoing outside of the rules set forth by the ethics agreement are not
within the Manufacturing Compliance Committee’s purview.
