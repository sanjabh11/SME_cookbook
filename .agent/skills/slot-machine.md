---
name: slot-machine
description: Safely delegates complex autonomous refactoring tasks using the git-checkpoint → auto-accept → accept/rollback pattern used by Anthropic's Data Science and RL Engineering teams.
---

# Slot Machine Skill

## Purpose

Run this skill when a user wants to delegate a complex, mechanical refactoring or generation task to Claude autonomously — with a guaranteed rollback safety net.

## When to Invoke

Use this skill when the user says phrases like:
- "Handle this autonomously"
- "Just do it and I'll review"
- "This is too tedious to do manually"
- "Run the slot machine on this"

Do NOT use for: core business logic, security-sensitive files, production deployments.

## Execution Steps

### Step 1: Gather the task spec
Ask the user to fill in this template if not already provided:
```
TASK: [one sentence]
SCOPE: [files or directories]
RULES: [constraints]
SUCCESS: [how to verify it worked]
```

### Step 2: Perform git checkpoint (MANDATORY)
```bash
git add -A && git commit -m "checkpoint: before slot machine — [task brief]"
```
Confirm this ran before proceeding.

### Step 3: Enable autonomous execution
Announce: *"Slot machine running. I'll work autonomously and commit progress as I go. Check back in 20–30 minutes."*

Enable auto-accept behavior. Commit after each logical unit of work with descriptive messages.

### Step 4: Self-verify on completion
After completing the task, run the success criteria defined by the user:
- For JS/TS: `npm run build && npm run lint && npm test`
- For Python: `pytest -v`
- For ROS2: `colcon test --packages-select [name]`

Report results clearly: "✅ All tests pass" or "⚠️ 2 tests failing in [file] — reason: [explain]"

### Step 5: Deliver summary
Output:
```
## Slot Machine Summary
- Task: [what was done]
- Files changed: [list]
- Commits made: [count]
- Tests: [PASS / FAIL + detail]
- Recommended: [ACCEPT / ROLLBACK + reason]
```

## Rollback Command (if needed)
```bash
git reset --hard HEAD
```

## Success Rate Calibration
- First-attempt success: ~1/3 of tasks
- With iteration: ~2/3 of tasks  
- Manual fallback required: ~1/3 of tasks  
This is expected. Time savings when it works compensate for resets.
