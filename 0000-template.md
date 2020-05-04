- Start Date: 2020-02-18
- HIP PR: <!-- leave this empty -->
- Tracking Issue: <!-- leave this empty -->

# Summary
[summary]: #summary

LongFi is not a full protocol from the ground up, but instead a blockchain layer on top of LoRaWAN. This allows any off-the-shelf LoRaWAN device to connect to the Helium network if you can update its AppKey and AppEui.

# Motivation
[motivation]: #motivation

There are many LoRaWAN compatible devices already out there and LoRaWAN already has many desirable protocol features (ACK, downlink, FCC certified, international definition). In order to accelerate adoption of the Helium network and to lower technical barriers, LongFi is no longer a distinct protocol from LoRaWAN but instead a layering of some blockchain components on top of LoRaWAN. 


# Stakeholders
[stakeholders]: #stakeholders

* LoRaWAN device users

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

This initial implementation of LongFi on LoRaWAN focuses on a single method of end-device activation: Over-the-Air Activation (OTAA). Activation by Personalization (ABP) is currently not supported.

In OTAA, DevEUI, AppEUI, and AppKey are all the LoRaWAN primitives used in the Join Request. The LongFi primitives of OUI and Device_ID are mapped into AppEUI:

```
___________________________________________
|             AppEui (32 bit)              |

| OUI (16 bit)       | Device_ID (16 bit)  |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

The AppEui (unique device identifier) and AppKey are used to accomplish a join, at which point the device is assigned a netid, a devaddr, and arkey, and nwkey
07:53:01.544 -> netid: 3302728
07:53:01.544 -> devaddr: 1000000
07:53:01.544 -> artKey: E8-FB-23-2B-CA-41-D4-32-E0-F5-54-24-5F-FC-8A-DF
07:53:01.544 -> nwkKey: C3-E6-6F-B-B1-84-1E-4A-79-6F-27-E-E9-74-D6-3B
07:53:01.544 -> 733431: EV_TXCOMPLETE (includes waiting for RX windows)


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

Describe how this design will be deployed and any potential imapact it may have on
current users of this project.

- How will current users be impacted?

- How will existing documentation/knowlegebase need to be supported?

- Is this backwards compatible?

        - If not, what is the procedure to migrate?

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- What should we measure to prove a performance increase?

- What should we measure to prove an improvement in stability?

- What should we measure to prove a reduction in complexity?

- What should we measure to prove an acceptance of this by it's users?
