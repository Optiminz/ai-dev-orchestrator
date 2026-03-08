# What Is Claude Code?

Claude Code is Anthropic's command-line tool for AI-assisted coding. You run it in your terminal (or inside VS Code or Cursor) and it works directly inside your project — reading your files, writing code, running commands, and managing git.

Think of it as an AI developer sitting next to you, with full access to your codebase.

---

## How It's Different from ChatGPT

With ChatGPT, you paste code into a chat window, read the response, then manually copy it back into your editor. Back and forth, every time.

Claude Code lives inside your project. It can:

- Read any file in your codebase
- Edit files directly — you see a diff of what changed
- Run terminal commands (`npm install`, `git commit`, `pytest`, etc.)
- Search across your entire project for patterns or references

No copy-pasting. Claude makes the changes; you review them.

---

## How It's Different from Cursor

Cursor is an IDE with AI built in — autocomplete on steroids, plus inline chat for editing specific lines or blocks.

Claude Code is a pair programmer. You describe an outcome, it plans and builds the whole thing.

- **Cursor:** "complete this function for me"
- **Claude Code:** "add user authentication with email/password — include the routes, database schema, and tests"

Claude Code also has a VS Code and Cursor extension, so you can run it inside those editors if you prefer not to use the terminal directly.

The key difference: Cursor suggests code line by line. Claude Code can design and implement entire features.

---

## The Mental Shift

This is the most important part.

You are not writing code. You are directing an AI developer.

That means:

- Describe **outcomes**, not instructions. Say "add user authentication", not "create a file called auth.js with a function that..."
- **Review and approve** rather than type every line
- Think of yourself as the architect or product manager. Claude is the developer.

You still need to understand what's being built — but you spend your time on decisions, not syntax.

---

## What Claude Code Can Do

- Read and understand your entire codebase
- Write new files and edit existing ones
- Run terminal commands (install packages, run tests, build)
- Search code across your project
- Manage git (commit, create branches, push)
- Browse the web for documentation (with plugins)
- Carry context between sessions using a learnings system
- Spawn sub-agents to handle complex multi-step tasks in parallel

---

## What's Next

- **Install Claude Code** — see `02-installation.md`
- **Your first session** — see `03-first-session.md`
