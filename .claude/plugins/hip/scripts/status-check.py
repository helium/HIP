#!/usr/bin/env python3
"""Reconcile a HIP's status across the three surfaces that must agree.

A status change touches the HIP frontmatter, the README badge, and the
tracking-issue label. The first two land through a PR that needs a human
merge; the label lands immediately through the API. An unmerged status PR
therefore leaves the repo and the tracking issue disagreeing, with nothing
to surface it.

This reports that disagreement, and any open status PR that would cause it.

Usage:
  status-check.py                 # every HIP
  status-check.py --hip 150       # one HIP
  status-check.py --local-only    # skip the GitHub reads

Exit: 0 clean, 1 drift found, 2 a check could not run.
"""

import argparse
import json
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO = "helium/HIP"

# Badge text -> the tracking-issue label that must accompany it.
BADGE_TO_LABEL = {
    "In Discussion": "discussion",
    "Voting Open": "voting now",
    "Approved": "approved",
    "Rejected": "rejected",
    "Deployed": "deployed",
    "Closed": "closed/withdrawn",
}

# Status labels with no badge of their own. They may sit alongside the
# canonical label and are reported, never treated as drift.
TRANSITIONAL_LABELS = {
    "draft", "voting soon", "closing soon", "in development",
    "stale", "changes requested", "revoked", "repealed",
}

# Badges for a HIP still moving through the lifecycle. A stalled status PR
# does its damage here, so these are always in scope.
IN_FLIGHT = {"In Discussion", "Voting Open"}

# Recently-settled HIPs stay in scope too: the transition into a terminal
# state is itself a status change that can half-land.
RECENT_COUNT = 5


def badge_text(raw):
    """Normalize a shields.io badge slug to its display text."""
    return raw.replace("%20", " ").replace("_", " ")


def read_readme(root):
    """HIP number -> (badge status, tracking issue number) from the index table."""
    out = {}
    row = re.compile(r"^\|\s*(\d+)\s*\|")
    for line in (root / "README.md").read_text(encoding="utf-8").splitlines():
        m = row.match(line)
        if not m:
            continue
        num = int(m.group(1))
        badge = re.search(r"Status-([A-Za-z0-9%_]+)-", line)
        issue = re.search(r"/issues/(\d+)", line)
        out[num] = (
            badge_text(badge.group(1)) if badge else None,
            int(issue.group(1)) if issue else None,
        )
    return out


def read_frontmatter(root):
    """HIP number -> frontmatter status, for HIPs that carry YAML frontmatter.

    Older HIPs use markdown-list metadata with no status field at all; they
    are absent from this map rather than recorded as None, so the caller can
    tell "no frontmatter to check" from "frontmatter says nothing".
    """
    out = {}
    for path in sorted(root.glob("0*-*.md")):
        num = int(path.name[:4])
        if num == 0:
            continue
        text = path.read_text(encoding="utf-8")
        m = re.match(r"^---\n(.*?)\n---", text, re.S)
        if not m:
            continue
        s = re.search(r"^status:\s*(.+)$", m.group(1), re.M)
        if s:
            out[num] = s.group(1).strip().strip("\"'")
    return out


def gh_json(args):
    """Run a gh command returning JSON. Raises on any failure."""
    proc = subprocess.run(
        ["gh", *args], capture_output=True, text=True, timeout=60
    )
    if proc.returncode != 0:
        raise RuntimeError(proc.stderr.strip() or "gh exited non-zero")
    return json.loads(proc.stdout)


def all_issue_labels():
    """issue number -> set of labels, for every issue in the repo.

    Fetched in one paginated call rather than one call per HIP: a per-HIP
    read makes a full sweep take minutes, and a check that slow does not
    get run. The issues endpoint also returns pull requests, which carry a
    "pull_request" key and are dropped here.
    """
    rows = gh_json([
        "api", f"repos/{REPO}/issues?state=all&per_page=100", "--paginate",
        "--slurp",
    ])
    out = {}
    for page in rows:
        for item in page:
            if "pull_request" in item:
                continue
            out[item["number"]] = {lbl["name"] for lbl in item["labels"]}
    return out


def open_status_prs():
    """Open PRs whose title is a status transition, with their age in days."""
    data = gh_json([
        "pr", "list", "--repo", REPO, "--state", "open", "--limit", "100",
        "--json", "number,title,createdAt,url",
    ])
    now = datetime.now(timezone.utc)
    found = []
    for pr in data:
        m = re.match(r"Update HIP-(\d+) status: (.+)", pr["title"])
        if not m:
            continue
        created = datetime.fromisoformat(pr["createdAt"].replace("Z", "+00:00"))
        found.append({
            "hip": int(m.group(1)),
            "target": m.group(2).strip(),
            "number": pr["number"],
            "url": pr["url"],
            "age_days": (now - created).days,
        })
    return found


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--hip", type=int, help="check a single HIP number")
    ap.add_argument("--all", action="store_true",
                    help="check every HIP, not just in-flight and recent")
    ap.add_argument("--local-only", action="store_true",
                    help="skip the GitHub reads (frontmatter vs README only)")
    ap.add_argument("--root", default=".", help="repo root")
    args = ap.parse_args()

    root = Path(args.root).resolve()
    readme = read_readme(root)
    frontmatter = read_frontmatter(root)

    if args.hip is not None:
        if args.hip not in readme:
            print(f"HIP-{args.hip} has no README row.", file=sys.stderr)
            return 2
        numbers, scope = [args.hip], f"HIP-{args.hip}"
    elif args.all:
        numbers, scope = sorted(readme), "every HIP"
    else:
        inflight = {n for n, (b, _) in readme.items() if b in IN_FLIGHT}
        recent = set(sorted(readme)[-RECENT_COUNT:])
        numbers = sorted(inflight | recent)
        scope = (f"in-flight ({len(inflight)}) + {RECENT_COUNT} most recent"
                 " -- pass --all for the full corpus")

    findings = []
    unchecked = []
    notes = []

    # 1. Frontmatter vs README badge.
    fm_checked = 0
    for num in numbers:
        badge = readme.get(num, (None, None))[0]
        if num not in frontmatter:
            continue  # legacy metadata carries no status field
        fm_checked += 1
        if frontmatter[num] != badge:
            findings.append(
                f"HIP-{num}: frontmatter says {frontmatter[num]!r}, "
                f"README badge says {badge!r}"
            )

    # 2. README badge vs tracking-issue label, and 3. stalled status PRs.
    label_checked = 0
    if args.local_only:
        unchecked.append("tracking-issue labels and open status PRs (--local-only)")
    else:
        try:
            stalled = open_status_prs()
        except Exception as exc:
            unchecked.append(f"open status PRs ({exc})")
        else:
            for pr in stalled:
                if args.hip is not None and pr["hip"] != args.hip:
                    continue
                findings.append(
                    f"HIP-{pr['hip']}: status PR #{pr['number']} "
                    f"(-> {pr['target']}) open {pr['age_days']}d, unmerged - {pr['url']}"
                )

        try:
            label_map = all_issue_labels()
        except Exception as exc:
            unchecked.append(f"tracking-issue labels ({exc})")
            label_map = None

        for num in numbers if label_map is not None else []:
            badge, issue = readme.get(num, (None, None))
            if issue is None:
                unchecked.append(f"HIP-{num} tracking issue (no link in README)")
                continue
            if issue not in label_map:
                unchecked.append(f"HIP-{num} issue #{issue} (not returned by the API)")
                continue
            labels = label_map[issue]
            label_checked += 1
            expected = BADGE_TO_LABEL.get(badge)
            if expected is None:
                findings.append(f"HIP-{num}: unrecognized README badge {badge!r}")
                continue
            present = labels & set(BADGE_TO_LABEL.values())
            if expected not in labels:
                findings.append(
                    f"HIP-{num}: README badge {badge!r} expects label "
                    f"{expected!r}; issue #{issue} has "
                    f"{sorted(present) or 'no status label'}"
                )
            elif present - {expected}:
                findings.append(
                    f"HIP-{num}: issue #{issue} carries conflicting status "
                    f"labels {sorted(present)}"
                )
            extra = labels & TRANSITIONAL_LABELS
            if extra:
                notes.append(f"HIP-{num} also carries {sorted(extra)}")

    # Report. Never print a clean result for a check that did not run.
    print()
    print(f"Scope: {scope}")
    print(f"Checked {len(numbers)} HIP(s): "
          f"{fm_checked} frontmatter, {label_checked} tracking issue.")
    if findings:
        print(f"\n{len(findings)} finding(s):")
        for f in findings:
            print(f"  - {f}")
    if notes:
        print(f"\n{len(notes)} note(s), not drift:")
        for n in notes:
            print(f"  - {n}")
    if unchecked:
        print(f"\n{len(unchecked)} check(s) COULD NOT RUN:")
        for u in unchecked:
            print(f"  - {u}")
        print("\nThese are unmeasured, not clean.")
        return 2
    if not findings:
        print("\nAll surfaces agree.")
        return 0
    return 1


if __name__ == "__main__":
    sys.exit(main())
