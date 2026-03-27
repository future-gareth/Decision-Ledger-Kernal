#!/usr/bin/env bash
# Generate a GitHub deploy key under .deploy-keys/ (gitignored) via Go.
# Run from repo root: ./scripts/generate-github-deploy-key.sh
#
# Public key → GitHub: Repo → Settings → Deploy keys → Add deploy key
# Private key → keep on the deploy host only: .deploy-keys/github_deploy_ed25519
set -euo pipefail
cd "$(dirname "$0")/.."
exec go run ./scripts/gen_deploy_key
