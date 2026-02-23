# Multi-Agent Orchestration — Enterprise Edition
# Claude Opus 4.6 as Orchestrator | Sonnet 4.5 as Specialists
# Feb 2026 | enterprise/multi-agent/

---

## When to Use Enterprise Multi-Agent Mode

Enterprise multi-agent mode (10+ parallel agents) is appropriate when:
- You need to process 500+ items simultaneously (e.g., security scan across 200 files, generate ad variants for 1,000 SKUs)
- You have time-constrained deliverables that a single agent would take hours to complete
- Quality requires separate specialist expertise that degrades when combined in one prompt

**Do NOT use for:** Tasks requiring sequential judgment (one output informs the next), regulatory or compliance reviews where auditability of individual decisions matters.

---

## Cost-Optimized Architecture (Feb 2026 Pricing)

| Agent Role | Recommended Model | Why |
|---|---|---|
| Orchestrator | Claude Opus 4.6 | Best reasoning for task decomposition |
| Specialist (bulk) | Claude Sonnet 4.5 | High speed, lower cost for repetitive work |
| Validator | Claude Sonnet 4.5 | Schema checking doesn't need Opus capabilities |
| Escalation Reviewer | Claude Opus 4.6 | Human-equivalent judgment for edge cases |

**Cost Control Rule:** Always estimate tokens before a large run.  
Prompt: *"Estimate the total cost of running this workflow for [N] items at Sonnet 4.5 pricing. Show calculation."*  
Require manager approval for runs expected to cost > $20.

---

## Standard Enterprise Agent Team Template

```python
import anthropic
import asyncio
from typing import Any

client = anthropic.Anthropic()

ORCHESTRATOR_SYSTEM = """
You are the Orchestrator Agent for an enterprise-scale workflow.
Decompose the task into exactly [N] specialist jobs.
Each job must be independently executable with no dependencies between specialists.
Output a JSON list of jobs: [{"job_id": 1, "prompt": "...", "schema": {...}}, ...]
"""

SPECIALIST_SYSTEM = """
You are Specialist Agent #{job_id}.
Your ONLY task: {job_description}
Output MUST conform to this schema: {schema}
Do NOT attempt anything outside your single responsibility.
"""

VALIDATOR_SYSTEM = """
You are the Validator Agent. Check each specialist output against the provided schema.
Return: {"job_id": N, "status": "PASS"|"FAIL", "reason": "...", "output": {...}}
For FAIL: describe exactly what is wrong so the specialist can be retried.
"""

async def run_specialist(job: dict) -> dict:
    """Run a single specialist agent for one job."""
    response = client.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=2048,
        system=SPECIALIST_SYSTEM.format(**job),
        messages=[{"role": "user", "content": job["prompt"]}]
    )
    return {"job_id": job["job_id"], "output": response.content[0].text}

async def enterprise_orchestrate(task: str, n_specialists: int) -> list[dict]:
    """Full enterprise multi-agent orchestration flow."""
    # Step 1: Orchestrator decomposes task
    decomposition = client.messages.create(
        model="claude-opus-4-5",
        max_tokens=4096,
        system=ORCHESTRATOR_SYSTEM.replace("[N]", str(n_specialists)),
        messages=[{"role": "user", "content": task}]
    )
    import json
    jobs = json.loads(decomposition.content[0].text)

    # Step 2: Run all specialists in parallel
    results = await asyncio.gather(*[run_specialist(job) for job in jobs])

    # Step 3: Validate all results
    validated = []
    for result in results:
        validation = client.messages.create(
            model="claude-sonnet-4-5",
            max_tokens=1024,
            system=VALIDATOR_SYSTEM,
            messages=[{"role": "user", "content": json.dumps(result)}]
        )
        validated.append(json.loads(validation.content[0].text))

    # Step 4: Re-run failed jobs (max 1 retry)
    for v in validated:
        if v["status"] == "FAIL":
            retry = await run_specialist(jobs[v["job_id"] - 1])
            validated[v["job_id"] - 1] = retry

    return validated
```

---

## Enterprise Safety Rules for Multi-Agent Runs

1. **Maximum 50 parallel agents** without platform engineering review.
2. **Exponential backoff required** on all API calls — never retry immediately.
3. **Log all agent outputs** to a file before passing downstream — never process in-memory only.
4. **Stop at 20% failure rate:** If more than 20% of specialists fail validation, halt the run and notify the operator.
5. **Git checkpoint before every run**, even short ones.
6. **Runs over $20 API cost** require manager approval before starting.
