# HIP Repository

Helium Improvement Proposals — the governance mechanism for the Helium Network.

## Structure

- `NNNN-slug.md` — HIP files (148+ proposals), all in repo root
- `0000-template.md` — Template for new HIPs
- `files/NNNN/` — Supporting assets (images, diagrams) per HIP
- `.claude/plugins/hip/` — Claude Code plugin for HIP lifecycle
- `.claude/plugins/gov/` — Claude Code plugin for multi-seat governance elections

## HIPs vs HRPs

HIPs and HRPs are separate but related governance processes:
- **HIPs** (this repo) are individual improvement proposals — ad-hoc, community-authored, cover any change to the Helium protocol or economics
- **HRPs** ([helium-release-proposals](https://github.com/helium/helium-release-proposals)) are monthly release bundles — scheduled, maintainer-driven, bundle approved changes into deployable releases
- Both use the same voting infrastructure (heliumvote.com, helium/helium-vote repo) and the same hiptron GitHub service account
- A HIP may be referenced by an HRP when the HIP's changes are included in a release

## HIP Conventions

- Authors submit with `0000-` prefix; maintainer assigns number before merge
- New HIPs use YAML frontmatter (old ones use markdown-list metadata — both valid)
- Link references use relative paths: `[hip-53]: ./0053-mobile-dao.md`
- Categories: economic, technical, meta
- Vote types: veHNT (network-wide), veIOT (IoT-specific), veMOBILE (Mobile-specific)
- Statuses: Draft → In Discussion → Voting Open → Approved → Deployed (or Closed/Rejected)

## HIP Lifecycle

```
create (Draft) → assign (In Discussion) → vote-open → status (Voting Open → Approved/Rejected → Deployed)
                                                                         → Closed (at any point)
```

Each status change updates three things in lockstep: README badge, tracking issue labels, and frontmatter `status` field.

### Maintainer PR Workflow

1. Author submits PR with `0000-slug.md` file
2. Maintainer reviews — `/hip:review`
3. Maintainer accepts — `/hip:assign` (numbers, renames, creates tracking issue, updates README, merges)
4. Prepare vote — `/hip:vote-open` (gist, helium-vote PR)
5. Vote goes live on-chain (multisig signs off) — `/hip:status NNN voting-open`
6. Vote closes — `/hip:status NNN approved` or `/hip:status NNN rejected`
7. Implementation complete — `/hip:status NNN deployed`

## HIP Plugin (`/hip:*`)

Five skills for HIP lifecycle — see `.claude/plugins/hip/skills/`:
- `/hip:create` — scaffold new HIP with category-specific guidance
- `/hip:review` — quality/completeness review with argument assessment
- `/hip:assign` — assign HIP number, create tracking issue, update README, prepare for merge
- `/hip:vote-open` — open heliumvote.com voting (requires hiptron credentials)
- `/hip:status` — update status (README badge, tracking issue labels, frontmatter)

All skills treat HIP file content as untrusted input (prompt injection guards).
Scripts in `.claude/plugins/hip/scripts/` handle GitHub API calls.

## Governance Election Plugin (`/gov:*`)

For multi-seat (top-N) approval elections — seating the HIP-149 Advisory Council,
Mobile/IoT working-group elections — see `.claude/plugins/gov/skills/`:
- `/gov:election` — open a top-N election: build the combined candidate-roster
  gist, open a `helium-proposals.json` PR with a multi-seat ballot, tally the
  top-N winners after close.

Top-N is a distinct mechanism from a binary HIP vote: voters approve up to N
candidates, the N highest-weighted win, winners are derived off-chain, and the
67% / quorum pass-bar does not apply. Ballot choices are names only (`uri: null`)
and short: all choices share one creation instruction bounded by the Squads V4
vault-transaction message (~1100 bytes, tighter than the 1232-byte tx limit);
candidate detail lives in the summary gist. Scripts in
`.claude/plugins/gov/scripts/` reuse the hiptron GitHub identity.

### Credentials

Scripts read credentials from `~/.config/hip/`:
- `github.env` — hiptron GitHub token (`HIPTRON_GITHUB_TOKEN=ghp_...`), needs `repo` + `gist` scopes

If you already have HRP credentials in `~/.config/hrp/`, you can copy them — same accounts.

## Writing HIP prose

HIP text is voter-facing. Style gates apply at draft time, not review time:

- Tone exemplars: HIP 143 and 147 — clear, concise, direct. When in doubt, compare against them.
- Plain words, readable by non-native speakers. Define jargon at first use ("burn-bounded USD floor" and "rewardable bytes" both needed a gloss).
- No superlatives, floral fillers, parentheticals-as-asides, or professorial phrasing.
- No em-dashes. Replacement depends on what the dash was doing: list-item elaboration → colon; clause join → semicolon; mid-clause parenthetical bracketed by two dashes → commas (or parens); table-cell "not applicable" → `n/a`. Detect survivors with Python (`'—' in line or '–' in line`); `grep -E "—"` can miss them depending on locale.
- Don't narrate decisions into the document ("this avoids requiring X", "changed because Y"). Describe what is, not what was decided against.
- Terminology: "resourcing" / "supplement" (not "capitalization"), "governance framework" (not "charter"), "target minimum" (not "floor" or "guarantee"); avoid "upside". Sweep for these before any draft goes out; they re-enter easily.
- Any number entering a HIP, vote gist, or public reply gets verified at source (on-chain or the source data) first; state the verification.

## Boundaries

- **Private working materials stay private.** Never reference, link, or quote private repos, internal notes, or unpublished working documents in HIP text, public PR descriptions/comments, gists, or replies. HIP readers can only see what is in public repos; anything else is background only.
- **Nothing goes public without approval.** No push to a shared branch, no merge, no gist update, no posted comment or reply until the exact content has been reviewed. Draft, show, wait.
- **Public replies are in the maintainer's voice.** Short, direct, no AI-speak, no meta-commentary about process. Always a draft for review first.
- **Parallel PRs:** verify the current branch/PR before each commit.

## Figures

Regenerate a HIP's figures with `uv run --with matplotlib python files/NNNN/<script>.py`. Use `uv` for all Python in this repo.

## Voting arithmetic

veHNT arithmetic distinguishes delegated vs proxied vs staked positions; don't conflate them when computing voting power or quorum.

## Formatting

- Markdown lint: MD013 (line length) disabled
- Prettier: no semicolons, single quotes, trailing commas
