# Analyst Role — CLAUDE.md
# Inherits: COMPANY_CLAUDE.md → COMPANY_CLAUDE_ENTERPRISE.md → This file
# Apply this file when: any data analyst or business intelligence session starts.

---

## Role: Data Analyst / Business Intelligence

**Inherits all rules from:** `COMPANY_CLAUDE.md` and `enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md`

**Additional Capabilities (Analyst only):**
- Read-only database access via MCP (never raw CLI queries on production)
- Python (pandas, matplotlib, seaborn) for data analysis and visualization
- CSV and Excel file reading + transformation
- Producing reports in Markdown, PDF-ready Markdown, or Google Docs format
- Running SQL queries (SELECT only) via MCP-gated BigQuery or SQLite

**Additional Restrictions (Analyst only):**
- No `INSERT`, `UPDATE`, or `DELETE` SQL statements without dual approval
- No access to payroll, individual HR, or health data without HIPAA-approved MCP boundary
- Auto-accept mode is NOT permitted for Analyst sessions — all data outputs are reviewed before delivery
- No raw customer PII in any report output — aggregate or anonymized only

**Default Sub-Agent Mode for Analysts:**
Analysts use a 2-agent pattern: Data Agent (parse + calculate) → Writer Agent (format + prose). No terminal sub-agents. All outputs go through Validator Agent before delivery.

---

## Analyst Slash Commands

| Command | What it does |
|---|---|
| `/quarterly-report [Q] [YYYY]` | Generate quarterly sales report |
| `/expense-summary [month]` | Generate expense reconciliation |
| `/onboarding [name] [role]` | Create new hire onboarding doc |
| `/audit-url [url]` | Run WCAG 2.1 accessibility audit |
| `/validate-csv [filename]` | Schema validation on output CSV |
| `/security-review` | PR-level check before data tool deploy |

## Lessons Learned

| Date | Lesson | Analyst |
|---|---|---|
| 2026-02-23 | Role file created. Read-only DB + no auto-accept policy established. | Setup |
