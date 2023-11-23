  # HIP XX: Obfuscating Live Voting Results

- Authors: [Andy Zyvoloski](https://github.com/heatedlime) 
- Start Date: 2023-11-02
- Category: Technical
- Original HIP PR: 
- Tracking Issue: 
- Vote Requirements: veHNT Holders


## Summary 
This HIP proposes removing live voting results on HIPs to encourage voter turnout.

## Motivation 
In real life elections, voting progress and turnout typically is not displayed live for the public to view. The creation of the blockchain allows voting to be automatically verified and display live results as the voting occurs. However, displaying live voting results may negatively impact voter turnout. For example, if one veHNT holder is against a HIP, but the results show the vote is 99% in favor of that HIP, they might be discouraged to vote. 

This HIP would remove the notion of not thinking your vote would matter, and thus, increase voter turnout. 


## Stakeholders
veHNT, veMOBILE, veIOT Holders, and Community Members - these stakeholders will be impacted, as they will no longer be able to see live voting results for HIPs that have not ended.

This HIP discourages 3rd parties from displaying live voting results on their websites, and discourages anyone from sharing live voting results with community members via discord, reddit, facebook, etc.

## Detailed Explanation 
This HIP proposes the Helium Foundation remove the display of live voting results from the system used to vote (i.e. Realms, Helium Vote, etc) until the vote has ended. Once the vote has ended, the results, and votes may be displayed for the public to view.

Further, at the time of this HIP, it is not feasible to implement truly blind voting, whereas voting results do not show live on the blockchain. Upon upgrades to the modular governance system by the Helium Foundation, this HIP gives the Helium Foundation authority to implement blind voting at a time in the future when it’s feasible to do so. 

## Drawbacks
Voting is not truly blind by removing live voting results from the voting website, as all votes are publicly viewable on the blockchain. 

## Alternatives
Do nothing and keep voting results live. However, this allows potential voting manipulation by voters being able to see how many more votes something needs to pass, and results in them staking/buying more tokens to get the HIP to pass. 

## Success Metrics
This HIP will be considered successful if voter turnout over the next 5 HIPs increases at least 25%.
