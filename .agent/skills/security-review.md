---
name: security-review
description: Runs the standardized 8-category security checklist on any PR diff or code change. Outputs a structured review with PASS/FAIL/NEEDS REVIEW per item and escalation instructions.
---

# Security Review Skill

## Purpose

Run this skill when a user invokes `/security-review` or asks for a security check on code changes. This skill implements the checklist defined in `cross-team/security-review/CLAUDE.md`.

## When to Invoke

Use when the user says:
- `/security-review`
- "Review this PR for security issues"
- "Is this code safe to merge?"
- "Check the diff for vulnerabilities"

## Execution Steps

### Step 1: Gather the code to review
If not already provided, ask:
> "Please paste the PR diff, or tell me which branch/files to review."

### Step 2: Run 8-category checklist

Evaluate each of the following. Output `✅ PASS`, `⚠️ NEEDS REVIEW`, or `🔴 FAIL`:

**A. Secrets & Credentials**
- No hardcoded API keys, tokens, passwords
- No `.env` files committed
- Environment variables accessed via `process.env` / `os.environ` only

**B. Input Validation & Injection**
- User inputs validated before use
- No raw SQL string concatenation
- No `eval()` / `exec()` on user data
- File paths sanitized

**C. Authentication & Authorization**
- New routes have auth checks
- Authorization verifies resource ownership (not just login)
- No session tokens in URLs or logs

**D. Data Handling**
- No PII in logs
- No real data in tests
- DB writes wrapped in transactions

**E. Dependencies**
- No new deps with known CVEs (`npm audit` / `pip-audit`)
- No unknown/unverified packages

**F. Infrastructure (if applicable)**
- No `*` IAM actions or resources
- No publicly exposed storage or databases
- Config changes reviewed for blast radius

**G. Robotics-Specific (if applicable)**
- No unnecessary root permissions on nodes
- Physical actuator commands have safety limits
- Emergency stop logic untouched (or approved)

**H. General Code Quality**
- Error messages don't expose stack traces to users
- Rate limiting on public API endpoints
- No TODO comments indicating known security holes

### Step 3: Output the structured review

```markdown
# Security Review — [PR/Branch Name]
**Date:** YYYY-MM-DD
**Overall:** ✅ APPROVED / ⚠️ NEEDS CHANGES / 🔴 BLOCKED

## Summary
[2–3 sentence plain English summary]

## Checklist Results
| Category | Item | Status | Notes |
|---|---|---|---|

## Required Changes
1. [Specific actionable fix]

## Approved for Merge
[ ] All FAIL items resolved
[ ] NEEDS REVIEW items signed off
```

### Step 4: Escalation

| Finding | Action |
|---|---|
| Hardcoded secret | **BLOCK** — rotate secret immediately |
| SQL injection | **BLOCK** — fix before merge |
| Missing auth on endpoint | **BLOCK** — fix before merge |
| Missing rate limiting | NEEDS CHANGES within 1 sprint |
| Overly permissive IAM | NEEDS security lead sign-off |
