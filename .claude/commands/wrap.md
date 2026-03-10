# Wrap — End-of-Session Cleanup

Run autonomous end-of-session cleanup: capture learnings, format code, commit, push, and optionally open a PR. Execute each step in order, skipping steps that don't apply.

## Prerequisites

Before running, check that the required infrastructure exists. If anything is missing, **tell the user what's needed and offer to set it up** before proceeding. Don't silently skip steps because infrastructure is absent.

**Required:**
- **Git repository** — Must be in an initialized git repo with at least one commit
- **Learnings directories** — Both global (`~/.claude/learnings/`) and project-level (`.claude/learnings/`) should exist with the expected files. If missing, create them:
  ```bash
  # Global learnings
  mkdir -p ~/.claude/learnings
  touch ~/.claude/learnings/{patterns,mistakes,preferences}.md

  # Project learnings (run from project root)
  mkdir -p .claude/learnings
  touch .claude/learnings/{insights,decisions,gotchas}.md
  ```

**Recommended (for full functionality):**
- **`session-learnings` skill** — Used in Step 1 for learning templates. Without it, use the format templates inline in this command, but recommend the user installs the skill for consistency.
- **`gh` CLI** — Required for Step 6 (PR creation). If not installed, skip PR steps and suggest: `brew install gh && gh auth login`
- **`best-practice-git` skill** — Used in Step 4 for Conventional Commits formatting. Without it, follow standard commit conventions (type: description).
- **`/sync-learnings` command** — Referenced in Step 8. Without it, skip the sync suggestion.
- **Wrap Config in CLAUDE.md** — Optional. If the project's CLAUDE.md has a `## Wrap Config` section, Step 2 uses it. Otherwise, auto-detects from `package.json`.

**Quick check:** If this is the first time running `/wrap` in a project, expect to spend a moment setting up the learnings directories. After that, subsequent runs are seamless.

## Step 1: Capture Learnings

Review the session and determine if anything genuinely novel was discovered — a pattern, mistake, preference, decision, or gotcha that a future session needs to know. The bar is high: routine work produces no learnings, and that's fine.

**Routing (global vs project):**
- **Global** (`~/.claude/learnings/`) — Patterns, Mistakes, Preferences that apply across any project
- **Project** (`.claude/learnings/`) — Insights, Decisions, Gotchas specific to this codebase

Before writing, check existing learnings files to avoid duplicates. If a similar learning exists, update it rather than adding a new entry.

**Format each learning using the templates from the session-learnings skill.** If nothing worth capturing, say so and move on.

## Step 2: Auto-Format & Local Checks

Check the project's CLAUDE.md for a `## Wrap Config` section. If present, follow its instructions. If absent, use these defaults:

1. Look for `package.json` — if it has format/lint scripts, run the auto-format command
2. Run any configured local checks (lint, type-check, format:check)
3. Report results but do NOT block on failures — note them in the commit or wrap summary

**Wrap Config format in project CLAUDE.md:**

```markdown
## Wrap Config
- **Auto-format command:** `npm run format` (or `none`)
- **Local checks:** `npm run lint`, `npm run type-check` (or `none`)
- **Skip remote CI gate:** true/false
```

If `skipRemoteCIGate` is true, proceed with push even though remote CI may fail. Local checks still run as a best-effort quality pass.

## Step 3: Update Crucial Docs

Check whether key project documents need updating based on the session's work. Look for:

1. **META-PLAN.md** (or equivalent tracking doc) — Mark completed items, update progress, adjust effort estimates
2. **CLAUDE.md / CONSTITUTION.md** — If architectural decisions or conventions changed
3. **Feature/fix docs** — If a feature was completed or a phase finished, update its status

Only update docs that are genuinely stale. Run prettier on any edited markdown files.

## Step 4: Stage & Commit

If there are uncommitted changes:

1. Run `git status` and `git diff` to understand what changed
2. Stage relevant files (be selective — no `.env`, credentials, or large binaries)
3. Create a conventional commit following best-practice-git patterns
4. The commit message should reflect the session's work, not just "wrap up"

If no changes exist, skip to Step 4.

## Step 5: Push

If on a feature branch (not main/master):

1. **Ask the user** before pushing (respect the `ask` permission on git push)
2. If approved, push with `-u` to set upstream if needed

If on main, skip push — just commit locally.

## Step 6: Open/Update PR

If on a feature branch AND push succeeded:

1. Check if a PR already exists for this branch (`gh pr view`)
2. If no PR exists, ask the user if they want one opened
3. If yes, create PR with summary of the branch's work (not just this session)

## Step 7: Rename Session

Generate a short, discoverable name for this session based on the work done. Use these sources (in priority order):

1. **Branch name** — if on a feature branch, use it as-is or lightly clean it (e.g., `feat/add-auth` → `add-auth`)
2. **Commit subjects** — distill the session's commits into a 2-4 word slug
3. **Primary topic** — fall back to the main thing worked on

**Rules:**
- Lowercase, hyphen-separated (e.g., `mlc-legal-timer`, `repo-restructure`, `fix-auth-redirect`)
- Max 40 characters
- Be specific enough to distinguish from other sessions — `update-docs` is bad, `okm-api-docs-v2` is good
- If the session was trivial (a quick question, no real work), skip this step

Apply the name:
```
/rename <generated-name>
```

## Step 8: Sync Learnings (Conditional)

Only if global learnings were captured in Step 1:

1. Briefly mention that new global learnings were added
2. Suggest running `/sync-learnings` if the user wants to propagate to other repos
3. Do NOT auto-run sync — just flag it

## Wrap Summary

After all steps, present a concise summary:

```
## Wrap Complete

**Learnings:** [captured N / nothing to capture]
**Checks:** [passed / N issues noted]
**Docs:** [updated N files / all up to date]
**Commit:** [commit hash + message / no changes]
**Push:** [pushed to origin/branch / skipped]
**PR:** [created #N / updated / skipped]
**Session:** [renamed to `<name>` / skipped]
**Sync:** [global learnings added — consider /sync-learnings]
```

## Arguments

If invoked with arguments (e.g., `/wrap just commit`), interpret the intent and run only the relevant steps.

$ARGUMENTS
