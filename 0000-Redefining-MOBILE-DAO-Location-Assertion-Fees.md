 # Helium HIP - Redefining MOBILE DAO Location Assertion Fees
- HIP Number: HIP-XXXX
- Author: Andy Zyvoloski & Max Gold
- Start Date: 10/2/2023
- Category: Technical & Economic
- Original HIP PR: 
- Tracking Issue: 
- Voting Requirements: veMOBILE

## Summary 
This HIP proposes changing the currency and lowering the MOBILE location assert fees for Helium 5G Compatible Hotspots and Wi-Fi Access Points (APs) to $5 in MOBILE token burn per assertion.

## Motivation 
Currently, Location Assert and Reassert Fees are paid by burning HNT tokens to create Data Credits (DC), and then the DC is then burned to pay the fee. However, there is no economic benefit to the MOBILE subDAO under [HIP-51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md) to pay for Location Assert fees using DC, as none of the burned tokens accrue back to the subDAO or increase the subDAO's DAO Utility Score. This proposal seeks to address this issue by transitioning the method of payment to MOBILE tokens, while also making it cheaper for deployers to move their equipment to new locations.

## Stakeholders
MOBILE Hotspot and Wi-Fi AP Deployers - This stakeholder is impacted as it lowers the cost to relocate their coverage devices, and requires the fees be paid in MOBILE.

MOBILE Holders - This stakeholder is impacted as the burning of MOBILE for each relocation will effectively decreasing the total supply of MOBILE. 

MOBILE Hotspot and Wi-Fi AP Makers - This stakeholder is impacted as they will now need to hold MOBILE within their maker wallet to pay for the first location assert for each MOBILE Hotspot and Wi-Fi AP.

Helium (HNT) Token Holders - This stakeholder is impacted as less DC will be burned upon implementation.

## Detailed Explanation 
This HIP would change how location assert fees are currently paid. Prior to the implementation of this HIP, each MOBILE Hotspot and or Wi-Fi AP is required to burn an initial location assert fee of $10 in DC. Additionally, each time a deployer wants to move their MOBILE Hotspot or Wi-Fi AP, they are required to burn an additional $10 in DC burn to reassert their location. This DC burn does not directly benefit the MOBILE subDAO, as location assert fees do not impact the DAO Utility Score created in [HIP51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md). 

Instead of the current process described above, this HIP proposes that Location Assert Fees be paid by burning $5 worth of MOBILE tokens at the current oracle price instead of DC. The change will be affected by modifying the relevant code within the Helium network core implementation. This modification will ensure that only MOBILE tokens are accepted for Location Assert Fees.

Data credits will not be utilized in this process. Instead, a straight burn of MOBILE tokens will be implemented.


#### Flowchart of Burn Transactions

1. User initiates a Location Assert Fee transaction.
2. The transaction sends the required amount of MOBILE tokens, based on the current oracle value, to the burn wallet address. 
3. MOBILE tokens are burned, effectively removing them from circulation.
4. The Location Assert Fee transaction is recorded on the blockchain.

## Drawbacks
One drawback is makers will now have to hold both MOBILE and DC in their maker wallets for each MOBILE Hotspot and Wi-Fi initial assertion. However, a new proposal under [HIP-96](https://github.com/helium/HIP/blob/main/0096-wifi-ap-onboarding-structure.md) would require a combination burn of MOBILE and DC to onboard MOBILE Hotspots and Wi-Fi Access points if passed. Thus, the impact on makers is limited.

Another drawback is currently, the treasury swap function within the Helium wallet only allows the swapping of MOBILE to HNT, and not the other way around. Thus, if any hotspot owners needed more MOBILE to complete the assertion, it will need to be obtained on the secondary market.

## Alternatives
Do nothing - keep the MOBILE location assert fee for MOBILE to $10
Lower fee - Lower the MOBILE location assert fee to $5 in DC
Change initial assertion fee payment - Lower the MOBILE location assertion fee to $5, and require the first location assert fee paid by makers to be paid in DC, while all subsequent location assert fees be paid in MOBILE burn

## Deployment Impact:

This change will require changes to the Helium blockchain core implementation to accept MOBILE tokens instead of HNT/DC tokens for Location Assert Fees.  The same burn wallet utilized by the Treasury Fund Swaps may be used or a different wallet, as advised by the Foundation's core team of engineers.


## Success Metrics
This HIP will be noted as successful once a MOBILE deployer can pay their location assert fees in MOBILE. 
