# /solve-issues — GitHub Issue Orchestrator

Triage open GitHub issues, classify them by complexity, and progressively solve each one. Designed for autonomous multi-session execution.

---

## What This Does

`/solve-issues` pulls open issues from the current repo, classifies each by complexity, and solves them one by one — batching trivials, implementing standards directly, and running full plan cycles for complex ones. Issues that need human judgment are skipped and summarised at the end.

Works for the **current repo only**. Chains existing skills — this command is glue, not reimplementation.

---

## Quality bar

- Every step names an outcome, and every tool it names is verified available at run time. A
  disabled or absent plugin triggers the stated fallback — never a silent skip. Say which route
  you took.
- Every change gets a fresh-context adversarial review, in a sub-agent, scoped to an explicit
  diff range — before it is committed. The trivial batch gets one batch-level review.
- The shared working tree is never disturbed: worktree, not `git checkout` in the primary tree.
- Every issue's premise is re-verified against current `main` before it is solved.
- The run ends at its own summary — never chains into `/wrap`.

---

## Prerequisites

- `gh` CLI authenticated
- Git repository with remote configured
- `commit-commands` plugin (git workflow)

**Tool availability — detect, never assume.** Every plugin skill below is *optional*. Installed
≠ available: a plugin can sit on disk and still be `false` in `enabledPlugins`, and enablement
differs per machine and per project. Check your own available-skills list — it is already in
context, no tool call needed — and route to the fallback when something isn't listed.

---

## How It Works

### Phase 0: Setup & Discovery

1. **Check for existing state** — looks for `.claude/solve-issues.local.md` in the **primary** tree. A state file is a claim, not a fact: validate its rows against `gh issue list --state all` before resuming. Closed issues = stale, delete and start fresh. A file with no branches cut yet is live, not stale. Resume automatically in Ralph mode (nobody is there to answer a prompt); ask once in manual mode.
2. **Register the work stream** — runs `/start-stream` unprompted, *gated on step 1*: skip it if a live state file exists, or an autonomous re-feed opens a new row per iteration.
3. **Mode** — read `mode:` from the state file on resume, else `--ralph` if passed, else manual. Never ask.
4. **Discover issues** — runs `gh-triage` to pull and prioritise open issues.
5. **Write state file** — creates `.claude/solve-issues.local.md` **before the first branch is cut**, in the primary tree (a worktree gets torn down and would take the resumption state with it). Local only, not committed.

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

**Git isolation:** in a shared working tree (a `local/SESSIONS.md` exists, or another session may be running in the same checkout), do the whole solve in a worktree — never `git checkout` in the primary tree. One branch per issue is the default, not a rule: issues rewriting overlapping regions of the *same* file belong on one branch, one commit each.

| Class | Approach | Preferred tool → fallback |
|-------|----------|--------------------------|
| **Trivial** | Batch all on one branch, commit each, **one batch-level review** | review sub-agent |
| **Standard** | Own branch, implement + review | review sub-agent |
| **Complex** | Own branch, plan → execute → review | `superpowers:writing-plans` → `Plan` agent or a numbered list in the state file; `superpowers:executing-plans` → work it directly |

**Review is the outcome, not the tool.** Always a fresh-context sub-agent, always scoped to an explicit diff range (`main..<branch>` or a PR number — a review with no target reads the working tree, which in a shared checkout is other sessions' WIP). Inside the sub-agent use `superpowers:requesting-code-review` if enabled, else the `code-review` skill. Brief it adversarially and specifically; a generic "review this PR" finds generic things.

After each issue or batch, a **checkpoint** shows progress and saves state.

If implementation fails (tests won't pass, unclear path), the issue is marked `failed` and a comment is added to the GitHub issue explaining why.

### Phase 3: Cleanup

**This command ends at PRs opened.** Merging is the user's call, not the run's.

1. **Summary** — shows solved, skipped, and failed counts
2. **Push and create PRs** — `git push -u origin <branch>` first (`gh pr create` on an unpushed branch prompts interactively, a silent hang in an autonomous run), then one PR per branch, trivials batched into one. One `Closes #N` keyword per issue — `Closes #1, #2` only closes the first.
3. **Stop** — do **not** invoke `/wrap` and do not offer to; `/ship` was changed the same way for the same reason (double-wraps, inconsistent endings). The work stream row stays Open until the user runs `/wrap` — say so, so an open row reads as expected state rather than a leak.
4. **State file** — delete it only when every issue is terminal (`done`/`skipped`/`failed`), the same condition the Ralph promise fires on. On any other ending, keep it and name which issues it still covers; staleness is handled by the Phase 0 validation gate, not by deleting early.

---

## Plugin Map

Nothing below is a hard dependency. Each row is a *preference*; if the tool isn't in your
available-skills list, take the fallback and say so.

| Phase | Preferred | Fallback | Purpose |
|-------|-----------|----------|---------|
| 0 | `gh-triage` | `gh issue list` directly | Discover and prioritise open issues |
| 0 | `/start-stream` | skip, note why, carry on | Register the work stream |
| 2 (complex) | `superpowers:writing-plans` | `Plan` agent, or a numbered list in the state file | Create implementation plan |
| 2 (complex) | `superpowers:executing-plans` | work the plan directly | Execute plan task by task |
| 2 (all) | `superpowers:requesting-code-review` | `code-review` skill | Review — always in a sub-agent, always diff-scoped |
| 3 | `commit-commands` | `git` + `gh pr create` | Git workflow for PRs |

`/wrap` is **not** in this map — the run ends at its summary and the user runs wrap themselves.

---

## State File

`.claude/solve-issues.local.md` — local file, not committed. Tracks issue list with classification, status (`pending` | `in-progress` | `done` | `skipped` | `failed`), and branch assignment.

This enables **multi-session execution** — each new session reads the state file and resumes from the first pending issue.

---

## Usage

```bash
/solve-issues            # manual mode (default)
/solve-issues --ralph    # autonomous, multi-session
```

Issues are discovered from the current repo automatically.

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
