# Agent Instructions

## Tools

- Use `gh` CLI for GitHub interactions and `glab` CLI for GitLab interactions
- GNU versions of sed, grep, tar, find, etc. are prioritized over BSD versions. Use GNU syntax in scripts (e.g., `sed -i 'pattern'` not `sed -i '' 'pattern'`)

### Web & Documentation

- **Context7** - Library/framework docs, API specs, usage samples, setup instructions
- **WebSearch** - Find things on the web, current events, quick facts
- **WebFetch** - Read a specific URL (simple pages)
- **Firecrawl** - Scrape JS-heavy pages, crawl sites, extract structured data

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
- Keep descriptions concise and direct
- Use markdown in commit bodies and PR descriptions; use backticks for inline code and identifiers
- No Co-Authored-By footers
- Never mention your plugins or skills
