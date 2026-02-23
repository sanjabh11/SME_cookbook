# Claude Code Security Workflow
# Feature: Enterprise/Team Preview (Feb 20–21 2026)
# Applies to: Enterprise and Team plan users only

---

## What Is Claude Code Security?

Claude Code Security is an Enterprise-only capability (Feb 2026 preview) that performs **full codebase vulnerability scanning** and proposes patches for human review. It is fundamentally different from the standard `/security-review` PR check in `cross-team/security-review/`:

| Feature | `/security-review` (Cross-Team) | Claude Code Security (Enterprise) |
|---|---|---|
| Scope | Single PR diff | Entire codebase |
| Trigger | Manual slash command | Scheduled scan or on-demand |
| Output | Human-readable checklist | Structured patch proposals |
| Auto-apply patches | Never | Never — always human-reviewed |
| Plan required | Any | Enterprise or Team only |

---

## How to Trigger a Full Codebase Scan

**In Claude Code sidebar:**
```
Run full codebase vulnerability scan using Claude Code Security.
Output human-review patches only. Do not apply any patches automatically.
Scope: entire repository (or specify: src/, technical/, etc.)
```

**Expected output:**
1. A summary report: `security-scan-results-YYYY-MM-DD.md`
2. A patch file per vulnerability: `patches/patch-[id]-[type].diff`
3. A human review queue: `patches/review-queue.md`

---

## Workflow: From Scan to Remediation

```
Step 1: Trigger scan (manual or via .github/workflows/claude-lint.yml weekly schedule)
Step 2: Review security-scan-results-YYYY-MM-DD.md — triage by severity
Step 3: For each patch in patches/review-queue.md:
   a. Open the diff file: patches/patch-[id]-[type].diff
   b. Review: does this patch fix the stated vulnerability without introducing new ones?
   c. If approved: apply via `git apply patches/patch-[id]-[type].diff`
   d. If rejected: note reason in review-queue.md and assign to engineering lead
Step 4: Run tests on each applied patch: npm test / pytest / colcon test
Step 5: Commit approved patches: git commit -m "security: applied [id] patch — [severity]"
Step 6: Run /security-review on the resulting PR as final check
Step 7: Update CHANGELOG.md with scan date and patch count
```

---

## Severity Classification

| Level | Examples | SLA to Patch |
|---|---|---|
| 🔴 Critical | Hardcoded secrets, SQLi, auth bypass | Immediate (same day) |
| 🟠 High | Missing rate limiting, unvalidated redirects | Within 48 hours |
| 🟡 Medium | Outdated deps with CVEs, weak crypto | Within 1 sprint |
| 🟢 Low | Missing security headers, verbose errors | Within 2 sprints |

---

## Key Rules (Non-Negotiable)

1. **Claude Code Security generates patch proposals only.** A human engineer must review and apply every patch.
2. **Never auto-merge** a patch from Claude Code Security — even if all tests pass, review the diff first.
3. **Escalate Critical findings** to the engineering lead within 2 hours of discovery.
4. **Log all scans** in `enterprise/metrics/autonomy-dashboard-template.md` with date, findings count, and patch status.
5. **Cross-reference** with 8-section checklist in `claude-security-checklist.md`.
