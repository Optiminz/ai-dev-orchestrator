# Slash Commands

These are [Claude Code slash commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands) — markdown prompts that Claude Code executes when you type `/command-name` in a session.

## Important: These Commands Build on Other Infrastructure

These commands are **not standalone**. They assume supporting infrastructure exists in your Claude Code environment. If you copy a command into your own project without the infrastructure, Claude Code will either skip steps silently or produce incomplete results.

**Each command's `.md` file includes a Prerequisites section** that tells Claude Code what to check for and what to help you set up. But here's the human-readable overview:

## Infrastructure Map

### Learnings System

Several commands (`/wrap`, `/reflect`) depend on a **learnings directory structure** for capturing session knowledge:

```
# Global (across all projects) — in your home Claude config
~/.claude/learnings/
  patterns.md      # Recurring patterns that work well
  mistakes.md      # Common mistakes and how to prevent them
  preferences.md   # Discovered user preferences

# Project-level (per repo) — committed to the repo
.claude/learnings/
  insights.md      # Project-specific discoveries
  decisions.md     # Architectural choices and rationale
  gotchas.md       # Edge cases and solutions
```

**Quick setup:**
```bash
# Global (once per machine)
mkdir -p ~/.claude/learnings
touch ~/.claude/learnings/{patterns,mistakes,preferences}.md

# Per project
mkdir -p .claude/learnings
touch .claude/learnings/{insights,decisions,gotchas}.md
```

### Skills & Plugins

Some commands invoke Claude Code **skills** (reusable prompt modules) and **plugins** (marketplace extensions). These need to be installed separately:

| Dependency | Type | Used by | Install |
|-----------|------|---------|---------|
| `session-learnings` | Skill | `/wrap`, `/reflect` | Copy `skills/session-learnings/` to `~/.claude/skills/` |
| `superpowers` | Plugin | `/orchestrate` | Install from Claude Code marketplace |
| `pr-review-toolkit` | Plugin | `/orchestrate` | Install from Claude Code marketplace |
| `commit-commands` | Plugin | `/orchestrate` | Install from Claude Code marketplace |
| `best-practice-git` | Skill | `/wrap` | Copy to `~/.claude/skills/` |

### External Tools

| Tool | Used by | Install |
|------|---------|---------|
| `gh` (GitHub CLI) | `/wrap` (PR creation) | `brew install gh && gh auth login` |
| `git` | `/wrap`, `/orchestrate` | Required — must be in an initialized repo |

### Project Files

| File | Used by | Purpose |
|------|---------|---------|
| `CONSTITUTION.md` | `/orchestrate` | Non-negotiable project rules and tech stack |
| `CLAUDE.md` | `/wrap` | Optional `## Wrap Config` section for auto-format/lint settings |
| `.claude/agents/technical-writer.md` | `/orchestrate` | Optional — Phase 4 documentation agent |

## Command Reference

| Command | Purpose | Key Dependencies |
|---------|---------|-----------------|
| `/orchestrate` | Full 5-phase dev workflow (explore, plan, build, review, document) | `CONSTITUTION.md`, superpowers + pr-review-toolkit + commit-commands plugins |
| `/wrap` | End-of-session cleanup (learnings, format, commit, push, PR) | Learnings directories, `gh` CLI (optional) |
| `/reflect` | Capture session learnings | Learnings directories |
| `/persona-to-agent` | Convert persona definitions to Claude agent files | None — self-contained |

## Using These in Your Own Project

1. **Start simple** — Copy `/reflect` first. It only needs the learnings directories.
2. **Add `/wrap`** — Once learnings are working, `/wrap` builds on top with git integration.
3. **Go full workflow** — `/orchestrate` is the most demanding. Set up `CONSTITUTION.md` and the required plugins first.

You don't need all commands. Pick what fits your workflow and set up the infrastructure for just those.
