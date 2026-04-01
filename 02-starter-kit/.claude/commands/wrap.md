# Wrap — End-of-Session Cleanup

Run autonomous end-of-session cleanup: capture learnings, format code, commit, push, and optionally open a PR. Execute each step in order, skipping steps that don't apply.

## Prerequisites

Before running, check that the required infrastructure exists. If anything is missing, **create it** before proceeding.

**Required:**
- **Git repository** — Must be in an initialized git repo with at least one commit
- **Learnings directories** — If missing, create them:
  ```bash
  mkdir -p ~/.claude/learnings
  touch ~/.claude/learnings/{patterns,mistakes}.md
  mkdir -p .claude/learnings
  touch .claude/learnings/learnings.md
  ```

**Recommended:**
- **`gh` CLI** — Required for Step 7 (PR creation). If not installed, skip PR steps.
- **`best-practice-git` skill** — Used in Step 5 for Conventional Commits formatting.
- **Wrap Config in CLAUDE.md** — Optional. If the project's CLAUDE.md has a `## Wrap Config` section, Step 3 uses it. Otherwise, auto-detects from build tooling.

## Step 0: Detect Repo Type

Determine the repo type before proceeding. This affects formatting, push, and PR steps.

| Signal | Classification |
|--------|---------------|
| Has `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`, or `Makefile` with build/test targets | **Codebase** |
| No build tooling detected | **Text repo** |

Also note the current branch — `main`/`master` vs feature branch. This determines push and PR behaviour later.

## Step 1: Capture Learnings

Review the session and determine if anything genuinely novel was discovered. The bar is high: routine work produces no learnings, and that's fine.

**Routing:**
- **Global** (`~/.claude/learnings/`) — `patterns.md` (things that worked), `mistakes.md` (things to avoid). Use if it applies across projects.
- **Project** (`.claude/learnings/learnings.md`) — gotchas, decisions, discoveries specific to this repo.
- **User preferences** go in auto-memory, not learnings files.

Before writing, check existing files to avoid duplicates. Update existing entries rather than adding new ones.

**Format:** Use the templates from the session-learnings skill. If nothing worth capturing, say so and move on.

### Step 1b: Classify & Escalate Learnings

After capturing, classify each learning (new and existing) as one of:

| Type | Definition | Action |
|------|-----------|--------|
| **Informational** | Context, decisions, gotchas — no further work needed | Keep in learnings file |
| **Actionable** | Implies outstanding work: something to fix, add, change, or enforce | Create a GH issue |

**For actionable learnings:**
1. Create a GitHub issue (`gh issue create --repo <org>/<repo>`) with:
   - Title: the action needed (not the learning description)
   - Body: link back to the learning entry, context, and acceptance criteria
   - Label: `security`, `tech-debt`, `dx`, or `enhancement` as appropriate
2. Update the learning entry to include `**Tracked:** <org>/<repo>#<number>`
3. This prevents learnings from silently accumulating without follow-through

## Step 2: Update Crucial Docs

Check whether key project documents need updating based on the session's work. Look for:

1. **META-PLAN.md** (or equivalent tracking doc) — Mark completed items, update progress, adjust effort estimates
2. **CLAUDE.md / CONSTITUTION.md** — If architectural decisions or conventions changed
3. **Feature/fix docs** — If a feature was completed or a phase finished, update its status

Only update docs that are genuinely stale.

## Step 3: Auto-Format & Local Checks

Check the project's CLAUDE.md for a `## Wrap Config` section. If present, follow its instructions. If absent, auto-detect:

**Codebases — detect and run the appropriate formatter/linter:**

| Tooling | Format command | Check command |
|---------|---------------|---------------|
| `package.json` (with scripts) | `npm run format` (if exists) | `npm run lint` (if exists) |
| `Cargo.toml` | `cargo fmt` | `cargo clippy` |
| `go.mod` | `gofmt -w .` | `go vet ./...` |
| `pyproject.toml` | `ruff format .` (if ruff) | `ruff check .` (if ruff) |

**Text repos:** Skip this step entirely.

Report results but do NOT block on failures — note them in the commit or wrap summary.

**Wrap Config format in project CLAUDE.md:**

```markdown
## Wrap Config
- **Auto-format command:** `npm run format` (or `none`)
- **Local checks:** `npm run lint`, `npm run type-check` (or `none`)
- **Skip remote CI gate:** true/false
```

If `skipRemoteCIGate` is true, proceed with push even though remote CI may fail.

## Step 4: Stage & Commit

If there are uncommitted changes:

1. Run `git status` and `git diff` to understand what changed
2. Stage relevant files (be selective — no `.env`, credentials, or large binaries)
3. Create a conventional commit following best-practice-git patterns
4. The commit message should reflect the session's work, not just "wrap up"

If no changes exist, skip to Step 5.

## Step 5: Push

Push logic depends on repo type and branch:

| Repo type | Branch | Action |
|-----------|--------|--------|
| **Codebase** | feature branch | Ask user, then push with `-u` |
| **Codebase** | main/master | **Do not push** — ask user to confirm if they really want to push directly to main |
| **Text repo** | main | Ask user, then push |
| **Text repo** | feature branch | Ask user, then push with `-u` |

Always ask before pushing. Respect the user's permission settings on git push.

## Step 6: Open/Update PR

**Codebases on feature branches only.** Skip for text repos and main branch work.

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

## Wrap Summary

After all steps, present a concise summary:

```
## Wrap Complete

**Learnings:** [captured N / nothing to capture]
**Issues:** [created N from actionable learnings / none needed]
**Docs:** [updated N files / all up to date]
**Checks:** [passed / N issues noted / skipped (text repo)]
**Commit:** [commit hash + message / no changes]
**Push:** [pushed to origin/branch / skipped]
**PR:** [created #N / updated / skipped]
**Session:** [renamed to `<name>` / skipped]
```

## Orchestrate Context

If wrap is being called from `/orchestrate` Phase 4:
- Learnings are more likely (full dev session) — lower the "is this novel?" bar slightly
- Branch context is already established by orchestrate's Phase 1.5
- Push and PR may be handled by orchestrate's Ship phase — if so, skip Steps 5-6 and note "deferred to orchestrate Ship" in the summary

## Arguments

If invoked with arguments (e.g., `/wrap just commit`), interpret the intent and run only the relevant steps.

$ARGUMENTS
