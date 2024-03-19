# HIP Template (OUI Additional Address Space Reshuffle)

- Author(s): [@ccall48](https://github.com/ccall48), @nowiresfil<!-- your GitHub @username -->
- Start Date: 2024-03-05<!-- fill me in with today's date, YYYY-MM-DD -->
- Category: Technical<!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: veIOT<!-- veHNT Holders, veIOT Holders, or veMOBILE Holders -->

## Summary
With the inital purchase of an OUI it is mandatory for a LNS operator to either supply an Lora Alliance NetID or purchase
a minimum device address block from the Helium Foundation for $100 per address, with a minimum purchase of 8 for ($800 USD).<br />
[Helium OUI Documentation](https://docs.helium.com/iot/run-an-lns/buy-an-oui)
<p>
This proposal is to increase the amount of address space from 8 to 128 for the same minimum one time purchase price.

## Motivation
The inital 8 block address spacing with the original helium console had the ability to multiplex this space out to
around ~ 300K devices which is not possible multiplexing the same block size through the new OpenLNS 
initiative on Helium network over ChirpStack.
<p>
On simulation runs on a few different hardware types reliably puts this number at a maximum active device count of 
around 2k devices well short of the previous ability which made the costing reasonable.
<p>
This should help encourage adopters to use the Helium 00003C NetID rather then bringing an external address space bought
elsewhere. In return drive up devices on the network by lowering the cost of entry for both hosters and deployers.

## Stakeholders
This HIP will affect exisiting and future OpenLNS operators or any individual operating an OUI on the Helium IOT network.
<p>
Feedback welcome by the offical discord channel or by watching the HIP repository on GitHub.

## Detailed Explanation
This is a breakdown of the prefix size of addresses for the respective prefix size for comparison.

```
Prefix / number of device address allocations
32 / 1
31 / 2
30 / 4
29 / 8 ________________ <= Current allocation size.
28 / 16
27 / 32
26 / 64 _______________ <= Proposed secondary new block allocation size.
25 / 128 ______________ <= Proposed preferred new block allocation size.
24 / 256
23 / 512
22 / 1,024
21 / 2,048
20 / 4,046
19 / 8,192
18 / 16,384
17 / 32,768
16 / 65,536
15 / 131,072
14 / 262,144
13 / 524,288
12 / 1,048,576
11 / 2,097,152
10 / 4,194,304
9  / 8,388,608
8  / 16,777,216
7  / 33,554,432 ________ <= Helium 00003C Allocation size from Lora Alliance.
```

## Drawbacks
This would reduce the current possible maximum revenue for address space on the Helium Network.<br />
However at the time of this HIP after ~3 years of operation and 1 year of the foundation offering the new 00003C
NetID allocation the uptake has already been quite slow, so there is also an argument that the existing pricing
has missed the mark and thus actually is being underutilized.
<p>
Existing stakeholders in this area may feel like they were over charged if the price reduces for more
address space, or if the system moves to a much lower cost per year or per year rental system.
We could offer increased address space per year to the new amount of existing costs already rendered.
Or offer fee free years in lieu of the new proposal.

## Rationale and Alternatives

At time of writing the break down of device addresses is:
```
Old Helium 000024  : 56
New Helium 00003C  : 29
Purchased Externaly: 21
Total OUI's        : 106
```
All larger allocations are being purchased externally and assigned to an OUI which is reducing the network burn,
only a few existing 000024 & 00003C users have purchased more then 1 x 8 address block.

### Existing Costs And Alternate Costing Ideas
```
# Current Cost /29:
- Possible total allocations: 4,194,304
- Network One Time Revenue: $3,355,443,200

# First Proposal /25
- Possible total allocations: 262,144
- Network One Time Revenue: $209,715,200

# Secondary Proposal /26
- Possible total allocations: 524,288
- Network One Time Revenue: $419,430,400

# 8 Block /29 at $10 per Address
- Possible total allocations: 4,194,304
- Network One Time Revenue: $335,544,320

# 8 Block /29 at $5 per Address (Yearly Rent)
- Possible total allocations: 4,194,304
- Network Total Possible Yearly Revenue: $20,971,520
```

### Accepatable alternatives could include:
```
1. Lower the costing of the offering to purchase a 8 block from $800 to $80.
2. Allow the sale of singular address space at around $10 per address.
3. Possibly rent device space per year at a much reduced cost of around $5 per address space,
   knowing the space is getting used and paid for yearly.
```

## Unresolved Questions
Would it be more reasonable to move to a lower cost but more address space allocation for a one time
fee? Or possibly move to a much lower cost but yearly rent on the existing address space thus helping to
be more accessable and help drive up IOT usage.

## Deployment Impact
By making the Helium Network more accessable and lowering the cost to encourage IOT usage being the main
factor. We expect the deployment impact to be positive with the lowering of the cost of offering hosting
to existing stakeholders I would expect this to be filtered all the way down to cost of paid hosting services,
as well as lower the barrier for small scale deployments to enter and use the network being more
attractive.

## Success Metrics
An uptick in OUI deployers and devices traversing the network. With accpetance being more DC burn and IOT rewards
for hotspot hosts.
