#!/bin/bash
# Documentation Audit Script
# Verifies every source file is documented and no ghost references exist
# Exit code 0 = all checks pass, 1 = gaps found

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

ERRORS=0
WARNINGS=0

echo "🔍 Documentation Audit"
echo "======================"
echo ""

# ============================================================================
# PHASE 1: Count actuals
# ============================================================================
echo "📊 Counting actual source files..."

ACTUAL_COMPONENTS=$(find src/components -name "*.tsx" -not -name "*.test.tsx" | wc -l | tr -d ' ')
ACTUAL_HOOKS=$(find src/hooks -name "use*.ts" -not -name "*.test.ts" | wc -l | tr -d ' ')

echo "  Components: $ACTUAL_COMPONENTS"
echo "  Hooks: $ACTUAL_HOOKS"
echo ""

# ============================================================================
# PHASE 2: Check for undocumented components
# ============================================================================
echo "🔎 Checking for undocumented components..."

UNDOC_COMPONENTS=()
while IFS= read -r file; do
  comp=$(basename "$file")
  if ! grep -q "$comp" docs/FRONTEND.md 2>/dev/null; then
    UNDOC_COMPONENTS+=("$comp")
  fi
done < <(find src/components -name "*.tsx" -not -name "*.test.tsx")

if [ ${#UNDOC_COMPONENTS[@]} -gt 0 ]; then
  echo -e "  ${RED}✗ ${#UNDOC_COMPONENTS[@]} components not in FRONTEND.md${NC}"
  ERRORS=$((ERRORS + ${#UNDOC_COMPONENTS[@]}))
  if [ "${VERBOSE:-0}" = "1" ]; then
    for comp in "${UNDOC_COMPONENTS[@]}"; do
      echo "    - $comp"
    done
  fi
else
  echo -e "  ${GREEN}✓ All components documented${NC}"
fi

# ============================================================================
# PHASE 3: Check for undocumented hooks
# ============================================================================
echo "🔎 Checking for undocumented hooks..."

UNDOC_HOOKS=()
while IFS= read -r file; do
  hook=$(basename "$file" .ts)
  if ! grep -q "$hook" docs/FRONTEND.md 2>/dev/null; then
    UNDOC_HOOKS+=("$hook")
  fi
done < <(find src/hooks -name "use*.ts" -not -name "*.test.ts")

if [ ${#UNDOC_HOOKS[@]} -gt 0 ]; then
  echo -e "  ${RED}✗ ${#UNDOC_HOOKS[@]} hooks not in FRONTEND.md${NC}"
  ERRORS=$((ERRORS + ${#UNDOC_HOOKS[@]}))
  if [ "${VERBOSE:-0}" = "1" ]; then
    for hook in "${UNDOC_HOOKS[@]}"; do
      echo "    - $hook"
    done
  fi
else
  echo -e "  ${GREEN}✓ All hooks documented${NC}"
fi

# ============================================================================
# PHASE 4: Check for ghost components (documented but don't exist)
# ============================================================================
echo "🔎 Checking for ghost references in FRONTEND.md..."

GHOST_COMPONENTS=()
while IFS= read -r comp; do
  # Skip common false positives
  if [[ "$comp" == "App.tsx" ]] || [[ "$comp" == "index.tsx" ]] || [[ "$comp" == "Utils.tsx" ]]; then
    continue
  fi
  if ! find src/components -name "$comp" 2>/dev/null | grep -q .; then
    if ! find src -name "$comp" 2>/dev/null | grep -q .; then
      if ! find src -name "*$comp" 2>/dev/null | grep -q .; then
        GHOST_COMPONENTS+=("$comp")
      fi
    fi
  fi
done < <(grep -oE "[A-Z][a-zA-Z]+\.tsx" docs/FRONTEND.md 2>/dev/null | sort -u || true)

if [ ${#GHOST_COMPONENTS[@]} -gt 0 ]; then
  echo -e "  ${RED}✗ ${#GHOST_COMPONENTS[@]} ghost components (documented but don't exist)${NC}"
  ERRORS=$((ERRORS + ${#GHOST_COMPONENTS[@]}))
  if [ "${VERBOSE:-0}" = "1" ]; then
    for comp in "${GHOST_COMPONENTS[@]}"; do
      echo "    - $comp"
    done
  fi
else
  echo -e "  ${GREEN}✓ No ghost component references${NC}"
fi

# ============================================================================
# PHASE 5: Check for ghost hooks
# ============================================================================
echo "🔎 Checking for ghost hook references..."

GHOST_HOOKS=()
while IFS= read -r hook; do
  if ! find src/hooks -name "${hook}.ts" 2>/dev/null | grep -q .; then
    if ! find src/components -name "${hook}.ts" 2>/dev/null | grep -q .; then
      GHOST_HOOKS+=("$hook")
    fi
  fi
done < <(grep -oE "use[A-Z][a-zA-Z]+\.ts" docs/FRONTEND.md 2>/dev/null | sed 's/\.ts$//' | sort -u || true)

if [ ${#GHOST_HOOKS[@]} -gt 0 ]; then
  echo -e "  ${RED}✗ ${#GHOST_HOOKS[@]} ghost hooks (documented but don't exist)${NC}"
  ERRORS=$((ERRORS + ${#GHOST_HOOKS[@]}))
  if [ "${VERBOSE:-0}" = "1" ]; then
    for hook in "${GHOST_HOOKS[@]}"; do
      echo "    - $hook"
    done
  fi
else
  echo -e "  ${GREEN}✓ No ghost hook references${NC}"
fi

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo "======================"
echo "📋 AUDIT SUMMARY"
echo "======================"
echo ""

if [ $ERRORS -eq 0 ]; then
  echo -e "${GREEN}✅ ALL CHECKS PASSED - Documentation is accurate!${NC}"
  exit 0
else
  echo -e "${RED}❌ $ERRORS TOTAL GAPS FOUND${NC}"
  echo ""
  echo "Run with VERBOSE=1 for details:"
  echo "  VERBOSE=1 ./scripts/docs-audit.sh"
  exit 1
fi
