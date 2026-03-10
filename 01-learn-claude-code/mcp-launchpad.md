# MCP Launchpad (mcpl) — On-Demand MCP Tools

[MCP Launchpad](https://github.com/nichochar/mcpl) loads MCP server tools on-demand via bash commands instead of bundling them into Claude Code's system prompt. This saves thousands of tokens per session.

---

## Why It Matters

Every MCP plugin loaded in Claude Code adds its tool definitions to the system prompt. That context is sent with every message, even if you never use those tools.

**Token cost of common plugins:**

| Plugin | Tools | Tokens |
|--------|-------|--------|
| GitHub | 40 | ~2,000 |
| Pinecone | 9 | ~3,900 |
| Google Workspace | 100+ | ~15,000+ |
| **Total** | **150+** | **~21,000+** |

With mcpl, these tools are loaded only when you call them — zero token cost at rest.

---

## Install

```bash
# Install via npm
npm install -g @nichochar/mcpl

# Or via Homebrew
brew install nichochar/tap/mcpl
```

Check the [mcpl repo](https://github.com/nichochar/mcpl) for the latest install instructions.

---

## Setup

mcpl uses a config file at `~/.claude/mcpl.json` to define which MCP servers are available.

Example configuration:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    },
    "pinecone": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/pinecone-mcp"],
      "env": {
        "PINECONE_API_KEY": "${PINECONE_API_KEY}"
      }
    }
  }
}
```

Store API keys in `~/.claude/.env`:

```bash
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...
PINECONE_API_KEY=pc_...
```

---

## Usage

### Common commands

```bash
# List all tools for a server
mcpl list github

# Search across all servers
mcpl search "pull request"

# Call a tool
mcpl call github get_me '{}'

# Inspect a tool (see parameters)
mcpl inspect github list_issues

# Inspect with example
mcpl inspect github list_issues --example
```

### GitHub examples

```bash
# Your profile
mcpl call github get_me '{}'

# List issues
mcpl call github list_issues '{"owner": "Optiminz", "repo": "ai-dev-orchestrator"}'

# Search repos
mcpl call github search_repositories '{"query": "mcp-server"}'
```

### Pinecone examples

```bash
# List indexes
mcpl call pinecone list-indexes '{}'

# Search docs
mcpl call pinecone search-docs '{"query": "vector upsert"}'

# Search records
mcpl call pinecone search-records '{"index": "my-index", "query": "search text"}'
```

### Troubleshooting

```bash
# Verify all servers are working
mcpl verify

# Check daemon status
mcpl session status

# Restart daemon (fixes most issues)
mcpl session stop

# Bypass daemon for debugging
mcpl call github get_me '{}' --no-daemon
```

---

## When to Use mcpl vs Plugins

| | Plugins | mcpl |
|---|---------|------|
| **Token cost** | Always loaded (~thousands of tokens) | Zero at rest |
| **Setup** | `/install-plugin` in Claude Code | Config file + API keys |
| **Auth** | OAuth handled automatically | Manual API key setup |
| **Best for** | Tools you use every session (Notion, commit-commands) | Tools you use occasionally (GitHub, Pinecone) |

**Rule of thumb:** If you use it every session, make it a plugin. If you use it sometimes, use mcpl.

---

## Further Reading

- [mcpl GitHub repo](https://github.com/nichochar/mcpl) — Full docs, config reference, and setup guide
- [Essential Plugins](essential-plugins.md) — Plugins worth loading every session
