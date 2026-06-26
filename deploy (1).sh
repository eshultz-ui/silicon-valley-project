#!/usr/bin/env bash
# One-shot deploy of the route optimizer to GitHub Pages.
# Prereqs: GitHub CLI installed (https://cli.github.com) and `gh auth login` done once.
# Run this from the folder that contains index.html (and README.md).
set -e

REPO_NAME="${1:-crew-route-optimizer}"   # pass a name as the first argument, or use the default

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) not found. Install it from https://cli.github.com then run: gh auth login"
  exit 1
fi
if [ ! -f index.html ]; then
  echo "index.html not found in this folder. cd into the folder that has index.html and re-run."
  exit 1
fi

echo "Creating repo '$REPO_NAME' and pushing files..."
git init -q
git add index.html README.md 2>/dev/null || git add index.html
git commit -q -m "Crew route optimizer" || true
git branch -M main

# Create the repo on your account and push (public, so Pages is free)
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

OWNER="$(gh api user --jq .login)"

echo "Enabling GitHub Pages..."
gh api -X POST "repos/$OWNER/$REPO_NAME/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || \
  echo "(If Pages didn't auto-enable, turn it on in Settings -> Pages -> Branch: main /root.)"

echo ""
echo "Done. Your site will be live in ~1 minute at:"
echo "   https://$OWNER.github.io/$REPO_NAME/"
