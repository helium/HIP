#!/usr/bin/env python3
"""Reconcile a HIP's status across the three surfaces that must agree.

A status change touches the HIP frontmatter, the README badge, and the
tracking-issue label. The first two land through a PR that needs a human
merge; the label lands immediately through the API. An unmerged status PR
therefore leaves the repo and the tracking issue disagreeing, with nothing
to surface it.

This reports that disagreement, and any open status PR that would cause it.

Usage:
  status-check.py                 # in-flight HIPs and the most recent few
  status-check.py --all           # every HIP
  status-check.py --hip 150       # one HIP

Exit code is a bitmask: 0 clean, 1 drift found, 2 a check could not run
(unmeasured, not clean), 3 both.
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
    """Decode a shields.io badge slug to its display text.

    shields.io escapes a literal dash as `--` and a literal underscore as
    `__`, and renders a single `_` or `%20` as a space. The doubled forms
    are resolved through placeholders so an unescaped dash is not then read
    as a separator.
    """
    dash, under = "\x00", "\x01"
    return (raw.replace("--", dash).replace("__", under)
               .replace("%20", " ").replace("_", " ")
               .replace(dash, "-").replace(under, "_"))


def parse_readme_rows(lines):
    """HIP number -> (badge status, tracking link) from the index table.

    The tracking link is `(kind, number)` where kind is "issues" or "pull",
    or None when the row carries no GitHub link at all. A row linking to a
    pull request is a real state the caller reports, not a parse failure.
    """
    out = {}
    row = re.compile(r"^\|\s*(\d+)\s*\|")
    for line in lines:
        m = row.match(line)
        if not m:
            continue
        badge = re.search(r"Status-([A-Za-z0-9%_-]+?)-[a-z]+\"", line)
        link = re.search(r"/(issues|pull)/(\d+)", line)
        out[int(m.group(1))] = (
            badge_text(badge.group(1)) if badge else None,
            (link.group(1), int(link.group(2))) if link else None,
        )
    return out


def read_readme(root):
    """Parse the README index table at the repo root."""
    text = (root / "README.md").read_text(encoding="utf-8")
    return parse_readme_rows(text.splitlines())


def read_frontmatter(root):
    """HIP number -> frontmatter status, for HIPs that carry YAML frontmatter.

    A HIP is in this map only when it carries a YAML `status:` field. Older
    HIPs use markdown-list metadata and hold their status in the README and
    the tracking issue alone, so absence here means there is no frontmatter
    to check.
    """
    out = {}
    for num, path in hip_files(root).items():
        status = parse_frontmatter_status(path.read_text(encoding="utf-8"))
        if status is not None:
            out[num] = status
    return out


def hip_files(root):
    """HIP number -> path, for every numbered HIP file at the repo root."""
    return {
        int(p.name[:4]): p
        for p in sorted(root.glob("0*-*.md"))
        if int(p.name[:4]) != 0
    }


def parse_frontmatter_status(text):
    """The YAML `status:` value, or None when the file carries no frontmatter."""
    m = re.match(r"^﻿?---\r?\n(.*?)\r?\n---", text, re.S)
    if not m:
        return None
    s = re.search(r"^status:\s*(.+?)\s*$", m.group(1), re.M)
    return s.group(1).strip("\"'") if s else None


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

    One paginated call covers the whole repo, so a full sweep costs the same
    as a single-HIP check. The endpoint serves pull requests from the same
    number space; those carry a "pull_request" key and are returned
    separately, because a README tracking link pointing at one is drift the
    caller reports rather than a lookup that failed.

    Returns (issue labels, set of numbers that are pull requests).
    """
    rows = gh_json([
        "api", f"repos/{REPO}/issues?state=all&per_page=100", "--paginate",
        "--slurp",
    ])
    labels, pulls = {}, set()
    for page in rows:
        for item in page:
            if "pull_request" in item:
                pulls.add(item["number"])
            else:
                labels[item["number"]] = {lbl["name"] for lbl in item["labels"]}
    return labels, pulls


def open_status_prs():
    """Open status-transition PRs raised from a branch in this repo.

    A PR title is written by whoever opened the PR, and anyone may open one
    from a fork. Only branches in `REPO` itself are counted, so a title
    alone cannot put this check into a failing state. Titles stay untrusted
    text and are quoted wherever they are printed.
    """
    data = gh_json([
        "pr", "list", "--repo", REPO, "--state", "open", "--limit", "100",
        "--json", "number,title,createdAt,url,isCrossRepository",
    ])
    now = datetime.now(timezone.utc)
    found = []
    for pr in data:
        if pr["isCrossRepository"]:
            continue
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


def decide(findings, unchecked):
    """Exit code: bit 0 is drift found, bit 1 is a check that could not run.

    The bits are independent, so 3 means both and a caller gating on `& 1`
    still fires when coverage was also incomplete. Drift has an owner and a
    fix; an unrun check means the tool could not look.
    """
    return (1 if findings else 0) | (2 if unchecked else 0)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--hip", type=int, help="check a single HIP number")
    ap.add_argument("--all", action="store_true",
                    help="check every HIP, not just in-flight and recent")
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
        if num not in frontmatter:
            continue  # legacy metadata carries no status field
        fm_checked += 1
        badge = readme[num][0]
        if frontmatter[num] != badge:
            findings.append(
                f"HIP-{num}: frontmatter says {frontmatter[num]!r}, "
                f"README badge says {badge!r}"
            )

    # 2. A HIP file with no README row is missing from a surface, not out
    #    of scope. This compares two whole sets, so it always covers the
    #    corpus regardless of the scope above.
    files = hip_files(root)
    for num in sorted(set(files) - set(readme)):
        if args.hip is None or num == args.hip:
            findings.append(f"HIP-{num}: file exists with no README index row")

    # 3. README badge vs tracking-issue label, and 4. stalled status PRs.
    label_checked = 0
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
                f"(-> {pr['target']!r}) open {pr['age_days']}d, "
                f"unmerged - {pr['url']}"
            )

    try:
        label_map, pull_numbers = all_issue_labels()
    except Exception as exc:
        unchecked.append(f"tracking-issue labels ({exc})")
        label_map = None

    for num in numbers if label_map is not None else []:
        badge, link = readme[num]
        if link is None:
            unchecked.append(f"HIP-{num} tracking issue (no GitHub link in README)")
            continue
        kind, ref = link
        if kind == "pull" or ref in pull_numbers:
            findings.append(
                f"HIP-{num}: README tracking link #{ref} is a pull request, "
                f"not a tracking issue"
            )
            continue
        if ref not in label_map:
            unchecked.append(f"HIP-{num} issue #{ref} (not returned by the API)")
            continue
        issue = ref
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

    print()
    print(f"Scope: {scope}")
    print(f"Checked {len(numbers)} HIP(s): "
          f"{fm_checked} frontmatter, {label_checked} tracking issue.")
    print(f"README rows cover {len(files)- len(set(files) - set(readme))}"
          f" of {len(files)} HIP files (corpus-wide).")
    if findings:
        print(f"\n{len(findings)} finding(s):")
        for f in findings:
            print(f"  - {f}")
    if notes:
        print(f"\n{len(notes)} note(s), not drift:")
        for n in notes:
            print(f"  - {n}")
    if unchecked:
        print(f"\n{len(unchecked)} check(s) COULD NOT RUN, so they are "
              f"unmeasured rather than clean:")
        for u in unchecked:
            print(f"  - {u}")
    if not findings and not unchecked:
        print("\nAll surfaces agree.")
    return decide(findings, unchecked)


if __name__ == "__main__":
    sys.exit(main())
