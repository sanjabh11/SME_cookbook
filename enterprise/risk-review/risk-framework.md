# Enterprise Risk Review Framework
# Integrates Anthropic Feb 18 2026 Autonomy Research + Anthropic RSP v2.2

---

## What Is the Risk Review Framework?

The Risk Review Framework provides a systematic approach for classifying, monitoring, and mitigating risks introduced by AI-assisted Claude Code workflows. It complements the session-level security checklist with a **strategic, portfolio-level view** across all teams and sessions.

---

## The Risk Quadrant (Per-Session Classification)

```
                 Auto-Approve Rate
                 Low (<20%)   |   High (>40%)
              ─────────────────────────────────
Session  <45m │   🟢 LOW      │   🟡 MEDIUM     │
Length        │   (Target)    │   (Review)      │
              ├───────────────┼─────────────────┤
         >45m │   🟡 MEDIUM   │   🔴 HIGH       │
              │   (Monitor)   │   (Reduce)      │
              ─────────────────────────────────
```

**Target:** 85%+ of sessions in 🟢 LOW quadrant.  
**Alert:** 2+ HIGH sessions in any 7-day window → mandatory team retrospective.  
**Hard Stop:** Any session reaching 45 minutes → pause and checkpoint before continuing.

---

## Anthropic RSP v2.2 Risk Thresholds (Feb 2026)

| Risk Dimension | Green (Safe) | Yellow (Monitor) | Red (Stop) |
|---|---|---|---|
| Session length | < 30 min | 30–45 min | ≥ 45 min |
| Auto-approve rate | 20–35% | 35–40% | > 40% |
| Interventions/hour | < 2 | 2–4 | ≥ 5 |
| Failed validations | < 5% | 5–20% | ≥ 20% |
| Autonomous file changes | < 10 files | 10–50 files | > 50 files |

---

## Monthly Risk Portfolio Review

At the first Monday of each month, the AI Champion for each team should:

1. Pull the last 30 days from `enterprise/metrics/autonomy-dashboard-template.md`
2. Calculate the team's aggregate risk score:
   ```
   Risk Score = (% HIGH sessions × 3) + (% MEDIUM sessions × 1)
   Target: < 10 per team per month
   ```
3. Identify the 2 highest-risk sessions: what caused the HIGH classification?
4. Propose one CLAUDE.md workflow improvement to prevent recurrence.
5. Report to the AI Steering Committee (Exec can use `/risk-status` command).

---

## Risk Escalation Matrix

| Trigger | Escalation Path | SLA |
|---|---|---|
| Single session > 45 min | Champion notified | Immediate |
| 2+ HIGH-risk sessions in 7 days | Team retrospective required | Within 3 business days |
| 20%+ validator failures in a run | Engineering lead review | Same day |
| Security scan CRITICAL finding | CISO + Engineering VP | Within 2 hours |
| Suspected data breach | Privacy Officer + Anthropic Enterprise | Within 1 hour |

---

## Risk Register (Maintained by AI Steering Committee)

| Risk ID | Description | Likelihood | Impact | Mitigation | Status |
|---|---|---|---|---|---|
| R001 | Runaway autonomous session modifies prod config | Medium | High | 45-min hard stop + git checkpoint | Active |
| R002 | PHI exposed in Cowork Slack message | Low | Critical | Cowork training + no-PHI policy | Active |
| R003 | Skills Marketplace deploys malicious third-party skill | Low | High | Security review before org deployment | Active |
| R004 | Policy drift across monorepo (CLAUDE.md inconsistency) | Medium | Medium | `claude-propagate.yml` CI enforcement | Active |
