# HIP 115: Redefining the MOBILE Maker Approval Process

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Contributor: [Groot](https://github.com/mawdegroot)
- Start Date: 2024-03-25
- Category: Technical, Economic
- Original HIP PR: [#921](https://github.com/helium/HIP/pull/921)
- Tracking Issue: [#957](https://github.com/helium/HIP/issues/957)
- Voting Requirements: veMOBILE Holders

---

## Summary

This Helium Improvement Proposal (HIP) defines the approval process and requirements for Manufacturers of MOBILE CBRS Hotspots and Access Points (MOBILE Makers) to get and retain a Maker Key, which will allow their Hotspots and Access Points to be onboarded.

## Previous Related HIPs

- [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md) documents the current requirements manufacturers must undergo to be approved for a Maker Key
- [HIP 53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) lays out the foundation and requirements for MOBILE Makers to produce equipment eligible to work with the Helium 5G Network.
- [HIP 96](https://github.com/helium/HIP/blob/main/0096-wifi-ap-onboarding-structure.md) introduces new onboarding fees for Wi-Fi Access Points

## Motivation
[HIP 53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) lays out the foundation and requirements that MOBILE Makers adhere to in order to produce equipment eligible to work with the Helium 5G Network. These requirements include manufactures hold a MOBILE NFT, which requires:

- Stake a minimum of 50M MOBILE 
- Obtain MOBILE DAO governance approval

In the case of Bobcat and Nebra, both have produced a 5G Hotspot; however, neither have satisfied either requirements above.

## Stakeholders

- **MOBILE Makers** - Manufacturers wishing to create MOBILE hardware will be required to adhere to the requirements within this HIP.
- **MOBILE Deployers** - MOBILE deployers who purchase 5G equipment from non-compliant MOBILE Makers may be unable to onboard their equipment, and will need to request a refund with the manufacturer.


## Detailed Explanation
This HIP imposes the Helium Foundation, on behalf of MOBILE Makers, to create a new MOBILE Maker Escrow Wallet in which the Maker will not have access to withdraw from. Additionally, MOBILE Makers must satisfy the five below requirements prior to being awarded a Maker Key. This HIP will classify MOBILE Makers into three (3) tiers.  Please note, approval of this HIP will serve as Nova Lab’s subDAO approval.

### MOBILE CBRS Hotspots Only (Tier 3)
1. Approval of hardware design by the Helium Foundation as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
2. Approval from the MOBILE subDAO via veMOBILE vote with 67% approval
3. The staking of 50M MOBILE tokens
4. Provide a copy of the Makers secure boot key in an escrow wallet held by the foundation
5. The Maker must have the following minimum balances within their Maker Wallet:
  - 1,000,000,000 DC
  - 2 SOL
  - 1 MOBILE

### Wi-Fi Access Points Only (Tier 2)
1. Approval of hardware design by the Helium Foundation as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
2. Approval from the MOBILE subDAO via veMOBILE vote with 67% approval
3. The staking of 50M MOBILE tokens
4. Provide a copy of the Makers secure boot key in an escrow wallet held by the foundation
5. The Maker must have the following minimum balances within their Maker Wallet:
  - 200,000,000 DC
  - 5 SOL
  - $4,000 worth of MOBILE at the time of deposit

### Both MOBILE CBRS Hotspots and Wi-Fi Access Points (Tier 1)
1. Approval of hardware design by the Helium Foundation as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
2. Approval from the MOBILE subDAO via veMOBILE vote with 67% approval
3. The staking of 50M MOBILE tokens
4. Provide a copy of the Makers secure boot key in an escrow wallet held by the foundation
5. The Maker must have the following minimum balances within their Maker Wallet:
  - 1,200,000,000 DC
  - 5 SOL
  - $4,000 worth of MOBILE at the time of deposit

Please note, in instances where a MOBILE Maker has subsidiaries that create different devices (e.g. one subsidiary that creates MOBILE CBRS Hotspots, and one subsidiary that creates Wi-Fi Access Points), only one stake of 50M MOBILE tokens is needed for both subsidiaries. The MOBILE Maker can choose to have one combined wallet for the parent company, or separate wallets for each subsidiary. In instances where the MOBILE Maker chooses to have separate wallets, they will be classified separately as both a Tier 3 and a Tier 2 MOBILE Maker for each subsidiary.

## Ongoing MOBILE Maker Requirements
As a part of this HIP, MOBILE Makers will be required to keep a minimum balance of tokens within their Maker Escrow Wallet, depending on their Tier. The minimum balance will be calculated to support at least 100 onboards, and are as followed:

### Tier 3
- 0.5 SOL
- 500,000,000 DC

### Tier 2
- 0.5 SOL
- 100,000,000 DC
- $2,000 worth of MOBILE*

### Tier 1
- 0.5 SOL
- 600,000,000 DC
- $2,000 worth of MOBILE*

*As the onboard fee for Wi-Fi Access Points are not set in a fixed amount of MOBILE, the amount of MOBILE a MOBILE Maker may need in their wallet may fluctuate. Therefore, on the first epoch of every quarter at 0:00:00 UTC, a snapshot of the MOBILE price from the MOBILE Price Oracle will be saved and that price will be used to determine the MOBILE requirement for the remaining quarter.

For example, if on the first epoch of the quarter at 0:00:00 UTC, the MOBILE Price Oracle lists MOBILE price at $0.004 per MOBILE, a Tier 1 & 2 MOBILE Maker will be required to hold at least 500,000 MOBILE tokens.

## MOBILE Maker Slashing
A smart contract will be created to automatically slash the MOBILE Makers 50M stake if that MOBILE Maker does not maintain the minimum balances identified above. If the MOBILE Makers balance goes below the minimum threshold defined in this HIP, they will have 1 epoch to replenish their wallet before slashing occurs. If the wallet stays below the minimum threshold on the 2nd epoch, the smart contract will automatically burn 0.10% (50,000 MOBILE) of the 50M MOBILE stake. For each epoch that the wallet stays below the minimum balance, the percentage burned will increase by 0.01. For example, if a MOBILE Makers wallet is below the minimum balance, on the second epoch, 0.10% of the stake balance will be burned, on the third epoch, 0.11% of the remaining stake will be burned, on the fourth epoch, 0.12% of the remaining stake will be burned, and so on. If the balance is replenished above the minimum, and then falls again, the slash will reset to 0.10%.

The foundation and or the MOBILE subDAO may make a request, which must to be approved by the subDAO, to slash the stake of MOBILE Makers if the MOBILE Maker fails to add software support or updates for essential operations, such as adding passpoint profiles of service providers in a timely manner, updating the software on the device if needed, etc. The slash will start at 0.10% on day one, and increase by .01% everyday until the foundation has determined the Maker has taken appropriate steps to remediate the problem. 

If the staked MOBILE balance falls under 30M MOBILE, the Maker Key will be revoked the same epoch the staked balance falls under 30M MOBILE. In order to reactivate their Maker Key, the Maker must replenish the staked balance to at least 50M.

## Retirement of a MOBILE Maker
In some instances, MOBILE Makers may wish to stop producing MOBILE devices, and request their stake be returned. In order for the stake to be returned to the MOBILE Maker, the following must occur:

- The Helium Foundation must conduct an audit to ensure the following:
  - The MOBILE Maker has issued a press release posted on their website that they are ceasing production and sales of said devices
  - The MOBILE Maker has stopped advertising such devices for sale, and will not sell any more to vendors or customers.
  - The MOBILE Maker will produce records that document total sales volume so the amount of sales can be reconciled against devices onboarded.
  - The Maker must transfer over their secure boot signing keys to the Helium Foundation
 
  Ultimately, the Helium Foundation will have the final say in determining whether the Maker has satisfied the above. 

The foundation will then require the wallet be replenished so at the time of the audit, the Maker Escrow Wallet holds at least enough tokens so that all remaining devices that have not been onboarded may be onboarded as of that date.

After the audit is complete, and the MOBILE Maker Escrow Wallet was funded to support the remaining onboards, the slashing smart contract will be removed, and the stake will be released no sooner than 60 epochs after the above requirements were met. If new information should arise within the 60 epochs that wasn't disclosed during the initial audit, the Helium Foundation may request a new audit.

## Migration of MOBILE Maker Wallets to MOBILE Maker Escrow Wallets
In instances where MOBILE Makers already have a pre-existing MOBILE Maker Wallet, they may continue to use that wallet for onboarding until the balance of DC is 0; however, a new MOBILE Maker Escrow Wallet must be created with the minimum wallet requirements noted above. 


## Deployment Impact

Upon HIP passing, the Helium Foundation will need to do the following: 

### Phase 1 
- 30 epochs after HIP passing, the Helium Foundation will strip any MOBILE Maker’s Maker Key’s that have not been approved by the subDAO and have not staked 50M MOBILE. The removal of the MOBILE Makers key will prevent any more hotspots from that MOBILE Maker from being onboarded. 

### Phase 2 
-   The Helium Foundation will create a new MOBILE Maker Escrow Wallet type that MOBILE Makers can request. Within 30 epochs of creation of said wallet, MOBILE Makers will be required to fund their new wallet with the minimum balance requirements outlined within this HIP. If a new MOBILE Maker is approved by the subDAO and has staked 50M prior to the implementation of phase 2, they will be required to fund their new wallet once implemented within 30 epochs of creation of said wallet.

 ### Phase 3 
- The Helium Foundation will create a slashing smart contract to slash the MOBILE stake of MOBILE Makers who do not meet the minimum wallet balances set forward within this HIP. The foundation will need to ensure that the smart contract pulls the MOBILE price from the MOBILE price Oracle on the first epoch of the quarter at 0:00:00 UTC, and use that MOBILE price for the duration of the epochs within that quarter.
- The Helium Foundation will create a way to replenish a stake if it falls below 50M MOBILE.

If a MOBILE Maker's wallet falls below the minimum balance thresholds before Phase 3 is implemented, slashing will start on the first epoch of implementation.

### After Implementation 
- The Helium Foundation will ensure they only award Maker Keys to MOBILE Makers who have satisfied the five requirements noted within this HIP.

## Success Metrics:

This HIP is successful when only approved MOBILE Makers are allowed to have their hotspots onboarded to the Helium 5G subnetwork. 
