#!/usr/bin/env bash
# Build the "Getting Started with Your Managed Mac" DITA sample to styled HTML5.
#
# Usage (from anywhere):  scripts/build-dita-onboarding.sh
# Requires the DITA Open Toolkit:  brew install dita-ot
#
# Output goes to docs/assets/pdfs/dita/managed-mac-onboarding/out/, which
# MkDocs publishes as static files. The stylesheet lives in scripts/dita-style/
# and is copied into the output folder by the build.
#
# Note: DITA-OT overwrites files but does not delete old ones. If you rename or
# remove a topic, delete the out/ folder by hand before rebuilding.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/docs/assets/pdfs/dita/managed-mac-onboarding"
MAP="$SRC/managed-mac-onboarding.ditamap"
OUT="$SRC/out"
CSS_DIR="$ROOT/scripts/dita-style"

if ! command -v dita >/dev/null 2>&1; then
  echo "Error: dita not found. Install it with: brew install dita-ot" >&2
  exit 1
fi

if [ ! -f "$MAP" ]; then
  echo "Error: DITA map not found: $MAP" >&2
  exit 1
fi

if [ ! -f "$CSS_DIR/portfolio.css" ]; then
  echo "Error: stylesheet not found: $CSS_DIR/portfolio.css" >&2
  exit 1
fi

dita --input="$MAP" --format=html5 --output="$OUT" \
  -Dargs.css=portfolio.css \
  -Dargs.cssroot="$CSS_DIR" \
  -Dargs.copycss=yes

echo "Built: $OUT/index.html"
