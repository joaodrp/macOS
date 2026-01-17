---
description: Quickly create a beads issue for something discovered during current work
argument-hint: <brief description of the problem>
allowed-tools: Bash(bd:*)
context: fork
agent: general-purpose
model: claude-haiku-4-5
---

# Create Discovered Issue

You are helping the user quickly log a problem they spotted while working on something else.

## Context

Current in-progress beads issue(s):
!`bd list --status=in_progress --json 2>/dev/null || echo "[]"`

## User's Description

$ARGUMENTS

## Task

Based on the user's description, create a beads issue with:

1. **Title**: Concise, imperative mood (e.g., "Fix X", "Add Y")

2. **Type**: `bug` | `task` | `feature` | `chore`

3. **Priority**: `P1` (critical) | `P2` (important, default) | `P3` (nice to have) | `P4` (backlog)

4. **Labels**: Relevant domain/tech labels

5. **Description**: Expand on user's description with context

6. **Dependencies**:
   - If user mentions an **epic**, use `--parent <epic-id>` (run `bd list --type=epic` to find ID)
   - If there's an **in-progress issue**, add `--deps discovered-from:<issue-id>`

## Command Format

```bash
bd create --title="<title>" --type=<type> --priority=<P1-P4> -l <labels> -d "<description>" [--parent <epic-id>] [--deps discovered-from:<issue-id>]
```

## Rules

- Keep title under 60 characters
- Always add a description
- Skip `--deps` if no in-progress issue exists
- Do NOT ask for confirmation - create immediately
- Return the created issue ID and title (e.g., "Created health-123: Fix button alignment")
