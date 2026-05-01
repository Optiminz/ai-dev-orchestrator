# Start Here

Welcome. This repo is your project workspace. You don't need to know how to code to use it — you just need to be able to describe what you're trying to do.

There are two steps before you start building.

---

## Step 1 — Scope your idea in a chat assistant

Before opening this repo in Claude Code, have a real conversation about what you're trying to build. Use whichever AI chat you're already comfortable with — Claude.ai, ChatGPT, or Gemini all work.

1. Open a new chat in your assistant of choice.
2. Open `chat-assistant-project-instructions.md` in this folder. Copy the entire file.
3. Paste it as the **first message** in your chat. (In Claude.ai or ChatGPT you can also paste it into the "custom instructions" or "project instructions" field — that way it sticks for the whole conversation.)
4. Then describe your project in plain language. Example: *"I want to organise about 30,000 photos for a small nonprofit so volunteers can find pictures of specific events."*

The assistant will ask you questions, push back on scope, and help you figure out the simplest thing that could actually solve your problem. **Let it.** That's the whole point.

When something useful comes out of the conversation — a decision, a constraint, a list of requirements, a sketch of how it might work — paste it into a new file in `notes/`. Name the files however you like (`scope.md`, `users.md`, `things-it-must-do.md`).

You're done with this step when you can answer, in plain language:

- What problem am I solving?
- Who's it for?
- What's the smallest version that would be useful?
- What's explicitly out of scope?

---

## Step 2 — Open this repo in Claude Code

Now you're ready to build.

1. Open Claude Code in this folder. (In your terminal: `cd` into this folder, then run `claude`. Or open the folder in VS Code with the Claude Code extension.)
2. Tell Claude: *"I just set this up. Read the notes folder and the constitution, then interview me before writing anything."*

Claude has been told (in `CLAUDE.md`) to interview you about your project before generating code. It will ask about your goals, constraints, and what success looks like, and then propose a plan. **Don't let it skip ahead and start coding.** If it does, say "stop, ask me more questions first."

When the plan feels right, Claude will start building — one small piece at a time, showing you what it changed and why.

---

## What's in this folder

| File | What it is |
|---|---|
| `START-HERE.md` | This file. |
| `README.md` | Public-facing description of your project. Fill in as you learn what you're building. |
| `CONSTITUTION.md` | The non-negotiable rules of the project — what it is, who it's for, what's out of scope. Updated as decisions are made. |
| `CLAUDE.md` | Instructions to Claude Code about how to work on this project. You can read it; you don't need to edit it (Claude will). |
| `chat-assistant-project-instructions.md` | The prompt you paste into Claude.ai/ChatGPT/Gemini in Step 1. |
| `notes/` | Anything useful from your scoping conversations. |

---

## If you get stuck

- **Claude wants to start coding before you've scoped the problem.** Say "stop, ask me more questions first."
- **You don't understand a word it just used.** Say "explain that without jargon."
- **It's suggesting something that feels like overkill.** Say "what's the simplest version of this?"
- **You're not sure what to do next.** Ask Claude: "given where we are, what's the next decision I need to make?"

You are the product owner. Claude is your developer. Your job is to make decisions and review what gets built. Their job is to ask good questions and write the code.
