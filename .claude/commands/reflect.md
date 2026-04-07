# Session Reflection

Conduct a structured reflection on the current session to capture learnings. This is the standalone version of `/wrap` Step 1 — use it when you want to capture learnings without committing/pushing.

## Process

### Step 1: Session Summary

Review what was accomplished:
- What was the main task/goal?
- What approaches were tried?
- What was the outcome?

### Step 2: Extract Learnings

Identify anything genuinely novel. The bar is high — routine work produces no learnings, and that's fine.

**Global** (`~/.claude/learnings/`) — applies across all projects:
- `patterns.md` — approaches that worked well, reusable workflows
- `mistakes.md` — errors made, root causes, how to prevent

**Project** (`.claude/learnings/learnings.md`) — specific to this repo:
- Gotchas, architectural decisions, edge cases, discoveries

**User preferences** go in auto-memory, not learnings files.

### Step 3: Write Learnings

Before writing, check existing files to avoid duplicates. Update existing entries rather than adding new ones where possible.

**For Patterns:**
```markdown
## YYYY-MM-DD: [Pattern Name]
- [What the pattern is]
- **When to use:** [Conditions]
- **Example:** [Brief code or workflow example]
```

**For Mistakes:**
```markdown
## YYYY-MM-DD: [Mistake Name]
- **What happened:** [Description]
- **Root cause:** [Why it happened]
- **Prevention:** [How to avoid in future]
```

**For Project Learnings:**
```markdown
## YYYY-MM-DD: [Title]
- [Description — what was learned, decided, or discovered]
- [Context, workaround, or rationale as needed]
```

### Step 4: Present Summary

```
## Session Reflection Complete

**Learnings Captured:**
- [Type]: "[title]" → [file path]

**Recommendation for next session:**
[Any follow-up items or things to watch for]
```

## If No Learnings

Say so honestly. Don't force learnings where there aren't any.

## Arguments

If invoked with arguments (e.g., `/reflect authentication flow`), focus reflection on that specific topic.

$ARGUMENTS
