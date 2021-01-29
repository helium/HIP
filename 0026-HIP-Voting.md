
# HIP Template

- Author(s): maco2035
- Start Date: 2020-01-26
- Category: Economic, Technical, & Meta
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

  This proposal is used for helping gaining conseous on the blockchain for HIPs. Currently it is done by a few people who can say I want to do this. As observed from the DEWI calls it is mainly the helium team, and less then 50 others. With this, evey miner on the blockchain can vote if they would like changes to the blockchain. This will give more power to the people who are currently running the blockchain.

# Motivation
[motivation]: #motivation

  Allow more people to have a more democratised voting to everyone on the blockchain. And let more people particpate have the ablitiy to voice there opinion. 

# Stakeholders
[stakeholders]: #stakeholders

* People with miners and runing the network. The small people are going to have the vote. Fulfilling the networks goal to be the people's network.

* Everyone who is actively supporting the network can have a say, unlike today where there is few amount of people who can make a change.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

- This hip will propose a few changes to the blockchain. The way I propose the block chain to move is making a new token called voting. Which can be generated when a new type of transaction of a change is proposed, all the miners on the network will get a token awared to them. 
- The transaction done by the miner will have to inclued the proposal, and a github link to the the hip. And then they will burn 10 hnt to send the transaction. Then the blockchain will then make 2 wallets that can only accept the voting tokens, and distrubute 1 voting token per miner to all the wallets. 
  
- One wallet will be for the chain, and another wallet against the proposed change. 

- Then at the end of the time limit there will either be a consesous to move forward, or there will not be. I propose the limit to be 65% This is not a simple majority but it is not extreamly high to make changes imposible. 

-`voting` new token for voting
-`votingBurn` New transcation to burn hnt to peose the transcation
-`votingTransactoin` New transcation to vote for or against a hip

# Drawbacks
[drawbacks]: #drawbacks

- People with more helium tokens then miners will lose out. They can't vote as much. They will have less of a stake then someone who has more miners.
- Lora device makers may feel that they have no power. This is true, however currently anyone can get a few hundred people to join the dewi's zoom call and flood the discord and make changes they want. However, if the miners are not happy with the network there will be less coverage overall and people leaving the ecosytem.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

Currently if you really want to change something you have to make a hip, get a dewi call approval and get the helium team on board. It is slow, and it allows a minority to control the direction of the network.

# Unresolved Questions
[unresolved]: #unresolved-questions

- How will making a change actually work. Do you make the code changes before, or will it have to be done at a later date. And if the code changes were not done if it was a later date who is reposnsible for it.

# Deployment Impact
[deployment-impact]: #deployment-impact

Describe how this design will be deployed and any potential imapact it may have on
current users of this project.

- Current opertators will get more ablitiy to vote on the chain and feel like they have a better stake.

- There will be a need to educate people on how a hip works and how it could help them.

- This should be able to added in to the blockchain pretty easily with the sidechain functionality. Also as it is a new token, it can only be used for a particular vote. You can't take token and vote for another HIP.

# Success Metrics
[success-metrics]: #success-metrics
  
   This will be sucesssful when there is future hips are voted via this.
