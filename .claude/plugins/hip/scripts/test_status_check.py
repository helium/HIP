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


class TitledHipNumber(unittest.TestCase):
    """A tracking issue names its own HIP; a mismatch means a mislinked row."""

    def test_current_convention(self):
        self.assertEqual(sc.titled_hip_number("HIP 150: Mobile Deployer"), 150)

    def test_no_space(self):
        self.assertEqual(sc.titled_hip_number("HIP18: Remove Oracle Forecast"), 18)

    def test_leading_zeros(self):
        self.assertEqual(sc.titled_hip_number("HIP-0053: Mobile DAO"), 53)

    def test_pre_convention_title_names_none(self):
        for title in ["new HIP", "Crowdspot Modifications",
                      "LoRaWAN packet routing (HIP draft)",
                      "Create 0006-reward-ramp-for-packets.md"]:
            self.assertIsNone(sc.titled_hip_number(title), title)

    def test_does_not_match_a_number_further_into_the_title(self):
        # "HIP" must introduce the number, or a title mentioning another
        # HIP in passing would read as that HIP's issue.
        self.assertIsNone(sc.titled_hip_number("Follow-up to HIP 42 discussion"))

    def test_number_must_end_at_a_boundary(self):
        self.assertEqual(sc.titled_hip_number("HIP 10: x"), 10)
        self.assertNotEqual(sc.titled_hip_number("HIP 100: x"), 10)


def _row(hip, badge, link):
    pad = " " * 40
    cell = (f'[<img src="https://img.shields.io/badge/Status-{badge}-x"></img>]'
            f'(https://github.com/helium/HIP/{link})' if link
            else f'<img src="https://img.shields.io/badge/Status-{badge}-x"></img>')
    return f"| {hip} | [T](00{hip}-t.md){pad} | {cell} | x |"


class EndToEnd(unittest.TestCase):
    """Drives main() over a fixture repo.

    Covers the branches that consume the parsers: era classification,
    mislink detection, and the label comparison behind them.
    """

    def _run(self, rows, files, issues, pulls, argv):
        import contextlib, io, tempfile, os
        with tempfile.TemporaryDirectory() as d:
            with open(os.path.join(d, "README.md"), "w") as f:
                f.write("\n".join(rows) + "\n")
            for name, body in files.items():
                with open(os.path.join(d, name), "w") as f:
                    f.write(body)
            sc.all_issues = lambda: (issues, pulls)
            sc.open_status_prs = lambda: []
            old_argv = sys.argv
            sys.argv = ["sc", "--root", d, "--all"] + argv
            buf = io.StringIO()
            try:
                with contextlib.redirect_stdout(buf):
                    code = sc.main()
            finally:
                sys.argv = old_argv
            return code, buf.getvalue()

    def test_legacy_pr_link_is_a_note_not_drift(self):
        code, out = self._run(
            [_row(6, "Deployed", "pull/20")],
            {"0006-t.md": "# HIP 6\n\n- Author: x\n"},
            {}, {20}, [],
        )
        self.assertIn("predates tracking issues", out)
        self.assertNotIn("finding(s)", out)
        self.assertEqual(code, 0)

    def test_legacy_row_with_no_link_is_a_note(self):
        code, out = self._run(
            [_row(1, "Deployed", None)],
            {"0001-t.md": "# HIP 1\n"},
            {}, set(), [],
        )
        self.assertIn("has no GitHub link", out)
        self.assertEqual(code, 0)

    def test_modern_hip_without_a_tracking_issue_is_drift(self):
        # YAML frontmatter means the current convention applies, so a
        # missing tracking issue is a finding rather than an era note.
        code, out = self._run(
            [_row(150, "Approved", None)],
            {"0150-t.md": "---\nstatus: Approved\n---\n"},
            {}, set(), [],
        )
        self.assertIn("no tracking issue", out)
        self.assertIn("1 finding(s)", out)
        self.assertEqual(code, 1)

    def test_row_linking_to_another_hips_issue_is_drift(self):
        code, out = self._run(
            [_row(18, "Closed", "issues/60")],
            {"0018-t.md": "# HIP 18\n"},
            {60: {"labels": {"deployed"}, "title": "HIP17: Hex Density"}}, set(), [],
        )
        self.assertIn("is HIP-17's issue", out)
        self.assertEqual(code, 1)
        # The label comparison must not also run against the wrong issue.
        self.assertNotIn("expects label", out)

    def test_correctly_linked_row_still_checks_labels(self):
        code, out = self._run(
            [_row(18, "Closed", "issues/65")],
            {"0018-t.md": "# HIP 18\n"},
            {65: {"labels": {"closed/withdrawn"},
                  "title": "HIP18: Remove Oracle Forecast"}}, set(), [],
        )
        self.assertIn("All surfaces agree", out)
        self.assertEqual(code, 0)

    def test_correctly_linked_row_reports_a_real_label_mismatch(self):
        code, out = self._run(
            [_row(18, "Closed", "issues/65")],
            {"0018-t.md": "# HIP 18\n"},
            {65: {"labels": {"deployed"}, "title": "HIP18: Remove Oracle"}},
            set(), [],
        )
        self.assertIn("expects label", out)
        self.assertEqual(code, 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
