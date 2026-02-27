# Changelog

All notable changes to the AI-Dev-Orchestrator project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
