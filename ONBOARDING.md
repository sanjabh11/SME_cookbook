# Onboarding Guide — Claude Code Cookbook
# For new team members and organizations adopting this cookbook

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

## Welcome

This guide walks you through your **first session with Claude Code** in this cookbook. It takes about 60 minutes and leaves you productive from Day 1.

---

## Before You Start (Checklist)

- [ ] You have **Google Antigravity** installed and open
- [ ] You have the `Cookbook-SME-Robotics` folder open inside Antigravity
- [ ] You know which folder is your team's (see the routing table in `README.md`)
- [ ] You have git basic knowledge: `git add`, `commit`, `reset --hard`

If any box is unchecked, ask your tech lead to help set it up — 15 minutes of setup saves hours later.

---

## Hour 1: Your First Session (Step by Step)

### Step 1: Read the org constitution (5 min)
Open `COMPANY_CLAUDE.md` and read it fully. It defines:
- Who you are and what this company does
- Security rules you must never violate
- The session-end ritual (critical)

### Step 2: Navigate to your team folder (2 min)
Based on the routing table in `README.md`, open your team's subfolder:
- **Marketing:** `non-technical/marketing/`
- **Finance / HR:** `non-technical/finance-hr/`
- **Legal:** `non-technical/legal-compliance/`
- **Robotics:** `technical/robotics/`
- **Web Dev:** `technical/web-dev/`
- **Code-Gen:** `technical/code-generation/`

### Step 3: Read your team's CLAUDE.md (10 min)
Read it fully. Pay special attention to:
- **Section 4 (Workflows):** This is what you'll use every day
- **Section 7 (Safety rules):** These protect you and the company
- **Section 10 (Session-end ritual):** Do this at the end of every session

### Step 4: Run the sample task (20 min)
Open your team's `README.md` and run the exact sample task described there. Don't skip this — it verifies your setup works and teaches you the workflow.

**Tip for non-technical staff:** If you see something you don't understand, type it to Claude: "I don't know what this means: [paste the confusing part]". Claude will explain it in plain English.

### Step 5: Ask Claude about the codebase (10 min)
Type this into Claude Code:
> *"I'm new to this team. What are the most important things I should understand about how this folder is set up? What are the most common tasks and how do I run them?"*

Claude will give you a tour tailored to your folder.

### Step 6: Practice the session-end ritual (5 min)
At the end of your first session, type:
> *"Summarize what we did today and suggest 3 improvements to this CLAUDE.md based on our session."*

Then make a git commit: `git commit -m "session-end: onboarding first session"`

---

## Key Concepts Every User Must Know

### The Slot Machine Safety Rule
Before any long autonomous task, ALWAYS run:
```bash
git add -A && git commit -m "checkpoint before autonomous run"
```
If something goes wrong: `git reset --hard HEAD` — instant rollback to safety.

### Auto-Accept Mode (Shift+Tab)
Enables Claude to work autonomously without asking for approval each step. **Only use after a git checkpoint.** Use for: safe, peripheral tasks (ad generation, documentation, refactoring). **Do NOT use for:** core business logic, financial reports, security changes.

### Sub-Agents
Claude can spawn specialized sub-agents for complex tasks. The patterns are all defined in your team's CLAUDE.md Section 5 and in `.agent/skills/sub-agent-spawner.md`.

### MCP Boundaries
MCP (Model Context Protocol) controls what external systems Claude can access. Your team's CLAUDE.md Section 3 defines exactly what's allowed and forbidden. When in doubt: **ask before accessing any system not listed as ✅ Allowed.**

---

## Frequently Asked Questions

**Q: Claude did something wrong and changed files I didn't want changed. What do I do?**  
A: Run `git reset --hard HEAD` to instantly undo everything back to your last checkpoint. This is why we always commit before long runs.

**Q: Can I use auto-accept mode for financial reports?**  
A: No. Financial reports require synchronous supervision (Section 4 of `finance-hr/CLAUDE.md`). Always monitor these in real-time.

**Q: I want to add a new workflow to my team's CLAUDE.md. How?**  
A: Add it in Section 4 following the same `Step 1 / Step 2 / Step 3...` format. Then run the session-end ritual so it gets committed.

**Q: I'm setting this up for a new organization. Where do I start?**  
A: Read `COMPANY_CLAUDE.md` Section 9 (Expanding for New Organizations). Replace all `{{PLACEHOLDER}}` values in `templates/CLAUDE.md.example`, and work through this onboarding guide with your team.

---

## For Engineering Leads: Setting Up a New Team Member

1. Have them read this file first.
2. Help with Antigravity installation and repo clone (15 min).
3. Sit with them for their first slot machine run (the `cross-team/slot-machine-refactor/` folder).
4. Show them your team's Claude Code session recording (or do a live demo).
5. Schedule a "share team usage sessions" workshop after 2 weeks (key Anthropic tip — spreads best practices).

---

*Last updated: 2026-02-23 | Update this file whenever onboarding takes more than 90 minutes — it means something changed.*
