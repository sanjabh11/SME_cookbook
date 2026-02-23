# Code Generation & AI Tooling Workspace

This workspace is configured for the **Code Generation team**.

## How to use this folder

1. **Review Architecture:** Check `CLAUDE.md` for the standard sub-agent architecture and rules for writing "Claude Code that builds Claude Code".
2. **Provide Input:** Describe the agent or tool you want to build in a text file (e.g., `sample_agent_request.txt`).
3. **Trigger Workflow:** Ask Claude to build the workflow or generate tests.

**Example Prompts:**
- `/build-workflow using sample_agent_request.txt`
- `/setup-pr-review`
- `Generate pytest coverage for my_agent.py`
