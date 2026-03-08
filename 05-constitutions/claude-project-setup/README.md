# Claude Code Project Setup Template

Quick setup template for Claude Code session learning system in new projects.

## What's Included

```
claude-project-setup/
├── README.md                    # This file
├── setup-learnings.sh           # Quick setup script
├── CLAUDE.md                    # Project CLAUDE.md template
└── learnings/
    ├── learnings.md             # Project learnings template
    └── decisions.md             # Architecture decisions template
```

## Quick Start

### For a New Project

```bash
cd ~/my-new-project

# Run the setup script
~/ai-dev-orchestrator/templates/claude-project-setup/setup-learnings.sh

# This creates:
# .claude/CLAUDE.md
# .claude/learnings/learnings.md
# .claude/learnings/decisions.md
```

### Customize After Setup

1. **Edit `.claude/CLAUDE.md`:**
   - Replace `{{PROJECT_NAME}}` with your project name
   - Replace `{{PROJECT_TYPE}}` (e.g., "Web App", "API Service")
   - Replace `{{TECH_STACK}}` (e.g., "React, Node.js, PostgreSQL")
   - Replace `{{PURPOSE}}` with project description
   - Update the constitution reference if needed

2. **Start using:**
   ```bash
   claude chat
   ```

## What Gets Created

### `.claude/CLAUDE.md`

Project-level Claude Code instructions that:
- Reference your CONSTITUTION.md
- Load project learnings
- Define working agreements
- Provide project context

### `.claude/learnings/`

Two learning files:

| File | Purpose | Example Entry |
|------|---------|---------------|
| `learnings.md` | Project discoveries — patterns, gotchas, and observations | "Auth system uses OAuth 2.0 with PKCE" |
| `decisions.md` | Architecture decisions and rationale | "Chose GraphQL over REST for flexible queries" |

## How It Works with Global Learnings

```
Session Start
    ↓
Load Global (~/.claude/)
├── CLAUDE.md (principles)
├── learnings/patterns.md
├── learnings/mistakes.md
└── learnings/preferences.md
    ↓
Load Project (.claude/)
├── CLAUDE.md (context)
└── learnings/
    ├── learnings.md
    └── decisions.md
    ↓
Claude has full context
```

**Global learnings** apply everywhere (TypeScript patterns, React best practices, etc.)

**Project learnings** apply to this repo only (this API's auth flow, this project's database schema, etc.)

## Using /reflect

At the end of sessions, run `/reflect` to capture learnings:

```bash
/reflect
```

Claude will:
1. Review what was accomplished
2. Ask which learnings are global vs project-specific
3. Write to appropriate files
4. Summarize what was captured

## Example: After Setup

**Your project structure:**
```
my-project/
├── .claude/
│   ├── CLAUDE.md              # ← Created by setup
│   └── learnings/             # ← Created by setup
│       ├── learnings.md
│       └── decisions.md
├── CONSTITUTION.md            # Your project constitution
├── src/
└── README.md
```

**First session:**
```bash
cd ~/my-project
claude chat

You: What do you know about this project?

Claude: I see this is "My Project" (from .claude/CLAUDE.md).

        I'm aware of:
        - Your CONSTITUTION.md rules
        - Global patterns from ~/.claude/learnings/
        - Project learnings (currently empty, but will accumulate)

You: Great! Let's implement the auth system

Claude: *works on auth*

# ... end of session ...

You: /reflect

Claude: *reviews session*

        Captured learnings:
        - Decision: Chose JWT with httpOnly cookies
        - Learning: Token expiry must be validated server-side

        Files updated:
        - .claude/learnings/decisions.md
        - .claude/learnings/learnings.md
```

**Next session:**
```bash
claude chat

Claude: *loads learnings automatically*

        I'm aware that this project uses JWT with httpOnly cookies
        and that we need to validate expiry server-side.

You: Perfect! Let's add the logout endpoint

Claude: *implements with proper JWT handling from the start*
```

## Comparison with Global Setup

**Global setup** (`~/.claude/`):
- Done ONCE for all projects
- Contains cross-project learnings
- Personal preferences and style

**Project setup** (`.claude/`):
- Done PER PROJECT
- Contains project-specific learnings
- Shared with team via git

## Team Usage

**Committing learnings:**

```bash
# Add learnings to git
git add .claude/

# Commit
git commit -m "docs: add learnings from auth implementation"

# Push
git push
```

**When teammates pull:**

```bash
git pull

# They now have your learnings
cat .claude/learnings/decisions.md
# Shows: "Chose JWT with httpOnly cookies"

# Claude Code will load these automatically
claude chat
```

## Files Reference

### setup-learnings.sh

Automated setup script that:
- Creates `.claude/learnings/` directory
- Creates learning template files
- Creates project CLAUDE.md
- Adds `.claude/CLAUDE.local.md` to .gitignore

**Usage:**
```bash
./setup-learnings.sh [project-name]
```

### CLAUDE.md Template

Template with placeholders:
- `{{PROJECT_NAME}}` - Your project name
- `{{PROJECT_TYPE}}` - Type of project
- `{{TECH_STACK}}` - Technologies used
- `{{PURPOSE}}` - Project description

**Replace these after setup!**

### Learning File Templates

Pre-structured markdown files with:
- Headers
- Format guidance
- Append markers

---

## Next Steps

After setup:

1. ✅ **Customize `.claude/CLAUDE.md`** with project details
2. ✅ **Ensure `CONSTITUTION.md` exists** in project root
3. ✅ **Start a session** with `claude chat`
4. ✅ **Use `/reflect`** at end of sessions
5. ✅ **Commit learnings** to share with team

---

## Related Documentation

- [Session Learning System Guide](../../guides/session-learning-system.md) - Comprehensive learning system docs
- [Claude Code Setup Guide](../../guides/claude-code-setup.md) - Full Claude Code setup
- [Main README](../../README.md) - AI-Dev-Orchestrator overview

---

**Questions?** See the [Session Learning System Guide](../../guides/session-learning-system.md) for detailed usage and troubleshooting.
