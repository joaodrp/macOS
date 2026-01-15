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
set -gx OPENCODE_EXPERIMENTAL_LSP_TOOL true

fish_add_path $HOME/go/bin

# =============================================================================
# Aliases
# =============================================================================

alias cat bat
alias ls eza
alias tree 'eza -T'
alias watch 'watch -d'
alias vim nvim

# =============================================================================
# Git prompt
# =============================================================================

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_invalidstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_stagedstate blue
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# =============================================================================
# Shell settings
# =============================================================================

set fish_greeting ""
set -x GIT_COMPLETION_CHECKOUT_NO_GUESS 1

# =============================================================================
# GPG / SSH
# =============================================================================

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

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

# =============================================================================
# Local overrides (not tracked in git)
# =============================================================================

test -f ~/.config/fish/local.fish && source ~/.config/fish/local.fish
