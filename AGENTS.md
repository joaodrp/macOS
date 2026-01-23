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
├── claude/              # Claude Code config
│   ├── commands/        # Custom slash commands
│   ├── npx-packages.txt # Third-party npx installers
│   ├── marketplaces.txt # Plugin marketplaces (GitHub repos)
│   └── plugins.txt      # Plugins to install
├── bat/              # bat (cat replacement) config
├── mitmproxy/        # HTTP proxy config
├── gemini/           # Gemini CLI config and themes
├── codex/            # Codex CLI config
├── cc-safety-net/    # cc-safety-net custom rules
└── vscode/           # VS Code settings and keybindings
```

## Key Commands

- `make sync` - Symlink all configs to their standard locations
- `make claude-npx` - Install/update Claude npx packages
- `make claude-plugins` - Install/update Claude marketplaces and plugins
- `make claude-plugins-prune` - Same as above, plus remove unlisted marketplaces/plugins
- `claude_sync` - Fish function for plugin sync (`claude_sync --prune` to remove unlisted)
- `make config` - Run macOS system preferences script
- `make clean` - Remove all symlinked configs
- `upgrade` - Fish function to update Homebrew, Fisher, App Store, Claude npx packages, and Claude plugins

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
- `feat: add fzf key bindings`
- `fix: correct fish PATH ordering`
- `chore: add comments to Brewfile`
- `docs: add installation instructions to README`

## When Modifying

1. **Adding a new tool**: Add to `Brewfile`, then add any config files to appropriate directory
2. **Fish aliases/functions**: Add to `fish/functions/` as separate `.fish` files
3. **System preferences**: Modify the `macos` script
4. **New config directory**: Add symlink target to `Makefile`'s sync target
5. **Renaming/moving/deleting files**: Update `Makefile` sync and clean targets accordingly
6. **Claude plugins**: Add marketplace to `claude/marketplaces.txt`, plugin to `claude/plugins.txt`

## Theme-Synced Configs

All apps use the official [Gruvbox](https://github.com/morhetz/gruvbox) **hard** contrast palette:
- **Hard** background (#1d2021 dark, #f9f5d7 light) for maximum contrast
- **Neutral** variants for normal UI elements
- **Bright** (dark mode) / **Faded** (light mode) variants for emphasis

These auto-switch based on macOS appearance mode via `sync_theme`:
- **Pure prompt** - colors via `_pure_set_gruvbox` function (universal variables)
- **bat** - `--theme` in `bat/config`
- **delta** - `syntax-theme` in `.gitconfig`
- **fzf** - theme sourced from `fish/fzf/gruvbox-{dark,light}.fish`
- **mitmproxy** - `console_palette` in `mitmproxy/config.yaml` (Solarized, no Gruvbox)
- **Claude Code** - `theme` in `~/.claude.json` (not tracked)
- **Gemini CLI** - `ui.theme` in `gemini/settings.json`
- **VS Code** - `workbench.colorTheme` in `vscode/settings.json`

Files with theme settings will show as modified in git due to automatic switching. Only commit non-theme changes.

## Terminal Stack

- **Shell**: Fish with Pure prompt and FZF integration
- **Multiplexer**: tmux with Ctrl+A prefix, vim-style navigation
- **Terminal**: Ghostty with Gruvbox theme (auto dark/light mode)

