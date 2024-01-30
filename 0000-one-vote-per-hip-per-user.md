# One Vote Per HIP, Per User

- Author(s): @jeffryevans
- Start Date: 2024-01-28
- Category: governance
- Original HIP PR: 
- Tracking Issue: 

## Summary

Currently, voters are able to deceive the community by voting the opposite of what they intend to vote, then changing their vote just prior to when the voting period ends. This is deceptive and should be prohibited. This HIP will allow only one vote per HIP, per user (in this case, a user is defined as a wallet address), nullifying the ability to deceive the community during the voting period of each HIP.

## Motivation

After observing and participating in the voting of HIP 101, it became apparent that one or more voters "flipped" their votes from "against" to "for" this particular HIP, to the tune of multiple billions of votes.

![Screenshot 2024-01-29 141444](https://github.com/helium/HIP/assets/11046593/f47e3104-7bef-4734-be5d-db31e5204685)

What we have is a some 15+ billion vote swing from no to yes on this vote, during the last moments of the vote. It almost flipped the vote to passing.

## Stakeholders

Everyone that chooses to vote on HIP(s).

## Drawbacks

@waveform06 says there's a drawback in people not being able to change their minds - I disagree. In what political election are people allowed to change their mind after they have voted? None that I know of, at least not in the US. It's a bad thing to allow people to change their minds after they have cast their vote. If there is a legitimate reason to change one's mind (e.g. something with the HIP changes during voting, which I hope would never happen), then all voting should stop and the HIP should be resubmitted for a new vote. This HIP will discourage people from casting a vote prior to understanding the HIP, which is a strength, not a drawback.

@waveform06 says there's a drawback in people waiting until the last minute to cast their vote - I disagree. When the voting time is open - we're on the block chain, which means people are able to see the vote tally in near real time, which really is not good for voting, but it's the technology we have, thus waiting until the last minute is a viable strategy to try and protect one's vote from being seen and people pivoting against it. There's no drawback there.

Bottom line - there are no drawbacks to this HIP, though I'm open to the community raising a drawback I haven't thought of.

## Rationale and Alternatives

The ability to change one's vote all the way up to the closing date/time of the vote allows for potential manipulation. This potential vote manipulation is unethical, inexcusable, and must be prevented on all future HIPs. This HIP will ensure that everyone's vote is truthful, as they will only have one chance to vote. All other voting privileges, such as locking up more tokens, etc. will continue as-is.
