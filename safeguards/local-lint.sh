#!/bin/bash
# Local Lint Script — Validate CLAUDE.md and YAML files before committing
# Run from repo root: bash safeguards/local-lint.sh
# Exit code 0 = all checks passed. Non-zero = failures detected.

set -e  # Stop on first error
ERRORS=0
WARNINGS=0

echo "============================================"
echo "  Claude Code Cookbook Local Linter v2.1   "
echo "============================================"

# ── Check 1: Validate all YAML files ──────────────────────────────────────────
echo ""
echo "▶ Checking YAML files..."
YAML_FILES=$(find . -name "*.yml" -o -name "*.yaml" | grep -v ".git" | grep -v "node_modules")
for f in $YAML_FILES; do
  if python3 -c "import yaml; yaml.safe_load(open('$f'))" 2>/dev/null; then
    echo "  ✅ $f"
  else
    echo "  ❌ YAML ERROR: $f — run 'python3 -c \"import yaml; yaml.safe_load(open('$f'))\"' to debug"
    ERRORS=$((ERRORS+1))
  fi
done

# ── Check 2: Validate Skills YAML frontmatter ──────────────────────────────────
echo ""
echo "▶ Checking .agent/skills/ YAML frontmatter..."
SKILL_FILES=$(find .agent/skills -name "*.md" 2>/dev/null)
for f in $SKILL_FILES; do
  if head -1 "$f" | grep -q "^---"; then
    echo "  ✅ $f has YAML frontmatter"
  else
    echo "  ⚠️  WARNING: $f missing YAML frontmatter (--- block)"
    WARNINGS=$((WARNINGS+1))
  fi
done

# ── Check 3: No unfilled {{PLACEHOLDER}} tokens in non-template files ─────────
echo ""
echo "▶ Checking for unfilled {{PLACEHOLDER}} tokens..."
UNFILLED=$(grep -r "{{" --include="*.md" --include="*.sh" --include="*.yml" \
  --exclude-dir=templates \
  --exclude-dir=".git" . 2>/dev/null | grep -v "^Binary" || true)
if [ -z "$UNFILLED" ]; then
  echo "  ✅ No unfilled placeholders found outside templates/"
else
  echo "  ❌ Unfilled placeholders detected:"
  echo "$UNFILLED"
  ERRORS=$((ERRORS+1))
fi

# ── Check 4: Verify scripts are executable ────────────────────────────────────
echo ""
echo "▶ Checking shell scripts are executable..."
SHELL_FILES=$(find . -name "*.sh" | grep -v ".git")
for f in $SHELL_FILES; do
  if [ -x "$f" ]; then
    echo "  ✅ $f is executable"
  else
    echo "  ⚠️  WARNING: $f is not executable — run: chmod +x $f"
    WARNINGS=$((WARNINGS+1))
  fi
done

# ── Check 5: Key files exist ──────────────────────────────────────────────────
echo ""
echo "▶ Checking required files exist..."
REQUIRED_FILES=(
  "COMPANY_CLAUDE.md"
  "README.md"
  "ONBOARDING.md"
  "CHANGELOG.md"
  ".gitignore"
  "templates/CLAUDE.md.example"
  "safeguards/glossary.md"
  "safeguards/manual-review-checklist.md"
)
for f in "${REQUIRED_FILES[@]}"; do
  if [ -f "$f" ]; then
    echo "  ✅ $f exists"
  else
    echo "  ❌ MISSING: $f"
    ERRORS=$((ERRORS+1))
  fi
done

# ── Final Report ──────────────────────────────────────────────────────────────
echo ""
echo "============================================"
echo "  LINT COMPLETE"
echo "  Errors:   $ERRORS"
echo "  Warnings: $WARNINGS"
echo "============================================"

if [ $ERRORS -gt 0 ]; then
  echo "❌ Fix all errors above before committing."
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "⚠️  Warnings present but not blocking. Review and commit when ready."
  exit 0
else
  echo "✅ All checks passed. Safe to commit."
  exit 0
fi
