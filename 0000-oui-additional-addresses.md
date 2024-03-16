# HIP Template (Give it a title here but do not allocate a number, maintainer will allocate a number)

- Author(s): @ccall48, @nowiresfil<!-- your GitHub @username -->
- Start Date: 2024-03-05<!-- fill me in with today's date, YYYY-MM-DD -->
- Category: Technical<!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT<!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary

<!-- One paragraph explanation of the proposal. -->
With the inital purchase of an OUI it is mandatory for a LNS operator to either supply an alliance netID or purchase
a minimum device address block from the foundation for $100 per address, with a minimum purchase of 8 for ($800 USD).
This proposal is to increase the amount of address space from 8 to 128 for the same minimum one time purchase price.
<!-- Read the content requests in all sections before starting to write any section. -->

## Motivation
The inital 8 block address spacing with the original helium console had the ability to multiplex this space out to
around ~ 300K devices which is not possible multiplexing the same block size through the new openlns 
initiative on Helium network over ChirpStack.

On simulation runs on a few different hardware types reliably puts this number at a maximum active device count of 
around 2k devices well short of the previous ability which made the costing reasonable.

Help encourage adopters to use the Helium 000003C netid rather then bringing an external address space.
<!--
- Why are we doing this?
- What use cases does it support?
- What problems does it solve?
- What is the expected outcome?
-->

## Stakeholders
This HIP will affect exisiting and future openlns operators operating a OUI on the Helium IOT network.
<!--
- Who is affected by this HIP? A stakeholder is any individual, group, or party such as network
  users, Hotspot hosts, or token holders.
- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIP repository or even directly active in the Helium Community chat channels.
-->
## Detailed Explanation
This is a breakdown of the prefix size of addresses for the respective prefix size for comparison.
Prefix / number of device addresses

32/1
31/2
30/4
29/8            <= Current allocation size.
28/16
27/32
26/64           <= Proposed secondary new block allocation size.
25/128          <= Proposed preferred new block allocation size.
24/256
23/512
22/1,024
21/2,048
20/4,046
19/8,192
18/16,384
17/32,768
16/65,536
15/131,072
14/262,144
13/524,288
12/1,048,576
11/2,097,152
10/4,194,304
9/8,388,608
8/16,777,216
7/33,554,432    <= Helium 00003C alocation size from lora alliance.
<!--
- Introduce and explain new concepts.
- It should be reasonably clear how the proposal would be implemented.
- Provide representative examples that show how this proposal would be commonly used.
- Corner cases should be dissected by example.
-->
## Drawbacks

CURRENT COST /29:
Possible allocations 4,194,304
Network Revenue: $3,355,443,200

CURRENT COST /29: 4,194,304 | $335,544,320

FIRST PROPOSAL /25:
Possible allocations 262,144
Network Revenue: $209,715,200

SECONDARY PROPOSAL /26:
Possible allocations 524,288
Network Revenue: $419,430,400

-
8 Block /29 at $10 per Address: 
Possible allocations 4,194,304
Network Revenue: $335,544,320

Existing stakeholders in this area may feel like they were over charged if the price reduces for more
address space, or if the system moves to a much lower cost per year rental system. We could offer increased
address space per year in of existing costs rendered or offer fee free years in lieu of the new proposal.
<!--
- Why should we _not_ do this?
- What problems could occur if we do this?
-->
## Rationale and Alternatives

Accepatable alternatives could include:
1. Lower the costing of the offering to purchase a 8 block from $800 to $80.
2. Allow the sale of singular addresse space at around $10 per address.
3. rent device space per year at a much reduced price of around $5 per address,
   knowing the space is getting used and paid for yearly.

<!--
This is your chance to discuss your proposal in the context of the whole design space. This is
probably the most important section!

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?
-->
## Unresolved Questions

<!--
- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?
- Are there dependencies, milestones, or dates that need to be met for this HIP to succeed?
-->
## Deployment Impact

The deployment impact would be expected to be positive with a lowering of the cost of offering hosting
to existing stakeholders I would expect this to be filtered down to cost of paid hosting services.
<!--
Describe how this design will be deployed and any potential impact it may have on current users of
this project.

- How will current users be impacted?
- How will existing documentation/knowledge base need to be supported? Any content to change at
  <http://docs.helium.com>?
- Is this backwards compatible? Can this HIP be undone?
  - If not, what is the procedure to migrate?
-->
## Success Metrics
An uptick in OUI deployers and devices traversing the network.
<!--
What metrics can be used to measure the success of this design? Are any new ETL reports needed to
measure the success?

- What should we measure to prove a performance increase?
- What should we measure to prove an improvement in stability?
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by its users?
-->