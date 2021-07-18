# Setup

```
# install all brew dependencies
brew bundle

# install Apple SF Mono fonts
cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SF-Mono*.otf ~/Library/Fonts/

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

# install asdf plugins and versions
for lang in golang ruby rust nodejs python
    asdf plugin add $lang
    asdf install $lang latest
    asdf global $lang latest
end

# install fisher
curl -sL https://git.io/fisher | source \
    && fisher install jorgebucaran/fisher

fisher install \
    jorgebucaran/autopair.fish \
    gazorby/fish-abbreviation-tips \
    jethrokuan/z \
    mattgreen/lucid.fish \
    lgathy/google-cloud-sdk-fish-completion

# Voxengo Marvel GEQ for OBS
set tmpdir (mktemp -d)
wget -P $tmpdir https://www.voxengo.com/files/VoxengoMarvelGEQ_110_Mac_VST_VST3_setup.dmg
hdiutil attach $tmpdir/VoxengoMarvelGEQ_110_Mac_VST_VST3_setup.dmg
sudo cp -r /Volumes/Voxengo\ Marvel\ GEQ\ 1.10\ VST2_VST3/Marvel\ GEQ.vst /Library/Audio/Plug-Ins/VST
rm -rf $tmpdir

# Fish completions
wget -P ~/.config/fish/completions https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.fish

ln -shi /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ~/.config/fish/completions/docker.fish
ln -shi /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion ~/.config/fish/completions/docker-compose.fish

# Loopback aliases
for target in app registry proxy
    sudo cp network/dev.$target.lo0-alias.plist /Library/LaunchDaemons/
    sudo chmod 0644 /Library/LaunchDaemons/dev.$target.lo0-alias.plist
    sudo chown root:wheel /Library/LaunchDaemons/dev.$target.lo0-alias.plist
    sudo launchctl load /Library/LaunchDaemons/dev.$target.lo0-alias.plist
end

cat network/hosts | sudo tee -a /private/etc/hosts

mkdir ~/.config/certs
for target in app registry proxy
    openssl req \
        -newkey rsa:4096 -nodes -sha256 -keyout ~/.config/certs/$target.dev.key \
        -addext "subjectAltName = DNS:$target.dev" \
        -x509 -out ~/.config/certs/$target.dev.crt -subj "/C=PT/CN=$target.dev"

    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.config/certs/$target.dev.crt
end
```