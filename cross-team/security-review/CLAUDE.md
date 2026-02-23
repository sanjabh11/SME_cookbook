# Security Review — CLAUDE.md
# Version 1.0 | Cookbook-SME-Robotics | Cross-Team

---

## 1. What is `/security-review`?

This folder defines the `/security-review` slash command referenced throughout this cookbook. It provides a standardized security checklist that Claude runs on any pull request or code change before it is merged.

**Referenced by:** `COMPANY_CLAUDE.md` Section 3 — "Run `/security-review` on ALL pull requests."

**Who runs it:** Any engineer before merging a PR, or any Claude Code instance as part of GitHub Actions.

---

## 2. How to Invoke

**Manual (in Claude Code sidebar):**
```
/security-review
```
Then paste the PR diff or say: "Review the changes in [branch_name]"

**Automated (GitHub Actions):** See `technical/code-generation/CLAUDE.md` Workflow C — the PR review bot uses this checklist as its system prompt.

---

## 3. The Security Review Checklist

Claude must evaluate every item below and output a table: `[PASS / FAIL / NOT APPLICABLE / NEEDS MANUAL REVIEW]`

### A. Secrets & Credentials
- [ ] No hardcoded API keys, passwords, tokens, or secrets in any changed file
- [ ] No `.env` files committed or referenced in code (should be in `.gitignore`)
- [ ] No credentials in commit messages or comments
- [ ] Environment variables accessed via `process.env` (JS) or `os.environ` (Python) only

### B. Input Validation & Injection
- [ ] All user-supplied inputs are validated before use
- [ ] No SQL queries built by string concatenation (use parameterized queries or ORM)
- [ ] No `eval()`, `exec()`, or dynamic code execution on user input
- [ ] File paths from user input are sanitized (no `../` traversal)
- [ ] All API inputs have type and length validation

### C. Authentication & Authorization
- [ ] New routes/endpoints have authentication checks
- [ ] Authorization checks verify the calling user owns the resource (not just is logged in)
- [ ] Session tokens are not exposed in URLs or logs
- [ ] No admin functionality accessible without role check

### D. Data Handling
- [ ] No personal/sensitive data logged to console or files
- [ ] Data stored complies with the team's retention policy
- [ ] No real data used in tests — sample/fixture data only
- [ ] Database writes are wrapped in transactions where appropriate

### E. Dependencies
- [ ] No new dependencies with known CVEs (check `npm audit` or `pip-audit`)
- [ ] New dependencies are from reputable sources (not unknown GitHub repos)
- [ ] `package-lock.json` or `requirements.txt` updated and committed

### F. Infrastructure (Terraform / Kubernetes / Config)
- [ ] No overly permissive IAM roles (avoid `*` actions or `*` resources)
- [ ] Security groups / network policies follow least-privilege
- [ ] No publicly exposed storage buckets or databases
- [ ] Configuration changes reviewed for blast radius (what breaks if this is wrong?)

### G. Robotics-Specific (if applicable)
- [ ] No node is given `sudo` or root-level system permissions without justification
- [ ] Physical actuator commands (motor, gripper) have software safety limits
- [ ] Emergency stop logic is not modified without team lead sign-off
- [ ] Simulation-only code is clearly separated from hardware code

### H. General Code Quality (security-relevant)
- [ ] Error messages do not expose internal stack traces to end users
- [ ] Logging does not include PII (names, emails, IP addresses where not required)
- [ ] Rate limiting is in place for any public or user-facing API endpoint
- [ ] No TODO/FIXME comments that indicate known security issues

---

## 4. Output Format

Claude must output a security review in this format:

```markdown
# Security Review — PR: [PR_NUMBER or Branch Name]
**Reviewer:** Claude Code  
**Date:** YYYY-MM-DD  
**Overall:** ✅ APPROVED / ⚠️ NEEDS CHANGES / 🔴 BLOCKED

## Summary
[2–3 sentence plain English summary of the change and its security profile]

## Checklist Results
| Category | Item | Status | Notes |
|---|---|---|---|
| Secrets | No hardcoded keys | ✅ PASS | |
| Input Validation | SQL parameterized | ⚠️ NEEDS REVIEW | Line 42: raw string concat |

## Required Changes (if any)
1. [Specific actionable fix]
2. [Specific actionable fix]

## Approved for Merge
[ ] All FAIL items resolved
[ ] All NEEDS MANUAL REVIEW items signed off by [engineer]
```

---

## 5. Escalation Rules

| Finding | Action |
|---|---|
| Hardcoded secret found | **BLOCK immediately.** Notify engineering lead. Rotate the secret before any merge. |
| SQL injection vulnerability | **BLOCK.** Fix required before merge. |
| Missing auth on new endpoint | **BLOCK.** Fix required before merge. |
| Missing rate limiting | **NEEDS CHANGES.** Must be added within 1 sprint. |
| Overly permissive IAM | **NEEDS MANUAL REVIEW.** Security lead must sign off. |
| New dependency with CVE | **NEEDS CHANGES.** Use a patched version or alternative. |

---

## 6. Session-End Ritual

Log to root `CHANGELOG.md`: `YYYY-MM-DD | Security-Review | [PRs reviewed] | [Findings summary]`

---

## 7. Enterprise Full-Codebase Scanning

This workflow covers **PR-level** security reviews (1 PR at a time).  
For **full codebase vulnerability scanning** (Enterprise/Team plans only), switch to:  
`enterprise/security-scanning/security-scan-workflow.md`

The enterprise scan adds 4 more categories (IaC, multi-agent boundaries, AI supply chain, audit log integrity) and generates patch proposals in `patches/` for human review.

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Initial creation: full checklist modeled on Anthropic Security Engineering team patterns + OWASP Top 10 | Setup |
