function ta -d "Attach to tmux session (default: main)"
    set -l session (string trim -- $argv[1]; or echo main)
    tmux new-session -A -s $session
end
