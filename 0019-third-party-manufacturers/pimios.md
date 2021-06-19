# Manufacturer name
### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)

## Summary

PiMios is an embedded systems product design and manufacturing company located in Pittsburgh, PA, USA. We are currently prototyping with the DIY concentrator and plan to manufacture the Light Hotspot (https://www.pimios.com/post/hnt-development-underway). 

## Company Information

Founded in 2013, we are embedded system developers who have launched products into outer space, performance athletics, and agriculture. Across our 3 industry segments we sell between 3,000 and 5,000 manufactured products annually. What brought us to Helium is a personal love of decentralization, cryptocurrency, and embedded systems. This is where our passion meets our expertise.

## Product Information

We develop and manufacture products for customers across 3 main industries:
1. Space
2. Performance Athletics
3. Agriculture

* One of our first main products was a high precision Master Reference Oscillator for a prominent Low Earth Orbit (LEO) satellie constellation (not allowed to disclose customer name). This product maintained a clock precision of 10 parts per billion (ppb) with a space-grade microcontroller. We were able to drive out 40% of the payload cost by qualifying automotive grade components for use in outer space. Partner website (https://resources.bliley.com/iris-space-ocxo-leo-constellations-small-satellites).
* We developed a custom 915MHz product for impact detection in performance athletics. The previous generation of this product used Bluetooth, and was not able to provide real-time data transfer from a large number of football players on the field at once. We built a 915MHz network that allows up to 120 athletes to simultaneously transmit real-time data into their team dashboards. This allows athletic trainers to quickly evaluate the health and safety of the players. Customer website (https://www.athleteintelligence.com/products/).
* We also supply IoT products in the agriculture industry. This is important, because the hardware is exposed to extreme weather conditions, heavy rain, and rough abuse with banging and constant dirt. We developed a Bluetooth product to improve logistics of grain harvesting operations across North America. This results in 15% increased efficiency in harvesting across the board. Customer website (https://pipeag.com/live-view/).
* We will be very active in the Helium community to ensure the hardware plays nice with the official Helium app and end user configuration features, such as OTA firmware updates.
* As of today, we have the ability to launch production of 5,000 Hotspots as early as September 2021. Retail price is TBD pending enclosure materials and testing for weatherproofing, but we are expected to be priced around $499.

## Previous shipments

We have certified FCC and IC products for both custom chip-down solutions as well as pre-certified modules in the USA and Canada. We have not certified any products for CE approval under the PiMios unbrella (yet), but our engineers have compelted CE approvals in their past corporate lives.

## Customer Support

We currently use Jira Service Management for our customer support of products. We plan to link to that in our GitHub and PiMios webpages, but we will also maintain active social media presence on Twitter and Discord to field customer support questions. All social media requests will be funneled into our Jira Service Desk instance to stay on top of all requests. We plan to handle repairs and replacements with RMA shipping returns. Depending on inventory availbility, we will either replace immediately while repairing returned units, or repair and return the same unit to the same customer.

## Hardware Security

We are developing the hardware closely according to the documented HNT Security Requirements (https://docs.helium.com/mine-hnt/hotspot-makers/security-requirements/).

* At the component level, we have adopted the ATECC608A IC with CryptoAuthentication
* The MCUs will be configured to prevent binary dumps should someone gain access to the internals
* We are exploring optional tamper protection to wipe the master MCU should it be tampered with/disassembled. We say "optional" for now as we want to gauge community desire for this feature since it would wipe the device clean.
* We will be happy to submit a product for audit and share the results with the community

## Hardware Information

Please let us know:
* Which security (swarm) chip are you using? - ATECC608A
* Which LoRa chipset are you planning to use in your gateway - SX1302
* Where are you sourcing your components? - Mixture of China and domestic (USA) suppliers. Our components are randomly sampled, tested and verified for authenticity. We plan to offer 2 price points for the hardware: 1) Randomly sampled components from each manufacture lot (full BoM sample) at standard retail price 2) 100% component audit/inspection (higher cost per unit)
* How many radio modules/ concentrators can you procure? - We have procured full BoM for 500 units as of 6/2021. We have deliveries due for 5,000 units by 9/2021.

## Manufacturing Information

We have deep experience delivering hardware products over the last 8 years. While we highlight our successes online, we are painfully aware of what can go wrong with QA, supply chain, field testing, etc. We continue to improve our processes to mitigate risk with customer deliverables, and we do not make commitments we cannot hit. We currently manufacture between 3,000-5,000 units across 3 industry segments. All of these products were custom designs that were built from the ground up. Once the pandemic hit, we had to drastically re-evaluate our global supply chain for redundancy and reliability. We now have direct partnerships with China manufacturers and we leverage a combination of third party and internal QA processes to ensure security and quality. Our manufacturing partners are mostly domestic (USA) PCBA factories. The rest of our manufacturing processes are internal, including custom electronics fabrication, custom metals/plastics fabrication, product programming, QA, and testing.

## Proof of Identity

Per typical KYC/AML procedures, proof of identity for major shareholders (25%+ ownership) will be expected to be provided privately to representatives from Helium Inc or DeWi board members. This will be attested and publicly confirmed by those representatives, e.g. as GitHub comments. Contact details for this will be provided after your application is submitted on GitHub.

## Budget & Capital

We hope to build and sell between 5,000 to 10,000 in the next 6-8 months. We will need to spend upwards of 7 figures to ramp up manufacturing. We have allocated enough cash on hand to begin the manufacturing ramp-up, and we plan to sell pre-orders to raise the remaining funds. Pre-orders will help de-risk the ramp-up period as it guarantees demand for our investment. If needed, we have business lines of credit that we can draw on to bridge any gaps in funding.

## Risks & Challenges

The biggest risk we have is supply chain and managing increasing orders. That has largely been mitigated as we only plan to sell the number of units we are able to manufacture with the components we have already purchased and received. We have de-risked all of the technical build as all of our prototyping capabilities are in-house. Beyond delivery, we plan to hire additional employees dedicated to support this program. Our main goal and differentiator is to focus on customer support, as we have personal experience in seeing customer service as a lacking feature in the crypto community when it comes to hardware support.

## Other information

* Desired Discord support channel name - #pimios
* Twitter profile - https://twitter.com/Pi_Mios
* Facebook profile - 
* Other social profiles - 
* Website - https://www.pimios.com/
* Contact info - nick@pimios.com
* Payment methods available - Visa, Mastercard, AMEX, Google Pay, Apple Pay, Bitcoin, Monero
* Regions covered / shipped to - USA, Canada (Mexico, EU to follow)
