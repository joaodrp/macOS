#!/bin/bash
# Validate git commit messages - block Claude/Happy co-author footers
# Exit 0 = allow, Exit 2 = block

# Read JSON input from stdin
input=$(cat)

# Extract tool name and command
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# Only check Bash tool with git commit
if [[ "$tool_name" != "Bash" ]]; then
    exit 0
fi

if ! printf '%s' "$command" | grep -qE '\bgit\s+commit\b'; then
    exit 0
fi

# Check for forbidden patterns (use printf to preserve newlines in HEREDOCs)
if printf '%s' "$command" | grep -qiE 'Generated with \[?Claude Code\]?'; then
    echo "Commit message contains 'Generated with Claude Code' footer - not allowed per AGENTS.md" >&2
    exit 2
fi

if printf '%s' "$command" | grep -qiE 'Co-Authored-By:\s*(Claude|Happy)'; then
    echo "Commit message contains Co-Authored-By Claude/Happy footer - not allowed per AGENTS.md" >&2
    exit 2
fi

# Allow the commit
exit 0
