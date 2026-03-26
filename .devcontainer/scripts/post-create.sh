#!/usr/bin/env bash
# post-create.sh – runs once after the container is created.
# All tools (docker, docker compose, gh) are already installed via devcontainer
# features, so this script is used only for lightweight environment validation.

set -euo pipefail

echo "==> Validating tool availability..."

# Docker daemon
docker info --format '{{.ServerVersion}}' \
  && echo "  ✔ Docker $(docker --version | awk '{print $3}' | tr -d ',')" \
  || { echo "  ✗ Docker daemon not reachable"; exit 1; }

# Docker Compose V2 (plugin – 'docker compose', not 'docker-compose')
docker compose version \
  && echo "  ✔ Docker Compose V2 available" \
  || { echo "  ✗ docker compose plugin not found"; exit 1; }

# GitHub CLI
gh --version \
  && echo "  ✔ GitHub CLI available" \
  || { echo "  ✗ gh not found"; exit 1; }

echo ""
echo "==> Environment ready. Happy coding! 🚀"
