# Starter Kit

A ready-to-use Claude Code configuration you can copy into any project.

## What's Included

- `.claude/CLAUDE.md` — Project config template with sensible defaults
- `.claude/commands/reflect.md` — `/reflect` command for capturing session learnings

## How to Use

1. Copy the `.claude/` folder into your project root:

   ```bash
   cp -r path/to/ai-dev-orchestrator/02-starter-kit/.claude/ /path/to/your-project/.claude/
   ```

2. Edit `.claude/CLAUDE.md` and fill in your project details (name, tech stack, conventions)

3. Install the recommended plugins — see [recommended-plugins.md](recommended-plugins.md)

4. Start Claude Code in your project:

   ```bash
   cd your-project && claude
   ```

5. Configure permissions for your risk level: ask Claude "Configure permissions for this project — it's a low risk personal project" (adjust risk level as needed)

## What's NOT Included

- **No agents** — Plugins like superpowers and pr-review-toolkit handle these roles better
- **No /orchestrate** — That's an advanced workflow; see [06-orchestrate/](../06-orchestrate/) when you're ready
- **No personal preferences** — Timezone, org-specific integrations, and personal style are yours to configure in your global `~/.claude/CLAUDE.md`
