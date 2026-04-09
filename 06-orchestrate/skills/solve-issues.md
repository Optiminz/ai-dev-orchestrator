# /solve-issues — GitHub Issue Orchestrator

Triage open GitHub issues, classify them by complexity, and progressively solve each one. Designed for autonomous multi-session execution.

---

## What This Does

`/solve-issues` pulls open issues from the current repo, classifies each by complexity, and solves them one by one — batching trivials, implementing standards directly, and running full plan cycles for complex ones. Issues that need human judgment are skipped and summarised at the end.

Works for the **current repo only**. Chains existing skills — this command is glue, not reimplementation.

---

## Prerequisites

- These plugins installed:
  - superpowers (plans, execution, verification, code review)
  - pr-review-toolkit (code review agents)
  - commit-commands (git workflow)
- `gh` CLI authenticated
- Git repository with remote configured

---

## How It Works

### Phase 0: Setup & Discovery

1. **Check for existing state** — looks for `.claude/solve-issues.local.md` in the repo root. If found, offers to resume.
2. **Discover issues** — runs `gh-triage` to pull and prioritise open issues.
3. **Write state file** — creates `.claude/solve-issues.local.md` tracking all issues (local only, not committed).

### Phase 1: Classification

Each issue is classified by reading the full issue body, labels, and comments:

| Class | Criteria | Git Strategy |
|-------|----------|-------------|
| **trivial** | Typo/config fix, one-file edit, docs fix | Batched on `fix/trivial-batch-{date}` |
| **standard** | Bug fix, small feature, clear criteria, 2-5 files | Own branch: `fix/{issue-num}-{slug}` |
| **complex** | Multi-file feature, architectural change, unclear scope | Own branch: `feat/{issue-num}-{slug}` |
| **needs-human** | Vague requirements, sensitive areas, opinions needed | Skipped entirely |

#### Needs-human detection signals

Classify as `needs-human` if **any** apply:

- Labels: `question`, `discussion`, `needs-decision`
- No clear acceptance criteria — vague body, no testable outcome
- Touches sensitive areas — auth, billing, payments, data deletion
- Asks for human opinion — "should we", "what do you think", "which approach"
- Architectural fork — multiple valid approaches, no preference stated
- External dependency — requires info not in the codebase

### Phase 2: Solve Loop

Issues are processed in order: **trivial batch → standard (by priority) → complex (by priority)**.

| Class | Approach | Plugins Used |
|-------|----------|-------------|
| **Trivial** | Batch all on one branch, commit each | Direct implementation |
| **Standard** | Own branch, implement + review | `superpowers:requesting-code-review` |
| **Complex** | Own branch, full plan → execute → review cycle | `superpowers:writing-plans` + `superpowers:executing-plans` + `superpowers:requesting-code-review` |

After each issue or batch, a **checkpoint** shows progress and saves state.

If implementation fails (tests won't pass, unclear path), the issue is marked `failed` and a comment is added to the GitHub issue explaining why.

### Phase 3: Cleanup

1. **Summary** — shows solved, skipped, and failed counts
2. **Create PRs** — one PR per branch (trivials batched into one PR)
3. **Wrap** — invokes `/wrap` for session learnings

---

## Plugin Map

| Phase | Plugin/Skill | Purpose |
|-------|-------------|---------|
| 0 | `gh-triage` | Discover and prioritise open issues |
| 2 (standard) | `superpowers:requesting-code-review` | Review standard fixes |
| 2 (complex) | `superpowers:writing-plans` | Create implementation plan |
| 2 (complex) | `superpowers:executing-plans` | Execute plan task by task |
| 2 (complex) | `superpowers:requesting-code-review` | Review complex implementations |
| 3 | `commit-commands` | Git workflow for PRs |
| 3 | `/wrap` | Session learnings capture |

---

## State File

`.claude/solve-issues.local.md` — local file, not committed. Tracks issue list with classification, status (`pending` | `in-progress` | `done` | `skipped` | `failed`), and branch assignment.

This enables **multi-session execution** — each new session reads the state file and resumes from the first pending issue.

---

## Usage

```bash
/solve-issues
```

No arguments needed — discovers issues from the current repo automatically.

---

## When to Use This vs /orchestrate

| Scenario | Use |
|----------|-----|
| Building a new feature from an idea | `/orchestrate` |
| Clearing a backlog of open issues | `/solve-issues` |
| One specific complex issue | `/orchestrate` (pointed at the issue) |
| Mix of trivial fixes and small bugs | `/solve-issues` |

---

## Key Principles

1. **Thin orchestrator** — chains existing skills, doesn't reimplement them
2. **State-driven resumability** — state file enables multi-session work
3. **Progressive complexity** — trivials batched, standards direct, complex get full plan cycle
4. **Human-aware** — auto-detects issues needing judgment, skips gracefully
5. **Autonomous between checkpoints** — doesn't ask permission for micro-decisions
