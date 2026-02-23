# Org-Level Skills Deployment Guide
# Feature: Dec 18 2025 | Anthropic Console Admin API

---

## What This Does

This guide walks an **Anthropic Console admin** through deploying Claude Code Skills to every user in the organization automatically — so no developer needs to copy `/.agent/skills/` files manually.

**Why it matters:** Without org-level deployment, every new employee has to manually copy skill files. With org-level deployment, skills appear automatically in every engineer's Claude Code sidebar within minutes.

---

## Prerequisites

- You must be an **Organization Admin** in the Anthropic Console
- Your org must be on **Team or Enterprise plan**
- `ANTHROPIC_API_KEY` and `ANTHROPIC_ORG_ID` must be available

Find your Org ID: `Console → Settings → Organization → Organization ID`

---

## Step 1: Run the Importer Script

```bash
# Set your credentials
export ANTHROPIC_API_KEY="sk-ant-..."
export ANTHROPIC_ORG_ID="org-..."

# Make executable and run
chmod +x enterprise/skills-marketplace/skills-importer.sh
bash enterprise/skills-marketplace/skills-importer.sh
```

Expected output: `✅ Deployed: 3 skills` (slot-machine, security-review, sub-agent-spawner)

---

## Step 2: Verify in Admin Console

1. Go to `console.anthropic.com`
2. Navigate to `Admin → Skills Marketplace`
3. Confirm all 3 skills show status: `Deployed (Organization-wide)`
4. Auto-update is enabled by default — future updates to `.agent/skills/*.md` files will propagate via the CI/CD pipeline

---

## Step 3: Enable Automatic Updates (CI/CD)

After first deployment, use `.github/workflows/claude-propagate.yml` to automatically re-deploy whenever skills are updated in the main branch.

See: `enterprise/monorepo/gitops-propagation.md` for full monorepo propagation setup.

---

## Compatibility

| Platform | Status |
|---|---|
| Google Antigravity + Claude Code | ✅ Fully compatible |
| Claude Code CLI | ✅ Fully compatible |
| Cowork (Slack/Google Chat) | ⚠️ Partial — text-only skills only |

---

## Rollback

To remove a skill from the org:

```bash
curl -X DELETE "https://api.anthropic.com/v1/organizations/$ANTHROPIC_ORG_ID/skills/$SKILL_ID" \
  -H "x-api-key: $ANTHROPIC_API_KEY"
```

Find `$SKILL_ID` in `Console → Admin → Skills → [Skill Name] → ID`.
