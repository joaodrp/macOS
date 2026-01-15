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
├── bat/              # bat (cat replacement) config
└── mitmproxy/        # HTTP proxy config
```

## Key Commands

- `make sync` - Symlink all configs to their standard locations
- `make config` - Run macOS system preferences script
- `make clean` - Remove all symlinked configs

## Conventions

- **Symlinks over copies**: Configs are symlinked from this repo to their target locations (e.g., `~/.config/fish`)
- **Brewfile**: All packages managed via Homebrew. Add new tools here, not manually
- **Fish functions**: One function per file in `fish/functions/`
- **Ghostty keybindings**: Use tmux-style Ctrl+A prefix for consistency
- **GNU tools in PATH**: GNU versions of sed, grep, tar, find, etc. are prioritized over BSD versions (see `config.fish`). Use GNU syntax in scripts (e.g., `sed -i 'pattern'` not `sed -i '' 'pattern'`)

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

The following files are automatically updated by `sync_theme` based on macOS appearance:
- `bat/config` - theme setting
- `mitmproxy/config.yaml` - console_palette setting

**Do not commit changes to these files.** They are updated automatically based on macOS appearance and will show as modified in git.

## Terminal Stack

- **Shell**: Fish with custom prompt and FZF integration
- **Multiplexer**: tmux with Ctrl+A prefix, vim-style navigation
- **Terminal**: Ghostty with Gruvbox theme (auto dark/light mode)

