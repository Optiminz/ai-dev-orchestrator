# Beginner-First Repo Restructure — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Restructure ai-dev-orchestrator into a numbered learning path that teaches Claude Code fundamentals first, then graduates into the orchestration framework.

**Architecture:** Move existing content into numbered directories (01-06), create new beginner content (01, 02), retire custom agents (plugins supersede), modernize /orchestrate to use plugin ecosystem, update setup.sh and README.

**Tech Stack:** Markdown, Bash (setup.sh), YAML (workflow state)

---

## Task 1: Create Directory Structure

**Files:**
- Create: `01-learn-claude-code/` (directory)
- Create: `02-starter-kit/.claude/commands/` (nested directories)
- Create: `06-orchestrate/` (directory)

**Step 1: Create all new directories**

Run:
```bash
cd /Users/malcolm/Projects/ai-dev-orchestrator
mkdir -p 01-learn-claude-code
mkdir -p 02-starter-kit/.claude/commands
mkdir -p 06-orchestrate
mkdir -p 05-constitutions/examples
```

**Step 2: Verify directories exist**

Run: `ls -d 01-learn-claude-code 02-starter-kit 06-orchestrate 05-constitutions`
Expected: All four listed

**Step 3: Commit**

```bash
git add 01-learn-claude-code/.gitkeep 02-starter-kit/.gitkeep 06-orchestrate/.gitkeep 05-constitutions/.gitkeep
git commit -m "chore: create numbered directory structure for learning path"
```

Note: Git doesn't track empty directories. Create `.gitkeep` files or skip this commit and let the first content commit handle it.

---

## Task 2: Move Existing Content — Prompts

**Files:**
- Move: `prompts/` → `04-prompts/`

**Step 1: Move the directory**

Run: `git mv prompts 04-prompts`

**Step 2: Update the README inside 04-prompts**

Modify: `04-prompts/README.md`
- Add a note at the top: "These prompts work with ANY AI tool — Claude Code, Cursor, ChatGPT, Gemini, etc."
- Keep existing content

**Step 3: Verify move**

Run: `ls 04-prompts/phase-1-planning/`
Expected: All 4 planning prompts listed

**Step 4: Commit**

```bash
git add -A
git commit -m "refactor: move prompts/ to 04-prompts/ for numbered learning path"
```

---

## Task 3: Move Existing Content — Quick Start

**Files:**
- Move: `quick-start/` → `03-your-first-feature/`

**Step 1: Move the directory**

Run: `git mv quick-start 03-your-first-feature`

**Step 2: Verify move**

Run: `ls 03-your-first-feature/`
Expected: README.md, simple-workflow.md, process-task-list.md

**Step 3: Commit**

```bash
git add -A
git commit -m "refactor: move quick-start/ to 03-your-first-feature/"
```

---

## Task 4: Move Existing Content — Constitutions & Examples

**Files:**
- Move: `CONSTITUTION-TEMPLATE.md` → `05-constitutions/CONSTITUTION-TEMPLATE.md`
- Move: `templates/internal-tool-constitution.md` → `05-constitutions/internal-tool.md`
- Move: `templates/client-app-constitution.md` → `05-constitutions/client-app.md`
- Move: `templates/ai-agent-constitution.md` → `05-constitutions/ai-agent.md`
- Move: `templates/README.md` → `05-constitutions/README.md`
- Move: `examples/` contents → `05-constitutions/examples/`
- Move: `templates/claude-project-setup/` → `05-constitutions/claude-project-setup/`

**Step 1: Move constitution template**

Run: `git mv CONSTITUTION-TEMPLATE.md 05-constitutions/CONSTITUTION-TEMPLATE.md`

**Step 2: Move template files (rename to drop "constitution" suffix)**

Run:
```bash
git mv templates/internal-tool-constitution.md 05-constitutions/internal-tool.md
git mv templates/client-app-constitution.md 05-constitutions/client-app.md
git mv templates/ai-agent-constitution.md 05-constitutions/ai-agent.md
git mv templates/README.md 05-constitutions/README.md
git mv templates/claude-project-setup 05-constitutions/claude-project-setup
```

**Step 3: Move examples into constitutions**

Run:
```bash
git mv examples/internal-tool 05-constitutions/examples/internal-tool
git mv examples/client-app 05-constitutions/examples/client-app
git mv examples/ai-agent 05-constitutions/examples/ai-agent
git mv examples/sample-outputs 05-constitutions/examples/sample-outputs
git mv examples/README.md 05-constitutions/examples/README.md
```

**Step 4: Remove now-empty directories**

Run:
```bash
rmdir templates 2>/dev/null || true
rmdir examples 2>/dev/null || true
```

**Step 5: Verify structure**

Run: `find 05-constitutions -type f | sort`
Expected: All constitution templates, examples, and READMEs

**Step 6: Commit**

```bash
git add -A
git commit -m "refactor: consolidate templates/ and examples/ into 05-constitutions/"
```

---

## Task 5: Move Workflow Content into 06-orchestrate

**Files:**
- Move: `workflow/workflow-overview.md` → `06-orchestrate/how-it-works.md`
- Move: `workflow/phase-checklist.md` → `06-orchestrate/phase-checklist.md`
- Move: `workflow/prompt-selection-guide.md` → `06-orchestrate/prompt-selection-guide.md`
- Create: `06-orchestrate/README.md`

**Step 1: Move workflow files**

Run:
```bash
git mv workflow/workflow-overview.md 06-orchestrate/how-it-works.md
git mv workflow/phase-checklist.md 06-orchestrate/phase-checklist.md
git mv workflow/prompt-selection-guide.md 06-orchestrate/prompt-selection-guide.md
```

**Step 2: Remove empty workflow directory**

Run: `rmdir workflow 2>/dev/null || true`

**Step 3: Create 06-orchestrate/README.md**

```markdown
# /orchestrate — Automated AI Development Workflow

The `/orchestrate` command automates a 4-phase development workflow with human approval checkpoints. It's the most advanced feature of this framework.

## Prerequisites

Before using `/orchestrate`, you need:

1. **Claude Code** installed and authenticated
2. **Plugins installed:**
   - `superpowers` (brainstorming, TDD, plans, verification)
   - `pr-review-toolkit` (code review)
   - `commit-commands` (git workflow)
3. **CONSTITUTION.md** in your project root
4. A **feature request** or idea to build

## How It Works

`/orchestrate` runs 5 phases, pausing for your approval between each:

| Phase | What happens | Plugin used |
|-------|-------------|-------------|
| **0 — Explore** | Brainstorm and clarify requirements | `superpowers:brainstorming` |
| **1 — Plan** | Create implementation plan from spec | `superpowers:writing-plans` |
| **2 — Build** | Implement task-by-task with tests | `superpowers:test-driven-development` or `subagent-driven-development` |
| **3 — Review** | Comprehensive code review | `pr-review-toolkit:review-pr` |
| **4 — Document** | Generate/update documentation | Technical Writer agent |
| **Ship** | Merge/PR decision | `superpowers:finishing-a-development-branch` |

## Usage

```bash
# Full workflow
/orchestrate "Build user authentication with email and OAuth"

# Skip planning (if you already have a spec)
/orchestrate --skip-planning --tasks-from docs/existing-tasks.md

# Single phase
/orchestrate --phase review
```

## Human Checkpoints

You approve at each phase transition — the AI never ships without your sign-off:

1. After brainstorming: "Does this capture what you want?"
2. After planning: "Review the plan. Ready to build?"
3. After building: "Implementation complete. Ready for review?"
4. After review: "Issues found. Fix and continue?"
5. After docs: "Ready to ship?"

## Learn More

- [How it works in detail](how-it-works.md)
- [Phase checklist](phase-checklist.md)
- [Which prompt/phase to use](prompt-selection-guide.md)
```

**Step 4: Commit**

```bash
git add -A
git commit -m "refactor: move workflow/ into 06-orchestrate/ with new README"
```

---

## Task 6: Trim Guides Directory

**Files:**
- Remove: `guides/claude-code-setup.md` (content moves to 01-learn-claude-code/)
- Remove: `guides/getting-started.md` (content absorbed into 03-your-first-feature/)
- Remove: `guides/replit-setup.md` (out of scope)
- Keep: `guides/cursor-setup.md`
- Keep: `guides/session-learning-system.md`
- Keep: `guides/project-onboarding.md`

**Step 1: Remove superseded guides**

Run:
```bash
git rm guides/claude-code-setup.md
git rm guides/getting-started.md
git rm guides/replit-setup.md
```

**Step 2: Verify remaining guides**

Run: `ls guides/`
Expected: cursor-setup.md, session-learning-system.md, project-onboarding.md

**Step 3: Commit**

```bash
git add -A
git commit -m "refactor: trim guides/ — beginner content moves to 01-learn-claude-code/"
```

---

## Task 7: Retire Custom Agents

**Files:**
- Remove: `.claude/agents/product-owner-prd.md`
- Remove: `.claude/agents/solutions-architect.md`
- Remove: `.claude/agents/specialist-developer.md`
- Remove: `.claude/agents/qa-engineer.md`
- Remove: `.claude/agents/frontend-design-orchestrator.md`
- Keep: `.claude/agents/technical-writer.md`

**Step 1: Remove superseded agents**

Run:
```bash
git rm .claude/agents/product-owner-prd.md
git rm .claude/agents/solutions-architect.md
git rm .claude/agents/specialist-developer.md
git rm .claude/agents/qa-engineer.md
git rm .claude/agents/frontend-design-orchestrator.md
```

**Step 2: Verify technical-writer remains**

Run: `ls .claude/agents/`
Expected: technical-writer.md

**Step 3: Commit**

```bash
git add -A
git commit -m "refactor: retire custom agents — superpowers and pr-review-toolkit supersede"
```

---

## Task 8: Write 01-learn-claude-code/what-is-claude-code.md

**Files:**
- Create: `01-learn-claude-code/what-is-claude-code.md`

**Step 1: Write the file**

Content should cover:
- **What it is:** Anthropic's CLI tool for AI-assisted coding. Runs in your terminal. Reads and writes your actual project files, runs commands, and manages git.
- **How it's different from ChatGPT:** ChatGPT is a chat window — you copy-paste code back and forth. Claude Code lives IN your project, sees your full codebase, and makes changes directly.
- **How it's different from Cursor:** Cursor is an IDE with AI autocomplete built in. Claude Code is a terminal-first tool that acts more like a pair programmer — you describe what you want, it plans and executes. Claude Code also has a VS Code extension that brings the same experience into VS Code/Cursor.
- **The mental shift:** You're directing an AI developer, not writing code yourself. You describe outcomes ("add user authentication"), not instructions ("create a file called auth.js and write a function...").
- **What it can do:** Read/write files, run terminal commands, search codebases, manage git, install packages, run tests, browse the web (with plugins), and remember context across sessions.

**Step 2: Verify file renders correctly**

Run: `wc -l 01-learn-claude-code/what-is-claude-code.md`
Expected: 60-120 lines (concise but thorough)

**Step 3: Commit**

```bash
git add 01-learn-claude-code/what-is-claude-code.md
git commit -m "docs: add 'What is Claude Code?' beginner guide"
```

---

## Task 9: Write 01-learn-claude-code/installation.md

**Files:**
- Create: `01-learn-claude-code/installation.md`

**Step 1: Write the file**

Content should cover:

**Claude Code CLI:**
- Prerequisites: Node.js 18+, an Anthropic API key or Claude Pro/Max subscription
- Install: `npm install -g @anthropic-ai/claude-code`
- First run: `cd your-project && claude` — walk through auth
- Verify: Ask Claude "read my README and summarize it"

**Cursor IDE Integration:**
- Install the Claude Code extension from VS Code marketplace
- How to open Claude Code panel in Cursor
- When to use CLI vs Cursor integration (CLI for terminal workflows, Cursor for visual editing)

**VS Code Integration:**
- Same extension, same process
- Note: Claude Code works in both VS Code and Cursor since Cursor is VS Code-based

**Step 2: Commit**

```bash
git add 01-learn-claude-code/installation.md
git commit -m "docs: add Claude Code installation guide for CLI and Cursor"
```

---

## Task 10: Write 01-learn-claude-code/core-concepts.md

**Files:**
- Create: `01-learn-claude-code/core-concepts.md`

**Step 1: Write the file**

Cover each concept with a 1-2 sentence explanation + practical example:

- **CLAUDE.md** — A markdown file in your project root (or `.claude/CLAUDE.md`) that tells Claude about your project. Think of it as a briefing document. Claude reads it at the start of every session.

- **Slash Commands** — Custom commands you create as markdown files in `.claude/commands/`. Example: create `.claude/commands/deploy.md` with deployment instructions, then type `/deploy` in Claude Code. They're like saved prompts that Claude follows.

- **Plugins** — Installable packages that add capabilities to Claude Code. You install them once and they work across all projects. Example: the `superpowers` plugin adds brainstorming, TDD, and debugging workflows. Install via Claude Code settings.

- **Skills** — Skills live INSIDE plugins. When you install a plugin, its skills become available. **Key insight: most skills fire automatically.** You don't type `/brainstorming` — superpowers detects you're about to build something and fires the brainstorming skill on its own. This is the magic of plugins.

- **Agents (sub-agents)** — When Claude faces a complex task, it can spawn sub-agents to handle parts of it in parallel. These are NOT the same as the "agent files" in `.claude/agents/` (those are custom prompt templates). Sub-agents are a built-in Claude Code capability.

- **Agent Files (.claude/agents/)** — Markdown files that define specialized behaviors. When Claude Code sees an agent file, it can invoke that persona for specific tasks. Think of them as role descriptions.

- **Hooks** — Shell commands that run automatically on events (before/after tool calls, on commit, etc.). Example: a pre-commit hook that runs linting. Configure in `.claude/settings.json`.

- **Learnings (.claude/learnings/)** — Markdown files where Claude captures patterns, mistakes, and decisions. Persists across sessions so Claude doesn't repeat mistakes. Use `/reflect` to capture learnings at the end of a session.

**Step 2: Commit**

```bash
git add 01-learn-claude-code/core-concepts.md
git commit -m "docs: add Claude Code core concepts guide"
```

---

## Task 11: Write 01-learn-claude-code/essential-plugins.md

**Files:**
- Create: `01-learn-claude-code/essential-plugins.md`

**Step 1: Write the file**

Structure:
1. How to install plugins (Claude Code settings UI or CLI)
2. Crucial plugins table (superpowers, commit-commands, pr-review-toolkit) with what each does and why
3. Highly recommended plugins (feature-dev, hookify)
4. Nice to have plugins (ralph-loop, vercel, firecrawl, playground)
5. Key skills from superpowers — grouped by purpose:
   - Workflow skills (brainstorming, writing-plans, executing-plans)
   - Implementation skills (test-driven-development, subagent-driven-development, dispatching-parallel-agents)
   - Quality skills (verification-before-completion, systematic-debugging, requesting-code-review, receiving-code-review)
   - Git skills (using-git-worktrees, finishing-a-development-branch)
6. The key insight section: "You don't manually invoke most skills — superpowers fires them automatically based on what you're doing. Install the plugin and your coding workflow gets disciplined guardrails without you thinking about it."

**Step 2: Commit**

```bash
git add 01-learn-claude-code/essential-plugins.md
git commit -m "docs: add essential plugins and skills guide"
```

---

## Task 12: Create Starter Kit

**Files:**
- Create: `02-starter-kit/README.md`
- Create: `02-starter-kit/.claude/CLAUDE.md`
- Copy: `.claude/commands/reflect.md` → `02-starter-kit/.claude/commands/reflect.md`
- Create: `02-starter-kit/recommended-plugins.md`

**Step 1: Write 02-starter-kit/README.md**

```markdown
# Starter Kit

A ready-to-use Claude Code configuration you can copy into any project.

## What's Included

- `.claude/CLAUDE.md` — Project config template with sensible defaults
- `.claude/commands/reflect.md` — `/reflect` command for capturing session learnings

## How to Use

1. Copy the `.claude/` folder into your project root:
   ```bash
   cp -r 02-starter-kit/.claude/ /path/to/your-project/.claude/
   ```

2. Edit `.claude/CLAUDE.md` and fill in your project details

3. Install the recommended plugins (see [recommended-plugins.md](recommended-plugins.md))

4. Start Claude Code in your project: `cd your-project && claude`

## What's NOT Included

- **No agents** — Plugins (superpowers, pr-review-toolkit) handle this better
- **No /orchestrate** — That's an advanced workflow; see [06-orchestrate/](../06-orchestrate/) when you're ready
- **No personal preferences** — Timezone, emoji, org-specific integrations are yours to configure
```

**Step 2: Write 02-starter-kit/.claude/CLAUDE.md**

A minimal but useful starter config:
- Project name/type placeholder
- Points to CONSTITUTION.md
- Lists available commands (/reflect)
- Learnings system reference
- Sensible defaults: run tests before commits, security checks, verbose naming

**Step 3: Copy reflect command**

Run: `cp .claude/commands/reflect.md 02-starter-kit/.claude/commands/reflect.md`

**Step 4: Write 02-starter-kit/recommended-plugins.md**

Condensed version of the essential-plugins.md with just the install instructions and brief descriptions. Link to `01-learn-claude-code/essential-plugins.md` for the full breakdown.

**Step 5: Commit**

```bash
git add 02-starter-kit/
git commit -m "docs: add starter kit with copyable .claude/ config"
```

---

## Task 13: Modernize /orchestrate Command

**Files:**
- Modify: `.claude/commands/orchestrate.md`

**Step 1: Rewrite orchestrate.md**

The modernized version should:

1. **Remove all persona/agent references** — no more "Invoke Product Owner persona" or "Read personas/01-product-owner.md"
2. **Map phases to plugins:**
   - Phase 0: Invoke `superpowers:brainstorming` skill
   - Phase 1: Invoke `superpowers:writing-plans` skill
   - Phase 2: Invoke `superpowers:test-driven-development` or `superpowers:subagent-driven-development`
   - Phase 3: Invoke `pr-review-toolkit:review-pr` skill
   - Phase 4: Use Technical Writer agent (the one surviving agent)
   - Ship: Invoke `superpowers:finishing-a-development-branch`
3. **Keep human checkpoints** between phases
4. **Remove stop hook references** — those shell scripts don't exist
5. **Remove Ralph Loop references** — superpowers handles iteration now
6. **Remove workflow-state.yaml** — over-engineered for current usage
7. **Keep the example usage section** — updated to reflect plugin-based flow
8. **Keep error handling section** — simplified

Target length: ~200-300 lines (down from 927). The plugins handle the complexity now.

**Step 2: Verify the command loads**

Run: `head -5 .claude/commands/orchestrate.md`
Expected: Valid markdown with title

**Step 3: Commit**

```bash
git add .claude/commands/orchestrate.md
git commit -m "refactor: modernize /orchestrate to use plugin ecosystem

Replaces custom agent invocations with superpowers and pr-review-toolkit.
Removes non-existent stop hooks and Ralph Loop dependencies.
Phases now map to: brainstorming → writing-plans → TDD → review-pr → technical-writer."
```

---

## Task 14: Rewrite README.md

**Files:**
- Modify: `README.md`

**Step 1: Rewrite as landing page**

Structure:
```markdown
# AI Dev Orchestrator

Learn Claude Code and build software with AI that actually works.

> Built by a non-coder pushing the limits... — MCS

## What This Is

[2-3 sentences: learning path from "what is Claude Code?" to fully automated workflows]

## The Learning Path

| Step | What You'll Learn | Time |
|------|------------------|------|
| [01 — Learn Claude Code](01-learn-claude-code/) | What it is, install, core concepts, essential plugins | 30 min |
| [02 — Starter Kit](02-starter-kit/) | Copy a ready-made config into your project | 5 min |
| [03 — Your First Feature](03-your-first-feature/) | Build something real with AI assistance | 1-2 hours |
| [04 — Prompts](04-prompts/) | 15 copy-paste prompts for any AI tool | Reference |
| [05 — Constitutions](05-constitutions/) | Project rules that keep AI consistent | 15 min |
| [06 — Orchestrate](06-orchestrate/) | Automated 4-phase workflow with /orchestrate | Advanced |

## Quick Start

**Never used Claude Code?** Start at [01 — Learn Claude Code](01-learn-claude-code/)

**Know Claude Code, want the framework?** Start at [04 — Prompts](04-prompts/) or grab the [02 — Starter Kit](02-starter-kit/)

**Just want the config?** Copy the starter kit and install plugins:
[brief 3-line instruction]

## How This Is Different

[Before/after: without framework (chaos, inconsistency, AI goes rogue) vs with framework (structured phases, quality gates, consistent output)]

## Works With Any AI Tool

The [prompts](04-prompts/) work with any AI — Claude Code, Cursor, ChatGPT, Gemini. The [starter kit](02-starter-kit/) and [/orchestrate](06-orchestrate/) are Claude Code specific.

## Requirements

- Claude Code CLI or any AI coding tool
- Node.js 18+ (for Claude Code)
- Optional: Cursor IDE

## Deep Dive

- [Orchestration integration guide](docs/orchestration-integration.md)
- [Research & academic foundations](docs/research-origin.md)
- [Session learning system](guides/session-learning-system.md)
- [Project onboarding at scale](guides/project-onboarding.md)
- [Cursor setup](guides/cursor-setup.md)
```

**Step 2: Verify rendering**

Run: `wc -l README.md`
Expected: 80-120 lines (concise landing page, not encyclopedia)

**Step 3: Commit**

```bash
git add README.md
git commit -m "docs: rewrite README as beginner-first landing page"
```

---

## Task 15: Update .claude/CLAUDE.md (Repo Config)

**Files:**
- Modify: `.claude/CLAUDE.md`

**Step 1: Update to reflect new structure**

- Update file paths (prompts → 04-prompts, templates → 05-constitutions, etc.)
- Remove references to 5 retired agents (keep technical-writer)
- Update key files list
- Update slash commands description
- Reference the new numbered directories

**Step 2: Commit**

```bash
git add .claude/CLAUDE.md
git commit -m "chore: update project CLAUDE.md for new repo structure"
```

---

## Task 16: Update setup.sh

**Files:**
- Modify: `setup.sh`

**Step 1: Update setup.sh**

Changes needed:
- Change `CONSTITUTION-TEMPLATE.md` source path to `05-constitutions/CONSTITUTION-TEMPLATE.md`
- Remove agent copying (was: copy `.claude/agents/*.md`) — plugins handle this now
- Keep command copying (orchestrate.md, reflect.md)
- Keep learnings directory creation
- Keep CLAUDE.md creation
- Update the header comment to reflect what it installs (no more "6 AI development agents")
- Update the success message

**Step 2: Test the script (dry run)**

Run: `bash -n setup.sh` (syntax check only)
Expected: No errors

**Step 3: Commit**

```bash
git add setup.sh
git commit -m "refactor: update setup.sh — remove agent copying, update paths"
```

---

## Task 17: Remove Orphaned Files and Cleanup

**Files:**
- Remove: `.claude/commands/README-ORCHESTRATE.md` (content now in 06-orchestrate/)
- Remove: `docs/plans/2026-02-27-repo-improvements.md` (superseded by this restructure)
- Verify: No broken internal links in remaining docs

**Step 1: Remove orphaned files**

Run:
```bash
git rm .claude/commands/README-ORCHESTRATE.md
```

**Step 2: Search for broken links**

Run: Search all .md files for references to old paths (prompts/, templates/, quick-start/, examples/, workflow/) and fix any found.

**Step 3: Commit**

```bash
git add -A
git commit -m "chore: remove orphaned files and fix internal links"
```

---

## Task 18: Update CHANGELOG.md

**Files:**
- Modify: `CHANGELOG.md`

**Step 1: Add new version entry**

Add entry at top for new version (likely 2.0.0 given the scope):

```markdown
## [2.0.0] - 2026-03-09

### Added
- `01-learn-claude-code/` — Claude Code fundamentals for beginners (what it is, install, core concepts, essential plugins)
- `02-starter-kit/` — Copyable .claude/ config with recommended plugins list
- `06-orchestrate/` — Modernized orchestration docs with plugin mapping

### Changed
- **README.md** rewritten as beginner-first landing page with learning path
- **`/orchestrate`** modernized to use superpowers + pr-review-toolkit instead of custom agents
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
```

**Step 2: Commit**

```bash
git add CHANGELOG.md
git commit -m "docs: update CHANGELOG for v2.0.0 restructure"
```

---

## Execution Order Summary

| Task | Description | Dependencies |
|------|-------------|-------------|
| 1 | Create directory structure | None |
| 2 | Move prompts → 04-prompts | Task 1 |
| 3 | Move quick-start → 03-your-first-feature | Task 1 |
| 4 | Move constitutions + examples → 05-constitutions | Task 1 |
| 5 | Move workflow → 06-orchestrate | Task 1 |
| 6 | Trim guides directory | None |
| 7 | Retire custom agents | None |
| 8 | Write what-is-claude-code.md | Task 1 |
| 9 | Write installation.md | Task 1 |
| 10 | Write core-concepts.md | Task 1 |
| 11 | Write essential-plugins.md | Task 1 |
| 12 | Create starter kit | Task 1 |
| 13 | Modernize /orchestrate | Task 7 |
| 14 | Rewrite README.md | Tasks 2-5, 8-12 |
| 15 | Update .claude/CLAUDE.md | Tasks 2-7 |
| 16 | Update setup.sh | Tasks 4, 7 |
| 17 | Remove orphans, fix links | Tasks 2-7 |
| 18 | Update CHANGELOG.md | All above |

**Parallelizable groups:**
- Tasks 2, 3, 4, 5, 6, 7 (all moves/deletes — independent)
- Tasks 8, 9, 10, 11, 12 (all new content — independent)
- Tasks 13, 14, 15, 16, 17 (updates — depend on moves being done)
- Task 18 (changelog — last)
