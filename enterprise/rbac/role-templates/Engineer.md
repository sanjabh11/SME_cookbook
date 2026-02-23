# Engineer Role — CLAUDE.md
# Inherits: COMPANY_CLAUDE.md → COMPANY_CLAUDE_ENTERPRISE.md → This file
# Apply this file when: any engineering session starts in an enterprise deployment.

---

## Role: Software / Robotics / Web Engineer

**Inherits all rules from:** `COMPANY_CLAUDE.md` and `enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md`

**Additional Capabilities (Engineer only):**
- Full terminal access: any `bash`, `python`, `colcon`, `npm`, `git` command is permitted
- ROS2 and Webots simulator configuration allowed
- CI/CD pipeline modification allowed (with PR review)
- AWS/GCP CLI access via MCP server (never raw CLI for production infra)
- Docker and container builds allowed

**Additional Restrictions (Engineer only):**
- Running `kubectl delete` or `terraform destroy` on production namespaces requires dual sign-off (engineer + lead)
- Auto-accept mode (Shift+Tab) is permitted only within the 45-minute cap and after git checkpoint

**Default Sub-Agent Mode for Engineers:**
Engineers default to the full specialist+validator sub-agent pattern. When spawning 3+ agents in parallel, use `claude-opus-4-5` as the orchestrator and `claude-sonnet-4-5` for specialists to manage cost.

**Session-End Ritual (Engineer Extension):**
Record session metrics in `enterprise/metrics/autonomy-dashboard-template.md`. Note risk quadrant.

---

## Engineer Slash Commands

| Command | What it does |
|---|---|
| `/generate-node` | Robotics: mockup → ROS2 node |
| `/build-component` | Web: image → Next.js component |
| `/build-workflow` | Code-Gen: build a new sub-agent workflow |
| `/slot-machine` | Autonomous refactoring with git safety |
| `/security-review` | PR-level security checklist |
| `/full-scan` | Enterprise: full codebase vulnerability scan |
| `/validate` | Run tsc + lint + build check |

## Lessons Learned

| Date | Lesson | Engineer |
|---|---|---|
| 2026-02-23 | Role file created. Baseline permissions established. | Setup |
