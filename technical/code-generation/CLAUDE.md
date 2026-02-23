# Code Generation — CLAUDE.md
# Version 1.0 | Cookbook-SME-Robotics

---

## 1. Role & Context

You are assisting the **Code Generation and AI Tooling team** at a 100-person robotics and web development SME.

**Team size:** ~8 engineers (senior technical)  
**Core domain:** Building agentic workflows, sub-agent systems, Claude API integrations, developer productivity tools.

We use Claude Code to build better Claude Code workflows — the "Claude Code building Claude Code" pattern. Our job is to create the internal tools, templates, and automation pipelines that make every other team in this company more productive.

---

## 2. Audience Instructions

- Assume **expert Python and API fluency.** No hand-holding needed.
- All generated code must be production-ready with full error handling, type hints, and logging.
- Prefer the **Anthropic Python SDK** (`anthropic`) for all Claude API interactions.
- Always generate tests before or alongside implementation.
- Use the sub-agent spawner pattern (Section 5) for any multi-step workflow.

---

## 3. Tools & Environment

| Tool | Purpose | Notes |
|---|---|---|
| `anthropic` Python SDK | Claude API calls | `pip install anthropic` |
| `asyncio` | Async agent execution | Prefer async for parallel sub-agents |
| `sqlite3` / SQLite | Lightweight state persistence | For agent memory and task logs |
| `pytest` | Testing framework | Always generate tests via Workflow B |
| GitHub Actions | CI/CD | Auto-PR review via Claude integration |
| Git | Version control | Checkpoint before all autonomous runs |

**Environment setup:**
```bash
pip install anthropic python-dotenv pytest
export ANTHROPIC_API_KEY="your-key-here"  # Or use .env + python-dotenv
```

**MCP Boundaries:**
- ✅ Allowed: Read/write local files, Claude API calls, GitHub API (for PR review)
- ❌ Forbidden: Access customer data repositories, production databases, or deploy to prod without human sign-off

---

## 4. Primary Workflows

### Workflow A: Build a New Sub-Agent Workflow

**When to use:** When any team needs a repeatable automation (ad generation, report writing, code review, etc.).

```
Step 1: Gather requirements:
   - What is the input? (CSV, image, text, URL)
   - What is the output? (CSV, Markdown, code file, API call)
   - What are the validation rules?
   - How many parallel agents are needed?
Step 2: Design the agent architecture (use Section 5 pattern)
Step 3: Generate the orchestrator agent first with a clear task decomposition prompt
Step 4: Generate each specialist agent with a focused single-responsibility prompt
Step 5: Generate the validator agent with the output schema
Step 6: Generate pytest tests for each agent
Step 7: Run tests; iterate until passing
Step 8: Write usage instructions to [workflow_name]/README.md
Step 9: git commit -m "feat: [workflow_name] sub-agent workflow"
```

### Workflow B: Test Generation for Existing Workflow

**When to use:** To verify an existing agent produces consistent, correct outputs.

```
Step 1: Read the target agent file
Step 2: Identify: input schema, output schema, business logic rules
Step 3: Generate pytest tests covering:
   - Happy path (valid input → valid output)
   - Schema validation failure (malformed input)
   - API timeout / retry behavior
   - Edge cases specific to this domain
Step 4: Use mock Claude API responses to avoid real API costs in tests
Step 5: Run and verify all tests pass
```

### Workflow C: PR Review Bot (GitHub Actions)

**When to use:** To set up automated code review on pull requests.

```
Step 1: Generate a GitHub Actions workflow file (.github/workflows/claude-review.yml)
Step 2: On every PR, the workflow:
   - Fetches the diff
   - Sends it to Claude with the team's CLAUDE.md as system context
   - Posts a structured review comment: [PASS / NEEDS CHANGES / QUESTIONS]
Step 3: Include the /security-review checklist in every review
Step 4: Never auto-merge — Claude comments only, human merges
```

---

## 5. Sub-Agent Architecture (Standard Pattern)

```python
import anthropic
import asyncio

client = anthropic.Anthropic()

async def run_specialist_agent(name: str, system: str, prompt: str) -> str:
    """Run a single specialist sub-agent."""
    response = client.messages.create(
        model="claude-opus-4-5",
        max_tokens=2048,
        system=system,
        messages=[{"role": "user", "content": prompt}]
    )
    return response.content[0].text

async def orchestrate(task: str) -> dict:
    """Orchestrate parallel sub-agents for a given task."""
    # Spawn all specialists concurrently
    results = await asyncio.gather(
        run_specialist_agent("Specialist1", SYSTEM_1, task),
        run_specialist_agent("Specialist2", SYSTEM_2, task),
    )
    # Validate and merge
    return {"specialist1": results[0], "specialist2": results[1]}
```

| Agent Type | Responsibility |
|---|---|
| **Orchestrator** | Decompose task, spawn specialists, merge results |
| **Specialist** | Single-focus job (e.g., "only write headlines", "only write tests") |
| **Validator** | Verify output against schema before delivery |
| **Memory Agent** | Log results to SQLite for future context |

Reference: `.agent/skills/sub-agent-spawner.md`

---

## 6. Output Schema & Validation

**All code generation outputs must include:**
```
[module_name]/
├── [agent_name].py         # Main agent file
├── test_[agent_name].py    # pytest tests
├── README.md               # Usage instructions
└── requirements.txt        # Dependencies
```

**Validation checklist:**
- [ ] All pytest tests pass (`pytest -v`)
- [ ] No hardcoded API keys or secrets
- [ ] Type hints on all function signatures
- [ ] Docstrings on all classes and public methods
- [ ] README includes: purpose, setup, usage example, output schema

---

## 7. Safety & Forbidden Actions

1. **Git checkpoint first.** `git add -A && git commit -m "checkpoint"` before any autonomous generation run.
2. **Never hardcode** API keys, credentials, or secrets — always use environment variables.
3. **Never auto-deploy** generated agents to production without human review.
4. **Rate limiting:** All agents must implement exponential backoff on API retries.
5. **Cost control:** Estimate token usage before running large batch jobs. Require confirmation for runs expected to cost > $5.
6. **Run `/security-review` on all PRs** containing new agent code.

---

## 8. Custom Slash Commands

| Command | What it does |
|---|---|
| `/build-workflow [description]` | Run Workflow A end-to-end |
| `/generate-tests [agent_file]` | Run Workflow B for an existing agent |
| `/setup-pr-review` | Run Workflow C to configure GitHub Actions bot |
| `/security-review` | Run security checklist (see `cross-team/security-review/`) |
| `/estimate-cost [prompt_count] [avg_tokens]` | Estimate Claude API cost before a batch run |

---

## 9. Session-End Ritual

At the end of every session, ask Claude:
> *"Summarize what we did and suggest 3 improvements to this CLAUDE.md."*

Then:
1. Add suggestions to `## Lessons Learned` below.
2. Log to root `CHANGELOG.md`: `YYYY-MM-DD | Code-Gen | [What changed]`
3. `git commit -m "session-end: code-gen [brief]"`

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Initial creation: sub-agent architecture, PR review bot, async orchestration pattern, cost control | Setup |
