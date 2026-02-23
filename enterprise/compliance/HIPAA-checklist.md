# HIPAA Compliance Checklist — Claude Code Workflows
# Claude for Healthcare (Jan 11 2026 connector update)
# Applies to: Any Claude Code workflow handling Protected Health Information (PHI)

---

> **Who needs this:** Any team using Claude Code to process patient records, clinical notes, lab results, medical images, insurance data, or any information that could be linked to an individual's health.

---

## What HIPAA Requires for AI-Assisted Workflows

Under HIPAA (Health Insurance Portability and Accountability Act), any AI tool handling PHI must:
1. Have a Business Associate Agreement (BAA) with the AI provider.
2. Implement Technical Safeguards for access, audit, and integrity controls.
3. Maintain audit logs for a minimum of **6 years**.
4. Conduct annual Risk Assessments.

**Anthropic Status (Jan 2026):** Anthropic offers BAA coverage for Enterprise customers. Confirm with your Anthropic account manager before processing any PHI.

---

## Pre-Workflow Checklist (Run before every session touching PHI)

- [ ] BAA with Anthropic is signed and on file (Legal has confirmed)
- [ ] This workflow is using MCP for data access — NOT the Claude Code sidebar directly
- [ ] PHI data is stored in a HIPAA-compliant environment (AWS HealthLake, Google HCLS, or equivalent)
- [ ] Session is being audit-logged per `enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md`
- [ ] Access is restricted to users who have completed HIPAA training this calendar year
- [ ] You are NOT using the free tier or Team plan for this session (requires Enterprise plan with BAA)

---

## In-Session Rules (Non-Negotiable)

1. **Never display** individual patient names, SSNs, dates of birth, MRNs, or addresses in the Claude Code sidebar chat window. Process as aggregate or anonymized data only.
2. **Never paste** raw PHI into a prompt. Route all PHI through an MCP server with field-level encryption.
3. **All outputs** containing clinical information must be reviewed by a qualified clinician before use.
4. **Session recordings:** If Antigravity records your session, disable recording before processing PHI.
5. **De-identification:** Use HIPAA Safe Harbor (18 identifiers removed) or Expert Determination before any data analysis.

---

## Audit Log Requirements for PHI Workflows

Per HIPAA §164.312(b):

| Log Element | Required | Where Stored |
|---|---|---|
| Who accessed PHI | ✅ Yes | MCP audit log |
| What was accessed | ✅ Yes | Session log in `enterprise/metrics/` |
| When (timestamp) | ✅ Yes | MCP audit log |
| What action was taken | ✅ Yes | Audit trail |
| Retention period | 6 years minimum | Immutable log storage |

---

## Incident Response (If PHI Is Accidentally Exposed)

1. **Stop the session immediately.**
2. Notify your HIPAA Privacy Officer within 1 hour.
3. Document: what PHI, which Claude model, how many tokens, session timestamp.
4. Anthropic Enterprise Support: `enterprise@anthropic.com` — notify within 24 hours.
5. Conduct breach risk assessment within 10 business days.

---

## Claude for Healthcare Connectors (Jan 11 2026)

The Jan 2026 Claude for Healthcare update adds native connectors for:
- **Epic EHR:** Claude can query (read-only via MCP) de-identified patient cohorts
- **AWS HealthLake:** Direct MCP integration for clinical NLP workflows
- **FHIR R4:** Structured data exchange format support for clinical summaries

Setup guide: Contact your Anthropic Enterprise account manager for Healthcare connector configuration.
