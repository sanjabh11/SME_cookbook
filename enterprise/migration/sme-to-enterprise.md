# SME → Enterprise Migration Guide
# From: 100-person SME Cookbook | To: 50,000-user enterprise deployment

---

## When to Migrate from SME to Enterprise Mode

You are ready to move from the SME configuration to Enterprise when any of the following apply:
- Team has grown beyond 500 users
- You now have SOC 2 or HIPAA compliance requirements
- You need centralized policy management across 10+ repositories
- Multiple departments need different RBAC roles
- Autonomous session lengths regularly exceed 30 minutes

---

## Migration Phases

### Phase 1: Audit (1 day)

Run this prompt in Claude Code:
> *"Audit this cookbook for any SME-specific assumptions that need to change for enterprise use. List each CLAUDE.md file, identify hardcoded team names or org-specific rules, and output a migration task list."*

Expected output: A table of ~20 items, each with: `File | SME Assumption | Enterprise Change Required`

---

### Phase 2: Enable Enterprise Features (2–4 hours)

```bash
# 1. Upgrade Anthropic plan to Enterprise (via Console)
# 2. Sign BAA (if handling PHI)
# 3. Configure MCP audit logging
# 4. Set up RBAC in Anthropic Console (assign roles per department)
# 5. Deploy org-level Skills:
chmod +x enterprise/skills-marketplace/skills-importer.sh
export ANTHROPIC_API_KEY="your-key"
export ANTHROPIC_ORG_ID="your-org-id"
bash enterprise/skills-marketplace/skills-importer.sh
```

---

### Phase 3: Update COMPANY_CLAUDE.md (1 hour)

Add enterprise constitution pointer (already done if using this cookbook):
```
Enterprise users: see enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md for RSP/ASL-3 extensions.
```

Load the applicable RBAC role file for each session:
```
I am an [Engineer/Analyst/Exec/Designer]. Load [role].md policies.
```

---

### Phase 4: Set Up Monorepo Propagation (2 hours)

1. Enable GitHub Actions in Settings → Actions → Allow all actions
2. Add `POLICY_PROPAGATION_PAT` to repository Secrets (Settings → Secrets → New)
3. Add your target repos to `.github/workflows/claude-propagate.yml`
4. Trigger manually: `gh workflow run claude-propagate.yml`
5. Verify: check one target repo's git log for the propagation commit

---

### Phase 5: Launch Champion Program (Week 1)

1. Identify 1 champion per department (see `enterprise/onboarding/champion-program.md`)
2. Schedule Hour 1 training for all champions this week
3. Deliver Hour 2 + Hour 3 over the following 7 days
4. First weekly "Usage Share" session at Day 10

---

## Tool Inventory (Track New Tools as You Adopt Them)

| Tool | Purpose | Date Added | Trained Users |
|---|---|---|---|
| Claude Code (Antigravity) | Core AI assistant | Initial setup | All teams |
| MCP Audit Logger | Session compliance logging | Pending | TBD |
| Anthropic Console | Admin + RBAC management | Pending | Admin only |
| Cowork (Slack) | Non-tech quick queries | Pending | Non-tech teams |
| Claude Code Security | Full codebase vuln scanning | Pending | Engineering |
| CodePath Learning Portal | Skills development | Pending | All technical |

---

## Enterprise Quota Calculator

Estimate your Anthropic plan costs before committing:

```
Engineers (technical users): [N] × $[rate]/user/month (Premium seats)
Analysts + Non-tech: [M] × $[rate]/user/month (Base Team seats)
Monthly API budget (for agent runs): estimate [X tokens/run × Y runs/month]

Rule of thumb: 50-person SME typically spends $500–$1,500/month.
100-person SME with enterprise features: $2,000–$5,000/month.
Coverage: ROI typically 5–15× spend within 60 days.
```

Contact your Anthropic account manager for volume pricing beyond 50 seats.
