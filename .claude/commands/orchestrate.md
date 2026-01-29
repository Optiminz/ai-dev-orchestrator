# Orchestrate: Full AI-Dev Workflow Automation

Orchestrate the complete ai-dev-orchestrator workflow with Ralph Loop + Superpowers skills integration for automated, multi-phase software development.

---

## What This Does

The `/orchestrate` skill automates the 4-phase ai-dev-orchestrator workflow by:
1. **Invoking personas** in sequence (Product Owner → Solutions Architect → Developer → QA → Writer)
2. **Using Ralph Loop** for iterative implementation with self-correction
3. **Enforcing gates** via stop hooks (constitution, artifacts, quality checks)
4. **Capturing learnings** at session boundaries

This turns a manual, human-orchestrated workflow into an automated pipeline with human approval checkpoints.

---

## Your Task

Execute the full ai-dev-orchestrator workflow for the given feature request, following the 4-phase structure with automated persona handoffs and quality gates.

---

## Phase Overview

```
Phase 1: Planning & Design
  ├─ Product Owner → PRD
  ├─ Solutions Architect → Tech Spec
  └─ (Optional) DB Schema, API Design

Phase 2: Implementation
  ├─ Generate Task List
  ├─ Ralph Loop → Iterative development
  └─ Constitution enforcement

Phase 3: Review & Refactoring
  ├─ QA Engineer → Comprehensive review
  └─ Fix issues identified

Phase 4: Documentation
  ├─ Technical Writer → README, guides
  └─ Session reflection
```

---

## Step-by-Step Execution

### Pre-Flight Checks

Before starting, verify:

1. **Constitution exists:** Check for `CONSTITUTION.md` in repo root
2. **Stop hooks configured:** Verify `.claude/hooks/stop/` has required hooks
3. **Project context loaded:** Read `CLAUDE.md` and `README.md` for context
4. **Templates available:** Check for artifact templates in `templates/`

If any are missing, inform user and offer to create them.

---

### Phase 1: Planning & Design

#### Step 1.1: Brainstorm with User (Superpowers)

If the feature is vague or complex, start with brainstorming:

```
Use /brainstorming skill if:
- Feature request is <50 words
- Multiple design approaches possible
- User needs or requirements unclear
```

**Output:** Clarified requirements and approach

#### Step 1.2: Create PRD (Product Owner Persona)

Invoke the Product Owner persona to create a PRD:

1. Read `personas/01-product-owner.md` for behavior guidelines
2. Create a PRD artifact at `docs/[feature-name]-prd.md`
3. Include:
   - Feature description
   - User stories (As a X, I want Y, so that Z)
   - Acceptance criteria (testable checkpoints)
   - Success metrics
   - Out-of-scope items

**Quality Gate (Stop Hook):**
- ✓ PRD file exists at `docs/[feature-name]-prd.md`
- ✓ Contains at least 3 user stories
- ✓ Each story has acceptance criteria
- ✓ Aligns with CONSTITUTION.md principles

Ask user: "Review PRD. Approve to continue to technical design?"

#### Step 1.3: Create Tech Spec (Solutions Architect Persona)

Invoke the Solutions Architect persona to create technical design:

1. Read `personas/02-solutions-architect.md` for behavior guidelines
2. Read the PRD created in Step 1.2
3. Create a Tech Spec at `docs/[feature-name]-tech-spec.md`
4. Include:
   - Architecture overview
   - File changes (new files, modifications)
   - Data models and schemas
   - API endpoints (if applicable)
   - Dependencies and integrations
   - Risk analysis

**Quality Gate (Stop Hook):**
- ✓ Tech Spec file exists at `docs/[feature-name]-tech-spec.md`
- ✓ References PRD user stories
- ✓ Tech stack matches CONSTITUTION.md
- ✓ No prohibited technologies used
- ✓ Type sharing patterns followed (if TypeScript)

Ask user: "Review Tech Spec. Approve to generate task list?"

#### Step 1.4: Optional - Database/API Design

If the tech spec indicates database changes or new APIs:

- **Database Schema:** Create `docs/[feature-name]-schema.sql`
- **API Design:** Create `docs/[feature-name]-api-spec.yaml` (OpenAPI 3.0)

**Quality Gate (Stop Hook):**
- ✓ Schema includes indexes and constraints
- ✓ API spec includes request/response schemas

---

### Phase 2: Implementation

#### Step 2.1: Generate Task List

Break the tech spec into 10-30 discrete tasks:

1. Read tech spec
2. Create `docs/[feature-name]-tasks.md`
3. Each task should be:
   - Completable in 30-60 minutes
   - Testable independently
   - Clearly defined with acceptance criteria

**Task Format:**
```markdown
## Task List

- [ ] Task 1: Setup database table for X
  - Create migration file
  - Add indexes on Y and Z columns
  - Acceptance: Migration runs without errors

- [ ] Task 2: Create API endpoint POST /api/users
  - Implement route handler
  - Add input validation with Zod
  - Write unit tests (>80% coverage)
  - Acceptance: Tests pass, endpoint returns 201
```

**Quality Gate (Stop Hook):**
- ✓ Task list exists
- ✓ Each task has acceptance criteria
- ✓ Tasks ordered by dependencies

#### Step 2.2: Test-Driven Development Setup (Superpowers)

Before implementation, set up tests:

```
Use /test-driven-development skill to:
- Create test files for each component
- Write failing tests based on acceptance criteria
- Define expected behavior
```

**Output:** Test suite ready for TDD workflow

#### Step 2.3: Ralph Loop Implementation

Start Ralph Loop to implement tasks iteratively:

**Ralph Loop Configuration:**
```bash
/ralph-loop "Implement tasks from docs/[feature-name]-tasks.md one at a time.
For each task:
1. Read CONSTITUTION.md for coding standards
2. Implement following type sharing patterns
3. Write code with meaningful comments (explain WHY)
4. Run tests after implementation
5. Mark task complete in task list
6. Commit with message: 'feat: [task description]'

Continue until all tasks complete.
Output <promise>ALL TASKS COMPLETE</promise> when done."
--completion-promise "ALL TASKS COMPLETE"
--max-iterations 50
```

**During Ralph Loop:**

The following stop hooks run after each iteration:

1. **Constitution Check Hook** (priority 10)
   - Validates naming conventions
   - Checks for prohibited patterns
   - Verifies error handling exists
   - Blocks if violations found

2. **Test Validation Hook** (priority 20)
   - Runs test suite
   - Blocks if tests fail
   - Requires >70% coverage for business logic

3. **Security Audit Hook** (priority 30)
   - Checks for common vulnerabilities
   - Validates input sanitization
   - Warns on security issues

4. **Ralph Loop Hook** (priority 5)
   - Checks for completion promise
   - Feeds same prompt back if not found
   - Tracks iteration count

**Persona Behavior During Ralph:**
- Invoke `personas/03-specialist-developer.md` behavior
- Follow CONSTITUTION.md coding standards
- Write meaningful comments (explain "why" not "what")
- One task at a time
- Test after each task
- Commit frequently

**Quality Gate (Stop Hook):**
- ✓ All tasks marked complete in task list
- ✓ All tests passing
- ✓ No constitution violations
- ✓ Code committed to git

---

### Phase 3: Review & Refactoring

#### Step 3.1: QA Engineer Review

Invoke QA Engineer persona for comprehensive review:

1. Read `personas/04-qa-engineer.md` for behavior guidelines
2. Review all code changes since phase 2 started
3. Create `docs/[feature-name]-qa-review.md`
4. Include:
   - **Issues Found** (categorized: CRITICAL, HIGH, MEDIUM, LOW)
   - **Security Vulnerabilities** (with OWASP category)
   - **Edge Cases** (scenarios not covered)
   - **Code Quality** (readability, maintainability)
   - **Test Coverage** (gaps in test suite)
   - **Performance Concerns**
   - **Recommendation** (Ship / Fix First / Major Refactor Needed)

**Quality Gate (Stop Hook):**
- ✓ QA Review exists
- ✓ No CRITICAL issues unresolved
- ✓ HIGH issues have remediation plan

#### Step 3.2: Fix Issues

If QA review found issues:

**For CRITICAL/HIGH issues:**
- Use Ralph Loop to fix iteratively
- Re-run QA review after fixes

**For MEDIUM/LOW issues:**
- Ask user: "These non-critical issues found. Fix now or defer?"

#### Step 3.3: Verification (Superpowers)

Before moving to documentation:

```
Use /verification-before-completion skill to:
- Verify all claims made are accurate
- Run full test suite
- Confirm no regressions introduced
- Validate acceptance criteria met
```

**Quality Gate (Stop Hook):**
- ✓ All tests passing
- ✓ CRITICAL/HIGH issues resolved
- ✓ Acceptance criteria from PRD met

---

### Phase 4: Documentation

#### Step 4.1: Technical Writer Documentation

Invoke Technical Writer persona:

1. Read `personas/05-technical-writer.md` for behavior guidelines
2. Create or update `README.md`
3. Include:
   - **What:** Feature description (user-facing)
   - **Why:** Problem it solves
   - **How to use:** Code examples
   - **API reference:** If endpoints added
   - **Setup/Installation:** If dependencies added
   - **Troubleshooting:** Common issues

**Optional Documentation:**
- User guide for non-technical users
- API documentation (if public API)
- Architecture decision records (ADRs)

**Quality Gate (Stop Hook):**
- ✓ README.md updated
- ✓ Code examples tested and working
- ✓ All public APIs documented

#### Step 4.2: Session Reflection (Superpowers)

Capture learnings from this session:

```
Use /reflect skill to:
- Document what worked well
- Record mistakes to avoid
- Capture architectural decisions
- Update project learnings
```

**Output:**
- `.claude/learnings/insights.md` updated
- `.claude/learnings/decisions.md` updated
- `.claude/learnings/gotchas.md` updated

#### Step 4.3: Request Code Review (Superpowers)

Before merging:

```
Use /requesting-code-review skill to:
- Summarize changes
- Highlight key decisions
- Request human review
```

---

## Workflow State Tracking

Throughout orchestration, maintain state in `.claude/workflow-state.yaml`:

```yaml
feature_name: user-authentication
current_phase: implementation
current_persona: specialist-developer
current_task: 8
total_tasks: 15
artifacts_completed:
  - PRD.md
  - TECH-SPEC.md
  - TASK-LIST.md
artifacts_pending:
  - QA-REVIEW.md
  - README.md
constitution_violations: 0
test_coverage: 82%
last_updated: 2026-01-28T14:30:00Z
```

This allows pausing and resuming orchestration.

---

## User Interaction Points

The user is prompted for approval at these checkpoints:

1. **After PRD created:** "Review PRD. Approve to continue?"
2. **After Tech Spec created:** "Review Tech Spec. Approve to generate tasks?"
3. **After Task List generated:** "Review task list. Approve to start implementation?"
4. **After QA Review:** "Issues found. Review and approve fixes?"
5. **After Documentation:** "Review docs. Ready to merge?"

Between checkpoints, orchestration runs autonomously via Ralph Loop.

---

## Stop Hook Integration

The orchestration relies on these stop hooks (priority order):

```
~/.claude/hooks/stop/
├── 01-ralph-loop.sh           # Ralph loop control
├── 10-constitution-check.sh   # Validate against CONSTITUTION.md
├── 20-test-validation.sh      # Run tests, block on failure
├── 30-artifact-gates.sh       # Verify required artifacts exist
├── 40-persona-handoff.sh      # Auto-transition to next persona
├── 50-security-audit.sh       # Security vulnerability scanning
├── 60-quality-gates.sh        # Code quality thresholds
├── 90-auto-commit.sh          # Auto-commit if checks pass
└── 99-session-learning.sh     # Prompt for /reflect
```

**How Hooks Enforce Workflow:**

- **Ralph Hook** (01): Checks for completion promise, feeds prompt back if not found
- **Constitution Hook** (10): Parses CONSTITUTION.md, validates naming, patterns, tech stack
- **Test Hook** (20): Runs `npm test` or equivalent, blocks exit if fail
- **Artifact Hook** (30): Checks phase requirements (e.g., PRD required before tech spec)
- **Handoff Hook** (40): Transitions to next persona when artifacts complete
- **Security Hook** (50): Runs `npm audit` or equivalent, warns on HIGH+ issues
- **Quality Hook** (60): Checks test coverage, linting, formatting
- **Commit Hook** (90): Auto-commits if all checks pass
- **Learning Hook** (99): Prompts `/reflect` if significant work done

---

## Error Handling

### If Ralph Loop Fails

If Ralph exceeds max iterations without completion:

1. **Analyze state:** Read task list, check what's incomplete
2. **Diagnose blocker:** Is a test failing? Constitution violation?
3. **Ask user:** "Ralph Loop incomplete after N iterations. Issue: [X]. How to proceed?"
4. **Options:**
   - Continue with increased max-iterations
   - Switch to manual task-by-task
   - Pause and review

### If Constitution Violations Found

If stop hooks detect violations:

1. **Show violations:** List specific issues with file:line
2. **Auto-fix if possible:** Simple fixes (naming, formatting)
3. **Block if critical:** Security issues, prohibited tech
4. **Ask user:** "Constitution violations found. [Details]. Fix now?"

### If Tests Fail

If tests fail during implementation:

1. **Show failures:** Test output with stack traces
2. **Ralph continues:** Ralph Loop attempts to fix
3. **If repeated failures:** After 3 attempts, pause and ask user

---

## Resume Capability

If orchestration is interrupted, resume with:

```
/orchestrate --resume [feature-name]
```

This reads `.claude/workflow-state.yaml` and continues from last checkpoint.

---

## Customization Options

### Quick Mode (Skip Planning)

If PRD and Tech Spec already exist:

```
/orchestrate --skip-planning --tasks-from docs/existing-tasks.md
```

Jumps directly to Phase 2 implementation.

### Selective Phases

Run only specific phases:

```
/orchestrate --phase implementation   # Phase 2 only
/orchestrate --phase review          # Phase 3 only
/orchestrate --phase docs            # Phase 4 only
```

### Constitution Override

For experimental features:

```
/orchestrate --no-constitution-checks
```

**⚠️ Warning:** Only use for prototyping. Not recommended for production.

---

## Success Criteria

Orchestration is complete when:

- ✓ All 4 phases executed
- ✓ All artifacts created (PRD, Tech Spec, Task List, QA Review, README)
- ✓ All tests passing
- ✓ No CRITICAL/HIGH issues unresolved
- ✓ Code committed to git
- ✓ Session learnings captured
- ✓ User approved final state

**Final Output:**
```
✓ Orchestration Complete

Feature: [name]
Artifacts: PRD, Tech Spec, Tasks, QA Review, README
Tasks Completed: 15/15
Test Coverage: 85%
Constitution Violations: 0
Time: 2h 30m (Ralph iterations: 23)

Ready to merge. Run /finishing-a-development-branch for PR workflow.
```

---

## Key Principles

1. **Autonomous execution** - Human approval only at checkpoints, not micro-decisions
2. **Constitution as law** - CONSTITUTION.md is non-negotiable source of truth
3. **Persona specialization** - Each persona has one job, does it well
4. **Iterative refinement** - Ralph Loop enables self-correction
5. **Quality gates** - Stop hooks enforce standards automatically
6. **Learning capture** - Every session improves future orchestration

---

## Example Usage

### Full Workflow

```
You: /orchestrate "Build user authentication with email/password and OAuth"

Claude (Phase 1 - Planning):
  ✓ Reading CONSTITUTION.md for project context
  ✓ Invoking Product Owner persona
  ✓ Creating PRD at docs/user-auth-prd.md
  → Review PRD. Approve to continue? [y/n]

You: y

Claude (Phase 1 - Design):
  ✓ Invoking Solutions Architect persona
  ✓ Creating Tech Spec at docs/user-auth-tech-spec.md
  → Tech stack validated against CONSTITUTION.md
  → Review Tech Spec. Approve to generate tasks? [y/n]

You: y

Claude (Phase 2 - Implementation):
  ✓ Generating task list (18 tasks)
  ✓ Created docs/user-auth-tasks.md
  → Review task list. Approve to start implementation? [y/n]

You: y

Claude (Phase 2 - Implementation):
  ✓ Starting Ralph Loop (max 50 iterations)
  ✓ Invoking Specialist Developer persona

  [Ralph Iteration 1]
    → Implementing Task 1: Create user model
    → Tests passing ✓
    → Committed: feat(auth): create user model

  [Ralph Iteration 2]
    → Implementing Task 2: Add password hashing
    → Tests passing ✓
    → Committed: feat(auth): add bcrypt password hashing

  ... [Ralph continues iteratively] ...

  [Ralph Iteration 18]
    → Implementing Task 18: Add OAuth callback handling
    → Tests passing ✓
    → Committed: feat(auth): add OAuth callback handling
    → <promise>ALL TASKS COMPLETE</promise>

  ✓ Ralph Loop complete (18/18 tasks done)

Claude (Phase 3 - Review):
  ✓ Invoking QA Engineer persona
  ✓ Running comprehensive review
  ✓ Created docs/user-auth-qa-review.md

  Issues Found:
    - MEDIUM: Missing rate limiting on login endpoint
    - LOW: Inconsistent error messages

  → Fix issues now? [y/n]

You: y

Claude:
  ✓ Fixed MEDIUM issue: Added rate limiting (5 attempts/15 min)
  ✓ Fixed LOW issue: Standardized error messages
  ✓ Tests passing (coverage: 87%)

Claude (Phase 4 - Documentation):
  ✓ Invoking Technical Writer persona
  ✓ Updated README.md with auth documentation
  ✓ Added API examples
  ✓ Created troubleshooting guide

  ✓ Running /reflect for session learnings
  ✓ Updated .claude/learnings/insights.md

  ✓ Orchestration Complete!

  Feature: user-authentication
  Tasks: 18/18 ✓
  Coverage: 87%
  Constitution: ✓

  Ready to merge. Run /finishing-a-development-branch for PR workflow.
```

### Quick Mode (Existing Design)

```
You: /orchestrate --skip-planning --tasks-from docs/existing-tasks.md

Claude:
  ✓ Skipping Phase 1 (planning)
  ✓ Reading task list from docs/existing-tasks.md
  ✓ Starting Ralph Loop for implementation...

  [Continues from Phase 2]
```

### Resume After Interruption

```
You: /orchestrate --resume user-authentication

Claude:
  ✓ Reading workflow state from .claude/workflow-state.yaml
  ✓ Resuming from Phase 2, Task 12/18
  ✓ Re-invoking Specialist Developer persona
  ✓ Continuing Ralph Loop...
```

---

## Implementation Notes for Claude

When executing this skill:

### 1. Read Context First

Before starting any phase:
- Read `CONSTITUTION.md` for tech stack and rules
- Read `CLAUDE.md` for project-specific context
- Read persona files from `personas/` directory
- Check for existing artifacts in `docs/`

### 2. Maintain State File

Create and update `.claude/workflow-state.yaml` after each checkpoint:

```yaml
feature_name: [extracted from user request]
start_time: [ISO timestamp]
current_phase: [planning|implementation|review|documentation]
current_persona: [product-owner|solutions-architect|specialist-developer|qa-engineer|technical-writer]
artifacts:
  prd: [filepath or null]
  tech_spec: [filepath or null]
  task_list: [filepath or null]
  qa_review: [filepath or null]
  readme: [filepath or null]
checkpoints:
  - timestamp: [ISO]
    phase: [name]
    action: [description]
    approved: [true|false]
```

### 3. Persona Invocation Pattern

When invoking a persona:

```markdown
I'm now operating as the **[Persona Name]** persona.

[Read persona file for specific behavior guidelines]

My responsibilities for this phase:
- [Responsibility 1]
- [Responsibility 2]
- [Responsibility 3]

[Execute persona-specific work]

[Create artifact]

[Validate artifact against quality checklist]
```

### 4. Ralph Loop Management

When starting Ralph Loop:

1. **Create Ralph state file:** `.claude/.ralph-loop.local.md`
2. **Track iterations:** Increment counter after each
3. **Check for promise:** After each iteration, scan output for `<promise>` tag
4. **Respect max-iterations:** Stop if exceeded, ask user how to proceed
5. **Commit frequently:** After each successful task completion

### 5. Stop Hook Awareness

Understand that stop hooks run AFTER you try to exit:

- If constitution violation, hook will block and show errors
- If tests fail, hook will block and show failures
- If artifacts missing, hook will block and show what's required
- If Ralph active, hook will feed prompt back to continue loop

Design your work to satisfy stop hooks before attempting to exit each phase.

### 6. User Approval Pattern

At each checkpoint:

```markdown
✓ [Phase] complete.

[Summary of what was done]

[Show key artifacts or outputs]

→ Review [artifact]. Approve to continue to [next phase]? [y/n]
```

Wait for user response before proceeding. If user says "no", ask what needs to change.

### 7. Error Recovery

If anything fails:

1. **Explain what failed** (don't just say "error occurred")
2. **Show relevant output** (test failures, errors, etc.)
3. **Propose solution** (what you'll try next)
4. **Ask user** if they approve the solution or have alternative

Never fail silently. Never retry indefinitely without asking user.

### 8. Learning Capture

At the end of orchestration:

```markdown
Session complete. Capturing learnings...

What worked well:
- [Pattern or approach that was effective]

Mistakes to avoid:
- [Issue encountered and how to prevent]

Architectural decisions:
- [Key choices made and rationale]

→ Updating .claude/learnings/ files
✓ Learnings captured for future sessions
```

---

## Dependencies

This skill requires:

### Required

- ✓ CONSTITUTION.md in repo root
- ✓ Persona files in `personas/` directory
- ✓ Stop hooks in `.claude/hooks/stop/` (or `~/.claude/hooks/stop/`)
- ✓ Git repository initialized
- ✓ Test framework configured

### Optional

- Artifact templates in `templates/` directory
- Example outputs in `examples/` directory
- Project-specific `CLAUDE.md`

### Stop Hooks

Create these hooks for full orchestration functionality:

```bash
# Required hooks (must exist)
01-ralph-loop.sh          # Ralph Loop control
10-constitution-check.sh  # Constitution enforcement
20-test-validation.sh     # Test runner

# Recommended hooks
30-artifact-gates.sh      # Artifact validation
40-persona-handoff.sh     # Auto persona transitions
90-auto-commit.sh         # Auto commits

# Optional hooks
50-security-audit.sh      # Security scanning
60-quality-gates.sh       # Code quality checks
99-session-learning.sh    # Learning prompts
```

If hooks don't exist, warn user and offer to create them.

---

## Troubleshooting

### "Constitution file not found"

Create CONSTITUTION.md from template:
```bash
cp /path/to/ai-dev-orchestrator/CONSTITUTION-TEMPLATE.md CONSTITUTION.md
```

Then customize for your project.

### "Persona files not found"

Ensure `personas/` directory exists with these files:
- `01-product-owner.md`
- `02-solutions-architect.md`
- `03-specialist-developer.md`
- `04-qa-engineer.md`
- `05-technical-writer.md`

### "Stop hooks not configured"

Create hook directory and required scripts:
```bash
mkdir -p .claude/hooks/stop
# Copy hooks from ai-dev-orchestrator/hooks/ directory
```

### "Ralph Loop not stopping"

Check for completion promise in output. If missing:
- Verify promise format: `<promise>TEXT</promise>`
- Check max-iterations not exceeded
- Inspect Ralph state file: `.claude/.ralph-loop.local.md`

---

## Advanced: Custom Orchestration

For specialized workflows, extend orchestration:

### Add Custom Persona

1. Create persona file: `personas/06-my-custom-persona.md`
2. Add to orchestration sequence in this skill
3. Define handoff points from/to other personas

### Add Custom Phase

Insert new phase between existing ones:

```markdown
Phase 2.5: Security Hardening
  ├─ Security Specialist Persona → Threat model
  ├─ Penetration testing
  └─ Vulnerability remediation
```

### Add Custom Gate

Create stop hook for custom validation:

```bash
# .claude/hooks/stop/45-custom-gate.sh
#!/bin/bash

# Your custom validation logic
if [[ condition ]]; then
  echo "✓ Custom gate passed"
  exit 0
else
  echo "❌ Custom gate failed: reason"
  exit 1  # Block exit
fi
```

---

## Related Skills

- `/brainstorming` - Pre-planning exploration (Phase 0)
- `/writing-plans` - Alternative to Product Owner + Architect
- `/test-driven-development` - TDD setup before implementation
- `/verification-before-completion` - Additional validation in Phase 3
- `/requesting-code-review` - Human review before merge
- `/finishing-a-development-branch` - Post-orchestration merge workflow
- `/reflect` - Session learning capture (auto-invoked)

---

## Version

**Skill Version:** 1.0.0
**Created:** 2026-01-28
**Author:** Malcolm (with Claude Opus 4.5)
**Framework:** ai-dev-orchestrator + Ralph Loop + Superpowers

---

*This skill automates the ai-dev-orchestrator workflow by combining persona-based development with Ralph Loop iteration and stop hook enforcement. It transforms a manual, human-orchestrated process into an autonomous pipeline with quality gates and human approval checkpoints.*