# AI-Dev-Orchestrator - Setup Guide

**Get started with AI-Dev-Orchestrator in 10 minutes.**

---

## Overview

This guide walks you through:
1. Setting up CONSTITUTION.md for a new project
2. Using your first prompt (Product Owner - PRD)
3. Following the workflow from idea to code
4. Best practices for working with AI personas

---

## Prerequisites

**You need:**
- [ ] Access to an AI assistant (Claude, ChatGPT, Gemini, etc.)
- [ ] A project idea or feature to build
- [ ] A code editor
- [ ] (Optional) Git for version control

**Skill level:** Works for beginners to experts

---

## Step 1: Create Your Project Structure

### Option A: New Project

```bash
# Create project directory
mkdir my-new-project
cd my-new-project

# Create basic structure
mkdir -p docs src tests

# Initialize git (optional but recommended)
git init
```

### Option B: Existing Project

```bash
# Just navigate to your project
cd /path/to/existing-project

# Create docs folder if it doesn't exist
mkdir -p docs
```

---

## Step 2: Set Up Your CONSTITUTION.md

This is the **most important step**. The CONSTITUTION.md file defines the rules all AI personas must follow.

### Copy the Template

```bash
# Copy from ai-dev-orchestrator template
cp /path/to/ai-dev-orchestrator/CONSTITUTION-TEMPLATE.md ./CONSTITUTION.md
```

### Customize It

Open `CONSTITUTION.md` and fill in the sections:

#### 2.1: Define Your Tech Stack

```markdown
## 2. Technical Stack (The "What")

**Frontend:**
- Framework: React 18
- Language: TypeScript (strict mode enabled)
- File extensions: .tsx for React components, .ts for utilities
- Type imports: `import type { ... }` for type-only imports
- Styling: Tailwind CSS
- State Management: Zustand

**Backend:**
- Framework: FastAPI
- Language: Python 3.11+
- API Style: REST

**Database:**
- Primary: PostgreSQL 15+
- Caching: Redis

**Infrastructure:**
- Platform: Docker
- CI/CD: GitHub Actions
```

#### 2.2: Set Coding Standards

```markdown
## 3. Coding Standards (The "How")

**Language Version:**
- TypeScript 5+ (strict mode enabled)
- Python 3.11+ with type hints

**Style Guide:**
- Airbnb JavaScript Style Guide
- PEP 8 for Python

**Linting & Formatting:**
- Linter: ESLint, Pylint
- Formatter: Prettier, Black
```

#### 2.3: Add Security Requirements

```markdown
## 4. Security & Compliance (The "Musts")

**Data Handling:**
- No PII in logs
- All secrets in environment variables

**Authentication:**
- OAuth 2.0 with JWT tokens
```

**See the full template for all sections.**

### Commit It

```bash
git add CONSTITUTION.md
git commit -m "Add project constitution"
```

---

## Step 3: Start Your First Feature (Product Owner)

### 3.1: Decide What to Build

Have a clear idea of what you want to build. Examples:
- "User password reset"
- "CSV export for customer data"
- "Dark mode toggle"

### 3.2: Get the PRD Prompt

Open `prompts/phase-1-planning/1.1-product-owner-prd.md` in the ai-dev-orchestrator folder.

Copy the entire prompt template.

### 3.3: Fill in the Prompt

Replace these placeholders:
- `[YOUR FEATURE DESCRIPTION]` - Your feature idea
- Attach your `CONSTITUTION.md` file

Example:
```markdown
You are a Product Owner. Your task is to turn my user requirements into a formal Product Requirement Document (PRD).

**Rules:**
1. You must adhere to all principles in the attached `CONSTITUTION.md` file.
2. The PRD must be in Markdown format.
...

Here is the feature I want to build:
I want users to be able to reset their passwords if they forget them. They should receive an email with a secure link that expires after 1 hour.

**Additional Context:**
- Target users: Internal employees (~200 people)
- Problem: Too many help desk tickets for password resets
- Existing features: Basic email/password login
```

### 3.4: Send to AI

Paste the filled prompt into Claude/ChatGPT/Gemini with your `CONSTITUTION.md` attached.

### 3.5: Review the PRD

The AI will generate a PRD. Check:
- [ ] User stories are clear
- [ ] Acceptance criteria are testable
- [ ] Scope is appropriate (not over-engineered)

If not perfect, ask for revisions.

### 3.6: Save the PRD

Save the AI's output to `docs/password-reset-prd.md` (use kebab-case naming).

```bash
git add docs/password-reset-prd.md
git commit -m "Add password reset PRD"
```

---

## Step 4: Create the Technical Spec (Solutions Architect)

### 4.1: Get the Tech Spec Prompt

Open `prompts/phase-1-planning/1.2-architect-tech-spec.md`.

### 4.2: Fill in the Prompt

Replace placeholders:
- Attach `CONSTITUTION.md`
- Attach `docs/password-reset-prd.md`
- Attach relevant existing code files

Example:
```markdown
You are a Solutions Architect. Your product manager has provided the attached PRD. Your task is to design the technical implementation.

**Rules:**
...

**Files Attached:**
- CONSTITUTION.md
- docs/password-reset-prd.md
- src/models/user.model.ts (existing user model)
- src/services/email.service.ts (existing email service)
```

### 4.3: Review the Tech Spec

Check:
- [ ] Architecture is sound
- [ ] Follows CONSTITUTION.md standards
- [ ] Not over-engineered
- [ ] All integration points identified

### 4.4: Save the Tech Spec

Save to `docs/password-reset-tech-spec.md`.

```bash
git add docs/password-reset-tech-spec.md
git commit -m "Add password reset tech spec"
```

**Optional:** If database or API is complex, use prompts 1.3 or 1.4.

---

## Step 5: Generate Task List

### 5.1: Get the Prompt

Open `prompts/phase-2-implementation/2.1-generate-task-list.md`.

### 5.2: Fill in the Prompt

Attach:
- `docs/password-reset-tech-spec.md`
- `CONSTITUTION.md`

### 5.3: Review the Task List

You should get a numbered list of tasks like:

```
Task 1: Create password_reset_tokens table
Task 2: Run database migration
Task 3: Create TokenGenerator utility
...
Task 17: Manual testing
```

Check that tasks are:
- [ ] Small enough (< 1 hour each)
- [ ] In logical order
- [ ] Specific about files to create/modify

### 5.4: Save the Task List

Save to `docs/password-reset-tasks.md`.

---

## Step 6: Implement Tasks (One at a Time)

**THIS IS THE MOST IMPORTANT RULE:** Implement ONE task at a time.

### 6.1: Get the Prompt

Open `prompts/phase-2-implementation/2.2-iterative-implementation.md`.

### 6.2: For Task #1, Fill in the Prompt

```markdown
You are an expert **Python/FastAPI** developer.

**Your Context:**
1. **Constitution:** (attach CONSTITUTION.md)
2. **Task List:** We are working on **Task #1** from the task list
3. **Task Description:**
   Task 1: Create password_reset_tokens table
   Description: Create the database migration...
   (paste the exact task description)
4. **Relevant Code:**
   (attach: database/schema.sql, CONSTITUTION.md)

**Your Assignment:**
1. Write the code to complete ONLY this task
2. Do NOT implement any other tasks
...
```

### 6.3: Review the Code

Check:
- [ ] Implements ONLY task #1
- [ ] Follows CONSTITUTION.md
- [ ] Includes comments
- [ ] Includes error handling

### 6.4: Test and Commit

```bash
# Copy code to your project
# Test it (run migrations, check database)

git add database/migrations/003_password_reset_tokens.sql
git commit -m "feat: create password_reset_tokens table (#1)"
```

### 6.5: Repeat for Task #2, #3, etc.

Use the same 2.2 prompt for each task. Change only the task number and description.

**Never ask AI to implement multiple tasks at once.**

---

## Step 7: Review Your Code (QA Engineer)

### 7.1: After All Tasks Complete

Use the comprehensive review prompt: `3.1-qa-comprehensive-review.md`.

Attach:
- All your new code
- `CONSTITUTION.md`

### 7.2: Fix Issues

The QA Engineer will find issues categorized by severity:
- 🔴 **CRITICAL** - Fix immediately
- 🟠 **HIGH** - Fix before merging
- 🟡 **MEDIUM** - Fix this iteration
- 🟢 **LOW** - Fix when convenient

Fix all CRITICAL and HIGH issues.

### 7.3: (Optional) Specialized Reviews

For deep dives, use:
- `3.2-qa-bugs-edge-cases.md` - Find bugs
- `3.3-qa-security-audit.md` - Security check
- `3.4-qa-style-standards.md` - Standards compliance
- `3.5-qa-testability.md` - Check if code is testable

---

## Step 8: Document (Technical Writer)

### 8.1: Generate README.md

Use prompt `4.1-readme-generator.md`.

Attach all your project files.

### 8.2: (Optional) Generate User Guide

If building an internal tool for non-technical users, use `4.2-user-guide-generator.md`.

---

## Step 9: Ship It! 🚀

```bash
# Final commit
git add .
git commit -m "docs: add README and user guide"

# Create PR (if using GitHub)
git push origin feature/password-reset
gh pr create --title "Add password reset feature" --body "..."
```

---

## Workflow Quick Reference

```
Idea
  ↓
1.1 Product Owner (PRD)
  ↓
1.2 Solutions Architect (Tech Spec)
  ↓
2.1 Generate Task List
  ↓
2.2 Implement Task #1
2.2 Implement Task #2
2.2 Implement Task #3
  ...
  ↓
3.1 QA Review
  ↓
Fix Issues
  ↓
4.1 README
  ↓
DONE
```

---

## Tips for Success

### ✅ DO:

1. **Always attach CONSTITUTION.md** to every prompt
2. **Review every AI output** before proceeding
3. **Implement one task at a time**
4. **Fix CRITICAL/HIGH issues immediately**
5. **Keep PRD and Tech Spec updated** if requirements change

### ❌ DON'T:

1. Skip the planning phase (PRD + Tech Spec)
2. Ask AI to "build the entire feature"
3. Ignore CRITICAL security issues
4. Over-engineer (remember: simplicity beats complexity)
5. Forget to test after each task

---

## Common Issues & Solutions

### Issue: "AI generated code that doesn't follow my standards"
**Solution:** Ensure CONSTITUTION.md is attached to every prompt.

### Issue: "The tech spec is too complex"
**Solution:** Update your CONSTITUTION.md to emphasize simplicity. Regenerate the tech spec.

### Issue: "AI implemented multiple tasks at once"
**Solution:** Re-run the 2.2 prompt with explicit instruction: "ONLY implement task #X."

### Issue: "I don't have time for all this planning"
**Solution:** For trivial changes, skip to Phase 2. But for non-trivial features, planning saves time by catching issues early.

---

## Next Steps

### Learn More:
- [Workflow Overview](./workflow/workflow-overview.md) - Detailed workflow explanation
- [Prompt Selection Guide](./workflow/prompt-selection-guide.md) - Which prompt to use when
- [Phase Checklist](./workflow/phase-checklist.md) - Ensure completeness

### Explore:
- [Personas](./personas/README.md) - Detailed persona descriptions
- [All Prompts](./prompts/) - Browse all 15 prompts
- [Research](./docs/research-origin.md) - The research behind this framework

---

## Get Help

**Questions or Issues?**
- Check [Workflow Overview](./workflow/workflow-overview.md)
- Check [Prompt Selection Guide](./workflow/prompt-selection-guide.md)
- Re-read the prompt templates (they include tips and examples)

**Contributing:**
- Found a better way? Share it!
- Built an example? Contribute it!

---

**Ready to start?**

Go to Step 1 and create your CONSTITUTION.md! 🚀
