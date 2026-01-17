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

# 4. Optional extras (vim-plug, tmux plugins, docker completions)
make post-install

# 5. Apply macOS preferences
make config
```

## Make Targets

| Target                    | Description                                                |
|---------------------------|------------------------------------------------------------|
| `make`                    | Full setup: brew-all + sync + fish + post-install + config |
| `make brew`               | Install Homebrew packages from Brewfile                    |
| `make brew-personal`      | Install personal packages from Brewfile.personal           |
| `make brew-all`           | Install both Brewfile and Brewfile.personal                |
| `make sync`               | Symlink all dotfiles to their locations                    |
| `make fish`               | Install fisher plugins and set fish as default shell       |
| `make vim-plugins`        | Install vim-plug and plugins                               |
| `make tmux-plugins`       | Install tmux plugin manager                                |
| `make docker-completions` | Install Docker fish completions                            |
| `make post-install`       | Run all optional installs (tmux, vim, docker)              |
| `make config`             | Run macOS system preferences script                        |
| `make clean`              | Remove all symlinked dotfiles                              |

## What's Included

### Terminal Stack
- **Shell**: Fish with [fisher](https://github.com/jorgebucaran/fisher) plugin manager
- **Terminal**: [Ghostty](https://ghostty.org) with Gruvbox theme (auto dark/light)
- **Multiplexer**: tmux with vim-style navigation

### Features
- Automatic theme sync (delta, bat, fzf, mitmproxy, Claude Code) with macOS dark/light mode via [dark-notify](https://github.com/cormacrelf/dark-notify)
- GNU coreutils prioritized over BSD versions
- Global git hooks with gitleaks for secret detection

## Local Overrides

These files are created by `make sync` but not tracked in git:
- `~/.gitconfig.local` - Local git config (user email)
- `~/.config/fish/local.fish` - Local fish config (secrets, machine-specific)
- `~/.config/opencode/opencode.local.json` - Local opencode config
- `~/.ssh/config.local` - Local SSH config (host overrides, IdentityAgent)
- `~/.psqlrc.local` - Local psql config

### SSH Agent

The default `ssh/config` uses 1Password agent. For GPG/YubiKey, override in `~/.ssh/config.local`:

```ssh
# Override to use GPG agent
Host *
  IdentityAgent ${SSH_AUTH_SOCK}
```

And configure the agent socket in `~/.config/fish/local.fish`:

```fish
# GPG/YubiKey
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
```

### Commit Signature Verification

For local verification of SSH-signed commits, create `~/.config/git/allowed_signers`:

```
your@email.com ssh-ed25519 AAAA...your-public-key
another@email.com ssh-ed25519 AAAA...your-public-key
```

List each email you sign commits with, followed by your public signing key.
