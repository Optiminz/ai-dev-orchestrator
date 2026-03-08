# Installing Claude Code

## Prerequisites

Before installing, confirm you have the following.

**Node.js 18 or higher:**

```bash
node --version
# Expected output: v18.x.x or higher
```

If Node.js is not installed or is outdated, download it from [nodejs.org](https://nodejs.org).

**An Anthropic account** — choose one of:

- **Claude Pro or Max subscription** (easiest) — no API key required, authenticate via browser
- **Anthropic API key** with credits — generate one at [console.anthropic.com](https://console.anthropic.com)

---

## Install the Claude Code CLI

Run this command in your terminal:

```bash
npm install -g @anthropic-ai/claude-code
```

Verify the installation:

```bash
claude --version
# Expected output: a version number, e.g. 1.x.x
```

---

## First Run

1. Navigate to a project directory:

   ```bash
   cd your-project
   ```

2. Start Claude Code:

   ```bash
   claude
   ```

3. On first run, Claude will prompt you to authenticate. You have two options:

   - **Browser login** — Claude opens a browser tab where you log in with your Anthropic account. Recommended for Pro/Max subscribers.
   - **API key** — Paste your API key when prompted.

4. Once authenticated, you are in an active conversation with Claude about your project.

---

## Verify It Works

Try asking Claude to read a file in your project:

```
Read my README and summarize it
```

Claude should read the file and return a summary. If it does, you are ready to use Claude Code.

---

## Editor Setup (VS Code and Cursor)

Claude Code is available as an editor extension, giving you the full experience inside your IDE.

**Cursor** and **VS Code** use the same extension (Cursor is built on VS Code).

1. Open the Extensions panel in your editor.
2. Search for **Claude Code**.
3. Install the extension published by Anthropic.
4. Open the Claude Code panel via the sidebar icon, or use:
   - **Cmd+Shift+P** (Mac) / **Ctrl+Shift+P** (Windows/Linux)
   - Type `Claude Code` and select the panel command
5. Complete the same authentication process as above.

---

## Terminal Quick Reference

| Action | Command |
|--------|---------|
| Start a session | `claude` |
| See available commands | `/help` |
| Cancel a running action | `Ctrl+C` |
| End the session | `exit` or `Ctrl+D` |

Always run `claude` from inside your project directory — Claude uses the current directory as context for your project.
