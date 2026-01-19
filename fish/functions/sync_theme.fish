function sync_theme --description 'Sync bat, delta, fzf, mitmproxy, Claude Code, and Gemini CLI themes with macOS appearance'
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

    # --- Claude Code ---
    if test -f ~/.claude.json; and command -q jq
        set -l claude_theme (test $mode = dark; and echo "dark-ansi"; or echo "light-ansi")
        set -l current_theme (jq -r '.theme // empty' ~/.claude.json 2>/dev/null)
        if test "$current_theme" != "$claude_theme"
            set -l tmp (mktemp)
            jq --arg theme "$claude_theme" '.theme = $theme' ~/.claude.json > $tmp && mv $tmp ~/.claude.json
        end
    end

    # --- Gemini CLI ---
    set -l gemini_config (realpath ~/.gemini/settings.json 2>/dev/null)
    if test -n "$gemini_config" -a -f "$gemini_config"; and command -q jq
        set -l gemini_theme (test $mode = dark; and echo '$HOME/.gemini/gruvbox-dark.json'; or echo '$HOME/.gemini/gruvbox-light.json')
        set -l current_theme (jq -r '.ui.theme // empty' "$gemini_config" 2>/dev/null)
        if test "$current_theme" != "$gemini_theme"
            set -l tmp (mktemp)
            jq --arg theme "$gemini_theme" '.ui.theme = $theme' "$gemini_config" > $tmp && mv $tmp "$gemini_config"
        end
    end
end
