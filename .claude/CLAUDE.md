# Project: AI Dev Orchestrator

## Constitution

This project provides constitution templates for other projects:
- `05-constitutions/CONSTITUTION-TEMPLATE.md` (main template)
- `05-constitutions/ai-agent-constitution.md`
- `05-constitutions/client-app-constitution.md`
- `05-constitutions/internal-tool-constitution.md`

## Project Context

**Type:** Meta-project (tooling for AI-assisted development)
**Purpose:** Provide orchestration patterns, personas, and templates for AI-driven development workflows

## Key Concepts

- **Personas**: 5 role-based prompt files in `personas/` (Product Owner, Architect, Developer, QA, Tech Writer)
- **Constitutions**: Non-negotiable project rules — templates in `05-constitutions/`, main template at `05-constitutions/CONSTITUTION-TEMPLATE.md`
- **Phases**: Planning → Implementation → Review → Documentation
- **Prompts**: 15 copy-paste prompts in `04-prompts/` for manual workflow with any AI tool

## Slash Commands Available

- `/orchestrate` — Full automated 5-phase development workflow (see `.claude/commands/orchestrate.md`)
- `/code-review-cycle` — 4-phase code review: Audit → Triage → Fix → Verify
- `/persona-to-agent` — Convert persona definitions into Claude subagent files
- `/reflect` — Session reflection and learnings capture (standalone)
- `/wrap` — End-of-session cleanup: learnings, commit, push, PR

## Key Files for Understanding This Repo

- `setup.sh` — Bootstrap script to install the framework into another project
- `docs/orchestration-integration.md` — How /orchestrate, learnings, and superpowers work together
- `03-your-first-feature/README.md` — Manual workflow quickstart (for non-Claude Code users)
- `01-learn-claude-code/` — Claude Code fundamentals for beginners

## Project Learnings

Read these on demand — they are deliberately **not** `@`-imported:

- `.claude/learnings/learnings.md` — patterns and observations for this repo
- `.claude/learnings/decisions.md` — ADRs, including the four on the design of this
  learnings system itself

Not auto-loaded: an earlier `@`-import here silently never resolved (a CLAUDE.md
`@`-import is relative to the importing file, so from `.claude/` it looked for
`.claude/.claude/learnings/...`), and it was replaced with this pointer rather than
repaired — bulk-loading a growing corpus into every session is context pollution.
Grep them; `/reflect` appends to them.

## Working Agreements

1. Templates should be self-documenting with clear placeholders
2. Keep personas focused on their specific role
3. Constitution templates should be technology-agnostic where possible
4. Use `/reflect` at end of sessions to capture learnings
5. Update `CHANGELOG.md` when making notable changes — use Keep a Changelog format, bump the version (semver), and date entries as `YYYY-MM-DD`
