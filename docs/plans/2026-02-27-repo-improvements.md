# Repo Improvements Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Improve onboarding, reduce friction for new users adopting the framework, and trim the constitution template of conventions Claude already knows.

**Architecture:** Five independent changes in dependency order: learnings collapse first (other tasks reference the final structure), then CLAUDE.md, constitution trim, setup script, and finally README (references everything else).

**Tech Stack:** Markdown, Bash

---

## Task 1: Collapse 3 Learnings Files → 2

**Why:** Three files (insights, decisions, gotchas) creates categorization overhead. Collapse to `learnings.md` (everything discovered) + `decisions.md` (architectural WHY records — worth keeping separate).

**Files:**
- Delete: `.claude/learnings/gotchas.md`
- Rename/merge: `.claude/learnings/insights.md` → `.claude/learnings/learnings.md` (merge gotchas content in)
- Keep: `.claude/learnings/decisions.md` (unchanged)
- Delete: `templates/claude-project-setup/learnings/gotchas.md`
- Rename: `templates/claude-project-setup/learnings/insights.md` → `templates/claude-project-setup/learnings/learnings.md`
- Modify: `templates/claude-project-setup/CLAUDE.md` (update `@` references)
- Modify: `templates/claude-project-setup/README.md` (update file inventory and table)
- Modify: `guides/session-learning-system.md` (update any 3-file references)

**Step 1: Create the merged learnings.md for the repo**

Content (merge insights + gotchas, which is empty):

```markdown
# Project Learnings

What we've discovered while working on this project — patterns, gotchas, and notable observations.

---

## 2025-01-05: Session Learning System Created
- Created a self-improving learning system for Claude Code
- Global learnings at `~/.claude/learnings/` apply across all repos
- Project learnings at `.claude/learnings/` are repo-specific
- `/reflect` command triggers comprehensive session review

---

<!-- New learnings will be appended below -->
```

**Step 2: Delete the old files**

```bash
rm /Users/malcolm/Projects/ai-dev-orchestrator/.claude/learnings/insights.md
rm /Users/malcolm/Projects/ai-dev-orchestrator/.claude/learnings/gotchas.md
```

**Step 3: Verify `.claude/learnings/` now has exactly 2 files**

```bash
ls .claude/learnings/
# Expected: decisions.md  learnings.md
```

**Step 4: Create merged learnings.md for the template**

```markdown
# Project Learnings

What we've discovered while working on this project — patterns, gotchas, and notable observations.

---

<!-- Learnings will be appended here by /reflect -->
```

**Step 5: Delete old template files**

```bash
rm templates/claude-project-setup/learnings/insights.md
rm templates/claude-project-setup/learnings/gotchas.md
```

**Step 6: Update `templates/claude-project-setup/CLAUDE.md`**

Replace the three `@` references:
```markdown
@.claude/learnings/insights.md
@.claude/learnings/decisions.md
@.claude/learnings/gotchas.md
```
With:
```markdown
@.claude/learnings/learnings.md
@.claude/learnings/decisions.md
```

**Step 7: Update `templates/claude-project-setup/README.md`**

- Update the "What's Included" file tree (remove gotchas.md, rename insights.md → learnings.md)
- Update the table that describes the three files (now two)
- Update the diagram showing the 3-file structure
- Update the example session output that mentions gotchas.md

**Step 8: Check guides/session-learning-system.md for 3-file references and update**

```bash
grep -n "insights\|gotchas" guides/session-learning-system.md
```
Update any references found.

**Step 9: Commit**

```bash
git add .claude/learnings/ templates/claude-project-setup/ guides/session-learning-system.md
git commit -m "refactor: collapse 3 learnings files to 2 (learnings.md + decisions.md)"
```

---

## Task 2: Update `.claude/CLAUDE.md`

**Why:** Current CLAUDE.md is minimal and doesn't tell Claude what tools exist in this repo, making it harder for Claude to orient a new user.

**Files:**
- Modify: `.claude/CLAUDE.md`

**Step 1: Replace the full content of `.claude/CLAUDE.md`**

New content:

```markdown
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
```

**Step 2: Verify the file reads correctly**

```bash
cat .claude/CLAUDE.md
```

**Step 3: Commit**

```bash
git add .claude/CLAUDE.md
git commit -m "docs: expand CLAUDE.md with agents, commands, and key file references"
```

---

## Task 3: Trim CONSTITUTION-TEMPLATE.md

**Why (Pete's feedback):** The template includes naming conventions, import order, file extensions, comment format specs, and full gitflow — things Claude already knows by language and ecosystem. The constitution should focus on what constrains AI behavior, not what AI already knows.

**Files:**
- Modify: `CONSTITUTION-TEMPLATE.md`

**Sections to REMOVE entirely:**

| Section | Lines | Why |
|---------|-------|-----|
| Naming Conventions (Variables/Functions/Classes/Constants/Files) | ~145–161 | Claude knows camelCase, PascalCase, snake_case by language |
| File naming conventions | ~158–161 | Convention by ecosystem, not project-specific |
| Import Order | ~180–184 | Handled by linters; Claude follows ecosystem norms |
| JSDoc/Google-style/GoDoc comment format requirements | ~186–201 | Keep "explain why not what" principle, remove format spec |
| Generic file structure template (src/components/services) | ~165–177 | Replace with a one-line placeholder — should be project-specific |
| Full conventional commits spec with examples | ~299–325 | Trim to: "Use conventional commits" + one example |
| Full gitflow (develop branch, feature/, hotfix/ format) | ~327–354 | Trim to 2 lines — most projects use simpler branching |
| PR review requirements (reviewer counts etc.) | ~345–354 | Remove — project-specific, not a template concern |

**Sections to KEEP as-is:**

- Section 1: Core Principles (soul of the constitution)
- Section 2: AI Model Assumptions
- Section 3: Technical Stack (mandated + prohibited — most important section)
- Section 4: Type Sharing (prevents real bugs)
- Error Handling patterns (AI genuinely gets this wrong)
- Testing thresholds table (concrete and useful)
- Security & Compliance (non-negotiable)
- Section 8: AI Coding Assistant Instructions (the enforcement section)
- Revision History

**Step 1: Edit CONSTITUTION-TEMPLATE.md — remove naming conventions**

Remove lines covering: Variables & Functions, Classes & Types, Constants, Files naming (the entire "Naming Conventions" subsection).

**Step 2: Edit CONSTITUTION-TEMPLATE.md — slim the Code Organization section**

Replace the generic `src/components/services` file structure block with:
```markdown
### Code Organization

**File Structure:**
```
[Define your project-specific directory structure here]
```
```

**Step 3: Edit CONSTITUTION-TEMPLATE.md — remove import order**

Remove the "Import Order" subsection entirely (4 lines).

**Step 4: Edit CONSTITUTION-TEMPLATE.md — trim comments section**

Replace the full JSDoc/docstring spec with:
```markdown
### Comments & Documentation

- Explain the **why** (intent), not the **what** (syntax)
- ❌ Bad: `// Loop through users`
- ✅ Good: `// Filter inactive users to reduce API payload size`
- Public functions need documentation headers; inline comments only for complex logic
```

**Step 5: Edit CONSTITUTION-TEMPLATE.md — trim Git section**

Replace the full commit format spec + gitflow with:
```markdown
## 5. Git & Version Control

**Commit Messages:** Use conventional commits format — `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`

**Branch Strategy:**
- `main`: production-ready code
- Feature branches: short-lived, branch from main, merged via PR

**PR Requirements:** All tests pass, linting clean, no merge conflicts
```

**Step 6: Verify the file still has all critical sections**

```bash
grep -n "^## " CONSTITUTION-TEMPLATE.md
```
Expected sections: Core Principles, AI Model Assumptions, Technical Stack, Type Sharing, Coding Standards, Security & Compliance, Performance Standards, Deployment & Operations, AI Coding Assistant Instructions, Revision History

**Step 7: Word count check**

```bash
wc -l CONSTITUTION-TEMPLATE.md
# Target: under 300 lines (was ~451)
```

**Step 8: Commit**

```bash
git add CONSTITUTION-TEMPLATE.md
git commit -m "refactor: trim constitution template — remove conventions Claude already knows"
```

---

## Task 4: Create `setup.sh`

**Why:** Closes the adoption gap. A new user can bootstrap the full framework into any existing project with a single command. Claude handles the smart configuration on first launch via instructions embedded in the generated CLAUDE.md.

**Files:**
- Create: `setup.sh` (executable)

**Step 1: Write setup.sh**

```bash
#!/usr/bin/env bash
# =============================================================================
# AI Dev Orchestrator — Project Setup Script
# =============================================================================
# Installs ai-dev-orchestrator into an existing or new project.
#
# Usage:
#   ./setup.sh                    # Install into current directory
#   ./setup.sh /path/to/project   # Install into specified directory
#
# What it installs:
#   CONSTITUTION.md               Project rules template (customize this)
#   .claude/agents/               6 AI development agents for Claude Code
#   .claude/commands/             /orchestrate and /reflect slash commands
#   .claude/learnings/            Session learning files
#   .claude/CLAUDE.md             Claude Code project config (with first-run setup)
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$(pwd)}"

# ── Validation ────────────────────────────────────────────────────────────────

if [ ! -d "$TARGET" ]; then
  echo "Error: Directory '$TARGET' does not exist."
  echo "Create it first, or pass a different path."
  exit 1
fi

if [ "$TARGET" = "$SCRIPT_DIR" ]; then
  echo "Error: Cannot install into the ai-dev-orchestrator repo itself."
  echo "Usage: ./setup.sh /path/to/your-project"
  exit 1
fi

echo ""
echo "Installing AI Dev Orchestrator into: $TARGET"
echo ""

# ── Constitution ──────────────────────────────────────────────────────────────

if [ -f "$TARGET/CONSTITUTION.md" ]; then
  echo "⚠  CONSTITUTION.md already exists — skipping (keeping yours)"
else
  cp "$SCRIPT_DIR/CONSTITUTION-TEMPLATE.md" "$TARGET/CONSTITUTION.md"
  echo "✓  CONSTITUTION.md created"
fi

# ── .claude directory structure ───────────────────────────────────────────────

mkdir -p "$TARGET/.claude/agents"
mkdir -p "$TARGET/.claude/commands"
mkdir -p "$TARGET/.claude/learnings"

# Agents
cp "$SCRIPT_DIR/.claude/agents/"*.md "$TARGET/.claude/agents/"
echo "✓  .claude/agents/ — 6 development agents installed"

# Commands
cp "$SCRIPT_DIR/.claude/commands/orchestrate.md" "$TARGET/.claude/commands/"
cp "$SCRIPT_DIR/.claude/commands/reflect.md" "$TARGET/.claude/commands/"
echo "✓  .claude/commands/ — /orchestrate and /reflect installed"

# Learnings (only create if they don't exist)
if [ ! -f "$TARGET/.claude/learnings/learnings.md" ]; then
  cat > "$TARGET/.claude/learnings/learnings.md" << 'EOF'
# Project Learnings

What we've discovered while working on this project — patterns, gotchas, and notable observations.

---

<!-- Learnings will be appended here by /reflect -->
EOF
fi

if [ ! -f "$TARGET/.claude/learnings/decisions.md" ]; then
  cat > "$TARGET/.claude/learnings/decisions.md" << 'EOF'
# Architecture Decisions

Significant technical decisions and their rationale. Format:

## YYYY-MM-DD: Decision Title
- **Decision:** What was chosen
- **Rationale:** Why this was chosen
- **Alternatives rejected:** What else was considered and why it lost

---

<!-- Decisions will be appended here by /reflect -->
EOF
fi
echo "✓  .claude/learnings/ — session learning files created"

# ── Generate CLAUDE.md ────────────────────────────────────────────────────────

if [ -f "$TARGET/.claude/CLAUDE.md" ]; then
  echo "⚠  .claude/CLAUDE.md already exists — skipping (keeping yours)"
  echo "   Add these lines manually to load learnings:"
  echo "   @.claude/learnings/learnings.md"
  echo "   @.claude/learnings/decisions.md"
else
  cat > "$TARGET/.claude/CLAUDE.md" << 'EOF'
# Project: [Project Name]

## Constitution
@CONSTITUTION.md

## Development Workflow

This project uses ai-dev-orchestrator for structured AI-assisted development.

### Available Agents (Claude Code)
6 specialized agents in `.claude/agents/` — auto-discovered by Claude Code:
- **Product Owner** — Creates PRDs and defines requirements
- **Solutions Architect** — Designs technical specs, schemas, APIs
- **Specialist Developer** — Implements code task-by-task
- **QA Engineer** — Reviews for quality, bugs, and security
- **Technical Writer** — Creates documentation
- **Frontend Design Orchestrator** — UI components and design systems

### Slash Commands
- `/orchestrate` — Full 4-phase development workflow (plan → build → review → document)
- `/reflect` — Capture session learnings

## Project Learnings

@.claude/learnings/learnings.md
@.claude/learnings/decisions.md

---

## 🚀 First Run Setup

**Claude: This project was just bootstrapped with ai-dev-orchestrator.
Before doing anything else, complete this setup:**

1. **Scan the codebase** — identify languages, frameworks, folder structure, and existing conventions
2. **Update CONSTITUTION.md** — fill in Section 3 (Technical Stack) with the actual technologies found; update Section 6 (Performance) and Section 7 (Deployment) if you have evidence for them; leave unknowns as placeholders
3. **Update this file** — replace `[Project Name]` with the actual project name; add any project-specific context or working agreements that would help future sessions
4. **Record initial observations** — add a dated entry to `.claude/learnings/learnings.md` with your key findings about the codebase
5. **Tell the user** what you found, what you configured, and what still needs their input (especially any CONSTITUTION.md placeholders you couldn't fill)

**After completing first-run setup, delete this "First Run Setup" section.**
EOF
  echo "✓  .claude/CLAUDE.md created (with first-run instructions for Claude)"
fi

# ── Done ──────────────────────────────────────────────────────────────────────

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  AI Dev Orchestrator installed successfully"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Next steps:"
echo "  1. Open '$TARGET' in Claude Code"
echo "  2. Claude will scan your codebase and configure CONSTITUTION.md"
echo "  3. Start building — describe a feature or run /orchestrate"
echo ""
echo "  Want to use the full automated workflow?"
echo "  Install the Superpowers plugin for Claude Code:"
echo "  https://claudeplugins.com (search: superpowers)"
echo ""
```

**Step 2: Make it executable**

```bash
chmod +x setup.sh
```

**Step 3: Test against a temp directory**

```bash
mkdir /tmp/test-project
./setup.sh /tmp/test-project
ls /tmp/test-project
ls /tmp/test-project/.claude
ls /tmp/test-project/.claude/agents
cat /tmp/test-project/.claude/CLAUDE.md
rm -rf /tmp/test-project
```

Expected output: All 5 "✓" lines, no errors. CLAUDE.md contains the First Run Setup section.

**Step 4: Test with no argument (installs to current dir)**

```bash
mkdir /tmp/test-project2 && cd /tmp/test-project2
/Users/malcolm/Projects/ai-dev-orchestrator/setup.sh
ls .claude/
cd - && rm -rf /tmp/test-project2
```

**Step 5: Test self-install guard**

```bash
cd /Users/malcolm/Projects/ai-dev-orchestrator
./setup.sh .
# Expected: Error message, exit 1
```

**Step 6: Commit**

```bash
git add setup.sh
git commit -m "feat: add setup.sh to bootstrap framework into any project"
```

---

## Task 5: Rewrite README.md

**Why:** Current README presents content in the wrong order for a new user (philosophy before quickstart, no mention of /orchestrate, outdated project structure). Bryan's feedback: one-liner → quickstart → example → only then explain philosophy.

**Files:**
- Modify: `README.md`

**New README structure:**

```
1. One-sentence description + personal note (2 lines)
2. Two-minute quickstart
   - Option A: Claude Code (automated) — clone → setup.sh → open Claude Code
   - Option B: Any AI tool (manual) — copy CONSTITUTION.md + use prompts
3. What a finished run looks like (condensed /orchestrate example)
4. Two ways to use this (clear paths, no time estimates)
   - Path A: Claude Code (automated) — agents + /orchestrate
   - Path B: Any AI tool (manual) — prompts + constitution
5. What's in this repo (updated inventory)
6. Works Better With Superpowers (new section)
7. The 4-phase workflow (kept as reference, condensed)
8. Core Principles (kept)
9. Updated project structure tree
10. FAQ (condensed — remove time estimates)
11. Contributing, Credits
```

**Step 1: Write the new README.md**

Key content for new sections:

**One-liner:**
```markdown
# AI-Dev-Orchestrator

A framework for building software with AI that actually works — structured personas,
copy-paste prompts, and (if you use Claude Code) a fully automated workflow.

> Built by a non-coder pushing the limits of what's possible with AI.
> Collaborate welcome. MCS
```

**Two-minute quickstart:**
```markdown
## Get Started in 2 Minutes

### Using Claude Code? (Recommended)
```bash
# 1. Clone this repo somewhere on your machine
git clone https://github.com/Optiminz/ai-dev-orchestrator.git ~/ai-dev-orchestrator

# 2. Run the setup script in your project
~/ai-dev-orchestrator/setup.sh /path/to/your-project

# 3. Open your project in Claude Code
# Claude will auto-detect the setup and configure itself
```

That's it. Claude configures CONSTITUTION.md, loads your agents, and you can start
building immediately with `/orchestrate`.

### Using Cursor, ChatGPT, Replit, or another AI?
1. Copy `CONSTITUTION-TEMPLATE.md` to your project as `CONSTITUTION.md`
2. Customize the tech stack section
3. Use prompts from `prompts/` — start with `prompts/phase-1-planning/1.1-product-owner-prd.md`
```

**What a finished run looks like:**
Use the condensed `/orchestrate` example output from `.claude/commands/orchestrate.md` — the block showing Phase 1 → Phase 4 with approval checkpoints.

**Works Better With Superpowers section:**
```markdown
## Works Better With Superpowers

The `/orchestrate` command integrates with the **Superpowers plugin** for Claude Code,
which adds structured brainstorming, test-driven development, parallel subagents,
and verification guardrails at each phase.

Without it: everything works, orchestrate skips those enhanced steps gracefully.
With it: fully automated quality gates, parallel task execution, and structured reviews.

**Install:** Search "superpowers" in Claude Code's plugin marketplace.

The relationship:
| Layer | Provides |
|-------|----------|
| ai-dev-orchestrator | WHAT — 4 phases, personas, constitution, artifacts |
| Superpowers | HOW — discipline at brainstorm, TDD, debug, verify moments |
| /orchestrate | Integration — calls superpowers skills at the right phase |
```

**Updated project structure:**
```
ai-dev-orchestrator/
├── setup.sh                           ← Start here (bootstraps into your project)
├── CONSTITUTION-TEMPLATE.md           ← Copy to your project as CONSTITUTION.md
├── README.md
│
├── .claude/                           ← Claude Code integration (copied by setup.sh)
│   ├── agents/                        ← 6 auto-discovered agents
│   ├── commands/                      ← /orchestrate and /reflect
│   └── learnings/                     ← Session learning system
│
├── personas/                          ← 5 AI persona definitions (source of agents)
├── prompts/                           ← 15 copy-paste prompts (manual workflow)
├── templates/                         ← Constitution templates by project type
├── examples/                          ← Example constitutions + sample outputs
├── guides/                            ← Tool-specific setup (Claude Code, Cursor, Replit)
├── quick-start/                       ← Minimal manual workflow
└── workflow/                          ← Phase checklists and prompt selection guide
```

**Step 2: Verify all internal links still work after rewrite**

```bash
grep -o '\[.*\](\./[^)]*\)' README.md | grep -v "http"
# Check each linked file actually exists
```

**Step 3: Commit**

```bash
git add README.md
git commit -m "docs: restructure README for new user onboarding (quickstart first)"
```

---

## Task 6: Final Verification

**Step 1: Run full setup script test**

```bash
mkdir /tmp/final-test
./setup.sh /tmp/final-test

# Verify all expected files exist
test -f /tmp/final-test/CONSTITUTION.md && echo "✓ CONSTITUTION.md"
test -d /tmp/final-test/.claude/agents && echo "✓ agents dir"
test -f /tmp/final-test/.claude/commands/orchestrate.md && echo "✓ orchestrate"
test -f /tmp/final-test/.claude/commands/reflect.md && echo "✓ reflect"
test -f /tmp/final-test/.claude/learnings/learnings.md && echo "✓ learnings"
test -f /tmp/final-test/.claude/learnings/decisions.md && echo "✓ decisions"
test -f /tmp/final-test/.claude/CLAUDE.md && echo "✓ CLAUDE.md"

# Verify CLAUDE.md has the First Run Setup section
grep "First Run Setup" /tmp/final-test/.claude/CLAUDE.md && echo "✓ first-run instructions present"

rm -rf /tmp/final-test
```

**Step 2: Verify constitution is under 300 lines**

```bash
wc -l CONSTITUTION-TEMPLATE.md
```

**Step 3: Verify README links**

```bash
grep -oP '\(\.\/[^)]+\)' README.md | tr -d '()' | while read f; do
  test -e "$f" && echo "✓ $f" || echo "✗ MISSING: $f"
done
```

**Step 4: Final commit and push**

```bash
git add -A
git status  # Review what's changed
git commit -m "chore: final verification — all changes complete"
git push
```

---

## Files Changed Summary

| File | Change |
|------|--------|
| `.claude/learnings/insights.md` | Renamed → `learnings.md`, gotchas merged in |
| `.claude/learnings/gotchas.md` | Deleted |
| `.claude/learnings/decisions.md` | Unchanged |
| `.claude/CLAUDE.md` | Expanded (agents, commands, key files) |
| `templates/claude-project-setup/learnings/insights.md` | Renamed → `learnings.md` |
| `templates/claude-project-setup/learnings/gotchas.md` | Deleted |
| `templates/claude-project-setup/CLAUDE.md` | Updated `@` references |
| `templates/claude-project-setup/README.md` | Updated file inventory and table |
| `guides/session-learning-system.md` | Updated 3-file references |
| `CONSTITUTION-TEMPLATE.md` | Trimmed ~38% (naming conventions, import order, gitflow) |
| `setup.sh` | New file — project bootstrapper |
| `README.md` | Restructured — quickstart first, updated inventory, superpowers section |
| `docs/plans/2026-02-27-repo-improvements.md` | This file |
