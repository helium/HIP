#!/bin/bash
# Open a multi-seat (top-N) election proposal PR against helium/helium-vote.
#
# Appends a single approval-election entry to a proposals JSON file: N candidate
# choices (names only, uri:null) with maxChoicesPerVoter = open seats, one
# top-level summary-gist uri, and freeform tags. Fetches the file via the GitHub
# API, appends textually (preserving the file's inline style), creates a branch,
# commits via the GraphQL createCommitOnBranch mutation (signed/Verified), and
# opens the PR — all as hiptron. No local clone needed.
#
# Winners are the N highest-weighted choices, derived off-chain after the vote
# closes (see tally.sh); the on-chain proposal only records per-choice weights.
#
# Usage:
#   election-pr.sh \
#     --name "HIP-149: Advisory Council Election" \
#     --seats 5 \
#     --gist-url RAW_GIST_URL \
#     --tags "advisory-council" \
#     --candidates-file /path/to/candidates.txt \
#     --branch hip-149-council-election \
#     [--reference-url https://github.com/helium/HIP/issues/NNN] \
#     [--file helium-proposals.json] [--repo helium/helium-vote]
#
# --candidates-file: one candidate name per line; blank lines ignored.
#
# Requires: gh CLI, jq, base64, python3

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GH="$SCRIPT_DIR/gh-hiptron.sh"
REPO="helium/helium-vote"
FILE_PATH="helium-proposals.json"

usage() {
  echo "Usage: $0 --name NAME --seats N --gist-url RAW_URL --tags TAGS --candidates-file FILE --branch BRANCH" >&2
  echo "          [--reference-url URL] [--file FILE] [--repo OWNER/REPO]" >&2
  echo "" >&2
  echo "  --name             Proposal title shown on heliumvote.com" >&2
  echo "  --seats            Open seats = maxChoicesPerVoter (integer >= 1)" >&2
  echo "  --gist-url         Raw gist URL of the combined election summary" >&2
  echo "  --tags             Comma-separated freeform tags (e.g. advisory-council)" >&2
  echo "  --candidates-file  File with one candidate name per line" >&2
  echo "  --branch           New branch name (e.g. hip-149-council-election)" >&2
  echo "  --reference-url    Optional link included in the PR body" >&2
  echo "  --file             Proposals file (default: helium-proposals.json)" >&2
  echo "  --repo             Target repo (default: helium/helium-vote)" >&2
  exit 1
}

NAME="" SEATS="" GIST_URL="" TAGS="" CANDIDATES_FILE="" BRANCH="" REFERENCE_URL=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)            NAME="$2"; shift 2 ;;
    --seats)           SEATS="$2"; shift 2 ;;
    --gist-url)        GIST_URL="$2"; shift 2 ;;
    --tags)            TAGS="$2"; shift 2 ;;
    --candidates-file) CANDIDATES_FILE="$2"; shift 2 ;;
    --branch)          BRANCH="$2"; shift 2 ;;
    --reference-url)   REFERENCE_URL="$2"; shift 2 ;;
    --file)            FILE_PATH="$2"; shift 2 ;;
    --repo)            REPO="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$NAME" || -z "$SEATS" || -z "$GIST_URL" || -z "$TAGS" || -z "$CANDIDATES_FILE" || -z "$BRANCH" ]]; then
  usage
fi

# Input validation
if ! [[ "$SEATS" =~ ^[0-9]+$ ]] || [[ "$SEATS" -lt 1 ]]; then
  echo "Error: --seats must be a positive integer (got: $SEATS)" >&2
  exit 1
fi

if ! [[ "$GIST_URL" =~ ^https://gist\.githubusercontent\.com/ ]]; then
  echo "Error: --gist-url must be a raw gist URL (https://gist.githubusercontent.com/...)" >&2
  exit 1
fi

if ! [[ "$BRANCH" =~ ^[A-Za-z0-9._/-]+$ ]]; then
  echo "Error: --branch has invalid characters (got: $BRANCH)" >&2
  exit 1
fi

if [[ ! -f "$CANDIDATES_FILE" ]]; then
  echo "Error: --candidates-file not found: $CANDIDATES_FILE" >&2
  exit 1
fi

if [[ -n "$REFERENCE_URL" ]] && ! [[ "$REFERENCE_URL" =~ ^https:// ]]; then
  echo "Error: --reference-url must be an https URL (got: $REFERENCE_URL)" >&2
  exit 1
fi

# Check dependencies
for cmd in jq base64 python3; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is required but not installed." >&2
    exit 1
  fi
done

# Build the choices block from the candidates file: one { "uri": null, "name": X }
# per non-empty line, jq-escaping each name, joined to match the file's inline
# 6-space indentation.
CHOICES_BLOCK=$(jq -Rrn '
  [inputs | gsub("^\\s+|\\s+$"; "") | select(length > 0)]
  | map("      { \"uri\": null, \"name\": " + (. | @json) + " }")
  | join(",\n")' "$CANDIDATES_FILE")

CAND_COUNT=$(jq -Rrn '[inputs | gsub("^\\s+|\\s+$"; "") | select(length > 0)] | length' "$CANDIDATES_FILE")
if [[ "$CAND_COUNT" -lt 1 ]]; then
  echo "Error: --candidates-file has no candidate names" >&2
  exit 1
fi
if [[ "$CAND_COUNT" -le "$SEATS" ]]; then
  echo "Warning: $CAND_COUNT candidates for $SEATS seats — election is non-competitive." >&2
fi

# Freeform tags -> inline JSON array, space after commas to match file style.
TAGS_JSON=$(printf '%s' "$TAGS" | jq -Rc 'split(",") | map(gsub("^\\s+|\\s+$"; "")) | map(select(length > 0))')
TAGS_JSON=${TAGS_JSON//,/, }

# Check that gh-hiptron.sh works
AUTH_OUTPUT=$("$GH" auth status 2>&1) || {
  echo "Error: hiptron GitHub auth failed:" >&2
  echo "$AUTH_OUTPUT" >&2
  exit 1
}

# Cleanup trap: delete remote branch if we created it but something fails after
BRANCH_CREATED=false
cleanup() {
  if $BRANCH_CREATED; then
    echo "Cleaning up: deleting branch $BRANCH from $REPO..." >&2
    "$GH" api "repos/$REPO/git/refs/heads/$BRANCH" -X DELETE >/dev/null 2>&1 || true
  fi
}
trap cleanup ERR

echo "Fetching $FILE_PATH from $REPO..."

BASE_SHA=$("$GH" api "repos/$REPO/git/ref/heads/main" --jq '.object.sha')
if [[ -z "$BASE_SHA" || "$BASE_SHA" == "null" ]]; then
  echo "Error: Could not resolve HEAD SHA for $REPO main branch." >&2
  exit 1
fi

# Fetch raw directly (Accept: raw); BSD/macOS base64 -d mishandles the
# newline-wrapped base64 the contents API returns.
CURRENT_CONTENT=$("$GH" api "repos/$REPO/contents/$FILE_PATH" -H "Accept: application/vnd.github.raw")

# Build the entry as a text block matching the file's existing inline style
# (2-space entry indent, inline tags, one choice object per line). Appended
# textually rather than via jq re-serialization to keep the diff to one entry.
NAME_JSON=$(jq -cn --arg x "$NAME" '$x')
URI_JSON=$(jq -cn --arg x "$GIST_URL" '$x')
ENTRY_BLOCK="  {
    \"name\": ${NAME_JSON},
    \"uri\": ${URI_JSON},
    \"maxChoicesPerVoter\": ${SEATS},
    \"tags\": ${TAGS_JSON},
    \"choices\": [
${CHOICES_BLOCK}
    ]
  }"

# Append the entry before the array's closing ']', preserving all existing bytes.
UPDATED_CONTENT=$(CUR="$CURRENT_CONTENT" ENTRY="$ENTRY_BLOCK" python3 -c '
import os, sys
cur = os.environ["CUR"]
entry = os.environ["ENTRY"]
trailing_nl = cur.endswith("\n")
body = cur.rstrip()
if not body.endswith("]"):
    raise SystemExit("proposals file does not end with a JSON array")
body = body[:-1].rstrip()  # drop the final "]" -> body now ends at the last entry "}"
sys.stdout.write(body + ",\n" + entry + "\n]" + ("\n" if trailing_nl else ""))
')

# Validate: well-formed JSON, exactly one entry added, and the new entry has the
# expected seat count and choice count.
ORIGINAL_COUNT=$(printf '%s' "$CURRENT_CONTENT" | jq 'length')
UPDATED_COUNT=$(printf '%s' "$UPDATED_CONTENT" | jq 'length')
if [[ "$UPDATED_COUNT" -ne $((ORIGINAL_COUNT + 1)) ]]; then
  echo "Error: Failed to append entry to $FILE_PATH (or produced invalid JSON)" >&2
  exit 1
fi
NEW_CHOICES=$(printf '%s' "$UPDATED_CONTENT" | jq --argjson n "$SEATS" '.[-1] | select(.maxChoicesPerVoter == $n) | .choices | length')
if [[ "$NEW_CHOICES" != "$CAND_COUNT" ]]; then
  echo "Error: appended entry has $NEW_CHOICES choices / wrong seat count (expected $CAND_COUNT candidates, $SEATS seats)" >&2
  exit 1
fi

echo "Appended election entry: $CAND_COUNT candidates, $SEATS seats."

# Pre-flight size check. All choices go into one initialize_proposal_v0 wrapped in
# a Squads V4 vault-transaction message; the create-proposals pipeline rejects it
# ("Failed to package instructions") above ~1100 bytes. This estimate is calibrated
# against the real @sqds/multisig serialization (constant covers the 8 accounts,
# discriminator, vec-length prefixes, compute-budget ixs, and batch wrapper; each
# choice costs ~5 bytes of framing plus its name; the uri and proposal name cost
# ~1 byte/char). It reproduces the measured sizes to the byte in the relevant range.
# Byte lengths (not codepoints) — the Squads limit is in bytes, so non-ASCII
# names/tags/title must count as their UTF-8 byte size.
NAME_LEN=$(printf %s "$NAME" | wc -c | tr -d '[:space:]')
GIST_LEN=$(printf %s "$GIST_URL" | wc -c | tr -d '[:space:]')
TAGS_CHARS=$(printf '%s' "$TAGS_JSON" | jq -r '[.[] | utf8bytelength] | add // 0')
NAME_CHARS=$(jq -Rrn '[inputs | gsub("^\\s+|\\s+$"; "") | select(length > 0) | utf8bytelength] | add // 0' "$CANDIDATES_FILE")
EST=$(( 708 + NAME_LEN + TAGS_CHARS + 5 * CAND_COUNT + NAME_CHARS + GIST_LEN ))
echo "Pre-flight packaged-size estimate: ~${EST} bytes (Squads V4 limit ~1100)."
if [[ "$EST" -gt 1100 ]]; then
  echo "Error: estimated ~${EST} B exceeds the ~1100 B Squads V4 message limit." >&2
  echo "The post-merge create-proposals run would fail with 'Failed to package instructions'." >&2
  echo "Shorten the ballot: plain candidate names (no @handles) and a short gist filename." >&2
  exit 1
elif [[ "$EST" -gt 1075 ]]; then
  echo "Warning: estimated ~${EST} B is within ~25 B of the ~1100 B limit." >&2
  echo "Consider shortening candidate names or the gist filename for more margin." >&2
fi

echo "Creating branch $BRANCH..."

# gh api exits non-zero on 404; test its exit status directly (no pipe race).
if "$GH" api "repos/$REPO/git/ref/heads/$BRANCH" >/dev/null 2>&1; then
  echo "Error: Branch $BRANCH already exists in $REPO." >&2
  echo "Delete it first if you want to retry:" >&2
  echo "  $GH api repos/$REPO/git/refs/heads/$BRANCH -X DELETE" >&2
  exit 1
fi

"$GH" api "repos/$REPO/git/refs" \
  -f "ref=refs/heads/$BRANCH" \
  -f "sha=$BASE_SHA" > /dev/null
BRANCH_CREATED=true

echo "Committing updated $FILE_PATH (signed)..."

# Commit via GraphQL createCommitOnBranch (web-flow-signed / Verified). The REST
# contents API leaves commits unsigned, and helium/helium-vote main requires
# signed commits — an unsigned commit leaves the PR unmergeable.
ENCODED_CONTENT=$(printf '%s' "$UPDATED_CONTENT" | base64 | tr -d '\n')
COMMIT_REQUEST=$(jq -n \
  --arg query 'mutation($input: CreateCommitOnBranchInput!) { createCommitOnBranch(input: $input) { commit { oid } } }' \
  --arg repo "$REPO" \
  --arg branch "$BRANCH" \
  --arg oid "$BASE_SHA" \
  --arg message "Add election proposal: ${NAME}" \
  --arg path "$FILE_PATH" \
  --arg contents "$ENCODED_CONTENT" \
  '{query: $query, variables: {input: {
      branch: {repositoryNameWithOwner: $repo, branchName: $branch},
      expectedHeadOid: $oid,
      message: {headline: $message},
      fileChanges: {additions: [{path: $path, contents: $contents}]}
  }}}')
COMMIT_RESPONSE=$(printf '%s' "$COMMIT_REQUEST" | "$GH" api graphql --input -)
COMMIT_OID=$(printf '%s' "$COMMIT_RESPONSE" | jq -r '.data.createCommitOnBranch.commit.oid // empty')
if [[ -z "$COMMIT_OID" ]]; then
  echo "Error: createCommitOnBranch did not return a commit:" >&2
  echo "$COMMIT_RESPONSE" >&2
  cleanup  # explicit exit does not fire the ERR trap; delete the orphan branch
  exit 1
fi

echo "Opening PR..."

PR_BODY="## Summary
Adds the community election proposal **${NAME}**.

- Seats (maxChoicesPerVoter): ${SEATS}
- Candidates: ${CAND_COUNT}
- Election summary gist: ${GIST_URL}"
if [[ -n "$REFERENCE_URL" ]]; then
  PR_BODY="${PR_BODY}
- Reference: ${REFERENCE_URL}"
fi
PR_BODY="${PR_BODY}

Winners are the ${SEATS} highest-weighted candidates, tallied off-chain after the vote closes."

PR_URL=$("$GH" pr create \
  --repo "$REPO" \
  --head "$BRANCH" \
  --title "Add election proposal: ${NAME}" \
  --body "$PR_BODY")

BRANCH_CREATED=false  # success — don't clean up
echo ""
echo "Done! PR created: $PR_URL"
