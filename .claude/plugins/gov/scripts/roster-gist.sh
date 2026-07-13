#!/bin/bash
# Render (and optionally publish) the combined election-summary gist for a
# multi-seat election.
#
# Input is candidate JSON: an object with an `items` array, each item having
# `name`, `body`, and optionally `handle`. The heliumtools council API is one
# such source; a different election source (a forum export, a CSV you convert,
# another API) can be reshaped into this form with a small jq map before calling.
# Renders one markdown document: an optional preamble (election rules) followed by
# every candidate's statement. Any extra fields (reaction/endorsement counts, edit
# timestamps) are ignored — a ballot statement is the candidate's own words, not
# popularity signals.
#
# By default it only renders (safe). Pass --publish to create the hiptron gist;
# render and review the markdown first.
#
# Usage:
#   roster-gist.sh --input council.json --out summary.md [--names-out candidates.txt] \
#     [--preamble rules.md] [--sort-by-name] [--names-with-handle] \
#     [--publish --desc "HIP-149 Advisory Council Election"]
#
# --sort-by-name      order candidates alphabetically by name (default: input order)
# --names-with-handle --names-out / ballot labels read "Name (@handle)" (default: name only)
#
# Requires: jq (+ gh CLI for --publish)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GH="$SCRIPT_DIR/gh-hiptron.sh"

usage() {
  echo "Usage: $0 --input JSON --out MD [--names-out TXT] [--preamble MD] [--publish --desc DESC]" >&2
  echo "" >&2
  echo "  --input      Candidate JSON: .items[] with name, body, optional handle" >&2
  echo "  --out        Markdown output path for the combined summary" >&2
  echo "  --names-out  Also write candidate names, one per line (for election-pr.sh)" >&2
  echo "  --preamble   Markdown file prepended before the candidate statements" >&2
  echo "  --publish    Create a new gist as hiptron (default: render only)" >&2
  echo "  --desc       Gist description (required with --publish)" >&2
  echo "  --update-gist ID  Update an existing gist in place; prints the new pinned raw URL" >&2
  exit 1
}

INPUT="" OUT="" NAMES_OUT="" PREAMBLE="" PUBLISH=false DESC="" SORT=false WITH_HANDLE=false UPDATE_GIST=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --input)             INPUT="$2"; shift 2 ;;
    --out)               OUT="$2"; shift 2 ;;
    --names-out)         NAMES_OUT="$2"; shift 2 ;;
    --preamble)          PREAMBLE="$2"; shift 2 ;;
    --sort-by-name)      SORT=true; shift ;;
    --names-with-handle) WITH_HANDLE=true; shift ;;
    --publish)           PUBLISH=true; shift ;;
    --update-gist)       UPDATE_GIST="$2"; shift 2 ;;
    --desc)              DESC="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$INPUT" || -z "$OUT" ]]; then usage; fi
if [[ ! -f "$INPUT" ]]; then echo "Error: --input not found: $INPUT" >&2; exit 1; fi
if $PUBLISH && [[ -z "$DESC" ]]; then echo "Error: --publish requires --desc" >&2; exit 1; fi
if $PUBLISH && [[ -n "$UPDATE_GIST" ]]; then echo "Error: --publish and --update-gist are mutually exclusive" >&2; exit 1; fi
if ! command -v jq &>/dev/null; then echo "Error: jq is required." >&2; exit 1; fi

# Validate the input has the expected shape.
if ! jq -e '.items | type == "array" and length > 0' "$INPUT" >/dev/null 2>&1; then
  echo "Error: $INPUT has no non-empty .items[] array" >&2
  exit 1
fi
if ! jq -e '.items | all(has("name") and has("body"))' "$INPUT" >/dev/null 2>&1; then
  echo "Error: every .items[] entry must have name and body" >&2
  exit 1
fi

# Build the markdown: optional preamble, then one section per candidate.
: > "$OUT"
if [[ -n "$PREAMBLE" ]]; then
  if [[ ! -f "$PREAMBLE" ]]; then echo "Error: --preamble not found: $PREAMBLE" >&2; exit 1; fi
  cat "$PREAMBLE" >> "$OUT"
  printf '\n\n' >> "$OUT"
fi

{
  echo "## Candidates"
  echo
  jq -r --argjson sort "$SORT" '
    (if $sort then (.items | sort_by(.name)) else .items end)[]
    | "### \(.name)\(if (.handle // "") != "" then " (@\(.handle))" else "" end)\n\n\(.body)\n"' "$INPUT"
} >> "$OUT"

echo "Rendered $(jq '.items | length' "$INPUT") candidate statements -> $OUT"

if [[ -n "$NAMES_OUT" ]]; then
  jq -r --argjson sort "$SORT" --argjson wh "$WITH_HANDLE" '
    (if $sort then (.items | sort_by(.name)) else .items end)[]
    | if $wh and ((.handle // "") != "") then "\(.name) (@\(.handle))" else .name end' "$INPUT" > "$NAMES_OUT"
  echo "Wrote candidate names -> $NAMES_OUT"
fi

if $PUBLISH; then
  echo "Publishing gist as hiptron..." >&2
  # gh gist create prints the gist's web URL; derive the pinned raw URL
  # (contains the commit sha) from the API so the vote entry freezes a snapshot.
  GIST_WEB_URL=$("$GH" gist create --public --desc "$DESC" "$OUT" | tail -1)
  GIST_ID=$(basename "$GIST_WEB_URL")
  RAW_URL=$("$GH" api "gists/$GIST_ID" --jq '.files | to_entries[0].value.raw_url')
  echo "Gist created: $GIST_WEB_URL"
  echo "Pinned raw URL (use as --gist-url): $RAW_URL"
fi

if [[ -n "$UPDATE_GIST" ]]; then
  echo "Updating gist $UPDATE_GIST as hiptron..." >&2
  # PATCH the existing gist's file (same filename => new revision, not a new file).
  # The API response's raw_url carries the new commit sha (a fresh pinned URL).
  # Update the gist's existing file in place. Look up its current filename so a
  # differing --out basename doesn't add a second file to the gist.
  FN=$("$GH" api "gists/$UPDATE_GIST" --jq '.files | keys[0]')
  if [[ -z "$FN" || "$FN" == "null" ]]; then
    echo "Error: could not read gist $UPDATE_GIST (does it exist?)" >&2
    exit 1
  fi
  RESP=$(jq -n --arg fn "$FN" --rawfile c "$OUT" '{files: {($fn): {content: $c}}}' \
    | "$GH" api -X PATCH "gists/$UPDATE_GIST" --input -)
  RAW_URL=$(printf '%s' "$RESP" | jq -r '.files | to_entries[0].value.raw_url')
  if [[ -z "$RAW_URL" || "$RAW_URL" == "null" ]]; then
    echo "Error: gist update did not return a raw_url:" >&2
    printf '%s\n' "$RESP" >&2
    exit 1
  fi
  echo "Gist updated. New pinned raw URL (use as --new-uri / --gist-url): $RAW_URL"
fi
