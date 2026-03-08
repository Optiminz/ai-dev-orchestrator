# Core Concepts of Claude Code

This guide explains the key building blocks of Claude Code. Read it once after installing — it will save you a lot of confusion later.

---

### CLAUDE.md

A markdown file you create in your project root (or `.claude/CLAUDE.md`) that tells Claude about your project. Think of it as a briefing document Claude reads at the start of every session, before you type anything.

Put in it: your project description, tech stack, conventions, rules, anything Claude should always know. Example:

```
This is a Next.js app using TypeScript and Supabase.
Always use server components. Never commit .env files.
```

Claude will follow these rules without you repeating them every session.

---

### Slash Commands

Custom commands you create as markdown files in `.claude/commands/`. Think of them as saved prompts that Claude follows step-by-step when you invoke them.

Create `.claude/commands/deploy.md` with your deployment instructions, then type `/deploy` — Claude reads the file and executes the steps. Because they live in your repo, you can share commands with your team via git.

---

### Plugins

Installable packages that add capabilities to Claude Code. You install a plugin once and it works across all your projects, not just one.

Example: the `superpowers` plugin adds brainstorming, TDD, and debugging workflows to every project you open. Install plugins through Claude Code settings. Plugins are the container — skills (see below) are what they contain.

---

### Skills

Skills live inside plugins. When you install a plugin, its skills become available in every session.

The key insight most people miss: most skills fire automatically. You do not type `/brainstorming` — the superpowers plugin detects you are about to build something and activates the brainstorming skill on its own. Example: start implementing a feature and superpowers automatically activates the TDD skill, prompting you to write tests first, without you thinking about it. Some skills are manual (like `/commit`), but the majority are automatic. This automatic behavior is the main reason to use plugins rather than slash commands alone.

---

### Agents (Sub-agents)

When Claude faces a complex task, it can spawn sub-agents to handle parts of it in parallel. This is a built-in Claude Code capability — you do not configure it.

Example: ask Claude to refactor three files and it may spawn three sub-agents, each handling one file simultaneously. Sub-agents run in isolated git worktrees so their changes do not conflict. You will see them appear as separate processes in your terminal.

---

### Agent Files (.claude/agents/)

Markdown files you create to define specialized role behaviors for Claude. These are different from the sub-agents described above — agent files are custom personas you author.

Example: create `.claude/agents/technical-writer.md` describing how Claude should behave when generating documentation (tone, format, what to include). Claude selects the appropriate agent file based on the task at hand. This is optional — plugins handle most use cases without custom agent files.

---

### Hooks

Shell commands that run automatically when specific events occur in Claude Code. Think of them as triggers attached to Claude's actions.

Configure hooks in `.claude/settings.json` under the `"hooks"` key. Common uses: run a linter before every commit, validate output after a file is written, or format code on save. Hooks let you enforce project standards without relying on Claude remembering to do it.

---

### Learnings (.claude/learnings/)

Markdown files where Claude captures patterns, mistakes, and decisions from your sessions. Because they persist across sessions, Claude does not repeat the same mistakes twice on your project.

Run `/reflect` at the end of a work session to prompt Claude to write down what it learned. Over time, these files accumulate project-specific knowledge — what broke, what worked, why certain decisions were made — and Claude consults them at the start of future sessions.
