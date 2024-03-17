# HIP Template (OUI Additional Address Space Reshuffle)

- Author(s): @ccall48, @nowiresfil<!-- your GitHub @username -->
- Start Date: 2024-03-05<!-- fill me in with today's date, YYYY-MM-DD -->
- Category: Technical<!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT<!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary
<!-- One paragraph explanation of the proposal. -->
With the inital purchase of an OUI it is mandatory for a LNS operator to either supply an Lora Alliance NetID or purchase
a minimum device address block from the Helium Foundation for $100 per address, with a minimum purchase of 8 for ($800 USD).<br />
[Helium OUI Documentation](https://docs.helium.com/iot/run-an-lns/buy-an-oui)
<p>
This proposal is to increase the amount of address space from 8 to 128 for the same minimum one time purchase price.
<!-- Read the content requests in all sections before starting to write any section. -->

## Motivation
The inital 8 block address spacing with the original helium console had the ability to multiplex this space out to
around ~ 300K devices which is not possible multiplexing the same block size through the new OpenLNS 
initiative on Helium network over ChirpStack.
<p>
On simulation runs on a few different hardware types reliably puts this number at a maximum active device count of 
around 2k devices well short of the previous ability which made the costing reasonable.
<p>
This should help encourage adopters to use the Helium 000003C NetID rather then bringing an external address space bought
elsewhere. In return drive up devices on the network by lowering the cost of entry for both hosters and deployers.
<!--
- Why are we doing this?
- What use cases does it support?
- What problems does it solve?
- What is the expected outcome?
-->

## Stakeholders
This HIP will affect exisiting and future OpenLNS operators or any individual operating an OUI on the Helium IOT network.
<p>
Feedback welcome by the offical discord channel or by watching the HIP repository on GitHub.
<!--
- Who is affected by this HIP? A stakeholder is any individual, group, or party such as network
  users, Hotspot hosts, or token holders.
- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIP repository or even directly active in the Helium Community chat channels.
-->

## Detailed Explanation
This is a breakdown of the prefix size of addresses for the respective prefix size for comparison.
<p>
Prefix / number of device address allocations<br />
32/1<br />
31/2<br />
30/4<br />
29/8 ________________ <= Current allocation size.<br />
28/16<br />
27/32<br />
26/64 _______________ <= Proposed secondary new block allocation size.<br />
25/128 ______________ <= Proposed preferred new block allocation size.<br />
24/256<br />
23/512<br />
22/1,024<br />
21/2,048<br />
20/4,046<br />
19/8,192<br />
18/16,384<br />
17/32,768<br />
16/65,536<br />
15/131,072<br />
14/262,144<br />
13/524,288<br />
12/1,048,576<br />
11/2,097,152<br />
10/4,194,304<br />
9/8,388,608<br />
8/16,777,216<br />
7/33,554,432 ________ <= Helium 00003C Allocation size from Lora Alliance.
<!--
- Introduce and explain new concepts.
- It should be reasonably clear how the proposal would be implemented.
- Provide representative examples that show how this proposal would be commonly used.
- Corner cases should be dissected by example.
-->

## Drawbacks
This would reduce the current possible maximum revenue for address space on the Helium Network.<br />
However at the time of this HIP after ~3 years of operation and 1 year of the foundation offering the new 00003C
NetID allocation the uptake has already been quite slow.
<p>
At time of writing the break down device address is:<br />
Total OUI: 106<br />
000024: 56<br />
00003C: 29<br />
Purchased Externaly: 21
<p>
All larger allocations are being purchased externally and assigned to an OUI which is reducing the network burn,
only a few existing 000024 & 00003C users have purchased more then 1 x 8 address block.

### Existing Costs And Alternate Costing Ideas
#### Current Cost /29:
- Possible total allocations: 4,194,304<br />
- Network One Time Revenue: $3,355,443,200

#### First Proposal /25<br />
- Possible total allocations: 262,144<br />
- Network One Time Revenue: $209,715,200

#### Secondary Proposal /26<br />
- Possible total allocations: 524,288<br />
- Network One Time Revenue: $419,430,400

#### 8 Block /29 at $10 per Address<br />
- Possible total allocations: 4,194,304<br />
- Network One Time Revenue: $335,544,320<p>

#### 8 Block /29 at $5 per Address (Yearly Rent)<br />
- Possible total allocations: 4,194,304<br />
- Network Total Possible Yearly Revenue: $20,971,520
<p>
Existing stakeholders in this area may feel like they were over charged if the price reduces for more
address space, or if the system moves to a much lower cost per year or per year rental system.
We could offer increased address space per year in of existing costs rendered or offer fee free years
in lieu of the new proposal.
<!--
- Why should we _not_ do this?
- What problems could occur if we do this?
-->

## Rationale and Alternatives

Accepatable alternatives could include:<br />
1. Lower the costing of the offering to purchase a 8 block from $800 to $80.
2. Allow the sale of singular address space at around $10 per address.
3. Possibly rent device space per year at a much reduced cost of around $5 per address space,<br />
   knowing the space is getting used and paid for yearly.
<!--
This is your chance to discuss your proposal in the context of the whole design space. This is
probably the most important section!

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?
-->
## Unresolved Questions
Would it be more reasonable to move to a lower cost but more address space allocation for a one time
fee? Or possibly move to a much lower cost but yearly rent on the existing address space thus helping to
be more accessable and help drive up IOT usage.
<!--
- What parts of the design do you expect to resolve through the HIP process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature?
- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?
- Are there dependencies, milestones, or dates that need to be met for this HIP to succeed?
-->
## Deployment Impact
By making the Helium Network more accessable and lowering the cost to encourage IOT usage being the main
factor. We expect the deployment impact to be positive with the lowering of the cost of offering hosting
to existing stakeholders I would expect this to be filtered all the way down to cost of paid hosting services,
as well as lower the barrier for small scale deployments to enter and use the network being more
attractive.

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
An uptick in OUI deployers and devices traversing the network. With accpetance being more DC burn and IOT rewards
for hotspot hosts.
<!--
What metrics can be used to measure the success of this design? Are any new ETL reports needed to
measure the success?

- What should we measure to prove a performance increase?
- What should we measure to prove an improvement in stability?
- What should we measure to prove a reduction in complexity?
- What should we measure to prove an acceptance of this by its users?
-->