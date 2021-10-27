# Community Entry Gate

- Author(s): Rob#8633
- Start Date: 2021-10-27
- Category: Community
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary
[summary]: #summary

The Helium community has become overrun with inexperienced members who have not taken the time to
do even the most basic of research into the network, the technology, and the reward token. This has
had a detrimental effect on the community and creates a poor experience for all. This HIP proposes
a solution to help educate prospective community members and provide an entry gate to the Discord server.

# Motivation
[motivation]: #motivation

Many community members are becoming fed up of answering the same questions and having the community as a
brothel for opportunists prostituting out their consultancy, 50 gazillion dBi antennas and other nonsense
to new members who do not have a decent understanding. Through education of new members and requiring a basic
entry test we can increase the quality of the community, reduce frustration for existing members and prevent
new members falling victims of opportunists taking advantage of their situation.

# Stakeholders
[stakeholders]: #stakeholders
 
* Who is affected by this HIP? - All Helium Discord Community Members.
* How are we soliciting feedback on this HIP from these stakeholders? - Discord channel for discussion, HIP
  only affects the Discord community.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

The HIP will be implemented by performing the following;

- Disable invite option in Discord server.
- Create a new single page app at https://community.helium.com which presents educational materials to
  new community members in a wizard like format including;
  + What is Helium? - introduces the IoT network and use cases
  + How does Helium work? - introduces blockchain, hotspots, validators, placement basics, rewards etc...
  + Community Rules - presents community rules
  + Scam Awareness - presents tips to avoid being scammed by others on Discord, e.g. suggesting to read
    the official docs for free rather than opting in to 30 min $200 Helium webinars being offered by 
    unscrupulous community members.
- Following presentation of the materials, or during interstitials during the materials, the user will
  be presented 5 random multiple choice questions based on the information provided.
- If the user answers all 5 questions satisfactorily then they will be invited to the Helium Discord server
  by a serverside service account.
- If the user isn't successful they will be invited to review the materials again and will be presented
  with 5 new questions.

There is no limit to the amount of attempts a user may have to enter the community. Materials should not be
as mundane as documentation and could be provided by video content to ensure easy consumption. The aim of this
entry gate is not to reduce the number of new members but to help educate new members at a high level about the
project, increase coverage of the rules, and accelerate new members to be active members of the community.
The process should be supportive and nurturing and not a barrier to entry.

# Drawbacks
[drawbacks]: #drawbacks

- May reduce number of new community members due to additional effort required to join.

# Rationale and Alternatives
[alternatives]: #rationale-and-alternatives

- Why is this design the best in the space of possible designs?
  + 100% Self-service & automated
  + Largely accessible
  

- What other designs have been considered and what is the rationale for not
  choosing them?
  + Restricting invite capability to existing members who have reached some level of cadence
    * Difficult to manage in an automated way 
    * Trusts existing community members to make reasonable invites
    * Makes it impossible to join unless you know an existing community member


- What is the impact of not doing this?
  + Continued rising tensions in the community between tenured members and new members due to lack of sympathy
    for new member's lack of experience. (at least with this system new members should have a basic understanding)
  + Continued poor experience for new members due to attitude of tenured members towards them due to their lack of
    knowledge.
  + Continued poor experience for new members being approached by unscrupulous members to buy expensive and
    exploitative consultation services most of which are sharing information freely available within the Helium docs.

# Deployment Impact
[deployment-impact]: #deployment-impact

- How will current users be impacted? - No impact to current community members, only affects new community members.
  New members will be required to review Helium community educational materials and pass basic test before receiving
  an invite to the Discord.

- How will existing documentation/knowlegebase need to be supported? - The community sign up wizard will be self documenting with an intuitive design.

- Is this backwards compatible? - Not Applicable

# Success Metrics
[success-metrics]: #success-metrics

- What should we measure to prove a performance increase? - Not Applicable

- What should we measure to prove an improvement in stability? - Not Applicable

- What should we measure to prove a reduction in complexity? - Not Applicable

- What should we measure to prove an acceptance of this by it's users? - Community vibe should be observed for less tension between tenured and new members.
