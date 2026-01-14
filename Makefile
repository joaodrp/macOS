all: sync config

sync:
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/functions.local
	mkdir -p ~/.tmux/
	mkdir -p ~/.gnupg/
	mkdir -p ~/Developer
	mkdir -p ~/.mitmproxy/
	mkdir -p ~/.config/bat/

	[ -f ~/.config/ghostty/config ] || ln -s $(PWD)/ghostty/config ~/.config/ghostty/config
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/tmuxline-dark.conf ] || ln -s $(PWD)/tmux/tmuxline-dark.conf ~/.tmux/tmuxline-dark.conf
	[ -f ~/.tmux/tmuxline-light.conf ] || ln -s $(PWD)/tmux/tmuxline-light.conf ~/.tmux/tmuxline-light.conf
	[ -f ~/.gnupg/gpg.conf ] || ln -s $(PWD)/gnupg/gpg.conf ~/.gnupg/gpg.conf
	[ -f ~/.gnupg/gpg-agent.conf ] || ln -s $(PWD)/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/.tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.gitignore ] || ln -s $(PWD)/gitignore ~/.gitignore
	[ -f ~/.dockerignore ] || ln -s $(PWD)/.dockerignore ~/.dockerignore
	[ -f ~/.ignore ] || ln -s $(PWD)/.ignore ~/.ignore
	[ -f ~/.gitconfig.local ] || touch ~/.gitconfig.local
	[ -f ~/.config/fish/local.fish ] || touch ~/.config/fish/local.fish
	[ -f ~/.hushlogin ] || ln -s $(PWD)/.hushlogin ~/.hushlogin
	[ -f ~/.psqlrc ] || ln -s $(PWD)/.psqlrc ~/.psqlrc
	[ -f ~/.psqlrc.local ] || touch ~/.psqlrc.local
	[ -f ~/.config/bat/config ] || ln -s $(PWD)/bat/config ~/.config/bat/config
	[ -f ~/.mitmproxy/config.yaml ] || ln -s $(PWD)/mitmproxy/config.yaml ~/.mitmproxy/config.yaml

	gpgconf --kill dirmngr
	chown -R $$USER ~/.gnupg/
	find ~/.gnupg -type f -exec chmod 600 {} \;
	find ~/.gnupg -type d -exec chmod 700 {} \;

config:
	./macos

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/ghostty/config
	rm -f ~/.config/fish/config.fish
	rm -rf ~/.config/fish/functions/
	rm -f ~/.tmux.conf
	rm -f ~/.gnupg/gpg.conf
	rm -f ~/.gnupg/gpg-agent.conf
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.gitignore
	rm -f ~/.dockerignore
	rm -f ~/.ignore
	rm -f ~/.hushlogin
	rm -f ~/.psqlrc
	rm -f ~/.config/bat/config
	rm -f ~/.mitmproxy/config.yaml

.PHONY: all sync config clean
