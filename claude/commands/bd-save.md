---
description: Save current work progress to the in-progress beads issue (user)
allowed-tools: Bash(bd:*)
---

# Save Progress to Issue

Add a detailed progress comment to the current in-progress issue(s).

## Current In-Progress Issues

!`bd list --status=in_progress`

## Your Task

For EACH in-progress issue:

### Step 1: Review existing context

First, look at what's already been captured in the issue (includes comments):

```bash
bd show <issue-id>
```

### Step 2: Identify what's NEW

Compare the conversation context and TodoWrite items against what's already in the issue/comments.

Only include NEW progress that isn't already captured:
- New completions since the last comment
- Changed status on current work
- New next steps
- New blockers discovered

### Step 3: Add progress comment (only if there's new info)

If there's meaningful new progress to capture:

```bash
bd comments add <issue-id> "$(cat <<'EOF'
**Completed:**
- Item 1 (NEW since last update)
- Item 2

**In Progress:**
- Current work item

**Next:**
- Planned step 1
- Planned step 2

**Blockers:** None (or list any)
EOF
)"
```

Skip adding a comment if the last comment already captures the current state.

Be specific and detailed - this comment will be used to recover context if the session is lost.
