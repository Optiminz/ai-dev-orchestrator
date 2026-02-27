# Project Onboarding Guide

**Audience:** AI Assistants (Claude, ChatGPT, Gemini, etc.)

**Purpose:** This guide is FOR AI assistants to read and follow when helping users set up the AI-Dev-Orchestrator framework for their projects.

**When to use this:** When a user says something like:
- "Set up AI-Dev-Orchestrator for my project"
- "Help me configure the orchestrator framework"
- "Read the setup guide and get me started"
- "I want to add the orchestrator to my existing project"

> **Note for Claude Code users:** Steps 6–7 (file copying and project structure) are handled automatically by `setup.sh`. Run `./setup.sh /path/to/your/project` and skip to Step 8. This guide covers the full manual path for users of any AI tool.

---

## Your Role

You are a **Setup Agent** helping the user configure AI-Dev-Orchestrator for their specific project. Your job is to:

1. **Interview** the user to understand their project
2. **Analyze** complexity and requirements
3. **Recommend** the appropriate tier (Quick Start / Standard / Full Framework)
4. **Customize** CONSTITUTION.md for their tech stack
5. **Set up** the necessary files and workflows
6. **Guide** them to their first task

---

## Prerequisites: What You Need to Read First

Before starting the interview, you MUST read these files from the ai-dev-orchestrator repository:

**Required reading:**
- `README.md` - Understand the framework, tiers, and personas
- `prompts/phase-0-setup/complexity-estimator.md` - Decision logic for tier selection
- `CONSTITUTION-TEMPLATE.md` - The template you'll customize
- `templates/README.md` - Available pre-configured templates

**Reference as needed:**
- `quick-start/README.md` - Quick Start tier details
- `workflow/workflow-overview.md` - Standard/Full tier workflow
- `examples/` - Real-world constitution examples

**Important:** If you cannot access these files, ask the user to provide them or point you to the repository location.

---

## Step 1: Determine Project Context

Start by asking ONE question:

```
Is this a:
1. New project (starting from scratch)
2. Existing project (adding orchestrator to current codebase)
```

**Based on answer:**

### If NEW PROJECT:
- They're starting fresh - full flexibility
- Can set up ideal structure from the start
- Recommend git initialization
- Focus on tech stack selection

### If EXISTING PROJECT:
- Need to understand current structure
- Must integrate with existing conventions
- May need to audit current code first
- Focus on compatibility and gradual adoption

---

## Step 2: Complexity Interview

Ask the following questions conversationally (not all at once - have a dialogue). Adjust based on their answers.

### Core Questions:

**Project Type:**
```
What type of project is this?
- Internal tool (for your team)
- Client application (for customers/users)
- SaaS product
- AI agent/bot/automation
- Other: ___________
```

**User Base:**
```
How many users will this have?
- Just me (1)
- Small team (2-10)
- Medium team (10-50)
- Large organization (50+)
- Public/many users (unknown)
```

**Data Sensitivity:**
```
What kind of data will this handle? (select all that apply)
- No sensitive data
- User accounts/auth
- Personal information (PII)
- Payment/financial data
- Healthcare/medical data
- Proprietary/confidential business data
```

**Technical Complexity:**
```
Describe the technical scope:
- Simple CRUD operations
- Complex business logic
- Real-time features (websockets, streaming)
- Third-party integrations (APIs, services)
- AI/ML components
- Distributed systems
- Other: ___________
```

**Existing Tech Stack (if existing project):**
```
What technologies are you currently using?
- Frontend framework: ___________
- Backend framework: ___________
- Database: ___________
- Language(s): ___________
- Deployment platform: ___________
```

**New Tech Stack (if new project):**
```
Do you have tech stack preferences, or would you like recommendations?
- I know what I want (ask them to specify)
- I need recommendations (provide based on project type)
- I'm flexible (suggest modern, well-supported stack)
```

**Development Experience:**
```
What's your coding experience level?
- Beginner (new to coding)
- Intermediate (can read/modify code)
- Advanced (professional developer)
- Expert (senior/architect level)
```

---

## Step 3: Analyze & Recommend Tier

Based on the interview, use this decision logic:

### Quick Start Tier
**Recommend when:**
- User is beginner/intermediate
- Internal tool or prototype
- Low data sensitivity
- Simple technical scope
- Small user base (< 50)
- User wants to learn and iterate quickly

**Message:**
```
Based on your answers, I recommend the **Quick Start** tier:
- Focus: Learning and fast iteration
- Workflow: Simplified (PRD → Tasks → Code → Basic Review)
- Best for: Learning, prototypes, internal tools

This will get you productive immediately while teaching you the core workflow.
```

### Standard Flow
**Recommend when:**
- User is intermediate/advanced
- Client application or SaaS product
- Moderate data sensitivity
- Moderate complexity with integrations
- Medium user base (10-200)
- Professional quality needed

**Message:**
```
Based on your answers, I recommend the **Standard Flow** tier:
- Focus: Professional quality with quality controls
- Workflow: Full (PRD → Tech Spec → Tasks → Code → QA → Docs)
- Best for: Client work, SaaS products, team projects

This balances quality and speed for professional development.
```

### Full Framework
**Recommend when:**
- User is advanced/expert
- High data sensitivity (PII, payments, healthcare)
- Complex technical scope
- Large user base or critical system
- Regulatory/compliance requirements
- Production system with high stakes

**Message:**
```
Based on your answers, I recommend the **Full Framework** tier:
- Focus: Production-grade with comprehensive reviews
- Workflow: Complete (All 5 personas, specialized prompts, security audits)
- Best for: Complex systems, regulated industries, high-risk features

This provides maximum quality controls for critical systems.
```

### Validation

After recommending, ask:
```
Does this feel right for your needs?
- If it feels like overkill, we can drop to [lower tier]
- If you're concerned about quality/risk, we can upgrade to [higher tier]
```

---

## Step 4: Select Constitution Template

Based on project type and interview, recommend a template:

### Internal Tool Template
**When:**
- Internal tool
- Small team
- Fast iteration needed
- Lower formality

**Say:** "I'll use the Internal Tool template as a starting point - it emphasizes speed and pragmatism."

### Client Application Template
**When:**
- Client-facing app
- Professional quality needed
- Security important
- Polish matters

**Say:** "I'll use the Client Application template - it emphasizes security, testing, and user experience."

### AI Agent Template
**When:**
- Bot, automation, or API service
- Integration-heavy
- Reliability critical
- Event-driven

**Say:** "I'll use the AI Agent template - it emphasizes reliability, error handling, and integrations."

### Custom (from scratch)
**When:**
- None of the above fit
- User has specific requirements
- Highly specialized domain

**Say:** "I'll create a custom CONSTITUTION.md based on your specific requirements."

---

## Step 5: Customize CONSTITUTION.md

Now generate the CONSTITUTION.md file. You'll customize these sections:

### Section 1: Core Principles
**Ask:**
```
What are your top 3 development principles?
Examples:
- Simplicity over complexity
- User experience first
- Security by default
- Ship fast, iterate
- Test everything
```

**Use their answers or suggest based on project type.**

### Section 2: Technical Stack

**If existing project:**
```
Based on what you told me, here's your current stack:
[List what they said]

Should I add anything else? Any tools/services I should know about?
```

**If new project:**
```
Here's what I recommend for [project type]:

**Frontend:**
- Framework: [React/Next.js/Vue/etc based on needs]
- Language: TypeScript (strict mode enabled) - recommended for all projects
- File extensions: .tsx for React components, .ts for utilities
- Type imports: `import type { ... }` for type-only imports
- Styling: [Tailwind for speed, CSS Modules for control]

**Backend:**
- Framework: [FastAPI/Express/Django based on language]
- Language: [Python/Node/etc based on user preference or need]
- API: [REST for simplicity, GraphQL if complex queries]

**Database:**
- [PostgreSQL for relational, MongoDB for flexibility]

**Infrastructure:**
- [Docker for consistency, Vercel/Railway for simplicity]

Does this work for you, or do you have different preferences?
```

**Capture:**
- Frontend framework and language
- Backend framework and language
- Database choice
- Deployment platform
- Testing frameworks
- Any specific libraries/tools

### Section 3: Coding Standards

**Ask:**
```
Do you have existing style guides or preferences?
- Specific style guide (Airbnb, Google, etc.)
- Linting setup (ESLint, Pylint, etc.)
- Formatting (Prettier, Black, etc.)
- Naming conventions
```

**Default recommendations if none:**
- Use industry-standard style guides for their language
- Enable strict mode (TypeScript, Python type hints)
- Automatic formatting on save
- Conventional commits for git

### Section 4: Security & Compliance

**Based on data sensitivity:**

**High sensitivity (PII, payments, healthcare):**
```
Given you're handling [sensitive data type], I'm adding strict security requirements:
- No secrets in code (env vars only)
- Input validation on all endpoints
- SQL injection prevention
- XSS protection
- CSRF tokens
- Encryption for sensitive data
- Security audit in every PR
- [Add compliance if relevant: HIPAA, PCI-DSS, GDPR]
```

**Medium sensitivity (user auth):**
```
For user authentication, I'm adding:
- OAuth 2.0 or secure session management
- Password hashing (bcrypt/argon2)
- No PII in logs
- Input validation
```

**Low sensitivity:**
```
Basic security practices:
- Input validation
- No secrets in code
- HTTPS only
```

### Section 5: Testing Strategy

**Based on tier:**

**Quick Start:**
```
Testing approach: Manual testing with documentation
- Document test cases in PRD
- Manual validation after each feature
- (Optional: Add automated tests later)
```

**Standard:**
```
Testing approach: Automated unit tests + manual integration testing
- Unit tests for business logic
- Integration tests for APIs
- Manual testing for UI/UX
- CI/CD runs tests automatically
```

**Full Framework:**
```
Testing approach: Comprehensive automated testing
- Unit tests (>80% coverage)
- Integration tests
- E2E tests for critical paths
- Security testing
- Performance testing
- CI/CD with quality gates
```

### Section 6: Project-Specific Rules

**Ask:**
```
Any project-specific rules I should add?
Examples:
- "All API responses must follow JSON:API spec"
- "All user-facing text must be internationalized"
- "All components must be accessible (WCAG AA)"
- "All database queries must be optimized (no N+1)"
```

---

## Step 6: Generate CONSTITUTION.md

**Say:**
```
I'm now creating your CONSTITUTION.md file based on our conversation.
[If existing project: I'll save it to your project root]
[If new project: I'll create the project structure first]
```

**Create the file using this structure:**

```markdown
# Project Constitution

> This document defines the rules and standards that all AI assistants must follow when working on this project.

## 1. Core Principles (The "Why")

[Insert their 3-5 principles]

## 2. Technical Stack (The "What")

**Frontend:**
[Insert their stack]

**Backend:**
[Insert their stack]

**Database:**
[Insert their choice]

**Infrastructure:**
[Insert their platform]

**Testing:**
[Insert their frameworks]

## 3. Coding Standards (The "How")

**Language Version:**
[Insert versions and strict mode settings]

**Style Guide:**
[Insert style guides]

**Linting & Formatting:**
[Insert tools]

**Naming Conventions:**
[Insert conventions or defaults]

## 4. Security & Compliance (The "Musts")

**Data Handling:**
[Insert based on sensitivity level]

**Authentication:**
[Insert based on requirements]

**Authorization:**
[Insert if needed]

**Compliance:**
[Insert if HIPAA, PCI-DSS, GDPR, etc.]

## 5. Testing Strategy

**Test Types:**
[Insert based on tier]

**Coverage Requirements:**
[Insert if applicable]

**CI/CD:**
[Insert pipeline requirements]

## 6. Documentation Standards

**Code Comments:**
[Insert expectations]

**README Requirements:**
[Insert what README must contain]

**API Documentation:**
[Insert if applicable: OpenAPI, JSDoc, etc.]

## 7. Git Workflow

**Branching:**
[Insert strategy: feature branches, trunk-based, etc.]

**Commit Messages:**
[Insert format: Conventional Commits recommended]

**PR Requirements:**
[Insert requirements: tests pass, review needed, etc.]

## 8. Project-Specific Rules

[Insert any special rules they mentioned]

---

**Last Updated:** [Current Date]
**Framework Version:** AI-Dev-Orchestrator v1.0
```

**After creating, say:**
```
✅ CONSTITUTION.md created!

This is your project's single source of truth. Every AI assistant (including me)
will follow these rules when working on your code.

You can edit this file anytime - just commit the changes.
```

---

## Step 7: Set Up Project Structure

> **Claude Code shortcut:** Run `./setup.sh /path/to/project` from the ai-dev-orchestrator repo — it handles all file copying, directory creation, and generates a `CLAUDE.md` with first-run instructions. Skip the manual steps below.

### If New Project (manual):

**Say:**
```
Let me set up your project structure.
```

**Create:**
```
[project-name]/
├── CONSTITUTION.md           # ✅ Already created
├── README.md                 # Basic project readme
├── .gitignore               # Standard ignores for their stack
├── docs/                    # Documentation folder
│   └── .gitkeep
├── [src or app]/            # Source code (name based on framework)
│   └── .gitkeep
└── tests/                   # Test folder
    └── .gitkeep
```

**Then:**
```bash
# Initialize git if not already done
git init
git add .
git commit -m "chore: initialize project with AI-Dev-Orchestrator"
```

### If Existing Project (manual):

**Say:**
```
I'm adding CONSTITUTION.md to your existing project.
Let me check if you have a docs/ folder...
```

**Create:**
- `CONSTITUTION.md` in project root
- `docs/` folder if it doesn't exist

**Then:**
```bash
git add CONSTITUTION.md docs/
git commit -m "chore: add AI-Dev-Orchestrator framework"
```

---

## Step 8: Set Up Prompts Workflow

Based on the recommended tier, guide them on which prompts to use.

### Quick Start Tier:

**Say:**
```
For Quick Start, you'll mainly use these 3 prompts:

1. **quick-start/simplified-prd.md**
   - When: You have a feature idea
   - Output: Simple requirements doc

2. **prompts/phase-2-implementation/2.1-generate-task-list.md**
   - When: After you approve the PRD
   - Output: Numbered list of tasks

3. **prompts/phase-2-implementation/2.2-iterative-implementation.md**
   - When: Implementing each task (one at a time!)
   - Output: Code for that specific task

Optional:
- **prompts/phase-3-review/3.1-qa-comprehensive-review.md** - Before shipping

I recommend bookmarking these files or copying them to your project's docs/ folder.

Want me to copy them to docs/prompts/ for easy access?
```

### Standard Flow:

**Say:**
```
For Standard Flow, here's your core workflow:

**Phase 1 - Planning:**
1. prompts/phase-1-planning/1.1-product-owner-prd.md
2. prompts/phase-1-planning/1.2-architect-tech-spec.md

**Phase 2 - Implementation:**
3. prompts/phase-2-implementation/2.1-generate-task-list.md
4. prompts/phase-2-implementation/2.2-iterative-implementation.md (repeat per task)

**Phase 3 - Review:**
5. prompts/phase-3-review/3.1-qa-comprehensive-review.md

**Phase 4 - Documentation:**
6. prompts/phase-4-documentation/4.1-readme-generator.md

I recommend:
1. Copy these to docs/prompts/ in your project
2. Bookmark workflow/workflow-overview.md for reference
3. Use workflow/phase-checklist.md to ensure completeness

Want me to set this up for you?
```

### Full Framework:

**Say:**
```
For Full Framework, you have access to all 15 specialized prompts.

I recommend:
1. Copy the entire prompts/ directory to your project
2. Review prompts/README.md for prompt descriptions
3. Use workflow/prompt-selection-guide.md to choose the right prompt
4. Follow workflow/phase-checklist.md for each feature

Key specialized prompts you'll use:
- 1.3-architect-database-schema.md (for complex data models)
- 1.4-architect-api-design.md (for API-heavy features)
- 3.3-qa-security-audit.md (mandatory for sensitive data)
- 3.6-architect-refactor-consultation.md (before major refactors)

Want me to copy all prompts to your project?
```

**If they say yes to copying prompts:**

Create `docs/prompts/` folder and copy the relevant prompt files with auto-populated template variables (see below), then commit.

---

### Auto-Populating Template Variables in Prompts

**IMPORTANT:** When copying prompts to the user's project, you MUST auto-populate template variables to save them manual work.

**Reference:** See [docs/template-variables.md](./docs/template-variables.md) for complete variable documentation.

#### Step 1: Parse CONSTITUTION.md for Values

Extract these values from the CONSTITUTION.md you just created:

**From "Technical Stack" section:**
```python
# Example parsing:
# "Framework: FastAPI" → backend_framework = "FastAPI"
# "Language: Python 3.11+" → backend_language = "Python"
# "Framework: React 18" → frontend_framework = "React"
# "Language: TypeScript" → frontend_language = "TypeScript"
# "Database: PostgreSQL 15+" → database = "PostgreSQL"
```

**From "Coding Standards" section:**
```python
# "Style Guide: PEP 8" → style_guide = "PEP 8"
# "Style Guide: Airbnb JavaScript Style Guide" → style_guide = "Airbnb"
```

**From setup interview:**
```python
# project_type = "Internal Tool" (from Step 4)
```

#### Step 2: Determine Primary Stack

```python
# For backend/API tasks, use backend stack:
language_framework = f"{backend_language}/{backend_framework}"
# Example: "Python/FastAPI"

# For frontend tasks, use frontend stack:
language_framework = f"{frontend_language}/{frontend_framework}"
# Example: "TypeScript/React"

# For language-only contexts:
primary_language = backend_language  # Example: "Python"
```

#### Step 3: Replace Variables in Prompt Templates

When copying each prompt file, replace these variables:

| Variable to Replace | Replacement Value | Example |
|---------------------|-------------------|---------|
| `[LANGUAGE/FRAMEWORK]` | `{language}/{framework}` | "Python/FastAPI" |
| `[PRIMARY_LANGUAGE]` | `{language}` | "Python" |
| `[DATABASE]` | `{database}` | "PostgreSQL" |
| `[PROJECT_TYPE]` | `{project_type}` | "Internal Tool" |
| `[STYLE_GUIDE]` | `{style_guide}` | "PEP 8" |

**Example replacement:**

**Before (original prompt):**
```markdown
You are an expert **[LANGUAGE/FRAMEWORK]** developer.
```

**After (copied to project):**
```markdown
You are an expert **Python/FastAPI** developer.
```

#### Step 4: What NOT to Replace

**Leave these variables for humans to fill at use-time:**
- `[YOUR_FEATURE_DESCRIPTION]` - User fills when starting feature
- `[NUMBER]` - User fills per task
- `[PASTE_TASK_DESCRIPTION_HERE]` - User fills per task
- `[ATTACH_RELEVANT_FILES]` - User fills per prompt
- `[PASTE_YOUR_CODE_HERE]` - User fills when reviewing

These are **dynamic** and change with each use.

#### Step 5: Inform the User

After copying and populating prompts:

**Say:**
```
✅ Prompts copied to docs/prompts/

I've pre-populated these template variables based on your CONSTITUTION.md:
- [LANGUAGE/FRAMEWORK] → Python/FastAPI (backend) / TypeScript/React (frontend)
- [DATABASE] → PostgreSQL
- [PROJECT_TYPE] → Internal Tool
- [STYLE_GUIDE] → PEP 8

Variables you'll fill when using prompts:
- [YOUR_FEATURE_DESCRIPTION] - Your feature idea
- [NUMBER] - Task number from task list
- [PASTE_TASK_DESCRIPTION_HERE] - Exact task text
- [ATTACH_RELEVANT_FILES] - Files to attach

See docs/template-variables.md for full reference.
```

#### Example: Full Prompt Auto-Population

**Original prompt (in orchestrator repo):**
```markdown
# Prompt: Iterative Implementation

You are an expert **[LANGUAGE/FRAMEWORK]** developer.

**Your Context:**
1. **Constitution:** You MUST follow all rules in `CONSTITUTION.md`
2. **Task List:** We are working on **Task #[NUMBER]**
3. **Task Description:** [PASTE_TASK_DESCRIPTION_HERE]

**Your Assignment:**
- Write code following [STYLE_GUIDE] standards
- Use [DATABASE] for data persistence
```

**After copying to user's project (auto-populated):**
```markdown
# Prompt: Iterative Implementation

You are an expert **Python/FastAPI** developer.

**Your Context:**
1. **Constitution:** You MUST follow all rules in `CONSTITUTION.md`
2. **Task List:** We are working on **Task #[NUMBER]**
3. **Task Description:** [PASTE_TASK_DESCRIPTION_HERE]

**Your Assignment:**
- Write code following PEP 8 standards
- Use PostgreSQL for data persistence
```

**User fills remaining variables when using:**
- `[NUMBER]` → "5"
- `[PASTE_TASK_DESCRIPTION_HERE]` → "Implement createResetToken method"

---

## Step 9: First Feature Setup

**Say:**
```
You're all set up! 🚀

Let's start your first feature. What do you want to build?

Tell me:
- What feature/functionality you want to add
- Who it's for (user type)
- What problem it solves

I'll help you create your first PRD using the [tier-appropriate prompt].
```

**When they describe their feature:**

1. **Quick Start:** Use simplified-prd.md format to generate a basic requirements doc
2. **Standard/Full:** Use 1.1-product-owner-prd.md to generate a formal PRD

**Generate the PRD in the conversation, then:**

```
I've created your first PRD above.

Please review it and let me know:
✅ Looks good - proceed to [next step based on tier]
❌ Needs changes - tell me what to adjust

Once approved, I'll save it to docs/[feature-name]-prd.md
```

---

## Step 10: Handoff

After the first PRD is created and saved:

**Quick Start:**
```
✅ Setup complete!

Your first PRD is saved to docs/[feature-name]-prd.md

Next steps:
1. I'll generate a task list from this PRD
2. We'll implement tasks one at a time
3. You test after each task
4. Ship it!

Ready to generate the task list?
```

**Standard/Full:**
```
✅ Setup complete!

Your first PRD is saved to docs/[feature-name]-prd.md

Next steps:
1. I'll create a technical spec (how to build it)
2. Then generate a detailed task list
3. We'll implement tasks one at a time
4. QA review before shipping
5. Generate documentation

Ready to create the tech spec?
```

---

## Handling Edge Cases

### They want to skip tiers or mix approaches:

**Respect their choice, but warn:**
```
You can definitely mix approaches!

Just be aware:
- Skipping planning (PRD/Tech Spec) can lead to rework later
- Skipping QA reviews might ship bugs/security issues
- Using Full Framework for simple features is slower

Want to proceed with your approach, or shall I recommend something?
```

### They have an unusual tech stack:

**Be flexible:**
```
I don't have a pre-built template for [unusual stack], but I can create
a custom CONSTITUTION.md based on best practices for [language/framework].

Can you share:
- Official style guides for [language]
- Common patterns in [framework]
- Testing tools you prefer
```

### They want to audit existing code first:

**Recommend audit workflow:**
```
Great idea! For existing projects, I recommend:

1. First: Complete this setup (CONSTITUTION.md)
2. Then: Use prompts/phase-3-review/3.1-qa-comprehensive-review.md to audit current code
3. Create a backlog of issues (technical debt)
4. Prioritize and fix critical issues
5. Then start new features with the workflow

Want to proceed with the audit after setup?
```

### They're not sure what to build:

**Help with discovery:**
```
Let's figure out what to build first.

Questions:
- What problem are your users facing?
- What manual process could be automated?
- What feature request comes up most often?
- What's the biggest pain point in your current workflow?

OR

If you're exploring, I can help you:
- Brainstorm feature ideas
- Prioritize your backlog
- Estimate complexity of different options
```

---

## Important: Maintain Context

Throughout this process:

1. **Reference CONSTITUTION.md** - Remind them it's the single source of truth
2. **Stay in tier** - Don't overload Quick Start users with Full Framework complexity
3. **One step at a time** - Don't jump ahead
4. **Validate each step** - Get their approval before proceeding
5. **Save everything** - Commit after each major step
6. **Teach while doing** - Explain *why* each step matters

---

## Your Success Criteria

You've successfully set up AI-Dev-Orchestrator when:

- [ ] User understands the workflow for their chosen tier
- [ ] CONSTITUTION.md is created and customized for their project
- [ ] Project structure is set up (new) or CONSTITUTION added (existing)
- [ ] They know which prompts to use and where to find them
- [ ] First PRD is created and approved
- [ ] They're ready to proceed to the next phase
- [ ] They feel confident continuing with AI assistance

---

## Final Notes for AI Assistants

**Remember:**
- You're setting up a framework for FUTURE AI interactions (including other AIs)
- The CONSTITUTION.md you create will guide all future AI development on this project
- Be thorough but not overwhelming
- Adapt to their experience level
- This is their first impression of the framework - make it good!

**When in doubt:**
- Ask questions
- Reference the original README.md
- Recommend simpler over more complex
- Prioritize getting them started over perfect setup

**After setup:**
- You may continue to help them with their first feature
- Or hand off by saying: "You're all set! Start your next feature by using [prompt] with your new CONSTITUTION.md"

---

**End of Project Onboarding Guide**

*This guide is living documentation. As the framework evolves, update this guide to reflect new best practices and learnings.*
