# HIP XXX: Implement CBRS CPI Fee

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) 
- Start Date: 12/31/2023
- Category: Economic, Technical
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veMOBILE Holders

## Summary:
This Helium Improvement Proposal (HIP) proposes requiring a fee, in HNT, be paid by deployers to the MOBILE subDAO Treasury to submit new Certified Professional Installer (CPI) information to Spectrum Access System (SAS) for outdoor CBRS Radios. 

## Motivation:
Currently, the IOT subDAO requires a fee whenever you move your Lorawan Hotspot; however, there are currently no fees associated with moving your CBRS radio. This HIP proposes establishing a required fee paid in HNT directly to the MOBILE subDAO Treasury, and a fee paid (upon request), to the entity reviewing the CPI submission, if requested. 

## Stakeholders:
The stakeholders of this proposal are:

- **CBRS Deployers** will be required to pay a fee when they move their radio or onboard a new radio
- **HNT Holders** will benefit from increased demand of HNT to pay fees
- **MOBILE Holders** will benefit with an increased value in terms of MOBILE/HNT Treasury swap rate.

## Detailed Explanation:
Currently, the only way the MOBILE subDAO treasury is funded is by daily HNT emissions based on the DAO utility score introduced in [HIP 51](https://github.com/helium/HIP/blob/main/0051-helium-dao.md). This HIP establishes supplemental funding to the MOBILE subDAO Treasury by requiring a $20 (at HNT Oracle Price) fee be paid in HNT to the MOBILE subDAO Treasury for any new CPI submissions. From calculations based on Q4 2023 data of the MOBILE subDAO Treasury, an addition of $20 worth of HNT to the Treasury increases the MOBILE/HNT swap rate more than a reduction of a $20 MOBILE burn. Therefore, in this scenario, it makes more sense to help fund the MOBILE subDAO Treasury than to burn MOBILE tokens.

## CPI Requirements
If the CPI information is rejected, the submitter will have up to two (2) additional submissions to re-submit the correct information. If the submission is rejected two more times after the initial rejection, a new fee will be required to be paid.  

This HIP also grants authority to the CPI reviewer to collect up to a $20 fee also paid in HNT, with the following stipulations/requirements: 

- The CPI submission must be approved or rejected within 2 business days
- A guide must be created that documents each reason a submission may be rejected (i.e. incorrect height, incorrect azimuth, outdoor radio installed indoors, etc.)
- If the CPI submission is rejected for a reason that is not noted within the guide, the re-submission may be redone for free, and not counted towards the limit of 3 rejections for repayment, and also must be reviewed (approved or rejected) within one (1) business day of re-submission. 

## Economic Impact Analysis 

The below analysis will document three different scenarios in which the $20 fee could be applied to, and how that impacts emissions and the MOBILE/HNT swap rate. The analysis below are based on data from Epoch 19,723, with a HNT Oracle Price of $6.89, and MOBILE Oracle price of $0.003697.

### Addition of HNT to MOBILE subDAO Treasury
This example shows the output if $1,000 in HNT is added to the MOBILE subDAO Treasury. At current Oracle Price of $6.89, $1,000 in HNT = 145.1378 HNT

| Control                             |                   |
|-------------------------------------|-------------------|
|HNT funded to MOBILE subDAO Treasury | 617,869           |
|Total MOBILE Supply                  | 79,775,824,336    |
|Swap Rate (MOBILE/HNT)               | 129,114.46        |
|MOBILE Value Per Treasury Swap       | $0.00005336350    |

| $1,000 in HNT Addition to Treasury  |                   |
|-------------------------------------|-------------------|
|HNT funded to MOBILE subDAO Treasury | 618,014.14        |
|Total MOBILE Supply                  | 79,775,824,336    |
|Swap Rate (MOBILE/HNT)               | 129,084.14        |
|MOBILE Value Per Treasury Swap       | $0.00005337604    |

MOBILE Value increase from $1,000 HNT deposited into MOBILE SubDAO Treasury = 0.0234992%

### Reduction (Burn) of overall MOBILE Supply
This example shows the output if $1,000 in HNT is added to the MOBILE subDAO Treasury. At current Oracle Price of $0.003697, $1,000 in MOBILE = 270,489.59 MOBILE

| Control                             |                   |
|-------------------------------------|-------------------|
|HNT funded to MOBILE subDAO Treasury | 617,869           |
|Total MOBILE Supply                  | 79,775,824,336    |
|Swap Rate (MOBILE/HNT)               | 129,114.46        |
|MOBILE Value Per Treasury Swap       | $0.00005336350    |

| $1,000 in MOBILE Burn               |                   |
|-------------------------------------|-------------------|
|HNT funded to MOBILE subDAO Treasury | 617,869           |
|Total MOBILE Supply                  | 79,775,553,846.41 |
|Swap Rate (MOBILE/HNT)               | 129,114.03        |
|MOBILE Value Per Treasury Swap       | $0.0000533638     |

MOBILE Value increase from $1,000 HNT deposited into MOBILE SubDAO Treasury = 0.000337309%

### Modification of the DAO Utility Score
This example shows the output if a revision was made to the DAO Utility score revised in [HIP 88](https://github.com/helium/HIP/blob/main/0088-adjustment-of-dao-utility-a-score.md) which includes all DC Burn into the score. Specifically, the output is showing if $1,000 in HNT is burned by the MOBILE subDAO Treasury. At the current HNT Oracle Price of $6.89, $1,000 in HNT burn results in 145.1378 HNT being burned

The new equation would be: 

$\text{DAO Utility Score} = V \times D \times A$

where

$V = \text{max}(1, veHNT_{DNP})$

$D = \text{max}(1, \sqrt{\text{All DNP DCs burned in USD}})$

$A = \text{max}(1, \sqrt[4]{\text{DNP Active Device Count} \times \text{DNP Device Activation Fee}})$

In the scenarios below, the HNT emitted to both subDAOs aggregates 27,945 assuming there is 0 HNT burn

| Control - 0 HNT Burn                        |                   |
|---------------------------------------------|-------------------|
|HNT burned in previous Epoch                 | 0                 |
|% of HNT Emitted to MOBILE subDAO per Epoch  | 66.88%            |
|HNT Emitted to MOBILE SubDAO Last Epoch      | 18,689.61         |
|HNT funded to MOBILE subDAO Treasury         | 617,869           |
|Total MOBILE Supply                          | 79,775,824,336    |
|Swap Rate (MOBILE/HNT)                       | 129,114.46        |
|MOBILE Value Per Treasury Swap               | $0.00005336350    |

|$1,000 in HNT    Burn for MOBILE subDAO      |                   |
|---------------------------------------------|-------------------|
|HNT burned by MOBILE subDAO in previous Epoch| 145.1378          |
|% of HNT Emitted to MOBILE subDAO per Epoch  | 66.88%            |
|HNT Emitted to MOBILE SubDAO Last Epoch      | 18,786.68         |
|HNT funded to MOBILE subDAO Treasury         | 617,966.07        |
|Total MOBILE Supply                          | 79,775,824,336    |
|Swap Rate (MOBILE/HNT)                       | 129,094.182       |
|MOBILE Value Per Treasury Swap               | $0.00005337188    |

MOBILE Value increase from $1,000 HNT deposited into MOBILE SubDAO Treasury = 0.0157036%


## Drawbacks:
New and existing deployers of CBRS radios will be required to obtain and pay at least $20 in HNT to onboard their new CBRS radio.

Further, this proposal will make it more expensive for deployers to move and onboard CBRS radios; however, this result is intended, as the subDAO is trying to encourage more Wi-Fi deployments.

## Rationale and Alternatives:
An alternative would be to do nothing, and keep allowing CBRS radios to be onboarded, moved and re-certified for no fee.


## Deployment Impact:
A method to transfer HNT from deployers wallets to the MOBILE subDAO will need to be created in such a way that the radio serial number that is being submitted is inscribed in the transaction message of the transfer in order to keep everything on-chain. 

## Success Metrics: 
This HIP is successful if: the swap rate of HNT/MOBILE increases in value from the MOBILE Treasury swap rate, and the rate of new CBRS deployments slow down. 





