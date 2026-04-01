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
#   .claude/commands/             /orchestrate, /reflect, and /wrap slash commands
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

if [ "$(cd "$TARGET" && pwd)" = "$SCRIPT_DIR" ]; then
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
  cp "$SCRIPT_DIR/05-constitutions/CONSTITUTION-TEMPLATE.md" "$TARGET/CONSTITUTION.md"
  echo "✓  CONSTITUTION.md created"
fi

# ── .claude directory structure ───────────────────────────────────────────────

mkdir -p "$TARGET/.claude/commands"
mkdir -p "$TARGET/.claude/learnings"

# Commands
cp "$SCRIPT_DIR/.claude/commands/orchestrate.md" "$TARGET/.claude/commands/"
cp "$SCRIPT_DIR/.claude/commands/reflect.md" "$TARGET/.claude/commands/"
cp "$SCRIPT_DIR/.claude/commands/wrap.md" "$TARGET/.claude/commands/"
echo "✓  .claude/commands/ — /orchestrate, /reflect, and /wrap installed"

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
  echo "   Tip: Add these lines to load learnings:"
  echo "   @.claude/learnings/learnings.md"
  echo "   @.claude/learnings/decisions.md"
else
  cat > "$TARGET/.claude/CLAUDE.md" << 'EOF'
# Project: [Project Name]

## Constitution
@CONSTITUTION.md

## Development Workflow

This project uses ai-dev-orchestrator for structured AI-assisted development.

### Slash Commands
- `/orchestrate` — Full 4-phase development workflow (plan → build → review → document)
- `/reflect` — Capture session learnings
- `/wrap` — End-of-session cleanup and handoff

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
echo "  Want the full automated workflow?"
echo "  Install the Superpowers plugin: search 'superpowers' in Claude Code plugins"
echo ""
