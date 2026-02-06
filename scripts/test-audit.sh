#!/bin/bash
# Test Audit Script
# Ensures new components and hooks have corresponding test files
# Uses an exceptions file to grandfather existing untested code

set -e

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPTS_DIR")"
EXCEPTIONS_FILE="$SCRIPTS_DIR/.test-exceptions"

cd "$PROJECT_ROOT"

echo "🧪 Test Coverage Audit"
echo "======================"
echo ""

# Create exceptions file if it doesn't exist
if [ ! -f "$EXCEPTIONS_FILE" ]; then
  echo "# Files that are exempt from test requirements" > "$EXCEPTIONS_FILE"
  echo "# Add one filename per line (without path)" >> "$EXCEPTIONS_FILE"
  echo "# Example: SimpleWrapper.tsx" >> "$EXCEPTIONS_FILE"
fi

# Load exceptions into array
EXCEPTIONS=()
if [ -f "$EXCEPTIONS_FILE" ]; then
  while IFS= read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue  # Skip comments
    [[ -z "$line" ]] && continue        # Skip empty lines
    EXCEPTIONS+=("$line")
  done < "$EXCEPTIONS_FILE"
fi

is_exception() {
  local file="$1"
  for exc in "${EXCEPTIONS[@]}"; do
    [[ "$file" == "$exc" ]] && return 0
  done
  return 1
}

MISSING_COMPONENT_TESTS=()
MISSING_HOOK_TESTS=()
TOTAL_COMPONENTS=0
TOTAL_HOOKS=0
TESTED_COMPONENTS=0
TESTED_HOOKS=0

echo "📊 Scanning for test coverage..."
echo ""

# Check components (adjust directories as needed)
echo "🔎 Checking components..."
while IFS= read -r file; do
  [[ "$file" == *".test.tsx" ]] && continue
  [[ ! -f "$file" ]] && continue
  
  filename=$(basename "$file")
  dir=$(dirname "$file")
  base="${filename%.tsx}"
  
  ((TOTAL_COMPONENTS++))
  
  if [ -f "${dir}/${base}.test.tsx" ]; then
    ((TESTED_COMPONENTS++))
  elif ! is_exception "$filename"; then
    MISSING_COMPONENT_TESTS+=("$file")
  fi
done < <(find src/components -name "*.tsx" -not -name "*.test.tsx")

# Check hooks
echo "🔎 Checking hooks..."
while IFS= read -r file; do
  [[ "$file" == *".test.ts" ]] && continue
  [[ "$file" == *"/types.ts" ]] && continue
  [[ "$file" == *"/index.ts" ]] && continue
  [[ "$file" == *"Types.ts" ]] && continue
  [[ "$file" == *"Constants.ts" ]] && continue
  [[ ! -f "$file" ]] && continue
  
  filename=$(basename "$file")
  dir=$(dirname "$file")
  base="${filename%.ts}"
  
  ((TOTAL_HOOKS++))
  
  if [ -f "${dir}/${base}.test.ts" ]; then
    ((TESTED_HOOKS++))
  elif ! is_exception "$filename"; then
    MISSING_HOOK_TESTS+=("$file")
  fi
done < <(find src/hooks -name "use*.ts" -not -name "*.test.ts")

echo ""
echo "======================"
echo "📋 TEST AUDIT SUMMARY"
echo "======================"
echo ""
echo "Components: $TESTED_COMPONENTS/$TOTAL_COMPONENTS tested"
echo "Hooks: $TESTED_HOOKS/$TOTAL_HOOKS tested"
echo ""

TOTAL_MISSING=$((${#MISSING_COMPONENT_TESTS[@]} + ${#MISSING_HOOK_TESTS[@]}))

if [ $TOTAL_MISSING -eq 0 ]; then
  echo "✅ All non-exempt files have tests!"
  exit 0
fi

echo "⚠️  Missing test files (not in exceptions):"
echo ""

if [ ${#MISSING_COMPONENT_TESTS[@]} -gt 0 ]; then
  echo "Components without tests:"
  for f in "${MISSING_COMPONENT_TESTS[@]}"; do
    echo "  - $f"
  done
  echo ""
fi

if [ ${#MISSING_HOOK_TESTS[@]} -gt 0 ]; then
  echo "Hooks without tests:"
  for f in "${MISSING_HOOK_TESTS[@]}"; do
    echo "  - $f"
  done
  echo ""
fi

echo "❌ $TOTAL_MISSING files missing tests"
echo ""
echo "To fix:"
echo "  1. Add test files for the missing components/hooks, OR"
echo "  2. Add exceptions to: scripts/.test-exceptions"
echo ""
exit 1
