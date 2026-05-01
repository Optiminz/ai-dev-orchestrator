# ADO Beginner Upgrade — Design

**Date:** 2026-05-02
**Status:** Implemented (v3.3.0)
**Author:** Malcolm + Claude

---

## Context

ADO has matured around the orchestrate / 5-phase / framework-heavy use case. The next user is different: a motivated non-coder with a specific small project (e.g. organising 30k photos for a small nonprofit). They have Claude Code installed but won't be writing code themselves — they need Claude Code to interview them, scope the work, and build the repo conversationally.

Recent learnings from `occb` and `occb-personal` are worth folding in, but most of that work is Malcolm-specific (OKM, Notion, 1Password, Optimi clients, handbook tree). This design picks only the parts that generalise.

## Goals

1. Add a beginner setup path that produces a clean conversation-first project repo.
2. Add a chat-assistant project-instructions template so beginners can scope their idea in Claude.ai / ChatGPT / Gemini before touching code.
3. Refresh the plugin guide to reflect plugins validated since the last update.
4. Add a soft breadcrumb pointing teams interested in a shared Claude Code harness toward Optimi.
5. Light update to the session-learnings guide.

## Non-Goals

- Promoting Malcolm-specific commands or skills (`/wrap-okm`, `/repo-health-okm`, `/handbook-gap`, `/scaffold-orchestrator`, `/persona-to-agent`, `gh-triage`, `landscape-context`, `callprep`, `nate-signal-capture`).
- Documenting OKM, Notion, 1Password, or any Optimi-internal infrastructure.
- Documenting cost-coordination across shared accounts (different concern from the harness breadcrumb).

## User Flow (Beginner)

```
1. Beginner has Claude Code installed.
2. Asks Claude Code: "clone ai-dev-orchestrator and set me up as a beginner."
3. Claude Code clones the repo, cd's in, runs ./setup.sh --beginner.
4. Script prompts for new project path + name.
5. Script creates that dir and seeds it with six items:
   - START-HERE.md  ← open this first
   - README.md
   - CONSTITUTION.md
   - CLAUDE.md  ← interview-and-build instructions
   - chat-assistant-project-instructions.md  ← paste into Claude.ai/ChatGPT/Gemini
   - notes/  (empty)
6. Beginner opens START-HERE.md. It tells them to:
   a. Paste chat-assistant-project-instructions.md into their chat assistant of
      choice and have a scoping conversation about their problem.
   b. Save useful bits of that conversation into notes/.
   c. Open the new repo in Claude Code. CLAUDE.md tells Claude to interview
      them and build the repo conversationally.
```

The script is conversation-first all the way down. Nothing pre-bakes structure that doesn't fit the user's actual project.

## Changes

### A. `setup.sh` — add `--beginner` / `--advanced` flags

- Default behaviour when no flag: interactive prompt asking which mode.
- `--advanced`: existing behaviour, preserved.
- `--beginner`:
  - Prompt for target project dir (default: `~/Projects/<name>`).
  - Refuse if dir exists and is non-empty (safety).
  - Copy templates from `02-starter-kit/beginner/` into the new dir, renaming `*.template.md` → `*.md`.
  - Initialise as a git repo (`git init`, no first commit — let the user own that).
  - Print final instructions: "Open `<path>/START-HERE.md`."

### B. New directory: `02-starter-kit/beginner/`

Templates the script copies. Each is a complete file the beginner can use as-is.

- **`START-HERE.template.md`** — orientation walkthrough. The "open this first" file. Two-step path: scope the idea in your chat assistant → open the repo in Claude Code.
- **`README.template.md`** — project README scaffold. Placeholders for project name, problem statement, current status. No tech stack assumptions.
- **`CONSTITUTION.template.md`** — generic key-structure rules. What this project is/isn't, who it's for, success criteria, what's out of scope. Conversation-friendly prompts the user fills in. No Optimi specifics.
- **`CLAUDE.template.md`** — instructions to Claude Code:
  - "Before writing any code, interview the user about their project."
  - Reference the populated CONSTITUTION.md.
  - Bias toward simplest-thing-that-works.
  - Surface scope risks early.
  - Ask before installing dependencies, picking frameworks, or making architectural calls.
- **`chat-assistant-project-instructions.template.md`** — generic Technical Delivery Advisor prompt. Aimed at chat assistants (Claude.ai, ChatGPT, Gemini), not Claude Code. Strips dash's Optimi/aihq/client-confidentiality content. Keeps: AI-systems-engineer + delivery-advisor framing, scope-questioning instinct, simplest-thing-that-works bias, propose-2-3-options pattern, cost-sketching, anti-patterns (no jargon, no terminal assumptions, no vendor energy).

### C. Plugin guide refresh — `01-learn-claude-code/essential-plugins.md`

Current "Crucial" tier (keep): superpowers, commit-commands, pr-review-toolkit.
Current "Highly Recommended" tier (keep): feature-dev, hookify.
Current "Nice to Have" tier (keep): ralph-loop, vercel, firecrawl, playground, skill-creator.

**Add to Highly Recommended:**
- **code-review** — adds `/security-review` and `/review` slash commands. Different surface from pr-review-toolkit's agent-based reviews.
- **context7** — pulls live library docs into context. Useful for non-coders who don't know which APIs are current.

**Add to Nice to Have:**
- **playwright** — browser automation for verifying UI changes actually work end-to-end.
- **supabase** + **postgres-best-practices** — for projects that touch a database.
- **frontend-design** — distinctive UI generation. Avoids the AI-slop look on user-facing work.

**Not added** (out of scope for beginners): mcp-server-dev, agent-sdk-dev, slack, github (official). Mention them in a single footnote sentence as "advanced — install when you have a specific need."

### D. `README.md` updates

**Quick Start — add a fourth path:**

> **"I have a specific small project in mind but I'm not a developer"**
> Easiest way — in Claude Code, just say: *"clone ai-dev-orchestrator and set me up as a beginner."* Claude figures out the rest. Then open the new project's `START-HERE.md`.

**New section near the bottom — shared harness breadcrumb:**

> ### Shared Claude Code config for teams
>
> Want everyone on your team using the same skills, plugins, hooks, and conventions — without each person setting it up by hand? That's what Optimi runs internally. [Get in touch](mailto:malcolm@optimi.co.nz) to learn more.

One paragraph. No deep dive into occb's mechanics.

### E. Session learnings — light update

`guides/session-learning-system.md` already exists. Light edits to reflect the validated end-of-session sweep pattern (patterns vs mistakes, grep before debugging recurring issues). Don't promote `/wrap` itself or any OKM-coupled variants. Keep it markdown-files-on-disk simple.

## Architecture / File Layout

```
ai-dev-orchestrator/
├── README.md                                      [edit]
├── setup.sh                                        [edit — add --beginner/--advanced]
├── 01-learn-claude-code/
│   └── essential-plugins.md                        [edit — refresh]
├── 02-starter-kit/
│   ├── README.md                                   [unchanged]
│   ├── recommended-plugins.md                      [unchanged]
│   └── beginner/                                   [new dir]
│       ├── START-HERE.template.md                  [new]
│       ├── README.template.md                      [new]
│       ├── CONSTITUTION.template.md                [new]
│       ├── CLAUDE.template.md                      [new]
│       └── chat-assistant-project-instructions.template.md  [new]
└── guides/
    └── session-learning-system.md                  [edit — light]
```

## Risks / Open Questions

- **Script complexity creep.** Adding flags + template-copying + git init is meaningful new logic in `setup.sh`. Keep it boring shell — no dependency on Bash 5+ features, no jq, no dynamic templating. Plain `cp` + `sed` for placeholders if needed.
- **Template drift.** Once `02-starter-kit/beginner/` templates exist, they'll go stale unless someone tests the beginner flow occasionally. Mitigation: smoke-test as part of acceptance.
- **CLAUDE.template.md tone.** Has to instruct Claude Code firmly enough that it doesn't immediately start coding, while staying readable to the human who'll see it on first open. Treat the file as having two audiences — write accordingly.
- **"Optimi for shared harness" framing.** Soft pitch, not a sales page. One paragraph, one mailto. Re-read for vendor energy before merging.

## Success Criteria

1. A beginner with Claude Code installed and a vague project idea can run one prompt (*"clone ADO and set me up as a beginner"*) and end up in a fresh project repo with a clear next step inside ten minutes.
2. The seeded `chat-assistant-project-instructions.md` reproduces the kind of conversation that happened in the Meghan-photos transcript: scope-questioning, complexity-stripping, plain language, no jargon.
3. The seeded `CLAUDE.md` causes Claude Code to interview rather than immediately scaffold.
4. Plugin guide reflects the current set of validated plugins, with the "install these three first" framing intact.
5. README has a clear beginner entry path and a soft Optimi breadcrumb for the team-harness use case.
6. None of the seeded files reference OKM, Notion, 1Password, Optimi clients, or any Malcolm-specific infra.

## Out of Scope

- Documenting how Optimi's shared harness (occb) actually works.
- Building a beginner-mode equivalent for the orchestrate workflow.
- Importing Malcolm's handbook content.
- Any change to `03-your-first-feature/`, `04-prompts/`, `05-constitutions/`, `06-orchestrate/`.
