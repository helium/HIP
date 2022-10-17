# HIP2: Sign miner

- Start Date: 2020-02-10
- HIP PR: #2
- Tracking Issue: #5318

# Summary

This is a proposal to separate Helium's blockchain software from the rest of the
Hotspot firmware image. Decoupling Helium's blockchain software from our
consumer Hotspot hardware and mandatory over-the-air updates makes a stronger
case for decentralized nature of the Helium Network. While Helium Systems Inc
makes Hotspots it may not necessarily be the same entity that owns the rights to
the Helium blockchain software. More importantly, separate signing enables
Hotspot owners to be able to securely deploy their own miner releases with
modified code if they choose to.

# Motivation

- Why are we doing this?
- What use cases does it support?
- What problems does it solve?
- What is the expected outcome?

A separate Helium blockchain software bundle allows an independent entity (like
a foundation) to hold signing power over the blockchain portion of the Hotspot
firmware image. Reliance on one or more independent signatories allows the
network to grow in a truly decentralized fashion, eventually moving control of
how the network develops away from any single entity and into the hands of the
network stakeholders themselves.

# Stakeholders

- Who is affected by this HIP?

Blockchain Engineering, Embedded Engineering

- How are we soliciting feedback on this HIP from these stakeholders?

Feedback will be gathered by sharing this HIP.

# Detailed Explanation

The Helium blockchain software and Hotspot firmware reside in separate GitHub
repos. The blockchain software repo (helium/miner) is public while the Hotspot
firmware repo (helium/nextgate) is private. The nextgate repo requires miner to
build a Hotspot firmware image but miner can still run on do-it-yourself
hardware or in the cloud without nextgate. The Hotspot firmware image also
includes radio-related software but miner can still sync the blockchain and
submit Proof-of-Coverage challenges without radio.

The nextgate repo currently builds miner as a separate software package that is
then installed to a target root file system for inclusion in the Hotspot's
embedded Linux image. The entire system image is signed by Helium Systems Inc
but the individual miner software artifacts are not. The image is signed so that
consumer Hotspots can verify that an OTA update originated from Helium before
committing it to flash storage and rebooting.

At a minimum a signing step needs to be added to miner's release process. As of
February 3rd 2020 Helium's Blockchain Engineering team tags miner releases in
conjunction with nextgate releases. Tagging a repo on GitHub results in a
gzipped tarball of the source code being published for downloading. That Git tag
or source arball release can be cryptographically signed so that a package
manager or build tool can verify that the code is blessed by a particular
signatory.

A third party can fork or mirror the helium/miner repo on GitHub and publish
their own signed release tags. Helium's Embedded Engineering team can then
modify the miner makefile within nextgate to fetch release source code from said
third party repo. Tag signature verification would be a necessary precondition
for building a miner release tag. In the event that Helium Systems Inc transfers
ownership of the blockchain software to the third party then helium/miner would
be archived and subsequent pull requests from Helium's Blockchain Engineering
team would need to be submitted to the third party's repo.

Signing Git tags or source tarballs only provides verification at build time.
These signing methods do not allow for distinct OTA miner updates separate from
the rest of the Hotspot firmware. For independent miner updates to work
signature verification needs to occur at the time of update not during the build
step. That means the miner's cross-compiled artifacts need to be bundled and
signed after they have been built for deployment as part of a third party miner
repo's CI/CD process.

# Drawbacks

- Why should we *not* do this?

Inserting a third party into the miner release process generates additional
overhead for the Helium Blockchain Engineering team. Pull requests submitted to
a third party's miner repo will need to be reviewed, approved and merged by an
open source maintainer retained by the third party. Urgent releases will need to
be tagged and signed by the third party before they can be deployed to the fleet
of consumer Hotspots. This increased overhead could slow the pace of feature
development and delay the release of critical bug fixes.

The Buildroot embedded Linux build system that nextgate relies on to build a
Hotspot firmware image already uses Git to clone the contents of the
helium/miner repo at a given Git commit hash. Helium's Embedded Engineering
team will need to replace the repo site in the miner makefile with the URL of
the third party's miner repo. Every time there is a new miner release the
Helium Engineering team will update the desired miner version with the latest
miner release tag. A Git tag verification step will need to be added to the
miner package makefile to ensure that the release tag verifies against the third
party's GPG public key.

Signing and updating miner independently of the rest of the Hotspot firmware
adds complexity to the nextgate CI/CD pipeline. Running Docker images on a
Hotspot requires adding a Docker runtime engine to the OTA firmware image which
is limited to 240 MB in size. Unzipping binaries on top of the Hotspot's root
file system is error prone and could result in bad updates without adequate
testing.

# Rationale and Alternatives

There are four ways to sign a miner release:

1. Sign a Git tag.
2. Sign a source tarball of a Git tag.
3. Sign a Docker image containing binaries built from a Git tag.
4. Sign a gzipped bundle of binaries built from a Git tag.

Signing a Git tag is the easiest because Git is the only tool required by both
the signer and verifier. Signing a source tarball is slightly harder because
another tool like OpenBSD's signify needs to be provisioned for both signing and
verifying. Source tarballs also necessitate checksum verification in case a
download is truncated, corrupt or tampered with.

Signing a Docker image or gzipped bundle of binaries is more difficult because
we have to wait for miner and all its dependencies to build for the target
platform. These late-stage signing methods are not mutually exclusive of the
previous two. It may be desirable to verify signatures at build time as well as
update time.

- What is the impact of not doing this?

If we do not separate miner from nextgate for signing we eventually risk greater
scrutiny from Hotspot operators, regulators and large cryptocurrency exchanges.

# Unresolved Questions

- What parts of the design do you expect to resolve through the HIP process
before this gets merged?

Which signing methods integrates best with our existing build system and OTA
update mechanism?

- What related issues do you consider out of scope for this HIP that could be
addressed in the future independently of the solution that comes out of this HIP?

How will Hotspot owners deliver their own OTA updates?

# Deployment Impact

- How will current users be impacted?

Consumer Hotspot owners will not notice a difference unless they elect to build
and deploy their own alternative miner distributions. DIY Hotspot makers and HNT
cloud miners can choose to verify miner Git release tags or source tarballs as
part of their software CI/CD pipeline if they feel so inclined.

# Success Metrics

Success is measured by:

- time it takes to Helium Blockchain and Embedded teams to implement a signing
and verification solution

- additional effort required by Helium Blockchain team to issue miner releases
