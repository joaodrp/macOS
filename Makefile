all: sync config

sync:
	mkdir -p ~/.config/alacritty
	mkdir ~/.config/fish
	mkdir ~/.tmux/
	mkdir ~/.gnupg/
	mkdir ~/Developer

	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.config/alacritty/colors.yml ] || ln -s $(PWD)/alacritty/colors.yml ~/.config/alacritty/colors.yml
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/statusbar-dark.conf ] || ln -s $(PWD)/tmux/statusbar-dark.conf ~/.tmux/statusbar-dark.conf
	[ -f ~/.tmux/statusbar-light.conf ] || ln -s $(PWD)/tmux/statusbar-light.conf ~/.tmux/statusbar-light.conf
	[ -f ~/.gnupg/gpg.conf ] || ln -s $(PWD)/gnupg/gpg.conf ~/.gnupg/gpg.conf
	[ -f ~/.gnupg/gpg-agent.conf ] || ln -s $(PWD)/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	[ -f ~/.gnupg/scdaemon.conf ] || ln -s $(PWD)/gnupg/scdaemon.conf ~/.gnupg/scdaemon.conf
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
	[ -f ~/Library/LaunchAgents/dark-mode-notify.plist ] || ln -s $(PWD)/dark-mode-notify.plist ~/Library/LaunchAgents/dark-mode-notify.plist

config:
	./macos

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.config/alacritty/colors.yml
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/
	rm -f ~/.tmux.conf
	rm -f ~/.gnupg/gpg.conf
	rm -f ~/.gnupg/gpg-agent.conf
	rm -f ~/.gnupg/scdaemon.conf
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.gitignore
	rm -f ~/.dockerignore
	rm -f ~/.ignore
	rm -f ~/.hushlogin
	rm -f ~/.psqlrc
	rm -f ~/Library/LaunchAgents/dark-mode-notify.plist

.PHONY: all sync config clean
