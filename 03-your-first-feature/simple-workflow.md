# Simple Workflow: Your First Feature in 3 Steps

This is a simplified, beginner-friendly version of the ai-dev-orchestrator framework. Use this for your first 3-5 features before moving to the full framework.

## Prerequisites Checklist

Before starting, ensure you have:
- [ ] Copied `CONSTITUTION-TEMPLATE.md` to your project as `CONSTITUTION.md`
- [ ] Customized these 3 critical sections in your CONSTITUTION.md:
  - **Technical Stack** (frameworks, languages, tools you want to use)
  - **User Context** (who will use this: you, team, clients, public)
  - **Security Requirements** (basic auth, production-ready, compliance needs)
- [ ] Your AI assistant can reference files (@ notation in Cursor, file paths in Claude Code)

If you haven't done this yet, stop and do it now. The quality of your AI's output depends entirely on how well you define these.

---

## Step 1: Define What You Want (Create Your PRD)

### What is a PRD?

A Product Requirements Document tells the AI:
- **What** you want to build
- **Why** you're building it (the problem it solves)
- **Who** will use it
- **How** they'll use it (user stories)
- **What** "done" looks like (acceptance criteria)

### How to Create Your PRD

Copy this template and fill it in with your AI's help:

```markdown
# Feature: [Feature Name]

## Problem Statement
[What problem does this solve? 2-3 sentences]

Example: "Users currently track tasks in spreadsheets, which makes
collaboration difficult. They need a simple way to create, assign,
and track tasks as a team."

## Target Users
[Who will use this?]

Example: "Small teams (3-10 people) who need basic task management
without complexity."

## User Stories

### Core User Stories (Must Have)
As a [user type], I want to [action], so that [benefit].

Example:
- As a team member, I want to create tasks, so that I can track my work
- As a manager, I want to assign tasks, so that I can delegate effectively
- As a user, I want to mark tasks complete, so that I can show progress

### Secondary User Stories (Nice to Have)
[Optional features for later]

Example:
- As a user, I want to filter tasks by status, so that I can focus on what's next
- As a team member, I want to comment on tasks, so that I can collaborate

## Acceptance Criteria

### Functional Requirements
- [ ] Users can create a new task with title and description
- [ ] Users can assign tasks to team members
- [ ] Users can mark tasks as complete
- [ ] Users can view all tasks in a list
- [ ] [Add your specific requirements]

### Technical Requirements
- [ ] Follows tech stack defined in CONSTITUTION.md
- [ ] Mobile-responsive (if applicable)
- [ ] Data persists between sessions
- [ ] [Add your specific requirements]

### Out of Scope (Not Building Now)
- Recurring tasks
- Time tracking
- Email notifications
- [List what you explicitly won't build yet]

## Success Metrics
[How will you know this works?]

Example: "Success = 3 team members can create, assign, and complete
tasks without confusion or errors."
```

### Prompt Template for PRD Creation

Use this prompt with your AI (customize the feature description):

```
I want to build [brief feature description].

Please help me create a Product Requirements Document (PRD) following
this structure:
1. Problem Statement
2. Target Users
3. User Stories (Core and Secondary)
4. Acceptance Criteria (Functional, Technical, Out of Scope)
5. Success Metrics

Ask me clarifying questions about anything that's unclear. Reference
my CONSTITUTION.md file for technical stack and security requirements.

Keep this simple - this is my first feature. Limit to 3-5 core user
stories and 5-10 acceptance criteria.
```

### What Good Looks Like

A good PRD is:
- **Specific**: "Users can create tasks with title, description, and due date" (not "users can manage tasks")
- **Scoped**: 3-5 core user stories max for your first feature
- **Referenced**: Mentions your CONSTITUTION.md for tech stack decisions
- **Clear on "out of scope"**: Explicitly lists what you're NOT building

A bad PRD is:
- Vague: "Build a task manager" (what does that mean exactly?)
- Too big: 20 user stories (you'll never finish)
- Ignores your stack: Suggests React when your CONSTITUTION says Vue
- No boundaries: Tries to build everything

### Save Your PRD

Once the AI generates your PRD:
1. Save it in your project: `docs/prds/feature-name-prd.md`
2. Review it carefully - this is your contract with the AI
3. Get agreement: "Does this PRD look correct? Shall we proceed to planning?"

---

## Step 2: Break It Down (Generate Task List)

Now that you know WHAT to build, break it into HOW (concrete tasks).

### Prompt Template for Task Generation

```
Using the PRD we just created, generate a task list following this structure:

1. Create 5-7 parent tasks (high-level phases)
2. For each parent task, create 3-8 sub-tasks (specific implementation steps)
3. Use checkbox format: - [ ] for incomplete, - [x] for complete
4. Reference files/functions with this format: file_path:line_number

Use "interactive mode":
- Generate parent tasks first
- Show them to me
- Say "Ready for sub-tasks? Reply 'Go' to continue"
- Wait for my "Go"
- Then generate detailed sub-tasks

Make sure every sub-task is:
- Actionable (starts with a verb: Create, Implement, Test, etc.)
- Specific (includes file names and what to change)
- Small (can be completed in 5-15 minutes)
```

### What the AI Will Do

The AI will generate something like:

```
## Parent Tasks

- [ ] 1. Set up data model and database schema
- [ ] 2. Create backend API endpoints
- [ ] 3. Build frontend components
- [ ] 4. Implement business logic
- [ ] 5. Add authentication and authorization
- [ ] 6. Create tests
- [ ] 7. Final review and deployment prep

Ready for sub-tasks? Reply "Go" to continue.
```

**You respond:** "Go"

Then the AI generates:

```
## Detailed Sub-Tasks

### 1. Set up data model and database schema
- [ ] 1.1 Create `schema.sql` with tasks table (id, title, description, status, assigned_to, created_at)
- [ ] 1.2 Add foreign key relationship to users table
- [ ] 1.3 Create database migration in `migrations/001_tasks.sql`
- [ ] 1.4 Test schema creation locally

### 2. Create backend API endpoints
- [ ] 2.1 Create `api/tasks/route.ts` with GET /api/tasks endpoint
- [ ] 2.2 Add POST /api/tasks endpoint for task creation
- [ ] 2.3 Add PATCH /api/tasks/[id] endpoint for updates
- [ ] 2.4 Add DELETE /api/tasks/[id] endpoint
- [ ] 2.5 Test all endpoints with sample data

[... continues for all parent tasks ...]
```

### Why Interactive Mode?

Interactive mode (showing parent tasks first, then sub-tasks) helps you:
1. **Validate the approach** before diving into details
2. **Catch missing pieces** early ("Wait, we forgot authentication!")
3. **Stay oriented** - you always know which phase you're in
4. **Prevent overwhelm** - 7 parent tasks are easier to grasp than 40 sub-tasks at once

---

## Step 3: Build Iteratively (Implement the Tasks)

Now you have a checklist. Time to build, one sub-task at a time.

### The Core Implementation Loop

Use this pattern for EVERY sub-task:

```
You: "Implement sub-task 1.1: Create schema.sql with tasks table"

AI: [Creates the file with the schema]

AI: "I've created schema.sql with the tasks table including id, title,
description, status, assigned_to, and created_at columns. The status
field uses an enum with values 'todo', 'in-progress', and 'done'."

AI: "Marking sub-task 1.1 as complete."

AI: [Updates the task list to show]:
- [x] 1.1 Create `schema.sql` with tasks table
- [ ] 1.2 Add foreign key relationship to users table

AI: "Ready for sub-task 1.2?"

You: "Yes, go ahead"

[Repeat for each sub-task]
```

### Critical Rules for Implementation

**Rule 1: One sub-task at a time**
- NEVER let the AI implement multiple sub-tasks without your approval
- Prompt: "Implement ONLY sub-task 1.1. Stop and wait for my approval before moving to 1.2."

**Rule 2: Mark complete immediately**
- The AI must mark each sub-task `[x]` right after finishing it
- Prompt: "After completing each sub-task, mark it with [x] and show me the updated list."

**Rule 3: Test frequently**
- After every 2-3 sub-tasks, run your application
- Prompt: "Before moving to sub-task 2.1, let's test what we've built so far."

**Rule 4: Reference your CONSTITUTION**
- Every implementation decision should follow your CONSTITUTION.md
- Prompt: "Make sure this follows the coding standards in CONSTITUTION.md"

### When Things Go Wrong

**Problem:** The AI built too much at once
```
You: "Stop. You just implemented 5 sub-tasks without asking. Let's
back up. Show me what you changed."
```

**Problem:** A sub-task failed or has bugs
```
You: "Sub-task 1.3 failed with this error: [paste error]. Fix this
before marking it complete or moving to 1.4."
```

**Problem:** The code doesn't match your tech stack
```
You: "You used React but my CONSTITUTION.md specifies Vue. Redo sub-task
2.1 using Vue components."
```

**Problem:** You realize the approach is wrong
```
You: "Hold on. Looking at sub-tasks 3.1-3.4, I think we should use a
different pattern. Let's revise the sub-tasks for parent task 3 before
implementing."
```

### Staying in Control

Remember: You're the pilot, the AI is the co-pilot.

**Good prompts (you're in control):**
- "Implement sub-task 2.1 only. Stop when done."
- "Before you start 3.1, explain your approach."
- "Show me the changes you'll make before implementing 4.2."
- "This doesn't look right. Walk me through what you did in 2.3."

**Bad prompts (AI runs ahead):**
- "Build everything in parent task 2" (too big)
- "Just finish it" (no oversight)
- "Do whatever you think is best" (ignores your Constitution)

### Completion Checklist

Before marking your feature "done", verify:

- [ ] All sub-tasks are marked `[x]` complete
- [ ] The application runs without errors
- [ ] You've tested all the core user stories from your PRD
- [ ] Code follows the standards in your CONSTITUTION.md
- [ ] You understand what was built (no "magic" code)

---

## After Your First Feature

Congratulations! 🎉 You just built something with AI-driven development.

### What You Learned

- **PRD first** - Define before building
- **Task breakdown** - Big features = small sub-tasks
- **Iterative implementation** - One piece at a time
- **Stay in control** - You direct, AI executes

### Next Steps

**After 2-3 features with this simple workflow:**

1. **Add quality control** - Learn `/prompts/phase-3-review/3.1-qa-comprehensive-review.md`
2. **Get technical design** - Learn `/prompts/phase-1-planning/1.2-architect-tech-spec.md`
3. **Document better** - Learn `/prompts/phase-4-documentation/4.1-readme-generator.md`

**After 5-7 features:**

4. **Graduate to the full framework** - Use all 5 personas, specialized reviews, and advanced workflows
5. **Customize personas** - Adapt prompts to your specific needs
6. **Build complex systems** - Multi-service architectures, API designs, etc.

### Moving to Standard Flow

When you're ready for the standard 8-file workflow:
1. Read `/workflow/workflow-overview.md`
2. Use `/workflow/prompt-selection-guide.md` to choose the right prompts
3. Learn the 5 personas in `/personas/`

### Moving to Full Framework

When you're building production systems:
1. Read the main `README.md` completely
2. Study all 15+ specialized prompts
3. Implement full review processes (QA, Security, Performance)
4. Use database and API design workflows

---

## Quick Reference

### The 3-Step Process

1. **Define (PRD)**
   - Problem statement
   - User stories (3-5 core)
   - Acceptance criteria (5-10)
   - Out of scope

2. **Break Down (Tasks)**
   - 5-7 parent tasks
   - 3-8 sub-tasks each
   - Checkbox format
   - Interactive mode (parent first, then sub-tasks)

3. **Build (Iterative)**
   - One sub-task at a time
   - Mark complete `[x]` immediately
   - Test frequently
   - Reference CONSTITUTION.md

### Essential Prompts

**Starting PRD:**
```
I want to build [feature]. Help me create a simple PRD with problem
statement, user stories, and acceptance criteria. Reference my
CONSTITUTION.md for tech stack. Keep it focused - this is my first feature.
```

**Generating tasks:**
```
Using this PRD, generate a task list with 5-7 parent tasks. Use
interactive mode: show me parent tasks first, wait for "Go", then
generate sub-tasks.
```

**Implementing:**
```
Implement sub-task [X.X] only. Mark it [x] when complete and show me
the updated task list. Wait for my approval before moving to the next one.
```

---

You're ready to build! Open your AI assistant and try your first feature. 🚀
