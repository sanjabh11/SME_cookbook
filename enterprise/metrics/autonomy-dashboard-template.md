# Autonomy Dashboard Template
# Research: Anthropic Measuring AI Agent Autonomy, Feb 18 2026
# Fill this in after every enterprise Claude Code session.

---

## How to Use This Dashboard

After each session, ask Claude:  
> *"Fill in a new row in autonomy-dashboard-template.md with today's session metrics."*

Claude will calculate the Risk Quadrant automatically based on your session length and auto-approve rate.

---

## Risk Quadrant Reference

```
                    Auto-Approve Rate
                    Low (<20%)   |   High (>40%)
                 ─────────────────────────────────
Session  Short  │   🟢 LOW      │   🟡 MEDIUM     │
Length   (<45m) │   (Ideal)     │   (Review)      │
                ├───────────────┼─────────────────┤
         Long   │   🟡 MEDIUM   │   🔴 HIGH       │
         (>45m) │   (Monitor)   │   (Reduce)      │
                ─────────────────────────────────
```

**Target zone:** 🟢 LOW — sessions under 45 minutes, auto-approve 20–40%.  
**Action required:** Any 🔴 HIGH session must be reviewed in the weekly team retrospective.

---

## Session Log

<!-- Claude fills this in via the Session-End Ritual -->

| Date | Team | Task | Session Length | Auto-Approve % | Human Interventions | Risk Quadrant | Notes |
|---|---|---|---|---|---|---|---|
| 2026-02-23 | Code-Gen | Enterprise v2.0 scaffolding | 35 min | 30% | 2 | 🟢 LOW | Baseline run, smooth |
| | | | | | | | |
| | | | | | | | |
| | | | | | | | |

---

## Monthly Summary (Auto-calculated by Claude)

Ask at month end: *"Summarize this dashboard for the month. Identify any HIGH-risk sessions and what caused them."*

| Month | Total Sessions | Avg Session Length | Avg Auto-Approve | HIGH Risk Sessions | Avg Interventions |
|---|---|---|---|---|---|
| Feb 2026 | — | — | — | — | — |

---

## Thresholds & Alerts

| Metric | Target | Alert Threshold | Action |
|---|---|---|---|
| Session Length | < 45 min | ≥ 45 min | Hard stop + checkpoint |
| Auto-Approve Rate | 20–40% | > 40% | Switch to synchronous mode |
| Human Interventions | < 3/hour | ≥ 5/hour | Simplify task scope |
| HIGH Risk Sessions | 0/week | ≥ 2/week | Team retro required |
