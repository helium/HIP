# HIP: IoT Operations Fund Transparency and Stewardship

- **Author(s):** @gradoj
- **Start Date:** 2026-08-22
- **Category:** Governance, Economic
- **Original HIP PR:** TBD
- **Tracking Issue:** TBD
- **Vote Requirements:** veHNT Holders

## Summary

This HIP requires the Helium Foundation to publish a complete financial and custody accounting of the IoT Operations Fund and the Foundation's material finances related to operation of the Helium IoT Network.

The accounting must identify all historical fund inflows, expenditures, wallets, current balances, multisig configuration and authorized signers, together with the purpose and recipient of material expenditures.

Before the Helium IoT Network is materially wound down, transferred, or deprived of core infrastructure, this HIP also requires disclosure of what will happen to assets accumulated for IoT operations and who will assume responsibility for any continuing network obligations.

## Motivation

The IoT Operations Fund is not a new concept.

HIP 52, started January 4, 2022, established the IoT subDAO and allocated **7% of IOT emissions to an Operations Fund**.

HIP 52 described its purpose as enabling the IoT network to perform operations necessary to **"create and sustain network growth."** Its primary stated use included network transaction costs, with other contemplated uses including coverage incentives and incentives for oracles, manufacturers, and other activities supporting the IoT network.

Following HIP 138 and HIP 141, IOT token emissions ceased and Helium network rewards returned to HNT while the existing subnetwork reward structure continued in HNT.

HIP 149 subsequently expanded flows to the IoT Operations Fund. With IoT Proof-of-Coverage retired, the Fund now receives the former IoT PoC allocation, unused data-transfer allocation, and the IoT subDAO share of applicable additional HNT emissions.

The Helium Foundation has also publicly stated that the IoT Working Group manages 10% of the IoT Operations Fund for grants and initiatives supporting the IoT Network.

The Fund therefore represents several years of assets specifically allocated through Helium governance for IoT network operations and development.

However, the public HIP record does not provide a single authoritative accounting showing the **total amount received, total amount spent, current balance, wallets holding the assets, or custody and authorization structure**.

This information becomes particularly important before any material discontinuation of the infrastructure required to operate the Helium IoT Network or any wind-down of the Helium Foundation itself.

The Helium Foundation describes itself as the nonprofit steward of the Helium Network. Stewardship of a community-funded network should include transparent accounting for assets specifically allocated to operate that network.

## Stakeholders

This proposal affects:

- Helium IoT Hotspot operators;
- IoT network users and customers;
- HNT and veHNT holders;
- IoT Working Group members;
- Helium Foundation directors and officers;
- current IoT infrastructure operators;
- developers and businesses relying upon Helium LoRaWAN coverage; and
- any future organization assuming stewardship of the IoT Network.

## Detailed Explanation

### 1. Historical IoT Operations Fund Accounting

Within 30 days of passage, the Helium Foundation shall publish a reconciliation of the IoT Operations Fund from inception to the publication date.

At minimum this shall report:

| Item | Required disclosure |
|---|---|
| Original allocation | 7% Operations Fund allocation established by HIP 52 |
| IOT received | Total IOT allocated to the Fund |
| IOT disposition | Amount held, spent, transferred, burned, converted, or otherwise disposed of |
| HNT received | Total HNT subsequently allocated to the Fund |
| HIP 149 inflows | HNT received from retired PoC, data underflow, top-ups, or other mechanisms |
| Other income | Grants, transfers, investment income, or other assets received |
| Total expenditures | Cumulative spending since inception |
| Current assets | Current balances of HNT, IOT, SOL, USDC, fiat, or other material assets |
| Liabilities | Material outstanding obligations attributable to IoT operations |

The reconciliation shall distinguish **protocol allocations from actual funds received** so the community can independently reproduce the totals.

### 2. Wallet and Custody Disclosure

For every wallet or account that has held material IoT Operations Fund assets, disclose:

- public wallet address;
- assets received;
- current balance;
- material transfers in and out;
- whether it is a single-signature or multisignature wallet;
- multisig signing threshold;
- identity or organizational role of each authorized signer; and
- date and authority under which signers were appointed or changed.

**No private keys, seed phrases, or other secret key material shall be disclosed.**

Historical wallets must remain listed even if their current balance is zero.

### 3. Spending Disclosure

Publish an expenditure ledger showing, at minimum:

- date;
- amount and asset;
- USD value at time of expenditure where reasonably available;
- recipient;
- purpose;
- approving authority; and
- associated transaction ID or supporting record where available.

Expenditures may be grouped where individual disclosure would reveal legitimately confidential information, but material payments to related parties, directors, officers, Nova Labs, major contractors, or other Helium-affiliated entities must be separately identified.

### 4. Helium Foundation Financial Disclosure

Because the Helium Foundation has acted as steward of the Helium Network and administrator or custodian of network-related funds, it shall also publish annual financial summaries covering the period during which it administered the IoT Operations Fund.

These shall include:

- annual revenue;
- annual operating expenses;
- grants;
- compensation;
- contractors and professional services;
- payments to related parties;
- assets and liabilities;
- material transfers between the Foundation and Nova Labs or other affiliated entities; and
- the portion attributable to IoT operations.

Existing audited financial statements, tax filings, or equivalent records may satisfy this requirement where they contain the required information.

### 5. Current IoT Operations Budget

The Foundation shall identify the current cost of operating the core IoT network, including where applicable:

- regional routing infrastructure;
- LoRaWAN packet routing;
- oracles;
- backend infrastructure;
- cloud services;
- protocol engineering;
- operational personnel; and
- other services required to keep the network functional.

This provides the community with both the **assets available** and the **actual cost of continuing operation**.

### 6. Wind-Down or Transfer of the IoT Network

This HIP does not require that the IoT Network operate indefinitely.

It does require transparency before assets accumulated for IoT operations are repurposed while the network itself is materially discontinued.

Before terminating or materially reducing core IoT infrastructure, the responsible entities shall publish:

1. the date and scope of the proposed discontinuation;
2. infrastructure and services affected;
3. remaining IoT Operations Fund balance;
4. outstanding contractual obligations;
5. proposed disposition of remaining IoT Operations Fund assets;
6. whether another operator may assume the infrastructure;
7. whether the community may operate or fund the infrastructure independently; and
8. what software, credentials, domains, infrastructure, contracts, and other resources are necessary to permit continuity.

### 7. Foundation Wind-Down

If the Helium Foundation itself intends to dissolve, cease operations, or transfer its stewardship responsibilities, it shall first publish:

- final IoT Operations Fund accounting;
- current Foundation financial position;
- disposition of remaining IoT-designated assets;
- successor custodian, if any;
- transfer of relevant wallets and multisigs;
- transfer or preservation of IoT operational infrastructure; and
- the governance authority relied upon for each transfer.

Closing or reorganizing the Foundation shall not by itself constitute authorization to repurpose assets previously allocated through Helium governance for IoT operations.

## Drawbacks

This proposal creates administrative work and may require disclosure of information not previously reported in one place.

Some contracts or commercially sensitive expenditures may require limited redaction.

However, most token flows are already publicly traceable on-chain, and the additional burden is reasonable given the duration, purpose, and scale of the Operations Fund.

## Rationale and Alternatives

The alternative is to rely exclusively on community members to reconstruct the Fund from blockchain transactions, governance proposals, Foundation statements, and historical records.

That is insufficient because on-chain transactions do not necessarily identify:

- beneficial ownership;
- multisig signers;
- expenditure purpose;
- contracts;
- fiat conversions;
- off-chain assets;
- liabilities; or
- internal authorization.

The custodian is best positioned to provide this reconciliation, after which the community can independently verify the on-chain portions.

## Unresolved Questions

The principal unresolved figure is itself the reason for this HIP:

**What is the complete historical and current value of the IoT Operations Fund?**

The governance record establishes the allocation mechanisms, but an authoritative reconciliation of cumulative IOT and HNT received, expenditures, conversions, transfers, and current assets should be supplied by the Foundation and reconciled against the blockchain.

## Deployment Impact

No protocol changes are required unless additional on-chain transparency mechanisms are necessary.

Implementation consists primarily of publication and maintenance of the required financial, wallet, and operational records.


## Success Metrics

This HIP is successful when the community can independently answer:

- How much has the IoT Operations Fund received since inception?
- How much has been spent?
- What was it spent on?
- What assets remain?
- Where are they held?
- Who controls the wallets?
- What does the IoT network currently cost to operate?
- What happens to the remaining assets and infrastructure if IoT operations or the Helium Foundation are wound down?

## References

- HIP 52 — IOT subDAO
- HIP 138 — Return to HNT
- HIP 141 — Single-Token Governance and Helium Release Proposals
- HIP 149 — Helium Utility and Emissions Realignment