
# HIP Voting

- Author(s): maco2035
- Start Date: 2020-01-26
- Category: Economic, Technical, & Meta
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

  This proposal is used for helping gain consensus on the blockchain for HIPs. Currently it is done by a few people who can say I want to do this. As observed from the DEWI calls it is mainly the helium team, and less then 50 others. With this, evey miner on the blockchain can vote if they would like changes to the blockchain. This will give more power to the people who are currently running the blockchain and underpining the network.

# Motivation
[motivation]: #motivation

  Allow more people to have a more democratised voting to everyone on the blockchain. And let more people particpate have the ablitiy to voice there opinion. 

# Stakeholders
[stakeholders]: #stakeholders

* People with miners and runing the network. The small people are going to have the vote. Fulfilling the networks goal to be the people's network.

* Everyone who is actively supporting the network can have a say, unlike today where there is few amount of people who can make a change.

* DEWI, job is not paid, and there is going to be more HIP's where they are going to have to deal with.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation
- There will be some changes need to the blockchain

- The first thing will be a new type of transcation called `votingProposal`. It will include the propsed changes to the blockchain (in a markdown editor format & git), time to vote (a minimum of 2 weeks which is 20k blocks), and time to implement the changes to the codebase (between 0 and 250k blocks). With this being a new type of transaction, there will be a cost assoiated with this. I propose it to be 10 HNT to be burned to prevent the network from being spamed with constant new transcation. This will be a permenant burn. No new HNT can replace this.

- To vote there will be a new type of token needed called `votingNetworkToken` also that can be called `VNT`. Once a transcation of `votingProposal` is posted the conseous group will genrate 2 new wallets. One of the wallets will be for implenting the change, and one against. And then they will distrbute tokens 1 per hotspot and it goes to the hotspots wallet. The tokens can be given to others to vote on your behalf called `votingTokenTransfer`. But for a wallet to transfer to another wallet it will cost the same as a normal HNT transaction of 35,000 data credits. 

- At the end of the voting period the mesure will only pass if there is 60% of the voting tokens are in favor of the changes. This will be easily auditable from the blockchain to see how many `VNT` are for and against. 

- After that there be a special token generator called `changeToken`. This token will be awarded to the person who made the proposal which has passed to the network, and now can submit the code they would like to change for the blockchain with the token, number of block need to vote (a minium 10,000 blocks),and number of blocks in the future this change will go in effect after the vote (between 1,000 and 20,000). This will triger another voting round. This token must be used from the time it was generated and till the time to implent in the first `votingProposal`. This token will contain the nessery changes to the codebase for the nodes.

- The consenous group will again distrabute a `votingNetworkToken` and two new addresses for to depostit the tokens. This is to verify that the network can support these changes. And everyone can audit them. This can also be transfered from one wallet to another wallet to allow for vote by proxy. This will allow everyone transpancy on the changes to the blockchain. And after the voting period

- Then the proposed blockchain changes can be added to the network after there was another 60% of the voting tokens were in favor of the changes of the blockchain and it's code. The change will be made to the time after the vote.

-`votingNetworkToken` New token for voting  on the network

-`votingBurn` New transcation to burn hnt to propose the transcation. This cost 10 HNT, and contains the info about the new hip.

-`votingTransaction` New transcation to vote for or against a hip. This is a free tranasctions that sends it to one of the 2 wallets generated for it.

-`votingTokenTransfer` New transcation to transfer your voting token from one wallet to another. This costs 35,000 DC's

- `changeToken` New token that has a one time use for editing the codebase, however still needs a vote to verify the changes.

# Drawbacks
[drawbacks]: #drawbacks

- People with more helium tokens then miners will lose out. They can't vote as much. They will have less of a stake then someone who has more miners.

- Lora device makers may feel that they have no power. This is true, however currently anyone can get a few hundred people to join the dewi's zoom call and flood the discord and make changes they want. However, if the miners are not happy with the network there will be less coverage overall and people leaving the ecosytem.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

- Currently if you really want to change something you have to make a hip, get a dewi call approval and get the helium team on board. It is slow, and it allows a minority to control the direction of the network.

- You can keep the status quo and it would be fine as dewi is a non-profit, but it still a small group, and not full democratic system.

- One miner can only get a vote. This is one of the only real particpatents in the network. The other groups use the network on top of this, they are important. But I don't think the miner network will disregrad the other aspects of the network. This really gives the people who run the network the power, because without the network users there is no reason to run the network. I am certain the miners will not cut the arm that feeds them.


# Unresolved Questions
[unresolved]: #unresolved-questions

- How will making a change actually work. Do you make the code changes before, or will it have to be done at a later date. And if the code changes were not done if it was a later date who is reposnsible for it.

# Deployment Impact
[deployment-impact]: #deployment-impact

Describe how this design will be deployed and any potential imapact it may have on
current users of this project.

- Current opertators will get more ablitiy to vote on the chain and feel like they have a better stake.

- There will be a need to educate people on how a hip works and how it could help them.

- This should be able to added in to the blockchain pretty easily with the sidechain functionality.

# Success Metrics
[success-metrics]: #success-metrics
  
   This will be sucesssful when there is future hips are voted via this.
