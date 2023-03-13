# Towards Trusted Mappers(Give it a title here but do not allocate a number, maintainer will allocate a number)

- Author(s): @gradoj, ChatGPT<!-- your GitHub @username -->
- Start Date: 2023-03-06<!-- fill me in with today's date, YYYY-MM-DD -->
- Category: Mappers<!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

The proposed idea is to create a system for mapping the coverage of the IoT Helium network using GPS-enabled LoRaWAN sensors. Interested parties could fund the mapping of specific hotspots by submitting SOL via a Solana program. The mapping process would be carried out by trusted mappers run on a central Helium Console. Mappers would receive incentives(free mapping and recognition) for mapping newly discovered hexagons in previously unmapped areas. Their mapping data would be logged on the Solana blockchain in the form of Uber H3 hexagons. The accuracy of mapping data would be verified through a rough location check to ensure that the loudest signal comes from the nearest hotspot. 

The mapping data generated through trusted mappers can be valuable for a variety of use cases, including identifying areas of coverage for hotspots and detecting PoC gaming. By verifying the location and coverage of hotspots, the system can detect any attempts to game the PoC system and ensure that hotspots are providing accurate and reliable coverage. This mapping data can also be used to improve the overall coverage of the network by identifying areas that need additional hotspots. Additionally, this data can be sold to third-party companies or used by Helium itself for research and development purposes including adjustment of on-chain density and redundancy values. Overall, the mapping data generated through trusted mappers can be a powerful tool for improving the Helium network and ensuring the accuracy and reliability of its coverage.

A functional proof-of-concept Solana program has been partially implemented to more deeply understand a potential solution and has been deployed to the Solana devnet.

https://github.com/gradoj/leaderboard

<!-- Read the content requests in all sections before starting to write any section. -->

## Motivation

There are several motivations for implementing such a system:

1. Optimizing network coverage: By mapping the coverage of the Helium network, network operators could identify areas where coverage is weak or non-existent. This information could then be used to optimize network deployment and improve network coverage.

2. Identifying sensor vs PoC performance: Mapping the coverage of the Helium network could help identify potential network gaps, such as areas where sensors are not communicating with hotspots. This information could be used in a comparison to PoC coverage and network variable such as redundancy and scaling. 

3. Incentivizing mappers: By providing incentives for mappers to map newly discovered hexagons, network operators could encourage more mapping activity and increase the accuracy of mapping data.

4. Providing a platform for funding: By allowing interested parties to fund the mapping of specific hotspots, network operators could generate additional revenue to support network expansion and maintenance.

5. Generate high quality data. The data generated can be used for location based research and development, PoC gaming detection, location service lookup, machine learning, propagation studies, etc.

Overall, implementing a system for mapping the coverage of the Helium network could help optimize network performance, identify potential issues, and provide additional revenue streams for network operators.

## Stakeholders

Existing Mappers: This system will be optional for mappers and will only impact mappers/sensors if they choose to enroll in this system. 

Hotspot owners: Hotspot owners could benefit from increased network coverage, which could increase the value of their hotspots and potentially lead to higher earnings.

Interested parties: Interested parties such as sensor business operators who fund the mapping of specific hotspots could benefit from increased network coverage in those areas, which could improve their business operations.

This data could provide value to anyone interested in gaming detection or location based services. 

## Detailed Explanation

Current state has mappers as unofficial actors generating data in an ad-hoc fashion. They feed the data to an ingestion point under the honor system. This works as mappers are typically passionate community members who pay to provide this service. This hip proposes a central Console instance run by a Nova or the Foundation containing all Trusted Mappers and a method to incentive them. 

There is currently an established community of mappers who are committed to providing accurate mapping data. Discord is used to connect and collaborate. Making them an official actor in the Helium system with some on-chain presence will build the number of users mapping also bring data credit usage. 

Verification of the mapping data is critical to ensure the accuracy. A verification process should be put in place to cross-referencing the data with other mapper's data to analyze the data and identify any potential discrepancies. GPS data can be spoofed, however you must be within RF range for hotspots to report the packet. This will limit the amount a gamer could do with gps spoofing with a check of nearest hotspots. Providing incentives to help mappers with some of the cost and allows anyone to contribute to the mapping effort. There is always a risk of individuals trying to game a system, even when incentives are involved. 

Implement a billing system: To fund the mapping effort, a system allowing anyone to pay for the mapping of a certain hotspot could be implemented. Interested parties could submit Sol via a Solana program to fund the mapping of specific hotspots and the coverage of the hotspot would be logged on the Solana blockchain in the form of Uber h3 hexagons.

### Who pays for the mapper packet?

The mapper user will still pay for most of the data credit required to send the packets used to map the network, however, they will get free credits if they are mapping an area for the very first time or if they are mapping a hotspot that has been funded by anyone that is interested in it's coverage.

With a few rules related to who pays for the mapping data packet a system that minimizes the incentive to game can be implemented:

1. If the mapper has previously mapped the resolution 9 hexagon, they will have to pay for their own mapping data packet but if this is the first time it has been mapped they will get this sent for free. This can be one packet or multiple TBD.

2. If a hotspot has been funded to map a particular area, it will pay for each mapper's data packet for each resolution 9 hexagon that it is covering. This can be one packet or multiple TBD. 

3. If the rough location check does not pass( nearest hotspots should be highest reporting signal strength ) the mapper will pay and the hexagon will not be submitted as successful coverage.

These rules are designed to incentivize mappers to map as much as possible, while also ensuring that the cost of mapping is distributed fairly among mappers and hotspots. The rules also help to prevent bad actor mappers from submitting fraudulent mapping data by creating a financial barrier to doing so.

## Drawbacks

Mapper's resolution 9 location, from where the packets originate, are stored on the solana blockchain. This could be a privacy concern for some. 

Goes against decentralization since it requires a trusted source to collect the mapper's data.

A bad-actor trusted mapper could use this to help validate their gaming hotspots. Using this data to prove hotspots coverage with a single trusted mapper may be possible to game. In order to draw any strong conclusions about hotspot validity multiple mappers data should be taken into consideration. There is a risk of mappers providing inaccurate or falsified GPS data to collect rewards, which could compromise the accuracy of the network coverage map. The use of trusted mappers can mitigate this risk to some extent, but it is not foolproof.

There is a potential for the system to be exploited by bad actors who may attempt to manipulate the mapping data for their own gain. This could include intentionally mapping areas with poor coverage or sabotaging existing coverage data.

Finally, the use of a centralized system for managing the mapping data could create a single point of failure, which could be vulnerable to cyberattacks or other security threats. This could compromise the integrity of the entire system and lead to significant data loss or damage.

## Rationale and Alternatives

There are a few alternatives to the trusted mapper approach. One approach is to rely on the existing Helium Proof-of-Coverage (PoC) system to validate the coverage of hotspots. The PoC system requires hotspots to regularly transmit packets to nearby hotspots, which can then be used to validate their coverage. However, this approach does not provide granular information about hotspot coverage, and it is vulnerable to gaming by hotspot owners.

Another approach is to use crowd-sourced mapping data from the Helium community. This approach relies on community members voluntarily contributing mapping data to create a coverage map. While this approach can provide granular information about hotspot coverage, it is not as reliable as a trusted mapper system, as the data quality and consistency can vary widely.

Finally, another approach is to use machine learning algorithms to predict the coverage of hotspots based on their location and other relevant data. This approach can provide a comprehensive coverage map without relying on individual mappers, but it requires significant computational resources and may not be as accurate as a trusted mapper system. This used in combination with Mapper data could be a powerful combination.

## Unresolved Questions

There may be several unanswered questions related to the implementation and effectiveness of trusted mappers in mapping the Helium network:

-How do we ensure that the trusted mappers are reliable and not colluding with hotspot owners or other parties to manipulate the mapping data?

-How do we handle cases where a mapper incorrectly reports GPS data or otherwise submits inaccurate information?

-How do we balance the need for accurate mapping data with concerns around data privacy and security, particularly given that the Helium network involves location data?

-How do we ensure that the incentives for mappers are sufficient to encourage widespread participation and coverage, without being so high as to incentivize fraudulent behavior or inaccurate reporting?

-How do we handle cases where multiple mappers report conflicting data about the same hexagon or coverage area?

-What impact will the implementation of trusted mappers have on the overall functioning and security of the Helium network, and how can we measure and monitor these effects?

## Deployment Impact

If the trusted mappers system is made optional, it would not have a significant impact on the current Helium deployment. Hotspot owners who wish to participate in the system could choose to fund mapping data packets and work with trusted mappers to improve the accuracy and coverage of their hotspots. Other hotspot owners who do not wish to participate can continue operating their hotspots as usual without any impact on their mining rewards or network participation. In this way, the trusted mappers system would provide an additional layer of network optimization and security for those who choose to participate, while not affecting the current network operations for those who do not wish to participate.

## Success Metrics

Here are some metrics that could be monitored to evaluate the success or failure of the trusted mappers system:

1. Number of mappers participating: A high number of mappers participating in the program indicates that there is interest and engagement in the system.

2. Percentage of hotspot coverage mapped: The percentage of hotspot coverage that has been mapped can indicate whether the system is effective in achieving its goal of providing comprehensive coverage data.

3. Accuracy of the mapped data: The accuracy of the mapped data can be measured through validation and verification processes, which could include comparing data from multiple mappers or comparing mapped data to ground-truth measurements.

4. Usage of the mapped data: If the mapped data is being used by developers and other users to build applications or make decisions, this can be considered a positive outcome.

5. Number of bad actors detected: The system's ability to detect and prevent bad actors can be monitored through metrics such as the number of fraudulent mapping attempts or the number of mappers removed from the program.

6. Community engagement: Positive engagement from the community, such as feedback and contributions to the mapping effort, can be an indicator of the success of the program.

