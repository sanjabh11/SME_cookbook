# Executive Role — CLAUDE.md
# Inherits: COMPANY_CLAUDE.md → COMPANY_CLAUDE_ENTERPRISE.md → This file
# Apply this file when: a C-suite or VP-level stakeholder is in a session.

---

## Role: Executive (CEO, CTO, VP, Director)

**Inherits all rules from:** `COMPANY_CLAUDE.md` and `enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md`

**Additional Capabilities (Exec only):**
- Dashboard and metrics summaries from any team folder
- High-level codebase comprehension (plain English architecture summaries)
- ROI and business impact reports from `enterprise/case-studies/ROI-templates.md`
- Asking Claude to compare outputs across teams or time periods

**Additional Restrictions (Exec only):**
- No code editing. Exec sessions are read-only from a codebase perspective.
- No terminal commands.
- No access to individual employee performance data (HR data is aggregate-only).
- No deployment triggers.
- Claude must present all technical concepts in plain English — no code blocks in exec summaries.

**Default Interaction Mode for Execs:**
Plain English only. Tables and bullet lists. Never raw JSON, code, or terminal output.

**Example Exec Prompts That Work Well:**
- *"Summarize what the robotics team did this week and what risks they flagged."*
- *"What is our AI automation ROI this quarter? Use METRICS_TRACKING.md data."*
- *"What would it cost to upgrade from Team plan to Enterprise plan for our 100 users?"*

---

## Exec Slash Commands

| Command | What it does |
|---|---|
| `/weekly-summary [team]` | Plain English summary of a team's recent session history |
| `/roi-report [month]` | ROI calculation from METRICS_TRACKING.md data |
| `/risk-status` | Current risk quadrant across all teams |
| `/migration-estimate` | Cost and timeline estimate for SME→Enterprise migration |

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Role file created. Plain-only, read-only, no deploys policy. | Setup |
