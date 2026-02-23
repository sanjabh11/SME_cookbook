# Monorepo CLAUDE.md Propagation — GitOps Architecture
# Use case: Enterprises with 10–1000+ Git repositories that all need consistent Claude Code policies.

---

## The Problem GitOps Solves

Without GitOps: When you update a policy in your `COMPANY_CLAUDE.md`, you must manually copy-paste the change into every team repository. At 100 repos, this becomes unmanageable. Policies drift and diverge silently.

**With GitOps:** This cookbook becomes the **source of truth**. Every update committed to `main` triggers an automated workflow that propagates `COMPANY_CLAUDE.md`, `COMPANY_CLAUDE_ENTERPRISE.md`, and selected `CLAUDE.md` templates to all downstream repositories.

---

## Architecture

```
[This cookbook repo]  ← source of truth
      │
      │  .github/workflows/claude-propagate.yml
      │  (runs on push to main)
      ▼
[Anthropic Console API]
      │
      │  Pushes policies to all registered target repos
      ▼
[Team Repo 1]  [Team Repo 2]  [Team Repo 3]  ...  [Team Repo N]
(receives updated COMPANY_CLAUDE.md + role templates)
```

---

## What Gets Propagated

| File | Propagated to | Override allowed? |
|---|---|---|
| `COMPANY_CLAUDE.md` | All repos | No — org-wide baseline |
| `enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md` | Enterprise repos only | No |
| `enterprise/rbac/role-templates/*.md` | Enterprise repos only | No |
| `templates/CLAUDE.md.example` | All repos | Yes — teams customize locally |
| `.agent/skills/*.md` | All repos | No — set at org level |

---

## Setup Steps

### Step 1: Register Target Repositories

In `claude-propagate.yml`, update the `TARGET_REPOS` list:
```yaml
env:
  TARGET_REPOS: |
    sanjabh11/robotics-core
    sanjabh11/web-platform
    sanjabh11/code-gen-tools
```

### Step 2: Create a PAT (Personal Access Token)

1. GitHub → Settings → Developer Settings → Personal Access Tokens
2. Create token with scope: `repo` (read/write)
3. Add as GitHub Secret: `Settings → Secrets → POLICY_PROPAGATION_PAT`

### Step 3: Test Propagation

```bash
# Trigger manually for testing
gh workflow run claude-propagate.yml
# Then verify in one target repo:
git -C /path/to/target-repo log --oneline -3
# Should show: "Auto: propagate Claude policies from SME_cookbook/main"
```

---

## Handling Merge Conflicts

If a target repo has local changes to `COMPANY_CLAUDE.md`:
1. The workflow creates a PR instead of force-pushing
2. A human must review and merge the PR
3. This is intentional — never force-overwrite deliberate local policy modifications
