# Session Learning System Guide

**Stop repeating yourself. Let Claude Code learn from every session.**

> **Credit:** This system was inspired by the [Developers Digest YouTube channel](https://www.youtube.com/watch?v=-4nUCaMNBR8), which demonstrated using Claude Code skills for reflection workflows. The implementation here has been adapted and extended for the ai-dev-orchestrator framework.

---

## The Problem

Without a learning system:
- ❌ You give the same instructions every session
- ❌ Claude makes the same mistakes repeatedly
- ❌ Project-specific knowledge lives only in your head
- ❌ New sessions start from zero context

With the session learning system:
- ✅ Learnings accumulate across sessions
- ✅ Mistakes are documented and prevented
- ✅ Patterns are captured and reused
- ✅ Projects build institutional memory

---

## How It Works

```
┌─────────────────────────────────────────────────────────┐
│               Session 1: Discovery                       │
│  You discover a pattern that works well                  │
│  → Run /reflect                                          │
│  → Pattern captured to learnings                         │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│              Session 2: Application                      │
│  Claude loads learnings at session start                 │
│  → Automatically applies the pattern                     │
│  → No need to re-explain                                 │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│              Session 3: Refinement                       │
│  Pattern is refined based on new experience              │
│  → /reflect updates the learning                         │
│  → Knowledge improves over time                          │
└─────────────────────────────────────────────────────────┘
```

---

## Architecture

### Two-Level System

**Global Learnings** (`~/.claude/learnings/`)
- Apply to ALL projects
- Shared across repos
- Language/framework patterns
- General coding principles

**Project Learnings** (`.claude/learnings/`)
- Apply to ONE project
- Repo-specific
- Architecture decisions
- Project gotchas

### File Structure

```
~/.claude/                              # Global (all projects)
├── CLAUDE.md                           # Core principles
├── commands/
│   └── reflect.md                      # /reflect command
├── skills/
│   └── session-learnings/
│       └── SKILL.md                    # Auto-capture skill
├── learnings/
│   ├── patterns.md                     # What works well
│   ├── mistakes.md                     # What to avoid
│   └── preferences.md                  # Your style
└── settings.json                       # Hooks config

YOUR-PROJECT/.claude/                   # Project-specific
├── CLAUDE.md                           # Project context
└── learnings/
    ├── learnings.md                    # Project discoveries, patterns, gotchas
    └── decisions.md                    # Why we chose X
```

---

## Setup

### Prerequisites

- Claude Code installed
- Git repository (optional but recommended)

### Installation (5 minutes)

#### Step 1: Clone ai-dev-orchestrator

```bash
cd ~
git clone https://github.com/yourusername/ai-dev-orchestrator.git
```

#### Step 2: Copy Global Files

```bash
# Create global directories
mkdir -p ~/.claude/learnings
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/skills/session-learnings

# Copy global CLAUDE.md
cp ~/ai-dev-orchestrator/05-constitutions/claude-project-setup/CLAUDE.md ~/.claude/CLAUDE.md
# Edit to remove project-specific placeholders

# Copy /reflect command
cp ~/ai-dev-orchestrator/.claude/commands/reflect.md ~/.claude/commands/

# Copy session-learnings skill (if it exists globally)
# This may already be in your ~/.claude/skills/ from the ai-dev-orchestrator setup

# Create learning files
touch ~/.claude/learnings/patterns.md
touch ~/.claude/learnings/mistakes.md
touch ~/.claude/learnings/preferences.md

# Add headers to learning files
echo "# Patterns\n\nRecurring patterns that work well.\n\n---\n" > ~/.claude/learnings/patterns.md
echo "# Mistakes to Avoid\n\nCommon mistakes and prevention.\n\n---\n" > ~/.claude/learnings/mistakes.md
echo "# User Preferences\n\nDiscovered preferences and style.\n\n---\n" > ~/.claude/learnings/preferences.md
```

#### Step 3: Enable Stop Hook

Edit `~/.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "github@claude-plugins-official": true
  },
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Before ending this session, take a moment to reflect:\n\n1. Were there any notable patterns, mistakes, or insights worth capturing?\n2. Should any learnings be documented for future sessions?\n\nIf yes, run `/reflect` to capture these learnings. If this was a routine session with nothing notable, you can skip reflection."
          }
        ]
      }
    ]
  }
}
```

#### Step 4: Set Up Your Project

```bash
cd ~/my-project

# Run setup script
~/ai-dev-orchestrator/05-constitutions/claude-project-setup/setup-learnings.sh

# This creates:
# .claude/CLAUDE.md
# .claude/learnings/learnings.md
# .claude/learnings/decisions.md
```

#### Step 5: Verify

```bash
# Check global structure
ls -la ~/.claude/learnings/
# Should show: patterns.md, mistakes.md, preferences.md

# Check project structure
ls -la .claude/learnings/
# Should show: learnings.md, decisions.md

# Check /reflect command exists
ls -la ~/.claude/commands/
# Should show: reflect.md
```

---

## Usage

### During a Session

Claude can **automatically capture learnings** using the session-learnings skill:

**Example:**

```
You: Implement the user authentication endpoint

Claude: *implements code*

Claude: I noticed we're using bcrypt for password hashing without
        specifying the salt rounds. This could be a performance issue.

        Capturing this as a pattern...

Captured pattern: "Always specify bcrypt salt rounds (10-12 for most apps)"
Location: ~/.claude/learnings/patterns.md
```

This happens **automatically** when Claude notices something worth remembering.

### At Session End

When you type `exit` or `Ctrl+D`, the **Stop hook triggers**:

```
Before ending this session, take a moment to reflect:

1. Were there any notable patterns, mistakes, or insights worth capturing?
2. Should any learnings be documented for future sessions?

If yes, run `/reflect` to capture these learnings.
```

If the session had notable learnings, run:

```bash
/reflect
```

### Reflection Process

The `/reflect` command guides you through:

1. **Session Summary** - What was accomplished
2. **Extract Learnings** - Patterns, mistakes, preferences, decisions
3. **Categorize** - Global vs project-specific
4. **Write to Files** - Update learning files
5. **Summary** - Show what was captured

**Example Reflection:**

```
/reflect

Claude: Let me review this session...

## Session Summary
- Implemented user authentication with JWT
- Fixed CORS issues with Next.js API routes
- Set up Prisma database schema

## Learnings Identified

**Patterns:**
1. Using httpOnly cookies for JWT storage (more secure than localStorage)
2. Prefixing API routes with /api/ for Next.js convention

**Mistakes:**
1. Forgot to handle refresh token rotation initially
2. Didn't validate JWT expiry time on server side

**Project-Specific:**
1. This project uses Prisma with PostgreSQL
2. Auth flow requires admin role for user management endpoints

Where should I save these?

You: Save patterns and mistakes globally, project details to this repo

Claude: *writes to files*

## Reflection Complete

**Global learnings:**
- Pattern: Use httpOnly cookies for JWT storage
- Pattern: Prefix API routes with /api/ in Next.js
- Mistake: Always validate JWT expiry server-side
- Mistake: Implement refresh token rotation from start

**Project learnings:**
- Learning: Uses Prisma + PostgreSQL
- Learning: Admin role required for user management

**Files Updated:**
- ~/.claude/learnings/patterns.md (2 new)
- ~/.claude/learnings/mistakes.md (2 new)
- .claude/learnings/learnings.md (2 new)

**Next session:** Continue with user profile page implementation
```

### Next Session

Start a new session:

```bash
cd ~/my-project
claude chat
```

Claude **automatically loads** all learnings:

```
Loading context:
✓ ~/.claude/CLAUDE.md
✓ ~/.claude/learnings/patterns.md (12 patterns)
✓ ~/.claude/learnings/mistakes.md (8 mistakes)
✓ ~/.claude/learnings/preferences.md (5 preferences)
✓ .claude/CLAUDE.md
✓ .claude/learnings/learnings.md (4 learnings)
✓ .claude/learnings/decisions.md (2 decisions)

Ready! I'm aware of your coding patterns and project context.
```

Now Claude:
- ✅ Knows to use httpOnly cookies for JWT
- ✅ Won't forget refresh token rotation
- ✅ Knows this project uses Prisma
- ✅ Knows admin endpoints require special role

---

## Learning Categories

### Global Categories

| Category | File | Purpose | Example |
|----------|------|---------|---------|
| **Patterns** | `patterns.md` | Solutions that work well | "Use Zod for API validation" |
| **Mistakes** | `mistakes.md` | Errors to prevent | "Always await database calls" |
| **Preferences** | `preferences.md` | Your coding style | "Prefer functional components" |

### Project Categories

| Category | File | Purpose | Example |
|----------|------|---------|---------|
| **Learnings** | `learnings.md` | Project knowledge, patterns, and pitfalls | "API uses OAuth 2.0 with PKCE" / "Rate limit: 100 req/min" |
| **Decisions** | `decisions.md` | Why we chose X | "Chose Zustand over Redux (simpler)" |

### When to Use Each

**Use Global** when the learning applies to ANY project:
- Language patterns (TypeScript, Python, etc.)
- Framework best practices (React, Next.js, etc.)
- Security principles (CORS, XSS, etc.)
- General coding style (naming, formatting, etc.)

**Use Project** when the learning is specific to THIS repo:
- Architecture choices for this app
- API endpoint details
- Database schema decisions
- Project-specific gotchas

**Still not sure?** Err on the side of Global. You can always move it later.

---

## Best Practices

### DO ✅

**Be Specific**
- ❌ Bad: "Use good error handling"
- ✅ Good: "Always wrap fetch calls in try-catch and check response.ok before parsing JSON"

**Include Context**
- ❌ Bad: "Use bcrypt"
- ✅ Good: "Use bcrypt with 10-12 salt rounds for password hashing (12 for sensitive apps, 10 for internal tools)"

**Capture Immediately**
- ✅ When a mistake costs >5 minutes, capture it right away
- ✅ When you discover an elegant pattern, capture it
- ✅ When user corrects you, capture the preference

**Update Existing Learnings**
- ✅ If a learning evolves, update it rather than creating duplicates
- ✅ Mark outdated learnings with ~~strikethrough~~ before replacing

**Use Examples**
```markdown
## 2025-01-05: Type Guards with Zod

- **Pattern:** Use Zod for runtime type validation instead of manual checks
- **When to use:** API boundaries, user input, external data
- **Example:**
  ```typescript
  import { z } from 'zod';

  const UserSchema = z.object({
    id: z.number(),
    email: z.string().email(),
  });

  // Instead of manual validation
  const user = UserSchema.parse(data); // throws if invalid
  ```
```

### DON'T ❌

**Don't Over-Capture**
- ❌ Every single thing is NOT a learning
- ❌ Only capture notable patterns or costly mistakes
- ❌ If it's obvious, skip it

**Don't Be Vague**
- ❌ "TypeScript is good"
- ❌ "Don't do bad things"
- ❌ "Remember to test"

**Don't Skip Categorization**
- ❌ Dumping everything into one file
- ❌ Mixing global and project learnings
- ❌ Not specifying when a learning applies

**Don't Force Reflection**
- ❌ If session was routine, skip `/reflect`
- ❌ Not every session needs documentation
- ❌ Only reflect when there's something notable

---

## Examples

### Example 1: Capturing a Mistake

**Session work:**
```
You: Implement the login endpoint

Claude: *writes code*

You: This crashes when I test it - "Cannot read property 'id' of undefined"

Claude: Let me fix that...

        I see the issue - I didn't check if user exists before accessing user.id.
        This is a common mistake I should capture.

Captured mistake: "Always check if database query returned a result before accessing properties"
Location: ~/.claude/learnings/mistakes.md
```

**Next session:**
```
You: Implement the logout endpoint

Claude: *writes code with proper null checks*

        // Check if user exists first
        if (!user) {
          return res.status(404).json({ error: "User not found" });
        }
```

### Example 2: Capturing a Pattern

**Session work:**
```
You: The API calls are failing with CORS errors in production

Claude: Let me help debug...

        The issue is that Next.js API routes need explicit CORS headers.
        Here's the pattern that works:

        *implements CORS middleware*

        This is a good pattern to capture for future Next.js projects.

Captured pattern: "Next.js API routes require explicit CORS middleware in production"
Location: ~/.claude/learnings/patterns.md
```

**Next project (Next.js):**
```
You: Set up the API routes for this new Next.js app

Claude: I'll set them up with proper CORS configuration from the start...

        *includes CORS middleware automatically*
```

### Example 3: Capturing a Decision

**Session work:**
```
You: Should we use Redux or Zustand for state management?

Claude: Let me analyze both options...

        Recommendation: Zustand
        - Simpler API (less boilerplate)
        - Smaller bundle size
        - Sufficient for this app's complexity

        I'll capture this decision for future reference.

Captured decision: "Chose Zustand over Redux for state management"
Rationale: "Simpler API, smaller bundle, sufficient for app complexity"
Alternatives: "Redux (too much boilerplate for this use case)"
Location: .claude/learnings/decisions.md
```

**Later session:**
```
You: Why are we using Zustand?

Claude: *checks learnings*

        Based on the architecture decision captured on 2025-01-05:
        We chose Zustand over Redux because it has a simpler API,
        smaller bundle size, and is sufficient for this app's complexity.
```

---

## Advanced Usage

### Organizing Large Learning Files

As learnings grow, organize them:

**patterns.md:**
```markdown
# Patterns

## TypeScript Patterns

### 2025-01-05: Zod for API Validation
...

### 2025-01-12: Type Guards with Branded Types
...

## React Patterns

### 2025-01-08: Custom Hooks for Data Fetching
...

## Database Patterns

### 2025-01-15: Prisma Transaction Patterns
...
```

### Cross-Referencing

Link related learnings:

```markdown
## 2025-01-20: JWT Authentication Pattern

- Use httpOnly cookies for storage
- Implement refresh token rotation
- See also: **Mistake 2025-01-05** about JWT expiry validation
```

### Learning Templates

Create templates for consistency:

**Pattern Template:**
```markdown
## YYYY-MM-DD: [Pattern Name]

- **What:** [One-sentence description]
- **When to use:** [Conditions/scenarios]
- **Example:**
  ```[language]
  [code example]
  ```
- **Benefits:** [Why this works]
- **Gotchas:** [What to watch for]
```

**Decision Template:**
```markdown
## YYYY-MM-DD: [Decision Name]

- **Decision:** [What was decided]
- **Context:** [Why this decision was needed]
- **Rationale:** [Why we chose this]
- **Alternatives considered:**
  - [Option 1]: [Why rejected]
  - [Option 2]: [Why rejected]
- **Trade-offs:** [What we're accepting/giving up]
```

---

## Troubleshooting

### Issue: Learnings Not Loading

**Symptoms:** Claude doesn't seem aware of captured learnings

**Fixes:**
1. Check files exist:
   ```bash
   ls -la ~/.claude/learnings/
   ls -la .claude/learnings/
   ```

2. Check CLAUDE.md references learnings:
   ```bash
   grep "@" ~/.claude/CLAUDE.md
   ```

3. Verify file format (should be markdown):
   ```bash
   file ~/.claude/learnings/patterns.md
   ```

### Issue: Stop Hook Not Triggering

**Symptoms:** No reflection prompt when exiting

**Fixes:**
1. Check settings.json:
   ```bash
   cat ~/.claude/settings.json | grep -A 10 "Stop"
   ```

2. Verify JSON is valid:
   ```bash
   cat ~/.claude/settings.json | python -m json.tool
   ```

3. Restart Claude Code session

### Issue: /reflect Command Not Found

**Symptoms:** `/reflect` doesn't work

**Fixes:**
1. Check command file exists:
   ```bash
   ls -la ~/.claude/commands/reflect.md
   ```

2. Verify command frontmatter (if using)

3. Try absolute path:
   ```bash
   cat ~/.claude/commands/reflect.md
   ```

### Issue: Too Many Learnings

**Symptoms:** Learning files are becoming unwieldy

**Fixes:**
1. **Archive old learnings:**
   ```bash
   mkdir ~/.claude/learnings/archive
   mv ~/.claude/learnings/patterns.md ~/.claude/learnings/archive/patterns-2025.md
   # Start fresh file
   ```

2. **Consolidate duplicates:**
   - Review learnings monthly
   - Merge similar patterns
   - Remove outdated ones

3. **Split by topic:**
   ```
   ~/.claude/learnings/
   ├── patterns-typescript.md
   ├── patterns-react.md
   ├── patterns-database.md
   └── mistakes.md
   ```

---

## FAQ

### How often should I reflect?

**After sessions with:**
- ✅ Significant debugging (>30min on one issue)
- ✅ New patterns discovered
- ✅ Mistakes that cost time
- ✅ Important architecture decisions

**Skip reflection for:**
- ❌ Routine bug fixes
- ❌ Simple feature additions
- ❌ Sessions with nothing notable

### Can I edit learnings manually?

**Yes!** Learning files are just markdown. Edit them anytime:

```bash
# Edit global patterns
vim ~/.claude/learnings/patterns.md

# Edit project decisions
vim .claude/learnings/decisions.md
```

### Should I commit learning files to git?

**Global learnings:** No (they're in `~/.claude/`, outside the repo)

**Project learnings:** YES! Commit `.claude/learnings/` to share with team:

```bash
git add .claude/learnings/
git commit -m "docs: add learnings from implementation phase"
```

**Personal notes:** Use `.claude/CLAUDE.local.md` (auto-ignored)

### Can I share learnings across my team?

**Yes!** Two approaches:

1. **Commit project learnings** (recommended):
   ```bash
   # Everyone gets project learnings when they clone
   git clone repo
   # Project learnings in .claude/learnings/ are already there
   ```

2. **Share global templates**:
   ```bash
   # Create a team global template
   cp ~/.claude/learnings/patterns.md ~/team-learnings/
   # Team members can copy and customize
   ```

### How do I migrate existing project knowledge?

**From README or wiki:**

```bash
# Copy relevant sections to learnings
# README.md section: "Common Gotchas"
# → .claude/learnings/learnings.md

# Wiki page: "Architecture Decisions"
# → .claude/learnings/decisions.md
```

**From comments in code:**

```bash
# Find TODO/FIXME/NOTE comments
grep -r "TODO\|FIXME\|NOTE" src/

# Convert insights to learnings
# Code comment: "NOTE: API rate limit is 100/min"
# → .claude/learnings/learnings.md entry
```

---

## Summary

**The session learning system transforms Claude Code into a self-improving tool.**

- ✅ Patterns accumulate
- ✅ Mistakes aren't repeated
- ✅ Knowledge persists
- ✅ Sessions get smarter over time

**Setup once, benefit forever.**

---

**Ready to set up?** Follow the [Setup](#setup) section above.

**Need help?** See [Troubleshooting](#troubleshooting).

**Want more?** Read the [claude-code-setup.md](./claude-code-setup.md) guide.
