#!/bin/bash
# Org-Level Skills Importer — Anthropic Console Integration
# Feature: Dec 18 2025 | Org-Level Skills Deployment
# Usage: bash enterprise/skills-marketplace/skills-importer.sh
#
# Prerequisites:
#   export ANTHROPIC_API_KEY="your-key-here"      (from Anthropic Console → API Keys)
#   export ANTHROPIC_ORG_ID="your-org-id"          (from Console → Settings → Organization)
#
# This script deploys all Skills in .agent/skills/ to the entire organization
# via the Anthropic Console Admin API so every team member gets them automatically.

set -e

# ── Validate prerequisites ─────────────────────────────────────────────────────
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "ERROR: ANTHROPIC_API_KEY not set. Run: export ANTHROPIC_API_KEY='your-key'"
  exit 1
fi

if [ -z "$ANTHROPIC_ORG_ID" ]; then
  echo "ERROR: ANTHROPIC_ORG_ID not set. Run: export ANTHROPIC_ORG_ID='your-org-id'"
  exit 1
fi

SKILLS_DIR=".agent/skills"
API_BASE="https://api.anthropic.com/v1/organizations/${ANTHROPIC_ORG_ID}/skills"

echo "============================================"
echo "  Anthropic Org Skills Deployer v2.0"
echo "  Deploying org-wide skills from: $SKILLS_DIR"
echo "============================================"
echo ""

# ── Deploy each skill ──────────────────────────────────────────────────────────
DEPLOYED=0
FAILED=0

for skill_file in "$SKILLS_DIR"/*.md; do
  if [ ! -f "$skill_file" ]; then
    continue
  fi

  SKILL_NAME=$(grep "^name:" "$skill_file" | head -1 | sed 's/name:\s*//')
  SKILL_CONTENT=$(cat "$skill_file")

  echo "▶ Deploying: $SKILL_NAME (from $skill_file)"

  RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_BASE" \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
      \"name\": \"$SKILL_NAME\",
      \"content\": $(echo "$SKILL_CONTENT" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),
      \"scope\": \"organization\",
      \"auto_update\": true
    }")

  HTTP_CODE=$(echo "$RESPONSE" | tail -1)

  if [ "$HTTP_CODE" -eq 200 ] || [ "$HTTP_CODE" -eq 201 ]; then
    echo "  ✅ Deployed successfully (HTTP $HTTP_CODE)"
    DEPLOYED=$((DEPLOYED+1))
  else
    echo "  ❌ Failed (HTTP $HTTP_CODE) — check API key and org ID"
    FAILED=$((FAILED+1))
  fi
  echo ""
done

# ── Summary ────────────────────────────────────────────────────────────────────
echo "============================================"
echo "  DEPLOYMENT COMPLETE"
echo "  ✅ Deployed: $DEPLOYED skills"
echo "  ❌ Failed:   $FAILED skills"
echo "============================================"

if [ $FAILED -gt 0 ]; then
  echo "Check Anthropic Console → Admin → Skills for deployment status."
  exit 1
fi
