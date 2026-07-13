#!/bin/bash
# Tally a multi-seat (top-N) approval election and print the winners.
#
# Reads per-choice vote weights from the helium-vote-service
# (GET /v1/proposals/:proposal/votes returns one row per voter+choice with the
# voter's weight on that choice), sums weight per candidate, ranks descending,
# and marks the top --seats as elected. Winners are NOT recorded on-chain, so
# this off-chain ranking is the authoritative result.
#
# Receiving-Entity recusal (or any exclusion) is applied with --exclude-voters:
# rows whose voter pubkey is listed are dropped before summing.
#
# Usage:
#   tally.sh --proposal <proposalPubkey> --seats 5 \
#     [--exclude-voters recused.txt] \
#     [--service-url https://helium-vote-service.web.helium.io]
#
# Requires: curl, python3

set -euo pipefail

SERVICE_URL="https://helium-vote-service.web.helium.io"
PROPOSAL="" SEATS="" EXCLUDE_FILE=""

usage() {
  echo "Usage: $0 --proposal PUBKEY --seats N [--exclude-voters FILE] [--service-url URL]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --proposal)        PROPOSAL="$2"; shift 2 ;;
    --seats)           SEATS="$2"; shift 2 ;;
    --exclude-voters)  EXCLUDE_FILE="$2"; shift 2 ;;
    --service-url)     SERVICE_URL="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$PROPOSAL" || -z "$SEATS" ]]; then usage; fi
if ! [[ "$SEATS" =~ ^[0-9]+$ ]] || [[ "$SEATS" -lt 1 ]]; then
  echo "Error: --seats must be a positive integer" >&2; exit 1
fi
if [[ -n "$EXCLUDE_FILE" && ! -f "$EXCLUDE_FILE" ]]; then
  echo "Error: --exclude-voters file not found: $EXCLUDE_FILE" >&2; exit 1
fi
for cmd in curl python3; do
  command -v "$cmd" &>/dev/null || { echo "Error: $cmd is required." >&2; exit 1; }
done

VOTES_JSON=$(curl -sS --fail "${SERVICE_URL}/v1/proposals/${PROPOSAL}/votes") || {
  echo "Error: failed to fetch votes from ${SERVICE_URL}/v1/proposals/${PROPOSAL}/votes" >&2
  exit 1
}

PROPOSAL="$PROPOSAL" SEATS="$SEATS" EXCLUDE_FILE="$EXCLUDE_FILE" \
VOTES_JSON="$VOTES_JSON" python3 <<'PY'
import json, os
from decimal import Decimal

votes = json.loads(os.environ["VOTES_JSON"])
seats = int(os.environ["SEATS"])
excluded = set()
ef = os.environ.get("EXCLUDE_FILE") or ""
if ef:
    with open(ef) as fh:
        excluded = {ln.strip() for ln in fh if ln.strip()}

if not isinstance(votes, list) or not votes:
    raise SystemExit("No vote rows returned — is the proposal address correct and the vote open/closed?")

# Sum weight per candidate (by choice index; carry the name for display).
# Decimal preserves the full base-unit precision; float would lose it.
totals = {}   # choice_index -> Decimal weight
names = {}     # choice_index -> choiceName
dropped = 0
for row in votes:
    if row.get("voter") in excluded:
        dropped += 1
        continue
    if "choice" not in row or "weight" not in row:
        raise SystemExit(f"unexpected vote row shape (missing choice/weight): {row}")
    ci = row["choice"]
    totals[ci] = totals.get(ci, Decimal(0)) + Decimal(str(row["weight"]))
    names[ci] = row.get("choiceName") or f"choice {ci}"

ranked = sorted(totals.items(), key=lambda kv: kv[1], reverse=True)

print(f"Proposal: {os.environ['PROPOSAL']}")
print(f"Seats: {seats} | candidates with votes: {len(ranked)} | excluded voter rows: {dropped}")
print()
print(f"{'#':>2}  {'':1} {'candidate':30} {'total weight (base units)':>28}")
for i, (ci, wt) in enumerate(ranked, 1):
    mark = "W" if i <= seats else " "
    print(f"{i:>2}  {mark} {names[ci][:30]:30} {str(wt):>28}")
print()
if len(ranked) < seats:
    print(f"WARNING: only {len(ranked)} candidates received votes for {seats} seats — seats under-filled.")
print(f"Winners (top {seats} by weight): " + ", ".join(names[ci] for ci, _ in ranked[:seats]))
if len(ranked) > seats:
    tie_edge = ranked[seats-1][1] == ranked[seats][1]
    if tie_edge:
        print("WARNING: tie at the seat boundary — resolve manually.")
PY
