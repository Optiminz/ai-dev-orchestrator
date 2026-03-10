# Changelog

All notable changes to the AI-Dev-Orchestrator project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [3.1.0] - 2026-03-10

### Added
- `01-learn-claude-code/mcp-launchpad.md` — Guide to MCP Launchpad (mcpl) for on-demand MCP tools, saving 20k+ tokens per session
- MCP Launchpad cross-reference in `essential-plugins.md` and `README.md`

### Changed
- `guides/cursor-setup.md` — Recommend Claude Code extension as primary AI tool in Cursor, with built-in AI as optional secondary

---

## [3.0.1] - 2026-03-10

### Added
- `/wrap` slash command (`.claude/commands/wrap.md`) — end-of-session cleanup with prerequisites
- `.claude/commands/README.md` — explains infrastructure dependencies for all slash commands

### Changed
- `/wrap` and `session-learnings` now include Prerequisites sections that tell Claude Code to check for and offer to set up missing infrastructure

---

## [3.0.0] - 2026-03-09

### Added
- `01-learn-claude-code/` — Claude Code fundamentals for beginners (what it is, install, core concepts, essential plugins, permissions guidance)
- `02-starter-kit/` — Copyable `.claude/` config with recommended plugins list
- `06-orchestrate/README.md` — Modernized orchestration docs with plugin mapping
- Wrap skill recommended for end-of-session cleanup

### Changed
- **README.md** rewritten as beginner-first landing page with learning path
- **`/orchestrate`** modernized — uses superpowers + pr-review-toolkit instead of custom agents (927 → 222 lines)
- **`setup.sh`** updated — no longer copies agents (plugins supersede)
- `quick-start/` → `03-your-first-feature/`
- `prompts/` → `04-prompts/`
- `templates/` + `examples/` → `05-constitutions/` (consolidated)
- `workflow/` → absorbed into `06-orchestrate/`

### Removed
- Custom agents: product-owner, solutions-architect, specialist-developer, qa-engineer, frontend-design-orchestrator (superseded by superpowers + pr-review-toolkit plugins)
- `guides/claude-code-setup.md` (content moved to `01-learn-claude-code/`)
- `guides/getting-started.md` (content absorbed into `03-your-first-feature/`)
- `guides/replit-setup.md` (out of scope — focus is Claude Code + Cursor)
- Stop hook references in /orchestrate (never existed as actual scripts)
- Ralph Loop hard dependency in /orchestrate (superpowers handles iteration)

---

## [2.1.0] - 2026-02-27

### Added
- **`setup.sh` bootstrapper** — one-command script to install the framework into any project; generates a `CLAUDE.md` with embedded first-run instructions for Claude to auto-configure itself from the codebase
- **Claude Code agents** (`.claude/agents/`) — all 5 role personas now available as Claude Code agents auto-discovered in any session: Product Owner, Solutions Architect, Specialist Developer, QA Engineer, Technical Writer, plus Frontend Design Orchestrator
- **`/reflect` slash command** added to repo so it's available to anyone who clones it
- **`ORCHESTRATION-INTEGRATION-GUIDE.md`** — documents how agents, `/orchestrate`, learnings, and Superpowers work together

### Changed
- **README restructured** — quickstart and `setup.sh` first, philosophy second; includes real `/orchestrate` run example with approval checkpoints
- **`CONSTITUTION-TEMPLATE.md` trimmed** — removed ~100 lines of conventions Claude already knows (naming conventions, import order, gitflow); kept only rules that constrain AI behaviour
- **Learnings system simplified** — 3 files (insights/gotchas/decisions) collapsed to 2 (learnings/decisions) across all templates and guides
- **`.claude/CLAUDE.md` expanded** — new sessions now auto-load full context on agents, commands, key files, and 4-phase workflow

### Rationale
Changes driven by external feedback: README was too philosophy-first for new users; constitution was wasting tokens on things Claude already knows by language/ecosystem; adoption path was unclear without a bootstrap script.

---

## [2.0.0] - 2025-12-29

### Breaking Changes
- **TypeScript Required on Frontend**: Constitution templates now mandate TypeScript (strict mode) across the entire stack. Projects using JavaScript-only frontend should migrate or use v1.x templates.

### Added
- **Type Sharing Section**: Explicit guidance on sharing types between frontend and backend via `shared/schema.ts`
- **AI Model Assumptions**: New section documenting which AI models the framework is designed for
- **Version History Requirement**: Constitutions must now include revision history table

### Changed
- **Simplicity Principle Clarified**: Expanded to explain what simplicity means AND doesn't mean
- **Testing Requirements**: Now include specific coverage thresholds instead of vague "adequate testing"
- **Frontend Language Guidance**: Updated from optional TypeScript to mandatory TypeScript with strict mode

### Rationale
These changes are based on 6+ months of real-world usage in the OKM (Optimi Knowledge Manager) project. Key learnings:

1. **TypeScript prohibition was outdated**: Based on 2023-era AI limitations (GPT-3.5, early Claude). Current models (Claude Sonnet 4+, GPT-4+) excel at TypeScript and the type safety significantly reduces bugs.

2. **Type sharing prevents bugs**: Projects with shared schema types between frontend/backend had significantly fewer API integration bugs.

3. **Vague testing requirements led to undertesting**: Specific thresholds give teams clear targets.

4. **"Simplicity" was misinterpreted**: Teams avoided useful tools (TypeScript, Zod) thinking it violated simplicity principles. Clarified that simplicity means proven, well-documented tools, not avoiding powerful features.

---

## [1.0.0] - 2025-01-15

### Added
- Initial release of AI-Dev-Orchestrator
- 15 copy-paste prompts for AI-assisted development
- 5 AI personas (Product Owner, Architect, Developer, QA, Writer)
- Constitution template
- 4-phase workflow
- Guides for Cursor, Claude Code, and Replit
- Comprehensive documentation and examples
