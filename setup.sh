#!/usr/bin/env bash
# =============================================================================
# AI Dev Orchestrator — Project Setup Script
# =============================================================================
# Installs ai-dev-orchestrator into a project, in one of two modes:
#
#   advanced (default for existing projects):
#     CONSTITUTION.md               Project rules template (customize this)
#     .claude/commands/             /orchestrate, /reflect, and /wrap commands
#     .claude/learnings/            Session learning files
#     .claude/CLAUDE.md             Claude Code project config
#
#   beginner:
#     A new project directory seeded with conversation-first templates:
#     START-HERE.md, README.md, CONSTITUTION.md, CLAUDE.md,
#     chat-assistant-project-instructions.md, notes/.
#     For non-developers scoping a small project. Initialises a git repo.
#
# Usage:
#   ./setup.sh                          # Interactive: asks which mode
#   ./setup.sh --advanced [dir]         # Install advanced framework into dir
#   ./setup.sh --beginner               # Create a beginner project (prompts for path/name)
#   ./setup.sh --beginner /path/to/dir  # Create a beginner project at a specific path
#   ./setup.sh /path/to/dir             # Same as --advanced /path/to/dir
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Argument parsing ──────────────────────────────────────────────────────────

MODE=""
TARGET=""

while [ $# -gt 0 ]; do
  case "$1" in
    --beginner)
      MODE="beginner"
      shift
      ;;
    --advanced)
      MODE="advanced"
      shift
      ;;
    -h|--help)
      sed -n '2,25p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      if [ -z "$TARGET" ]; then
        TARGET="$1"
      else
        echo "Error: unexpected argument '$1'"
        exit 1
      fi
      shift
      ;;
  esac
done

# ── Mode selection ────────────────────────────────────────────────────────────

if [ -z "$MODE" ]; then
  echo ""
  echo "AI Dev Orchestrator setup"
  echo ""
  echo "  1) Beginner   — new project, conversation-first, for non-developers"
  echo "  2) Advanced   — install framework into an existing project"
  echo ""
  printf "Choose [1/2]: "
  read -r choice
  case "$choice" in
    1) MODE="beginner" ;;
    2) MODE="advanced" ;;
    *) echo "Invalid choice."; exit 1 ;;
  esac
  echo ""
fi

# ── Beginner mode ─────────────────────────────────────────────────────────────

if [ "$MODE" = "beginner" ]; then
  TEMPLATE_DIR="$SCRIPT_DIR/02-starter-kit/beginner"
  if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: beginner templates not found at $TEMPLATE_DIR"
    exit 1
  fi

  if [ -z "$TARGET" ]; then
    printf "Project name (short, lowercase, hyphens — e.g. photo-tagger): "
    read -r project_name
    if [ -z "$project_name" ]; then
      echo "Error: project name is required."
      exit 1
    fi
    DEFAULT_PARENT="$HOME/Projects"
    printf "Where to create it? [%s/%s]: " "$DEFAULT_PARENT" "$project_name"
    read -r project_path
    if [ -z "$project_path" ]; then
      project_path="$DEFAULT_PARENT/$project_name"
    fi
    TARGET="$project_path"
  fi

  PROJECT_NAME="$(basename "$TARGET")"

  if [ -d "$TARGET" ] && [ -n "$(ls -A "$TARGET" 2>/dev/null)" ]; then
    echo "Error: '$TARGET' already exists and is not empty."
    echo "Pick a fresh path so we don't overwrite anything."
    exit 1
  fi

  mkdir -p "$TARGET"
  mkdir -p "$TARGET/notes"

  for src in "$TEMPLATE_DIR"/*.template.md; do
    [ -e "$src" ] || continue
    fname="$(basename "$src" .template.md).md"
    # Substitute {{PROJECT_NAME}} placeholder
    sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$src" > "$TARGET/$fname"
  done

  # Empty .keep so notes/ is committed
  touch "$TARGET/notes/.keep"

  # Initialise git, no commit (let the user own it)
  if command -v git >/dev/null 2>&1; then
    (cd "$TARGET" && git init -q)
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Beginner project created at: $TARGET"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "  Next: open $TARGET/START-HERE.md"
  echo ""
  exit 0
fi

# ── Advanced mode (existing behaviour) ────────────────────────────────────────

TARGET="${TARGET:-$(pwd)}"

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
echo "Installing AI Dev Orchestrator (advanced) into: $TARGET"
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
