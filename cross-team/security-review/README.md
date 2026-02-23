# Security Review Workspace

This workflow implements the company's **8-category security review checklist**.

## How to use this folder

1. **Review Criteria:** Read `CLAUDE.md` to understand the 8 categories checked during a security review.
2. **Provide Diff:** Paste your pull request diff or describe the branch changes (e.g., `sample_diff.txt`).
3. **Trigger Workflow:** Command Claude to assess the changes.

**Example Commands:**
- `/security-review (with a git diff pasted)`
- `Review the changes in sample_diff.txt against our security guidelines`

If any item is marked `FAIL`, it must be resolved before merging. See the Escalation Rules in `CLAUDE.md`.
