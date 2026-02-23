---
name: sub-agent-spawner
description: Orchestrates multi-agent workflows by decomposing a task, spawning specialist sub-agents, running them in parallel, validating outputs, and merging results. Used by marketing, code-gen, robotics, and web-dev teams.
---

# Sub-Agent Spawner Skill

## Purpose

Run this skill when a task is too complex for a single prompt — when it needs parallel specialists working simultaneously for best quality. This implements the sub-agent pattern documented across all team CLAUDE.md files.

## When to Invoke

Use when the user says:
- "Use sub-agents for this"
- "Spawn specialists"
- "This task is big enough to split up"
- "Run the orchestrator pattern"

Default indicators: task has more than 3 distinct output types, or expected run time > 10 minutes as a single agent.

## Execution Steps

### Step 1: Decompose the task

Read the task and identify:
- **Inputs:** What data are we starting with?
- **Outputs:** What are the distinct output types? (Each becomes one specialist)
- **Dependencies:** Can outputs be generated in parallel, or does Specialist B need Specialist A's output first?
- **Validation rules:** How do we know each output is correct?

Output a decomposition table before proceeding:
```
| Agent | Job | Input | Output | Can parallelize? |
|---|---|---|---|---|
```

Get confirmation before spawning agents.

### Step 2: Define system prompts for each specialist

Each specialist needs a tight, focused system prompt:
```
You are a [SPECIALIST_NAME]. Your ONLY job is to [SINGLE_RESPONSIBILITY].
Input: [exact input format]
Output: [exact output format with schema]
Constraints: [hard rules, e.g., "headlines must be ≤ 30 characters"]
Do NOT: [what to avoid — e.g., "do not attempt descriptions"]
```

### Step 3: Run specialists

**If parallelizable:** Announce running agents simultaneously. Process all inputs through all specialists, collecting outputs.

**If sequential:** Run Specialist A, validate output, then pass to Specialist B.

Report progress: "✅ Specialist 1 complete (X items)", "⏳ Specialist 2 running..."

### Step 4: Run Validator Agent

The validator checks all outputs against the schema and validation rules.

For each output item, run the checklist defined in the team's CLAUDE.md Section 6.

If any item fails: regenerate that specific item only (do not re-run the entire batch).

### Step 5: Assemble and deliver

Merge validated outputs into the final format. Output:
```
## Sub-Agent Run Summary
- Orchestrator: [task description]
- Specialists run: [N agents]
- Items processed: [M items]
- Validation: [X passed / Y failed / Z regenerated]
- Output file: [filename]
```

## Reference Architectures by Team

| Team | Agents | See |
|---|---|---|
| Marketing | Headline Agent + Description Agent + Validator | `non-technical/marketing/CLAUDE.md` Section 5 |
| Finance-HR | Data Agent + Writer Agent | `non-technical/finance-hr/CLAUDE.md` Section 5 |
| Robotics | Parser + Node Builder + Launch Builder + Test + Validator | `technical/robotics/CLAUDE.md` Section 5 |
| Code-Gen | Orchestrator + Specialist + Validator + Memory | `technical/code-generation/CLAUDE.md` Section 5 |
| Web-Dev | Component Agents + Assembly + Test + Validator | `technical/web-dev/CLAUDE.md` Section 5 |

## Error Handling

- If a specialist consistently fails at one item type: log it, skip it, and flag for human review. Never block the entire batch.
- If the validator fails more than 20% of items: stop and report — the specialist's system prompt likely needs revision.
- Always commit intermediate results: `git commit -m "agents: [N] items complete, continuing..."`
