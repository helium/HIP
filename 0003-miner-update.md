# HIP3: Over-the-air miner updates

- Start Date: 2020-02-13
- HIP PR: #3
- Tracking Issue: #5318

# Summary

This proposal examines how Helium could allow consumer Hotspot owners to specify and deliver their
own over-the-air miner updates. The scope of this proposal excludes do-it-yourself Hotspots which
Helium is under no obligation to support. It also excludes the non-miner-related bits of the Hotspot
firmware image which Helium will solely continue to update using our existing nextgate/nexthaul
client-server mechanism.

This feature can be enabled in one of three ways: image overlays, Docker images or OCI images. The
first method requires users to stand up and run their own OTA servers (aka minerhaul) for deploying
their own custom miner packages from a cloud storage service like AWS S3. The second and third
approaches require users to publish images to a container registry like AWS ECR in order to store
and distribute their own custom miner images. OCI images are Docker-compatible but can also run on
more lightweight tooling like bubblewrap.

# Motivation

- Why are we doing this?
- What use cases does it support?
- What problems does it solve?
- What is the expected outcome?

Allowing Hotspot owners to build and distribute their own custom miner software encourages diversity
across the Helium Network. Delivering different miner updates from different points of origin allows
the network to grow in a truly decentralized fashion, eventually moving control of how the network
develops away from any single entity and into the hands of the network stakeholders themselves.

# Stakeholders

- Who is affected by this HIP?

Blockchain Engineering, Embedded Engineering

- How are we soliciting feedback on this HIP from these stakeholders?

Feedback will be gathered by sharing this HIP.

# Detailed Explanation

Helium's private nextgate build system builds Hotspot firmware, signs it and uploads it to a public
AWS S3 bucket for downloading. The nexthaul OTA server provides metadata about where to find and how
to verify available Hotspot firmware releases. The Helium Blockchain Engineering team updates this
release information inside the helium/coop repo and pushes changes to Heroku for deployment to the
existing fleet of Hotspots. Hotspots use a self-signed public SSL certificate included in their
firmware to establish that the ota.helium.com server on the other end is in fact Helium's and not
some bad actor's.

The nextgate repo currently builds miner as a separate software package that is then installed to a
target root file system for inclusion in the Hotspot's embedded Linux image. The entire system image
is signed by Helium but the individual miner software artifacts currently are not. The firmware
image is signed so that consumer Hotspots can verify that an over-the-air update originated from
Helium before committing it to flash storage and rebooting.

The monolithic firmware updates that nextgate/nexthaul performs are too dangerous for Hotspot owners
to administer themselves. The chances of an end user deploying a homemade firmware update that
accidentally bricks their Hotspots is simply too high. What we want is a way for Hotspot owners to
only upgrade the miner portion of their devices' firmware so that their Hotspots remain online and
continue to receive hardware-specific updates (Linux kernel, gateway-config, LoRa packet_forwarder)
only from Helium.

The simplest solution is to install miner and all its dependencies (RocksDB, libsodium, ebus) as an
image overlay on top of a Hotspot's root file system. This extraction step would happen at boot time
once Linux has started and the immutable root file system has been loaded into memory. The end
result is similar to how web applications are deployed as tarballs for extracting to and running on
a newly-launched AWS EC2 instance. A new minerhaul OTA server will need to be open sourced and
client-side scripts will need to be added to nextgate to download and apply miner updates.

Another solution is to package miner releases as Docker images for deployment to and execution on
Hotspots. Instead of pointing their Hotspots at alternative minerhaul servers Hotspot owners would
instead point them at alternative Docker registries. A miner package maintainer uses Docker push
commands to publish new miner images to her registry. Hotspots use Docker pull commands to fetch new
miner images from their designated registries. A Docker runtime and client-side scripts will need to
be added to nextgate for automatic teardown and setup of miner images on the Hotspots.

The third and most promising solution is to package miner releases as OCI images for deployment to
and execution on Hotspots. OCI images are published to container registries the same way Docker
images are. An OCI image can be mounted and booted on a Hotspot using a containerization tool known
as bubblewrap. A multilayered OCI approach is being adopted for containerization of cloud miners.
This layering allows us to build an arm64 slim container that only contains the cross-compiled NIFs
and BEAM bytecode files needed to populate /opt/miner. We would untar or mount this slim container
through the needed system paths into the bubblewrap environment. Like the preceding image overlay
approach this OCI image approach depends on a full Erlang/OTP runtime already being installed.

The only way to configure a consumer Hotspot right now is through Helium's mobile app. That means
some write-only characteristics (MinerUpdateSourceUrl, SslPublicCert and SignifyPublicKey) will need
to be added to the BLE GATT server so that users can switch from ota.helium.com to an alternative
OTA server for miner updates. Similar write-only characteristics will need to be added if we decide
to let users fetch their miner updates from a Docker registry of their choosing. Docker supports
signing and verification of images from a specific registry using a feature known as Docker Content
Trust. Runtime enforcement of signed image verification requires Docker Enterprise Engine.

# Drawbacks

- Why should we _not_ do this?

As with most other blockchain-based cryptocurrencies many alternative miner implementations are
likely to be fueled by a desire to hack or game the system for more HNT. While the design of the
Helium blockchain should be robust enough to resist the most common attacks there will undoubtedly
be some bugs or holes that were missed. The Helium Blockchain Engineering team will need to respond
to these exploits in a swift and timely manner so that such an event does not wipe out the entire
Helium Network.

Diverging implementations of miner are likely to behave slightly differently. The result is likely
to be unintended forking of the blockchain. Forking is not much of a problem for us because it is
hard for a fork to make any significant progress without consensus from the larger share of the
Helium Network. Although they may solicit help from the Helium Blockchain Engineering team
ultimately it will be the responsibility of individual miner package maintainers to resolve the
blockchain forks and other user complaints resulting from their published miner updates.

# Rationale and Alternatives

- Why is this design the best in the space of possible designs?

The three miner update designs being considered can all be retrofitted on top of our existing
consumer Helium Hotspots.

- What other designs have been considered and what is the rationale for not choosing them?

While there are several third party firmware update services like NervesHub, Mender and balena
available none of them meet our immediate needs. NervesHub relies on Buildroot-based-images and
Mender also has support for Buildroot but both of these services only allow for monolithic image
updates like our existing nexthaul/nextgate mechanism. Balena deploys updates via Docker containers
but it looks like the target edge devices need to run their Yocto-based balenaOS to receive them.

- What is the impact of not doing this?

If we do not allow Hotspot owners to build and distribute their own custom miner software we
eventually risk greater scrutiny by Hotspot operators, regulators and large cryptocurrency
exchanges.

# Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process before this gets merged?

What is the minimum viable product we can implement without sacrificing security or diminishing the
user experience?

- What parts of the design do you expect to resolve through the implementation of this feature?

Deploying Docker images to Hotspots is a new and unproven technique so the only way to evaluate that
approach is through rapid prototyping.

- What related issues do you consider out of scope for this HIP that could be addressed in the
  future independently of the solution that comes out of this HIP?

How does a third party package and sign a miner release for download and verification by a consumer
Hotspot?

How do we facilitate the deployment of miner instances in the cloud that receive LoRa packets from
third party radio gateways?

# Deployment Impact

- How will current users be impacted?

End users will have the option to specify the URL of a miner package repository or image registry
besides Helium's so that subsequent miner updates originate from that third party miner package
repository or image registry. If no alternative URL is specified then the miner package repository
or image registry utilized by a Hotspot defaults to Helium's. In either case miner updates continue
to happen automatically so an end users should notice no difference unless they select an unreliable
miner package or image supplier.

- How will existing documentation/knowledgebase need to be supported?

The final solution will need to include clear step-by-step instructions for miner package or image
maintainers. This documentation can take the form of a GitHub project README for a Helium minerhaul
repo that miner package maintainers will need to fork to deliver their updates.

UI for entering the URL of an alternative miner package repository will need to be added to the
Hotspot Settings page of the Helium mobile app. Because a malfunctioning miner can prevent a user
from pairing with a Hotspot over Bluetooth we need some way of determining who owns a Hotspot in the
absence of a working miner. A related help article will also need to be added to the support section
of Helium's website for end users.

- Is this backwards compatible?

We are not abandoning the Buildroot embedded Linux build system for existing first generation of
Helium Hotspots so any miner update approach we adopt will need to integrate with Buildroot.

# Success Metrics

- What should we measure to prove a performance increase or decrease?

We need measure the impact on blockchain throughput that running miner inside a Docker container has
on our resource-constrained hardware.

- What should we measure to prove an acceptance of this by its users?

We need to count how many consumer Hotspots that are actively challenging are not receiving their
miner updates from Helium.
