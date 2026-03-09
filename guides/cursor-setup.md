# Cursor IDE Setup Guide for AI-Dev-Orchestrator

[Cursor](https://cursor.sh) is an AI-powered IDE built on VSCode. It's recommended for beginners because of its intuitive interface and powerful AI integration.

## Installation

1. **Download Cursor**
   - Visit [cursor.sh](https://cursor.sh)
   - Download for your platform (Mac, Windows, Linux)
   - Install and launch

2. **Import VSCode Settings (Optional)**
   - Cursor will prompt you to import your VSCode settings
   - Recommended: Import extensions, keybindings, and settings

3. **Configure AI Model**
   - Open Settings (Cmd/Ctrl + ,)
   - Search for "Cursor"
   - Choose your preferred AI model:
     - **Claude Sonnet** (Recommended for most tasks - balanced speed/quality)
     - **Claude Opus** (Best quality, slower, use for complex features)
     - **GPT-4** (Alternative option)

## Project Setup

### For Quick Start (Beginners)

If you're just starting with ai-dev-orchestrator, set up the minimal framework:

1. **Create your project structure**:
   ```bash
   mkdir my-project
   cd my-project
   git init
   ```

2. **Add the Quick Start framework**:
   ```bash
   mkdir -p ai-framework/03-your-first-feature

   # Copy from ai-dev-orchestrator
   cp /path/to/ai-dev-orchestrator/03-your-first-feature/* ./ai-framework/03-your-first-feature/
   cp /path/to/ai-dev-orchestrator/05-constitutions/CONSTITUTION-TEMPLATE.md ./ai-framework/
   ```

3. **Customize your Constitution**:
   ```bash
   cp ai-framework/CONSTITUTION-TEMPLATE.md CONSTITUTION.md
   # Edit CONSTITUTION.md with your project details
   ```

4. **Open in Cursor**:
   ```bash
   cursor .
   ```

### For Standard Flow (Intermediate)

If you're ready for the 8-file core workflow:

1. **Copy core prompts**:
   ```bash
   mkdir -p ai-framework/04-prompts
   cp -r /path/to/ai-dev-orchestrator/04-prompts/phase-1-planning ./ai-framework/04-prompts/
   cp -r /path/to/ai-dev-orchestrator/04-prompts/phase-2-implementation ./ai-framework/04-prompts/
   cp -r /path/to/ai-dev-orchestrator/04-prompts/phase-3-review ./ai-framework/04-prompts/
   ```

2. **Copy personas**:
   ```bash
   mkdir -p ai-framework/personas
   cp /path/to/ai-dev-orchestrator/personas/product-owner.md ./ai-framework/personas/
   cp /path/to/ai-dev-orchestrator/personas/solutions-architect.md ./ai-framework/personas/
   cp /path/to/ai-dev-orchestrator/personas/qa-engineer.md ./ai-framework/personas/
   ```

3. **Add your Constitution**:
   ```bash
   cp ai-framework/CONSTITUTION-TEMPLATE.md CONSTITUTION.md
   ```

### For Full Framework (Advanced)

If you need all features for production systems:

1. **Copy entire framework**:
   ```bash
   mkdir -p ai-framework
   cp -r /path/to/ai-dev-orchestrator/* ./ai-framework/
   ```

2. **Customize**:
   ```bash
   cp ai-framework/CONSTITUTION-TEMPLATE.md CONSTITUTION.md
   # Edit CONSTITUTION.md extensively
   ```

## Using Cursor with AI-Dev-Orchestrator

### The @ Notation (Essential)

Cursor uses `@` to reference files in the AI chat. This is critical for ai-dev-orchestrator:

**Examples:**

```
@CONSTITUTION.md I want to build a user authentication feature.
Help me create a PRD following @ai-framework/03-your-first-feature/simple-workflow.md
```

```
Using @CONSTITUTION.md and @ai-framework/04-prompts/phase-1-planning/1.2-architect-tech-spec.md,
create a technical specification for the task management feature described in @docs/prds/tasks-prd.md
```

```
Follow @ai-framework/03-your-first-feature/process-task-list.md to generate a task list for
the feature in @docs/prds/user-profile-prd.md
```

### Recommended Workflows in Cursor

#### Workflow 1: Quick Start (Your First Feature)

1. **Create PRD**:
   ```
   Cmd+L to open chat

   I want to build [describe feature]. Reference @CONSTITUTION.md and
   @ai-framework/03-your-first-feature/simple-workflow.md to help me create a PRD.
   ```

2. **Generate Task List**:
   ```
   Using the PRD we just created and @ai-framework/03-your-first-feature/process-task-list.md,
   generate a task list. Use interactive mode.
   ```

3. **Implement Tasks**:
   ```
   Implement sub-task 1.1 only. Mark it [x] when complete.
   Reference @CONSTITUTION.md for coding standards.
   ```

#### Workflow 2: Standard (With Tech Spec)

1. **Create PRD**:
   ```
   @ai-framework/04-prompts/phase-1-planning/1.1-product-owner-prd.md
   @CONSTITUTION.md

   Help me create a PRD for [feature description]
   ```

2. **Create Tech Spec**:
   ```
   @ai-framework/04-prompts/phase-1-planning/1.2-architect-tech-spec.md
   @CONSTITUTION.md
   @docs/prds/[feature-name]-prd.md

   Create a technical specification for this PRD
   ```

3. **Generate Tasks**:
   ```
   @ai-framework/04-prompts/phase-2-implementation/2.1-generate-task-list.md
   @docs/[feature-name]-tech-spec.md
   @CONSTITUTION.md

   Generate a task list. Use interactive mode.
   ```

4. **Implement**:
   ```
   @ai-framework/04-prompts/phase-2-implementation/2.2-iterative-implementation.md
   @docs/[feature-name]-tasks.md
   @CONSTITUTION.md

   Implement task #1
   ```

5. **Review**:
   ```
   @ai-framework/04-prompts/phase-3-review/3.1-qa-comprehensive-review.md
   @CONSTITUTION.md

   Review the [feature name] feature we just implemented
   ```

## Cursor-Specific Tips

### 1. Use Composer Mode for Large Edits

For implementing complex tasks:
- Press `Cmd+I` (Mac) or `Ctrl+I` (Windows/Linux)
- This opens "Composer" - a mode for multi-file edits
- Reference your task list and CONSTITUTION
- The AI can edit multiple files in one session

**Example:**
```
Cmd+I

@ai-framework/03-your-first-feature/process-task-list.md
@docs/tasks.md
@CONSTITUTION.md

Implement sub-tasks 2.1 through 2.3 which involve creating
the API endpoints. Update the task list as you complete each one.
```

### 2. Use CMD+K for Quick Edits

For small, focused changes:
- Highlight code
- Press `Cmd+K` (Mac) or `Ctrl+K` (Windows/Linux)
- Ask for specific changes

**Example:**
```
Highlight a function

Cmd+K

Refactor this to follow the error handling pattern in @CONSTITUTION.md
```

### 3. Use Chat History

Cursor remembers your chat history per project:
- Reference previous conversations
- Continue from where you left off
- Review what the AI suggested earlier

### 4. Configure Rules (Optional)

Create a `.cursorrules` file in your project root for custom instructions:

```bash
# .cursorrules

# Always reference the project constitution
When writing code, always follow the standards in CONSTITUTION.md

# Task-based development
When implementing features:
1. Reference the task list in docs/[feature]-tasks.md
2. Implement one task at a time
3. Mark tasks complete [x] immediately
4. Ask before moving to the next task

# Code quality
- Add JSDoc comments for all functions
- Include error handling for all API calls
- Write tests for business logic
- Use TypeScript strict mode

# File references
When creating file paths in responses, always use the format: file_path:line_number
```

### 5. Budget Management

If you're on Cursor Pro or using your own API keys:

**For PRD/Planning** (complex reasoning):
- Use Claude Opus or GPT-4
- More expensive but better quality

**For Implementation** (following clear instructions):
- Use Claude Sonnet
- Faster and cheaper, still high quality

**For Simple Edits**:
- Use Claude Haiku (if available)
- Very fast and cheap for straightforward changes

Set this in Settings → Cursor → Model Selection

## Best Practices for Cursor + AI-Dev-Orchestrator

### DO:

✅ **Always reference CONSTITUTION.md** - Cursor needs context for every request
✅ **Use @ for file references** - `@filename.md` instead of describing the file
✅ **Keep chat context focused** - Start new chat for new features
✅ **Verify AI's changes** - Review code before accepting edits
✅ **Use Cmd+L for planning** - Use Cmd+I for implementation
✅ **Save prompts** - Copy useful prompts to a `prompts.md` file in your project

### DON'T:

❌ **Don't skip the Constitution** - The AI needs your project context
❌ **Don't let AI run ahead** - Approve each task before the next
❌ **Don't accept without reading** - Always review generated code
❌ **Don't mix features in one chat** - Keep conversations focused
❌ **Don't forget to commit** - Commit after completing each parent task

## Keyboard Shortcuts (Essential)

| Shortcut | Action | When to Use |
|----------|--------|-------------|
| `Cmd/Ctrl + L` | Open AI Chat | Planning, questions, PRD creation |
| `Cmd/Ctrl + I` | Open Composer | Multi-file implementation |
| `Cmd/Ctrl + K` | Inline Edit | Quick changes to highlighted code |
| `Cmd/Ctrl + Shift + P` | Command Palette | Access Cursor features |
| `@ + filename` | Reference File | Include file context in chat |

## Example: Complete Feature in Cursor

Here's a full example of building a feature from start to finish:

### 1. Start New Feature (Cmd+L)
```
@CONSTITUTION.md
@ai-framework/03-your-first-feature/simple-workflow.md

I want to build a user profile page where users can:
- View their profile information
- Edit their name and email
- Upload a profile picture

Help me create a PRD.
```

### 2. Generate Task List (Same Chat)
```
Great! Now using @ai-framework/03-your-first-feature/process-task-list.md,
generate a task list for this feature. Use interactive mode.
```

### 3. Review Parent Tasks
```
AI: "I've generated 5 parent tasks. Ready for sub-tasks? Reply 'Go'"

You: Go
```

### 4. Implement First Task (Cmd+I)
```
@CONSTITUTION.md
@docs/user-profile-tasks.md

Implement sub-task 1.1: Create user_profiles table in schema.sql

Mark it complete when done.
```

### 5. Continue Through Tasks
```
Sub-task 1.1 complete. Ready for 1.2?

You: Yes

[Repeat for all sub-tasks]
```

### 6. Review Feature (New Chat - Cmd+L)
```
@ai-framework/04-prompts/phase-3-review/3.1-qa-comprehensive-review.md
@CONSTITUTION.md
@src/components/UserProfile.tsx
@src/api/routes/profile.ts

Review the user profile feature for bugs and security issues.
```

## Troubleshooting

### Issue: "AI doesn't follow my tech stack"
**Fix:** Make sure you're always referencing `@CONSTITUTION.md` in your prompts

### Issue: "AI generates too much code at once"
**Fix:** Be explicit: "Implement ONLY sub-task 1.1. Stop when complete."

### Issue: "Chat context gets too long"
**Fix:** Start a new chat (Cmd+L). Reference the task list file instead of pasting history.

### Issue: "AI suggests wrong file paths"
**Fix:** Show the AI your project structure: `@src/ @docs/ @tests/` then ask again

### Issue: "Code doesn't match CONSTITUTION.md standards"
**Fix:** After generation, ask: "Review this code against @CONSTITUTION.md and fix any violations"

## Additional Resources

- [Cursor Documentation](https://cursor.sh/docs)
- [Cursor Discord Community](https://discord.gg/cursor)
- [AI-Dev-Orchestrator Main README](../README.md)
- [Quick Start Guide](../03-your-first-feature/README.md)

## Next Steps

1. **Install Cursor** from [cursor.sh](https://cursor.sh)
2. **Set up your project** with Quick Start files
3. **Customize CONSTITUTION.md** for your project
4. **Try your first feature** using the Quick Start workflow
5. **Join the community** - Share your experience!

---

**Ready to build?** Open Cursor and start with the [Quick Start Guide](../03-your-first-feature/README.md)! 🚀
