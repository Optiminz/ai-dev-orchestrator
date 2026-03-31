# Phase Completion Checklist

Use these checklists to ensure you complete each phase before moving to the next.

---

## Phase 0: Explore

- [ ] Feature idea described to Claude
- [ ] `superpowers:brainstorming` skill invoked
- [ ] Requirements and constraints clarified
- [ ] 2-3 approaches proposed with trade-offs
- [ ] You approved an approach

**Ready to move on?** → Proceed to Plan

---

## Phase 1: Plan

- [ ] `superpowers:writing-plans` skill invoked
- [ ] Project standards file found (CONSTITUTION.md / CLAUDE.md / AGENTS.md)
- [ ] Implementation plan created at `docs/plans/YYYY-MM-DD-[feature]-plan.md`
- [ ] Plan includes:
  - [ ] Bite-sized tasks with exact file paths
  - [ ] Code snippets or pseudocode for each task
  - [ ] Test commands where applicable
  - [ ] Dependencies between tasks noted
- [ ] You reviewed the plan
- [ ] Tasks are small enough (each independently completable)
- [ ] Plan follows project standards

**Ready to move on?** → Proceed to Branch Setup (codebases) or Build (text repos)

---

## Phase 1.5: Branch Setup (Codebases Only)

**Skip this phase for text repos.**

- [ ] Repo detected as codebase (build tooling present)
- [ ] `superpowers:using-git-worktrees` invoked
- [ ] Feature branch created: `feat/[feature-slug]`
- [ ] Worktree confirmed ready
- [ ] All subsequent work happens on the feature branch

**Ready to move on?** → Proceed to Build

---

## Phase 2: Build

### For Each Task in the Plan:

- [ ] Task description from plan is clear
- [ ] **Codebases:** Test written first (TDD)
- [ ] Implementation follows project standards
- [ ] Task completed and working
- [ ] Changes committed with descriptive message

### Overall Build Phase:

- [ ] All tasks from the plan implemented
- [ ] **Codebases:** All tests passing
- [ ] No `console.log` or debug code left behind
- [ ] You reviewed the implementation

**All tasks done?** → Proceed to Review

---

## Phase 3: Review

### Codebases:

- [ ] Feature branch pushed to remote
- [ ] `pr-review-toolkit:review-pr` invoked
- [ ] Six specialized reviewers completed:
  - [ ] Silent failure hunter
  - [ ] Type design analyzer
  - [ ] PR test analyzer
  - [ ] Code reviewer
  - [ ] Code simplifier
  - [ ] Comment analyzer
- [ ] All CRITICAL issues fixed
- [ ] All HIGH issues fixed
- [ ] MEDIUM/LOW issues fixed or deferred (with your approval)
- [ ] `superpowers:verification-before-completion` run
- [ ] All tests still passing after fixes

### Text Repos:

- [ ] `superpowers:requesting-code-review` invoked on diff
- [ ] Issues found are fixed
- [ ] `superpowers:verification-before-completion` run

**Review complete?** → Proceed to Document

---

## Phase 4: Document

- [ ] Technical Writer agent invoked
- [ ] Documentation updated:
  - [ ] README.md updated with feature docs
  - [ ] Usage examples added
  - [ ] API endpoints documented (if applicable)
  - [ ] Troubleshooting for common issues added
- [ ] Documentation changes committed
- [ ] `/wrap` run to capture session learnings
- [ ] You reviewed the documentation

**Documentation complete?** → Proceed to Ship

---

## Ship

### Codebases:

- [ ] `superpowers:finishing-a-development-branch` invoked
- [ ] Option chosen:
  - [ ] Create PR (default for team repos)
  - [ ] Merge locally
  - [ ] Keep branch as-is
  - [ ] Discard
- [ ] Worktree cleaned up (if merged or discarded)

### Text Repos:

- [ ] All changes committed
- [ ] Pushed to main

---

## Quick Reference: "Am I Done?"

| Phase | "I'm done when..." |
|-------|-------------------|
| Phase 0 | Requirements explored and approach approved |
| Phase 1 | Plan written and approved |
| Phase 1.5 | Feature branch created in worktree (codebases only) |
| Phase 2 | All tasks implemented, tests passing |
| Phase 3 | All CRITICAL/HIGH issues fixed, verification passed |
| Phase 4 | Documentation written, session learnings captured |
| Ship | PR created / merged / pushed |

---

## See Also

- [Workflow Overview](./how-it-works.md)
- [Prompt Selection Guide](./prompt-selection-guide.md)
