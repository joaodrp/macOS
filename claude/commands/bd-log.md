---
description: Quickly create a beads issue for something discovered during current work
argument-hint: <brief description of the problem>
allowed-tools: Bash(bd:*), Task
---

# Create Discovered Issue

You are helping the user quickly log a problem they spotted while working on something else.

## Quick Execution

This command should be fast and minimal:

1. **Use the Task tool** to spawn a subagent (bd create is instant, no need for background)
2. **Show the created issue ID** from the subagent result
3. **Resume** whatever work was in progress before this command was invoked

## Context

Current in-progress beads issue(s):
!`bd list --status=in_progress --json 2>/dev/null || echo "[]"`

## User's Description

$ARGUMENTS

## Your Task

Based on the user's description, create a beads issue with:

1. **Title**: A concise, descriptive title (imperative mood, e.g., "Fix X", "Add Y", "Update Z")

2. **Type**: Choose the most appropriate:
   - `bug` - Something is broken or incorrect
   - `task` - Technical work, refactoring, maintenance
   - `feature` - New user-facing functionality
   - `chore` - Config, dependencies, tooling

3. **Priority**: Based on severity:
   - `P1` - Critical path, blocks core functionality
   - `P2` - Important but not blocking (default for most discoveries)
   - `P3` - Nice to have, can wait
   - `P4` - Backlog, future consideration

4. **Labels**: Add relevant labels based on the domain/tech involved (check existing labels with the project)

5. **Description**: Expand on what the user described with any relevant context

6. **Dependencies**:
   - If user mentions an **epic** (e.g., "in phase 7 epic", "for epic X"), use `--parent <epic-id>` to set parent-child relationship
   - If there's an **in-progress issue**, add `--deps discovered-from:<issue-id>`
   - Both can be used together

## Command Format

```bash
# With parent epic:
bd create --title="<title>" --type=<type> --priority=<P1-P4> -l <labels> -d "<description>" --parent <epic-id> --deps discovered-from:<current-issue>

# Without parent epic:
bd create --title="<title>" --type=<type> --priority=<P1-P4> -l <labels> -d "<description>" --deps discovered-from:<current-issue>
```

## Rules

- Keep the title under 60 characters
- Always add a description explaining the issue
- If user mentions an epic, look up the epic ID and use `--parent`
- If no in-progress issue exists, skip the `--deps` flag
- Do NOT ask for confirmation - just create the issue immediately

## Subagent Instructions

Pass ALL of the above context (User's Description, Your Task, Command Format, Rules) to the subagent. The subagent should:

1. Analyze the user's description
2. If user mentions an epic, run `bd list --type=epic` to find the epic ID
3. Determine appropriate title, type, priority, labels
4. Run `bd create` with the proper arguments (including `--parent` if epic mentioned)
5. Return the created issue ID and title (e.g., "Created health-123: Fix button alignment")

Use `subagent_type: "general-purpose"` (no background - bd create is instant).
