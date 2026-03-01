# Adapted from https://github.com/basecamp/omarchy
function tdl -d "Create a tmux dev layout with editor, AI, and terminal"
    if test (count $argv) -lt 1
        echo "usage: tdl <command> [<second_command>]"
        return 1
    end

    if test -z "$TMUX"
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir $PWD
    set -l editor_pane $TMUX_PANE
    set -l ai $argv[1]
    set -l ai2 $argv[2]

    tmux rename-window -t $editor_pane (basename $current_dir)

    # Bottom terminal pane (15%)
    tmux split-window -v -p 15 -t $editor_pane -c $current_dir

    # Right AI pane (30%)
    set -l ai_pane (tmux split-window -h -p 30 -t $editor_pane -c $current_dir -P -F '#{pane_id}')

    # Optional second AI pane below the first
    if test -n "$ai2"
        set -l ai2_pane (tmux split-window -v -t $ai_pane -c $current_dir -P -F '#{pane_id}')
        tmux send-keys -t $ai2_pane $ai2 C-m
    end

    tmux send-keys -t $ai_pane $ai C-m
    tmux send-keys -t $editor_pane "$EDITOR ." C-m
    tmux select-pane -t $editor_pane
end
