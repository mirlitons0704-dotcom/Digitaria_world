#!/bin/bash
# File Size Audit - identifies files exceeding 400 lines
# Logs oversized files for post-push refactoring prompt

set -euo pipefail

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

MAX_LINES=400

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
OVERSIZED_FILE="$PROJECT_ROOT/.oversized-files"

cd "$PROJECT_ROOT"

# Get files changed in this push (compared to remote)
REMOTE_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "origin/main")
CHANGED_FILES=$(git diff --name-only "$REMOTE_BRANCH" HEAD -- '*.ts' '*.tsx' '*.js' '*.jsx' 2>/dev/null || true)

# Clear previous oversized file list
> "$OVERSIZED_FILE"

OVERSIZED_COUNT=0

echo "📏 Checking file sizes (max $MAX_LINES lines)..."

for file in $CHANGED_FILES; do
  [ ! -f "$file" ] && continue
  [[ "$file" == *.test.* ]] && continue
  [[ "$file" == *.spec.* ]] && continue
  
  LINE_COUNT=$(wc -l < "$file" | tr -d ' ')
  
  if [ "$LINE_COUNT" -gt "$MAX_LINES" ]; then
    echo "$file:$LINE_COUNT" >> "$OVERSIZED_FILE"
    echo -e "  ${YELLOW}⚠️  $file: $LINE_COUNT lines (exceeds $MAX_LINES)${NC}"
    ((OVERSIZED_COUNT++))
  fi
done

if [ "$OVERSIZED_COUNT" -gt 0 ]; then
  echo ""
  echo -e "${YELLOW}⚠️  $OVERSIZED_COUNT file(s) exceed $MAX_LINES lines${NC}"
  echo "These files have been logged to .oversized-files"
  echo "Consider refactoring after push to maintain modularity."
else
  echo -e "  ${GREEN}✓ All changed files under $MAX_LINES lines${NC}"
fi

# Always exit 0 - this is advisory, not blocking
exit 0
