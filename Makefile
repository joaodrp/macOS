all: sync config

sync:
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/functions.local
	mkdir -p ~/.config/fish/functions
	mkdir -p ~/.config/fish/fzf
	mkdir -p ~/.tmux/
	mkdir -p ~/.gnupg/
	mkdir -p ~/.config/git
	mkdir -p ~/Developer
	mkdir -p ~/.mitmproxy/
	mkdir -p ~/.config/bat/
	mkdir -p ~/Library/LaunchAgents

	[ -f ~/.config/ghostty/config ] || ln -s $(PWD)/ghostty/config ~/.config/ghostty/config
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	ln -sf $(PWD)/fish/fish_plugins ~/.config/fish/fish_plugins
	fish -c "fisher update"
	ln -sf $(PWD)/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
	ln -sf $(PWD)/fish/functions/fzf_key_bindings.fish ~/.config/fish/functions/fzf_key_bindings.fish
	ln -sf $(PWD)/fish/functions/op_signin.fish ~/.config/fish/functions/op_signin.fish
	ln -sf $(PWD)/fish/functions/showhidden.fish ~/.config/fish/functions/showhidden.fish
	ln -sf $(PWD)/fish/functions/sync_theme.fish ~/.config/fish/functions/sync_theme.fish
	ln -sf $(PWD)/fish/functions/upgrade.fish ~/.config/fish/functions/upgrade.fish
	ln -sf $(PWD)/fish/fzf/gruvbox-dark-hard.fish ~/.config/fish/fzf/gruvbox-dark-hard.fish
	ln -sf $(PWD)/fish/fzf/gruvbox-light-hard.fish ~/.config/fish/fzf/gruvbox-light-hard.fish
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/tmuxline-dark.conf ] || ln -s $(PWD)/tmux/tmuxline-dark.conf ~/.tmux/tmuxline-dark.conf
	[ -f ~/.tmux/tmuxline-light.conf ] || ln -s $(PWD)/tmux/tmuxline-light.conf ~/.tmux/tmuxline-light.conf
	[ -f ~/.gnupg/gpg.conf ] || ln -s $(PWD)/gnupg/gpg.conf ~/.gnupg/gpg.conf
	[ -f ~/.gnupg/gpg-agent.conf ] || ln -s $(PWD)/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/.tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.gitignore ] || ln -s $(PWD)/gitignore ~/.gitignore
	ln -sfn $(PWD)/git/hooks ~/.config/git/hooks
	[ -f ~/.dockerignore ] || ln -s $(PWD)/.dockerignore ~/.dockerignore
	[ -f ~/.ignore ] || ln -s $(PWD)/.ignore ~/.ignore
	[ -f ~/.gitconfig.local ] || touch ~/.gitconfig.local
	[ -f ~/.config/fish/local.fish ] || touch ~/.config/fish/local.fish
	[ -f ~/.hushlogin ] || ln -s $(PWD)/.hushlogin ~/.hushlogin
	[ -f ~/.psqlrc ] || ln -s $(PWD)/.psqlrc ~/.psqlrc
	[ -f ~/.psqlrc.local ] || touch ~/.psqlrc.local
	[ -f ~/.config/bat/config ] || ln -s $(PWD)/bat/config ~/.config/bat/config
	[ -f ~/.mitmproxy/config.yaml ] || ln -s $(PWD)/mitmproxy/config.yaml ~/.mitmproxy/config.yaml
	[ -f ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist ] || ln -s $(PWD)/dark-notify.plist ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist
	-launchctl load ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist 2>/dev/null

	gpgconf --kill dirmngr
	chown -R $$USER ~/.gnupg/
	find ~/.gnupg -type f -exec chmod 600 {} \;
	find ~/.gnupg -type d -exec chmod 700 {} \;

brew:
	brew bundle --verbose

brew-skip-personal:
	SKIP_PERSONAL=1 brew bundle --verbose

config:
	./macos

clean:
	-launchctl unload ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist 2>/dev/null
	rm -f ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist
	rm -f ~/.vimrc
	rm -f ~/.config/ghostty/config
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/fish_plugins
	rm -f ~/.config/fish/functions/fish_user_key_bindings.fish
	rm -f ~/.config/fish/functions/fzf_key_bindings.fish
	rm -f ~/.config/fish/functions/op_signin.fish
	rm -f ~/.config/fish/functions/showhidden.fish
	rm -f ~/.config/fish/functions/sync_theme.fish
	rm -f ~/.config/fish/functions/upgrade.fish
	rm -f ~/.config/fish/fzf/gruvbox-dark-hard.fish
	rm -f ~/.config/fish/fzf/gruvbox-light-hard.fish
	rm -f ~/.tmux.conf
	rm -f ~/.gnupg/gpg.conf
	rm -f ~/.gnupg/gpg-agent.conf
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.gitignore
	rm -rf ~/.config/git/hooks
	rm -f ~/.dockerignore
	rm -f ~/.ignore
	rm -f ~/.hushlogin
	rm -f ~/.psqlrc
	rm -f ~/.config/bat/config
	rm -f ~/.mitmproxy/config.yaml

.PHONY: all sync brew brew-skip-personal config clean
