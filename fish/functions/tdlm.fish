# Adapted from https://github.com/basecamp/omarchy
function tdlm -d "Create a tdl window per subdirectory in the current directory"
    if test (count $argv) -lt 1
        echo "usage: tdlm <command> [<second_command>]"
        return 1
    end

    if test -z "$TMUX"
        echo "You must start tmux to use tdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l base_dir $PWD
    set -l first true

    tmux rename-session (basename $base_dir | tr '.:' '--')

    for dir in $base_dir/*/
        test -d $dir; or continue
        set -l dirpath (string trim -r -c / $dir)

        if test $first = true
            tmux send-keys -t $TMUX_PANE "cd '$dirpath' && tdl $ai $ai2" C-m
            set first false
        else
            set -l pane_id (tmux new-window -c $dirpath -P -F '#{pane_id}')
            tmux send-keys -t $pane_id "tdl $ai $ai2" C-m
        end
    end
end
