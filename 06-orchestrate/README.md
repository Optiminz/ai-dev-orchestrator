# /orchestrate — Automated AI Development Workflow

The `/orchestrate` command automates a 5-phase development workflow with human approval checkpoints at every stage. It's the most advanced feature of this framework.

## Prerequisites

Before using `/orchestrate`, you need:

1. **Claude Code** installed and authenticated
2. **Plugins installed:**
   - `superpowers` (brainstorming, TDD, plans, verification)
   - `pr-review-toolkit` (code review)
   - `commit-commands` (git workflow)
3. A **git repository** initialized
4. A **feature request** or idea to build

**Standards file** (recommended): `CONSTITUTION.md`, `CLAUDE.md`, or `AGENTS.md` in your project root. Orchestrate looks for these in order and uses the first one found. If none exist, it infers conventions from existing code.

## How It Works

`/orchestrate` detects your repo type (codebase vs text repo) and adapts the workflow accordingly.

### Repo Type Detection

| Signal | Classification |
|--------|---------------|
| Has `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`, or `Makefile` with build/test targets | **Codebase** — uses feature branches, PRs, test gates |
| No build tooling detected | **Text repo** — commits to main, no PR needed |

### Workflow Phases

| Phase | What happens | Plugin used |
|-------|-------------|-------------|
| **0 — Explore** | Brainstorm and clarify requirements | `superpowers:brainstorming` |
| **1 — Plan** | Create implementation plan from spec | `superpowers:writing-plans` |
| **1.5 — Branch** (codebases only) | Create feature branch in worktree | `superpowers:using-git-worktrees` |
| **2 — Build** | Implement task-by-task with tests | `superpowers:test-driven-development` or `subagent-driven-development` |
| **3 — Review** | Comprehensive code review | `pr-review-toolkit:review-pr` (codebases) or `superpowers:requesting-code-review` (text repos) |
| **4 — Document** | Generate/update documentation | Technical Writer agent |
| **Ship** | Merge/PR decision (codebases) or push to main (text repos) | `superpowers:finishing-a-development-branch` |

## Usage

```bash
/orchestrate "Build user authentication with email and OAuth"
```

## Human Checkpoints

You approve at each phase transition — the AI never ships without your sign-off:

1. After brainstorming: "Does this capture what you want?"
2. After planning: "Review the plan. Ready to build?"
3. After building: "Implementation complete. Ready for review?"
4. After review: "Review complete. Approve documentation?"
5. After docs: "Ready to ship?"

## Codebase vs Text Repo Differences

| Step | Codebase | Text Repo |
|------|----------|-----------|
| **Branching** | Creates `feat/` branch in worktree before building | Stays on main |
| **Building** | TDD — tests before implementation, commit per task | Commit logical chunks |
| **Review** | Pushes branch, runs 6 specialized PR reviewers | Reviews diff since start |
| **Ship** | Offers PR, merge, keep, or discard options | Commits and pushes to main |

## Learn More

- [How the workflow works in detail](how-it-works.md)
- [Phase checklist](phase-checklist.md)
- [Which prompt/phase to use](prompt-selection-guide.md)
