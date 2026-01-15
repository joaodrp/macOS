# macOS Dotfiles

Personal dotfiles and setup automation for macOS development machines.

## Quick Start

```bash
# 1. Install Homebrew packages
make brew            # work machine
make brew-all        # personal machine (includes extra apps)

# 2. Symlink dotfiles
make sync

# 3. Setup fish (plugins + set as default shell)
make fish

# 4. Apply macOS preferences
make config
```

## Make Targets

| Target                  | Description                                          |
|-------------------------|------------------------------------------------------|
| `make`                  | Full setup: brew-all + sync + fish + config          |
| `make brew`             | Install Homebrew packages from Brewfile              |
| `make brew-personal`    | Install personal packages from Brewfile.personal     |
| `make brew-all`         | Install both Brewfile and Brewfile.personal          |
| `make sync`             | Symlink all dotfiles to their locations              |
| `make fish`             | Install fisher plugins and set fish as default shell |
| `make vim-plugins`      | Install vim-plug and plugins                         |
| `make tmux-plugins`     | Install tmux plugin manager                          |
| `make docker-completions` | Install Docker fish completions                    |
| `make post-install`     | Run all optional installs (tmux, vim, docker)        |
| `make config`           | Run macOS system preferences script                  |
| `make clean`            | Remove all symlinked dotfiles                        |

## What's Included

### Terminal Stack
- **Shell**: Fish with [fisher](https://github.com/jorgebucaran/fisher) plugin
  manager
- **Terminal**: [Ghostty](https://ghostty.org) with Gruvbox theme (auto
  dark/light)
- **Multiplexer**: tmux with vim-style navigation

### Configs
- `fish/` - Fish shell config, functions, and plugins
- `ghostty/` - Ghostty terminal configuration
- `tmux/` - tmux config with Gruvbox themes
- `bat/` - bat (cat replacement) config
- `gnupg/` - GPG agent configuration
- `mitmproxy/` - HTTP proxy config
- `git/` - Global git hooks (gitleaks pre-commit)

### Features
- Automatic theme sync (bat, fzf, mitmproxy) with macOS dark/light mode via
  [dark-notify](https://github.com/cormacrelf/dark-notify)
- GNU coreutils prioritized over BSD versions
- Global git hooks with gitleaks for secret detection

## Optional

```bash
# Install all optional tools at once
make post-install

# Or individually:
make tmux-plugins       # tmux plugin manager
make vim-plugins        # vim-plug and plugins
make docker-completions # Docker fish completions (requires Docker.app)
```

## Local Overrides

These files are created by `make sync` but not tracked in git:
- `~/.gitconfig.local` - Local git config (user, signing key)
- `~/.config/fish/local.fish` - Local fish config (secrets, machine-specific)
- `~/.psqlrc.local` - Local psql config
