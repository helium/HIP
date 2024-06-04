# HIP 115: Redefining the MOBILE Maker Approval Process

- Author: [Andy Zyvoloski](https://github.com/heatedlime) & the Helium Foundation
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
This HIP imposes the Helium Foundation, on behalf of MOBILE Makers, to create a new MOBILE Maker Escrow Wallet in which the Maker will not have access to withdraw from. Additionally, MOBILE Makers must satisfy the below requirements prior to being awarded a Maker Key.  Please note, approval of this HIP will serve as Nova Lab’s subDAO approval.

### Requirements
1. Propose a HIP to become a MOBILE Maker
2. Work with the Helium Foundation and Firmware developers to ensure their firmware is compatible
3. Complete and publish penetration testing results of hardware
4. Provide evidence to the Helium Foundation they have the source of liquidity to provide the required stake
5. The HIP goes to vote and approval from the MOBILE subDAO via veMOBILE is granted with the current thresholds required of MOBILE governance (today, 67% approval and 100,000,000 veMOBILE vote power)
6. The Maker stakes a bond of MOBILE tokens (currently specified as 50,000,000 through HIP-53). Once the bond is staked, and requirements 1-5 above have been satisfied, a MOBILE Maker NFT will be issued to the MOBILE Maker. 
7. The Maker provides a copy of the Makers secure boot key in an escrow wallet held by the foundation
8. The Maker must have the following minimum balances within their Maker Wallet:
  - 10,000 USDC
  - 2 SOL
  - 1 MOBILE

Once all 8 above requirements have been satisfied, the Helium Foundation may issue a Maker Key to the MOBILE Maker

USDC maintained within the Maker Escrow Wallets will automatically be swapped/converted to MOBILE/HNT/DC, and then subsequently burned for each onboard.

The MOBILE Maker may only have one Maker Escrow wallet per 50M stake. 

## Ongoing MOBILE Maker Requirements
As a part of this HIP, MOBILE Makers will be required to keep a minimum balance of tokens within their Maker Escrow Wallet. The minimum balance was calculated to support at least 100 onboards for the highest onboarding fee ($40), and will be the same regardless of what type of device the Maker produces.

### Minimum Balance Requirements
|Required Solana Balance | Required USDC Balance|
|------------------------|----------------------|
| 0.1 SOL                | 4,000 USDC           |



## MOBILE Maker Slashing
A smart contract will be created to automatically slash the MOBILE Makers 50M stake if that MOBILE Maker does not maintain the minimum balances identified above. If the MOBILE Makers balance goes below the minimum threshold defined in this HIP, they will have 1 epoch to replenish their wallet before slashing occurs. If the wallet stays below the minimum threshold on the 2nd epoch, the smart contract will automatically burn 0.10% (50,000 MOBILE) of the 50M MOBILE stake. For each epoch that the wallet stays below the minimum balance, the percentage burned will increase by 0.01. For example, if a MOBILE Makers wallet is below the minimum balance, on the second epoch, 0.10% of the stake balance will be burned, on the third epoch, 0.11% of the remaining stake will be burned, on the fourth epoch, 0.12% of the remaining stake will be burned, and so on. If the balance is replenished above the minimum, and then falls again, the slash will reset to 0.10%.

The foundation and or the MOBILE subDAO may make a request, which must be approved by the subDAO, to slash the stake of MOBILE Makers if the MOBILE Maker fails to add software support or updates for essential operations, such as adding passpoint profiles of service providers in a timely manner, updating the software on the device if needed, etc. The slash will start at 0.10% on day one, and increase by .01% everyday until the foundation has determined the Maker has taken appropriate steps to remediate the problem. 

If the staked MOBILE balance falls under 30M MOBILE, the Maker Key will be revoked the same epoch the staked balance falls under 30M MOBILE. In order to reactivate their Maker Key, the Maker must replenish the staked balance to at least 50M.

## Retirement of a MOBILE Maker
In some instances, MOBILE Makers may wish to stop producing MOBILE devices, and request their stake be returned. In order for the stake to be returned to the MOBILE Maker, the following must occur:

- The Helium Foundation must conduct an audit to ensure the following:
  - The MOBILE Maker has issued a press release posted on their website that they are ceasing production and sales of said devices
  - The MOBILE Maker has stopped advertising such devices for sale, and will not sell any more to vendors or customers.
  - The MOBILE Maker will produce records that document total sales volume so the amount of sales can be reconciled against devices onboarded.
  - The Maker must transfer over their secure boot signing keys to the Helium Foundation
 
  Ultimately, the Helium Foundation will have the final say in determining whether the Maker has satisfied the above. 

The foundation will then require the wallet be replenished so at the time of the audit, the Maker Escrow Wallet holds at least enough tokens so that all remaining devices that have not been onboarded may be onboarded as of that date, plus an extra 1% to cover any swapping fees. For example, if a Maker has a total of 1000 indoor Wi-Fi access points that have yet to be onboarded, they will require to have at least 20,200 USDC within their Maker Escrow Wallet.

After the audit is complete, and the MOBILE Maker Escrow Wallet was funded to support the remaining onboards, the slashing smart contract will be removed, and the stake will be released no sooner than 60 epochs after the above requirements were met. If new information should arise within the 60 epochs that wasn't disclosed during the initial audit, the Helium Foundation may request a new audit.

## Migration of MOBILE Maker Wallets to MOBILE Maker Escrow Wallets
In instances where MOBILE Makers already have a pre-existing MOBILE Maker Wallet, all tokens from these wallets will be migrated to the Maker Escrow Wallet. This includes the data credits, which will be allowed a one-time contract endpoint to be transferred to the new program-owned escrow wallet. Further, regardless if a previous wallet will be used at first, a new MOBILE Maker Escrow Wallet must be created with the minimum wallet requirements noted above. The escrow wallet will use all held MOBILE and DC before exhausting its USDC.


## Deployment Impact

Upon HIP passing, the Helium Foundation will need to do the following: 

### Phase 1 
- 30 epochs after HIP passing, the Helium Foundation will strip any MOBILE Maker’s Maker Key’s that have not been approved by the subDAO and have not staked 50M MOBILE. The removal of the MOBILE Makers key will prevent any more hotspots from that MOBILE Maker from being onboarded. 

### Phase 2 
-   Makers must fund their existing onboarding wallet with the required USDC to meet the requirements of this HIP. Makers will have 30 epochs to supply the required funds, or their maker keys will be revoked.
-   The Helium Foundation will create a new MOBILE Maker Escrow Wallet in which MOBILE Makers will have to deposit funds to onboard their devices, and Makers will not have access to withdraw funds.
-   The Helium Foundation will implement a way for USDC balances to automatically be swapped/converted to MOBILE/HNT/DC at market value, which will then be burned to pay for the MOBILE and DC onboarding fee for each device.

Note that the funds can be gathered into the existing onboarding wallets without the smart contracts having been completed.

### Phase 3
- All mobile onboarding wallets will be migrated to the new MOBILE Maker Escrow Wallets, taking with it all MOBILE, USDC, and DC tokens.
- The MOBILE Maker Escrow related smart contracts will be deployed
- All new onboards on the mobile network will happen through the excrow wallet
- These changes may require a big-bang update to all mobile maker apps

 ### Phase 4 
- The Helium Foundation will create a slashing smart contract to slash the MOBILE stake of MOBILE Makers who do not meet the minimum wallet balances set forward within this HIP.
- The Helium Foundation will create a way to replenish a stake if it falls below 50M MOBILE.
- The Helium Foundation will implement a way to withdraw funds in the case of retirement. This withdrawal will require the signoff of the Helium Program Multisig.

If a MOBILE Maker's wallet falls below the minimum balance thresholds before Phase 3 is implemented, slashing will start on the first epoch of implementation.

### After Implementation 
- The Helium Foundation will ensure they only award Maker Keys to MOBILE Makers who have satisfied all requirements noted within this HIP.

## Success Metrics:

This HIP is successful when only approved MOBILE Makers are allowed to have their hotspots onboarded to the Helium MOBILE subnetwork. 
