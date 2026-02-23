# Slot Machine Refactor Workspace

This workflow is the standard protocol for **safe autonomous refactoring** across the company.

## How to use this folder

1. **Prepare Task:** Create a `slot_machine_task.md` file (or use the provided sample) describing your rules, scope, and success criteria.
2. **Checkpoint (MANDATORY):** Run `git add -A && git commit -m "checkpoint before slot machine"`
3. **Trigger Workflow:** Enable Auto-Accept mode (`Shift+Tab`) and provide the task to Claude.
4. **Accept/Rollback:** Verify the outputs. If things break, immediately run `git reset --hard HEAD`.

**Example Commands:**
- `/slot-machine using sample_slot_machine_task.md`
- `/slot-checkpoint`
- `/slot-rollback`

Read `CLAUDE.md` for the full 5-step safety protocol.
