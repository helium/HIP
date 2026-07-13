#!/bin/bash
# Apply a set of exactly-once string replacements to a proposals JSON file on a
# NEW branch off the base, then open a PR — as hiptron, via a signed commit.
#
# Use to correct an already-merged entry (e.g. re-issue a proposal whose choice
# labels or uri must change) without reformatting the file: each replacement is a
# plain string swap that must match exactly once, so formatting and every other
# entry are preserved. Validates the result parses and the entry count is
# unchanged, then commits via the signed GraphQL createCommitOnBranch mutation
# (helium-vote main requires signed commits).
#
# Usage:
#   edit-entry.sh --branch fix-branch --replacements repl.json \
#     --title "Fix HIP-149 election entry" \
#     [--reference-url URL] [--file helium-proposals.json] \
#     [--repo helium/helium-vote] [--base main]
#
# --replacements: JSON array of {"old": "...", "new": "..."}; each "old" must
#                 occur exactly once in the file.
#
# Requires: gh CLI, jq, base64, python3

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GH="$SCRIPT_DIR/gh-hiptron.sh"
REPO="helium/helium-vote"
FILE_PATH="helium-proposals.json"
BASE="main"

usage() {
  echo "Usage: $0 --branch BRANCH --replacements JSON --title TITLE [--reference-url URL] [--file FILE] [--repo OWNER/REPO] [--base BASE]" >&2
  exit 1
}

BRANCH="" REPL="" TITLE="" REFERENCE_URL=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch)        BRANCH="$2"; shift 2 ;;
    --replacements)  REPL="$2"; shift 2 ;;
    --title)         TITLE="$2"; shift 2 ;;
    --reference-url) REFERENCE_URL="$2"; shift 2 ;;
    --file)          FILE_PATH="$2"; shift 2 ;;
    --repo)          REPO="$2"; shift 2 ;;
    --base)          BASE="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$BRANCH" || -z "$REPL" || -z "$TITLE" ]]; then usage; fi
if ! [[ "$BRANCH" =~ ^[A-Za-z0-9._/-]+$ ]]; then
  echo "Error: --branch has invalid characters (got: $BRANCH)" >&2; exit 1
fi
if [[ ! -f "$REPL" ]]; then echo "Error: --replacements file not found: $REPL" >&2; exit 1; fi
if [[ -n "$REFERENCE_URL" ]] && ! [[ "$REFERENCE_URL" =~ ^https:// ]]; then
  echo "Error: --reference-url must be an https URL (got: $REFERENCE_URL)" >&2; exit 1
fi
for cmd in jq base64 python3; do
  command -v "$cmd" &>/dev/null || { echo "Error: $cmd is required." >&2; exit 1; }
done
# Validate the replacements file shape up front.
if ! jq -e 'type == "array" and length > 0 and all(has("old") and has("new") and (.old | type == "string") and (.new | type == "string"))' "$REPL" >/dev/null 2>&1; then
  echo "Error: --replacements must be a non-empty JSON array of {old,new} strings" >&2; exit 1
fi

AUTH_OUTPUT=$("$GH" auth status 2>&1) || {
  echo "Error: hiptron GitHub auth failed:" >&2; echo "$AUTH_OUTPUT" >&2; exit 1
}

BRANCH_CREATED=false
cleanup() {
  if $BRANCH_CREATED; then
    echo "Cleaning up: deleting branch $BRANCH from $REPO..." >&2
    "$GH" api "repos/$REPO/git/refs/heads/$BRANCH" -X DELETE >/dev/null 2>&1 || true
  fi
}
trap cleanup ERR

echo "Fetching $FILE_PATH from $REPO@$BASE..."
BASE_SHA=$("$GH" api "repos/$REPO/git/ref/heads/$BASE" --jq '.object.sha')
if [[ -z "$BASE_SHA" || "$BASE_SHA" == "null" ]]; then
  echo "Error: base branch $BASE not found in $REPO." >&2; exit 1
fi
CURRENT_CONTENT=$("$GH" api "repos/$REPO/contents/$FILE_PATH?ref=$BASE" -H "Accept: application/vnd.github.raw")

# Apply each replacement, requiring exactly one occurrence of each "old".
UPDATED_CONTENT=$(CUR="$CURRENT_CONTENT" REPL_JSON="$(cat "$REPL")" python3 -c '
import os, sys, json
cur = os.environ["CUR"]
repls = json.loads(os.environ["REPL_JSON"])
for i, r in enumerate(repls):
    old, new = r["old"], r["new"]
    n = cur.count(old)
    if n != 1:
        raise SystemExit(f"replacement {i}: expected exactly 1 occurrence of {old!r}, found {n}")
    cur = cur.replace(old, new)
sys.stdout.write(cur)
')

# Validate: still valid JSON and the entry count is unchanged.
ORIGINAL_COUNT=$(printf '%s' "$CURRENT_CONTENT" | jq 'length')
UPDATED_COUNT=$(printf '%s' "$UPDATED_CONTENT" | jq 'length' 2>/dev/null || echo -1)
if [[ "$UPDATED_COUNT" != "$ORIGINAL_COUNT" ]]; then
  echo "Error: entry count changed ($ORIGINAL_COUNT -> $UPDATED_COUNT) or invalid JSON" >&2
  exit 1
fi
NUM_REPL=$(jq 'length' "$REPL")
echo "Applied $NUM_REPL replacement(s); $ORIGINAL_COUNT entries unchanged in count."

# Guard: branch must not already exist.
if "$GH" api "repos/$REPO/git/ref/heads/$BRANCH" >/dev/null 2>&1; then
  echo "Error: branch $BRANCH already exists in $REPO. Delete it to retry." >&2; exit 1
fi
echo "Creating branch $BRANCH off $BASE..."
"$GH" api "repos/$REPO/git/refs" -f "ref=refs/heads/$BRANCH" -f "sha=$BASE_SHA" >/dev/null
BRANCH_CREATED=true

echo "Committing (signed)..."
ENCODED_CONTENT=$(printf '%s' "$UPDATED_CONTENT" | base64 | tr -d '\n')
COMMIT_REQUEST=$(jq -n \
  --arg query 'mutation($input: CreateCommitOnBranchInput!) { createCommitOnBranch(input: $input) { commit { oid } } }' \
  --arg repo "$REPO" --arg branch "$BRANCH" --arg oid "$BASE_SHA" \
  --arg message "$TITLE" --arg path "$FILE_PATH" --arg contents "$ENCODED_CONTENT" \
  '{query: $query, variables: {input: {
      branch: {repositoryNameWithOwner: $repo, branchName: $branch},
      expectedHeadOid: $oid,
      message: {headline: $message},
      fileChanges: {additions: [{path: $path, contents: $contents}]}
  }}}')
COMMIT_RESPONSE=$(printf '%s' "$COMMIT_REQUEST" | "$GH" api graphql --input -)
COMMIT_OID=$(printf '%s' "$COMMIT_RESPONSE" | jq -r '.data.createCommitOnBranch.commit.oid // empty')
if [[ -z "$COMMIT_OID" ]]; then
  echo "Error: createCommitOnBranch did not return a commit:" >&2; echo "$COMMIT_RESPONSE" >&2
  cleanup  # explicit exit does not fire the ERR trap; delete the orphan branch
  exit 1
fi

echo "Opening PR..."
PR_BODY="## Summary
${TITLE}

Applied ${NUM_REPL} exactly-once string replacement(s) to \`${FILE_PATH}\`; entry count unchanged."
if [[ -n "$REFERENCE_URL" ]]; then
  PR_BODY="${PR_BODY}

Reference: ${REFERENCE_URL}"
fi
PR_URL=$("$GH" pr create --repo "$REPO" --base "$BASE" --head "$BRANCH" --title "$TITLE" --body "$PR_BODY")
BRANCH_CREATED=false
echo ""
echo "Done! PR created: $PR_URL"
