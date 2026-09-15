# Project: [Your Project Name]

## Project Context

**Type:** [web app / API / CLI tool / library / etc.]
**Purpose:** [One sentence describing what this project does]

## Technical Stack

- **Frontend:** [e.g., Next.js, React, Vue — or "N/A"]
- **Backend:** [e.g., Node.js, Python, Go — or "N/A"]
- **Database:** [e.g., PostgreSQL, Supabase, MongoDB — or "N/A"]
- **Language:** [e.g., TypeScript, Python, etc.]

## Constitution

@../CONSTITUTION.md

## Slash Commands

- `/reflect` — Capture session learnings (what worked, what broke, decisions made)
- `/wrap` — End-of-session cleanup with learnings capture and summary

## Learnings

Read these on demand — they are deliberately **not** `@`-imported:

- `.claude/learnings/learnings.md` — patterns, gotchas and observations
- `.claude/learnings/decisions.md` — architecture decisions and their rationale

They grow without bound as `/reflect` appends to them, and auto-loading the whole
corpus into every session is context pollution. Read or grep them when starting
work in an unfamiliar part of the codebase.

## Working Agreements

1. Run tests before committing
2. Follow existing code patterns and conventions
3. Use verbose, self-documenting names
4. Add comments that explain "why" not "what"
5. Never commit secrets or .env files
