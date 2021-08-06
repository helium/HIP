# Miromico AG

### Application to become an approved third party manufacturer as per [HIP19](https://github.com/helium/HIP/blob/master/0019-third-party-manufacturers.md)

## Summary

Miromico is a Swiss based global leader in Wireless IoT hardware,
firmware and systems like LoRaWAN and in mixed Signal ASIC design. We
and our customers and partners want to integrate our battle-proof
miroEdge platform of LoRaWAN gateways as Light Hotspots into the Helium
network. Links: \* [General
Information](https://miromico.ch/portfolio/fmlr-gateway/?lang=en) \*
[Gateway Card](https://miromico.ch/portfolio/miro-edgecard/?lang=en) \*
[Usage Docs](https://docs.miromico.ch/miroEdge/index.html)

## Company Information

Miromico AG was founded in 2002 in Zürich, Switzerland and is a
private-owned, Swiss based global leader in mixed Signal ASIC, Embedded
Systems, IoT design and production with nearly 20 years of experience.
With a long and strong focus on designing our and our customers products
and systems we are proud seeing some of our developments as the worlds
best products in its category used around the globe in millions of
units. We design, manufacture and ship both standard compliant and
proprietary components, products and systems. Over the two decades we’ve
build all kinds of electronic products and systems. From ultra low cost
low power sensors, actors, proprietary and standard wireless systems for
ISM, cellular and satellite communication, wireless, digital, ultra-low
latency HD video transmission systems, many different Linux-based
products and system, often with our own custom designed hardware,
automated production testing rigs and systems up to large, custom,
FPGA-driven high-performance hyper-scale cloud-storage systems we’ve
done everything. Our proprietary MiroEdge product platform of LoRaWAN
gateways has a 5-digit-installed user base. Our 868/915 MHz / 2.4 GHz
LoRa-based designs have a installed user base of millions of devices.
2.4 GHz LoRa both gateways and devices see a huge growth recently.
Recently customers and partners were pushing us again and again to
provide Helium-Network integration for our platforms.

## Product Information

- MiroEdge - a ultra modular edge platform 2, 3 or 4 standard compliant
  mPCI-E slots (USB 2.0)
- Mips24k or Quad core Cortex-A72 (ARM v8) 64-bit SoC @ 1.5GHz
- Supported regions: global by gateway cards and firmware supporting the
  correct region
- Backhauls: Ethernet, WiFi, LTE
- Power Supply via Power over Ethernet (PoE), 5 VDC MicroUSB/Solder
  terminal
- Antenna internal, external or antenna diversity
- 1-4 LoRaWAN gateway cards (8-32 channels): miroEdge Card (Semtech
  SX1308/01 GW chipset 868/915 MHz, 8 channels, 27 dBm) or others
- Indoor and outdoor versions available
- Multiple options like power fail protection, Battery backup UPS,
  Satellite back-haul, 2.4 GHz LoRa GW,
- Starts from 199,- EUR in high volume
- in sales at our distributors
- We have our local port of the Helium software running on the miro Edge
- 5-digits of installed devices
- [Website link](https://miromico.ch/portfolio/fmlr-gateway/)
- [Distributer
  link](https://www.avnet.com/shop/emea/search/fmlr%20picogw#categoryId=3074457345616680430&)
- lead times 1-3 weeks from stock, can vary depending on current stock

## Previous shipments

- Miromico is in business as a hardware design company since 2002, we
  ship our own products since about 10 years now, our partners in
  manufacturing, logistics and distribution are global leads since
  decades
- We ship FCC, CE and others approved products regularly to many
  European countries (like Germany, UK, Belgium, France, Netherlands,
  Norway, Sweden, Switzerland, Italy, Poland, Hungary) the USA, Canada,
  Ecuador, Argentina, Brazil, South Africa, Australia, New Zealand, Hong
  Kong and more.
- With the help of our global distribution partners like AVNET (Top 3
  global distributor), Farnell, Glyn (Asia, Australia, New Zealand),
  Computer Controls (East Europe, Asia) and more to come our goal is to
  ship to every country on the globe.

## Customer Support

Miromico has a system of 1st level support via mail, chat, an
online-forum and by trained FAE of our distributors (AVNET, FARNELL,
Computer Controls and more to come). 2nd level support is directly
provided by senior Miromico engineers. For our hardware we provide
multiple warranty and service level options covering up to 10 years for
hardware, batteries and whole systems. The miro Edge gateway platform is
LinuxOS based and we provide firmware updates which can be initiated
from remote via web interface, SSH or API using any back-haul connection
like Ethernet, WiFi, LTE, satellite. Docs, manuals, firmwares etc. can
be downloaded [here](https://docs.miromico.ch/datasheets/gateways.html).

If possible, we would like to get our own channel on the helium discord
to get in direct contact with end users.

## Hardware Security Element

We will use the already approved ECC608A/B chip (based on availability,
footprints for both chips will be on the board and may be separately
populated). This will ensure easy integration with
[gateway-rs](https://github.com/helium/gateway-rs/tree/c888ec26d0b8d39b91579e13c02b0ae22e1ec3d5)
and also allows us to use the
[gateway_mfr](https://github.com/helium/gateway_mfr), provided by helium
to provision the chips in production.

Some additional considerations concerning the Linux are listed below:

- Gateway card firmware is a binary contained in the Linux image
- LinuxOS is completely contained in a sealed hardware module
- The miro Edge is LinuxOS based and we provide firmware updates (one
  binary contains both Linux and LoRaWAN GW card) which can be initiated
  from remote via web-interface, SSH or API using any back-haul
  connection.
- The bootloader of the Media Tek chip is locked and the firmware can be
  updated via USB even

## Hardware Information

- most of our 868/915 MHz gateways use 1..4 of our own SX1301/08 &
  SX1255/57 based miro EdgeCard (8-32 channels)
- Our next generation miro EdgeCard using SX1302/03 & SX1250s is almost
  finished
- AVNET our directly from the chip vendors like Semtech, Skyworks
- Miromico is specializing in designing and providing large-scale,
  high-volume IoT hardware. Our partner-setup of sourcing,
  manufacturing, distribution and logistics is capable of scaling into
  multi-millions of devices annually.

## Manufacturing Information

- Miromico designs, builds and delivers radio hardware products since
  11+ years
- Miromico designs, builds and delivers gateway hardware products since
  12+ years
- Miromico has 5-digits of installed gateway products solely designed
  and build by us
- Our world-class partner-setup for sourcing, manufacturing,
  distribution and logistics has a daily-proofen capacity of
  multi-millions of devices per year.

## Proof of Identity

This is the [public company
record](https://zh.chregister.ch/cr-portal/auszug/auszug.xhtml;?uid=CHE-109.441.167&amt=ZH)
of Miromico AG, Switzerland

## Budget & Capital

We have an on-going, continuous, lean production and sales process with
certain buffers to cope with components issues like its seen in the past
months due to Covid-19 and trade wars. Usually our hardware business is
fully financed without any loans solely by customers and revenue.
Gateway business (and financing requirements) in IoT is typically way
smaller then device and sensor business - there is only 1 gateway per 10
or 100 or 1000 or 100k wireless IoT devices. We were asked by some of
our partners and customers to provide our Miro Edge platform to the
Helium network asap. We cannot foresee much about the volume of devices
- but we are prepared to provide millions of devices over time if
necessary.

## Risks & Challenges

Global components and supply chain crisis (Covid-19, trade wars) is a
main issue we and our partners have dedicated teams setup to take care
for. Its getting better recently but we still have to put a lot of daily
effort that we still can ship every day.

## Other information

- [Contact
  info](https://miromico.ch/imprint/?lang=en%20wireless@miromico.ch)
- [LinkedIn](https://www.linkedin.com/company/miromico)
- [Website](https://miromico.ch/?lang=en)
- [Twitter profile](https://twitter.com/miromicoAG)
- Payment methods available: wire transfer (IBAN), Paypal
