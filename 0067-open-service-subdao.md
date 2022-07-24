# HIP Template

- Author(s): [@haihongS](https://github.com/haihongS) [@sndnsos](https://github.com/sndnsos), 
- Start Date: 07/23/2022
- Category: economic, technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->


# Summary
[summary]: #summary

[HIP 51: Helium DAO](https://github.com/helium/HIP/blob/main/0051-helium-dao.md) proposed that each communications network built on top of the Helium Network (LoRaWAN, WiFi, 5G, CDN, VPN — referred to as Decentralized Network Protocols or DNPs) has its own subDAO with its own token (referred to as Decentralized Network Tokens or DNTs). The key specifications of the DNP such as Proof-of-Coverage rules, mining rewards, and Data Transfer pricing are governed by each DNP subDAO.

For the services on CDN and VPN for example, there would be lots of projects that want to use Helium's Network to help run various services.
We think for many Heliums nodes, their bandwidth resources, storage spaces, device performance, and all idle resources today, should be more fully taken used now and in the future. 
So here we suggest Helium start an open service list for the projects who have the requirement to use Helium Network. And for the nodes of the helium network, they could choose to run any services in the list as their wish, getting extra motivation rewards in return.

And the services which could join the open list need to follow some standards made by the community.
We suggest to start the Open-Service subDAO under Helium Network which plays some open and special roles in Helium Network.


# Explanation
- What is the service list?
    The service list is for multiple services to easily join/use Helium Network.
    The Helium node owner could pick any services in the list, and install/uninstall the services.
    The project side needs to pay the Data Credits to use the services provided by Helium nodes.
- For the project side, how to join the list?
    The project side should inform the usage scenarios, the resource it consumes, and publish the source codes, finishing the process to guarantee its security.
    The subDAO committee will examine and approve/reject the application.
- For the helium node owners, what do they need to do?
    There need to update the service list, and be able to choose any services to install anytime, also be able to quit the services anytime.

# Launch
[motivation]: #motivation

Meson Network would like to be one of the start projects to launch the service list.
As a bandwidth trading platform, [Meson Network](https://meson.network) takes use of idle bandwidth resources to help distribute files/data globally.
The global distributed Helium nodes could help Meson Newtowk to deliver the different kinds of files/data, and get the service fee in return for how much it contributes. 

Meson Network is going to draft and finish the application form, proposing the charging standard form, giving the Helium Nodes a choice to share their bandwidth/space to install the Meson service. The team of Meson Network will help the different kinds of Helium to deploy Meson.
They could install the patch to share some resources to help Meson Network, and quit anytime as their wish.

# Deployment Impact
[deployment-impact]: #deployment-impact

 - Make Helium Network more commonly used for multiple purposes.
 - Help the Helium node owners get more rewards.
 - Build a network service trading platform and help the development and growth of the Internet, reducing the cost and improving the performance with the tremendous Helium nodes around the world
 

# Unresolved Questions*
[unresolved]: #unresolved-questions

- Is it a better choice to get an open service list? Or for each project to join to create an independent subDAO like Meson subDAO?
