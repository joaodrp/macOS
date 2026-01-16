# AGENTS.md

This is a macOS dotfiles repository for setting up development machines.

## Structure

```
.
├── Brewfile          # Homebrew packages (formulas, casks, taps)
├── Makefile          # Installation automation
├── macos             # macOS system preferences script
├── fish/             # Fish shell configuration
│   ├── config.fish   # Main shell config
│   └── functions/    # Custom fish functions
├── tmux/             # tmux configuration and themes
├── ghostty/          # Ghostty terminal config
├── gnupg/            # GPG agent configuration
├── ssh/              # SSH config with Include for local overrides
├── git/              # Git hooks (gitleaks)
├── opencode/         # Opencode AI assistant config
├── claude/           # Claude Code config
│   ├── commands/     # Custom slash commands
│   └── npx-packages  # Third-party npx installers (one command per line)
├── bat/              # bat (cat replacement) config
└── mitmproxy/        # HTTP proxy config
```

## Key Commands

- `make sync` - Symlink all configs to their standard locations
- `make claude-npx` - Install/update Claude npx packages
- `make config` - Run macOS system preferences script
- `make clean` - Remove all symlinked configs
- `upgrade` - Fish function to update Homebrew, Fisher, App Store, and Claude npx packages

## Conventions

- **Symlinks over copies**: Configs are symlinked from this repo to their target locations (e.g., `~/.config/fish`)
- **Brewfile**: All packages managed via Homebrew. Add new tools here, not manually
- **Fish functions**: One function per file in `fish/functions/`
- **Ghostty keybindings**: Use tmux-style Ctrl+A prefix for consistency

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <description>

[optional body]
```

**Types:**
- `feat` - New feature or tool
- `fix` - Bug fix
- `docs` - Documentation changes
- `chore` - Maintenance (updating packages, cleanup)
- `refactor` - Code restructuring without behavior change

**Examples:**
- `feat: add starship prompt configuration`
- `fix: correct fish PATH ordering`
- `chore: add comments to Brewfile`
- `docs: add installation instructions to README`

## When Modifying

1. **Adding a new tool**: Add to `Brewfile`, then add any config files to appropriate directory
2. **Fish aliases/functions**: Add to `fish/functions/` as separate `.fish` files
3. **System preferences**: Modify the `macos` script
4. **New config directory**: Add symlink target to `Makefile`'s sync target

## Theme-Synced Configs

These files auto-switch based on macOS appearance mode. Only commit non-theme changes:
- `.gitconfig` - do not commit `delta.syntax-theme` changes
- `bat/config` - do not commit `--theme` changes
- `mitmproxy/config.yaml` - do not commit `console_palette` changes

These files will often show as modified in git due to automatic theme switching. Only commit non-theme changes to these files.

## Terminal Stack

- **Shell**: Fish with custom prompt and FZF integration
- **Multiplexer**: tmux with Ctrl+A prefix, vim-style navigation
- **Terminal**: Ghostty with Gruvbox theme (auto dark/light mode)

