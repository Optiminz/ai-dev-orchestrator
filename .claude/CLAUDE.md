# Project: AI Dev Orchestrator

## Constitution

This project provides constitution templates for other projects:
- `CONSTITUTION-TEMPLATE.md` (main template)
- `templates/ai-agent-constitution.md`
- `templates/client-app-constitution.md`
- `templates/internal-tool-constitution.md`

## Project Context

**Type:** Meta-project (tooling for AI-assisted development)
**Purpose:** Provide orchestration patterns, personas, agents, and templates for AI-driven development workflows

## Key Concepts

- **Personas**: 5 role-based prompt files in `personas/` (Product Owner, Architect, Developer, QA, Tech Writer)
- **Agents**: Claude Code agent versions of each persona in `.claude/agents/` — auto-discovered by Claude Code
- **Constitutions**: Non-negotiable project rules — templates in `templates/`, main template at `CONSTITUTION-TEMPLATE.md`
- **Phases**: Planning → Implementation → Review → Documentation
- **Prompts**: 15 copy-paste prompts in `prompts/` for manual workflow with any AI tool

## Slash Commands Available

- `/orchestrate` — Full automated 4-phase development workflow (see `.claude/commands/orchestrate.md`)
- `/reflect` — Session reflection and learnings capture

## Key Files for Understanding This Repo

- `setup.sh` — Bootstrap script to install the framework into another project
- `ORCHESTRATION-INTEGRATION-GUIDE.md` — How agents + /orchestrate + learnings + superpowers work together
- `quick-start/README.md` — Manual workflow quickstart (for non-Claude Code users)
- `guides/claude-code-setup.md` — Claude Code specific setup guide

## Project Learnings

@.claude/learnings/learnings.md
@.claude/learnings/decisions.md

## Working Agreements

1. Templates should be self-documenting with clear placeholders
2. Keep personas focused on their specific role
3. Constitution templates should be technology-agnostic where possible
4. Use `/reflect` at end of sessions to capture learnings
