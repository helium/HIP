# HIP11: Usage-based Data Transfer Rewards

- Start Date: 2020/08/19
- Original HIP PR: [#33](https://github.com/helium/HIP/pull/33)
- Tracking Issue: [#34](https://github.com/helium/HIP/issues/34)
- Author: @JMFayal

# Summary
Developing a DC reward system that combines a set reward per DC transmitted and a cap on total HNT per Epoch per hotspot continues to incentivize building the network around real world data usage, while still encouraging HNT burn and limiting the reward for extreme gamification. For the reward to have an impact it has to be significant enough to incentivize network building, which I believe is accomplished at setting the reward to $0.0001 per DC transfer or approximately 1000% the DC cost.

# Stakeholders

I plan to circulate this proposal in Discord #hips and on the Helium community Reddit. I will also solicit specific individuals for feedback, from both within the Helium community and other crypto and open-source projects.
Specifically I would like to achieve rough consensus around this process with Hotspot owners, Helium Inc (as the primary developer of nearly all core Helium software), and the newly-formed DeWi Alliance, which plans to commit time & money to community governance in the Helium ecosystem.
On-the-record comments should be made on this HIP's {{to be made}}.

# Detailed Explanation

## Adjusted Reward Structure

There would be three components to the reward structure. Including establishing the maximum reward of $0.0001 per DC transmission (i.e. 1:10 reward), setting a per hotspot per epoch cap and redistributing the rewards.

### Establishing a $0.0001 reward for DC transmission

By establishing a set $0.0001 reward per DC transmitted by a hotspot, there is a significant incentive for companies and individuals to build networks around data usage or potential data usage. The total DC reward for the community would max out at the current 32.5% rate established in the initial whitepaper and reconfirmed over months of community discussion. Once total rewards hit the 32.5% the per DC reward would automatically adjust downward to maintain the 32.5% cap.

Under this model, people building networks around legitimate data usage will not be penalized by people building around farmed data sources. It also gives the community a tool to incentivize the growth of the network by creating data transmission ‘centers’ in key industries and locales. I would personally be interested in contributing to such an effort to incentivize the growth of the network around the US highways system and in key industries like agriculture and energy.

### Setting a per hotspot per epoch cap

By establishing a 100,000 DC per epoch per hotspot cap on data rewards, it disincentives ‘extreme’ gaming of the system and puts a cap on the time and energy of developers working to optimize mining devices. It also reduces to total mining going to the top few percentile of DC mining units and allows for the redistribution of that HNT, while still incentivizing significant data usage in the system. As the value of per DC rewards come down, so will the total max reward as the ratio remains.

### Redistribution of rewards

Any HNT that would be mined above the cap can be redistributed to either the PoC community or evenly to any hotspot that transmits the data. They both have value but I would propose the redistribution to the hotspots transmitting data to over incentivize low DC transmitting use cases like Tabs, dog collars and most other current use cases.

That provides an even great reward to companies building systems around their own data usage, even if the data amounts are small. In my opinion, the most important thing the community can incentivize at this time is building networks that fit the needs of real world use cases and this proposal over incentives said networks.

Alternatively, redistributing the HNT to PoC witnesses and Challengees helps incentivize PoC growth regardless of real world application. Growth in hotspot numbers has value in itself.
