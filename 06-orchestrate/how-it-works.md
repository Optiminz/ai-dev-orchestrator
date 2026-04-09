# AI-Dev-Orchestrator: Workflow Overview

This document provides a high-level overview of the AI-driven development workflow.

---

## The Plugin-Powered Workflow

```
Phase 0: EXPLORE          Phase 1: PLAN            Phase 1.5: BRANCH         Phase 2: BUILD
                                                    (codebases only)

[User Need/Idea]
       ↓
┌──────────────────┐
│ Brainstorming    │
│ (superpowers)    │     ┌──────────────────┐
│ Clarify needs    │     │ Writing Plans    │     ┌──────────────────┐
│ Propose approaches│    │ (superpowers)    │     │ Git Worktrees    │     ┌──────────────────┐
└──────────────────┘     │ Task breakdown   │     │ (superpowers)    │     │ TDD / Subagent   │
       ↓                 │ File paths       │     │ feat/ branch     │     │ (superpowers)    │
   Review/Approve        └──────────────────┘     └──────────────────┘     │ Task-by-task     │
                                ↓                        ↓                 │ Tests first      │
                            Review/Approve           Auto (codebases)      └──────────────────┘
                                                                                  ↓
                                                                              Review/Approve


Phase 3: REVIEW                    Phase 4: DOCUMENT              SHIP

┌──────────────────┐
│ Codebases:       │
│ Push branch      │               ┌──────────────────┐
│ PR Review Toolkit│               │ Technical Writer  │     ┌──────────────────┐
│ (6 reviewers)    │               │ README, guides    │     │ Codebases:       │
├──────────────────┤               │ API docs          │     │ Finishing Branch  │
│ Text repos:      │               │                   │     │ (PR/merge/keep)  │
│ Code Review      │               │ + /wrap for       │     ├──────────────────┤
│ on diff          │               │ session learnings │     │ Text repos:      │
└──────────────────┘               └──────────────────┘     │ Push to main     │
       ↓                                  ↓                  └──────────────────┘
   Fix issues                        Review/Approve
   Review/Approve
```

---

## The Philosophy: Explore → Plan → Build → Review → Ship

### 1. EXPLORE (Phase 0)
- **Don't jump to planning.** Clarify requirements and constraints first
- **Propose trade-offs** — 2-3 approaches with pros/cons
- **Get buy-in** before investing in a detailed plan
- **If requirements are ambiguous or there are 3+ valid approaches:** Use `sequential-thinking` MCP to reason through trade-offs systematically before proposing

### 2. PLAN (Phase 1)
- **Create a detailed plan** with exact file paths, code snippets, and test commands
- **Reference project standards** (CONSTITUTION.md, CLAUDE.md, or AGENTS.md)
- **Break into bite-sized tasks** — each should be independently completable
- **If task dependencies are complex or ordering is non-obvious:** Use `sequential-thinking` MCP to work through dependency chains and sequencing

### 3. BUILD (Phase 2)
- **One task at a time.** Implement iteratively, not all at once
- **Tests first** (codebases) — TDD catches issues early
- **Commit after each task** — clean, reviewable history

### 4. REVIEW (Phase 3)
- **Review everything.** Don't ship without review
- **Codebases get six specialized reviewers:** silent failure hunter, type design analyzer, PR test analyzer, code reviewer, code simplifier, comment analyzer
- **Fix CRITICAL/HIGH issues immediately**, ask about MEDIUM/LOW
- **If review findings conflict or severity is unclear:** Use `sequential-thinking` MCP to reason through triage decisions

### 5. SHIP
- **Codebases:** Feature branch → PR or merge, with worktree cleanup
- **Text repos:** Already on main, just push

---

## Plugin-Powered Architecture

Instead of asking a single AI to "do everything," each phase delegates to specialized plugins:

| Phase | Plugin/Skill | What It Does |
|-------|-------------|--------------|
| 0 | `superpowers:brainstorming` | Structured requirements exploration |
| 1 | `superpowers:writing-plans` | Implementation plans with task breakdown |
| 1.5 | `superpowers:using-git-worktrees` | Isolated feature branches |
| 2 | `superpowers:test-driven-development` | Tests-first implementation |
| 2 | `superpowers:subagent-driven-development` | Parallel task execution |
| 3 | `pr-review-toolkit:review-pr` | 6 specialized code reviewers |
| 3 | `superpowers:requesting-code-review` | Lightweight diff review |
| 3 | `superpowers:verification-before-completion` | Verify all claims are accurate |
| 0, 1, 3 | `sequential-thinking` MCP (optional) | Structured reasoning for ambiguous or complex decisions |
| 2 | `context7` MCP (optional) | Current library/framework docs during implementation |
| 4 | Technical Writer agent | Documentation generation |
| Ship | `superpowers:finishing-a-development-branch` | PR/merge/cleanup decisions |
| Ship | `/wrap` | Session learnings capture |

---

## Key Principles

### 1. Standards as Law
- Every phase references your project standards file
- Non-negotiable conventions prevent drift
- Consistency across all AI outputs

### 2. Repo-Type Awareness
- Codebases get branches, PRs, and test gates
- Text repos commit to main — no unnecessary ceremony
- Detection is automatic based on build tooling

### 3. Autonomous Between Checkpoints
- Human approval at phase transitions, not micro-decisions
- AI works autonomously within each phase
- You make the strategic decisions, AI handles execution

### 4. Quality Gates
- Review phase runs specialized checks (not just "looks good")
- Verification proves claims before shipping
- Session learnings improve future sessions via `/wrap`

---

## Standards Discovery

Orchestrate looks for project standards in this order:

1. `CONSTITUTION.md` — dedicated project rules file
2. `CLAUDE.md` — Claude Code project instructions
3. `AGENTS.md` — agent-specific instructions
4. Infer from existing code patterns and tooling

You don't need all of these. One is enough. If you're starting fresh, create a `CONSTITUTION.md` using the templates in [05-constitutions/](../05-constitutions/).

---

## Common Pitfalls to Avoid

### Skipping the Plan
- **Problem:** Jumping straight to code without Phase 0-1
- **Result:** Over-engineering, scope creep, rework
- **Fix:** Always start with Explore + Plan

### Implementing Multiple Tasks at Once
- **Problem:** Asking AI to "build the entire feature"
- **Result:** Complex, hard-to-review code
- **Fix:** Build phase implements one task at a time

### Ignoring Review Feedback
- **Problem:** Not fixing CRITICAL/HIGH issues
- **Result:** Security vulnerabilities, bugs in production
- **Fix:** Address all critical issues before shipping

### Using Feature Branches for Text Repos
- **Problem:** Creating PRs for markdown changes
- **Result:** Unnecessary ceremony, merge overhead
- **Fix:** Orchestrate detects text repos and stays on main

---

## See Also

- [Prompt Selection Guide](./prompt-selection-guide.md) - Decision tree for choosing prompts
- [Phase Checklist](./phase-checklist.md) - Ensure you complete each phase fully
- [Personas Overview](../personas/README.md) - Detailed persona definitions (for manual prompt workflows)
