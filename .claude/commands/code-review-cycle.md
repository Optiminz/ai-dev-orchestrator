# Code Review Cycle: Audit → Triage → Fix → Verify

Automate a 4-phase code review workflow with human approval checkpoints at every stage.

---

## What This Does

The `/code-review-cycle` command audits an existing codebase, creates prioritised GitHub issues, works through fixes in priority order, and runs a deep verification pass — pausing for your approval between each phase.

---

## Prerequisites

- `pr-review-toolkit` plugin installed (audit agents)
- `superpowers` plugin installed (verification)
- `commit-commands` plugin installed (git workflow)
- GitHub repo with issues enabled
- CONSTITUTION.md in repo root (coding standards reference)

---

## Your Task

Execute the full review cycle, following the phases below with human approval between each. Work autonomously within phases — only pause at the checkpoints marked **→ Ask user**.

---

## Arguments

```
/code-review-cycle              # Full cycle from Phase 0
/code-review-cycle --phase fix  # Skip audit, work existing open GitHub issues
/code-review-cycle --phase deep # Skip to Phase 3 deep review only
/code-review-cycle --priority P1,P2  # Phase 2: fix only specified priorities
```

---

## Phase 0: Audit

Run all review agents **in parallel** using the Agent tool:

- `pr-review-toolkit:code-reviewer` — bugs, logic errors, security, code quality
- `pr-review-toolkit:silent-failure-hunter` — silent failures, swallowed errors, bad fallbacks
- `pr-review-toolkit:type-design-analyzer` — type safety, invariants, encapsulation
- `feature-dev:code-reviewer` — deeper analysis: architecture, patterns, dependencies

Consolidate all findings. De-duplicate overlapping issues. Assign a priority to each finding:

| Priority | Criteria |
|----------|----------|
| P1 | Bugs, security issues, data loss, broken functionality |
| P2 | Performance problems, incorrect logic, bad error handling |
| P3 | Code quality, consistency, maintainability |
| P4 | Accessibility, minor refactors, style |
| P5 | Deep design concerns, architectural improvements, nice-to-haves |

Show a summary table of all findings with their assigned priorities.

**→ Ask user:** "Found N issues (X P1, Y P2, Z P3 ...). Create as GitHub issues and proceed to triage? [y/n]"

---

## Phase 1: Triage

Create a GitHub issue for each finding using `gh issue create`:

- Title: `[P{n}] <concise description>`
- Body: finding detail, affected file(s) with line references, recommended fix
- Labels: `p1`, `p2`, `p3`, `p4`, or `p5` (create labels if they don't exist)

Show a summary: "Created N issues: #X, #Y, #Z ..."

**→ Ask user:** "Issues created. Start fixing P1s first? [y/n]"

---

## Phase 2: Fix Cycle

Work through issues **in priority order** — all P1s first, then P2s, P3s, P4s.

For each priority group:
1. Read the GitHub issues for that priority
2. Fix each issue. Follow CONSTITUTION.md standards throughout.
3. Reference the issue number in code comments where helpful
4. After all issues in the group are fixed, run: `npm run lint && npm run typecheck && npm run test`
5. Commit the group: `fix: P{n} fixes — <brief summary>` with `Resolves #X, #Y, #Z` in body
6. Close resolved issues via `gh issue close`

**→ Ask user after each priority group:** "P{n} complete ({n} issues fixed, committed). Continue to P{n+1}? [y/n/stop]"

If user says `stop`, skip remaining priorities and go to Phase 3.

---

## Phase 3: Deep Review

Invoke `superpowers:code-reviewer` for a holistic pass over everything changed.

Focus areas:
- Did any fixes introduce regressions?
- Are there patterns across the fixes that suggest a deeper structural issue?
- Anything critical missed in Phase 0?

Then run `superpowers:verification-before-completion`:
- All tests passing (`npm run test`)
- No type errors (`npm run typecheck`)
- No lint errors (`npm run lint`)
- Build succeeds (`npm run build`)

**→ Ask user:** "Deep review complete. Any remaining issues to fix before wrapping up? [y/n]"

If yes, fix them, commit, and re-run verification.

---

## Wrap Up

1. Update CHANGELOG.md with a summary of what was fixed (group by priority)
2. Run `/wrap` to capture session learnings
3. Show final summary: issues created, issues resolved, commits made

**→ Ask user:** "Cycle complete. Create a PR? [y/n]"

If yes, invoke `superpowers:finishing-a-development-branch`.

---

## User Interaction Points

You pause for approval at these checkpoints only:

1. After audit: "Found N issues. Create as GitHub issues?"
2. After triage: "Issues created. Start fixing?"
3. After each priority group: "P{n} complete. Continue to P{n+1}?"
4. After deep review: "Any remaining issues?"
5. At wrap up: "Create a PR?"

Between checkpoints, work autonomously. Do not ask about individual fixes.

---

## Key Principles

1. **Priority discipline** — Never skip a P1 to work a P3. Severity order is non-negotiable.
2. **Issue-driven** — Every fix traces to a GitHub issue. No untracked changes.
3. **Test after each group** — Don't batch commits across priority groups without verifying.
4. **Constitution as law** — CONSTITUTION.md governs all fixes, not personal preference.
5. **Checkpoint, don't micromanage** — Human approves phases, not individual file edits.
