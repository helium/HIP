#!/usr/bin/env python3
"""Tests for status-check.py.

Run: python3 .claude/plugins/hip/scripts/test_status_check.py

The repo has no CI, so these run by hand. They cover the pure seams: the
exit-code contract, the two parsers, and the badge decoder.
"""

import importlib.util
import sys
import unittest
from pathlib import Path

_spec = importlib.util.spec_from_file_location(
    "status_check", Path(__file__).parent / "status-check.py"
)
sc = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(sc)


class Decide(unittest.TestCase):
    """The exit contract. Each bit must survive the other being set."""

    def test_clean(self):
        self.assertEqual(sc.decide([], []), 0)

    def test_drift_only(self):
        self.assertEqual(sc.decide(["drift"], []), 1)

    def test_unchecked_only(self):
        self.assertEqual(sc.decide([], ["unrun"]), 2)

    def test_both_keeps_the_drift_bit(self):
        # Drift must stay readable when a check also could not run: a caller
        # gating on the drift bit still fires.
        code = sc.decide(["drift"], ["unrun"])
        self.assertEqual(code, 3)
        self.assertTrue(code & 1)


class BadgeText(unittest.TestCase):
    """shields.io escaping: `--` is a literal dash, `__` a literal underscore."""

    def test_live_slugs(self):
        for slug, want in [
            ("Approved", "Approved"),
            ("Closed", "Closed"),
            ("Deployed", "Deployed"),
            ("In%20Discussion", "In Discussion"),
            ("Rejected", "Rejected"),
            ("Voting_Open", "Voting Open"),
        ]:
            self.assertEqual(sc.badge_text(slug), want, slug)

    def test_every_live_slug_maps_to_a_label(self):
        # The decoder and the mapping table have to agree, or a real row
        # reports as an unrecognized badge.
        for slug in ["Approved", "Closed", "Deployed", "In%20Discussion",
                     "Rejected", "Voting_Open"]:
            self.assertIn(sc.badge_text(slug), sc.BADGE_TO_LABEL, slug)

    def test_escaped_dash_and_underscore(self):
        self.assertEqual(sc.badge_text("In--Development"), "In-Development")
        self.assertEqual(sc.badge_text("Voting__Open"), "Voting_Open")


class ParseReadmeRows(unittest.TestCase):
    ROW = ('| 150 | [Mobile Deployer Prioritization](0150-x.md) | '
           '[<img src="https://img.shields.io/badge/Status-Approved-green">'
           '</img>](https://github.com/helium/HIP/issues/1239) | x |')

    def test_badge_and_issue_link(self):
        self.assertEqual(sc.parse_readme_rows([self.ROW]),
                         {150: ("Approved", ("issues", 1239))})

    def test_multiword_badge(self):
        row = self.ROW.replace("Status-Approved-green",
                               "Status-In%20Discussion-orange")
        self.assertEqual(sc.parse_readme_rows([row])[150][0], "In Discussion")

    def test_pull_link_is_recorded_as_a_pull(self):
        row = self.ROW.replace("/issues/1239", "/pull/20")
        self.assertEqual(sc.parse_readme_rows([row])[150][1], ("pull", 20))

    def test_row_with_no_link(self):
        row = self.ROW.replace("https://github.com/helium/HIP/issues/1239", "")
        self.assertIsNone(sc.parse_readme_rows([row])[150][1])

    def test_number_must_be_its_own_cell(self):
        # The index row is `| N | ...`. A line that merely starts with a
        # number is not one, and ingesting it would invent a HIP.
        self.assertEqual(
            sc.parse_readme_rows(["| 150 and some prose | x |"]), {}
        )

    def test_non_numeric_first_cell_is_not_a_hip_row(self):
        # The status-key legend sits in the same file and must not parse as
        # a HIP. Assert the result itself, not that some later lookup is empty.
        legend = ('| Status | [<img src="https://img.shields.io/badge/'
                  'Status-Approved-green"></img>](x) |')
        self.assertEqual(sc.parse_readme_rows([legend]), {})


class ParseFrontmatterStatus(unittest.TestCase):
    def test_reads_status(self):
        self.assertEqual(
            sc.parse_frontmatter_status("---\nauthors: x\nstatus: Approved\n---\n# H"),
            "Approved",
        )

    def test_strips_quotes(self):
        self.assertEqual(
            sc.parse_frontmatter_status("---\nstatus: 'Voting Open'\n---\n"),
            "Voting Open",
        )

    def test_legacy_file_without_frontmatter(self):
        self.assertIsNone(
            sc.parse_frontmatter_status("# HIP 148\n\n- Author: x\n- Status: Deployed\n")
        )

    def test_frontmatter_without_a_status_field(self):
        self.assertIsNone(sc.parse_frontmatter_status("---\nauthors: x\n---\n"))

    def test_bom_prefixed_frontmatter(self):
        # A BOM would otherwise read as "no frontmatter" and silently skip
        # the check rather than reporting anything.
        self.assertEqual(
            sc.parse_frontmatter_status("\ufeff---\nstatus: Approved\n---\n"),
            "Approved",
        )

    def test_crlf_frontmatter(self):
        self.assertEqual(
            sc.parse_frontmatter_status("---\r\nstatus: Deployed\r\n---\r\n"),
            "Deployed",
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
