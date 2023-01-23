# HIP allocating unused processing power for scientific research.

- Author(s): snipeTR
- Start Date: 23.01.2023
- Category: technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

The incredible amount of total processing power created by changing hotspot tasks with HIP 55 will enable changes to be used for one/multiple projects that will benefit the world.
<!-- Read the content requests in all sections before starting to write any section. -->

# Motivation

With HIP 55, many HOTSPOT devices have turned into a type of hotspot called "light" hotspot, and the processing power used for block processing has become almost completely useless.

 Currently, thousands of devices with extremely powerful processors and Terabytes of memory are sitting idle on roofs and in houses. These devices are always open to electricity and internet access, and many have advanced cooling systems. Because they are not performing any block processing, they are wasting energy and running idle until the next ping. 

On average, each hotspot has the potential of 1Ghz single-core processing power, with the best case scenario being 1.4 ghz dual-core processing power and 1Gb - 8Gb of memory, all sitting idle in dusty plastic/metal boxes on rooftops and in corners of rooms. If you multiply these numbers by an average of 500,000 hotspots, it's not hard to see the incredible processing and memory power that is going to waste. 

To put this idle power to good use for the benefit of humanity, by using a completely scientific and civilian distributed system for computing mechanism for climate and nuclear research in the future, which could help humanity escape from the climate crisis and infectious diseases more quickly, is in my opinion, quite possible. This way, people living on this world could benefit from it and thank the helium community every day. 

If we think deeper, we can leave the choice of participating to personal selection and encourage the participation by rewarding them with helium award. But I think this is a different HIP topic.

# Stakeholders

- As a result of this HIP, I believe that all of humanity and all civilizations, including future generations, will be affected positively. I wanted to give an example of a "distributed system computing mechanism" that I mentioned above. There is an organization like this at https://boinc.berkeley.edu/ but a better computing organization may be found as a community. It would be good to make this decision together with the helium community. For example, after the necessary HIP for the limitations and operation of the mechanism is approved, a different HIP can be used to decide which distributed system computing organization/coordinator to work with.

- If as a result of this scientific computation, even at a very low level, electricity and bandwidth are consumed by the community, the following method can be used for the initial setup:
- - a Participation in the distributed computing system starts actively for everyone, and then a method is created for shutting it off.
     - a1- An award is given for the method and it is encouraged not to shut it off.
     - a2- No award is given for the method.
  - b- Participation in the distributed computing system starts inactively, and then a method is created for turning it on.
    - b1- An award is given for the method and it is encouraged to turn on the system.
    - b2- No award is given for the method.

# Detailed Explanation

**The scientific advancement that will result from this proposal is incredibly large compared to the individual cost of the energy spent. **

We can see how diseases like COVID have affected humanity. It is not incorrect to say that the way vaccines were developed so quickly for this disease was through distributed computing clusters, which we refer to as supercomputers. By repeating millions of simulations with thousands of possibilities in minutes, the ability to find optimal calculations and molecules has made it easier to find vaccines and prevent the pandemic from lasting for decades and saving millions of lives. This is just one example of a current and simple use case that I can give.

There can be various criteria for using this excess processing and memory power for scientific calculations and operations. For example, during transmission, these operations can be given a lower priority. This way, they do not affect the use of the helium network. And in this way, with the excess processing power, they can continue their calculations in a comfortable manner without affecting the necessary updates and system stability with a higher priority.

Another system control mechanism can be memory and processor/system temperature controls. For example, the amount of memory used can be the amount calculated as free by the system. And it can be changed dynamically. This way, the functionality of the helium network will not be affected. The situation where the operation is stopped based on the processor temperature can also be considered as a method that does not affect the functionality of helium and allows scientific calculations to continue and prevent possible hardware failures.

The algorithm is as follows:
- The helium hotspot software should be run at a lower CPU priority.
- If the amount of free memory is above a certain level, this amount of memory should be used.
- If the system temperature rises to 70 degrees or above, the scientific calculation should be stopped..

# Drawbacks

- There are two reasons not to do this requires inter-agency coordination (berkeley etc, vs helium)
- Difficulties in software development.

# Rationale and Alternatives

This is a unique proposal. 

There is no disadvantage to doing it, other than time and effort. 

However, if we don't do it, we will never know what contributions we can make to science. In the future, other than seeing news headlines like "the helium community found a definitive cure for cancer of xxxx", I can't see any disadvantage (:)).

# Unresolved Questions

For this hypothesis, a standard data set should be first requested from hardware manufacturers. 

##### The data should consist of:
1. Total units produced
2. Number online
3. Minimum RAM
4. Maximum RAM
5. Average free RAM
6. Minimum processor speed produced
7. Maximum processor speed produced
8. Number of processor cores
9. Disk size
10. Average free disk space
11. Average internet speed
12. Minimum processor temperature
13. Maximum processor temperature
14. Average ambient temperature

With these data, a security framework should be constructed. This security framework should be loaded onto systems with a separate update to obtain current data and calculate potential processing power. In other words, a kind of dummy calculation should be made and the effects of this calculation on the helium network should be monitored and adjustments made to optimize the security framework and not affect the helium network. After all, these devices perform operations that last only a tenth of a second every 10-15 times per hour. The rest of the time, they are idle.

Once this security framework system is successfully active, the necessary institutions will gladly develop and quickly write this software to make it applicable to systems. I am almost certain that they will provide the central servers themselves. No one will say no to such a scientific aid on this scale.

If this security layer test is successfully completed, it poses no security risk to helium because these hardware that uses linux embedded systems work in a separate user and permission, and even a software that runs under a container system like docker can never reach the software above and cannot steal information or stop their work. Special keys created specifically for helium, or similar things, must first be a major security vulnerability related to the institution in question, then take advantage of some vulnerabilities in the helium system, and then take advantage of the vulnerabilities of the devices. This possibility is reduced to zero.

The creation of the security framework is really important, but it is not a difficult task. It is a matter of collecting data and applying them to a simple algorithm. The algorithm that will be developed with the data obtained from the manufacturers will be able to analyze the data and report the results in a very short time.

# Deployment Impact

Describe how this design will be deployed and any potential impact it may have on
current users of this project.

- How will current users be impacted?
		Existing users will not be technically affected.

- How will existing documentation/knowlegebase need to be supported?
  Any content to change at <http://docs.helium.com> ?
		just a little information and a short article.

- Is this backwards compatible?
		yes
- Can this HIP be undone?
		yes


# Success Metrics

What metrics can be used to measure the success of this design?

		Despite no changes appearing in activities on the helium network, there is an incredible increase in the average processing power of the following website over 24 hours: https://boinc.berkeley.edu/computing.php

Are any new ETL reports needed to measure the success?

		yes, hardware statistics and a report showing the change in helium network activities may be required.

