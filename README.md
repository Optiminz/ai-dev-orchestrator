# AI Dev Orchestrator

Learn Claude Code and build software with AI that actually works.

> Built by a non-coder pushing the limits of what's possible without a human developer at the wheel. Collaboration welcome. — MCS

---

## What This Is

A learning path from "what is Claude Code?" to fully automated AI-assisted development. Whether you're brand new to AI coding or already using Claude Code, this repo gives you structured workflows, essential plugin recommendations, and a battle-tested development framework.

---

## The Learning Path

| Step | What You'll Learn | Time |
|------|------------------|------|
| [01 — Learn Claude Code](01-learn-claude-code/) | What it is, how to install, core concepts, essential plugins | 30 min |
| [02 — Starter Kit](02-starter-kit/) | Copy a ready-made `.claude/` config into your project | 5 min |
| [03 — Your First Feature](03-your-first-feature/) | Build something real with AI assistance | 1-2 hours |
| [04 — Prompts](04-prompts/) | 15 copy-paste prompts that work with any AI tool | Reference |
| [05 — Constitutions](05-constitutions/) | Project rules that keep AI consistent and on track | 15 min |
| [06 — Orchestrate](06-orchestrate/) | Automated 5-phase workflow with `/orchestrate` + `/solve-issues` | Advanced |

---

## Quick Start

**Never used Claude Code?**
Start at [01 — Learn Claude Code](01-learn-claude-code/what-is-claude-code.md)

**Know Claude Code, want the framework?**
Grab the [02 — Starter Kit](02-starter-kit/) and jump to [04 — Prompts](04-prompts/)

**I have a specific small project in mind but I'm not a developer.**
Easiest way — in Claude Code, just say: *"clone ai-dev-orchestrator and set me up as a beginner."* Claude clones the repo, runs `./setup.sh --beginner`, and seeds you a fresh project with a conversation-first walkthrough. Then open the new project's `START-HERE.md`.

**Just want the config?**

```bash
# Clone this repo
git clone https://github.com/Optiminz/ai-dev-orchestrator.git ~/ai-dev-orchestrator

# Bootstrap into your project
~/ai-dev-orchestrator/setup.sh /path/to/your-project

# Install essential plugins in Claude Code
/install-plugin superpowers
/install-plugin commit-commands
/install-plugin pr-review-toolkit
```

---

## How This Is Different

**Without a framework:**
- AI generates code that contradicts your conventions
- No quality gates — bugs ship unreviewed
- Each session starts from zero
- You copy-paste prompts and hope for the best

**With AI Dev Orchestrator:**
- CONSTITUTION.md enforces your rules every session
- Structured phases: brainstorm → plan → build → review → document
- Human approval checkpoints between each phase
- Session learnings persist — Claude gets better at YOUR project over time
- Plugins add automatic discipline (TDD, debugging, verification)

---

## Works With Any AI Tool

The [prompts](04-prompts/) work with any AI — Claude Code, ChatGPT, Gemini, Copilot. Copy-paste them and follow the workflow.

The [starter kit](02-starter-kit/), [plugins guide](01-learn-claude-code/essential-plugins.md), and [/orchestrate](06-orchestrate/) are Claude Code specific.

---

## What's Inside

- **4 beginner guides** — Claude Code fundamentals from zero ([01-learn-claude-code/](01-learn-claude-code/))
- **MCP Launchpad guide** — Save 20k+ tokens by loading MCP tools on-demand ([01-learn-claude-code/mcp-launchpad.md](01-learn-claude-code/mcp-launchpad.md))
- **Starter kit** — Copyable `.claude/` config + plugin install guide ([02-starter-kit/](02-starter-kit/))
- **15 prompts** — Copy-paste workflows for any AI tool ([04-prompts/](04-prompts/))
- **5 personas** — Specialized AI roles: Product Owner, Architect, Developer, QA, Writer ([personas/](personas/))
- **3 constitution templates** — For internal tools, client apps, and AI agents ([05-constitutions/](05-constitutions/))
- **Automated orchestration** — `/orchestrate` command for 5-phase development ([06-orchestrate/](06-orchestrate/))
- **Issue solving** — `/solve-issues` command for autonomous issue backlog clearing ([06-orchestrate/skills/solve-issues.md](06-orchestrate/skills/solve-issues.md))

---

## Deep Dive

- [How orchestration works](docs/orchestration-integration.md) — Full integration guide
- [Session learning system](guides/session-learning-system.md) — How Claude remembers across sessions
- [Post-compaction context](guides/post-compaction-context.md) — Prevent Claude from losing context in long sessions
- [Project onboarding](guides/project-onboarding.md) — Scaling from 1 to 20 developers
- [Claude Code installation](01-learn-claude-code/installation.md) — Install and configure Claude Code
- [Research foundations](docs/research-origin.md) — Academic origins of this approach

---

## Requirements

- **Claude Code CLI** — [Install guide](01-learn-claude-code/installation.md)
- **Node.js 18+**
- **Optional:** VS Code with Claude Code extension

---

## Contributing

This framework was built by a non-developer using AI. If you're using it, improving it, or have ideas — contributions and feedback are welcome.

---

## Shared Claude Code config for teams

Want everyone on your team using the same skills, plugins, hooks, and conventions — without each person setting it up by hand? That's what [Optimi](https://optimi.co.nz) runs internally. [Get in touch](mailto:malcolm@optimi.co.nz) if you'd like to learn more.

---

## License

MIT
