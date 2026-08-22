---
name: repo-health
description: "Cross-repo health check — audits the current repo against Optimi's standards for structure, documentation, and hygiene. Run from any repo with /repo-health. Checks CLAUDE.md quality, index files, learnings depth, duplication, stale TODOs, env docs, dependency freshness, GH issue inventory, and secrets. Produces a pass/fail report with actionable fixes. Trigger on 'repo health', 'repo audit', 'repo check', 'health check', or '/repo-health'."
---

# Repo Health Check

Audits the current repo against Optimi's standards and produces a pass/fail report.

## Trigger

**Primary:** `/repo-health`
**Secondary:** `repo health`, `repo audit`, `repo check`, `health check`

---

## STEP 1: CLASSIFY THE REPO

Determine the repo type from the working directory. This controls which checks apply.

| Type | Indicators | Example repos |
|------|-----------|---------------|
| **content** | No `package.json`, mostly `.md` files | oai |
| **code** | Has `package.json` or `pyproject.toml` | oi-app, OKM, ai-outreach |
| **config** | Skills, prompts, agent definitions | dash |
| **hybrid** | Mix of code and significant content | ai-sales-workflow |

If unclear, default to **code**.

---

## STEP 2: RUN CHECKS

Run all applicable checks in parallel where possible. Each check produces one of:
- **PASS** — meets standard
- **WARN** — functional but could be better
- **FAIL** — missing or broken, needs action

### Check 1: CLAUDE.md exists, is current, and isn't bloated (all repos)

1. Read `CLAUDE.md` in repo root
2. Verify it contains:
   - Repo description (what this repo is)
   - Repo structure table or overview
   - Any repo-specific overrides to global defaults
3. Check `Last Updated` date — WARN if older than 60 days from today
4. **Bloat check** — estimate token count (rough: word count × 1.3):
   - Count instructions that restate default model behaviour (e.g. "use descriptive variable names", "handle errors gracefully") — the model already does these
   - Look for contradictory instructions (same topic, conflicting guidance)
   - Look for redundant/duplicate paragraphs within the file itself
   - Check for over-specific formatting rules or prompt-engineering scaffolding that newer models don't need

**FAIL** if: no CLAUDE.md, or it has no repo description.
**WARN** if: missing structure overview, stale date, estimated tokens >3000, or contradictory/redundant instructions found.
**FAIL** if: estimated tokens >5000 — CLAUDE.md is actively degrading output quality. Recommend a prune pass.

**Report the estimate even on PASS** — a number nobody is told is indistinguishable from a check that never ran. Note that this file is only part of a session's opening prefix (skills, MCP tool schemas and the system prompt make up the rest), and the whole prefix is billed at cache-*write* rate on each new session — roughly 20× what a cache hit costs. For the full picture, run `/doctor`.

When bloat is flagged, suggest: *"Run: 'Update my CLAUDE.md to remove anything that's no longer needed, contradictory, duplicate, or unnecessary bloat impacting effectiveness.'"*

### Check 2: Index file exists (all repos)

Look for `_index.md`, `README.md`, or equivalent at repo root.

**FAIL** if: no index/readme at all.
**WARN** if: index exists but hasn't been updated in 90+ days (check git blame).

### Check 3: CLAUDE.md / constitution / subagent deduplication (repos with agents)

1. Check if repo has any of: `.claude/constitution.md`, `constitution.md`, agent/persona definitions (glob for `**/persona*.md`, `**/subagent*.md`, `**/agent*.md`)
2. If found, read CLAUDE.md and each agent/constitution file
3. Look for duplicated content blocks — same paragraph or instruction appearing in multiple files
4. Flag any instruction that appears in both CLAUDE.md and constitution/subagents

**FAIL** if: significant duplicated instruction blocks (3+ lines repeated verbatim).
**WARN** if: overlapping intent (same idea phrased differently in multiple places).
**PASS** if: no agent files, or clean separation of concerns.

### Check 4: Learnings directory (all repos)

Check for `.claude/learnings/` with at least one file.

**WARN** if: directory missing or empty. Not a FAIL — repo may be new.

### Check 5: Stale TODOs/FIXMEs (code repos only)

1. Grep for `TODO`, `FIXME`, `HACK`, `XXX` across all source files
2. For each, check git blame date
3. Flag any older than 30 days

**WARN** if: stale TODOs found. List them with file, line, age.
**PASS** if: none found or all recent.

### Check 6: Environment documentation (code repos only)

1. Check if `.env`, `.env.local`, or `.env.example` exists
2. If `.env*` exists (other than `.env.example`), verify `.env.example` or env docs also exist
3. Check `.gitignore` includes `.env*.local`

**FAIL** if: `.env` files exist but no `.env.example` and no env docs in CLAUDE.md/README.
**WARN** if: `.gitignore` doesn't cover env files.

### Check 7: Dependency freshness (code repos only)

1. Read `package.json` (or equivalent)
2. Don't run `npm outdated` — too slow and noisy
3. Instead, flag known sunset/deprecated packages from this list:
   - `@vercel/postgres` (use `@neondatabase/serverless`)
   - `@vercel/kv` (use `@upstash/redis`)
   - AI SDK v5 patterns (`generateObject`, `streamObject`, `parameters` in tools)
   - Any package with `deprecated` in its npm description (if easily checkable)

**WARN** if: known deprecated packages found.

### Check 8: Secrets in shell history (all repos — runs once per machine)

1. Search `~/.zsh_history` and `~/.bash_history` for patterns:
   - API keys: `api[_-]?key`, `api[_-]?secret`
   - OpenAI: `sk-[a-zA-Z0-9]{20,}`
   - GitHub PATs: `ghp_[a-zA-Z0-9]{30,}`, `gho_[a-zA-Z0-9]{30,}`
   - Slack tokens: `xoxb-`, `xoxp-`
   - AWS keys: `AKIA[0-9A-Z]{16}`
   - Bearer tokens: `bearer [a-zA-Z0-9]{20,}` (in commands, not docs)
   - Explicit key headers: `-H '.*key:.*'` patterns in curl commands
   - Export statements: `export.*(KEY|SECRET|TOKEN|API)=`
2. Also search for secrets committed in the **current repo**:
   - `git log -p --all -S 'sk-' -S 'xoxb-' -S 'AKIA' -- '*.env' '*.json' '*.yaml' '*.yml' '*.toml'` (limit to 20 results)
   - Grep tracked files (excluding `node_modules`, `.git`, lockfiles) for the same patterns
3. Exclude lines that only reference env vars (e.g., `echo $API_KEY`) — only flag literal key values

**FAIL** if: literal secrets found in history or committed to repo.
**WARN** if: suspicious patterns found but may be false positives.
**PASS** if: no secrets detected.

When reporting, **redact keys** — show only the first 8 and last 4 characters (e.g., `NTcxMWQ3...Y2M4OQ`). Never print full secrets in the report.

**Offer to fix:**
- Remove offending lines from shell history (back up first)
- List which keys need rotation
- If committed to repo, recommend `git filter-repo` or BFG Repo-Cleaner and flag that force-push will be needed (confirm with user)

### Check 9: Orphaned files (content repos only)

1. Find `.md` files not modified in 60+ days (use `git log`)
2. Cross-reference against index files and CLAUDE.md
3. Flag files that aren't referenced anywhere and haven't been touched

**WARN** if: orphaned files found. List them.
**PASS** if: all files referenced or recently active.

### Check 10: GitHub issue inventory (code and hybrid repos)

1. Run `gh issue list --state open --limit 50` to get all open issues
2. For each issue, note creation date and calculate age in days
3. Classify:
   - **Active** — created or updated within last 30 days
   - **Stale** — no update in 30+ days
   - **Abandoned** — no update in 90+ days

Report summary: total open, active, stale, abandoned. Don't list every issue — just the counts and any abandoned ones by title.

This is a **read-only inventory** — don't triage, close, or modify issues. The purpose is awareness.

**WARN** if: any abandoned issues (90+ days).
**PASS** if: all issues active or stale, or no issues exist.

### Check 11: Learnings depth review (all repos with learnings)

Go beyond existence — review the actual content of `.claude/learnings/` files:

1. Read all learnings files
2. For each learning entry, classify as:
   - **Informational** — context, decisions, gotchas — no action needed
   - **Actionable** — implies outstanding work (something to fix, add, change, enforce) that hasn't been tracked
   - **Stale** — references files, patterns, or tools that no longer exist or have changed
   - **Enforced** — already tracked via a GH issue or hookify rule (has `**Tracked:**` annotation)

3. For **actionable** learnings without a `**Tracked:**` annotation:
   - Determine routing: Is this an AI/dev task (GH issue) or a Malcolm task (Notion)?
   - Create the appropriate tracking item
   - Update the learning entry to include `**Tracked:** <link>`

4. For **stale** learnings:
   - Verify staleness (grep for referenced files/functions)
   - Flag for removal or update

**Report format:**
```
Learnings: N total entries
- Informational: N
- Actionable (untracked): N — [list briefly]
- Stale: N — [list briefly]
- Enforced: N
```

**FAIL** if: actionable learnings sitting untracked for 30+ days.
**WARN** if: stale learnings found.
**PASS** if: all learnings are informational or properly tracked.

### Check 12: Verification setup (code and hybrid repos)

Boris Cherney (Claude Code creator): "Give Claude a way to verify its work — it will 2-3x the quality of the final result."

1. Check if CLAUDE.md mentions any verification mechanism:
   - Test commands (`npm test`, `pytest`, `vitest`, etc.)
   - Linting/type-checking commands
   - Browser testing or preview URLs
   - Any explicit "how to verify" section
2. Check if `package.json` has `test`, `lint`, or `typecheck` scripts defined
3. Check for test directories (`__tests__/`, `tests/`, `test/`, `*.test.*`, `*.spec.*`)

**FAIL** if: code repo with no tests, no test scripts, and no verification guidance in CLAUDE.md.
**WARN** if: test infrastructure exists but CLAUDE.md doesn't mention how to verify work.
**PASS** if: CLAUDE.md documents verification steps, or test/lint scripts are present and discoverable.

### Check 13: Skills coverage (config and hybrid repos)

Check whether repetitive workflows have been captured as reusable skills.

1. Look for `.claude/skills/` or `skills/` directories
2. If skills exist:
   - Check for orphaned skills — skill files that aren't referenced in any CLAUDE.md, slash command list, or skill index
   - Check for skills with no `description` in frontmatter (undiscoverable)
3. If no skills directory exists and repo type is config or hybrid:
   - WARN — suggest running `/skill-scan` to identify candidates

**WARN** if: orphaned or undescribed skills found, or config repo has no skills directory.
**PASS** if: skills are present, described, and referenced — or repo type doesn't warrant skills.

---

## STEP 3: PRODUCE REPORT

Format the report as a table:

```
## Repo Health Report: {repo-name}
Type: {content|code|config|hybrid}
Date: {today}

| # | Check | Status | Detail |
|---|-------|--------|--------|
| 1 | CLAUDE.md | PASS/WARN/FAIL | ... |
| 2 | Index file | PASS/WARN/FAIL | ... |
| ... | ... | ... | ... |

### Summary
- X passed, Y warnings, Z failures

### Recommended Actions
1. [Most important fix first]
2. ...
```

Order recommended actions by:
1. FAILs first (blocking issues)
2. WARNs that are quick to fix
3. WARNs that need more thought

---

## STEP 4: OFFER TO FIX

After presenting the report, ask:

> "Want me to fix any of these? I can handle [list quick fixes] right now."

Quick fixes (do without asking further):
- Create empty `.claude/learnings/` directory
- Add `.env*.local` to `.gitignore`
- Create skeleton `.env.example` from existing `.env`

Larger fixes (confirm approach first):
- Rewriting CLAUDE.md
- Deduplicating constitution/subagent content
- Removing orphaned files

---

## STEP 5: LOG THE RESULT

After the report is presented, append a summary to the global health log at `~/.claude/repo-health-log/`.

**This directory is NOT auto-loaded into context.** It exists only as a historical record, read on demand.

### Log structure

One file per repo: `~/.claude/repo-health-log/{repo-name}.md`

Each run appends an entry (do not overwrite previous entries):

```markdown
## {date}

| # | Check | Status |
|---|-------|--------|
| 1 | CLAUDE.md | PASS/WARN/FAIL |
| 2 | Index file | PASS/WARN/FAIL |
| ... | ... | ... |

**Summary:** X pass, Y warn, Z fail
**Actions taken:** [list any fixes applied, or "none"]
**Delta from last run:** [improved/regressed/unchanged — compare to previous entry if one exists]
```

### Using the log

- When running `/repo-health`, check if a previous log entry exists for this repo. If it does, include a **Delta** line in the report comparing current vs last run (e.g. "Check 1 improved WARN→PASS, Check 5 regressed PASS→WARN").
- The log enables tracking health trends across runs without polluting context on every conversation start.
- To review all repo health history: read `~/.claude/repo-health-log/` directly.

---

## NOTES

- This skill runs against the **current working directory** only. To audit multiple repos, run it from each.
- Don't fetch from remote or run install commands. Work with what's on disk.
- The check list is defined here as the canonical source. If standards evolve, update this file.

---

## Quality bar

- A check that already computes a quantity **reports it**; a check that doesn't must not invent one to look thorough. A bare PASS is acceptable only where the standard is genuinely boolean.
- A PASS means the standard was measured and met. A check that couldn't run is **SKIP with a reason**, never PASS by omission.
- Findings are proposals. Nothing outside the report is changed without approval — Step 4's quick-fix / confirm-first split is the boundary, and anything not on the quick-fix list needs an explicit go-ahead.
- A new check needs a real incident behind it. A diagnostic that emits advice nobody acts on stops being read, and then it has stopped being a check.
- The run is logged. An audit that leaves no trail can't produce a delta next time, which is most of its value.
