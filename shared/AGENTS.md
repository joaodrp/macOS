# AGENTS.md

## Tools

- Use `gh` CLI for GitHub interactions and `glab` CLI for GitLab interactions
- GNU versions of sed, grep, tar, find, etc. are prioritized over BSD versions. Use GNU syntax in scripts (e.g., `sed -i 'pattern'` not `sed -i '' 'pattern'`)
- Prefer individual or bulk operations through CLIs, MCP servers, or
  built-in tools over writing Bash/Python/AppleScript scripts. Scripts
  require explicit approval on each run and are harder to review.

### Search & Documentation

- **Context7 MCP** - Library/framework docs, API specs, usage samples, setup instructions
- **Your own web search tools** - Find things on the web, current events, quick facts
- **Firecrawl CLI** - Scrape JS-heavy pages, crawl sites, extract structured data
- **Perplexity MCP** - Deep research on complex topics requiring synthesis from multiple sources

### Web Testing

Prefer `agent-browser` CLI (and the corresponding Skill) to interacting direclty with Playwright.

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
- Never post comments on issues or PRs without explicit consent
- Never use em-dashes (—, ---, or --)

## Commits & PRs

- Follow [Conventional Commits](https://www.conventionalcommits.org/) for commit messages and PR titles
- One logical change per commit. Never batch unrelated fixes into a single
  commit.
- Never amend pushed commits. Verify push status before amending.
- Keep descriptions concise and direct
- Use markdown in commit bodies and PR descriptions; use backticks for inline code and identifiers
- No Co-Authored-By footers
- Never mention your plugins or skills
- After merging a PR, switch to the default branch and pull
- Before making changes on the default branch, create a new feature branch
