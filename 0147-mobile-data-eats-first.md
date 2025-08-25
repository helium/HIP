# HIP 147: Mobile Data Eats First

- Author: [@ferebee](https://github.com/ferebee)
- Start Date: 2025-08-20
- Category: Economic, Technical
- Original HIP PR: [#1182](https://github.com/helium/HIP/pull/1182)
- Tracking Issue: [#1183](https://github.com/helium/HIP/issues/1183)
- Voting Requirement: veHNT Holders

---

## Summary

Currently, 20% of the HNT emissions to the Mobile network are reserved for PoC (Proof-of-Coverage) rewards, as defined in [HIP-53][hip-53]. Data Transfer is rewarded pro-rata from the 40% Data Transfer bucket, with anything left over added to the PoC bucket.

Since the recent halving, Data Transfer has been increasing, while HNT prices have been volatile. This means the 40% of HNT emissions allocated to Mobile may sometimes be insufficient to reward Hotspots 1:1 for their actual Data Transfer contribution. Meanwhile, the time it takes for useful deployments to be selected for offload is decreasing. Developments such as Utility Probing, as proposed in [HIP-145][hip-145], are expected to reduce that time even further.

Therefore, PoC rewards are no longer the primary driver of network growth. Data Transfer is the ultimate proof of utility.

Under this proposal, the 20% reservation of emissions for PoC would be removed. Instead, up to 60% of HNT emissions to Mobile would be used to reward Hotspots for Data Transfer pro-rata. Any remaining emissions would be distributed as PoC rewards.

## Motivation

The success of the Helium Mobile network depends on Data Transfer. PoC was an important motivator of deployment in the early stages of the network, but now that Hotspots that meet the needs of carrier partners can often earn Data Transfer rewards within weeks, PoC is less important.

The best motivator of network buildout is to reward actual utility, so Data Transfer should be rewarded first. Any leftover emissions can still be used as an additional incentive for desirable installations, as specified by the evolving rules of PoC.

## Stakeholders

This proposal primarily affects deployers in the Mobile network. When the network is processing a lot of data (high utility) but HNT prices are low, their deployments will receive greater rewards for Data Transfer and fewer rewards for PoC.

## Detailed Explanation

Under this proposal, the 20% reservation of HNT emissions to the Mobile network for PoC will be removed. Rewards for Data Transfer will be prioritized over rewards for PoC.

As before, if there is no Data Transfer in an Epoch, 60% of emissions to Mobile will be distributed as PoC rewards.

However, if the dollar value of Data Transfer (DC Burn) exceeds the dollar value of 60% of HNT emissions to the Mobile network, then PoC rewards to Mobile Hotspots will be zero, and the entire 60% will be distributed pro-rata among Hotspots for Data Transfer.

### Examples

The following tables show possible daily reward distributions in USD at various HNT market prices. They compare “legacy” rules (HIP-53) with the “new” rules proposed here.

**Assumptions:**
- Daily issuance: 20,547.95 HNT plus 1,644 HNT Net Emissions
- Protocol Score: 82% Mobile vs. 18% IOT  
- Data Transfer price: $0.50 per GB

**Column explanations:**
- **PoC/HS**: Average PoC rewards per Helium Mobile (greenfield) Hotspot, assuming 30,000/60,000 total Hotspots are participating
- **$USD/GB**: Effective rate at which Hotspots (both greenfield and brownfield) earn for Rewardable Data

<table>
  <thead>
    <tr>
      <th colspan="11" align="center">Current network: 30,000 Hotspots with PoC, 40 TB daily Data Transfer</th>
    </tr>
    <tr>
      <td></td>
      <td align="center">&nbsp;&nbsp;</td>
      <td colspan="4" align="center">legacy: 20% PoC reservation</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td colspan="4" align="center">new: no PoC reservation</td>
    </tr>
    <tr>
      <th align="left">HNT price</th>
      <th align="center">&nbsp;&nbsp;</th>
      <th align="right">total PoC</th>
      <th align="right">PoC/HS</th>
      <th align="right">total Data</th>
      <th align="right">$USD/GB</th>
      <th align="center">&nbsp;&nbsp;</th>
      <th align="right">total PoC</th>
      <th align="right">PoC/HS</th>
      <th align="right">total Data</th>
      <th align="right">$USD/GB</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th align="left" scope="row">$1</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$3,639</td>
      <td align="right">$0.12</td>
      <td align="right">$7,279</td>
      <td align="right">$0.18</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$0</td>
      <td align="right">$0.00</td>
      <td align="right">$10,918</td>
      <td align="right">$0.27</td>
    </tr>
    <tr>
      <th align="left" scope="row">$2</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$7,279</td>
      <td align="right">$0.24</td>
      <td align="right">$14,558</td>
      <td align="right">$0.36</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$1,837</td>
      <td align="right">$0.06</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
    </tr>
    <tr>
      <th align="left" scope="row">$3</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$12,755</td>
      <td align="right">$0.43</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$12,755</td>
      <td align="right">$0.43</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
    </tr>
    <tr>
      <th align="left" scope="row">$5</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$34,592</td>
      <td align="right">$1.15</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$34,592</td>
      <td align="right">$1.15</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
    </tr>
    <tr>
      <th align="left" scope="row">$10</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$89,184</td>
      <td align="right">$2.97</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$89,184</td>
      <td align="right">$2.97</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
    </tr>
    <tr>
      <th align="left" scope="row">$20</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$198,369</td>
      <td align="right">$6.61</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$198,369</td>
      <td align="right">$6.61</td>
      <td align="right">$20,000</td>
      <td align="right">$0.50</td>
    </tr>
  </tbody>
</table>


<table>
  <thead>
    <tr>
      <th colspan="11" align="center">Future network: 60,000 Hotspots with PoC, 120 TB daily Data Transfer</th>
    </tr>
    <tr>
      <td></td>
      <td align="center">&nbsp;&nbsp;</td>
      <td colspan="4" align="center">legacy: 20% PoC reservation</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td colspan="4" align="center">new: no PoC reservation</td>
    </tr>
    <tr>
      <th align="left">HNT price</th>
      <th align="center">&nbsp;&nbsp;</th>
      <th align="right">total PoC</th>
      <th align="right">PoC/HS</th>
      <th align="right">total Data</th>
      <th align="right">$USD/GB</th>
      <th align="center">&nbsp;&nbsp;</th>
      <th align="right">total PoC</th>
      <th align="right">PoC/HS</th>
      <th align="right">total Data</th>
      <th align="right">$USD/GB</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th align="left" scope="row">$1</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$3,639</td>
      <td align="right">$0.06</td>
      <td align="right">$7,279</td>
      <td align="right">$0.06</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$0</td>
      <td align="right">$0.00</td>
      <td align="right">$10,918</td>
      <td align="right">$0.09</td>
    </tr>
    <tr>
      <th align="left" scope="row">$2</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$7,279</td>
      <td align="right">$0.12</td>
      <td align="right">$14,558</td>
      <td align="right">$0.12</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$0</td>
      <td align="right">$0.00</td>
      <td align="right">$21,837</td>
      <td align="right">$0.18</td>
    </tr>
    <tr>
      <th align="left" scope="row">$3</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$10,918</td>
      <td align="right">$0.18</td>
      <td align="right">$21,837</td>
      <td align="right">$0.18</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$0</td>
      <td align="right">$0.00</td>
      <td align="right">$32,755</td>
      <td align="right">$0.27</td>
    </tr>
    <tr>
      <th align="left" scope="row">$5</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$18,197</td>
      <td align="right">$0.30</td>
      <td align="right">$36,395</td>
      <td align="right">$0.30</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$0</td>
      <td align="right">$0.00</td>
      <td align="right">$54,592</td>
      <td align="right">$0.45</td>
    </tr>
    <tr>
      <th align="left" scope="row">$10</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$49,184</td>
      <td align="right">$0.82</td>
      <td align="right">$60,000</td>
      <td align="right">$0.50</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$49,184</td>
      <td align="right">$0.82</td>
      <td align="right">$60,000</td>
      <td align="right">$0.50</td>
    </tr>
    <tr>
      <th align="left" scope="row">$20</th>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$158,369</td>
      <td align="right">$2.64</td>
      <td align="right">$60,000</td>
      <td align="right">$0.50</td>
      <td align="center">&nbsp;&nbsp;</td>
      <td align="right">$158,369</td>
      <td align="right">$2.64</td>
      <td align="right">$60,000</td>
      <td align="right">$0.50</td>
    </tr>
  </tbody>
</table>


## Drawbacks

The assumption behind this proposal is that deployers will be encouraged to create maximal utility for the network if the network prioritizes rewarding Data Transfer.

However, if PoC rewards can encourage deployments that don’t achieve attractive rewards from Data Transfer but are still valuable to the network, then this proposal might discourage such deployments. This would depend on market conditions and the total utility of the network.

## Rationale and Alternatives

There is strong support in the community to reward Data Transfer 1:1 as much as possible. However, under this proposal, depending on market conditions, Hotspots might not earn any rewards from PoC at all until selected for carrier offload. Their rewards would be limited to their offload for Helium Mobile subscribers.

It has been proposed that Hotspots could receive some form of UBI until they are accepted or rejected for carrier offload.

On the other hand, if carriers can reduce the time it takes to make an offload decision, perhaps with help from Utility Probing, it might serve the community better to focus deployers’ attention as much as possible on Data Transfer.

## Unresolved Questions

Are there situations where deployments that bring value to the network can only be sustained through PoC?

## Deployment Impact

Core developers have completed the necessary code for inclusion in HRP-2025-09, conditional on the approval of this proposal.

## Success Metrics

This proposal will be successful if the promise of increased rewards under adverse market conditions encourages useful deployments.

[hip-53]: https://github.com/helium/HIP/blob/main/0053-mobile-dao.md
[hip-145]: https://github.com/helium/HIP/blob/main/0145-utility-probing.md
