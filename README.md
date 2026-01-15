# Setup

```
# install brew dependencies (work machine)
make brew

# install personal packages too (personal machine)
make brew-all

# install Apple SF Mono fonts
cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SF-Mono*.otf ~/Library/Fonts/

# symlink dotfiles to the appropriate places
make sync

# install fisher and fish plugins
make fish-plugins

# make fish the new default
chsh -s /opt/homebrew/bin/fish

# setup vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# open vim and install all plugins
:PlugInstall

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install asdf plugins and versions
for lang in golang ruby rust nodejs python
    asdf plugin add $lang
    asdf install $lang latest
    asdf global $lang latest
end

# Voxengo Marvel GEQ for OBS
set tmpdir (mktemp -d)
wget -P $tmpdir https://www.voxengo.com/files/VoxengoMarvelGEQ_110_Mac_VST_VST3_setup.dmg
hdiutil attach $tmpdir/VoxengoMarvelGEQ_110_Mac_VST_VST3_setup.dmg
sudo cp -r /Volumes/Voxengo\ Marvel\ GEQ\ 1.10\ VST2_VST3/Marvel\ GEQ.vst /Library/Audio/Plug-Ins/VST
rm -rf $tmpdir

# Docker completions
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

# Redirect ports 80 and 443 to 8080 and 8443 respectively
# https://gist.github.com/novemberborn/aea3ea5bac3652a1df6b
sudo ln -s $(PWD)/network/dev /etc/pf.anchors/dev
# make /etc/pf.conf match ./network/pf.conf
sudo pfctl -v -n -f /etc/pf.conf
sudo pfctl -ef /etc/pf.conf
sudo cp network/dev.pfctl.plist /Library/LaunchDaemons/
sudo chmod 0644 /Library/LaunchDaemons/dev.pfctl.plist
sudo chown root:wheel /Library/LaunchDaemons/dev.pfctl.plist
sudo launchctl load /Library/LaunchDaemons/dev.pfctl.plist
```