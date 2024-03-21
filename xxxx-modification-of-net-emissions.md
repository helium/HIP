# HIP XXX: Modification of Net Emissions 

- Author(s): [Andy Zyvoloski](https://github.com/heatedlime) 
- Start Date: 2024-03-20
- Category: Economic
- Original HIP PR: 
- Tracking Issue:
- Vote Requirements: veHNT Holders

## Summary:
This Helium Improvement Proposal (HIP) proposes changing net emissions whereby per epoch, 50% of HNT burned for Data Credits (DC) will be permanently removed from the max supply, while the remaining 50% will be reminted via net emissions for that epoch. 


## Motivation:
The current net emissions number (1,643.83561643 HNT) is a fixed amount, which doesn’t allow for fluctuations within normal market conditions. For example, as the price of HNT rises, less HNT is needed to be burned to generate the same amount of DC. As a result, any epochs in which 1,643.83 HNT or less have been burned will not result in a net decrease in the overall maximum supply of HNT. Over time, this may make HNT less deflationary.

## Stakeholders:
The stakeholders of this proposal are:

- **veHNT Holders** will benefit from a decrease in supply of HNT
- **MOBILE and IOT subDAO** will receive less HNT sent to their respective subDAOs as a part of net emissions. 


## Detailed Explanation:
Net Emissions enables the Network to monitor the number of HNT burned for DC in a given epoch and add that to the number of HNT to mint for that epoch. The current value for Net Emissions is 1,643.83561643 HNT.

This means that if less than 1,643.84 HNT is burned for DC within an epoch, the full amount burned will be reminted and distributed into the subDAOs Treasury for that epoch, along with normal daily emissions. However, if more than 1,643.84 HNT is burned for DC within a single epoch, any HNT burn for DC over that amount will be permanently burned and removed from the max supply, while 1,643.84 being reminted and distributed to the subDAOs. 

This proposal suggests changing net emissions from a fixed amount (1,643.84) to a fixed percentage (50%), whereas 50% of HNT burned each epoch will be reminted via net emissions per epoch.

For example, over the past 120 epochs (11/22/2024 through 3/20/2024), a total of 151,542.96 HNT was burned, with 58,548.99 (39%) of that being permanently burned and removed from circulation, while 92,993.97 (61%) was reminted via net emissions. Only 10 out of the past 120 epochs had HNT burn greater than 1,643.84 for that epoch. This HIP would change it so an even, more predictable amount is being burned.


## Rationale and Alternatives
The rationale behind this HIP is to make net emissions easier and more predictable to understand, while allowing more HNT to be burned as market conditions fluctuate. 

One alternative is to take a similar approach, but modify the burn and emit ratio to something other than 50/50.

## Deployment Impact
The Helium Foundation will need to update the chain variable for net emissions to programmatically ensure that only 50% of HNT burned that epoch are reminted via net emissions. 

## Success Metrics
This HIP would be considered successful if there is more HNT being permanently removed from circulation than there is now. 



