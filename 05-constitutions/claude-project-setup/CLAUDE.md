# Project: {{PROJECT_NAME}}

## Constitution

This project follows the rules defined in:
@../CONSTITUTION.md

## Project Context

**Type:** {{PROJECT_TYPE}}
**Tech Stack:** {{TECH_STACK}}
**Purpose:** {{PURPOSE}}

## Key Files

- `CONSTITUTION.md` - Non-negotiable rules and standards
- `README.md` - Project overview and setup
- `.claude/learnings/` - Project-specific learnings

## Project Learnings

Read these on demand — they are deliberately **not** `@`-imported:

- `.claude/learnings/learnings.md` — patterns, gotchas and observations
- `.claude/learnings/decisions.md` — architecture decisions and their rationale

They grow without bound as `/reflect` appends to them, and auto-loading the whole
corpus into every session is context pollution. Read or grep them when starting
work in an unfamiliar part of the codebase.

## Working Agreements

1. Always check CONSTITUTION.md before implementing
2. Reference learnings before starting new work
3. Update learnings when discovering something notable
4. Use `/reflect` at end of significant sessions

---

*Replace {{PLACEHOLDERS}} with project-specific values*
