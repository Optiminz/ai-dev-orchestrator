# Project Learnings

What we've discovered while working on this project — patterns, gotchas, and notable observations.

---

## 2025-05-01: Session Learning System Created
- Created a self-improving learning system for Claude Code
- Global learnings at `~/.claude/learnings/` apply across all repos
- Project learnings at `.claude/learnings/` are repo-specific
- `/reflect` command triggers comprehensive session review

---

## 2026-04-07: Commands in this repo drift from global versions
- This repo is the *origin* of `/reflect`, `/wrap`, `/orchestrate`, etc. but the global copies at `~/.claude/commands/` evolve independently during daily use
- `/repo-health` Check 13 (skills coverage) caught that CLAUDE.md's slash command list was incomplete, but didn't catch command content drift
- `/skill-scan` surfaced `reflect.md` referencing the deprecated 3-file learnings structure and `wrap.md` missing the audit log step
- **Prevention:** When running `/repo-health` on this repo, also diff `.claude/commands/*.md` against `~/.claude/commands/*.md` to catch content drift
- **Tracked:** Optiminz/ai-dev-orchestrator#8

---

<!-- New learnings will be appended below -->
