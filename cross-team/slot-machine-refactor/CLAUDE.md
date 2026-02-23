# Slot Machine Refactor — CLAUDE.md
# Version 1.0 | Cookbook-SME-Robotics | Cross-Team

---

## 1. What is the "Slot Machine" Pattern?

The **slot machine pattern** is a safe, repeatable workflow for delegating complex or tedious refactoring work to Claude Code autonomously — while maintaining a guaranteed rollback point if anything goes wrong.

**Named after:** The "commit state → pull the lever → accept or walk away" analogy used by Anthropic's Data Science and RL Engineering teams.

**Use when:**
- Merge conflicts that are too complex for editor macros
- Semi-complicated file refactoring spread across many files
- Large-scale renaming or structural changes
- Any tedious but mechanical task that would take 30–60 min manually

**Do NOT use when:**
- Core business logic needs changing (use synchronous supervision instead)
- The task requires deep domain knowledge or judgment calls
- You need the result in the next 5 minutes (it takes 20–30 min to run)

---

## 2. Audience Instructions

- **Technical staff:** This workflow is for you. It requires git comfort — you need to know how to `commit`, `reset --hard`, and `diff`.
- **Non-technical staff:** Use this only with a technical team member present to handle the git steps.

---

## 3. The 5-Step Slot Machine Protocol

### Step 1: Describe the task (5 min)

Write a clear task description. Use this template:
```
TASK: [One sentence describing the goal]
SCOPE: [Which files or directories are in scope]
RULES: [Any constraints — e.g., "don't change function signatures", "keep all tests passing"]
SUCCESS: [How we know it worked — e.g., "all tests pass", "no TypeScript errors"]
```

Save this as `slot_machine_task.md` in this folder before starting.

### Step 2: Checkpoint (1 min — MANDATORY)

```bash
git add -A && git commit -m "checkpoint: before slot machine run — [brief task description]"
```

**This is the safety step.** Never skip it. It takes 10 seconds and gives you infinite rollback.

### Step 3: Pull the lever (enable auto-accept)

Enable auto-accept mode in Claude Code: **`Shift+Tab`**

Then paste your task description and say:
> *"You have full autonomy. Work through this task completely. Commit your changes as you go using `git commit -m "..." ` after each logical step. If you get stuck, stop and explain why rather than guessing."*

### Step 4: Wait (20–30 min)

Walk away. Get coffee. Check back every ~10 minutes to confirm Claude is still making progress (look for activity in the terminal / file changes). 

If Claude has been silent for more than 5 minutes, check if it's stuck — ask "Are you still working? What's the current state?"

### Step 5: Accept or Reset

**If it worked:** Review the diff (`git diff HEAD~5 HEAD`), verify tests pass, merge.
```bash
git log --oneline   # Review all commits from the run
npm test            # Or pytest / colcon test depending on language
git push            # If satisfied
```

**If it went wrong:** One command, instant rollback.
```bash
git reset --hard HEAD  # Returns to your pre-run checkpoint instantly
```

Then analyze what went wrong and either try again with a more specific task description, or switch to manual execution.

---

## 4. Success Rate Expectations

Per Anthropic's RL Engineering team findings:
- Works on first attempt: **~1/3 of the time**
- Works after iteration: **~2/3 of the time**
- Requires manual fallback: **~1/3 of the time**

This is expected. The time saved when it works (30 mins → 2 mins) more than compensates for the resets. Think of it as a portfolio of attempts, not individual transactions.

---

## 5. Common Tasks This Works Well For

| Task Type | Configuration Note |
|---|---|
| Rename a function/variable across entire codebase | Add: "Use sed or AST-based rename — not find/replace" |
| Fix all TypeScript errors in a file | Add: "Do not change function signatures" |
| Resolve git merge conflicts | Add: "Prefer the main branch version unless it's clearly wrong" |
| Add docstrings to all functions in a module | High success rate — very mechanical |
| Convert synchronous code to async | Medium success — review carefully |
| Large CSS/Tailwind refactoring | High success rate |
| Migrating from one library to another | Risky — use synchronous mode |

---

## 6. Safety Rules

1. **NEVER skip the git checkpoint.** This is the entire point of the pattern.
2. **One task at a time** — don't give Claude two goals in the same slot machine run.
3. **Test before pushing.** Always run your test suite after a successful run before pushing to `main`.
4. **No production deployments** from a slot machine run without human build verification.
5. **If in doubt, manual fallback.** The pattern should save time, not create stress.

---

## 7. Custom Slash Commands

| Command | What it does |
|---|---|
| `/slot-machine [task description]` | Run the 5-step protocol from scratch |
| `/slot-checkpoint` | Run Step 2 git checkpoint |
| `/slot-rollback` | Run `git reset --hard HEAD` rollback |
| `/slot-review` | Run diff review and test verification |

For the Antigravity Skill wrapper: see `.agent/skills/slot-machine.md`

---

## 8. Session-End Ritual

Log result to root `CHANGELOG.md`: `YYYY-MM-DD | Slot Machine | [Task attempted] | [Result: Success/Rollback]`

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Initial creation: full 5-step protocol, success rate calibration, and task type guide per Anthropic Data Science + RL Engineering teams | Setup |
