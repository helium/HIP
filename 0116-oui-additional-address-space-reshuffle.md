# HIP 116: OUI Additional Address Space Reshuffle

- Author(s): [@ccall48](https://github.com/ccall48), [@nowiresfil](https://github.com/nowiresfil)
- Start Date: 2024-03-25
- Category: Technical
- Original HIP PR: [#948](https://github.com/helium/HIP/pull/948)
- Tracking Issue: [#959](https://github.com/helium/HIP/issues/959)
- Vote Requirements: veIOT Holders

---

## Summary
With the initial purchase of an OUI it is mandatory for a LNS operator to either supply a Lora Alliance NetID or purchase
a minimum device address block from the Helium Foundation for $100 per address, with a minimum purchase of 8 for ($800 USD).

[Helium OUI Documentation](https://docs.helium.com/iot/run-an-lns/buy-an-oui)

This proposal is to decrease the purchase cost from $800 to $100 for the same `/29` 8 Address block.<br />
While also seeking to move the cost of OUI and Addresses space to be burnt from IOT subdao tokens.

## Motivation
The initial 8 block address spacing with the original helium console had the ability to multiplex this space out to
around ~ 300K devices which is not possible multiplexing the same block size through the new OpenLNS
initiative on Helium network over ChirpStack.

On simulation runs on a few different hardware types reliably puts this number at a maximum active device count of 
around 2k devices well short of the previous ability which made the costing reasonable.

This should help encourage adopters to use the Helium 00003C NetID rather than bringing an external address space bought
elsewhere. In return drive up devices on the network by lowering the cost of entry for both hosts and deployers.

## Stakeholders
This HIP will affect existing and future OpenLNS operators or any individual operating an OUI on the Helium IOT network
by lowering the cost of entry for deployment on the IOT network.
- Future operators by a reduced cost of entry.
- Existing operators by reduced cost of additional address block purchases.

Helium Foundation for required develpement work to setup the appropriate mechanism to burn IOT instead of DC. 

Feedback welcome by the official discord channel or by watching the HIP repository on GitHub.

## Detailed Explanation
This is a breakdown of the prefix size of addresses for the respective prefix size for comparison.

```
Prefix / number of device address allocations
32 / 1
31 / 2
30 / 4
29 / 8 ________________ <= Current allocation size to reduce from $800 to $100.
28 / 16
27 / 32
26 / 64
25 / 128
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
This would reduce the current possible maximum revenue for address space on the Helium Network.

However, at the time of this HIP after ~3 years of operation and 1 year of the foundation offering the new 00003C
NetID allocation the uptake has already been quite slow, so there is also an argument that the existing pricing
has missed the mark and thus actually is being underutilized.

Existing stakeholders in this area may feel like they were overcharged if the price reduces for more
address space, or if the system moves to a much lower cost per year or per year rental system.
We could offer increased address space per year to the new amount of existing costs already rendered.
Or offer fee free years in lieu of the new proposal.

## Rationale and Alternatives

At time of writing the breakdown of device addresses is:
```
Old Helium 000024  : 56
New Helium 00003C  : 29
Purchased Externaly: 21
Total OUI's        : 106
```
All larger allocations are being purchased externally and assigned to an OUI which is reducing the network burn,
only a few existing 000024 & 00003C users have purchased more than 1 x 8 address block.

### Existing Costs And Alternate Costing Ideas
```
# Current Cost /29:
- Possible total allocations: 4,194,304
- Network One Time Revenue: $3,355,443,200

# After Proposal /29
- Possible total allocations: 4,194,304
- Network One Time Revenue: $419,430,400
```
Move the costs to be paid by burning IOT tokens to help IOT subdao score.

### Acceptable alternatives could include:
```
1. Lower the costing of the offering to purchase a 8 block from $800 to $80.
2. Allow the sale of singular address space at around $10 per address.
3. Possibly rent device space per year at a much reduced cost of around $5 per address space,
   knowing the space is getting used and paid for yearly.
```

## Unresolved Questions
Would it be more reasonable to move to a lower cost but more address space allocation for a one time
fee? Or possibly move to a much lower cost but yearly rent on the existing address space thus helping to
be more accessible and help drive up IOT usage.

## Deployment Impact
By making the Helium Network more accessible and lowering the cost to encourage IOT usage being the main
factor. We expect the deployment impact to be positive with the lowering of the cost of offering hosting
to existing stakeholders I would expect this to be filtered all the way down to cost of paid hosting services,
as well as lower the barrier for small scale deployments to enter and use the network being more
attractive.

## Success Metrics
An uptick in OUI deployers and devices traversing the network. With acceptance being more DC burn and IOT rewards
for hotspot hosts.

## Documentation Updates
A list of known pages in the documentation that will need updating should this HIP be successful.
- Helium OUI Documentation / https://docs.helium.com/iot/run-an-lns/buy-an-oui
