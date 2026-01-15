# Local functions (not tracked in git)
set -p fish_function_path ~/.config/fish/functions.local

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)
set -gx HOMEBREW_NO_ENV_HINTS 1

# Promote Homebrew installs
fish_add_path \
	(brew --prefix findutils)/libexec/gnubin \
	(brew --prefix gnu-sed)/libexec/gnubin \
	(brew --prefix gnu-tar)/libexec/gnubin \
	(brew --prefix gnu-time)/libexec/gnubin \
	(brew --prefix grep)/libexec/gnubin \
	(brew --prefix grep)/coreutils/gnubin \
	(brew --prefix ssh-copy-id)/bin \
	(brew --prefix curl)/bin \
	(brew --prefix icu4c)/bin \
	$HOME/.rd/bin

set -gx EDITOR vim
set -gx GOBIN $HOME/go/bin

fish_add_path \
	(npm config get prefix)/bin \
	$HOME/go/bin

# Aliases
alias cat bat
alias ls eza
alias tree 'eza -T'
alias watch 'watch -d'
alias vim nvim

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
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

# don't show any greetings
set fish_greeting ""

# GPG
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Sync theme for bat, fzf, mitmproxy on shell start
sync_theme

# TODO: review plugins:
# mattgreen/lucid.fish
# pure-fish/pure
# jethrokuan/z
# franciscolourenco/done
# PatrickF1/fzf.fish

direnv hook fish | source

source "/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.fish.inc"

# Sensitive or local stuff not pushed to git
source ~/.config/fish/local.fish

# git
set -x GIT_COMPLETION_CHECKOUT_NO_GUESS 1
