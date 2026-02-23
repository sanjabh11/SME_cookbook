# Manual Review Checklist — Before Each Enterprise Implementation Batch

Run through this checklist BEFORE starting each batch and AFTER each batch completes.  
**Do not skip any item regardless of time pressure.**

---

## Pre-Batch Checklist (Run before starting any batch)

- [ ] **Git state is clean:** `git status` returns `nothing to commit, working tree clean`
- [ ] **On the right branch:** `git branch` confirms you are on `main` (or a feature branch if working in isolation)
- [ ] **No merge conflicts active:** No `<<<<<<` markers visible in any open file
- [ ] **Test prompt passed:** Ask Claude "List all files and check for conflicts" — results look nominal
- [ ] **Antigravity policy set to:** Review-driven development (not full auto-accept — use Shift+Tab only after this checklist is complete)
- [ ] **You have 20 minutes available:** Do not start a batch you cannot finish in one sitting

---

## Batch 1 Post-Check (After governance, skills, security, metrics, rbac)

- [ ] All 13 files in `/enterprise/` subdirectories created successfully
- [ ] `/safeguards/` folder and all 3 prep files exist
- [ ] `skills-importer.sh` has `#!/bin/bash` on line 1 (not empty, not binary)
- [ ] `COMPANY_CLAUDE_ENTERPRISE.md` references `COMPANY_CLAUDE.md` explicitly (not standalone)
- [ ] RBAC role files all follow the same format (Inherits → Additional Policies → Slash Commands)
- [ ] Run: `grep -r "{{PLACEHOLDER}}" enterprise/` — should return ZERO results (no unfilled templates)

---

## Batch 2 Post-Check (After monorepo, CI/CD, onboarding, compliance, multi-agent, cowork)

- [ ] Both YAML workflows created in `.github/workflows/`
- [ ] YAML validity check: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/claude-lint.yml'))"` — no error
- [ ] YAML validity check: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/claude-propagate.yml'))"` — no error
- [ ] `enterprise/compliance/HIPAA-checklist.md` contains minimum 8 checklist items
- [ ] `non-technical/cowork-hybrid/CLAUDE.md` follows non-technical audience rules (no code blocks for non-tech users)
- [ ] `champion-program.md` references the CodePath partnership (Feb 13 2026)

---

## Batch 3 Post-Check (After risk, case-studies, global, migration + root modifications)

- [ ] Root `README.md` now contains "SME or Enterprise?" decision tree section
- [ ] Root `COMPANY_CLAUDE.md` references `/enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md`
- [ ] `templates/METRICS_TRACKING.md` now has `Session Length` and `Risk Quadrant` columns with one WORKED EXAMPLE row filled in
- [ ] `DAY-1-EXERCISES.md` has new `## Beginner Debug Drills` section with at least 3 drills
- [ ] `CHANGELOG.md` has a v2.1 entry dated 2026-02-23
- [ ] Final git commit tagged: `v2.1 – Beginner-Resilient Enterprise Scaling`

---

## Escalation (What to do if a check fails)

1. Do NOT commit. Stay on the failing check.
2. Run `git diff` to isolate the exact file.
3. Ask Claude: "Fix only [specific file] — describe why the check is failing."
4. Re-run the failed check item before continuing.
5. If stuck for more than 10 minutes: `git reset --hard HEAD` and restart that batch only.
