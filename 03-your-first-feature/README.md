# 🚀 Quick Start Guide

New to AI-driven development? Start here!

## Your Journey

### Day 1: Hello World (You are here)
- 3 files only
- Build your first feature in 2-3 hours
- Learn the core workflow

### Week 1: Standard Flow
- Add specialized personas
- Learn review processes
- Implement with confidence

### Month 1: Full Framework
- Master all 5 personas
- Use specialized reviews
- Build production-ready apps

## The Simple 3-Step Process

1. **Define** what you want (PRD)
2. **Break down** into tasks
3. **Build** iteratively

Ready? Let's start with your first feature...

## Getting Started

### Prerequisites

Before you begin, you need:
1. **An AI coding assistant** - Choose one:
   - [Cursor IDE](https://cursor.sh) (Recommended for beginners)
   - [Claude Code](https://code.claude.com) (CLI-based)
   - [Replit AI](https://replit.com) (Browser-based, instant deployment)
   - Any AI that can reference files (ChatGPT with code interpreter, etc.)

2. **Your project's Constitution** - This defines how the AI should build:
   - Copy `CONSTITUTION-TEMPLATE.md` from the root to your project
   - Rename it to `CONSTITUTION.md`
   - Customize these 3 critical settings:
     - **Tech stack** (what frameworks/languages to use)
     - **User type** (who will use this: just you, team, clients)
     - **Security level** (internal tool, public app, regulated industry)

### Your First Feature (2-3 hours)

Follow these three prompts in order:

#### Step 1: Define What You Want (30 minutes)
Use `simple-workflow.md` - it combines PRD creation with planning

**Example prompt:**
```
I want to build a task tracker for my team. Follow simple-workflow.md
to help me create a PRD and plan it out.
```

#### Step 2: Break Into Tasks (30 minutes)
Use `process-task-list.md` - it creates a checkbox task list

**Example prompt:**
```
Using the PRD we just created, generate a task list following
process-task-list.md. Use interactive mode.
```

The AI will:
- Generate 5-7 high-level parent tasks
- Ask "Ready for sub-tasks? Reply 'Go' to continue"
- Wait for your "Go"
- Generate detailed sub-tasks for each parent

#### Step 3: Build Iteratively (1-2 hours)
Work through the task list, one sub-task at a time:

**Example workflow:**
```
AI: "I've generated 6 parent tasks with 23 sub-tasks. Ready to start?"
You: "Yes, let's begin with the first sub-task"
AI: [Implements first sub-task, marks it complete with [x]]
AI: "Sub-task 1.1 complete. Shall I continue to 1.2?"
You: "Go"
AI: [Continues through sub-tasks]
```

**Key principle:** The AI marks each sub-task complete `[x]` immediately after finishing it. This keeps progress visible and prevents re-work.

## What You'll Build

By the end of your first feature, you'll have:
- ✅ A working feature (not perfect, but functional)
- ✅ Clear requirements documented (your PRD)
- ✅ A completed task list showing what was built
- ✅ Confidence in the AI development workflow

## Next Steps

After building 2-3 features with Quick Start:

### Ready for Quality Control?
Add reviews to catch bugs before you ship:
- Start with `/prompts/phase-3-review/3.1-qa-comprehensive-review.md`
- Run after each feature before deploying

### Building Something Complex?
Get technical design first:
- Use `/prompts/phase-1-planning/1.2-architect-tech-spec.md`
- Run before starting implementation

### Want Better Documentation?
Generate README files automatically:
- Use `/prompts/phase-4-documentation/4.1-readme-generator.md`
- Run after completing a feature

### Ready for the Full Framework?
Head back to the main [README.md](../README.md) to learn about:
- All 5 specialized personas
- Advanced review processes
- Database and API design workflows
- Complex system architecture

## Common Pitfalls (and How to Avoid Them)

### "The AI keeps regenerating tasks instead of doing them"
**Fix:** Be explicit: "Stop planning. Start implementing sub-task 1.1 now."

### "I don't know if something is done"
**Fix:** Require checkbox completion: "Mark each sub-task [x] when complete."

### "The AI builds everything at once"
**Fix:** One at a time: "Implement ONLY sub-task 1.1. Wait for my approval before 1.2."

### "The code doesn't match my tech stack"
**Fix:** Your CONSTITUTION.md isn't clear. Specify exact versions: "Next.js 14, Supabase, Tailwind CSS 3"

## Tips for Success

1. **Start small** - Your first feature should take 2-3 hours max
2. **One task at a time** - Don't let the AI run ahead
3. **Test frequently** - Run your app after every 2-3 sub-tasks
4. **Customize your Constitution** - Generic settings = generic code
5. **Save your PRDs** - You'll reference them later

## Example First Features

Good starter features (2-3 hours each):
- ✅ User authentication (login/logout)
- ✅ Simple CRUD (create, read, update, delete items)
- ✅ Basic form with validation
- ✅ Data display with filtering
- ✅ File upload and storage

Avoid for your first feature:
- ❌ Real-time chat (too complex)
- ❌ Payment processing (too risky)
- ❌ Multi-tenant systems (too architectural)
- ❌ AI integrations (too many moving parts)

## You're Ready!

Open `simple-workflow.md` and start building. Remember:
1. Define (PRD)
2. Break down (tasks)
3. Build (iteratively)

You've got this! 🎉

---

**Need help?** Open an issue on the [ai-dev-orchestrator repository](https://github.com/mdshearer/ai-dev-orchestrator/issues)

**Want to go deeper?** Check out the [main README](../README.md) for the full framework
