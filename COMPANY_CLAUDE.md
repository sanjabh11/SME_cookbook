# Org-Wide Claude Code Constitution
# Cookbook-SME-Robotics | Version 1.0 | Updated: 2026-02-23

---

## 1. Who We Are

You are assisting a 100-person SME in robotics, code generation, and web development.

**Non-technical staff (40 people):** HR, Finance, Marketing, Sales.
- Use plain English only. Never assume coding knowledge.
- Do not mention terminal commands, git, or code syntax without explaining what each step does.
- Show outputs as tables, bullet lists, or prose — never raw JSON or code blocks.

**Technical staff (60 people):** Robotics (ROS2/simulation), Web (React/Next.js), Code-Gen tools.
- You may assume Python, git, and CLI fluency.
- Default to clean, production-ready code with full docstrings.
- Always prefer the team's existing patterns over introducing new dependencies.

---

## 2. Tech Stack & Environment

| Domain | Preferred Stack |
|---|---|
| Robotics | ROS2 Humble, Python (rclpy), Gazebo/Webots, colcon |
| Web | React, Next.js 14+, TypeScript, Vercel/Netlify |
| Code-Gen | Python, sub-agents, Claude API (Anthropic SDK) |
| Data | CSV, SQLite, MCP-gated BigQuery (never raw CLI for sensitive data) |
| CI/CD | GitHub Actions, auto-PR review via Claude |
| Version Control | Git (always checkpoint before autonomous runs) |

---

## 3. Security Rules (NON-NEGOTIABLE)

1. **Never access real customer or employee data without an MCP boundary in place.** Use `sample_*.csv` files only for testing.
2. **Always `git commit` to a clean checkpoint BEFORE enabling auto-accept mode (`Shift+Tab`).** This is the "slot machine" safety rule — you can always roll back.
3. **Run `/security-review` on ALL pull requests.** The slash command definition lives in `cross-team/security-review/CLAUDE.md`.
4. **Never commit `.env`, API keys, or credentials.** See `.gitignore` for the full blocked list.
5. **Use MCP servers (not CLI) for any tool that touches BigQuery, databases, or external APIs.** Prefer logging and auditability.
6. **For non-technical staff automation:** Never auto-execute a workflow that modifies files without a confirmation step.

---

## 4. Workflow Modes

**Synchronous (supervised):** Core business logic, customer-facing features, financial reports, security-sensitive tasks.
- You must explain each step before executing.
- Request confirmation on irreversible actions.

**Asynchronous (auto-accept):** Peripheral features, ad copy generation, refactoring, test generation, documentation.
- Only allowed after a git checkpoint.
- Generate tests before implementing, so Claude can self-verify.
- After 30 minutes of autonomous work, pause and report progress.

---

## 5. Sub-Agent Architecture

Complex tasks should be broken into specialized sub-agents. Pattern:
1. **Orchestrator agent:** Reads task, decomposes, spawns sub-agents.
2. **Specialist agents:** One job each (e.g., headline writer, test generator, ROS node builder).
3. **Validator agent:** Checks outputs against the schema defined in the folder's `CLAUDE.md`.
4. **Merge agent:** Assembles outputs, runs final checks, writes to output file.

Reference: `cross-team/slot-machine-refactor/` and `.agent/skills/sub-agent-spawner.md`.

---

## 6. Style & Output Standards

- **Code:** Clean, documented, production-ready. Every function gets a docstring. No magic numbers.
- **Reports:** Professional, plain English. Tables for comparisons, bullet lists for summaries.
- **Documentation:** Update the relevant `CLAUDE.md` at session end (see Section 8).
- **Naming:** Use snake_case for files, PascalCase for React components, SCREAMING_SNAKE for constants.
- **Preferred tools:** Antigravity browser preview for web tests; built-in sub-agents for complex tasks.

---

## 7. Onboarding New Team Members

Direct all new joiners to:
1. Read `ONBOARDING.md` (root-level, ~1 hour guided first session).
2. Navigate to their team's subfolder and read its `CLAUDE.md`.
3. Run the folder's sample task exactly as described in `README.md`.
4. Use Claude Code to explain any part of the codebase they don't understand (never guess).

---

### Team Scaling & Anthropic Plan Recommendation

We are a 100-person SME (40 non-technical + 60 technical).  
- Start with Anthropic **Team plan** (recommended for shared billing, admin seat management, usage analytics, and full Claude Code access).  
- Upgrade high-usage technical users (robotics, web dev) to Premium seats (~$150/user/month) for unlimited Sonnet 4.5 / Opus 4.6 + higher context.  
- Non-technical staff can stay on base Team seats.  
- After 2 weeks of usage, run company-wide “slot-machine” refactor on our core robotics and web codebases for 2–4x additional gains.  
- Track everything in METRICS_TRACKING.md files and review monthly in All-Hands.

All users: Never exceed free-tier limits without manager approval. Use Review-driven policy at all times.

---

## 8. Session-End Ritual (MANDATORY)

At the end of every Claude Code session:
1. Ask Claude: *"Summarize what we did this session and suggest 3 improvements to this folder's `CLAUDE.md` based on what we learned."*
2. Copy the suggestions into the folder's `CLAUDE.md` under a `## Lessons Learned` section.
3. Append a one-line entry to `CHANGELOG.md` in the root: `YYYY-MM-DD | [Team] | [What changed]`.
4. Run `git commit -m "session-end: [team] [brief description]"`.

This creates the **continuous improvement loop** that keeps automation effective over time.

---

## 9. Expanding This Repo for New Organizations

This cookbook is designed to be forked and adapted. To customize for a new org:
1. Replace all instances of `robotics/web SME` with your org description in `COMPANY_CLAUDE.md`.
2. Update the tech stack table (Section 2 above).
3. Copy `templates/CLAUDE.md.example` into your new team folder and fill in the `{{PLACEHOLDER}}` fields.
4. Run the onboarding sequence in `ONBOARDING.md`.
5. Update security rules in Section 3 to reflect your compliance requirements (GDPR, HIPAA, SOC2, etc.).

---

## 10. Lessons Learned Log

*(Updated via the session-end ritual — see Section 8)*

| Date | Team | Lesson |
|---|---|---|
| 2026-02-23 | All | Initial constitution created from Anthropic internal guide best practices |
