#!/bin/bash
# Setup Claude Code learnings structure for a new project
# Usage: ./setup-learnings.sh [project-name]

PROJECT_NAME="${1:-$(basename $(pwd))}"

echo "Setting up Claude Code learnings for: $PROJECT_NAME"

# Create .claude directory structure
mkdir -p .claude/learnings

# Create learnings files if they don't exist
if [ ! -f .claude/learnings/insights.md ]; then
  cat > .claude/learnings/insights.md << 'EOF'
# Project Insights

Key insights discovered while working on this project.

---

<!-- New insights will be appended below -->
EOF
  echo "Created .claude/learnings/insights.md"
fi

if [ ! -f .claude/learnings/decisions.md ]; then
  cat > .claude/learnings/decisions.md << 'EOF'
# Architecture Decisions

Significant technical decisions and their rationale.

---

<!-- New decisions will be appended below -->
EOF
  echo "Created .claude/learnings/decisions.md"
fi

if [ ! -f .claude/learnings/gotchas.md ]; then
  cat > .claude/learnings/gotchas.md << 'EOF'
# Project Gotchas

Things that can trip you up in this project.

---

<!-- New gotchas will be appended below -->
EOF
  echo "Created .claude/learnings/gotchas.md"
fi

# Create CLAUDE.md if it doesn't exist
if [ ! -f .claude/CLAUDE.md ]; then
  cat > .claude/CLAUDE.md << EOF
# Project: $PROJECT_NAME

## Constitution

This project follows the rules defined in:
@./CONSTITUTION.md

## Project Learnings

@.claude/learnings/insights.md
@.claude/learnings/decisions.md
@.claude/learnings/gotchas.md

## Working Agreements

1. Always check CONSTITUTION.md before implementing
2. Reference learnings before starting new work
3. Update learnings when discovering something notable
4. Use \`/reflect\` at end of significant sessions
EOF
  echo "Created .claude/CLAUDE.md"
fi

# Add local files to gitignore if not already there
if [ -f .gitignore ]; then
  if ! grep -q "\.claude/CLAUDE\.local\.md" .gitignore; then
    echo -e "\n# Claude Code local files\n.claude/CLAUDE.local.md" >> .gitignore
    echo "Added .claude/CLAUDE.local.md to .gitignore"
  fi
fi

echo ""
echo "Done! Structure created:"
echo "  .claude/"
echo "  ├── CLAUDE.md"
echo "  └── learnings/"
echo "      ├── insights.md"
echo "      ├── decisions.md"
echo "      └── gotchas.md"
echo ""
echo "Next steps:"
echo "  1. Customize .claude/CLAUDE.md with project details"
echo "  2. Ensure CONSTITUTION.md exists in project root"
echo "  3. Use /reflect at end of sessions to capture learnings"
