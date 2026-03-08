# Session Reflection

Conduct a structured reflection on the current session to capture learnings and prevent repeated mistakes.

## Your Task

Analyze this session and extract actionable learnings. Categorize them as **global** (applies to all projects) or **project-specific** (only this repo).

## Reflection Process

### Step 1: Session Summary

Review what was accomplished in this session:
- What was the main task/goal?
- What approaches were tried?
- What was the outcome?

### Step 2: Extract Learnings

Identify learnings in these categories:

**Patterns (things that worked well):**
- Code patterns that solved problems elegantly
- Workflows that were efficient
- Debugging approaches that found issues quickly

**Mistakes (things to avoid):**
- Errors made and their root cause
- Approaches that wasted time
- Assumptions that were wrong

**Preferences (user style discovered):**
- Coding style preferences observed
- Tool preferences
- Communication preferences

**Decisions (architectural choices):**
- Technical decisions made and WHY
- Trade-offs considered
- Alternatives rejected and reasons

### Step 3: Categorize Each Learning

For each learning, determine:
- **Global**: Applies across all projects (e.g., "Always check for null before accessing nested properties")
- **Project-specific**: Only applies to this repo (e.g., "This project uses Zustand for state, not Redux")

### Step 4: Write Learnings

**For GLOBAL learnings**, append to the appropriate file:

```bash
# For patterns
echo -e "\n## $(date '+%Y-%m-%d'): [Pattern Title]\n- [Description]\n- **Example:** [Code or workflow example]" >> ~/.claude/learnings/patterns.md

# For mistakes
echo -e "\n## $(date '+%Y-%m-%d'): [Mistake Title]\n- **What happened:** [Description]\n- **Root cause:** [Why]\n- **Prevention:** [How to avoid]" >> ~/.claude/learnings/mistakes.md

# For preferences
echo -e "\n## $(date '+%Y-%m-%d'): [Preference]\n- [Description]" >> ~/.claude/learnings/preferences.md
```

**For PROJECT-SPECIFIC learnings**, first ensure the directory exists:

```bash
mkdir -p .claude/learnings
```

Then append to project files:

```bash
# For insights
echo -e "\n## $(date '+%Y-%m-%d'): [Insight Title]\n- [Description]" >> .claude/learnings/insights.md

# For decisions
echo -e "\n## $(date '+%Y-%m-%d'): [Decision Title]\n- **Decision:** [What was decided]\n- **Rationale:** [Why]\n- **Alternatives considered:** [What else was evaluated]" >> .claude/learnings/decisions.md

# For gotchas
echo -e "\n## $(date '+%Y-%m-%d'): [Gotcha Title]\n- **Issue:** [What can go wrong]\n- **Solution:** [How to handle it]" >> .claude/learnings/gotchas.md
```

### Step 5: Present Summary

After writing learnings, show the user:

```
## Session Reflection Complete

### Learnings Captured:

**Global** (applies everywhere):
- [Pattern/Mistake/Preference]: [Brief description]

**Project-specific** (this repo only):
- [Insight/Decision/Gotcha]: [Brief description]

### Files Updated:
- ~/.claude/learnings/[file].md
- .claude/learnings/[file].md

### Recommendation for next session:
[Any follow-up items or things to watch for]
```

## If No Learnings

If the session was straightforward with nothing notable:
- Say so honestly
- Don't force learnings where there aren't any
- Suggest this is a good sign the existing learnings are working

## Arguments

If invoked with arguments (e.g., `/reflect authentication flow`), focus reflection on that specific topic.

$ARGUMENTS

---

*This reflection helps Claude Code sessions learn from themselves. The more specific the learnings, the more useful they are.*
