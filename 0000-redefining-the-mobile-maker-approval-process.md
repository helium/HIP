# HIP XXX: Redefining the MOBILE Maker Approval Process

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2/27/2024
- Category: Technical & Economic
- Original HIP PR:
- Tracking Issue: 
- Voting Requirements: veMOBILE Holders

## Summary:

This Helium Improvement Proposal (HIP) defines the approval process and requirements for Manufacturers of MOBILE CBRS Hotspots and Access Points (MOBILE Makers) to get a Maker Key.

## Previous Related HIPs

- [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md) documents the current requirements manufacturers must undergo to be approved for a Maker Key
- [HIP 53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) lays out the foundation and requirements for MOBILE Makers to produce equipment eligible to work with the Helium 5G Network.
- [HIP 96](https://github.com/helium/HIP/blob/main/0096-wifi-ap-onboarding-structure.md) introduces new onboarding fees for Wi-Fi Access Points

## Motivation:
[HIP 53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md) lays out the foundation and requirements that MOBILE Makers adhere to in order to produce equipment eligible to work with the Helium 5G Network. These requirements include manufactures hold a MOBILE NFT, which requires:

- Stake a minimum of 50M MOBILE 
- Obtain MOBILE DAO governance approval

In the case of Bobcat and Nebra, both have produced a 5G Hotspot; however, neither have satisfied either requirements above.

## Stakeholders:

- **MOBILE Makers** - Manufacturers wishing to create MOBILE hardware will be required to adhere to the requirements within this HIP.


## Detailed Explanation
This HIP imposes MOBILE Makers must create a new MOBILE Maker Escrow Wallet in which they will not have access to withdraw funds from. Additionally, MOBILE Makers must satisfy the four below requirements prior to being awarded a Maker Key. This HIP will classify MOBILE Makers into three (3) tiers.  Please note, approval of this HIP will serve as Nova Lab’s subDAO approval. As such, Nova Labs will have satisfied all four requirements to this HIP.


### MOBILE CBRS Hotspots Only (Tier 3)
1. Approval of hardware design by the Helium Foundation as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
2. Approval from the MOBILE subDAO via veMOBILE vote with 67% approval
3. The staking of 50M MOBILE tokens
4. The Maker must have the following minimum balances within their Maker Wallet:
  - 1,000,000,000 DC
  - 2 SOL
  - 1 MOBILE

### Wi-Fi Access Points Only (Tier 2)
1. Approval of hardware design by the Helium Foundation as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
2. Approval from the MOBILE subDAO via veMOBILE vote with 67% approval
3. The staking of 50M MOBILE tokens
4. The Maker must have the following minimum balances within their Maker Wallet:
  - 200,000,000 DC
  - 5 SOL
  - $4,000 worth of MOBILE at the time of deposit

### Both MOBILE CBRS Hotspots and Wi-Fi Access Points (Tier 1)
1. Approval of hardware design by the Helium Foundation as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
2. Approval from the MOBILE subDAO via veMOBILE vote with 67% approval
3. The staking of 50M MOBILE tokens
4. The Maker must have the following minimum balances within their Maker Wallet:
  - 1,200,000,000 DC
  - 5 SOL
  - $4,000 worth of MOBILE at the time of deposit

Please note, in instances where a MOBILE Maker has subsidiaries that create different devices (e.g. one subsidiary that creates MOBILE CBRS Hotspots, and one subsidiary that creates Wi-Fi Access Points), only one stake of 50M MOBILE tokens is needed for both subsidiaries. The MOBILE Maker can choose to have one combined wallet for the parent company, or separate wallets for each subsidiary. In instances where the MOBILE Maker chooses to have separate wallets, they will be classified separately as both a Tier 3 and a Tier 2 MOBILE Maker for each subsidiary.

## Stripping of Maker Keys
Upon HIP passing, the MCC will strip any MOBILE Maker’s Maker Key’s that have not satisfied the above requirements. The removal of the MOBILE Makers key will prevent any more hotspots from that MOBILE Maker from being onboarded.

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
A smart contract will be created to automatically slash the MOBILE Makers 50M stake if that MOBILE Maker does not maintain the minimum balances identified above. If the MOBILE Makers balance goes below the minimum threshold defined in this HIP, they will have 1 epoch to replenish their wallet before slashing occurs. If the wallet stays below the minimum threshold on the 2nd epoch, the smart contract will automatically burn 0.10% (50,000 MOBILE) of the 50M MOBILE stake. For each epoch that the wallet stays below the minimum balance, the percentage burned will increase by 0.01. For example, if a MOBILE Makers wallet is below the minimum balance, on the second epoch, 0.10% of the stake balance will be burned, on the third epoch, 0.11% of the remaining stake will be burned, on the fourth epoch, 0.12% of the remaining stake will be burned, and so on.

## Retirement of a MOBILE Maker
In some instances, MOBILE Makers may wish to stop producing MOBILE devices, and request their stake be returned. In order for the stake to be returned to the MOBILE Maker, the following must occur:

- The Helium Foundation must conduct an audit to ensure the following:
  - The MOBILE Maker has issued a press release posted on their website that they are ceasing production and sales of said devices
  - The MOBILE Maker and any of its affiliates have stopped advertising such devices for sale
  - The MOBILE Maker will produce records that document total sales volume so the amount of sales can be reconciled against devices onboarded. The foundation will then require the wallet be replenished so at the time of the audit, the Maker Escrow Wallet holds at least enough tokens so that all remaining devices that have not been onboarded may be onboarded.

After the audit is complete, and the MOBILE Maker Escrow Wallet was funded to support the remaining onboards, the slashing smart contract will be removed, and the stake will be released no sooner than 60 epochs after the above requirements were met. If new information should arise within the 60 epochs that wasn't disclosed during the initial audit, the Helium Foundation may request a new audit.

## Migration of MOBILE Maker Wallets to MOBILE Maker Escrow Wallets
In instances where MOBILE Makers already have a pre-existing MOBILE Maker Wallet, they may continue to use that wallet for onboarding until the balance of DC is 0; however, a new MOBILE Maker Escrow Wallet must be created with the minimum wallet requirements noted above. 


## Deployment Impact:

Upon HIP passing, the Helium Foundation will need to do the following: 
- The Helium Foundation will revoke any Maker Keys for any Maker that do not satisfy the requirements of this HIP.
- The Helium Foundation will create a new MOBILE Maker Escrow Wallet type that MOBILE Makers can request.
- The Helium Foundation will create a slashing smart contract to slash the MOBILE stake of MOBILE Makers who do not adhere to the requirements of this HIP.
- The Helium Foundation will ensure they only award Maker Keys to MOBILE Makers who have satisfied the four (4) requirements noted within this HIP.


## Success Metrics:

This HIP is successful when only approved MOBILE Makers are allowed to have their hotspots onboarded to the Helium 5G subnetwork. 
