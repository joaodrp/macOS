---
description: Save current work progress to the in-progress beads issue
allowed-tools: Bash(bd:*)
model: claude-haiku-4-5
---

# Save Progress to Issue

Add a detailed progress comment to the current in-progress issue(s).

## Current In-Progress Issues

!`bd list --status=in_progress`

## Task

For EACH in-progress issue:

### Step 1: Review existing context

```bash
bd show <issue-id>
```

### Step 2: Identify what's NEW

Compare conversation context and TodoWrite items against what's already in the issue/comments.

Only include NEW progress:
- New completions since last comment
- Changed status on current work
- New next steps
- New blockers discovered

### Step 3: Add progress comment (only if there's new info)

```bash
bd comments add <issue-id> "$(cat <<'EOF'
**Completed:**
- Item 1 (NEW since last update)

**In Progress:**
- Current work item

**Next:**
- Planned step 1

**Blockers:** None (or list any)
EOF
)"
```

Skip if the last comment already captures the current state.

Be specific - this comment recovers context if the session is lost.
