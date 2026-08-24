---
name: sweep
description: Terminology or number consistency sweep after a change - find every stale occurrence across the HIP, its assets, and the linked vote surfaces. Use when the user renames a term ("top-up" to "re-emission", "charter" to "governance framework"), changes a number ("2x to 3x", "3 weeks to 2"), or says "sweep for", "make consistent", "any other places with".
user_invocable: true
---

# HIP Consistency Sweep

Input: old term/value → new term/value (or "check consistency of X").

## Surfaces — all of them, every time

1. The HIP file itself, plus `files/NNNN/` assets. Figure *sources* count: labels and captions live in the generation scripts, and a stale label survives regeneration.
2. Sibling references: README index, the tracking issue, other HIPs that reference this one.
3. Linked vote surfaces when they exist: the heliumvote vote-summary gist and the `helium/helium-vote` proposal entry.

If the user maintains private working materials for the HIP, remind them the same sweep applies there via that material's own flow — never quote private content into public text here.

## Method

- Grep with variants: singular + plural, spaced + hyphenated ("12 month", "12-month", "12 months"), with and without tilde, case variants. A single-form regex hides survivors (`\b36[- ]month\b` misses "36 months").
- For a number change, also sweep *derived* figures: a 2x→3x cap change moves every threshold computed from it.
- Em/en dash detection needs Python (`'—' in line or '–' in line`); `grep -E "—"` can miss them depending on locale.
- Report every hit as `file:line` with the proposed replacement BEFORE editing anything — some hits are historical quotes or alternatives-considered text that must stay.
- After edits: regenerate affected figures and PDFs, then re-run the full grep set and show zero survivors.
