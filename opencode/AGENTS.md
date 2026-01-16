# Agent Instructions

## Tools

- Use Context7 MCP for library docs, APIs, and setup instructions without asking

## Code

- No emojis unless requested
- Follow existing patterns in the codebase

## Communication

- Be direct and concise
- Ask when there are genuine trade-offs or ambiguity

## Commits

- Follow [Conventional Commits](https://www.conventionalcommits.org/)
- Keep descriptions concise and direct. Use markdown formatting for code or identifiers
- No Co-Authored-By footers
- These files auto-switch based on macOS appearance mode. Only commit non-theme changes:
  - `.gitconfig` - do not commit `delta.syntax-theme` changes
  - `bat/config` - do not commit `--theme` changes
  - `mitmproxy/config.yaml` - do not commit `console_palette` changes
