# Setup

```
# install all brew dependencies
brew bundle

# copy dotfiles to the appropriate places
make

# make fish the new default
chsh -s /usr/local/bin/fish

# dark-mode-notify
set tmpdir (mktemp -d)
git clone https://github.com/bouk/dark-mode-notify.git $tmpdir
swiftc $tmpdir/dark-mode-notify.swift -o /usr/local/bin/dark-mode-notify
rm -rf $tmpdir

# setup vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# open vim and install all plugins
:PlugInstall

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# disable font smoothing
defaults -currentHost write -g AppleFontSmoothing -int 0

# enable dark mode notify service
launchctl load -w ~/Library/LaunchAgents/dark-mode-notify.plist

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install \
    jorgebucaran/autopair.fish \
    gazorby/fish-abbreviation-tips \
    jethrokuan/z
```