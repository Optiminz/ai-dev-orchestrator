# Project Learnings

What we've discovered while working on this project — patterns, gotchas, and notable observations.

---

## 2025-05-01: Session Learning System Created
- Created a self-improving learning system for Claude Code
- Global learnings at `~/.claude/learnings/` apply across all repos
- Project learnings at `.claude/learnings/` are repo-specific
- `/reflect` command triggers comprehensive session review

---

## 2026-04-07: Commands in this repo drift from global versions
- This repo is the *origin* of `/reflect`, `/wrap`, `/orchestrate`, etc. but the global copies at `~/.claude/commands/` evolve independently during daily use
- `/repo-health` Check 13 (skills coverage) caught that CLAUDE.md's slash command list was incomplete, but didn't catch command content drift
- `/skill-scan` surfaced `reflect.md` referencing the deprecated 3-file learnings structure and `wrap.md` missing the audit log step
- **Prevention:** When running `/repo-health` on this repo, also diff `.claude/commands/*.md` against `~/.claude/commands/*.md` to catch content drift
- **Tracked:** Optiminz/ai-dev-orchestrator#8

---

<!-- New learnings will be appended below -->

## 2026-05-02: Default to PR for non-trivial work, not commit-then-offer-PR

While implementing the beginner-upgrade spec, I committed and pushed each chunk straight to `main` and only opened a PR after Malcolm flagged it. Per his rules ("Malcolm authorizes direct pushes to `main` for trivial cleanup commits — non-trivial work still goes through a PR"), feature work should branch + PR by default. The fix path (revert on main + cherry-pick to branch + PR) worked but was avoidable noise in the history.

**Prevention:** For anything that's not whitespace/.gitignore/untracking-deleted-files, branch first. Ask only when it's borderline.

---

## 2026-05-02: Reverted commits get silently dropped during rebase/cherry-pick — use --allow-empty

When cleaning up a direct-to-main mistake by reverting on main and trying to put the original commits on a feature branch, both `git rebase main` and plain `git cherry-pick` will silently drop those commits because their changes are already accounted for in the base (the revert undid them, then they'd be re-applied as no-ops, and git skips no-ops by default). Result: the branch ends up empty relative to main and `gh pr create` fails with "No commits between main and <branch>".

**Fix:** `git cherry-pick --allow-empty <commit-range>` keeps each commit even when the diff resolves to nothing locally — and because the branch starts from main *after* the revert, the cherry-picked changes do produce real diffs, just ones git is too clever about by default.

**When this comes up:** any time you revert + try to recover the original commits onto a branch.

---
