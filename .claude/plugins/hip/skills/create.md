---
name: create
description: Create a new Helium Improvement Proposal. Scaffolds a HIP file from the template with YAML frontmatter, provides category-specific writing guidance, and identifies related existing HIPs. Use when the user wants to write a new HIP, start a proposal, draft an improvement, or says things like "new HIP", "draft a proposal", "write a HIP about...", or "I have an idea for a HIP".
user_invocable: true
---

# HIP Create Skill

You help authors scaffold and draft a new Helium Improvement Proposal. The goal is to produce a complete, well-structured HIP that's ready for community review — not a skeleton with placeholder text.

## Frontmatter format

HIPs use YAML frontmatter (standardized format). The old markdown-list metadata style is deprecated.

```yaml
---
authors:
  - "@githubuser"
start-date: YYYY-MM-DD
category: economic | technical | meta
original-hip-pr:
tracking-issue:
vote-requirements: veHNT Holders | veIOT Holders | veMOBILE Holders
status: Draft
---
```

- `original-hip-pr` and `tracking-issue` — leave empty, maintainer fills these after merge
- `status` — always `Draft` for new submissions

## Steps

### 1. Gather the proposal idea

Ask the user for:
- **What they want to change** — the core idea in a sentence or two
- **Category** — economic, technical, or meta. If unclear, help them classify:
  - *Economic*: reward structures, token mechanics, incentive changes, service provider onboarding, fee changes
  - *Technical*: protocol upgrades, network architecture, data transfer mechanisms, oracle changes
  - *Meta*: governance process changes, HIP process itself
- **Author GitHub username(s)**
- **Vote requirement** — which token holders need to vote:
  - *veHNT Holders*: network-wide changes affecting all of Helium
  - *veIOT Holders*: changes specific to the IoT subnetwork
  - *veMOBILE Holders*: changes specific to the Mobile subnetwork
  - Multiple can apply (e.g., "veHNT Holders, veMOBILE Holders")

If the user already has a draft or detailed description, work from that rather than asking redundant questions.

### 2. Search for related HIPs

Before writing, search the repository for HIPs that overlap with or relate to the proposal:

- Search filenames and content for keywords from the user's idea
- Check the README.md index table for HIPs in the same category
- Look for HIPs that this proposal would amend, extend, or replace

Report what you find:
- "This relates to HIP-53 (Mobile subDAO) and HIP-77 (Mobile PoC). You should reference these."
- "HIP-110 proposed something similar but was closed — worth addressing why this approach differs."
- "No existing HIPs cover this area."

If the proposal directly amends existing HIPs, those **must** be referenced in the new HIP.

### 3. Scaffold the file

**Filename**: Use `0000-descriptive-title.md` (zeroes as placeholder, matching the template convention). The HIP number is assigned by a maintainer before merge — the author never picks their own number. The maintainer renames the file (e.g., `0000-demand-sampling.md` → `0145-demand-sampling.md`).

Create the file in the repository root (where all other HIPs live).

**File structure**:

```markdown
---
authors:
  - "@{username}"
start-date: {today YYYY-MM-DD}
category: {category}
original-hip-pr:
tracking-issue:
vote-requirements: {vote requirement}
status: Draft
---

# {Proposal Title}

## Summary

{One paragraph — what this proposal does and why, understandable to someone unfamiliar with the details.}

## Motivation

{Why are we doing this? What problem exists today? What use cases does it support? What is the expected outcome?}

## Stakeholders

{Who is affected? Be specific — name the groups. How is feedback being solicited?}

## Detailed Explanation

{The meat of the proposal. See category-specific guidance below.}

## Drawbacks

{Why should we NOT do this? What are the trade-offs?}

## Rationale and Alternatives

{Why is this the best design? What alternatives were considered? What happens if we don't do this?}

## Unresolved Questions

{What needs to be resolved before merge? During implementation? What's out of scope?}

## Deployment Impact

{How will this be deployed? Impact on current users? Backwards compatible? Migration path?}

## Success Metrics

{How do we measure success? What specific metrics, thresholds, or timelines?}
```

### Link reference format

When citing other HIPs, use reference-style links with relative paths:

- In the text: `[HIP-53][hip-53]`
- At the bottom of the file: `[hip-53]: ./0053-mobile-dao.md`

Do NOT use full GitHub URLs (`https://github.com/helium/HIP/blob/main/...`) — use `./NNNN-slug.md` relative paths. Every reference used in the text must have a definition at the bottom, and every definition must be used in the text (no orphans).

### 4. Write the content with the user

Work through each section with the user. Don't leave template prompts — every section should have real content or an explicit "None" with justification.

Apply the category-specific guidance below to push for substance.

#### Economic HIPs — writing guidance

Economic proposals are the most common HIP category and the most likely to be underspecified. Push hard on these:

**Detailed Explanation must include:**
- Concrete numbers: percentages, token amounts, allocation tables
- Before/after comparisons showing what changes
- If modifying reward structures: a table showing current allocation vs. proposed allocation
- If touching treasury or fee mechanics: worked examples with realistic numbers
- Reference every HIP being amended or repealed by number

**Example of good specificity** (from HIP-148):
> "The allocation of MOBILE Mapping rewards changes from 20% to 10% of the MOBILE Mapping Pool" with a full table showing all pool allocations before and after.

**Red flags to push back on:**
- "Rewards will be adjusted" — adjusted how? By how much?
- "A portion of tokens" — what portion?
- "Stakeholders will benefit" — quantify the benefit

**Rationale section**: Must genuinely engage with at least one alternative approach. "There are no alternatives" is never true for economic proposals.

**Success Metrics**: Must reference on-chain or measurable data. Good: "MOBILE data transfer exceeds X TB/month within 6 months." Bad: "Network growth increases."

#### Technical HIPs — writing guidance

**Detailed Explanation must include:**
- How the change interacts with existing protocol components
- Implementation approach (phases, milestones if complex)
- Any new data structures, API changes, or protocol messages
- Edge cases and how they're handled

**Deployment Impact is critical** — technical changes need:
- Migration path for existing nodes/infrastructure
- Backwards compatibility analysis
- Rollback plan if something goes wrong

**Success Metrics**: Should include performance benchmarks, latency targets, or throughput goals where applicable.

#### Meta HIPs — writing guidance

Meta proposals are typically lighter but need process clarity:
- Who is responsible for what?
- What are the decision criteria?
- How is compliance/adherence measured?
- What changes in the day-to-day for affected parties?

### 5. Quality check before finishing

Before presenting the final HIP, verify:

- [ ] Summary is one paragraph, self-contained
- [ ] Motivation states the problem, not just the solution
- [ ] Stakeholders names specific groups (not "the community")
- [ ] Detailed Explanation has concrete specifics appropriate to category
- [ ] Drawbacks section is honest (not empty, not "there are no drawbacks")
- [ ] Rationale discusses at least one genuine alternative
- [ ] All referenced HIPs exist and are cited correctly (use `[HIP-NN][hip-nn]` reference links with definitions at the bottom of the file using relative paths: `[hip-53]: ./0053-mobile-dao.md`)
- [ ] Every link definition at the bottom is actually used in the text (no orphaned definitions)
- [ ] Every `[hip-nn]` reference in the text has a matching definition at the bottom
- [ ] Success Metrics are measurable
- [ ] No template placeholder text remains
- [ ] No `<!-- comments -->` with template instructions remain

### 6. Git workflow

After the user confirms the content:

- Create branch: `git checkout -b hip/{title-slug} main`
- Commit the new file
- Push with `-u` flag
- Tell the user to open the PR themselves (or open it with `gh pr create` if they ask)

PR title format: `HIP: {Proposal Title}`

PR body:
```
## Summary
{The summary section from the HIP}

**Category**: {category}
**Vote requirement**: {vote requirement}
```

**Important**: The author does NOT assign a HIP number. The file uses `0000-` as a placeholder. A maintainer assigns the real number and renames the file (e.g., `0000-demand-sampling.md` → `0145-demand-sampling.md`) before merging the PR into main.

### 7. Report

Tell the user:
- File path created
- Related HIPs identified
- Next steps: open PR (if not already), community will discuss on the PR and associated GitHub issue, maintainer assigns HIP number
