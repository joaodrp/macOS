# Local functions (not tracked in git)
set -p fish_function_path ~/.config/fish/functions.local

# =============================================================================
# Homebrew
# =============================================================================

eval (/opt/homebrew/bin/brew shellenv)
set -gx HOMEBREW_NO_ENV_HINTS 1

# Prefer GNU utils over macOS built-ins (hardcoded for performance)
fish_add_path \
    /opt/homebrew/opt/coreutils/libexec/gnubin \
    /opt/homebrew/opt/findutils/libexec/gnubin \
    /opt/homebrew/opt/gnu-sed/libexec/gnubin \
    /opt/homebrew/opt/gnu-tar/libexec/gnubin \
    /opt/homebrew/opt/gnu-time/libexec/gnubin \
    /opt/homebrew/opt/grep/libexec/gnubin \
    /opt/homebrew/opt/curl/bin \
    /opt/homebrew/opt/ssh-copy-id/bin

# =============================================================================
# Environment
# =============================================================================

set -gx EDITOR nvim
set -gx GOBIN $HOME/go/bin
set -gx OPENCODE_CONFIG $HOME/.config/opencode/opencode.local.json
set -gx OPENCODE_EXPERIMENTAL_LSP_TOOL true

fish_add_path $HOME/.local/bin $HOME/go/bin

# =============================================================================
# Aliases
# =============================================================================

alias cat bat
alias ls eza
alias tree 'eza -T'
alias watch 'watch -d'
alias vim nvim

# =============================================================================
# Shell settings
# =============================================================================

set fish_greeting ""
set -x GIT_COMPLETION_CHECKOUT_NO_GUESS 1

# =============================================================================
# Integrations
# =============================================================================

# Theme sync for bat, fzf, mitmproxy
sync_theme

# direnv
direnv hook fish | source

# Google Cloud SDK
test -f /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.fish.inc \
    && source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.fish.inc

# zoxide (smarter cd)
zoxide init fish | source

# =============================================================================
# Local overrides (not tracked in git)
# =============================================================================

test -f ~/.config/fish/local.fish && source ~/.config/fish/local.fish
