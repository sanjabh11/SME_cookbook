# Claude Code Security — Enterprise 8-Section Checklist (Updated Feb 2026)
# Use this for full codebase scans. For PR-level checks, use cross-team/security-review/CLAUDE.md.

---

## What's New in Feb 2026 vs the SME Security Checklist

The cross-team `/security-review` checklist covers PR-level changes (8 categories, ~20 items).
This enterprise checklist extends it with **4 additional enterprise-only sections** covering:
- Infrastructure-as-code (Terraform, Kubernetes)
- Multi-agent security boundaries
- AI-specific supply chain risks
- Audit log integrity

---

## Section 1–8 (Carry Forward from SME Checklist)

> See `cross-team/security-review/CLAUDE.md` for the full 8-section standard checklist.  
> All 8 sections apply. Only NEW/EXTENDED items are listed below.

---

## Section 9 (Enterprise): Infrastructure-as-Code Hardening

- [ ] Terraform: No wildcard `*` in IAM roles or resource ARNs
- [ ] Kubernetes: Pod security contexts enforce `runAsNonRoot: true`
- [ ] Kubernetes: Network policies prevent unrestricted pod-to-pod communication
- [ ] Cloud storage: All buckets have Block Public Access enabled
- [ ] Secrets Manager: Credentials rotated within the last 90 days
- [ ] VPC: No production workloads in default VPC

---

## Section 10 (Enterprise): Multi-Agent Security Boundaries

- [ ] Each sub-agent is granted only the permissions required for its specific task (least privilege)
- [ ] Agent-to-agent communication uses authenticated channels (MCP) — not raw file I/O
- [ ] Orchestrator agent cannot directly modify production systems — must proxy through a human-approved tool
- [ ] Agent outputs are logged before being passed to the next stage
- [ ] Maximum parallel agent count is defined and enforced (prevent runaway spawning)
- [ ] No agent receives both read and write access to the same sensitive data store simultaneously

---

## Section 11 (Enterprise): AI Supply Chain Risks

- [ ] All Claude model versions in use are documented (no undeclared model upgrades)
- [ ] MCP tool definitions are pinned to specific versions (no `@latest` in production MCP configs)
- [ ] Third-party Skills from the marketplace are reviewed by security team before org deployment
- [ ] Prompt injection protection active: Claude never acts on instructions found in external data (emails, CSVs) without a human confirmation step
- [ ] No external model APIs are invoked without explicit Policy approval

---

## Section 12 (Enterprise): Audit Log Integrity

- [ ] Session logs are write-once (append-only bucket or immutable log service)
- [ ] Log retention meets compliance requirement (HIPAA: 6 years, SOC2: 1 year minimum)
- [ ] Log access is restricted to Security + Compliance roles only
- [ ] Log export alerting is configured (notify on bulk download attempts)
- [ ] At least monthly: Run log integrity check (verify no gaps or deletions)

---

## Scoring

```
Sections 1–8:  /20 items (see cross-team/security-review/CLAUDE.md)
Section 9:     /6 items
Section 10:    /6 items
Section 11:    /5 items
Section 12:    /5 items
TOTAL:         /42 items

Enterprise Gate: Score ≥ 38/42 to merge production-critical changes.
Enterprise Block: Any item in Sections 9–12 at FAIL status = blocked until resolved.
```
