Author: [@gateholder](https://github.com/gateholder)

Start date: TBA

Category: Add a Wireless Service Provider

Original HIP PR: none

Tracking Issue: none

Vote Requirements: VeMobile Holders

( [HIP53](https://github.com/helium/HIP/blob/main/0053-mobile-dao.md#economics-overview) and [HIP82](https://github.com/helium/HIP/blob/main/0082-helium-mobile-service-provider.md) )

**Summary**

This HIP proposes to introduce a new service provider to the Helium network. Worthington networks will provide fixed wireless services over the Helium 5G network . Using the robust coverage of the CBRS network Worthington networks will buy, market and sell data and plans to new fixed wireless subscribers.

**Motivation**

The CBRS Helium Network has a superior infrastructure to support and provide the fixed wireless services at low cost. This will provide an alternative use case for the CBRS Helium network. We expect this effort to increase the usage and viability of and incentivize the expansion of the CBRS Helium network.

**Stake holders**

This HIP affects:

- Worthington Networks
- Helium mobile deployers
- Helium community

**Detailed Explanation**

We plan to use the CBRS network to provide fixed cost wireless services to customers using 4 CPE devices and 2 different service level plans. The Outdoor High-powered CPE would be used to connect to an available CBRS network. The Indoor CPE High power would be used to provide high speed wireless access to the internet, whereas the Indoor Low power CPE would be used for basic internet access. For example, a premium customer could use 100% of the band width of one CBRS radio. However, a CBRS radio can service 96 customers simultaneously at varying levels of service. Also, a CBRS radio can handle roughly 20, 4k Netflix streams.

4 CPE devices:

1. Outdoor - High power (long range up to 2 miles) - ATOM OD15 CPE
2. Outdoor - Low power - ATOM OD06 HIGH GAIN CPE
3. Indoor - High power - ATOM ID15M-HP CPE
4. Indoor - Low power, low cost - ATOM ID04/06 CPE

The service plan cost will be region specific but the rewards to the plans will be 75% of the fixed monthly cost (not including equipment, installation cost, and taxes paid) and the Providers will receive their proportional reward of the data provided to the customer. Worthington Networks will burn the equivalent HNT tokens to pay for data transfers and the Providers will be rewarded with the equivalent in kind MOBILE tokens.

Example:

Basic Customer plan - $20 per month

Premium Customer plan - $40 per month  
<br/>

|     | Customer 1 (example @ $20/mo) | Customer 2 (example @ $40/mo) |
| --- | --- | --- |
| Provider 1 | 10% - of the data traffic | 75% - of the data traffic |
| --- | --- | --- |
| Provider 2 | 90% - of the data traffic | 25% - of the data traffic |
| --- | --- | --- |

Provider 1 would receive $1.50 (10% x 75% of $20) for data traffic paid in Helium mobile emissions for Customer 1 and would receive $22.50 (75% x 75% of $40) for Customer 2 for a total of $24.00

Provider 2 would receive $13.50 (90% x 75% of $20) for data traffic paid in Helium mobile emissions for Customer 1 and would receive $7.50 (25% x 75% of $40) for Customer 2 for a total of $21.00

Snap shots are to be taken at 00:00 UTC on a revolving cycle based on the billing schedule. Worthington Networks will burn the equivalent value of HNT (75% of the net plan cost) and in return the Service Providers will receive the equivalent in mobile tokens as Data Rewards.

Corner Case

Where CBRS networks are not available to a customer, we plan to incentivize the customer with the installation of a CBRS network device at their home or arrange for one to be installed that would provide an access point within range. We would assist them in connecting to their local ISP.

**Implementation**

We leave the implementation of the smart contract components, verifiability, and Service Provider compliance up to the Helium Core Developers.

The service must be highly available, reliable and performant. This is imperative to be able to provide subscribers with a service they would consider using for a long term. Redundancy and secondary sourcing needs to be considered to achieve the high availability for long term success.

**Drawbacks**

Over saturation of Internet connections could occur and plans would be needed to appropriately limit the data traffic throughput or strategies need to be put in place to provide additional capabilities?

**Rationale and Alternatives**

The CBRS network provides the best connectivity since it is better at penetrating various obstacles. It provides a larger coverage area with more robust coverage over different types of terrain. With the widespread deployment of CBRS equipment a significant number of potential subscribers has been reached.

**Unresolved Questions**

· The compensation will be based on fixed price service plans chosen and not the data transmission of $.5 per GB used?

· The community needs to vote in the Tiered Service Provider system

· The Foundation would need to program the reward mechanism.

**Success Metrics**

Worthington Networks can create a large pool of customers to the Helium Network for mutually beneficial ends.

We will need to monitor the availability of the CBRS network devices involved in providing the service to ensure that they are highly available. Internet access needs to be available 99.99% of the time.

We will need to monitor the throughput of the CBRS network devices involved in providing the service to ensure that subscribers are being serviced in a responsive manner.