# HIP: HIP Improvement Proposal

- Author(s): @mawdegroot
- Start Date: <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: meta
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

# Summary

<!-- One paragraph explanation of the proposal. -->
<!-- Read the content requests in all sections before starting to write any section. -->

<!-- # Motivation -->

<!-- Why are we doing this? What use cases does it support? What problems does it
solve? What is the expected outcome? -->

The current HIP process is often described as unfavorable for a variety of reasons. This HIP seeks to rectify some of the pitfalls of the current HIP process from a technical point of view. In the existing HIP process proposals are often implemented in a way not strictly adhering to the proposal. Another issue in the current HIP process is that proposals are often (unintentionally) vague and ambiguously written. This HIP proposes strict requirements that HIPs must adhere to. The proposed requirements forbid the implementation to differ from the proposal as well as outline the deployment steps, from draft to mainnet deployment to finalized.

# Stakeholders

Everyone.

# Detailed Explanation

<!-- - Introduce and explain new concepts. -->

<!-- - It should be reasonably clear how the proposal would be implemented. -->

<!-- - Provide representative examples that show how this proposal would be commonly used. -->

<!-- - Corner cases should be dissected by example. -->

This HIP will assume the original role of the HIP editor will remain unchanged. The HIP editor will stay responsible for facilitating HIP authors, scheduling votes and keeping the HIP process tidy. The HIP does describe several obligations towards HIP authors that are not present in the HIP 7 description of HIP editors.

## Vote mechanics

### Consensus vote

Consensus votes will use rough consensus as specified by the IEEE as the passing metric and allows the author to set the required vote weight 66% and 83%. Before a consensus vote the HIP must be frozen for at least 7 days. The weighting of votes is explicitly not a part of this proposal and can be adjusted in a separate HIP if required.

## Technical Requirements

A HIP must clearly and unambiguously describe who, what, why, how and when.

### Who

A HIP must clearly specify who will implement the proposal.

### What

A HIP must clearly indicate what change is proposed. The answer to this question must be thorough and will be used to determine if the proposed implementation adequately addresses the problem. The description must be clear for all stakeholders.

### Why

A HIP must clearly indicate why the change is proposed. This shall include at least a description of the problem it intends to solve. Any and all arguments should be factual and have corroberative data to support the authenticity. If the HIP contains verifiable falsehoods it will be closed and a new HIP must be proposed.

### How

A HIP must clearly indicate how the change will be implemented. The implementation details of the HIP must be complete and will be used to measure compliance in the `deployment` state. Any newly introduced variables must be defined and describe their intended effect. Any new behavior must be described including possible corner cases. If an implementation meeting the specification causes consensus failure the specification is not precise enough! The use of RFC2119 keywords to describe mandatory and optional implementation details is highly recommended. Any deployment of code not meeting the specification is forbidden and will not be allowed on mainnet. If the testnet testing brings out flaws in the design the HIP will change to state `in-discussion` and require a new consensus vote.

## When

A HIP must describe a clear time table for implementation and activation. The time table must at minimum describe the time needed between approval and mainnet deployment. The timeline must include the mandatory testing period. The timeline has a maximum duration of 3 months.

## States

### Draft (`draft`)

A HIP starts as draft and can stay draft for a maximum of _3 months_. During the `draft` status discussion about a HIP will take place in #hip-discussion. A HIP will move from status `draft` to status `in-discussion` as soon as the author requests the HIP to be merged (in practice this will mean removing the Draft label from the Pull Request). A HIP in state `in-discussion` can not undergo significant changes so the author should make sure that the HIP crystallizes in the `draft` state.

### In discussion (`in-discussion`)

HIPs in discussion shall have their own discord channel. The `in-discussion` state is meant for gathering support as well as request feedback on _parameters_ of the HIP (this can include the values of tunables but shall _not include significant rewrites_). A HIP can stay in state `in-discussion` for a maximum of 3 months after which it will be closed as `stale`. It is up to the author to ensure that the HIP is finalized enough in state `draft` to move through state `in-discussion` quickly. Significant rewrites are forbidden and will require a new HIP.

If the technical requirements are met the author of the HIP can request a temperature check. The Foundation will schedule the temperature check at the earliest convenience but at most 3 weeks after the request. The temperature check determines whether the stakeholders consider the proposal clear enough to be voted on and _does not determine consensus_. If the temperature check fails the author must wait at least 2 weeks for a new temperature check but _does not extend the 3 month deadline_.

A HIP with a passed temperature check can request a consensus vote. The Foundation will schedule the full consensus vote at the earliest convenience but at most 4 weeks after the request. After the consensus vote is requested the 3 month deadline will be extended until the Foundation schedules the vote. If the vote passes the HIP will change state to `approved`.

### Approved (`approved`)

A HIP in state `approved` must adhere to the time line as specified in the proposal. A single extension of 1 month can be requested via a temperature check vote. If the extended deadline is not met the HIP will be closed. If the author still wants to proceed a new HIP must be opened. After the HIP is deployed to the testnet it changes state to `testing`.

### Testing (`testing`)

ASuccessful testing on a testnet is _required_ before a HIP is allowed to be deployed on mainnet. A successful test will require _at least_ 2 successful activations and deactivations of the feature and a minimum of 7 days of active testing. The success metrics of the proposal will be measured on the testnet to be later compared to the mainnet deployment.  If the testing is successful the HIP can be deployed to the mainnet and the state will change to `deployed`.

### Deployed (`deployed`)

In the 2 months after a HIP is deployed the success metrics of the HIP will be monitored. If the HIP meets the success metrics based on verifiable and quantifiable data the HIP will enter the `final` state. If the HIP does not meet the success metrics specified in the proposal a new vote will held where the stakeholders can either allow the HIP to remain as-is without meeting the success metrics or to revert the proposal.

### Final (`final`)

The Discord channel for the HIP will be archived.

### Stale (`stale`)

The Discord channel for the HIP will be archived.

# Drawbacks

There are several drawbacks to this HIP. One of the drawbacks is that fast-tracking a change through the process will require significant effort from all parties involved. This HIP does not propose a method for fast-tracking immediately required changes and leaves this up to a future HIP.

Another drawback of the proposed HIP process is that it will require significantly more votes. In order to make this system successful the voting process needs to be convenient and cheap. The migration to Solana will allow voting with minimal transaction fees and the voting infrastructure will be built with or without this HIP.

Possibly the biggest drawback is that the way the proposed process forces implementation to strictly adhere to the specifications of the proposal will require significantly more deliberation before proposing a HIP. While less agile this will ensure that future HIPs will be unambiguous, allow for alternative implementations, have strict success criteria and the mandatory testing will ensure that the implementation does not harm the network.

The proposed process will likely have a larger amount of stale and closed HIPs due to the strict boundaries. While daunting at first this will ensure a more streamlined HIP process in the future with less wasted efforts on abandoned or unimplementable HIPs.

<!-- - Why should we *not* do this?
- What problems could occur if we do this? -->

<!-- # Rationale and Alternatives

This is your chance to discuss your proposal in the context of the whole design
space. This is probably the most important section!

- Why is this design the best in the space of possible designs?

- What other designs have been considered and what is the rationale for not
  choosing them?

- What is the impact of not doing this? -->

# Unresolved Questions

<!--
- What parts of the design do you expect to resolve through the HIP process
  before this gets merged?

- What parts of the design do you expect to resolve through the implementation
  of this feature?

- What related issues do you consider out of scope for this HIP that could be
  addressed in the future independently of the solution that comes out of this
  HIP?

- Are there are dependencies, milestones or dates that need need to be met for
  this HIP to succeed? -->

This proposal mentions several durations. These durations would be a clear example of allowable parameter changes in the `in-dicussion` state. These durations are not finalized but serve as a starting point for a constructive discussion.

# Deployment Impact

<!--
Describe how this design will be deployed and any potential impact it may have on
current users of this project.

- How will current users be impacted?

- How will existing documentation/knowlegebase need to be supported?
  Any content to change at <http://docs.helium.com> ?

- Is this backwards compatible?
  Can this HIP be undone?

        - If not, what is the procedure to migrate? -->

If this HIP passes it affects all future HIPs. The docs will have to be changed to describe the new process as well as checklists to guard the process against subjectivity. Such checklists will include a checklist to track the progress of a HIP through the HIP process.

# Success Metrics

<!--
What metrics can be used to measure the success of this design?
Are any new ETL reports needed to measure the success?

- What should we measure to prove a performance increase?

- What should we measure to prove an improvement in stability?

- What should we measure to prove a reduction in complexity?

- What should we measure to prove an acceptance of this by its users? -->

This HIP is considered successful if future HIPs:

1. will have strict and unambiguous specifications
2. have clear success criteria
3. are tested on a testnet before deployment
4. are implemented according to the proposed specifications
5. meet the specified success criteria


