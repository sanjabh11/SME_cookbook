# 📓 Cookbook — Claude Code for SME & Enterprise Teams

> **What this is:** A ready-to-run, dual-mode collection of Claude Code workflows designed for teams from 10 to 50,000 users. SMEs use the standard team folders; enterprises add governance, compliance, and RBAC via the `/enterprise/` directory.

---

## 🤔 SME or Enterprise? Start Here.

| Question | If YES → | If NO → |
|---|---|---|
| Are you a team of < 500 people? | 🟢 **Use SME mode** (all standard folders) | 🔵 **Use Enterprise mode** (start with `enterprise/`) |
| Do you need HIPAA or SOC 2 compliance? | 🔵 **Enterprise** → `enterprise/compliance/` | 🟢 SME is fine |
| Do you manage 10+ repos needing the same policies? | 🔵 **Enterprise** → `enterprise/monorepo/` | 🟢 SME is fine |
| Do different roles need different permissions? | 🔵 **Enterprise** → `enterprise/rbac/` | 🟢 SME is fine |
| Are you using Claude Code Security (Feb 2026)? | 🔵 **Enterprise** → `enterprise/security-scanning/` | 🟢 Use `cross-team/security-review/` |

**First time migrating from SME to Enterprise?** See `enterprise/migration/sme-to-enterprise.md`.

---

## 🚀 5-Minute First-Time Setup (Google Antigravity + Claude Code)

Follow these steps **exactly once** — even if you’ve never used an IDE before. Takes 5 minutes and works on Mac, Windows, or Linux.

1. **Download Antigravity**  
   Go to https://antigravity.google/download  
   Click the button for your computer (Apple Silicon, Intel Mac, Windows 64-bit, or Linux .deb/.rpm).

2. **Install & Launch**  
   Open the downloaded file and follow the installer.  
   Launch Antigravity for the first time.

3. **Complete the Setup Wizard** (important!)  
   - Choose **Fresh start** (or import VS Code settings if you have them).  
   - Theme: pick Dark or Light.  
   - **Agent usage policy**: Select **Review-driven development** (this is the safest and recommended setting for our company).  
   - Sign in with your Google/Gmail account (free preview tier is enough to start).

4. **Install Claude Code Extension**  
   Press `Cmd + Shift + X` (Mac) or `Ctrl + Shift + X` (Windows/Linux).  
   In the Extensions search bar, type **Claude Code**.  
   Install the official one by **Anthropic** (publisher badge verified, ID: anthropic.claude-code).  
   Wait for it to activate (may take 10–20 seconds).

5. **Sign in to Claude Code**  
   Look for the sparkling star icon or press `Cmd + L` (Mac) / `Ctrl + L` (Win/Linux) to open the Claude Code sidebar.  
   Click **Sign in** and use your Anthropic account.  
   **Recommendation**: Upgrade to Anthropic Team plan (shared billing, higher limits for 100 users — see COMPANY_CLAUDE.md).

6. **Final Checks**  
   - Open this cookbook folder (File → Open Folder → select the cloned repo).  
   - In Antigravity’s Agent Manager (Mission Control), confirm policy is still “Review-driven”.  
   - Test: Type “Hello” in the Claude Code sidebar — it should reply.

**Hybrid tip**: Use Antigravity’s built-in Gemini agents + browser preview for quick web tests. Use Claude Code (this sidebar) for all deep robotics, web dev, marketing, and finance work from the Anthropic guide.

You are now ready for Day-1 exercises below!

---

## 🚀 Quick Start (2 minutes)

1. Open this folder in **Google Antigravity** (Claude Code extension is pre-configured).
2. Find your team below → click your folder.
3. Read the `CLAUDE.md` inside → it tells Claude everything it needs to know.
4. Type your task in plain English in the sidebar. That's it.

---

## 📂 Who Goes Where

| Your Role | Your Folder | Example Task |
|---|---|---|
| Marketing / Growth | `non-technical/marketing/` | *"Generate 200 ad variants from this CSV"* |
| Finance / Accounting | `non-technical/finance-hr/` | *"Produce Q1 sales report from sample_sales.csv"* |
| HR / People Ops | `non-technical/finance-hr/` | *"Draft an onboarding doc for a new hire"* |
| Legal / Compliance | `non-technical/legal-compliance/` | *"Build a compliance tracking form"* |
| Robotics / Simulation | `technical/robotics/` | *"Turn this diagram into a ROS2 Python node"* |
| Web Developer | `technical/web-dev/` | *"Convert this Figma mockup to a Next.js page"* |
| Code-Gen / Tooling | `technical/code-generation/` | *"Build a sub-agent that reviews PRs"* |
| Any Team (prototyping) | `cross-team/prototyping-from-image/` | *"Here's a screenshot — build a working prototype"* |
| Any Team (refactoring) | `cross-team/slot-machine-refactor/` | *"Handle this merge conflict autonomously"* |
| Any Team (security) | `cross-team/security-review/` | *"Review this PR for security issues"* |

---

## ⚠️ The Slot Machine Safety Rule (READ THIS FIRST)

Before any long autonomous run, **always run this command:**
```
git add -A && git commit -m "checkpoint before autonomous run"
```
Then enable auto-accept (`Shift+Tab`). If Claude goes off track, `git reset --hard HEAD` brings you back to safety. This pattern is used by Anthropic's own engineering teams.

---

## 🔄 The Session-End Ritual

At the end of every session, type this into Claude:
> *"Summarize what we did and suggest 3 improvements to this folder's CLAUDE.md."*

Then add a one-liner to `CHANGELOG.md`:
```
2026-02-23 | Marketing | Added character-limit validation to ad generator
```

This keeps every CLAUDE.md improving over time.

---

## 📁 Full Folder Map

```
Cookbook-SME-Robotics/
├── COMPANY_CLAUDE.md          ← Org-wide rules (all teams, all sessions)
├── README.md                  ← This file
├── ONBOARDING.md              ← First-session guide for new team members
├── CHANGELOG.md               ← Running log of CLAUDE.md improvements
├── .gitignore                 ← Blocks secrets/real data from commits
│
├── non-technical/
│   ├── marketing/             ← Google Ads generation, CSV → ad variants
│   ├── finance-hr/            ← Sales reports, Excel, onboarding docs
│   └── legal-compliance/      ← Accessibility tools, compliance tracking
│
├── technical/
│   ├── robotics/              ← Image → ROS2 node, Gazebo simulation
│   ├── code-generation/       ← Sub-agents building sub-agents
│   └── web-dev/               ← Figma → Next.js full-stack
│
├── cross-team/
│   ├── prototyping-from-image/← Paste screenshot → working prototype
│   ├── slot-machine-refactor/ ← Autonomous refactoring with git safety
│   └── security-review/       ← /security-review slash command
│
└── templates/
    └── CLAUDE.md.example      ← Gold-standard template for new folders
```

---

## 🔧 Adding a New Folder (for any org)

1. Copy `templates/CLAUDE.md.example` into your new folder.
2. Replace all `{{PLACEHOLDER}}` values.
3. Add a row to the "Who Goes Where" table above.
4. Commit: `git commit -m "feat: add [team] folder"`

---

## Scaling for 100 People

We are a 100-person SME (40 non-technical + 60 technical).  
- Start with Anthropic **Team plan** (recommended for shared billing, admin seat management, usage analytics, and full Claude Code access).  
- Upgrade high-usage technical users (robotics, web dev) to Premium seats (~$150/user/month) for unlimited Sonnet 4.5 / Opus 4.6 + higher context.  
- Non-technical staff can stay on base Team seats.  
- After 2 weeks of usage, run company-wide “slot-machine” refactor on our core robotics and web codebases for 2–4x additional gains.  
- Track everything in METRICS_TRACKING.md files and review monthly in All-Hands.

All users: Never exceed free-tier limits without manager approval. Use Review-driven policy at all times.

---

*Track usage in Antigravity history. Update each CLAUDE.md weekly via the session-end ritual.*
