all: sync

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
	[ -f ~/.gitignore ] || ln -s $(PWD)/gitignore ~/.gitignore
	[ -f ~/.dockerignore ] || ln -s $(PWD)/.dockerignore ~/.dockerignore
	[ -f ~/.ignore ] || ln -s $(PWD)/.ignore ~/.ignore
	[ -f ~/Library/LaunchAgents/dark-mode-notify.plist ] || ln -s $(PWD)/dark-mode-notify.plist ~/Library/LaunchAgents/dark-mode-notify.plist

	[ -f ~/.gitconfig.local ] || touch ~/.gitconfig.local
	[ -f ~/.config/fish/local.fish ] || touch ~/.config/fish/local.fish

	# don't show last login message
	touch ~/.hushlogin

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

.PHONY: all sync clean
