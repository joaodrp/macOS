# Agent Instructions

## Tools

- Use Context7 MCP for library docs, APIs, and setup instructions without asking
- GNU versions of sed, grep, tar, find, etc. are prioritized over BSD versions (see `~/.config/fish/config.fish`). Use GNU syntax in scripts (e.g., `sed -i 'pattern'` not `sed -i '' 'pattern'`)

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
