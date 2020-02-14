- Start Date: 2020-02-11
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

This HIP proposes to add bloom filter based routing tables to the blockchain ledger to aid in routing LoRaWAN join packets to the correct destination. Additionally once the device has joined, it can be assigned a DevAddr corresponding to an address allocation the OUI controls.

# Motivation
[motivation]: #motivation

#Why are we doing this? What use cases does it support? What problems does it solve? What is the expected outcome?

With the addition of LoRaWAN support, we have inherited some of the routing problems inherent in the LoRaWAN network model. LoRaWAN assumes that the network has a centralized network server (or set of them) (similar to a LAN) and our model is much closer to internet routing. Additionally, it turns out many LoRaWAN devices do not allow end-user configuration of DevEUI/AppEUI/AppKey. Thus the existing model of co-opting the AppEUI to route the join packet is unsuitable and something new is needed.a

In addition, the current scheme for DevAddr allocation (the session address, essentially) is not ideal because we map the 32 bit OUI to the DevAddr directly. This will cause problems for large OUIs at the expense of small ones. It would be good for OUIs to be able to obtain more address space for their DevAddrs if they're willing to pay for it.

# Stakeholders
[stakeholders]: #stakeholders

* LoRaWAN device users

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

A bloom filter is a probabalistic data structure that allows for fast checking for key membership  It never has false negatives but can have false positives depending on a configurable probability.

A new ledger entity would be added to the blockchain, a 'routing entry'. These would have a total ordering (assigned by the order they are added to the chain) and a bloom filter that is one of a specific list of combinations of bits in the filter and # of items (addresses). Thus this bloom filter can be used to both route join requests *and* designate a size of a DevAddr allocation.

Proposed allocation sizes are as follows:

| Devices | Bytes on chain |
|---------|----------------|
| 100     | 497 bytes      |
| 1000    | 4.85 kbytes    |
| 10000   | 48.56 kbytes   |
| 100000  | 485.63 kbytes  |
| 1000000 | 4.74 mbytes    |

Each bloom filter is created with a 1 in 199,725,093 chance of a false positive and uses 28 hash functions.

With the largest bloom filter, we can check for key membership in 100 microseconds on an intel core i7. The smallest bloom filter above can be checked for membership in about 70 microseconds.

In a more complete test, 2039 OUIs holding device space for 100,052,066 devices and 10,000 populated was able to resolve the owning OUI for a device in about 0.8 seconds.

One good piece of news is that bloom filters compress *really* well when they're mostly full or mostly empty, and they compress more the bigger they are. I've observed 2-3 orders of magnitude of compression for mostly empty blooms.

# Drawbacks
[drawbacks]: #drawbacks

- Why should we *not* do this?

No matter how you slice it, this adds quite a lot of information to the ledger. Storing every possible DevEUI is 32Gb ( 2^32 * 8 bytes) of data. Storing AppEUIs or the associated routing destination just makes it worse. Bloom filters compress massively more, but they're not free.

One flaw with this scheme will be 'route posioning' where I will be able to get join packets for devices I want to see routed to myself simply by adding that device to my bloom filter. In theory this could be used as a denial of service attack by interfering with the receive window for the legitimate join response packet.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

## Why is this design the best in the space of possible designs?

Bloom filters are probably the most mature probabalistic filter of this type, other alternatives are cuckoo filters and exor filters, but libraries for these are less mature and not as widely available. Simply storing a complete routing table, as discussed before, is not reasonable because of size constraints.

##What other designs have been considered and what is the rationale for not choosing them?

Suggestions for other designs are welcome, routing arbitrary addresses without being able to use prefix routing seems hard.

- What is the impact of not doing this?

We will be unable to support routing join packets for arbitrary LoRaWAN join packets and thus unable to support LoRaWAN devices that are already provisioned or unable to have their credentials modified.

# Unresolved Questions
[unresolved]: #unresolved-questions

##What parts of the design do you expect to resolve through the HIP process before this gets merged?

We need to nail down the permissible sizes of the bloom filters, and the false positive rate we want to tolerate.

We need to decide if these routing table entries also contain a range of DevAddr entries to be used for routing of non-join packets.

##What parts of the design do you expect to resolve through the implementation of this feature?

We need to define where/how these routing entries are stored, how they're created/updated and if they can be transferred (like IP space can be traded).

##What related issues do you consider out of scope for this HIP that could be addressed in the future independently of the solution that comes out of this HIP?

Pricing and availability of routing table entries for organizations operating their own OUI.

# Deployment Impact
[deployment-impact]: #deployment-impact

##How will current users be impacted?

All existing LoRaWAN devices will either have to have their credentials added to the routing table, or they will need new credentials.

##How will existing documentation/knowlegebase need to be supported?

We don't have a lot of documentation for the existing thing, so we can probably forego this.

#Is this backwards compatible?

It can be made to be, we can probably generate routing tables out of console's DB.

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

##What should we measure to prove an acceptance of this by it's users?

A user should be able to onboard any arbitrary LoRaWAN device without altering its DevEUI/AppEUI/AppKey.
