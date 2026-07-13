#!/bin/bash
# Re-point a proposal entry's `uri` on an existing helium-vote PR branch.
#
# Use when the summary gist was edited after the vote PR was opened: the entry's
# `uri` pins a specific gist revision, so it must be updated to the new pinned
# raw URL. Fetches the file from the branch, replaces the old URL with the new
# one (which must occur exactly once), validates the result, and commits onto the
# existing branch via the signed GraphQL createCommitOnBranch mutation (helium-vote
# main requires signed commits). Does NOT create or delete branches.
#
# Usage:
#   repoint-uri.sh --branch hip-149-council-election \
#     --old-uri OLD_RAW_URL --new-uri NEW_RAW_URL \
#     [--file helium-proposals.json] [--repo helium/helium-vote]
#
# Requires: gh CLI, jq, base64, python3

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GH="$SCRIPT_DIR/gh-hiptron.sh"
REPO="helium/helium-vote"
FILE_PATH="helium-proposals.json"

usage() {
  echo "Usage: $0 --branch BRANCH --old-uri OLD --new-uri NEW [--file FILE] [--repo OWNER/REPO]" >&2
  echo "" >&2
  echo "  --branch    Existing PR branch to update" >&2
  echo "  --old-uri   Current uri to replace (must appear exactly once)" >&2
  echo "  --new-uri   New pinned raw gist URL" >&2
  echo "  --file      Proposals file (default: helium-proposals.json)" >&2
  echo "  --repo      Target repo (default: helium/helium-vote)" >&2
  exit 1
}

BRANCH="" OLD_URI="" NEW_URI=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch)   BRANCH="$2"; shift 2 ;;
    --old-uri)  OLD_URI="$2"; shift 2 ;;
    --new-uri)  NEW_URI="$2"; shift 2 ;;
    --file)     FILE_PATH="$2"; shift 2 ;;
    --repo)     REPO="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$BRANCH" || -z "$OLD_URI" || -z "$NEW_URI" ]]; then usage; fi
if ! [[ "$NEW_URI" =~ ^https://gist\.githubusercontent\.com/ ]]; then
  echo "Error: --new-uri must be a raw gist URL (https://gist.githubusercontent.com/...)" >&2
  exit 1
fi
if ! [[ "$BRANCH" =~ ^[A-Za-z0-9._/-]+$ ]]; then
  echo "Error: --branch has invalid characters (got: $BRANCH)" >&2
  exit 1
fi
for cmd in jq base64 python3; do
  command -v "$cmd" &>/dev/null || { echo "Error: $cmd is required." >&2; exit 1; }
done

AUTH_OUTPUT=$("$GH" auth status 2>&1) || {
  echo "Error: hiptron GitHub auth failed:" >&2
  echo "$AUTH_OUTPUT" >&2
  exit 1
}

echo "Fetching $FILE_PATH from $REPO@$BRANCH..."
BASE_SHA=$("$GH" api "repos/$REPO/git/ref/heads/$BRANCH" --jq '.object.sha')
if [[ -z "$BASE_SHA" || "$BASE_SHA" == "null" ]]; then
  echo "Error: branch $BRANCH not found in $REPO." >&2
  exit 1
fi
CURRENT_CONTENT=$("$GH" api "repos/$REPO/contents/$FILE_PATH?ref=$BRANCH" -H "Accept: application/vnd.github.raw")

# Replace the uri, requiring exactly one occurrence. Fail loudly otherwise.
UPDATED_CONTENT=$(CUR="$CURRENT_CONTENT" OLD="$OLD_URI" NEW="$NEW_URI" python3 -c '
import os, sys
cur = os.environ["CUR"]; old = os.environ["OLD"]; new = os.environ["NEW"]
n = cur.count(old)
if n != 1:
    raise SystemExit(f"expected --old-uri exactly once, found {n}")
sys.stdout.write(cur.replace(old, new))
')

# Validate: still valid JSON, same entry count, new uri present once, old gone.
ORIGINAL_COUNT=$(printf '%s' "$CURRENT_CONTENT" | jq 'length')
UPDATED_COUNT=$(printf '%s' "$UPDATED_CONTENT" | jq 'length' 2>/dev/null || echo -1)
# Check JSON validity + count BEFORE any further jq, so invalid JSON hits this
# friendly message instead of a raw parse error under `set -e`.
if [[ "$UPDATED_COUNT" != "$ORIGINAL_COUNT" ]]; then
  echo "Error: entry count changed ($ORIGINAL_COUNT -> $UPDATED_COUNT) or invalid JSON" >&2
  exit 1
fi
NEW_HITS=$(printf '%s' "$UPDATED_CONTENT" | jq --arg u "$NEW_URI" '[.[] | select(.uri == $u)] | length')
if [[ "$NEW_HITS" -lt 1 ]]; then
  echo "Error: new uri not present after replacement" >&2
  exit 1
fi
echo "Re-pointed uri in one entry; $ORIGINAL_COUNT entries unchanged in count."

echo "Committing (signed) onto $BRANCH..."
ENCODED_CONTENT=$(printf '%s' "$UPDATED_CONTENT" | base64 | tr -d '\n')
COMMIT_REQUEST=$(jq -n \
  --arg query 'mutation($input: CreateCommitOnBranchInput!) { createCommitOnBranch(input: $input) { commit { oid } } }' \
  --arg repo "$REPO" \
  --arg branch "$BRANCH" \
  --arg oid "$BASE_SHA" \
  --arg message "Update election vote uri (gist revision)" \
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
  exit 1
fi

echo ""
echo "Done! Re-pointed $FILE_PATH uri on $BRANCH (commit $COMMIT_OID)."
