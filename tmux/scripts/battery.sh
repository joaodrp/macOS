#!/usr/bin/env bash
# Returns "ICON  85%" if battery present, empty string if not

ICON=$'\uf240'

if uname | grep -q Darwin; then
    b=$(pmset -g batt 2>/dev/null | grep -oE '[0-9]+%' | head -1)
else
    cap=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
    [ -n "$cap" ] && b="${cap}%"
fi

[ -n "$b" ] && echo "${ICON}  ${b}"
