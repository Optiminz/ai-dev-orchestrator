# Recommended Plugins

Install these plugins to get the most out of Claude Code. Plugins are global — install once, use everywhere.

## Install the Essentials

```bash
/install-plugin superpowers
/install-plugin commit-commands
/install-plugin pr-review-toolkit
```

**superpowers** — Adds disciplined workflows: brainstorming before building, TDD, structured debugging, verification before calling things done. Most skills fire automatically.

**commit-commands** — `/commit` and `/commit-push-pr` with Conventional Commits format.

**pr-review-toolkit** — Six specialized code review agents that each focus on a different angle (silent failures, types, tests, logic, complexity, comments).

## Highly Recommended

```bash
/install-plugin feature-dev
/install-plugin hookify
```

**feature-dev** — Guided feature development with deep codebase understanding.

**hookify** — Create hooks to prevent bad patterns (e.g., never commit .env files).

## Nice to Have

| Plugin | Purpose |
|--------|---------|
| `ralph-loop` | Iterative implementation loops |
| `vercel` | Deploy to Vercel from Claude Code |
| `firecrawl` | Web scraping and research |
| `playground` | Interactive HTML explorers |
| `skill-creator` | Write your own custom skills |

For the full breakdown of what each plugin's skills do, see [01-learn-claude-code/essential-plugins.md](../01-learn-claude-code/essential-plugins.md).
