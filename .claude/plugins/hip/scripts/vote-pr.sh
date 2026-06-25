#!/bin/bash
# Open a vote proposal PR against helium/helium-vote for a HIP.
#
# Fetches helium-proposals.json via the GitHub API, appends a new vote entry,
# creates a branch, commits the change, and opens a PR — all as hiptron.
# No local clone of helium-vote is needed.
#
# Usage:
#   vote-pr.sh --hip-number 148 --title "Reallocate Mobile Mapping Rewards" \
#     --category economic --gist-url RAW_URL --hip-file 0148-reallocate-mobile-mapping-rewards.md
#
# Requires: gh CLI, jq, base64

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GH="$SCRIPT_DIR/gh-hiptron.sh"
REPO="helium/helium-vote"
FILE_PATH="helium-proposals.json"

usage() {
  echo "Usage: $0 --hip-number NNN --title TITLE --category CATEGORY --gist-url RAW_URL --hip-file FILENAME" >&2
  echo "" >&2
  echo "  --hip-number  HIP number (e.g. 148)" >&2
  echo "  --title       HIP title" >&2
  echo "  --category    HIP category (economic, technical, meta)" >&2
  echo "  --gist-url    Raw URL of the vote summary gist" >&2
  echo "  --hip-file    HIP filename (e.g. 0148-reallocate-mobile-mapping-rewards.md)" >&2
  exit 1
}

# Parse arguments
HIP_NUMBER="" TITLE="" CATEGORY="" GIST_URL="" HIP_FILE=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --hip-number) HIP_NUMBER="$2"; shift 2 ;;
    --title)      TITLE="$2"; shift 2 ;;
    --category)   CATEGORY="$2"; shift 2 ;;
    --gist-url)   GIST_URL="$2"; shift 2 ;;
    --hip-file)   HIP_FILE="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$HIP_NUMBER" || -z "$TITLE" || -z "$CATEGORY" || -z "$GIST_URL" || -z "$HIP_FILE" ]]; then
  usage
fi

# Input validation
if ! [[ "$HIP_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "Error: --hip-number must be numeric (got: $HIP_NUMBER)" >&2
  exit 1
fi

if ! [[ "$GIST_URL" =~ ^https://gist\.githubusercontent\.com/ ]]; then
  echo "Error: --gist-url must be a raw gist URL (https://gist.githubusercontent.com/...)" >&2
  exit 1
fi

if ! [[ "$HIP_FILE" =~ ^[0-9]{4}-[a-z0-9-]+\.md$ ]]; then
  echo "Error: --hip-file must match NNNN-slug.md format (got: $HIP_FILE)" >&2
  exit 1
fi

if ! [[ "$CATEGORY" =~ ^(economic|technical|meta)(,\ ?(economic|technical|meta))*$ ]]; then
  echo "Error: --category must be economic, technical, or meta (got: $CATEGORY)" >&2
  exit 1
fi

BRANCH="hip-${HIP_NUMBER}"

# Map category (possibly comma-separated, e.g. "economic, technical") to tags,
# preserving every category rather than just the first. The ${TAGS//,/, } adds a
# space after commas to match the inline-array style in helium-proposals.json.
TAGS=$(printf '%s' "$CATEGORY" | jq -Rc '
  split(",")
  | map(gsub("^\\s+|\\s+$"; "") | ascii_downcase)
  | map({economic: "Economic", technical: "Technical", meta: "Meta"}[.])
  | map(select(. != null))')
TAGS=${TAGS//,/, }

# Check dependencies
for cmd in jq base64 python3; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is required but not installed." >&2
    exit 1
  fi
done

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

# Get the SHA of the default branch HEAD
BASE_SHA=$("$GH" api "repos/$REPO/git/ref/heads/main" --jq '.object.sha')
if [[ -z "$BASE_SHA" || "$BASE_SHA" == "null" ]]; then
  echo "Error: Could not resolve HEAD SHA for $REPO main branch." >&2
  exit 1
fi

# Get the current file's blob SHA and its raw content. Fetch raw content
# directly (Accept: raw) instead of base64-decoding the JSON response — BSD/macOS
# `base64 -d` mishandles the newline-wrapped base64 the contents API returns.
FILE_SHA=$("$GH" api "repos/$REPO/contents/$FILE_PATH" --jq '.sha')
if [[ -z "$FILE_SHA" || "$FILE_SHA" == "null" ]]; then
  echo "Error: Could not get $FILE_PATH SHA from $REPO." >&2
  exit 1
fi
CURRENT_CONTENT=$("$GH" api "repos/$REPO/contents/$FILE_PATH" -H "Accept: application/vnd.github.raw")

# Build the new entry as a text block matching the file's existing style:
# 2-space indentation with inline `tags` and `choices`. We append it textually
# rather than re-serializing the whole array with `jq`, because jq's pretty-printer
# expands those inline arrays and reformats every existing entry (a ~500-line diff
# for a one-entry change). jq is used only to JSON-escape the scalar values, and
# to validate the result below.
NAME_JSON=$(jq -cn --arg x "HIP-${HIP_NUMBER}: ${TITLE}" '$x')
URI_JSON=$(jq -cn --arg x "$GIST_URL" '$x')
FOR_JSON=$(jq -cn --arg x "For HIP-${HIP_NUMBER}" '$x')
AGAINST_JSON=$(jq -cn --arg x "Against HIP-${HIP_NUMBER}" '$x')
ENTRY_BLOCK="  {
    \"name\": ${NAME_JSON},
    \"uri\": ${URI_JSON},
    \"maxChoicesPerVoter\": 1,
    \"tags\": ${TAGS},
    \"choices\": [
      { \"uri\": null, \"name\": ${FOR_JSON} },
      { \"uri\": null, \"name\": ${AGAINST_JSON} }
    ]
  }"

# Append the entry before the array's closing ']', preserving all existing bytes
# (and the file's trailing-newline state).
UPDATED_CONTENT=$(CUR="$CURRENT_CONTENT" ENTRY="$ENTRY_BLOCK" python3 -c '
import os, sys
cur = os.environ["CUR"]
entry = os.environ["ENTRY"]
trailing_nl = cur.endswith("\n")
body = cur.rstrip()
if not body.endswith("]"):
    raise SystemExit("helium-proposals.json does not end with a JSON array")
body = body[:-1].rstrip()  # drop the final "]" -> body now ends at the last entry "}"
sys.stdout.write(body + ",\n" + entry + "\n]" + ("\n" if trailing_nl else ""))
')

# Validate the result is well-formed JSON and exactly one entry was added
ORIGINAL_COUNT=$(printf '%s' "$CURRENT_CONTENT" | jq 'length')
UPDATED_COUNT=$(printf '%s' "$UPDATED_CONTENT" | jq 'length')
if [[ "$UPDATED_COUNT" -ne $((ORIGINAL_COUNT + 1)) ]]; then
  echo "Error: Failed to append entry to $FILE_PATH (or produced invalid JSON)" >&2
  exit 1
fi

echo "Creating branch $BRANCH..."

# Check if the branch already exists. `gh api` exits non-zero on a 404, so test
# its exit status directly — do not pipe the response through `head`/`grep`, which
# races with SIGPIPE under `set -o pipefail` and misreports the status as "404\n000".
if "$GH" api "repos/$REPO/git/ref/heads/$BRANCH" >/dev/null 2>&1; then
  echo "Error: Branch $BRANCH already exists in $REPO." >&2
  echo "Delete it first if you want to retry:" >&2
  echo "  $GH api repos/$REPO/git/refs/heads/$BRANCH -X DELETE" >&2
  exit 1
fi

# Create the branch
"$GH" api "repos/$REPO/git/refs" \
  -f "ref=refs/heads/$BRANCH" \
  -f "sha=$BASE_SHA" > /dev/null
BRANCH_CREATED=true

echo "Committing updated $FILE_PATH..."

# Encode content
ENCODED_CONTENT=$(printf '%s' "$UPDATED_CONTENT" | base64 | tr -d '\n')
"$GH" api "repos/$REPO/contents/$FILE_PATH" \
  -X PUT \
  -f "message=Add HIP-${HIP_NUMBER} vote proposal" \
  -f "content=$ENCODED_CONTENT" \
  -f "sha=$FILE_SHA" \
  -f "branch=$BRANCH" > /dev/null

echo "Opening PR..."

# Open the PR
PR_URL=$("$GH" pr create \
  --repo "$REPO" \
  --head "$BRANCH" \
  --title "Add HIP-${HIP_NUMBER} vote proposal: ${TITLE}" \
  --body "$(cat <<PREOF
## Summary
Adds the community vote proposal for [HIP-${HIP_NUMBER}: ${TITLE}](https://github.com/helium/HIP/blob/main/${HIP_FILE}).

Vote summary gist: ${GIST_URL}
PREOF
)")

BRANCH_CREATED=false  # success — don't clean up
echo ""
echo "Done! PR created: $PR_URL"
