# /orchestrate — Automated AI Development Workflow

The `/orchestrate` command automates a 5-phase development workflow with human approval checkpoints at every stage. It's the most advanced feature of this framework.

## Prerequisites

Before using `/orchestrate`, you need:

1. **Claude Code** installed and authenticated
2. **Plugins installed:**
   - `superpowers` (brainstorming, TDD, plans, verification)
   - `pr-review-toolkit` (code review)
   - `commit-commands` (git workflow)
3. **CONSTITUTION.md** in your project root
4. A **feature request** or idea to build

## How It Works

`/orchestrate` runs 5 phases, pausing for your approval between each:

| Phase | What happens | Plugin used |
|-------|-------------|-------------|
| **0 — Explore** | Brainstorm and clarify requirements | `superpowers:brainstorming` |
| **1 — Plan** | Create implementation plan from spec | `superpowers:writing-plans` |
| **2 — Build** | Implement task-by-task with tests | `superpowers:test-driven-development` or `subagent-driven-development` |
| **3 — Review** | Comprehensive code review (6 specialized agents) | `pr-review-toolkit:review-pr` |
| **4 — Document** | Generate/update documentation | Technical Writer agent |
| **Ship** | Merge/PR decision | `superpowers:finishing-a-development-branch` |

## Usage

```bash
# Full workflow
/orchestrate "Build user authentication with email and OAuth"

# Skip to a specific phase
/orchestrate --phase build
/orchestrate --phase review
/orchestrate --phase docs
```

## Human Checkpoints

You approve at each phase transition — the AI never ships without your sign-off:

1. After brainstorming: "Does this capture what you want?"
2. After planning: "Review the plan. Ready to build?"
3. After building: "Implementation complete. Ready for review?"
4. After review: "Issues found. Fix and continue?"
5. After docs: "Ready to ship?"

## Learn More

- [How the workflow works in detail](how-it-works.md)
- [Phase checklist](phase-checklist.md)
- [Which prompt/phase to use](prompt-selection-guide.md)
