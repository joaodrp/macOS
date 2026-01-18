#!/usr/bin/env bash
# Temporary workaround for https://github.com/obra/superpowers/issues/237
# Injects superpowers discipline framework into subagents
# Remove once superpowers plugin includes SubagentStart hook

set -euo pipefail

# Find the superpowers skill content
skill_file=$(find ~/.claude/plugins/cache/claude-plugins-official/superpowers -name "SKILL.md" -path "*/using-superpowers/*" 2>/dev/null | head -1)

if [[ ! -f "$skill_file" ]]; then
    echo '{}'
    exit 0
fi

# Read skill content
content=$(cat "$skill_file")

# Escape for JSON
escape_for_json() {
    local input="$1"
    local output=""
    local i char
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        case "$char" in
            $'\\') output+='\\' ;;
            '"') output+='\"' ;;
            $'\n') output+='\n' ;;
            $'\r') output+='\r' ;;
            $'\t') output+='\t' ;;
            *) output+="$char" ;;
        esac
    done
    printf '%s' "$output"
}

escaped=$(escape_for_json "$content")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SubagentStart",
    "additionalContext": "<EXTREMELY_IMPORTANT>\nYou have superpowers.\n\n**Below is the full content of your 'superpowers:using-superpowers' skill - your introduction to using skills. For all other skills, use the 'Skill' tool:**\n\n${escaped}\n\n</EXTREMELY_IMPORTANT>"
  }
}
EOF
