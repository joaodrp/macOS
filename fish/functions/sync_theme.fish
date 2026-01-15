function sync_theme --description 'Sync bat, delta, fzf, and mitmproxy themes with macOS appearance'
    # Detect current macOS appearance (dark mode returns 0, light mode returns error)
    if defaults read -g AppleInterfaceStyle &>/dev/null
        set mode dark
    else
        set mode light
    end

    # --- bat ---
    set -l bat_config (realpath ~/.config/bat/config 2>/dev/null)
    if test -n "$bat_config" -a -f "$bat_config"
        if test $mode = dark
            sed -i "s/^--theme=.*/--theme='gruvbox-dark'/" "$bat_config"
        else
            sed -i "s/^--theme=.*/--theme='gruvbox-light'/" "$bat_config"
        end
    end

    # --- delta (git pager) ---
    set -l git_config (realpath ~/.gitconfig 2>/dev/null)
    if test -n "$git_config" -a -f "$git_config"
        if test $mode = dark
            sed -i 's/syntax-theme = gruvbox-light/syntax-theme = gruvbox-dark/' "$git_config"
        else
            sed -i 's/syntax-theme = gruvbox-dark/syntax-theme = gruvbox-light/' "$git_config"
        end
    end

    # --- mitmproxy ---
    set -l mitm_config (realpath ~/.mitmproxy/config.yaml 2>/dev/null)
    if test -n "$mitm_config" -a -f "$mitm_config"
        if test $mode = dark
            sed -i 's/^console_palette:.*/console_palette: solarized_dark/' "$mitm_config"
        else
            sed -i 's/^console_palette:.*/console_palette: solarized_light/' "$mitm_config"
        end
    end

    # --- fzf (Gruvbox theme from tinted-fzf) ---
    if test $mode = dark
        source ~/.config/fish/fzf/gruvbox-dark-hard.fish
    else
        source ~/.config/fish/fzf/gruvbox-light-hard.fish
    end
end
