#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
user=$(whoami)
dir=$(basename "$cwd")

# Get git branch and dirty status
git_branch=""
git_dirty=""
if [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    [ -n "$branch" ] && git_branch=" ($branch)"

    # Check for uncommitted changes
    if ! git -C "$cwd" --no-optional-locks diff --quiet HEAD 2>/dev/null || \
       [ -n "$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null)" ]; then
        git_dirty=$(printf ' \033[31m✗\033[0m')
    fi
fi

# Get model name
model_display=""
model_name=$(echo "$input" | jq -r '.model.display_name // empty')
if [ -n "$model_name" ] && [ "$model_name" != "null" ]; then
    # Use short name (e.g., "Opus 4.5" -> "Opus 4.5")
    model_display=$(printf ' | \033[2;37m%s\033[0m' "$model_name")
fi

# Get session duration from cost.total_duration_ms
duration_display=""
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
if [ -n "$duration_ms" ] && [ "$duration_ms" != "null" ] && [ "$duration_ms" -gt 0 ] 2>/dev/null; then
    elapsed=$((duration_ms / 1000))
    hours=$((elapsed / 3600))
    minutes=$(((elapsed % 3600) / 60))
    if [ $hours -gt 0 ]; then
        duration_display=$(printf ' | \033[2;37m%dh%dm\033[0m' "$hours" "$minutes")
    else
        duration_display=$(printf ' | \033[2;37m%dm\033[0m' "$minutes")
    fi
fi

# Calculate context usage and percentage
context_info=""
size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

if [ -n "$size" ] && [ "$size" != "null" ] && [ "$size" -gt 0 ] 2>/dev/null; then
    # Use total_input_tokens as current usage
    current=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')

    pct=$((current * 100 / size))

    # Format with K suffix for readability
    if [ $current -ge 1000 ]; then
        current_k=$(echo "scale=1; $current / 1000" | bc)
        current_fmt="${current_k}K"
    else
        current_fmt=$current
    fi

    # Orange (208) if > 80%, yellow (33) otherwise
    if [ $pct -gt 80 ]; then
        pct_color="38;5;208"
    else
        pct_color="33"
    fi

    context_info=$(printf ' | \033[35m%s\033[0m (\033[%sm%d%%\033[0m)' "$current_fmt" "$pct_color" "$pct")
fi

# Output: yellow user, "in", cyan dir, dimmed branch, dirty indicator, context, model, duration
printf '\033[33m%s\033[0m in \033[36m%s\033[0m\033[2;37m%s\033[0m%s%s%s%s' \
    "$user" "$dir" "$git_branch" "$git_dirty" "$context_info" "$model_display" "$duration_display"
