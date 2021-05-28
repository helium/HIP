## HIP31: Governance by token burn

- Authors: [@tjmcc](Tushar#5143), Shayon Sengupta
- Start Date: November 14, 2020
- Category: Governance
- Original HIP PR: https://github.com/helium/HIP/pull/182
- Tracking Issue: TBD
- Status: In Discussion

# Summary
[summary]: #summary

This proposal suggests a governance mechanism for on chain voting for chain variables.

# Motivation
[motivation]: #motivation

On chain governance helps make governance decisions transparent and permissionless to influence. It is intended to give control of the protocol to the community.

Traditionally, on chain governance has meant one token one vote. This is vulnerable to people borrowing tokens to vote with them. With the low voter turnout seen in most other protocols, this attack vector on governance is fairly easy to execute.

One token one vote also concentrates voting power in the hands of whales and early miners. This can lead to smaller holders becoming disenfranchised and disengaged from governance.

We propose a new governance system where voters must burn their HNT in order to vote. This system helps encourage consensus building because contentious votes are more expensive than landslides. It also imposes a significant cost on any large holder which tries to control governance, leading to less oligarchic governance outcomes.

# Stakeholders
[stakeholders]: #stakeholders

All Helium Network stakeholders are affected by this HIP.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

Anyone can bring a chain var update to a vote by posting a bond of 1% of staked HNT. This will create 2 burn addresses, one to accept the HIP and one to reject it. The voting period will be 1,008 epochs (21 days). During this time anyone can send staked HNT to either address. Only staked HNT is eligible to vote.

At the end of the voting period the protocol determines the winner by seeing which address received the most tokens. Addresses which voted for the winner get a refund of their winning margin. For example if there were 200k votes for yes and 50k votes for no, the voters for yes would get 75% (150k) of their tokens back distributed pro rata amongst them.

Votes earlier in the process get higher weight to incentivize people to vote early rather than wait for the last minute. For the first three days of voting, each HNT will have equal voting weight (so as to not immediately provide an advantage to the proposer of the vote), but the decay in voting power begins after this point. The “decay” of vote strength should be a chain variable. The initially proposed value of this chain variable is 3.33% per day – meaning that 1 HNT deposited on the third day of voting counts as 1 HNT but if it was deposited on the fourth day of voting it counts at 0.967 HNT and the other 0.033 HNT is burned.

![](https://lh4.googleusercontent.com/yfRQ1Id0sK3LjbWAjZ-FDVTA6-j-KorzIqbOfOkOC3KfTGbUQRARrhxQhHvNc1OwzrHVfq9-GovKRm-TBImlTnG60tRejXfZ5T3vGys0SEMzrIRjFnG3X93YEEbGIZeD8oSwM3E)  
  
However, the current implementation still does not address the issue of having an asymmetric cost ascribed to expressing preferences as in the voting process. There is no incentive to vote without some increased certainty that one’s vote is “pivotal” to the outcome, since voting is strictly negative EV in payoff terms assuming there is nonzero participation throughout the vote. Coalitions are difficult for low token holders to participate in, given the risk of losing their holdings and not having the vote land in their favour. As a solution, HNT submitted for voting ‘for’ or ‘against’ a specific proposal will be sent to state channels such that the contract only deposits the HNT to the respective address if a minimum is hit (i.e. total HNT ‘against’ would be 1.5x votes ‘for’ before some time t_n &lt; T where T is the end of the voting period, and n is the is the current day or epoch prior to that point)

![](https://lh6.googleusercontent.com/YBrpA3YrUAyG_apxOi3D1EjVr3GALdKPEuABAVuYjko9fohciEmvjDMhFWypUcGe3jHuBoaD5bYItfrvlazQ8NJB1YZh0xDJkfjxwpa0ap464kL3I8xHnWEv_a_HOjeE-X15Ye8)  
  
For any vote in the opposite direction of the current winning side, EV increases if there is a significant winning margin after one’s vote is cast. If ‘against’ votes are ever roughly equal to ‘for’ votes, then both sides burn their balances without adding a significant edge since it is trivial for one side to marginally vote more in the next move. There will be some specific incremental amount that acts as a kind of dominated strategy, based on prior data around voting that can be input to the mixed strategy equation. In the diagram below we have considered a minimum 100% margin i.e. the cost to shift the vote is always 100% more than the last staked amount.

The state channel should not be capped at any amount prior to deposit, since EV for voting against the winning direction increases with a significant winning margin not only in outcome terms (deciding the outcome of the actual vote), but also payoff terms (the higher the winning margin, the higher the portion of staked HNT is returned to the voter)

The initial bond amount must be fixed, such that no high balance HNT holder can create a vote with a very high ‘amount to beat’, and the cost of putting a contentious proposal to vote is the same for each participant in the network.

The benefits of this proposal are:

- Expensive to vote so you only vote if you really care
- Having a contentious vote is extremely expensive so it is worth building consensus on a proposal so others don’t block you
- Voting creates deflationary pressure on HNT supply for all network participants
- Further increases incentives for staking HNT
- Naturally decentralizes over time. Right now there are only a handful of people who care enough about the system to burn a bunch of money to have a voice in governance. As the system gets more important to more stakeholders, more people will care enough to vote despite the cost
- State channels minimize expected loss of participation by turning this voting exercise into a mixed strategy game with linear payoffs, and also prevent outcomes where an outcome is decided without a significant margin of victory i.e. no side can win by submitting 1 HNT more than the other side
- Much less oligarchic than 1 token 1 vote like tezos or compound. 1 token 1 vote which just means early whales control governance forever. In governance by burn, if whales try to control governance against others they start losing tokens and stop being whales.

# Drawbacks
[drawbacks]: #drawbacks

1. Participants necessarily lose tokens to express preferences in the network
2. Contentious votes are very expensive to propose and participate in
    - For someone to vote against a proposal, their expectation of the event in which the proposal passes must be less than cost of voting, and they must have conviction that their votes will drive the proposal in their favour
    - Cost of voting decreases with margin of victory. Addresses with high balances have lower marginal utility for each incremental HNT held, so voting remains less costly
3. We assume all voters prioritize winning the proposal over their HNT staked in voting. This may limit the development of the protocol as minor changes may be contentious, and therefore expensive and unlikely to be proposed.
4. It is difficult to calculate the payoff for participation in any given vote.

# Rationale
[rationale]: #rationale

1. Weighted voting attaches a tax toward proposing and participating in protocol changes, and this tax increases in how contentious the specific proposal is
2. The token burn simultaneously adds deflationary pressure to HNT, distributing the tax paid by proposal participants to the broader community
3. Time-weighted votes allow for fairer markets in that they disincentivize last minute bids
4. State channels allow for less wasteful coalition formation, allowing all network participants to be pivotal to a given vote, and not just high balance HNT holders

# Alternatives
[alternatives]: #alternatives

1. Shape of bonding curve for time-weighted vote
    - Quadratic Decay: 1 - kT^2
    - ![quadratic decay](https://lh5.googleusercontent.com/LnJ4oI9bXq-3YXeTr092HEKn64c9fgzrAwrpVgIyjkDdDmttllHqSV-t1yRxJCAwdhWRuAeb_Jkw0TPC2nmJrhDX_HgyO7SjViOQnMqLpDXRkE9I-VqKbcPMYD7ier9A0x06Ltc)  
  
2. Log Decay: max(1, 1 - log(kT))
    - Considerations: Ideally, the curve should be flat for a very small portion of the initial stage, as any dropoff after the vote is proposed immediately disadvantages the opposition

3. Burn/Return amounts (P are votes in wining address, Q are votes in losing address)
    1. Linear (current)
        1. Burn: 2Q
        2. Return: P - Q pro rata ownership
    2. Dollar Auction
        1. Burn: Q
        2. Return: P pro rata ownership
        - Each side is incentivized to outbid the other, may be too destructive

4. Quadratic or Linear Coefficient (alternatives to state channels)
    1. Burn: 2(sqrt Q) or 2/n \* Q (n is number of unique addresses participating)
    2. Return: P - sqrt Q and Q - sqrt Q, P - (2/n)\*Q and Q - (2/n)\*Q
        - Makes votes slightly less expensive to participate in, and increases the payoff for voting against proposals

5. What are the conditions for proposing a vote
    1. Minimum bond amount
        1. 1% of staked HNT may be too high
    2. Minimum engagement on HIP forums
        1. Should there be a threshold amount of prior discussion before a vote is proposed, as this ensures clear discussion of the ramifications of approving or rejecting the change
6. What can we assume about voters
    1. What percentage of balance can we expect rational voters to dedicate toward voting? How should this inform the minimum bond amount?
7. Alternatives to burning/minting
    1. Curve-like vote locking (voting escrow, less price impact on contentious votes)

# Deployment Impact
[deployment-impact]: #deployment-impact

TBD
