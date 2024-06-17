# HIP 114: Incentive Escrow Fund for Subscriber Referrals

- Author: [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-03-12
- Category: Economic, Technical
- Original HIP PR: [#927](https://github.com/helium/HIP/pull/927)
- Tracking Issue: [#942](https://github.com/helium/HIP/issues/942)
- Vote Requirements: veMOBILE Holders

---

## Summary

Service Provider rewards will be used to programmatically issue various incentives (like referral fees) to grow the Helium network subscriber base.

## Motivation

Helium Network utility is a function of the number of subscribers sending paid data to the network. I.e. we want more subscribers. Per HIP53, the service provider rewards bucket was originally designed to empower service providers to bring more subscribers to the network using token incentives.
Today, the service provider bucket is mostly unused. Some rewards go to Helium Mobile for the traffic, but 90%+ of it is just never emitted.

We propose a referral incentive program that would channel rewards to the community referring users and takes advantage of non-emitted MOBILE in the service provider bucket.

## Stakeholders

- Service Providers will have a new capability to create referral incentive programs using unused rewards from service provider bucket.
- Builders will be able to earn MOBILE rewards for referring subscribers.
- Subscribers may be eligible for "referral discounts" in the form of MOBILE, if they stay with the network for a period of time.

## Detailed Explanation

- Service providers get the ability to delegate a percentage of their service provider rewards towards referral incentives.

- Any funds delegated towards referral incentives are matched pro rata up to 100% by unused programmatic emissions from the service provider bucket. i.e. if there are plenty of non-emitted funds in the 10% service provider bucket and Helium Mobile chooses to start delegating up to 50% of its rewards towards referral incentive escrow (roughly $1K/day in MOBILE), a total of $2K/day in MOBILE will be deposited into the escrow.

- On-chain variable called _active percentage_ tracks relative contributions by various service providers towards incentive referral escrow and what portion of said rewards has already been distributed by a given service provider. The variable is then used by the mobile verifier at the moment of reward distribution to determine what portion of MOBILE rewards stored in the referral escrow bucket a particular service provider can direct towards a referral campaign.   

- Each service provider delivers wallet "referral eligibility" to the mobile ingest services. This is similar to how mobile mapper eligibility is delivered today.

- At rewards time, the mobile verifier will distribute the amount indicated by the _active_ percentage as stored on-chain of the given service provider rewards plus the matched amount to _all_ eligible wallets as delivered by the service provider during the epoch.

- A service provider can change the allocated percentage at any time. The percentage used at reward calculation time is the percentage as stored in the service provider Solana account.

- The referral percentage is specific to a service provider. Each service provider defines their own referral percentage, and eligibility criteria. I.e. Helium Mobile can run its own, and Telefonica (when and if approved as an SP) can run its own.

- Service providers can define and run various incentive programs that would reward the community for growing subscribers, using MOBILE delegated via the on-chain percentage.

- MOBILE in the escrow fund cannot be used for anything other than programmatic incentive programs aimed at new subscriber acquisitions (i.e. "referrals" or “new subscriber” bonus rewards).

### Example Incentive Program Proposed by Helium Mobile

Hotspot owners are incentivized to refer subscribers to the network. Each hotspot can generate a referral code unique to that hotspot.

For each successful and qualified subscriber that registered for the network and used the referral code, the hotspot owner earns $10 in MOBILE immediately, then another $20 in MOBILE over 5 months, provided the subscriber is still active and in good standing.

The gradual reward payout promotes subscriber retention and ensures a higher-quality subscriber base (an anti-gaming mechanism). Referrals are paid out of the incentive allocation.

### Geographic Limiations 

This proposal is limited to service providers and subscribers operating in the United States and Mexico. Expansion of this proposal to apply to future geographies will require a separate Helium Improvement Proposal and vote. 

## Drawbacks

This proposal introduces an additional layer of complexity to the already complex reward mechanism.

It may also be argued that allowing service providers the freedom to define the structure of a referral program is prone to gaming. Poorly designed and implemented referral schemes could result in exploits where referral payouts for fake users.

Finally, since this proposal does not require that incentive programs launched by service providers require that referred subscribers send data to the Helium Network, service providers will be using “network’s emissions” to attract subscribers that will bring revenue to the service provider, but not the network.

## Rationale and Alternatives

An alternative would be for service providers to pay token rewards directly to network participants, instead of using an incentive escrow fund. Depending on the regulatory framework governing crypto in the country where the service provider is domiciled, this may involve varying levels of regulatory / compliance risk.

## Unresolved Questions

Do we need to implement a gating mechanism, such that referral payouts coming from the incentive escrow fund require that any referred user actually used data on the Helium network vs. just becoming a subscriber with one of the network approved service providers?

## Deployment Impact

Nova Labs will collaborate with the foundation engineering team to develop detailed architecture and roadmap.

## Success Metrics

This HIP would be considered successful if a referral program launched by at least one service provider resulted in at least 50,000 new network subscribers/users sending at least 6TB of paid data to the network per day.
