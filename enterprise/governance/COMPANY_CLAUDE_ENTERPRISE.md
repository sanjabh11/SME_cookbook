# COMPANY_CLAUDE_ENTERPRISE.md — Enterprise Constitution
# Inherits from root COMPANY_CLAUDE.md. Enterprise-only extensions live here.
# Version 2.0 | Feb 2026 | Applies to: 1,000–50,000 user deployments

---

> **Inheritance:** This file EXTENDS (does not replace) root `COMPANY_CLAUDE.md`. All SME rules apply. Enterprise-specific rules below override SME rules only where explicitly stated.

---

## RSP & ASL-3 Alignment (Anthropic Responsible Scaling Policy v2.2, Feb 2026)

**What this means for Claude Code sessions:**
- Codebase vulnerability scans (Claude Code Security preview) require Enterprise or Team plan.
- All security patches produced by Claude Code Security must have human review before merge. Never auto-apply.
- Follow ASL-3 containment standards: no autonomous access to production infrastructure APIs without a dedicated MCP server with audit logging.
- Claude Code in Enterprise must not be used to assist with dual-use biological, chemical, nuclear, or radiological research of any kind.

**The 45-Minute Rule (Feb 18 2026 Autonomy Research):**
- Autonomous sessions must not exceed **45 minutes continuously** without a human checkpoint.
- Target auto-approve rates: **20–40%** (below is too slow, above is too risky).
- Optimal cadence: 3 or fewer human interventions per hour of autonomous work indicates a well-calibrated workflow.
- Sessions exceeding 45 minutes or approval rates above 40% must be logged in `enterprise/metrics/autonomy-dashboard-template.md`.

---

## RBAC Inheritance Structure

All Claude Code sessions must load the applicable role file from `enterprise/rbac/role-templates/`:

| Role | File | Capabilities |
|---|---|---|
| Engineer | `Engineer.md` | Full terminal, ROS2, git, CI/CD |
| Analyst | `Analyst.md` | Data tools, reports, read-only DB via MCP |
| Exec | `Exec.md` | Dashboard summaries, metrics only |
| Designer | `Designer.md` | Figma-to-code, no infrastructure access |

**How role loading works in Antigravity:**  
At session start, if the user opens a folder under `enterprise/`, they should state their role explicitly:  
> *"I am an Engineer. Load Engineer.md policies."*  
Claude will acknowledge and apply the additional permissions and restrictions for that role.

---

## Audit Logging (Enterprise Mandatory)

- All Claude Code sessions in Enterprise must route through an MCP server with audit logging enabled.
- Logs must capture: session start/end time, prompts sent, files modified, git commits made, and auto-approve rate.
- Audit logs are stored for **90 days minimum** (HIPAA: 6 years).
- Reference audit log schema: `enterprise/compliance/HIPAA-checklist.md` and `SOC2-checklist.md`.

---

## Org-Level Skills Deployment (Dec 18 2025 Feature)

- Enterprise admins use the Anthropic Console to deploy Skills organization-wide.
- Skills deployed at org level override local `.agent/skills/` files.
- See: `enterprise/skills-marketplace/org-deploy-guide.md` for step-by-step admin instructions.
- CI/CD for Skills updates: `.github/workflows/claude-propagate.yml`.

---

## Multi-Agent Orchestration at Scale (Opus 4.6, Feb 2026)

- For workflows requiring 10+ parallel sub-agents, use Claude Opus 4.6 as the orchestrator.
- Specialist agents may use Claude Sonnet 4.5 to reduce cost.
- All agent outputs must be routed through a Validator agent before delivery.
- Escalation rule: If more than 20% of items fail validation in a single batch, stop the run and report.
- See full architecture: `enterprise/multi-agent/agent-teams.md`.

---

## Enterprise Session-End Ritual (Extended)

In addition to the SME ritual (root `COMPANY_CLAUDE.md` Section 8), Enterprise sessions must also:
1. Record session metrics in `enterprise/metrics/autonomy-dashboard-template.md`: session length, auto-approve rate, risk quadrant, interventions.
2. Update the relevant role file's `## Lessons Learned` if any new permission boundary was discovered.
3. For any new tool or MCP integration used: document it in `enterprise/migration/sme-to-enterprise.md` under the `## Tool Inventory` section.

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Enterprise constitution created. RSP v2.2 alignment, RBAC structure, 45-min autonomy rule, audit log requirements | Setup |
