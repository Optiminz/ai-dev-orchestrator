# Post-Compaction Context Preservation

**Stop Claude from forgetting what you're doing in long sessions.**

---

## The Problem

During long sessions, Claude Code automatically compacts its context window — summarising earlier messages and dropping the originals. This is necessary (context windows are finite), but it has a side effect: Claude can lose track of important context that was established early in the session.

What gets lost:
- Project rules and conventions from CLAUDE.md
- Which task you're working on and where you are in a plan
- Behavioral guidelines (plugins, skills, personas)
- Your preferences and working style

The result: Claude starts behaving like a fresh session mid-conversation. You repeat yourself. It makes mistakes you already corrected. It forgets the architecture decisions you agreed on 20 minutes ago.

---

## The Solution: PostCompact Hook

The `PostCompact` hook fires immediately after compaction completes, before Claude responds. It re-injects critical context so Claude maintains coherence across compaction boundaries.

### How It Works

```
Long session in progress...
         ↓
Context window fills up
         ↓
Claude compacts (summarises + drops old messages)
         ↓
PostCompact hook fires ← your context file is injected here
         ↓
Claude responds with full awareness of project context
```

---

## Setup

### Step 1: Create the Context File

Create `~/.claude/compaction-context.md` (global) or `.claude/compaction-context.md` (project-specific):

```markdown
# Post-Compaction Context

Re-read these after compaction to maintain coherence.

## Critical Files
- Project instructions: CLAUDE.md (re-read if context feels stale)
- [Add your key files here]

## Key Behaviors
- [Your most important rules — the ones Claude forgets]
- [Preferences that aren't obvious from the code]

## Active Systems
- [Plugins, tools, integrations Claude should remember]
```

Keep this file **short** — it gets injected into every post-compaction context. Aim for the minimum needed to re-orient Claude, not a full briefing. If Claude needs details, point it to files it can re-read.

### Step 2: Add the Hook

Add the PostCompact hook to your `settings.json` (global `~/.claude/settings.json` or project `.claude/settings.json`):

```json
{
  "hooks": {
    "PostCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat ~/.claude/compaction-context.md",
            "statusMessage": "Re-injecting context after compaction..."
          }
        ]
      }
    ]
  }
}
```

For project-specific context, use a relative path:

```json
{
  "hooks": {
    "PostCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat ${CLAUDE_PROJECT_DIR}/.claude/compaction-context.md",
            "statusMessage": "Re-injecting project context..."
          }
        ]
      }
    ]
  }
}
```

You can combine both — global context plus project-specific context:

```json
{
  "hooks": {
    "PostCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat ~/.claude/compaction-context.md && echo '---' && cat ${CLAUDE_PROJECT_DIR}/.claude/compaction-context.md 2>/dev/null || true",
            "statusMessage": "Re-injecting context after compaction..."
          }
        ]
      }
    ]
  }
}
```

### Step 3: Verify

Start a Claude Code session and confirm the hook is registered:

```bash
# Check your settings are valid JSON
cat ~/.claude/settings.json | python3 -m json.tool

# Start Claude Code — the hook is active immediately
claude
```

You won't see the hook fire until a compaction actually occurs (typically after extended sessions with heavy tool use).

---

## What to Include

**Good candidates for the context file:**

| Include | Why |
|---------|-----|
| Pointers to key files (CLAUDE.md, memory index) | Claude can re-read them if needed |
| Your top 3-5 behavioral rules | The ones that drift most after compaction |
| Active integrations/tools | So Claude remembers what's available |
| Task routing rules | Where to create tasks, how to handle different work types |

**What NOT to include:**

| Skip | Why |
|------|-----|
| Full project documentation | Too large — point to files instead |
| Code snippets or examples | These belong in CLAUDE.md or the codebase |
| Session-specific state | Compaction summaries already capture this |
| Anything in CLAUDE.md | Claude re-reads CLAUDE.md anyway — don't duplicate |

---

## Example: Minimal Context File

```markdown
# Post-Compaction Context

## Key Behaviors
- Concise responses, no trailing summaries
- Check for applicable skills before any action
- Use verbose naming in code

## Active Systems
- Superpowers plugin (brainstorming, TDD, debugging, plans)
- Memory system at ~/.claude/projects/*/memory/
- MCP via mcpl for GitHub and Google Workspace

## Task Routing
- Human tasks -> Notion Tasks DB
- Dev tasks -> GitHub Issues
```

## Example: Project-Specific Context File

```markdown
# Post-Compaction Context — [Project Name]

## Architecture
- Next.js 14 with App Router
- Supabase for auth and database
- Zustand for client state

## Current Sprint
- Implementing user dashboard (see docs/plans/dashboard-plan.md)
- Do NOT modify auth flow — it's frozen for compliance review

## Critical Rules
- All API routes require auth middleware
- Database migrations go through Supabase CLI, never raw SQL
- Tests must pass before any commit
```

---

## Combining with Session Learnings

PostCompact and the [session learning system](./session-learning-system.md) work together:

- **Session learnings** capture knowledge across sessions (persistent)
- **PostCompact** preserves context within a session (transient)

If you use both, your PostCompact context file can include a pointer to learnings:

```markdown
## Context Recovery
- Re-read learnings if needed: ~/.claude/learnings/ and .claude/learnings/
```

This way Claude knows where to look without the learnings being duplicated in the compaction context.

---

## Troubleshooting

### Hook not firing

PostCompact only fires when compaction actually occurs. This happens automatically during long sessions — you cannot trigger it manually. If you want to test your context file, just `cat` it yourself to verify the content looks right.

### Context file too large

If your context file is more than ~50 lines, it's too large. The goal is re-orientation, not re-briefing. Cut it down to pointers and rules. Claude can re-read full files on its own.

### Conflict with project settings

If both global and project settings define PostCompact hooks, both run. Use the combined command approach (Step 2) to handle missing project files gracefully with `2>/dev/null || true`.
