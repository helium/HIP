# HIP Sunset Console

- Author(s): [Nik Hawks](https://github.com/gristlekinginc), [Max Gold](https://github.com/maxgold91)
- Start Date: 2023-06-25
- Category: economic
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

This proposal suggests sunsetting the Helium Console (defined as the Console run by Helium Foundation, not to be confused with the private Console, commonly known as "Helium VIP", which is run by Nova Labs) by Dec 31st, 2023.  Helium Console is a free service provided by the Helium Foundation that hinders the development of the Helium Network by removing any incentive for outside businesses to operate an LNS at anything more than base cost. Transitioning to a sustainable model encourages the adoption of independently operated LoRaWAN Network Servers (LNS). This network of independently operated LNS is vital to the sustainability of a global decentralized LoRaWAN.

This HIP aims to outline a phased approach to remove access to the Helium Console quickly while ensuring a fair transition for businesses relying on the free service.

## Motivation

The motivation behind this proposal is to promote decentralization along with commercial growth and sustainability of the Helium network by encouraging businesses to operate their own LNS. 

The Helium Foundation incurs significant costs by providing the free Helium Console, and by phasing it out, they can alleviate this burden and continue the transition to a strong decentralized LoRaWAN. 

Additionally, transitioning to independently operated LNS offers benefits such as increased control and customization options for network participants.

## Stakeholders

Helium Foundation - Incurring current costs to maintain the Helium Console
Network users - Paying for data on the network

## Detailed Explanation

**Communication and Notification:** 
Promptly communicate the decision to sunset the Helium Console by the date proposed, providing the reasons, timeline, and commitment to a fair transition.

**Establish a Transition Period:** 
Provide a three step transition period for all those users relying on the free Helium Console to adjust their operations.

1. Immediately removing the ability for new users to sign up for Helium Console.  
2. Shut down all Helium Console accounts with 10 or less devices by September 1st.
3. Shut down commercial access to Helium Console on December 31st, 2023.
4. The Helium Foundatino may elect to continue to maintain Console for testing purposes or educational accounts.

**Encourage Independent LNS Adoption:** 
Actively promote the adoption of independently operated LNS during the transition period, highlighting the associated benefits.

**Migration Support and Resources:**
Helium Foundation will provide comprehensive migration guides, tutorials, and support documentation. Additionally, the Foundation will stand up a migration team of 2-3 people to offer technical assistance to any current user throughout the migration process, with priority given to accounts running commercial operations of 40 or more proveable devices in the field.

**Incentives for Early Migration:** 
Helium Foundation will provide a grant of 500 HNT for any commercial  businesses that have 40 or more provable devices in the field that have been operating prior to the first public proposal of this HIP and that complete the migration by September 1st, 2023.

## Drawbacks

Some businesses may face challenges in migrating from the free Helium Console to independently operated LNS.
It may take time for businesses to adapt their operations to the new model.

## Rationale and Alternatives

This proposal promotes sustainability, growth, and independence among Helium network participants, and allows for businesses to invest in the network. 
Alternatives, such as continuing the free Helium Console indefinitely, significantly hinder the network's long-term viability and place a financial burden on the Helium Foundation.
Additionally, the intent here should be to move as fast as possible in order to give new businesses who want to build on the Helium network a reasonable runway. 
Delaying the sunsetting for a few hundred sensors deployed against a "Console should be free" model creates an uninviting ecosystem for the thousands of business that can grow on Helium as long as they don't have to compete with "free".

## Unresolved Questions

Specific details regarding the timeline, incentives, and technical support need to be resolved through the HIP process.
How many businesses currently use and rely on the free Helium Console?  
How much data do current businesseses represent as a percentage of network LoRaWAN data?
The impact on businesses that do not migrate or choose alternative solutions should be further discussed.

## Deployment Impact

The deployment of this design will impact current users of the Helium network who rely on the free Helium Console. 
They will need to migrate to independently operated LNS to continue using the network effectively. 
Existing documentation and the knowledge base may require updates to reflect the new model. 
The backwards compatibility of this HIP needs to be considered, along with a clear procedure for migration.

## Success Metrics
- Adoption rate/number of independently operated LNS.
- Network stability and performance measurements.
- Reduction in Helium Foundation support overhead.
- User acceptance and feedback on the new model.
- Number of devices on Helium Console vs number of devices not on HC.
