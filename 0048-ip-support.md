# HIP Template

- Author(s): @ivelin
- Start Date: Dec 6, 2021
- Category: Technical, Economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

It appears that as of Dec 2021, Helium supports only simple Class A broadcast messages under 100 bytes. This is a good start, but without IP support, the use cases are somewhat limited.

# Motivation
[motivation]: #motivation


IP support would open up application for IoT devices using MQTT, WebRTC, HTTP and other widely used protocols that majority of developers are familiar with. Note that IP support does not necessarily mean broadband speeds. In many cases smart IoT devices do not need to constantly stream large amounts of data.

For example privacy preserving smart cameras do not need to stream audio/video to a cloud service or a central NVR server as traditional IP cameras do. Instead they can send brief notifications when an event of interest is observed (person, pet, car, fall, fire, etc). One such project is ambianic.ai: https://github.com/ambianic .

There is also a proof of concept project that demonstrates feasibility of the use case: [Smart Cam alerts over LoRa](https://hackaday.io/project/162667-lora-neural-network-security-system)

# Stakeholders
[stakeholders]: #stakeholders

* Who is affected by this HIP?

Helium miners, LoRa developers and IoT over IP users.

* How are we soliciting feedback on this HIP from these stakeholders? Note that
  they may not be watching the HIPs repository or even aren't directly active in
  the Helium Community Slack channels.

I started reaching out to people in the Helium discord channels: `sensors-usage`, `questions-and-answers`.

There are also two related discussion in the Helium and Ambianic online forums:
https://github.com/helium/HIP/issues/319
https://github.com/ambianic/ambianic-edge/discussions/405

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

There are several projects that demonstrate IP stack deployment over LoRa:

https://airbus-cyber-security.com/ip2lora-a-diverted-use-of-lora-to-build-your-wireless-ip-link-over-kilometers/

https://changelog.complete.org/archives/10048-tcp-ip-over-lora-radios


- Introduce and explain new concepts.

- It should be reasonably clear how the proposal would be implemented.

- Provide representative examples that show how this proposal would be commonly
  used.

- Corner cases should be dissected by example.

# Drawbacks
[drawbacks]: #drawbacks

- Why should we *not* do this?

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

- Why is this design the best in the space of possible designs?

- What other designs have been considered and what is the rationale for not
  choosing them?

- What is the impact of not doing this?

# Unresolved Questions
[unresolved]: #unresolved-questions

- What parts of the design do you expect to resolve through the HIP process
  before this gets merged?

- What parts of the design do you expect to resolve through the implementation
  of this feature?

- What related issues do you consider out of scope for this HIP that could be
  addressed in the future independently of the solution that comes out of this
  HIP?

# Deployment Impact
[deployment-impact]: #deployment-impact

Describe how this design will be deployed and any potential impact it may have on
current users of this project.

- How will current users be impacted?

- How will existing documentation/knowlegebase need to be supported?

- Is this backwards compatible?

        - If not, what is the procedure to migrate?

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

Possible success metrics:
- Short term (1-3 months): user staking on this proposal with commitment to deploy IP devices on Helium when available.
- Longer term (12-18 months): number of new IP devices deployed on Helium.

- What should we measure to prove a performance increase?

- What should we measure to prove an improvement in stability?

- What should we measure to prove a reduction in complexity?

- What should we measure to prove an acceptance of this by it's users?
