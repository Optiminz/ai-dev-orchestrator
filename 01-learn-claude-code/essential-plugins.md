# Essential Plugins

Plugins are installed once and work across every project you open. This guide covers which ones to install first and why they matter.

---

## How to Install Plugins

1. Open Claude Code and run:

   ```
   /install-plugin plugin-name
   ```

   Or go to **Settings → Plugins** inside the Claude Code interface and search by name.

2. Plugins install globally — you do not need to re-install them per project.

3. Once installed, their skills activate automatically. No further setup required.

---

## Crucial Plugins — Install These First

### superpowers

The most important plugin. Without it, Claude writes code when you ask it to. With it, Claude thinks before building, plans before implementing, tests before shipping, and verifies before claiming it is done.

Superpowers adds discipline to the workflow: brainstorming before creative work, TDD before implementation, structured debugging when things break, and verification before calling a task complete. Most of its skills fire automatically based on what you are doing — you do not invoke them manually.

```
/install-plugin superpowers
```

### commit-commands

Adds two slash commands: `/commit` and `/commit-push-pr`. Both follow the [Conventional Commits](https://www.conventionalcommits.org/) format automatically — `feat:`, `fix:`, `docs:`, `chore:`, etc. Your git history stays clean and consistent without any effort.

```
/install-plugin commit-commands
```

### pr-review-toolkit

Adds six specialized code review agents that each focus on a specific angle:

- `silent-failure-hunter` — catches errors that fail silently instead of throwing
- `type-design-analyzer` — reviews your TypeScript types and data structures
- `pr-test-analyzer` — checks test coverage and quality
- `code-reviewer` — general correctness and logic review
- `code-simplifier` — identifies unnecessary complexity
- `comment-analyzer` — reviews code comments for accuracy and usefulness

A single general review pass misses things. Running six focused passes does not.

```
/install-plugin pr-review-toolkit
```

---

## Highly Recommended

### feature-dev

Guides feature development by having Claude deeply read and understand your architecture before writing a single line. Useful for larger features where context matters — Claude will not write code that ignores how your project is structured.

```
/install-plugin feature-dev
```

### hookify

Creates Claude Code hooks to prevent bad patterns project-wide. Examples: never commit `.env` files, always run tests before committing, format code after every file write. Hooks enforce standards without relying on Claude remembering to apply them.

```
/install-plugin hookify
```

---

## Nice to Have

| Plugin | What it adds |
|--------|-------------|
| `ralph-loop` | Iterative implementation loops for complex multi-step tasks |
| `vercel` | Deploy to Vercel directly from Claude Code |
| `firecrawl` | Web scraping and research from within your session |
| `playground` | Creates interactive HTML explorers for visual experimentation |
| `skill-creator` | Guides you through writing your own custom skills |

---

## Key Skills from Superpowers

You do not invoke most of these manually. Superpowers detects context and fires the relevant skill automatically.

### Workflow — how you approach work

| Skill | When it fires | What it does |
|-------|--------------|--------------|
| brainstorming | Before any creative or building work | Explores requirements, proposes approaches, gets your approval before coding starts |
| writing-plans | When you have specs or requirements | Turns designs into numbered step-by-step implementation plans |
| executing-plans | When you have a written plan | Executes plans with review checkpoints between each task |

### Implementation — how you build

| Skill | When it fires | What it does |
|-------|--------------|--------------|
| test-driven-development | Before writing implementation code | Prompts you to write tests first, then implement — prevents "it works on my machine" |
| subagent-driven-development | When executing plans with independent tasks | Dispatches sub-agents to implement tasks with built-in review at each step |
| dispatching-parallel-agents | When facing two or more independent tasks | Launches agents in parallel across git worktrees — true parallel development |

### Quality — how you verify

| Skill | When it fires | What it does |
|-------|--------------|--------------|
| verification-before-completion | Before claiming work is done | Forces Claude to run tests and show evidence before declaring "done" |
| systematic-debugging | When hitting a bug or test failure | Structured root-cause analysis — hypothesis, evidence, fix — instead of guess-and-check |
| requesting-code-review | After completing a feature | Structured review pass before merging |
| receiving-code-review | When processing review feedback | Prevents blindly implementing suggestions without critical evaluation |

### Git — how you ship

| Skill | When it fires | What it does |
|-------|--------------|--------------|
| using-git-worktrees | Starting isolated feature work | Creates isolated worktrees so parallel branches do not conflict |
| finishing-a-development-branch | When implementation is done and tests pass | Guides the merge vs PR vs cleanup decision |

### Session — how you finish

| Skill | When it fires | What it does |
|-------|--------------|--------------|
| wrap | At the end of a work session | Captures learnings, cleans up, and produces a session summary — the clean way to finish |

---

## The Key Insight

You do not manually invoke most of these skills. Superpowers detects what you are doing — starting a feature, hitting a bug, wrapping up a task — and fires the right skill automatically.

Install the plugin and your AI coding workflow gets disciplined guardrails without you thinking about it. That is the whole point: the discipline is built in, not bolted on.

---

## Optional MCP Servers

MCP servers are separate from plugins — they provide tools via the Model Context Protocol. These are not required but can improve specific parts of the workflow.

### context7

Fetches **current documentation** for libraries, frameworks, and SDKs on demand. Claude's training data may not reflect recent API changes — Context7 pulls the latest docs so implementation code uses current syntax and patterns.

**When it helps:**
- Phase 2 (Build) when implementing code that uses external libraries
- Any time you're integrating a third-party API, SDK, or framework
- Version migrations — checking what changed between library versions

**When it doesn't help:**
- Planning, brainstorming, or review phases (no library docs needed)
- Pure business logic with no external dependencies
- Documentation writing

Claude will use Context7 naturally during implementation when it's available — you don't need to tell it to. Just having it installed is enough.

**Setup:** Add to your Claude Code MCP config. See [context7.com](https://context7.com) for installation.

### sequential-thinking

Provides a structured step-by-step reasoning tool for complex decisions. Instead of Claude reasoning internally and jumping to a conclusion, each step is explicit and revisable.

**When it helps:**
- Phase 0 (Explore) when requirements are ambiguous or there are 3+ valid approaches
- Phase 1 (Plan) when task dependencies are complex or ordering is non-obvious
- Phase 3 (Review) when review findings conflict or severity judgments are unclear
- Any decision where the first intuitive answer might be wrong

**When it doesn't help:**
- Straightforward implementation tasks
- Simple file edits or lookups
- Tasks where the path is already clear

**Setup:** Add to your Claude Code MCP config. Available as `@anthropic/sequential-thinking` or similar community packages.

---

## Saving Tokens with MCP Launchpad

Every plugin loaded in Claude Code adds its tool definitions to the system prompt — even when you don't use them. If you're running GitHub, Pinecone, or Google Workspace as plugins, that's 20,000+ tokens of overhead per message.

[MCP Launchpad (mcpl)](mcp-launchpad.md) lets you call those tools on-demand from the terminal instead. Zero token cost at rest, full functionality when you need it.

**Rule of thumb:** If you use it every session, keep it as a plugin. If you use it sometimes, switch to mcpl.
