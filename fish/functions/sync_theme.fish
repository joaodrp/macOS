function sync_theme --description 'Sync Pure prompt, bat, delta, fzf, mitmproxy, Claude Code, OpenCode, Zellij, lazygit, and lumen themes with macOS appearance'
    # Detect current macOS appearance (dark mode returns 0, light mode returns error)
    if defaults read -g AppleInterfaceStyle &>/dev/null
        set mode dark
    else
        set mode light
    end

    # Export for conf.d scripts
    set -gx MACOS_APPEARANCE $mode

    # --- Pure prompt (Gruvbox) ---
    _pure_set_gruvbox $mode

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

    # --- fzf (Gruvbox Hard) ---
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

    # --- OpenCode ---
    set -l opencode_config (realpath ~/.config/opencode/opencode.json 2>/dev/null)
    if test -n "$opencode_config" -a -f "$opencode_config"; and command -q jq
        set -l opencode_theme (test $mode = dark; and echo "gruvbox-dark-hard"; or echo "gruvbox-light-hard")
        set -l current_theme (jq -r '.theme // empty' "$opencode_config" 2>/dev/null)
        if test "$current_theme" != "$opencode_theme"
            set -l tmp (mktemp)
            jq --arg theme "$opencode_theme" '.theme = $theme' "$opencode_config" > $tmp && mv $tmp "$opencode_config"
        end
    end

    # --- Zellij ---
    set -l zellij_config (realpath ~/.config/zellij/config.kdl 2>/dev/null)
    if test -n "$zellij_config" -a -f "$zellij_config"
        if test $mode = dark
            sed -i 's/^theme "gruvbox-light-hard"/theme "gruvbox-dark-hard"/' "$zellij_config"
        else
            sed -i 's/^theme "gruvbox-dark-hard"/theme "gruvbox-light-hard"/' "$zellij_config"
        end
    end

    # --- lumen ---
    set -l lumen_config (realpath ~/.config/lumen/lumen.config.json 2>/dev/null)
    if test -n "$lumen_config" -a -f "$lumen_config"; and command -q jq
        set -l lumen_theme (test $mode = dark; and echo "gruvbox-dark"; or echo "gruvbox-light")
        set -l tmp (mktemp)
        jq --arg theme "$lumen_theme" '.theme = $theme' "$lumen_config" > $tmp && mv $tmp "$lumen_config"
    end

    # --- lazygit ---
    if command -q yq
        set -l base ~/Developer/github.com/joaodrp/macos/lazygit/config-base.yml
        set -l lazygit_theme (test $mode = dark; and echo gruvbox-dark-hard; or echo gruvbox-light-hard)
        yq eval-all '. as $item ireduce ({}; . * $item)' "$base" ~/Developer/github.com/joaodrp/macos/lazygit/themes/$lazygit_theme.yml > ~/.config/lazygit/config.yml
    end

end
