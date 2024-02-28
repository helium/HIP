# HIP XXX: Redefining the MOBILE Maker Approval Process

- Author: [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 2/27/2024
- Category: Technical & Economic
- Original HIP PR:
- Tracking Issue: 
- Voting Requirements: veMOBILE Holders

## Summary:

This Helium Improvement Proposal (HIP) defines the approval process and requirements for Manufacturers of MOBILE Hotspots and Access Points (MOBILE Makers) to get a Maker Key.

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

**MOBILE Makers** - Manufacturers wishing to create MOBILE hardware will be required to adhere to the requirements within this HIP.
**Manufacturer Compliance Committee (MCC)** - The MCC will need to ensure the requirements of this HIP are met prior to awarding a MOBILE Maker a Maker Key. 


## Detailed Explanation
This HIP imposes the following requirements MOBILE Makers must satisfy prior to them being given a Maker Key: 

- Approval of hardware design by the MCC as outlined in HIP [HIP 19](https://github.com/helium/HIP/blob/main/0019-third-party-manufacturers.md)
- The staking of 50M MOBILE tokens
- Approval from the MOBILE subDAO via veMOBILE vote with 67% approval once the requirements above are met
- The Maker must have the following minimum balances within their Maker Wallet:
  - $10,000 in DC
  - $10,000 worth of MOBILE at the Oracle Price at the time of deposit 

Once the above four (4) requirements are met, the MCC may award the MOBILE Maker a Maker Key.


Please note, approval of this HIP will serve as Nova Lab’s subDAO approval. As such, Nova Labs will have satisfied all four requirements to this HIP. 

### Rejection of Maker
If the Maker does not get approved by the MOBILE subDAO via veMOBILE vote, the 50M stake will be returned to that manufacturer within 30 days. 

### Stripping of Maker Keys
Upon HIP passing, the MCC will strip any MOBILE Maker’s Maker Key’s that have not satisfied the above requirements. 


## Issuing Keys
In order to join the blockchain, every Hotspot requires an onboarding code. This code is validated by an Onboarding Oracle and used to onboard a Hotspot/Access Point and pay the $40 onboard fee for Hotspots, $20 onboard fee for indoor Wi-Fi Access Points ($10 in DC and $10 in MOBILE), and $30 for outdoor Wi-Fi Access Points ($10 in DC and $20 in MOBILE). Currently, these codes are exclusively issued by the Helium Foundation and validated by their Onboarding Oracle at <staking.helium.foundation>.

Currently, manufacturers acquire codes from the Helium Foundation via a proprietary, manual process, with records of serial numbers or MAC addresses presumably kept by the Helium Foundation.

This HIP will impose the following changes in order for the manufacturer to acquirer an onboard code:

- Manufacturer must have an active Maker Key for the MOBILE subDAO
- The onboarding fee for each device must be burned 1:1 at the time of the request for the code. For example, if a manufacturer is requesting an onboarding code for 1 outdoor Wi-Fi Access Point, they will be required to burn 1,000,000 DC and $20 worth of MOBILE at the current Oracle Price from their Maker Wallet at the time of request.


Once the above requirements are met, the Helium Foundation may issue an onboard code.


## Deployment Impact:

Upon HIP passing, the MCC and Helium Foundation will need to do the following: 
- The MCC will revoke any Maker Keys for any Maker that do not satisfy the requirements of this HIP. 
- The Helium Foundation will create a new Onboard Code process in which the Maker is required to submit the transaction ID(s) of the corresponding burn for each new Onboard Code they are requesting. 
- The MCC will ensure they only award Maker Keys to MOBILE Makers who have satisfied the four (4) requirements noted within this HIP.
- For any onboarding codes obtained, but not used, these onboards will undergo the legacy process of requiring the burn at the time of onboarding. For new Onboard Codes issued, the workflow for onboarding a Hotspot/Access Point will need to be changed by the Helium Foundation to not require the onboarding fee be paid at the time of onboarding.

## Success Metrics:

This HIP is successful when only approved MOBILE Makers are allowed to have their hotspots onboarded to the Helium 5G subnetwork. 
