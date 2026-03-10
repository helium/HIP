# /// script
# requires-python = ">=3.11"
# ///
"""Post or update Helium Improvement Proposals on Reddit.

Usage:
  reddit-post.py post --file HIP_FILE --title TITLE --body BODY [--subreddit SUB]
  reddit-post.py update --file HIP_FILE --body BODY
  reddit-post.py lookup --file HIP_FILE

The Reddit post ID is stored in the HIP file's YAML frontmatter as
`reddit-post-id`. This keeps tracking in the repo itself, visible to all users.

Credentials are read from environment variables or ~/.config/hrp/reddit.env:
  REDDIT_CLIENT_ID, REDDIT_CLIENT_SECRET, REDDIT_USERNAME, REDDIT_PASSWORD
"""

import argparse
import base64
import json
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

ENV_FILE = Path.home() / ".config" / "hrp" / "reddit.env"
USER_AGENT = "helium-improvement-proposals/1.0 (by /u/HeliumConsoleTeam)"


def read_frontmatter(filepath):
    """Read YAML frontmatter from a HIP file. Returns (dict, full_text).

    Supports both YAML frontmatter (--- delimited) and legacy markdown-list
    metadata (- Key: value lines at the top of the file).
    """
    path = Path(filepath)
    if not path.exists():
        print(f"Error: HIP file not found: {filepath}", file=sys.stderr)
        sys.exit(1)

    text = path.read_text()

    # Try YAML frontmatter first
    match = re.match(r"^---\n(.*?\n)---\n", text, re.DOTALL)
    if match:
        fm = {}
        for line in match.group(1).splitlines():
            if ":" in line and not line.startswith(" "):
                key, _, value = line.partition(":")
                fm[key.strip()] = value.strip()
        return fm, text

    # Fall back to legacy markdown-list metadata
    fm = {}
    for line in text.splitlines():
        m = re.match(r"^- (.+?):\s*(.*)$", line)
        if m:
            fm[m.group(1).lower().replace("(", "").replace(")", "")] = m.group(2).strip()
        elif line.startswith("#") or (line.strip() and not line.startswith("-")):
            break

    return fm, text


def write_frontmatter_field(filepath, key, value):
    """Add or update a field in the YAML frontmatter of a HIP file."""
    text = Path(filepath).read_text()
    match = re.match(r"^---\n(.*?\n)---\n", text, re.DOTALL)
    if not match:
        print(f"Error: No YAML frontmatter found in {filepath}", file=sys.stderr)
        print("Cannot write reddit-post-id to legacy metadata format.", file=sys.stderr)
        print(f"IMPORTANT: Manually add 'reddit-post-id: {value}' to {filepath}", file=sys.stderr)
        sys.exit(1)

    fm_text = match.group(1)
    rest = text[match.end():]

    # Update existing field or insert before closing ---
    field_pattern = re.compile(rf"^{re.escape(key)}:.*$", re.MULTILINE)
    if field_pattern.search(fm_text):
        fm_text = field_pattern.sub(f"{key}: {value}", fm_text)
    else:
        fm_text = fm_text.rstrip("\n") + f"\n{key}: {value}\n"

    Path(filepath).write_text(f"---\n{fm_text}---\n{rest}")


def load_credentials():
    """Load Reddit API credentials from env vars or .env file."""
    creds = {
        "client_id": os.environ.get("REDDIT_CLIENT_ID"),
        "client_secret": os.environ.get("REDDIT_CLIENT_SECRET"),
        "username": os.environ.get("REDDIT_USERNAME"),
        "password": os.environ.get("REDDIT_PASSWORD"),
    }

    if not all(creds.values()) and ENV_FILE.exists():
        found_any = False
        for line in ENV_FILE.read_text().splitlines():
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            key, _, value = line.partition("=")
            key = key.strip()
            value = value.strip().strip("'\"")
            env_key = key.lower().replace("reddit_", "")
            if env_key in creds:
                creds[env_key] = creds[env_key] or value
                found_any = True
        if not found_any:
            print(f"Warning: {ENV_FILE} exists but no credentials were parsed from it.", file=sys.stderr)

    missing = [k for k, v in creds.items() if not v]
    if missing:
        print(f"Error: Missing credentials: {', '.join(missing)}", file=sys.stderr)
        print(f"\nSet environment variables or create {ENV_FILE} with:", file=sys.stderr)
        print("  REDDIT_CLIENT_ID=...", file=sys.stderr)
        print("  REDDIT_CLIENT_SECRET=...", file=sys.stderr)
        print("  REDDIT_USERNAME=...", file=sys.stderr)
        print("  REDDIT_PASSWORD=...", file=sys.stderr)
        sys.exit(1)

    return creds


def get_access_token(creds):
    """Authenticate with Reddit OAuth2 and return access token."""
    data = urllib.parse.urlencode({
        "grant_type": "password",
        "username": creds["username"],
        "password": creds["password"],
    }).encode()

    req = urllib.request.Request(
        "https://www.reddit.com/api/v1/access_token",
        data=data,
        method="POST",
    )
    req.add_header("User-Agent", USER_AGENT)

    auth = base64.b64encode(
        f"{creds['client_id']}:{creds['client_secret']}".encode()
    ).decode()
    req.add_header("Authorization", f"Basic {auth}")

    try:
        with urllib.request.urlopen(req) as resp:
            result = json.loads(resp.read())
    except urllib.error.HTTPError as e:
        print(f"Error: Reddit auth failed (HTTP {e.code})", file=sys.stderr)
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Error: Could not reach Reddit API: {e.reason}", file=sys.stderr)
        sys.exit(1)
    except (json.JSONDecodeError, ValueError):
        print("Error: Reddit returned non-JSON response during auth", file=sys.stderr)
        sys.exit(1)

    if "access_token" not in result:
        error_type = result.get("error", "unknown")
        error_msg = result.get("message", "no details")
        print(f"Error: Reddit auth failed: {error_type} - {error_msg}", file=sys.stderr)
        sys.exit(1)

    return result["access_token"]


def api_request(token, method, endpoint, data=None):
    """Make an authenticated request to Reddit's OAuth API."""
    url = f"https://oauth.reddit.com{endpoint}"
    encoded = urllib.parse.urlencode(data).encode() if data else None

    req = urllib.request.Request(url, data=encoded, method=method)
    req.add_header("User-Agent", USER_AGENT)
    req.add_header("Authorization", f"bearer {token}")

    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        body = e.read().decode()
        print(f"Error: Reddit API request failed (HTTP {e.code}): {body}", file=sys.stderr)
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Error: Could not reach Reddit API: {e.reason}", file=sys.stderr)
        sys.exit(1)
    except (json.JSONDecodeError, ValueError):
        print("Error: Reddit returned non-JSON response", file=sys.stderr)
        sys.exit(1)


def check_reddit_errors(result, action):
    """Check for Reddit API-level errors (returned as HTTP 200 with errors in body)."""
    if "json" in result:
        errors = result["json"].get("errors", [])
        if errors:
            error_msgs = "; ".join(f"{e[0]}: {e[1]}" for e in errors)
            print(f"Error: {action} failed: {error_msgs}", file=sys.stderr)
            sys.exit(1)


def cmd_post(args):
    """Submit a new Reddit post and write the post ID into the HIP file."""
    fm, _ = read_frontmatter(args.file)
    if fm.get("reddit-post-id"):
        print(
            f"Error: {args.file} already has reddit-post-id: {fm['reddit-post-id']}",
            file=sys.stderr,
        )
        print("Use 'update' to comment on the existing post.", file=sys.stderr)
        sys.exit(1)

    creds = load_credentials()
    token = get_access_token(creds)

    result = api_request(token, "POST", "/api/submit", {
        "sr": args.subreddit,
        "kind": "self",
        "title": args.title,
        "text": args.body,
        "sendreplies": "true",
    })

    check_reddit_errors(result, "Reddit post")

    post_url = None
    post_id = None
    if "json" in result and "data" in result["json"]:
        post_url = result["json"]["data"].get("url")
        post_id = result["json"]["data"].get("name")

    if not post_id:
        print("Error: No post ID returned from Reddit", file=sys.stderr)
        sys.exit(1)

    # Print recovery info before writing, so post ID isn't lost if write fails
    print(f"Reddit post created: {post_id}", file=sys.stderr)

    try:
        write_frontmatter_field(args.file, "reddit-post-id", post_id)
    except Exception as e:
        print(f"Error: Failed to write post ID to {args.file}: {e}", file=sys.stderr)
        print(f"IMPORTANT: Manually add 'reddit-post-id: {post_id}' to {args.file} frontmatter", file=sys.stderr)
        sys.exit(1)

    output = {"success": True, "post_id": post_id}
    if post_url:
        output["url"] = post_url
    print(json.dumps(output))


def cmd_update(args):
    """Add a comment to the existing Reddit post for this HIP."""
    fm, _ = read_frontmatter(args.file)
    post_id = fm.get("reddit-post-id")
    if not post_id:
        print(f"Error: No reddit-post-id in {args.file}", file=sys.stderr)
        print("Use 'post' first to create the initial announcement.", file=sys.stderr)
        sys.exit(1)

    if not post_id.startswith("t3_"):
        post_id = f"t3_{post_id}"

    creds = load_credentials()
    token = get_access_token(creds)

    result = api_request(token, "POST", "/api/comment", {
        "thing_id": post_id,
        "text": args.body,
    })

    check_reddit_errors(result, "Reddit comment")

    output = {"success": True, "parent_post_id": post_id}
    if "json" in result and "data" in result["json"]:
        things = result["json"]["data"].get("things", [])
        if things:
            output["comment_id"] = things[0].get("data", {}).get("name")

    print(json.dumps(output))


def cmd_lookup(args):
    """Look up the Reddit post ID from the HIP file frontmatter."""
    fm, _ = read_frontmatter(args.file)
    post_id = fm.get("reddit-post-id")
    if not post_id:
        print(json.dumps({"found": False}))
    else:
        print(json.dumps({"found": True, "post_id": post_id}))


def main():
    parser = argparse.ArgumentParser(description="Post HIPs to Reddit")
    sub = parser.add_subparsers(dest="command", required=True)

    p_post = sub.add_parser("post", help="Create initial HIP announcement")
    p_post.add_argument("--file", required=True, help="Path to HIP .md file")
    p_post.add_argument("--title", required=True)
    p_post.add_argument("--body", required=True)
    p_post.add_argument("--subreddit", default="HeliumNetwork")

    p_update = sub.add_parser("update", help="Comment on existing HIP post")
    p_update.add_argument("--file", required=True, help="Path to HIP .md file")
    p_update.add_argument("--body", required=True)

    p_lookup = sub.add_parser("lookup", help="Look up tracked post for a HIP")
    p_lookup.add_argument("--file", required=True, help="Path to HIP .md file")

    args = parser.parse_args()

    if args.command == "post":
        cmd_post(args)
    elif args.command == "update":
        cmd_update(args)
    elif args.command == "lookup":
        cmd_lookup(args)


if __name__ == "__main__":
    main()
