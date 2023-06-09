- Start Date: 2020-02-11
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary

[summary]: #summary

This HIP proposes to add [XOR filter](https://lemire.me/blog/2019/12/19/xor-filters-faster-and-smaller-than-bloom-filters/)
based routing tables to the blockchain ledger to aid in routing LoRaWAN join
packets to the correct destination. Additionally once the device has joined, it
can be assigned a DevAddr corresponding to an address allocation the OUI controls.

# Motivation

[motivation]: #motivation

#Why are we doing this? What use cases does it support? What problems does it solve? What is the expected outcome?

With the addition of LoRaWAN support, we have inherited some of the routing
problems inherent in the LoRaWAN network model. LoRaWAN assumes that the network
has a centralized network server (or set of them) (similar to a LAN) and our model
is much closer to internet routing. Additionally, it turns out many LoRaWAN devices
do not allow end-user configuration of DevEUI/AppEUI/AppKey. Thus the existing
model of co-opting the AppEUI to route the join packet is unsuitable and
something new is needed.

In addition, the current scheme for DevAddr allocation (the session address,
essentially) is not ideal because we map the 32 bit OUI to the DevAddr directly.
This will cause problems for large OUIs at the expense of small ones. It would
be good for OUIs to be able to obtain more address space for their DevAddrs if
they're willing to pay for it.

# Stakeholders

[stakeholders]: #stakeholders

- LoRaWAN device users

# Detailed Explanation

[detailed-explanation]: #detailed-explanation

A XOR filter is a probabalistic data structure that allows for fast checking for
key membership It never has false negatives but can have false positives. XOR
filters come in 2 flavors, xor8 and xor16. xor8 has a false positive rate of
about 0.3 percent and xor16 has a false positive rate of about 0.002%. We
propose that the space tradeoff (2x) for xor16 is worth it because it results in
much less ambiguous routing for large numbers of devices.

XOR filters require inputs be hashed to a 64 bit integer before being stored or
compared against the XOR filter. We propose the use of
[xxhash](http://cyan4973.github.io/xxHash/)'s 64 bit mode. This is one of the
fastest hash functions available and seems to provide good distribution for the
XOR filter. Both the DevEUI and the AppEUI (totaling 128 bits together) would be
hashed to a 64 bit key, this should help in cases of DevAddr collisions.

A new ledger entity would be added to the blockchain, a 'routing entry'. These
would have a total ordering (assigned by the order they are added to the chain)
and an XOR filter built from the set of active DevEUI/AppEUIs for the owning OUI.

XOR16 filters for a range of sizes are presented below for illustration purposes:

| Devices   | Bytes on chain |
| --------- | -------------- |
| 100       | 322 bytes      |
| 1,000     | 2.48 kbytes    |
| 10,000    | 24.09 kbytes   |
| 100,000   | 240.21 kbytes  |
| 1,000,000 | 2.34 mbytes    |

With the largest XOR filter, we can check for key membership in about 14
milliseconds on an raspberry pi 3b+ in 32 bit mode. The smallest xor filter can
be checked in well under a millisecond.

In a more complete test, 10,000 OUIs holding device space for 50 million devices
was able route an address to its destination in 1.1 seconds, again on a
raspberry pi 3b+ in 32 bit mode. 64 bit mode is expected to be slightly faster.
The same test on a pi 4 is about 200 milliseconds faster, and the same test on
an intel i7-7700HQ runs in about 96 milliseconds.

Some more benchmarks are presented below. The memory and database sizes are
approximate.

On an Intel i7-7700HQ running Void linux:

```
running xor8_xxhash with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.21Mb, max 0.51Mb, min 0.10Mb
Approximate database size 9.99Mb
Average errors 39.300, max 59, min 20
Average lookup 0.056s, max 0.150s, min 0.034s
Lookup misses 0


running xor16_xxhash with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.54Mb, max 0.96Mb, min 0.23Mb
Approximate database size 23.76Mb
Average errors 0.155, max 2, min 0
Average lookup 0.077s, max 0.202s, min 0.054s
Lookup misses 0


running bloom with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.55Mb, max 1.02Mb, min 0.24Mb
Approximate database size 38.65Mb
Average errors 0.036, max 2, min 0
Average lookup 0.101s, max 0.218s, min 0.068s
Lookup misses 0
```

On a Raspberry Pi 3b+ running 32 bit Raspbian:

```
running xor8_xxhash with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.12Mb, max 0.25Mb, min -0.06Mb
Approximate database size 9.99Mb
Average errors 39.300, max 59, min 20
Average lookup 0.360s, max 0.426s, min 0.278s
Lookup misses 0


running xor16_xxhash with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.27Mb, max 0.84Mb, min 0.08Mb
Approximate database size 23.76Mb
Average errors 0.155, max 2, min 0
Average lookup 0.533s, max 0.629s, min 0.487s
Lookup misses 0


running bloom with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.14Mb, max 0.88Mb, min 0.02Mb
Approximate database size 38.65Mb
Average errors 0.030, max 1, min 0
Average lookup 0.700s, max 0.838s, min 0.651s
Lookup misses 1000
```

On a Raspberry Pi 4 running 32 bit Rasbian:

```
running xor8_xxhash with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.15Mb, max 0.26Mb, min -0.02Mb
Approximate database size 9.99Mb
Average errors 39.300, max 59, min 20
Average lookup 0.269s, max 0.386s, min 0.227s
Lookup misses 0


running xor16_xxhash with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.24Mb, max 0.37Mb, min 0.08Mb
Approximate database size 23.76Mb
Average errors 0.155, max 2, min 0
Average lookup 0.391s, max 0.436s, min 0.355s
Lookup misses 0


running bloom with 10000 OUIs and 8000000 Devices
Attempting 1000 random lookups
Average memory 0.20Mb, max 0.40Mb, min 0.02Mb
Approximate database size 38.65Mb
Average errors 0.030, max 1, min 0
Average lookup 0.536s, max 0.583s, min 0.500s
Lookup misses 1000
```

As we can see, xor16-xxhash seems to be the best combination of speed, size and
accuracy. Additionally the bloom filter seems to have some portability issue
(likely related to the 32/64 bit switch) which would need to be resolved.

Finally, a more ambitious test, on the same 3 machines, in the same order:

```
running xor16_xxhash with 10000 OUIs and 50000000 Devices
Attempting 1000 random lookups
Average memory 0.53Mb, max 1.58Mb, min 0.04Mb
Approximate database size 118.54Mb
Average errors 0.179, max 2, min 0
Average lookup 0.096s, max 0.137s, min 0.079s
Lookup misses 0

running xor16_xxhash with 10000 OUIs and 50000000 Devices
Attempting 1000 random lookups
Average memory -0.01Mb, max 1.58Mb, min -0.09Mb
Approximate database size 118.54Mb
Average errors 0.179, max 2, min 0
Average lookup 1.112s, max 1.322s, min 0.945s
Lookup misses 0

running xor16_xxhash with 10000 OUIs and 50000000 Devices
Attempting 1000 random lookups
Average memory 0.17Mb, max 1.99Mb, min 0.07Mb
Approximate database size 118.54Mb
Average errors 0.179, max 2, min 0
Average lookup 0.916s, max 1.009s, min 0.864s
Lookup misses 0
```

The benchmark code can be found
[here](https://github.com/Vagabond/bloom_router). These runs were generated by
the command in the README. The benchmark was first run on the Intel machine to
generate the routing tables, run a second time to use the generated routing
tables, and then the tables were copied to the Pi to run the test with the same
databases (generating the tables can be quite RAM intensive, so it is unsuitable
to be done on the Pi).

# Drawbacks

[drawbacks]: #drawbacks

## Why should we _not_ do this?

No matter how you slice it, this adds quite a lot of information to the ledger.
However, storing every possible DevEUI in a list would be 32Gb ( 2^32 \* 8 bytes)
of data. Storing AppEUIs or the associated routing destination just makes it
worse. XOR filters compress massively more, but they're not free.

One flaw with this scheme will be 'route posioning' where I will be able to get
join packets for devices I want to see routed to myself simply by adding that
device to my bloom filter. In theory this could be used as a denial of service
attack by interfering with the receive window for the legitimate join response
packet.

# Rationale and Alternatives

[alternatives]: #rationale-and-alternatives

## Why is this design the best in the space of possible designs?

XOR16 filters using xxhash64 were evaluated against bloom filters using a 1 in
200 million false positive rate, XOR8 filters using erlang:phash2 and xxhash64 and
xor16 filters using erlang:phash2. XOR16 with xxhash64 provided the best all
around speed and memory usage, and were very competitive for lookup times.
phash2 has too many collisions (it's only a 60 bit hash) for this application,
so it was rejected.

Other alternatives include cuckoo filters, but they're expected to be slower
than xor16+xxhash64 and require a more complicated implementation. Simply
storing a complete routing table, as discussed before, is not reasonable
because of size constraints.

## What other designs have been considered and what is the rationale for not choosing them?

Suggestions for other designs are welcome, routing arbitrary addresses without
being able to use prefix routing seems hard.

## What is the impact of not doing this?

We will be unable to support routing join packets for arbitrary LoRaWAN
join packets and thus unable to support LoRaWAN devices that are
already provisioned or unable to have their credentials modified.

# Unresolved Questions

[unresolved]: #unresolved-questions

## What parts of the design do you expect to resolve through the HIP process before this gets merged?

We need to nail down the permissible sizes of the XOR filters we want to store.

We need to decide if these routing table entries also contain a range of
DevAddr entries to be used for routing of non-join packets.

## What parts of the design do you expect to resolve through the implementation of this feature?

We need to define where/how these routing entries are stored, how they're
created/updated and if they can be transferred (like IP space can be traded).

## What related issues do you consider out of scope for this HIP that could be addressed in the future independently of the solution that comes out of this HIP?

Pricing and availability of routing table entries for organizations operating
their own OUI.

# Deployment Impact

[deployment-impact]: #deployment-impact

## How will current users be impacted?

All existing LoRaWAN devices will either have to have their credentials added
to the routing table, or they will need new credentials.

## How will existing documentation/knowlegebase need to be supported?

We don't have a lot of documentation for the existing thing, so we can probably
forego this.

#Is this backwards compatible?

It can be made to be, we can probably generate routing tables out of console's
DB, for the devices we know the DevEUI for.

# Success Metrics

[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

## What should we measure to prove an acceptance of this by it's users?

A user should be able to onboard any arbitrary LoRaWAN device without altering
its DevEUI/AppEUI/AppKey.
