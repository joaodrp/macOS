all: build sync setup

build:
	$(eval TMPDIR := $(shell mktemp -d))
	git clone https://github.com/bouk/dark-mode-notify.git $(TMPDIR)
	cd $(TMPDIR); git reset --hard 87b71ab45f14ca978d3e47efac54c86ec32ae140
	swiftc $(TMPDIR)/dark-mode-notify.swift -o /usr/local/bin/dark-mode-notify
	rm -rf $(TMPDIR)

sync:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/fish
	mkdir -p ~/.tmux/

	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.config/alacritty/colors.yml ] || ln -s $(PWD)/alacritty/colors.yml ~/.config/alacritty/colors.yml
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/statusbar-dark.conf ] || ln -s $(PWD)/tmux/statusbar-dark.conf ~/.tmux/statusbar-dark.conf
	[ -f ~/.tmux/statusbar-light.conf ] || ln -s $(PWD)/tmux/statusbar-light.conf ~/.tmux/statusbar-light.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/.tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.gitignore ] || ln -s $(PWD)/.gitignore ~/.gitignore
	[ -f ~/.dockerignore ] || ln -s $(PWD)/.dockerignore ~/.dockerignore
	[ -f ~/.ignore ] || ln -s $(PWD)/.ignore ~/.ignore
	[ -f ~/Library/LaunchAgents/dark-mode-notify.plist ] || ln -s $(PWD)/dark-mode-notify.plist ~/Library/LaunchAgents/dark-mode-notify.plist

	[ -f ~/.gitconfig.local ] || touch ~/.gitconfig.local
	[ -f ~/.config/fish/local.fish ] || touch ~/.config/fish/local.fish

	# don't show last login message
	touch ~/.hushlogin

setup:
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
	fisher install \
		jorgebucaran/autopair.fish \
		gazorby/fish-abbreviation-tips

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.config/alacritty/colors.yml
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/
	rm -f ~/.tmux.conf
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.gitignore
	rm -f ~/.dockerignore
	rm -f ~/.ignore
	rm -f ~/Library/LaunchAgents/dark-mode-notify.plist

.PHONY: all build clean sync
