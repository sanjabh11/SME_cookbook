# DAY-1-EXERCISES.md — Get 10x Productive in Your First Hour

Open this cookbook in Google Antigravity and try **one exercise per role** today.  
Copy-paste the exact prompt into the Claude Code sidebar. Expect results in 1–5 minutes.

## For Everyone (Non-Technical & Technical)
1. **Update your personal CLAUDE.md**  
   Go to any folder → open its CLAUDE.md → at the bottom type:  
   “Add my name and role, then run the Session-End Ritual.”  
   Claude will improve the file automatically.

## Non-Technical Teams (Marketing, Finance/HR, Legal)
2. **Marketing – 100 Google Ads variants**  
   Folder: `non-technical/marketing`  
   Prompt: “Run both Headline Agent and Description Agent on sample-ads.csv. Generate 100 variants with A/B test columns. Respect character limits.”  
   Expected: New CSV + summary in <2 minutes.

3. **Finance/HR – Quarterly report**  
   Folder: `non-technical/finance-hr`  
   Prompt: “Using Green data only, create a Q1 Excel summary from sample-sales.csv including charts and onboarding checklist.”  
   Expected: Ready-to-email Excel file.

4. **Legal & Compliance – Accessibility audit**  
   Folder: `non-technical/legal-compliance`  
   Prompt: “Run WCAG 2.1 audit on sample-webpage.html and generate a 1-page fix report plus lightweight HTML prototype.”  
   Expected: Report + fixed HTML file.

## Technical Teams (Robotics, Web Dev, Code Generation)
5. **Robotics – Image to ROS2 code**  
   Folder: `technical/robotics`  
   Prompt: “Turn the attached mock-robot-dashboard.png into a complete ROS2 Python node with Webots config and sensor_msgs.”  
   Expected: Working nodes + build instructions.

6. **Web Development – Mockup to Next.js**  
   Folder: `technical/web-dev`  
   Prompt: “Convert this Figma-style mockup image to a full Next.js 14 App Router page with TypeScript and edge-case tests.”  
   Expected: Complete working component.

7. **Code Generation Tools – New sub-agent**  
   Folder: `technical/code-generation`  
   Prompt: “Create a new Claude-integrated sub-agent skill for ROS2 simulation testing using the official Anthropic SDK.”  
   Expected: New skill file ready to use.

## Cross-Team (Everyone can try)
8. **Slot Machine Refactor**  
   Folder: `cross-team/slot-machine-refactor`  
   Prompt: “Run slot-machine pattern on one of our existing files (choose any). Checkpoint first, auto-accept 10 minutes, then show me diffs.”  

**After each exercise**:  
- Review the output.  
- Run the Session-End Ritual (Claude will remind you).  
- Add notes to CHANGELOG.md.

Finish 2–3 exercises today and you will already be faster than yesterday. Share results in your team channel!

---

## 🐛 Beginner Debug Drills

These drills are designed to teach you how to handle the most common failure modes before they become real problems. Run one drill per week in your first month.

### Drill 1: The Broken YAML (Catch it before CI does)
1. Open `.github/workflows/claude-lint.yml`
2. Deliberately add a 2-space indentation error on one line under a `steps:` block.
3. Run: `bash safeguards/local-lint.sh`
4. Observe: the linter catches it and prints a YAML ERROR message.
5. Fix the indentation and re-run until you see `✅ All checks passed.`
**Lesson:** Your lint script catches YAML errors locally before they break CI. This is why we run it.

### Drill 2: The Slot Machine Rollback
1. Go to `cross-team/slot-machine-refactor/`.
2. Run: `git add -A && git commit -m "drill: pre-slot-machine-test"`
3. Ask Claude: "Add a comment to every function in safeguards/local-lint.sh. Auto-accept."
4. Wait 1 minute. Then inspect the changes with `git diff`.
5. Practice rollback: `git reset --hard HEAD`
6. Confirm the file is back to original.
**Lesson:** The rollback is fast, safe, and completely reversible. You can always start over.

### Drill 3: The Accidental Hardcoded Secret
1. Open `cross-team/security-review/sample_diff.txt`
2. Observe: it contains `AWS_KEY = "AKIAIOSFODNN7EXAMPLE"`
3. Run `/security-review` on it.
4. Observe: Claude returns `🔴 FAIL` on the Secrets & Credentials check.
5. Ask Claude: "What is the correct fix for the hardcoded AWS key?"
6. Log the exercise in `CHANGELOG.md`: `2026-02-XX | Drill 3 | Identified hardcoded secret pattern | [your name]`
**Lesson:** This is what a hardcoded secret looks like. And this is exactly why the security review checklist exists.
