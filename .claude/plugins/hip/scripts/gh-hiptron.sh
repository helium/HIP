#!/bin/bash
# Run gh CLI commands as the hiptron GitHub user.
# Parses the token from ~/.config/hrp/github.env and passes it via GH_TOKEN.

set -euo pipefail

ENV_FILE="$HOME/.config/hrp/github.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Error: $ENV_FILE not found." >&2
  echo "" >&2
  echo "Setup:" >&2
  echo "  1. Log in to GitHub as hiptron" >&2
  echo "  2. Settings > Developer settings > Personal access tokens > Tokens (classic)" >&2
  echo "  3. Create a token with scopes: repo, gist (no expiration)" >&2
  echo "  4. Create $ENV_FILE with:" >&2
  echo "     HIPTRON_GITHUB_TOKEN=ghp_xxxxx" >&2
  exit 1
fi

# Parse the token value directly instead of sourcing the file as code
HIPTRON_GITHUB_TOKEN=$(grep -m1 '^HIPTRON_GITHUB_TOKEN=' "$ENV_FILE" | cut -d'=' -f2-)

if [ -z "$HIPTRON_GITHUB_TOKEN" ]; then
  echo "Error: HIPTRON_GITHUB_TOKEN not set in $ENV_FILE" >&2
  exit 1
fi

unset GH_DEBUG
GH_TOKEN="$HIPTRON_GITHUB_TOKEN" exec gh "$@"
