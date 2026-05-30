---
name: git-commit
description: Auto-commit changes after a command completes
---

# Auto-Commit Changes

Automatically stage and commit all changes after a command completes.

## Behavior

This command is invoked as a hook after (or before) core commands. It:

1. Determines the event name from the hook context (e.g., if invoked as an `after_specify` hook, the event is `after_specify`; if `before_plan`, the event is `before_plan`)
2. Checks `references/commit-messages.yml` for the `commit_messages` section
3. Looks up the specific event key and uses the per-command `message` if configured, otherwise a default message
4. If there are uncommitted changes, runs `git add .` + `git commit`

## Execution

Determine the event name from the hook that triggered this command, then run the appropriate script based on your platform:

- **Bash**: `scripts/auto-commit.sh <event_name>`

Replace `<event_name>` with the actual hook event (e.g., `after_specify`, `before_plan`, `after_implement`).

## Graceful Degradation

- If Git is not available or the current directory is not a repository: skips with a warning
- If no changes to commit: skips with a message