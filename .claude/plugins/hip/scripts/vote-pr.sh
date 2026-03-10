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

BRANCH="hip-${HIP_NUMBER}"

# Map category to tags
case "$CATEGORY" in
  economic*)  TAGS='["Economic"]' ;;
  technical*) TAGS='["Technical"]' ;;
  meta*)      TAGS='["Meta"]' ;;
  *)          TAGS='["Economic", "Technical"]' ;;
esac

# Check dependencies
for cmd in jq base64; do
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

# Get the current file content and its blob SHA
FILE_RESPONSE=$("$GH" api "repos/$REPO/contents/$FILE_PATH")
FILE_SHA=$(echo "$FILE_RESPONSE" | jq -r '.sha')
if [[ -z "$FILE_SHA" || "$FILE_SHA" == "null" ]]; then
  echo "Error: Could not get $FILE_PATH SHA from $REPO." >&2
  exit 1
fi
CURRENT_CONTENT=$(echo "$FILE_RESPONSE" | jq -r '.content' | base64 -d)

# Build the new entry
NEW_ENTRY=$(jq -n \
  --arg name "HIP-${HIP_NUMBER}: ${TITLE}" \
  --arg uri "$GIST_URL" \
  --arg choice_for "For HIP-${HIP_NUMBER}" \
  --arg choice_against "Against HIP-${HIP_NUMBER}" \
  --argjson tags "$TAGS" \
  '{
    name: $name,
    uri: $uri,
    maxChoicesPerVoter: 1,
    tags: $tags,
    choices: [
      { uri: null, name: $choice_for },
      { uri: null, name: $choice_against }
    ]
  }')

# Append to the array
UPDATED_CONTENT=$(echo "$CURRENT_CONTENT" | jq --argjson entry "$NEW_ENTRY" '. + [$entry]')

# Check that the entry was actually added
ORIGINAL_COUNT=$(echo "$CURRENT_CONTENT" | jq 'length')
UPDATED_COUNT=$(echo "$UPDATED_CONTENT" | jq 'length')
if [[ "$UPDATED_COUNT" -le "$ORIGINAL_COUNT" ]]; then
  echo "Error: Failed to append entry to $FILE_PATH" >&2
  exit 1
fi

echo "Creating branch $BRANCH..."

# Check if branch already exists
BRANCH_CHECK_STATUS=$("$GH" api "repos/$REPO/git/ref/heads/$BRANCH" \
  --include 2>/dev/null | head -1 | grep -oE '[0-9]{3}' || echo "000")
if [[ "$BRANCH_CHECK_STATUS" == "200" ]]; then
  echo "Error: Branch $BRANCH already exists in $REPO." >&2
  echo "Delete it first if you want to retry:" >&2
  echo "  $GH api repos/$REPO/git/refs/heads/$BRANCH -X DELETE" >&2
  exit 1
elif [[ "$BRANCH_CHECK_STATUS" != "404" ]]; then
  echo "Error: Could not check if branch exists (HTTP $BRANCH_CHECK_STATUS)." >&2
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
