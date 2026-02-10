# AGENTS.md

This is a macOS dotfiles repository for setting up development machines.

## Structure

```text
.
├── Brewfile          # Homebrew packages (formulas, casks, taps)
├── justfile          # Installation automation (just command runner)
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
│   ├── settings.json    # Claude settings
│   └── statusline.sh    # Claude statusline hook
├── bat/              # bat (cat replacement) config
├── mitmproxy/        # HTTP proxy config
├── gemini/           # Gemini CLI config and themes
├── codex/            # Codex CLI config
├── cc-safety-net/    # cc-safety-net custom rules
├── vscode/           # VS Code settings and keybindings
└── zed/              # Zed editor settings
```

## Key Commands

- `just` - Show available commands (grouped by category)
- `just all` - Full setup: brew, sync, fish, plugins, config
- `just sync` - Symlink all configs to their standard locations
- `just brew` / `just brew-all` - Install Brewfile packages
- `just fish` - Setup Fish shell as default
- `just plugins` - Install all plugins (vim, tmux, docker, npm)
- `just config` - Run macOS system preferences script
- `just clean` - Remove all symlinked configs (requires confirmation)
- `upgrade` - Fish function to update Homebrew, Fisher, App Store, and global npm packages

## Conventions

- **Symlinks over copies**: Configs are symlinked from this repo to their target locations (e.g., `~/.config/fish`)
- **Brewfile**: All packages managed via Homebrew. Add new tools here, not manually
- **Fish functions**: One function per file in `fish/functions/`
- **Ghostty keybindings**: Use tmux-style Ctrl+A prefix for consistency

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```text
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
4. **New config directory**: Add symlink target to `justfile`'s sync recipes
5. **Renaming/moving/deleting files**: Update `justfile` sync and clean recipes accordingly

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
- **Zed** - `theme` in `zed/settings.json` (uses system mode, auto-switches)

Files with theme settings will show as modified in git due to automatic switching. Only commit non-theme changes.

## Terminal Stack

- **Shell**: Fish with Pure prompt and FZF integration
- **Multiplexer**: tmux with Ctrl+A prefix, vim-style navigation
- **Terminal**: Ghostty with Gruvbox theme (auto dark/light mode)
