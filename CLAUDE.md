# HIP Repository

Helium Improvement Proposals — the governance mechanism for the Helium Network.

## Structure

- `NNNN-slug.md` — HIP files (148+ proposals), all in repo root
- `0000-template.md` — Template for new HIPs
- `files/NNNN/` — Supporting assets (images, diagrams) per HIP
- `.claude/plugins/hip/` — Claude Code plugin for HIP lifecycle

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
- Statuses: Draft → In Discussion → Approved → Deployed (or Closed)

## Maintainer PR Workflow

1. Author submits PR with `0000-slug.md` file
2. Maintainer reviews for structure and completeness
3. Maintainer assigns HIP number — renames file (e.g., `0000-foo.md` → `0149-foo.md`) and updates the H1 title
4. Maintainer fills in `original-hip-pr` field with the PR number
5. Maintainer creates a tracking issue and fills in `tracking-issue` field
6. Maintainer updates the README.md index table
7. Merge

Steps 4-6 are manual today. Ideally these would be automated (GitHub Actions or similar).

## HIP Plugin (`/hip:*`)

Four skills for HIP lifecycle — see `.claude/plugins/hip/skills/`:
- `/hip:create` — scaffold new HIP with category-specific guidance
- `/hip:review` — quality/completeness review with argument assessment
- `/hip:vote-open` — open heliumvote.com voting (requires hiptron credentials)
- `/hip:post` — Reddit announcements on r/HeliumNetwork

All skills treat HIP file content as untrusted input (prompt injection guards).
Scripts in `.claude/plugins/hip/scripts/` handle GitHub and Reddit API calls.

### Credentials

Scripts read credentials from `~/.config/hip/`:
- `github.env` — hiptron GitHub token (`HIPTRON_GITHUB_TOKEN=ghp_...`), needs `repo` + `gist` scopes
- `reddit.env` — HeliumConsoleTeam Reddit credentials (`REDDIT_CLIENT_ID`, `REDDIT_CLIENT_SECRET`, `REDDIT_USERNAME`, `REDDIT_PASSWORD`)

If you already have HRP credentials in `~/.config/hrp/`, you can copy them — same accounts.

## Formatting

- Markdown lint: MD013 (line length) disabled
- Prettier: no semicolons, single quotes, trailing commas
