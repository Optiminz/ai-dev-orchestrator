# Orchestrate: Full AI-Dev Workflow Automation

Automate a 5-phase development workflow with human approval checkpoints at every stage.

---

## What This Does

The `/orchestrate` command takes a feature request and runs it through structured phases — brainstorming, planning, building, reviewing, and documenting — pausing for your approval between each. It uses the superpowers and pr-review-toolkit plugins to handle each phase.

---

## Prerequisites

Before using `/orchestrate`, ensure you have:
- CONSTITUTION.md in your project root
- These plugins installed:
  - superpowers (brainstorming, TDD, plans, verification)
  - pr-review-toolkit (code review)
  - commit-commands (git workflow)

---

## Your Task

Execute the full workflow for the given feature request, following the phases below with human approval between each.

---

## Phase 0: Explore

Invoke the `superpowers:brainstorming` skill to explore the idea with the user.

- Clarify requirements and constraints
- Propose 2-3 approaches with trade-offs
- Get user approval on the approach before proceeding

Ask user: "Does this capture what you want to build? Approve to continue to planning?"

---

## Phase 1: Plan

Invoke the `superpowers:writing-plans` skill to create an implementation plan.

- Read CONSTITUTION.md for tech stack and coding standards
- Create a detailed plan at `docs/plans/YYYY-MM-DD-[feature]-plan.md`
- Break into bite-sized tasks with exact file paths, code, and test commands

Ask user: "Review the plan. Approve to start building?"

---

## Phase 2: Build

Invoke `superpowers:subagent-driven-development` (if tasks are independent) or `superpowers:test-driven-development` (if tasks are sequential).

- Implement task-by-task following the plan
- Write tests before implementation (TDD)
- Commit after each completed task
- Follow CONSTITUTION.md coding standards throughout

Ask user: "Implementation complete. Ready for review?"

---

## Phase 3: Review

Invoke `pr-review-toolkit:review-pr` to run a comprehensive code review.

This fires six specialized reviewers:
- Silent failure hunter
- Type design analyzer
- PR test analyzer
- Code reviewer
- Code simplifier
- Comment analyzer

If issues are found:
- CRITICAL/HIGH: Fix before proceeding
- MEDIUM/LOW: Ask user whether to fix now or defer

After fixes, run `superpowers:verification-before-completion` to verify all tests pass and all claims are accurate.

Ask user: "Review complete. Approve to write documentation?"

---

## Phase 4: Document

Use the Technical Writer agent (`.claude/agents/technical-writer.md`) to create or update documentation:

- Update README.md with feature documentation
- Add usage examples and code samples
- Document API endpoints if applicable
- Add troubleshooting for common issues

Then run `/wrap` to capture session learnings and produce a summary.

Ask user: "Documentation complete. Ready to ship?"

---

## Ship

Invoke `superpowers:finishing-a-development-branch` to decide how to integrate the work:
- Merge directly (if on a feature branch)
- Create a PR (for team review)
- Cleanup (if experimental)

---

## User Interaction Points

You pause for approval at these checkpoints:

1. After brainstorming: "Does this capture what you want?"
2. After planning: "Review the plan. Ready to build?"
3. After building: "Implementation complete. Ready for review?"
4. After review: "Review complete. Approve documentation?"
5. After documentation: "Ready to ship?"

Between checkpoints, work autonomously. Only pause for approval, not micro-decisions.

---

## Usage

### Full workflow
```
/orchestrate "Build user authentication with email and OAuth"
```

### Skip to a specific phase
```
/orchestrate --phase build    # Skip straight to Phase 2
/orchestrate --phase review   # Skip to Phase 3
/orchestrate --phase docs     # Skip to Phase 4
```

---

## Example Run

```
You: /orchestrate "Add a comments system to blog posts"

Claude (Phase 0 — Explore):
  Using superpowers:brainstorming...
  ✓ Explored requirements
  ✓ Proposed 3 approaches (nested comments, flat, threaded)
  → Does this capture what you want? [y/n]

You: y — go with threaded comments

Claude (Phase 1 — Plan):
  Using superpowers:writing-plans...
  ✓ Created plan at docs/plans/2026-03-09-comments-plan.md
  ✓ 12 tasks identified
  → Review the plan. Ready to build? [y/n]

You: y

Claude (Phase 2 — Build):
  Using superpowers:subagent-driven-development...
  ✓ Task 1/12: Comment model + migration (tests passing)
  ✓ Task 2/12: Comment API endpoints (tests passing)
  ... [continues task by task] ...
  ✓ Task 12/12: Comment notification preferences
  → Implementation complete. Ready for review? [y/n]

You: y

Claude (Phase 3 — Review):
  Using pr-review-toolkit:review-pr...
  ✓ 6 specialized reviewers completed
  Found: 1 MEDIUM issue (missing rate limiting on comment creation)
  → Fix now? [y/n]

You: y

Claude:
  ✓ Added rate limiting
  ✓ Verification: all tests passing, no regressions

Claude (Phase 4 — Document):
  ✓ Updated README with comments feature docs
  ✓ Added API examples
  ✓ Session learnings captured via /wrap
  → Ready to ship? [y/n]

You: y

Claude (Ship):
  Using superpowers:finishing-a-development-branch...
  → Created PR #47: "feat: add threaded comments system"
```

---

## Key Principles

1. **Autonomous between checkpoints** — Human approval at phase transitions, not micro-decisions
2. **Constitution as law** — CONSTITUTION.md is the non-negotiable source of truth for standards
3. **Plugin-powered** — Each phase delegates to the best available plugin/skill
4. **Quality gates** — Review phase runs 6 specialized checks, verification proves claims
5. **Learning capture** — Every session improves future orchestration via /wrap

---

## Dependencies

### Required
- CONSTITUTION.md in repo root
- superpowers plugin installed
- pr-review-toolkit plugin installed
- commit-commands plugin installed
- Git repository initialized

### Optional
- .claude/agents/technical-writer.md (for Phase 4 — falls back to default behavior)
- CONSTITUTION.md Section 3 filled in with actual tech stack (not placeholders)
