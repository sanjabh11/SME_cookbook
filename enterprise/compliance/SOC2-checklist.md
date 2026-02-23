# SOC 2 Type II Compliance Checklist — Claude Code Workflows
# Applies to: Enterprise deployments where customers require SOC 2 evidence

---

## The 5 Trust Service Criteria (TSC) for Claude Code

SOC 2 evaluates your AI workflow controls against 5 Trust Service Criteria. Below is how our cookbook maps to each.

---

### TSC 1: Security (CC6–CC9)

Controls in place via the cookbook:

| Control | Implementation | Evidence Location |
|---|---|---|
| Access control | RBAC role files + MCP gating | `enterprise/rbac/role-templates/` |
| Vulnerability scanning | Claude Code Security + /security-review | `enterprise/security-scanning/` |
| Change management | Git commits + PR review policy | `.github/workflows/claude-lint.yml` |
| Incident response | Escalation rules in security checklist | `cross-team/security-review/CLAUDE.md` |

**Evidence for auditor:** Export `CHANGELOG.md` (shows all policy changes with dates) + git history + session audit logs.

---

### TSC 2: Availability (A1)

- [ ] Service uptime monitoring is configured for any API endpoints Claude Code integrates with
- [ ] MCP servers have health check endpoints
- [ ] Fallback documented: if Claude API is unavailable, workflow reverts to manual process
- [ ] No single-point-of-failure in the AI workflow (human can override at every step)

---

### TSC 3: Processing Integrity (PI1)

- [ ] All Claude Code outputs validated by Validator Agent before delivery (Section 5 of each CLAUDE.md)
- [ ] Schema validation enforced for all CSV and JSON outputs
- [ ] Business logic rules are documented in CLAUDE.md files (auditor can read them)
- [ ] No automated decisions affect customers without a human review step
- [ ] Test data is clearly labeled and used exclusively in non-production environments

---

### TSC 4: Confidentiality (C1–C2)

- [ ] No customer PII in any CLAUDE.md file, sample data, or CHANGELOG entry
- [ ] All `sample_*.csv` files contain fabricated data only (verified by `.gitignore` rules)
- [ ] MCP boundaries enforce data classification: Green safe, Yellow controlled, Red MCP-only
- [ ] API keys and credentials excluded from all commits (enforced by `.gitignore` and `claude-lint.yml`)
- [ ] Data retention policy defined and enforced

---

### TSC 5: Privacy (P1–P8)

- [ ] Privacy notice exists informing users that Claude processes their prompts (Anthropic's ToS)
- [ ] Users can request session log deletion (contact Anthropic Enterprise support)
- [ ] No training on customer data: Anthropic Enterprise confirms opt-out from model training
- [ ] Data residency requirements documented (relevant for EU customers, GDPR overlap)

---

## Evidence Package for SOC 2 Auditor

Provide the following to your auditor:
1. This Cookbook repository (shows documented controls)
2. `CHANGELOG.md` (change management evidence)
3. `.github/workflows/claude-lint.yml` (automated policy enforcement)
4. `enterprise/metrics/autonomy-dashboard-template.md` (monitoring and review evidence)
5. Session audit logs from MCP server (access and activity logs)
6. Signed BAA with Anthropic (if applicable)
7. Screenshots of Anthropic Console RBAC configuration

---

## Annual Review Items

| Item | Frequency | Owner |
|---|---|---|
| Review RBAC role templates for accuracy | Annual | Security Lead |
| Verify MCP audit log retention | Annual | Engineering Lead |
| Update this checklist with new TSC guidance | Annual | Compliance Officer |
| Review all CLAUDE.md files for policy drift | Quarterly | AI Champions |
