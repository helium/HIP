# HIP XX:  Driving Value Into The IOT Network Through IOT Token Payments
- Authors: [Max Gold](https://github.com/maxgold91) & [Andy Zyvoloski](https://github.com/heatedlime)
- Start Date: 6/19/2023
- Category: Technical & Economic
- Original HIP PR: #
- Tracking Issue: #
- Voting Requirements: veIOT

## Summary: 
This HIP proposes changing the method of payment for Location Assert Fees on the IOT subDAO from Data Credits (DC) burned from HNT to IOT tokens. The primary purpose of this change is to drive value into IOT tokens and provide them with a small amount of utility. This HIP does not propose altering any other aspect of Location Assert Fees. 

## Motivation:
Currently, Location Assert Fees are paid using HNT tokens. However, there is no economic benefit to the IOT subDAO under HIP-51 to pay for Location Assert fees using DC, as none of the burned tokens accrue back to the subDAO or increase the subDAO's DAO Utility Score. This proposal seeks to address this issue by transitioning the method of payment to IOT tokens.

By adopting IOT tokens as the method of payment, it aims to drive value into the IOT ecosystem and give IOT tokens a small amount of utility. Moreover, this change aligns with the rules established in HIP-51, as detailed below.

## Stakeholders:
IoT Token Holders - This HIP will benefit IoT token holders by providing a small amount of utility to the IoT token.

## Detailed Explanation:
### Method of Payment
This HIP proposes that Location Assert Fees be paid using IOT tokens instead of DC. The change will be effected by modifying the relevant code within the Helium network core implementation. This modification will ensure that only IOT tokens are accepted for Location Assert Fees.

Data credits will not be utilized in this process. Instead, a straight burn of IOT tokens will be implemented.

### Implementation

A burn wallet will be used for the implementation of this change. The burn wallet will take the oracle value of IOT at the time of the transaction, ensuring that the correct amount of IOT tokens is burned for each Location Assert Fee transaction. The burn wallet will also ensure that no changes are made to any other aspect of Location Assert Fees.

#### Burn Wallet Functionality on Solana

A burn wallet on Solana functions by sending tokens to an address that has no known private key. This ensures that the tokens sent to this address are effectively removed from circulation and considered "burned". This process is irreversible.

#### Flowchart of Burn Transactions

1. User initiates a Location Assert Fee transaction.
2. The transaction sends the required amount of IOT tokens, based on the current oracle value, to the burn wallet address.
3. IOT tokens are burned, effectively removing them from circulation.
4. The Location Assert Fee transaction is recorded on the blockchain.

## Alternatives:

One alternative is to keep DC as the source used to pay for these fees; however, this does not benefit the IoT subDAO or token holders.

## Drawbacks:

Currently, the treasury swap function within the Helium wallet only allows the swapping of IoT to HNT, and not the other way around. Thus, if any hotspot owners needed $10 in IoT, it would need to be bought on the secondary market. 

## Unresolved Questions:

There are no unresolved questions. 

## Deployment Impact:

This change will require changes to the Helium blockchain core implementation to accept IOT tokens instead of HNT tokens for Location Assert Fees.  The same burn wallet utilized by the Treasury Fund Swaps may be used or a different wallet, as advised by the Foundation's core team of engineers.

### Security Implications:

There are no known security implications associated with this HIP. The proposal focuses solely on the method of payment for Location Assert Fees and does not affect any other aspect of the Helium network or its operations.

## Success Metrics:

The primary success metric will be all hotspot reassertion fees being paid in IoT, which will provide a small amount of utility to the IOT tokens. 
