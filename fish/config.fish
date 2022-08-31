# Promote Homebrew installs
fish_add_path \
	/usr/local/opt/findutils/libexec/gnubin \
	/usr/local/opt/gnu-sed/libexec/gnubin \
	/usr/local/opt/gnu-tar/libexec/gnubin \
	/usr/local/opt/gnu-time/libexec/gnubin \
	/usr/local/opt/grep/libexec/gnubin \
	/usr/local/opt/ssh-copy-id/bin \
	/usr/local/opt/curl/bin \
	/usr/local/opt/openssl/bin

set -gx EDITOR vim
set -gx GOBIN $HOME/go/bin

fish_add_path \
	(npm config get prefix)/bin \
	$HOME/go/bin

# Aliases
alias cat bat
alias ls exa
alias tree 'exa -T'
alias watch 'watch -d'

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

# Set correct tmuxline theme on start
if set -q TMUX
  # sync_tmux_background # FIXME: tmux-prefix-highlight does not work with this
end

# asdf
set -x ASDF_DIR (brew --prefix asdf)/libexec
source $ASDF_DIR/asdf.fish

# TODO: review plugins:
# mattgreen/lucid.fish
# pure-fish/pure
# jethrokuan/z
# franciscolourenco/done
# PatrickF1/fzf.fish

direnv hook fish | source

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

# Sensitive or local stuff not pushed to git
source ~/.config/fish/local.fish

# Docker
set -x DOCKER_HOST docker.local
