---
name: gh-triage
description: "Review and triage GitHub issues on the current repo. First invocation prioritises open issues and recommends next steps. Subsequent invocations detect work done on issues in this session and update them (comment, close, label). Trigger on 'issues', 'triage issues', 'issue update', 'what issues are open'."
---

# GitHub Issue Triage — `/issues`

Scoped to the **current repo only**. Two implicit modes based on session state.

---

## MODE DETECTION

- **Triage mode**: No prior `/issues` run in this session, or user explicitly asks to re-triage.
- **Update mode**: `/issues` has already run this session AND work has been done on issues since (commits, file changes). Detect by checking conversation context for previously triaged issues and comparing against `git log` / `git diff` since triage.

If ambiguous, ask: "Triage fresh or update issues you've worked on?"

---

## TRIAGE MODE

### Step 1: Silent Pull

**Tools:** `gh issue list --repo {current_repo} --state open --limit 50 --json number,title,labels,assignees,createdAt,updatedAt,milestone,body`

For each issue, extract:
- Number, title, labels, assignee
- Age (days since created)
- Last activity (days since updated)
- One-line summary from body (first meaningful sentence)

### Step 2: Prioritise

Classify each issue into priority tiers:

- **🔴 HIGH** — bugs, blockers, security, anything with an urgent label, issues assigned to Malcolm that are stale (>7 days no update)
- **🟡 MEDIUM** — feature requests with clear scope, issues with recent discussion, issues tied to active work
- **⚪ LOW / BACKLOG** — nice-to-haves, vague requests, no recent activity, no assignee

Use judgement based on:
- Labels (bug > feature > enhancement > chore)
- Age and staleness
- Whether the issue relates to files recently changed in the repo
- Assignee (Malcolm's issues rank higher)

### Step 3: Present

```
🎫 ISSUES — {repo} ({count} open)

🔴 HIGH
• #{num} {title} — {one-line rationale for priority}
• #{num} {title} — {one-line rationale}

🟡 MEDIUM
• #{num} {title} — {one-line rationale}

⚪ LOW / BACKLOG
• #{num} {title}
• #{num} {title}

{If no open issues: "No open issues. Clean slate."}
```

### Step 4: Consulting Coach Recommendations

Channel the Consulting Coach voice (see `prompts/consulting-coach.md`):

- **Direct and confident.** "Here's what to tackle" not "You might want to consider..."
- **Strategic framing.** Connect issues to what matters — client-facing bugs before internal cleanup.
- **Be honest about stale issues.** If something has sat untouched for weeks, call it out — close it or do it.

```
🎯 RECOMMENDED NEXT

1. **#{num} {title}** — {why this one first, what the next concrete action is}
2. **#{num} {title}** — {why, what to do}
3. **#{num} {title}** — {why, what to do}

{If stale issues exist: "🧹 Consider closing: #{num}, #{num} — these have been open {X} days with no activity. If they mattered, they'd have moved by now."}
```

Use `ask_user_input` to confirm focus or adjust.

---

## UPDATE MODE

### Step 1: Detect Worked Issues

Check conversation context for which issues were discussed or worked on. Cross-reference with:
- `git log --oneline` since the session started (look for issue references like `#123`, `fixes #123`, `closes #123`)
- `git diff --name-only` to see what files changed
- Any issue numbers mentioned in conversation

### Step 2: Propose Updates

For each touched issue, propose ONE of:

| Signal | Action |
|--------|--------|
| Commit message says "fixes #N" or "closes #N" | **Close** with summary comment |
| Substantial code changes related to the issue | **Comment** with what was done, link commits |
| Investigation done, no code yet | **Comment** with findings/insights |
| Issue turns out to be invalid or duplicate | **Close** with explanation |
| New information surfaced during work | **Comment** with new context |

### Step 3: Present and Confirm

```
🎫 ISSUE UPDATES — {repo}

#{num} {title}
  → {proposed action}: {draft comment or close reason}

#{num} {title}
  → {proposed action}: {draft comment or close reason}

{If no issues were worked on: "No issue work detected this session. Run /issues to re-triage."}
```

**Wait for confirmation before pushing any changes to GitHub.** Present all proposed updates, then ask:

> "Push these updates? (y/n, or edit specific ones)"

### Step 4: Execute

On confirmation, use `gh` CLI to:
- `gh issue comment {num} --body "{comment}"` for comments
- `gh issue close {num} --comment "{reason}"` for closures
- `gh issue edit {num} --add-label "{label}"` for label changes

Report results:
```
✅ #{num} — commented
✅ #{num} — closed
```

---

## OUTPUT STYLE

- Terminal only — no browser
- Direct, scannable, emoji headers for structure (🎫 🔴 🟡 ⚪ 🎯 🧹)
- Skip empty priority tiers silently
- Consulting Coach voice for recommendations only — data sections are neutral
- If `gh` CLI fails, note the error and continue with what's available
