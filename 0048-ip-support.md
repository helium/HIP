# HIP 48: IP Support

- Author(s): @ivelin
- Start Date: Dec 6, 2021
- Category: Technical, Economic
- Original HIP PR: <https://github.com/helium/HIP/pull/320>
- Tracking Issue: <https://github.com/helium/HIP/issues/319>

# Summary

It appears that as of Dec 2021, Helium supports only simple Class A broadcast messages under 100
bytes. This is a good start, but without IP support, the use cases are somewhat limited.

# Motivation

IP support would open up application for IoT devices using MQTT, WebRTC, HTTP and other widely used
protocols that majority of developers are familiar with. Note that IP support does not necessarily
mean broadband speeds. In many cases smart IoT devices do not need to constantly stream large
amounts of data.

For example privacy preserving smart cameras do not need to stream audio/video to a cloud service or
a central NVR server as traditional IP cameras do. Instead they can send brief notifications when an
event of interest is observed (person, pet, car, fall, fire, etc). One such project is ambianic.ai:
<https://github.com/ambianic> .

There is also a proof of concept project that demonstrates feasibility of the use case:
[Smart Cam alerts over LoRa](https://hackaday.io/project/162667-lora-neural-network-security-system)

# Stakeholders

- Who is affected by this HIP?

Helium miners, LoRa developers and IoT over IP users.

- How are we soliciting feedback on this HIP from these stakeholders? Note that they may not be
  watching the HIPs repository or even aren't directly active in the Helium Community Slack
  channels.

I started reaching out to people in the Helium discord channels: `sensors-usage`,
`questions-and-answers`.

There are also two related discussion in the Helium and Ambianic online forums:
<https://github.com/helium/HIP/issues/319>
<https://github.com/ambianic/ambianic-edge/discussions/405>

# Detailed Explanation

There are several projects that demonstrate IP stack deployment over LoRa:

<https://airbus-cyber-security.com/ip2lora-a-diverted-use-of-lora-to-build-your-wireless-ip-link-over-kilometers/>

<https://changelog.complete.org/archives/10048-tcp-ip-over-lora-radios>

# Drawbacks

TBD

# Rationale and Alternatives

TBD

# Unresolved Questions

TBD

# Deployment Impact

TBD

# Success Metrics

TBD
