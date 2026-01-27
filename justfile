# Dotfiles setup for macOS
# Run `just` or `just --list` to see available commands

set shell := ["bash", "-uc"]
set quiet

# Repository root
root := justfile_directory()

# Show available commands
[group('setup')]
default:
    @just --list --unsorted

# Full setup: brew, sync, fish, plugins, config
[group('setup')]
all: brew-all sync fish plugins config

# Symlink all configs to standard locations
[group('setup')]
sync: _sync-dirs _sync-fish _sync-editors _sync-terminal _sync-git _sync-security _sync-ai _sync-misc _sync-local _sync-launchd _sync-permissions

# Install main Brewfile packages
[group('brew')]
brew:
    brew bundle --verbose

# Install personal Brewfile packages
[group('brew')]
brew-personal:
    brew bundle --file=Brewfile.personal --verbose

# Install both Brewfiles
[group('brew')]
brew-all: brew brew-personal

# Setup Fish shell as default
[group('shell')]
fish:
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"
    @grep -q /opt/homebrew/bin/fish /etc/shells || (echo "Adding fish to /etc/shells (requires sudo)..." && echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells)
    @[ "$SHELL" = "/opt/homebrew/bin/fish" ] && echo "Fish is already the default shell" || chsh -s /opt/homebrew/bin/fish

# Install all plugins (vim, tmux, docker, npm, claude)
[group('plugins')]
plugins: _vim-plugins _tmux-plugins _docker-completions _npm-global claude-plugins

# Install Claude marketplaces and plugins
[group('plugins')]
claude-plugins:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "Adding marketplaces..."
    installed=$(claude plugin marketplace list --json 2>/dev/null | jq -r '.[].repo')
    grep -v '^#' ~/.claude/marketplaces.txt 2>/dev/null | grep -v '^$' | while read -r repo; do
        if ! echo "$installed" | grep -qx "$repo"; then
            claude plugin marketplace add "$repo" 2>&1 || true
        fi
    done
    echo "Updating marketplaces..."
    claude plugin marketplace update
    echo "Installing plugins..."
    grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$' | while read -r plugin; do
        claude plugin install "$plugin" 2>&1 || true
    done

# Install Claude plugins and prune unlisted ones
[group('plugins')]
claude-plugins-prune: claude-plugins
    #!/usr/bin/env bash
    set -euo pipefail
    echo "Pruning unlisted marketplaces..."
    desired=$(grep -v '^#' ~/.claude/marketplaces.txt 2>/dev/null | grep -v '^$')
    claude plugin marketplace list --json 2>/dev/null | jq -r '.[] | "\(.name)|\(.repo)"' | while read -r entry; do
        mp_name=$(echo "$entry" | cut -d'|' -f1)
        mp_repo=$(echo "$entry" | cut -d'|' -f2)
        if ! echo "$desired" | grep -qx "$mp_repo"; then
            echo "Removing marketplace: $mp_name"
            claude plugin marketplace remove "$mp_name" 2>&1 || true
        fi
    done
    echo "Pruning unlisted plugins (user scope)..."
    desired=$(grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$' | sed 's/@.*//')
    claude plugin list --json 2>/dev/null | jq -r '.[] | select(.scope == "user") | .id' | sort -u | while read -r id; do
        name=$(echo "$id" | sed 's/@.*//')
        if ! echo "$desired" | grep -qx "$name"; then
            echo "Removing plugin: $name"
            claude plugin uninstall "$name" --scope user 2>&1 || true
        fi
    done

# Apply macOS system preferences
[group('system')]
config:
    {{ root }}/macos

# Remove all symlinked configs
[group('system')]
[confirm('This will remove all symlinked configs. Continue?')]
clean:
    -launchctl unload ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist 2>/dev/null
    rm -f ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist
    rm -f ~/.vimrc
    rm -f ~/.config/ghostty/config
    rm -f ~/.config/fish/config.fish
    rm -f ~/.config/fish/fish_plugins
    rm -f ~/.config/fish/functions/fish_user_key_bindings.fish
    rm -f ~/.config/fish/functions/fzf_key_bindings.fish
    rm -f ~/.config/fish/functions/hidden.fish
    rm -f ~/.config/fish/functions/sync_theme.fish
    rm -f ~/.config/fish/functions/_pure_set_gruvbox.fish
    rm -f ~/.config/fish/functions/upgrade.fish
    rm -f ~/.config/fish/functions/cdr.fish
    rm -f ~/.config/fish/functions/co.fish
    rm -f ~/.config/fish/functions/hb.fish
    rm -f ~/.config/fish/functions/hc.fish
    rm -f ~/.config/fish/functions/ghpr.fish
    rm -f ~/.config/fish/functions/claude_sync.fish
    rm -f ~/.config/fish/functions/afk.fish
    rm -f ~/.config/fish/functions/mc.fish
    rm -f ~/.config/fish/functions/pubkey.fish
    rm -f ~/.config/fish/functions/wifi_pass.fish
    rm -f ~/.config/fish/fzf/gruvbox-dark-hard.fish
    rm -f ~/.config/fish/fzf/gruvbox-light-hard.fish
    rm -f ~/.config/fish/conf.d/_done.fish
    rm -f ~/.config/fish/conf.d/pure_theme.fish
    rm -f ~/.tmux.conf
    rm -f ~/.tmux/tmuxline-dark.conf
    rm -f ~/.tmux/tmuxline-light.conf
    rm -f ~/.gnupg/gpg.conf
    rm -f ~/.gnupg/gpg-agent.conf
    rm -f ~/.tigrc
    rm -f ~/.gitconfig
    rm -f ~/.gitconfig-github
    rm -f ~/.gitignore
    rm -rf ~/.config/git/hooks
    rm -f ~/.ssh/config
    rm -f ~/.1password/agent.sock
    rm -f ~/.dockerignore
    rm -f ~/.ignore
    rm -f ~/.hushlogin
    rm -f ~/.psqlrc
    rm -f ~/.config/bat/config
    rm -f ~/.mitmproxy/config.yaml
    rm -f ~/.config/opencode/opencode.json
    rm -f ~/.config/opencode/AGENTS.md
    rm -f ~/.config/opencode/themes/gruvbox-dark-hard.json
    rm -f ~/.config/opencode/themes/gruvbox-light-hard.json
    rm -f ~/.claude/CLAUDE.md
    rm -f ~/.claude/settings.json
    rm -f ~/.claude/hooks/statusline.sh
    rm -f ~/.claude/hooks/subagent-start.sh
    rm -f ~/.claude/marketplaces.txt
    rm -f ~/.claude/plugins.txt
    rm -f ~/.gemini/settings.json
    rm -f ~/.gemini/gruvbox-dark-hard.json
    rm -f ~/.gemini/gruvbox-light-hard.json
    rm -f ~/.codex/config.toml
    rm -f ~/.cc-safety-net/config.json
    rm -f ~/Library/Application\ Support/Code/User/settings.json
    rm -f ~/Library/Application\ Support/Code/User/keybindings.json
    rm -f ~/.config/zed/settings.json

# --- Private recipes (underscore prefix hides from --list) ---

_sync-dirs:
    mkdir -p ~/.config/ghostty
    mkdir -p ~/.config/fish
    mkdir -p ~/.config/fish/functions.local
    mkdir -p ~/.config/fish/functions
    mkdir -p ~/.config/fish/fzf
    mkdir -p ~/.config/fish/conf.d
    mkdir -p ~/.tmux/
    mkdir -p ~/.gnupg/
    mkdir -p ~/.ssh
    mkdir -p ~/.ssh/sockets
    mkdir -p ~/.1password
    mkdir -p ~/.config/git
    mkdir -p ~/Developer
    mkdir -p ~/.mitmproxy/
    mkdir -p ~/.config/bat/
    mkdir -p ~/.config/opencode/
    mkdir -p ~/.config/opencode/themes
    mkdir -p ~/.claude
    mkdir -p ~/.claude/hooks
    mkdir -p ~/.gemini
    mkdir -p ~/.codex
    mkdir -p ~/.cc-safety-net
    mkdir -p ~/Library/LaunchAgents
    mkdir -p ~/Library/Application\ Support/Code/User
    mkdir -p ~/.config/zed

_sync-fish:
    [ -f ~/.config/fish/config.fish ] || ln -s {{ root }}/fish/config.fish ~/.config/fish/config.fish
    ln -sf {{ root }}/fish/fish_plugins ~/.config/fish/fish_plugins
    ln -sf {{ root }}/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
    ln -sf {{ root }}/fish/functions/fzf_key_bindings.fish ~/.config/fish/functions/fzf_key_bindings.fish
    ln -sf {{ root }}/fish/functions/hidden.fish ~/.config/fish/functions/hidden.fish
    ln -sf {{ root }}/fish/functions/sync_theme.fish ~/.config/fish/functions/sync_theme.fish
    ln -sf {{ root }}/fish/functions/_pure_set_gruvbox.fish ~/.config/fish/functions/_pure_set_gruvbox.fish
    ln -sf {{ root }}/fish/functions/upgrade.fish ~/.config/fish/functions/upgrade.fish
    ln -sf {{ root }}/fish/functions/cdr.fish ~/.config/fish/functions/cdr.fish
    ln -sf {{ root }}/fish/functions/co.fish ~/.config/fish/functions/co.fish
    ln -sf {{ root }}/fish/functions/hb.fish ~/.config/fish/functions/hb.fish
    ln -sf {{ root }}/fish/functions/hc.fish ~/.config/fish/functions/hc.fish
    ln -sf {{ root }}/fish/functions/ghpr.fish ~/.config/fish/functions/ghpr.fish
    ln -sf {{ root }}/fish/functions/claude_sync.fish ~/.config/fish/functions/claude_sync.fish
    ln -sf {{ root }}/fish/functions/afk.fish ~/.config/fish/functions/afk.fish
    ln -sf {{ root }}/fish/functions/mc.fish ~/.config/fish/functions/mc.fish
    ln -sf {{ root }}/fish/functions/pubkey.fish ~/.config/fish/functions/pubkey.fish
    ln -sf {{ root }}/fish/functions/wifi_pass.fish ~/.config/fish/functions/wifi_pass.fish
    ln -sf {{ root }}/fish/fzf/gruvbox-dark-hard.fish ~/.config/fish/fzf/gruvbox-dark-hard.fish
    ln -sf {{ root }}/fish/fzf/gruvbox-light-hard.fish ~/.config/fish/fzf/gruvbox-light-hard.fish
    ln -sf {{ root }}/fish/conf.d/_done.fish ~/.config/fish/conf.d/_done.fish
    ln -sf {{ root }}/fish/conf.d/pure_theme.fish ~/.config/fish/conf.d/pure_theme.fish

_sync-editors:
    [ -f ~/.vimrc ] || ln -s {{ root }}/.vimrc ~/.vimrc
    [ -f ~/Library/Application\ Support/Code/User/settings.json ] || ln -s {{ root }}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    [ -f ~/Library/Application\ Support/Code/User/keybindings.json ] || ln -s {{ root }}/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
    [ -f ~/.config/zed/settings.json ] || ln -s {{ root }}/zed/settings.json ~/.config/zed/settings.json

_sync-terminal:
    [ -f ~/.config/ghostty/config ] || ln -s {{ root }}/ghostty/config ~/.config/ghostty/config
    [ -f ~/.tmux.conf ] || ln -s {{ root }}/tmux/.tmux.conf ~/.tmux.conf
    [ -f ~/.tmux/tmuxline-dark.conf ] || ln -s {{ root }}/tmux/tmuxline-dark.conf ~/.tmux/tmuxline-dark.conf
    [ -f ~/.tmux/tmuxline-light.conf ] || ln -s {{ root }}/tmux/tmuxline-light.conf ~/.tmux/tmuxline-light.conf

_sync-git:
    [ -f ~/.gitconfig ] || ln -s {{ root }}/.gitconfig ~/.gitconfig
    [ -f ~/.gitconfig-github ] || ln -s {{ root }}/.gitconfig-github ~/.gitconfig-github
    [ -f ~/.gitignore ] || ln -s {{ root }}/gitignore ~/.gitignore
    [ -f ~/.tigrc ] || ln -s {{ root }}/.tigrc ~/.tigrc
    [ -f ~/.dockerignore ] || ln -s {{ root }}/.dockerignore ~/.dockerignore
    [ -f ~/.ignore ] || ln -s {{ root }}/.ignore ~/.ignore
    ln -sfn {{ root }}/git/hooks ~/.config/git/hooks

_sync-security:
    [ -f ~/.gnupg/gpg.conf ] || ln -s {{ root }}/gnupg/gpg.conf ~/.gnupg/gpg.conf
    [ -f ~/.gnupg/gpg-agent.conf ] || ln -s {{ root }}/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
    [ -f ~/.ssh/config ] || ln -s {{ root }}/ssh/config ~/.ssh/config
    [ -S ~/.1password/agent.sock ] || ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

_sync-ai:
    [ -f ~/.config/bat/config ] || ln -s {{ root }}/bat/config ~/.config/bat/config
    [ -f ~/.config/opencode/opencode.json ] || ln -s {{ root }}/opencode/opencode.json ~/.config/opencode/opencode.json
    ln -sf {{ root }}/opencode/AGENTS.md ~/.config/opencode/AGENTS.md
    ln -sf {{ root }}/opencode/themes/gruvbox-dark-hard.json ~/.config/opencode/themes/gruvbox-dark-hard.json
    ln -sf {{ root }}/opencode/themes/gruvbox-light-hard.json ~/.config/opencode/themes/gruvbox-light-hard.json
    ln -sf {{ root }}/claude/CLAUDE.md ~/.claude/CLAUDE.md
    [ -f ~/.claude/settings.json ] || ln -s {{ root }}/claude/settings.json ~/.claude/settings.json
    ln -sf {{ root }}/claude/statusline.sh ~/.claude/hooks/statusline.sh
    ln -sf {{ root }}/claude/subagent-start.sh ~/.claude/hooks/subagent-start.sh
    ln -sf {{ root }}/claude/marketplaces.txt ~/.claude/marketplaces.txt
    ln -sf {{ root }}/claude/plugins.txt ~/.claude/plugins.txt
    [ -f ~/.gemini/settings.json ] || ln -s {{ root }}/gemini/settings.json ~/.gemini/settings.json
    ln -sf {{ root }}/gemini/gruvbox-dark-hard.json ~/.gemini/gruvbox-dark-hard.json
    ln -sf {{ root }}/gemini/gruvbox-light-hard.json ~/.gemini/gruvbox-light-hard.json
    [ -f ~/.codex/config.toml ] || ln -s {{ root }}/codex/config.toml ~/.codex/config.toml
    [ -f ~/.cc-safety-net/config.json ] || ln -s {{ root }}/cc-safety-net/config.json ~/.cc-safety-net/config.json

_sync-misc:
    [ -f ~/.mitmproxy/config.yaml ] || ln -s {{ root }}/mitmproxy/config.yaml ~/.mitmproxy/config.yaml
    [ -f ~/.hushlogin ] || ln -s {{ root }}/.hushlogin ~/.hushlogin
    [ -f ~/.psqlrc ] || ln -s {{ root }}/.psqlrc ~/.psqlrc

_sync-local:
    [ -f ~/.ssh/config.local ] || touch ~/.ssh/config.local
    [ -f ~/.gitconfig.local ] || touch ~/.gitconfig.local
    [ -f ~/.config/git/allowed_signers ] || touch ~/.config/git/allowed_signers
    [ -f ~/.config/fish/local.fish ] || touch ~/.config/fish/local.fish
    [ -f ~/.config/opencode/opencode.local.json ] || echo '{}' > ~/.config/opencode/opencode.local.json
    [ -f ~/.psqlrc.local ] || touch ~/.psqlrc.local

_sync-launchd:
    [ -f ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist ] || ln -s {{ root }}/dark-notify.plist ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist
    -launchctl load ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist 2>/dev/null

_sync-permissions:
    gpgconf --kill dirmngr
    chown -R $USER ~/.gnupg/
    find ~/.gnupg -type f -exec chmod 600 {} \;
    find ~/.gnupg -type d -exec chmod 700 {} \;

_vim-plugins:
    [ -f ~/.vim/autoload/plug.vim ] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall

_tmux-plugins:
    [ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

_docker-completions:
    mkdir -p ~/.config/fish/completions
    @[ -f /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ] && \
        ln -sf /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ~/.config/fish/completions/docker.fish && \
        ln -sf /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion ~/.config/fish/completions/docker-compose.fish && \
        echo "Docker completions installed" || echo "Docker.app not found, skipping completions"

_npm-global:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "Installing global npm packages..."
    grep -v '^#' {{ root }}/npm-global-packages.txt 2>/dev/null | grep -v '^$' | while read -r pkg; do
        npm list -g "$pkg" >/dev/null 2>&1 || npm install -g "$pkg"
    done
