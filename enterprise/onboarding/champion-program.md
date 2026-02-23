# Champion Program — Enterprise Train-the-Trainer Kit
# Extends the SME ONBOARDING.md for large-org deployments.
# CodePath Partnership (Feb 13 2026) modules integrated.

---

## What Is the Champion Program?

The Champion Program trains 1–2 **AI Champions** per department, who then train their own team members. At 100+ people this is the only scalable approach — centralized training doesn't work beyond 50 people.

**Champion selection criteria:**
- High comfort with new technology (doesn't have to be technical)
- Respected peer — people ask them questions naturally
- Available for 3 hours of initial training + 1 hour/week ongoing

---

## Champion Training Curriculum (3 Hours Total)

### Hour 1: Foundations (Run in Antigravity together)
1. Open the cookbook in Antigravity. Read `README.md` together (5 min).
2. Read `COMPANY_CLAUDE.md` — discuss every section (15 min).
3. Run the 5-Minute Setup with the champion watching and repeating each step (20 min).
4. Run 2 exercises from `DAY-1-EXERCISES.md` for their team's folder (20 min).

### Hour 2: The Safety Protocols (Practice makes permanent)
1. Practice the Slot Machine pattern: `cross-team/slot-machine-refactor/` (30 min).
   - Champion performs a git checkpoint, enables auto-accept, waits 5 minutes, then rolls back.
   - Goal: build muscle memory for the checkpoint → accept/rollback cycle.
2. Practice the Session-End Ritual in their team folder (15 min).
3. Run `bash safeguards/local-lint.sh` — explain every check (15 min).

### Hour 3: Train-the-Trainer Preparation
1. Champion designs their department's first group exercise (use `DAY-1-EXERCISES.md` as template) (30 min).
2. Champion delivers a 10-minute micro-demo to you (the trainer) (10 min).
3. Set up a weekly 30-minute "Usage Share" session — champion's team shares wins each week (20 min).

---

## CodePath Partnership Integration (Feb 13 2026)

The Anthropic CodePath partnership provides structured learning modules for engineers new to AI-assisted coding. Champions with engineering teams should incorporate these:

| Module | Duration | Best For |
|---|---|---|
| Module 1: Claude Code Foundations | 2 hours | All technical roles |
| Module 2: Sub-Agent Architecture | 3 hours | Engineers, Code-Gen team |
| Module 3: CI/CD + Policy Automation | 2 hours | Senior engineers, DevOps |
| Module 4: Security & Compliance | 2 hours | All enterprise users |

Access via: `https://codepath.org/anthropic` (partner code provided by Anthropic Enterprise support)

---

## Weekly Champion Cadence

| Week | Champion Activity |
|---|---|
| Week 1 | Deliver Day-1 Exercises to team (90 min workshop) |
| Week 2 | Host "Usage Share" — 3+ team members share a win from that week |
| Week 3 | Review METRICS_TRACKING.md with team; discuss any 0% or stuck areas |
| Week 4 | Update team's CLAUDE.md with best suggestions from the month |
| Monthly | Submit champion report to AI Steering Committee (1-page table) |

---

## Champion Success Metrics

At 4 weeks, a successful champion's team shows:
- [ ] ≥ 80% of team has completed at least 2 DAY-1-EXERCISES
- [ ] At least 1 METRICS_TRACKING.md row per team member
- [ ] CLAUDE.md in team folder updated at least once since initial setup
- [ ] Zero unhandled CRITICAL findings in `/security-review` for the month
- [ ] Team's average session risk quadrant is 🟢 LOW or 🟡 MEDIUM
