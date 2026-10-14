#!/usr/bin/env bash
#
# Rebuild the Reading List API documentation.
#
# Lints the OpenAPI spec, regenerates the HTML reference from it, then builds
# the MkDocs site. Stops at the first failure.
#
# Run from anywhere:   ./scripts/build-reading-list-api.sh
# Requires:            Node.js (for npx) and MkDocs
#
# Add --strict to the mkdocs line if you want broken links to fail the build.

set -euo pipefail

# Run from the repository root, whatever directory the script was called from.
cd "$(dirname "$0")/.."

REDOCLY_VERSION="2.63.0"
SPEC="docs/projects/reading-list-api/reading-list-api.yaml"
REFERENCE="docs/projects/reading-list-api/api-reference.html"

echo "==> Linting $SPEC"
npx --yes "@redocly/cli@${REDOCLY_VERSION}" lint "$SPEC"

echo "==> Generating $REFERENCE"
npx --yes "@redocly/cli@${REDOCLY_VERSION}" build-docs "$SPEC" \
  --title "Reading List API Reference" \
  --output "$REFERENCE"

echo "==> Building the MkDocs site"
mkdocs build

echo "Done. Preview with: mkdocs serve"
