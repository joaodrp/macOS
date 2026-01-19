# Agent Instructions

## Tools

- Use Context7 MCP for library docs, APIs, and setup instructions without asking
- Use `gh` CLI for GitHub interactions and `glab` CLI for GitLab interactions
- GNU versions of sed, grep, tar, find, etc. are prioritized over BSD versions. Use GNU syntax in scripts (e.g., `sed -i 'pattern'` not `sed -i '' 'pattern'`)

## GitLab

### MR Reviews

- To request a review on a GitLab MR, post a comment with the quick action: `/request_review @username`
- Example: `glab mr note <MR_ID> --repo <repo> -m "/request_review @reviewer"`

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
