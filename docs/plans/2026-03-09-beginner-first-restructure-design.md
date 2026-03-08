# Design: Beginner-First Repo Restructure

**Date:** 2026-03-09
**Status:** Approved
**Goal:** Restructure ai-dev-orchestrator so new AI coders can learn Claude Code from scratch, then graduate into the orchestration framework.

---

## Decisions Made

1. **Primary goal:** Teach people Claude Code itself (not just the orchestration framework)
2. **Target audience:** New AI coders who may not know what Claude Code is
3. **Sharing approach:** Curated docs AND a copyable starter kit for plugins/skills
4. **IDE focus:** Claude Code CLI + Cursor
5. **Restructure level:** Full restructure with numbered learning path (few existing clones, no backwards-compat burden)
6. **Agent strategy:** Retire custom agents — plugins (superpowers, pr-review-toolkit) supersede them. Exception: Technical Writer agent stays (no plugin replacement)
7. **Persona strategy:** Keep personas/prompts as the portable "any AI tool" path
8. **Orchestrate strategy:** Modernize `/orchestrate` to call plugins instead of custom agents

---

## New Repo Structure

```
ai-dev-orchestrator/
├── README.md                          (rewritten as landing page)
├── setup.sh                           (updated bootstrap script)
├── LICENSE
├── CHANGELOG.md
│
├── 01-learn-claude-code/              (NEW — Claude Code fundamentals)
│   ├── what-is-claude-code.md
│   ├── installation.md
│   ├── core-concepts.md
│   └── essential-plugins.md
│
├── 02-starter-kit/                    (NEW — copyable config)
│   ├── README.md
│   ├── .claude/
│   │   ├── CLAUDE.md
│   │   └── commands/
│   │       └── reflect.md
│   └── recommended-plugins.md
│
├── 03-your-first-feature/             (evolved from quick-start/)
│   ├── README.md
│   ├── simple-workflow.md
│   └── process-task-list.md
│
├── 04-prompts/                        (renamed from prompts/)
│   ├── README.md                      (explains "use with ANY AI tool")
│   ├── phase-0-setup/
│   ├── phase-1-planning/
│   ├── phase-2-implementation/
│   ├── phase-3-review/
│   └── phase-4-documentation/
│
├── 05-constitutions/                  (evolved from templates/ + CONSTITUTION-TEMPLATE)
│   ├── README.md
│   ├── CONSTITUTION-TEMPLATE.md
│   ├── internal-tool.md
│   ├── client-app.md
│   ├── ai-agent.md
│   └── examples/                      (moved from examples/)
│       ├── internal-tool/
│       ├── client-app/
│       ├── ai-agent/
│       └── sample-outputs/
│
├── 06-orchestrate/                    (NEW — modernized automation docs)
│   ├── README.md
│   └── how-it-works.md
│
├── guides/                            (trimmed — beginner content moved to 01/)
│   ├── cursor-setup.md
│   ├── session-learning-system.md
│   └── project-onboarding.md
│
├── docs/                              (deep reference — stays)
│   ├── orchestration-integration.md
│   ├── research-origin.md
│   ├── software-pattern-visual.md
│   ├── template-variables.md
│   └── assets/
│
├── personas/                          (source material for prompts — stays)
│
├── .claude/                           (repo's own config — slimmed)
│   ├── CLAUDE.md
│   ├── agents/
│   │   └── technical-writer.md        (only surviving agent)
│   ├── commands/
│   │   ├── orchestrate.md             (modernized)
│   │   └── reflect.md
│   └── learnings/
│       ├── learnings.md
│       └── decisions.md
```

### What Moves Where

| Current Location | New Location | Notes |
|-----------------|-------------|-------|
| `quick-start/` | `03-your-first-feature/` | Renamed, content updated |
| `prompts/` | `04-prompts/` | Numbered prefix added |
| `templates/*.md` | `05-constitutions/` | Merged with CONSTITUTION-TEMPLATE.md |
| `CONSTITUTION-TEMPLATE.md` | `05-constitutions/CONSTITUTION-TEMPLATE.md` | Moved into directory |
| `examples/` | `05-constitutions/examples/` | Folded into constitutions |
| `guides/claude-code-setup.md` | Content split into `01-learn-claude-code/` files | Retired as standalone file |
| `guides/getting-started.md` | Content absorbed into `03-your-first-feature/` | Retired as standalone file |
| `guides/replit-setup.md` | Removed | Out of scope (focus is Claude Code + Cursor) |
| `.claude/agents/*.md` (5 files) | Removed | Plugins supersede (except technical-writer) |
| `workflow/` | Content absorbed into `06-orchestrate/` | Retired as standalone directory |

### What's New

| File | Purpose |
|------|---------|
| `01-learn-claude-code/what-is-claude-code.md` | What Claude Code is, how it differs from ChatGPT/Cursor |
| `01-learn-claude-code/installation.md` | CLI install + Cursor setup |
| `01-learn-claude-code/core-concepts.md` | CLAUDE.md, slash commands, plugins, skills, agents, hooks, learnings |
| `01-learn-claude-code/essential-plugins.md` | Tiered plugin/skill recommendations with install instructions |
| `02-starter-kit/` | Copyable .claude/ config + recommended-plugins.md |
| `06-orchestrate/how-it-works.md` | Phase breakdown with plugin mapping |

### What's Removed

| Item | Reason |
|------|--------|
| `.claude/agents/product-owner-prd.md` | superpowers:brainstorming replaces |
| `.claude/agents/solutions-architect.md` | superpowers:writing-plans + native Plan agent replaces |
| `.claude/agents/specialist-developer.md` | Opus 4.6 native + superpowers:TDD/subagent-dev replaces |
| `.claude/agents/qa-engineer.md` | pr-review-toolkit (6 specialized reviewers) replaces |
| `.claude/agents/frontend-design-orchestrator.md` | frontend-design plugin replaces |
| `guides/replit-setup.md` | Out of scope for target audience |

---

## README Structure

```markdown
# AI Dev Orchestrator

One-liner: Learn Claude Code and build software with AI that actually works.

## What This Repo Is
2-3 sentences positioning as a learning path.

## The Learning Path
01 → Learn Claude Code (fundamentals, install, concepts)
02 → Starter Kit (config + essential plugins)
03 → Your First Feature (hands-on walkthrough)
04 → Prompts (15 copy-paste prompts for any AI tool)
05 → Constitutions (project rules that keep AI on track)
06 → Orchestrate (automated 4-phase workflow)

## Quick Start (3 entry points)
- "I've never used Claude Code" → 01
- "I know Claude Code, show me the framework" → 04
- "Just give me the config" → 02 + setup.sh

## How This Repo Is Different
Before/after comparison.

## Requirements
Claude Code CLI, Node.js 18+, optional Cursor IDE.
```

---

## Plugin & Skills Recommendations

### Plugins — Tiered

**Crucial (install first):**
- **superpowers** — brainstorming, TDD, debugging, verification, plan execution
- **commit-commands** — `/commit` and `/commit-push-pr` with Conventional Commits
- **pr-review-toolkit** — 6 specialized code review agents

**Highly recommended:**
- **feature-dev** — guided feature development with codebase understanding
- **hookify** — create hooks to prevent bad patterns

**Nice to have:**
- **ralph-loop** — iterative implementation loops
- **vercel** — deployment (if using Vercel)
- **firecrawl** — web scraping/research
- **playground** — interactive HTML explorers

### Skills — Grouped by Purpose (all from superpowers)

**Workflow (how you approach work):**
| Skill | When it fires | Purpose |
|-------|--------------|---------|
| `brainstorming` | Before any creative/building work | Explore requirements, propose approaches, get approval |
| `writing-plans` | When you have specs/requirements | Turn designs into numbered implementation plans |
| `executing-plans` | When you have a written plan | Execute plans with review checkpoints |

**Implementation (how you build):**
| Skill | When it fires | Purpose |
|-------|--------------|---------|
| `test-driven-development` | Before writing implementation code | Write tests first, then implement |
| `subagent-driven-development` | When executing plans with independent tasks | Run multiple tasks via sub-agents |
| `dispatching-parallel-agents` | When facing 2+ independent tasks | Launch agents in parallel across worktrees |

**Quality (how you verify):**
| Skill | When it fires | Purpose |
|-------|--------------|---------|
| `verification-before-completion` | Before claiming work is done | Prove it works before saying "done" |
| `systematic-debugging` | When hitting a bug or test failure | Structured root-cause analysis |
| `requesting-code-review` | After completing a feature | Structured review before merging |
| `receiving-code-review` | When getting review feedback | Prevents blind implementation of suggestions |

**Git (how you ship):**
| Skill | When it fires | Purpose |
|-------|--------------|---------|
| `using-git-worktrees` | Starting isolated feature work | Isolated worktrees for parallel work |
| `finishing-a-development-branch` | Implementation done, tests pass | Guides merge/PR/cleanup decision |

**Key insight for beginners:** You don't manually invoke most of these. Superpowers fires them automatically based on what you're doing. Install the plugin and your workflow gets disciplined guardrails without thinking about it.

---

## Modernized /orchestrate Phase Mapping

| Phase | Current (custom agents) | Modernized (plugins) |
|-------|------------------------|---------------------|
| **Phase 0 — Explore** | _(none)_ | `superpowers:brainstorming` |
| **Phase 1 — Plan** | Product Owner → Solutions Architect agents | `superpowers:writing-plans` |
| **Phase 2 — Build** | Specialist Developer agent | `superpowers:subagent-driven-development` or `test-driven-development` |
| **Phase 3 — Review** | QA Engineer agent | `pr-review-toolkit:review-pr` (6 specialist reviewers) |
| **Phase 4 — Document** | Technical Writer agent | Technical Writer agent (**stays**) |
| **Ship** | _(manual)_ | `superpowers:finishing-a-development-branch` |

Human checkpoints remain between each phase.

---

## Starter Kit Contents

### `02-starter-kit/.claude/CLAUDE.md`
Minimal project config with:
- Project context placeholder
- Points to CONSTITUTION.md
- Available slash commands
- Learning system setup
- Sensible defaults (test before commit, security checks)

### `02-starter-kit/.claude/commands/reflect.md`
The `/reflect` command — universally useful.

### `02-starter-kit/recommended-plugins.md`
Tiered list with install instructions.

### NOT included:
- No agents (plugins replace them)
- No `/orchestrate` (advanced — lives in 06/)
- No personal preferences (timezone, emoji, org-specific integrations)

---

## 01-learn-claude-code/ Content Outline

### `what-is-claude-code.md`
- What it is (Anthropic's CLI tool)
- How it differs from ChatGPT (terminal, reads/writes files, runs commands)
- How it differs from Cursor (CLI-first vs IDE-first, agents vs autocomplete)
- The mental shift: directing an AI developer, not typing code

### `installation.md`
- CLI install (npm, auth, first run)
- Cursor IDE setup (extension)
- Verification ("read my README and summarize it")

### `core-concepts.md`
- CLAUDE.md — project config
- Slash commands — custom commands in .claude/commands/
- Plugins — install to add capabilities
- Skills — live inside plugins, fire automatically (key insight)
- Agents — sub-agents Claude spawns for complex tasks
- Hooks — shell commands on events
- Learnings — .claude/learnings/ for cross-session memory

### `essential-plugins.md`
- Full tiered tables (plugins + skills)
- Install instructions
- "You don't manually invoke most skills" explanation
