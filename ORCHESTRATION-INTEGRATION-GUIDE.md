# Orchestration Integration Guide: Ralph Loop + Superpowers + ai-dev-orchestrator

**Version:** 1.0.0
**Date:** 2026-01-28
**Author:** Malcolm (with Claude Opus 4.5)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [The Three Systems](#the-three-systems)
3. [How They Integrate](#how-they-integrate)
4. [The Complete Workflow](#the-complete-workflow)
5. [Stop Hook Architecture](#stop-hook-architecture)
6. [Setup Guide](#setup-guide)
7. [Usage Examples](#usage-examples)
8. [Troubleshooting](#troubleshooting)
9. [Advanced Topics](#advanced-topics)

---

## Executive Summary

This guide explains how three systems work together to create a fully automated AI development workflow:

| System | Purpose | Role in Integration |
|--------|---------|---------------------|
| **ai-dev-orchestrator** | Persona-based development methodology | Defines WHAT (phases, personas, artifacts) |
| **Ralph Loop** | Iterative execution engine | Provides HOW (continuous iteration until success) |
| **Superpowers Skills** | Structured workflow patterns | Adds WHEN (phase-appropriate skills) |
| **Stop Hooks** | Enforcement & automation layer | Ensures WHY (quality gates, constitution compliance) |

**The Result:** An autonomous development pipeline where:
- Personas create artifacts in phases
- Ralph Loop iterates until criteria met
- Stop hooks enforce quality gates
- Superpowers skills guide key moments
- Human approval only at checkpoints

---

## The Three Systems

### 1. ai-dev-orchestrator

**What it is:** A research-backed framework for building software with AI through structured, persona-based workflows.

**Core Components:**

#### 5 Personas
- **Product Owner** - Defines WHAT and WHY (creates PRD)
- **Solutions Architect** - Defines HOW (creates Tech Spec, DB Schema, API Design)
- **Specialist Developer** - IMPLEMENTS code (writes source code)
- **QA Engineer** - VALIDATES quality (reviews, finds issues)
- **Technical Writer** - EXPLAINS features (documentation)

#### 4 Phases
```
Phase 1: Planning & Design
  └─ Output: PRD, Tech Spec, DB Schema, API Spec

Phase 2: Implementation
  └─ Output: Source code, tests, commits

Phase 3: Review & Refactoring
  └─ Output: QA Review, bug fixes, optimizations

Phase 4: Documentation
  └─ Output: README, user guides, API docs
```

#### CONSTITUTION.md
The non-negotiable governance document that defines:
- Tech stack (mandated and prohibited technologies)
- Coding standards (naming, comments, patterns)
- Type sharing patterns (TypeScript single source of truth)
- Security requirements (PII handling, auth, input validation)
- Performance targets (API response times, bundle sizes)
- Git workflow (commit format, branch strategy)

**Limitation:** Originally designed for **human orchestration** - developers manually invoke personas, review artifacts, and advance phases.

---

### 2. Ralph Loop

**What it is:** An iterative development technique where the same prompt is fed to Claude repeatedly until a completion promise is detected.

**Core Concept:**
```bash
while :; do
  cat PROMPT.md | claude-code --continue
done
```

**How it works:**
1. Claude receives prompt
2. Works on task, modifying files
3. Tries to exit
4. Stop hook intercepts
5. Checks for `<promise>` tag
6. If not found → feed same prompt again
7. Claude sees its own previous work in files
8. Iterates until promise detected or max iterations reached

**Key Insight:** The "loop" isn't output-to-input. It's **same prompt repeatedly** with Claude seeing its own work in the codebase.

**Example:**
```
Iteration 1: Implement feature → Test fails
Iteration 2: See failure, fix code → Test fails (different error)
Iteration 3: See new failure, fix again → Test passes ✓
Iteration 4: Detect promise → Exit
```

**Strengths:**
- Self-correcting through iteration
- No prompt engineering between loops
- Deterministic failure modes (predictable, tunable)

**Limitations:**
- Needs clear success criteria (completion promise)
- Can loop infinitely without max-iterations safety
- Works best with automated feedback (tests, linters)

---

### 3. Superpowers Skills

**What it is:** A collection of structured workflow skills for key development moments.

**Available Skills:**

| Skill | Phase | Purpose |
|-------|-------|---------|
| `/brainstorming` | Phase 0 | Explore requirements before planning |
| `/writing-plans` | Phase 1 | Structure implementation approach |
| `/test-driven-development` | Phase 2 | Write tests before implementation |
| `/systematic-debugging` | Phase 2/3 | Analyze bugs before fixing |
| `/verification-before-completion` | Phase 3 | Verify claims before marking done |
| `/requesting-code-review` | Phase 3/4 | Prepare code for human review |
| `/using-git-worktrees` | Any | Create isolated workspace |
| `/finishing-a-development-branch` | Phase 4 | Merge/PR workflow guidance |
| `/dispatching-parallel-agents` | Any | Run independent tasks concurrently |
| `/subagent-driven-development` | Any | Execute plans with task agents |
| `/reflect` | Phase 4 | Capture session learnings |

**Philosophy:** Skills provide **structured moments** in workflows rather than replacing workflows entirely.

---

### 4. Stop Hooks

**What they are:** Shell scripts that run when Claude attempts to exit, with power to block exits or feed new prompts.

**Core Mechanism:**
```
Claude: "Task complete, exiting..."
  ↓
Stop Hook Runs
  ↓
Hook checks condition
  ↓
If PASS: exit 0 (allow exit)
If FAIL: exit 1 (block exit, optionally feed new prompt)
```

**Key Powers:**
1. **Block exits** - Prevent Claude from exiting until conditions met
2. **Feed prompts** - Echo text to feed back to Claude (Ralph mechanism)
3. **Run commands** - Execute tests, linters, validators
4. **Read state** - Check files, git status, task lists
5. **Enforce gates** - Validate artifacts, constitution compliance

**Hook Priorities:**
- **1-10:** Ralph Loop control
- **11-30:** Quality gates (tests, constitution)
- **31-50:** Artifact validation
- **51-80:** Security and performance
- **81-999:** Post-processing (commits, learning)

---

## How They Integrate

The integration creates **layered automation**:

```
┌─────────────────────────────────────────────────────────────┐
│                    USER REQUEST                             │
│              "Build user authentication"                    │
└───────────────────────┬─────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│               ORCHESTRATION SKILL                           │
│         (Manages 4-phase workflow)                          │
└───────────────────────┬─────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│                  PERSONAS                                   │
│   Product Owner → Solutions Architect → Developer          │
│          → QA Engineer → Technical Writer                   │
│                                                             │
│   (Define WHAT each phase produces)                         │
└───────────────────────┬─────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│              SUPERPOWERS SKILLS                             │
│   /brainstorming, /test-driven-development,                 │
│   /verification-before-completion, /reflect                 │
│                                                             │
│   (Provide structured moments at key points)                │
└───────────────────────┬─────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│                  RALPH LOOP                                 │
│   (Iterative execution engine for implementation)           │
│                                                             │
│   Iteration N:                                              │
│     1. Read task list                                       │
│     2. Implement next task                                  │
│     3. Run tests                                            │
│     4. Try to exit                                          │
│     5. Stop hooks intercept                                 │
│     6. Check for promise                                    │
│     7. If not found → feed prompt back                      │
│                                                             │
│   (Self-corrects until success criteria met)                │
└───────────────────────┬─────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│                  STOP HOOKS                                 │
│   (Enforcement & automation layer)                          │
│                                                             │
│   01-ralph-loop.sh → Ralph continuation logic               │
│   10-constitution-check.sh → Validate against rules         │
│   20-test-validation.sh → Run tests, block on fail          │
│   30-artifact-gates.sh → Verify required outputs exist      │
│   40-persona-handoff.sh → Auto-transition personas          │
│   90-auto-commit.sh → Commit if all checks pass             │
│   99-session-learning.sh → Prompt for reflection            │
│                                                             │
│   (Enforce quality gates and trigger transitions)           │
└───────────────────────┬─────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────────┐
│               CONSTITUTION.md                               │
│   (Non-negotiable source of truth)                          │
│                                                             │
│   - Tech stack rules                                        │
│   - Coding standards                                        │
│   - Security requirements                                   │
│   - Performance targets                                     │
│                                                             │
│   (Referenced by personas, validated by hooks)              │
└─────────────────────────────────────────────────────────────┘
```

### Integration Points

#### 1. Orchestration → Personas
- `/orchestrate` skill reads persona files from `personas/`
- Invokes personas in sequence by phase
- Passes context (PRD, Tech Spec) between personas

#### 2. Personas → CONSTITUTION.md
- Every persona references CONSTITUTION.md for rules
- Tech stack validated against mandated technologies
- Coding patterns follow constitution standards
- Security requirements enforced

#### 3. Personas → Ralph Loop
- Implementation phase uses Ralph Loop for task execution
- Specialist Developer persona behavior during iterations
- Ralph continues until all tasks complete

#### 4. Ralph Loop → Stop Hooks
- Ralph state file created: `.claude/.ralph-loop.local.md`
- Stop hook checks for completion promise
- If not found, feeds same prompt back
- If found or max iterations reached, allows exit

#### 5. Stop Hooks → CONSTITUTION.md
- Constitution hook parses CONSTITUTION.md
- Validates naming conventions
- Checks for prohibited technologies
- Verifies error handling patterns
- Blocks on violations

#### 6. Stop Hooks → Artifacts
- Artifact gate hook checks required files exist
- Validates against phase requirements
- Blocks phase advancement if missing
- Example: Can't start implementation without Tech Spec

#### 7. Superpowers → Phases
- `/brainstorming` before Phase 1 (planning)
- `/test-driven-development` before Phase 2 (implementation)
- `/verification-before-completion` during Phase 3 (review)
- `/reflect` at end of Phase 4 (documentation)

#### 8. Session Learnings → Future Sessions
- `/reflect` captures patterns, mistakes, decisions
- Stored in `.claude/learnings/`
- Auto-loaded in next session
- Informs future orchestration

---

## The Complete Workflow

### Phase 0: Pre-Planning (Optional)

**When:** Feature request is vague or complex

**Tools:**
- Superpowers: `/brainstorming`

**Actors:**
- Human + Claude explore requirements interactively

**Outputs:**
- Clarified requirements
- Design approach consensus

**Stop Hooks:** None (interactive phase)

---

### Phase 1: Planning & Design

#### Phase 1.1: Product Requirements

**Tools:**
- Persona: Product Owner
- Prompt: `prompts/phase-1-planning/1.1-product-owner-prd.md`

**Process:**
1. Read feature request
2. Ask clarifying questions
3. Create PRD with user stories
4. Define acceptance criteria
5. Write to `docs/[feature]-prd.md`

**Stop Hook Gates:**
- ✓ PRD file exists
- ✓ Contains ≥3 user stories
- ✓ Each story has acceptance criteria
- ✓ Aligns with CONSTITUTION.md principles (simplicity, user-centric)

**Checkpoint:** Human approval required to proceed

---

#### Phase 1.2: Technical Specification

**Tools:**
- Persona: Solutions Architect
- Prompt: `prompts/phase-1-planning/1.2-architect-tech-spec.md`
- Superpowers: `/writing-plans` (optional alternative)

**Process:**
1. Read PRD
2. Design architecture
3. Define data models
4. Specify API endpoints
5. Identify file changes
6. Write to `docs/[feature]-tech-spec.md`

**Stop Hook Gates:**
- ✓ Tech Spec file exists
- ✓ References PRD user stories
- ✓ Tech stack matches CONSTITUTION.md
- ✓ No prohibited technologies
- ✓ Type sharing patterns followed (TypeScript)

**Checkpoint:** Human approval required to proceed

---

#### Phase 1.3: Optional - DB/API Design

**Tools:**
- Persona: Solutions Architect
- Prompts:
  - `prompts/phase-1-planning/1.3-architect-database-schema.md`
  - `prompts/phase-1-planning/1.4-architect-api-design.md`

**Process:**
1. Read Tech Spec
2. Design database schema (if DB changes)
3. Design API spec (if new endpoints)
4. Write to `docs/[feature]-schema.sql` and `docs/[feature]-api.yaml`

**Stop Hook Gates:**
- ✓ Schema includes indexes and constraints
- ✓ API spec is OpenAPI 3.0 compliant
- ✓ Follows REST/GraphQL conventions per constitution

---

### Phase 2: Implementation

#### Phase 2.1: Task List Generation

**Tools:**
- Persona: Solutions Architect (task breakdown mode)
- Prompt: `prompts/phase-2-implementation/2.1-generate-task-list.md`

**Process:**
1. Read Tech Spec
2. Break into 10-30 discrete tasks
3. Each task: 30-60 min, independently testable
4. Order by dependencies
5. Write to `docs/[feature]-tasks.md`

**Task Format:**
```markdown
- [ ] Task 1: Setup database migration
  - Create migration file
  - Add indexes
  - Acceptance: Migration runs cleanly

- [ ] Task 2: Implement POST /api/users endpoint
  - Route handler
  - Input validation (Zod)
  - Unit tests (>80% coverage)
  - Acceptance: Tests pass, returns 201
```

**Stop Hook Gates:**
- ✓ Task list exists
- ✓ Each task has acceptance criteria
- ✓ Ordered by dependencies
- ✓ Estimated 10-30 tasks (warn if >50)

---

#### Phase 2.2: Test-Driven Development Setup

**Tools:**
- Superpowers: `/test-driven-development`

**Process:**
1. Read task list and acceptance criteria
2. Create test files (one per component)
3. Write failing tests for expected behavior
4. Document test strategy

**Outputs:**
- Test files created (empty implementations)
- Test suite ready (all failing)

**Stop Hook Gates:** None (tests will fail initially, expected)

---

#### Phase 2.3: Ralph Loop Implementation

**Tools:**
- Ralph Loop (iterative execution engine)
- Persona: Specialist Developer
- Prompt: `prompts/phase-2-implementation/2.2-iterative-implementation.md`

**Ralph Loop Start:**
```bash
/ralph-loop "Implement tasks from docs/[feature]-tasks.md one at a time.

For each task:
1. Read CONSTITUTION.md for coding standards
2. Follow type sharing patterns (single source of truth)
3. Write code with meaningful comments (explain WHY, not WHAT)
4. Run tests after implementation
5. Mark task complete in task list with ✓
6. Commit with message: 'feat: [task description]'

Continue until all tasks marked complete.
Output <promise>ALL TASKS COMPLETE</promise> when done."
--completion-promise "ALL TASKS COMPLETE"
--max-iterations 50
```

**Ralph Iteration Pattern:**

Each iteration:
```
[Iteration N]
1. Claude reads task list
2. Finds next incomplete task
3. Reads CONSTITUTION.md for standards
4. Implements task (Specialist Developer persona)
5. Runs tests
6. Marks task complete
7. Commits to git
8. Tries to exit

Stop Hooks Run:
  → 01-ralph-loop.sh: Check for promise
     - Not found → Feed same prompt back (iteration continues)
  → 10-constitution-check.sh: Validate code
     - Naming conventions ✓
     - Error handling ✓
     - No prohibited patterns ✓
  → 20-test-validation.sh: Run test suite
     - All tests pass ✓
     - Coverage >70% ✓

  If all hooks pass:
    → 90-auto-commit.sh: Commit changes
    → Loop continues with next task

  If any hook fails:
    → Block exit
    → Show error
    → Loop continues to fix issue
```

**Ralph Completion:**
```
[Iteration 18]
  → All tasks marked complete
  → Claude outputs: <promise>ALL TASKS COMPLETE</promise>

Stop Hooks Run:
  → 01-ralph-loop.sh: Promise detected! Allow exit.

✓ Ralph Loop complete (18/18 tasks)
```

**Stop Hook Gates (run every iteration):**
- ✓ Tests passing
- ✓ Constitution compliance
- ✓ No security vulnerabilities
- ✓ Code formatted and linted
- ✓ Commits follow convention

**Result:**
- All 10-30 tasks implemented
- Tests passing
- Code committed
- No constitution violations

---

### Phase 3: Review & Refactoring

#### Phase 3.1: QA Engineer Comprehensive Review

**Tools:**
- Persona: QA Engineer
- Prompt: `prompts/phase-3-review/3.1-qa-comprehensive-review.md`

**Process:**
1. Review all code changes since Phase 2 started
2. Identify issues (CRITICAL, HIGH, MEDIUM, LOW)
3. Find edge cases not covered
4. Check security (OWASP Top 10)
5. Analyze test coverage
6. Review code quality
7. Write to `docs/[feature]-qa-review.md`

**Output Format:**
```markdown
# QA Review: [Feature Name]

## Summary
- Issues Found: 8 (0 CRITICAL, 2 HIGH, 4 MEDIUM, 2 LOW)
- Test Coverage: 87%
- Security: 2 vulnerabilities found
- Recommendation: Fix HIGH issues before shipping

## Issues Found

### CRITICAL
(None)

### HIGH
1. **Missing rate limiting on /login endpoint**
   - Location: src/api/auth.ts:45
   - Risk: Brute force attack vector
   - Remediation: Add rate limiting (5 attempts/15 min)

2. **Password reset tokens don't expire**
   - Location: src/services/auth.service.ts:120
   - Risk: Token reuse attack
   - Remediation: Add 1-hour expiration

### MEDIUM
...

## Edge Cases
...

## Test Coverage Gaps
...
```

**Stop Hook Gates:**
- ✓ QA Review file exists
- ✓ Issues categorized by severity
- ✓ Each issue has remediation plan

**Checkpoint:** Human approval required - Review issues, decide to fix now or defer

---

#### Phase 3.2: Fix Issues

**Tools:**
- Ralph Loop (if multiple issues) OR Manual implementation
- Persona: Specialist Developer

**Process:**
1. For each CRITICAL/HIGH issue:
   - Implement fix
   - Add test for the issue
   - Mark issue resolved in QA Review
2. Re-run QA review if desired

**Stop Hook Gates:**
- ✓ No CRITICAL issues remaining
- ✓ HIGH issues resolved or documented as acceptable risk

---

#### Phase 3.3: Verification Before Completion

**Tools:**
- Superpowers: `/verification-before-completion`

**Process:**
1. Verify all claims made are accurate
2. Run full test suite (unit + integration)
3. Check acceptance criteria from PRD
4. Validate no regressions
5. Confirm constitution compliance

**Stop Hook Gates:**
- ✓ All tests passing
- ✓ Acceptance criteria met
- ✓ No constitution violations
- ✓ No CRITICAL/HIGH issues unresolved

---

### Phase 4: Documentation

#### Phase 4.1: Technical Writer Documentation

**Tools:**
- Persona: Technical Writer
- Prompt: `prompts/phase-4-documentation/4.1-readme-generator.md`

**Process:**
1. Read PRD, Tech Spec, implemented code
2. Create or update `README.md`
3. Include:
   - **What:** Feature description (user-facing)
   - **Why:** Problem it solves
   - **How to use:** Code examples (tested)
   - **API reference:** New endpoints documented
   - **Setup:** New dependencies or env vars
   - **Troubleshooting:** Common issues

**Optional Docs:**
- User guide (non-technical audience)
- API documentation (public APIs)
- Architecture decision records (complex decisions)

**Stop Hook Gates:**
- ✓ README.md updated
- ✓ Code examples tested (actually work)
- ✓ All public APIs documented
- ✓ New env vars listed

---

#### Phase 4.2: Session Reflection

**Tools:**
- Superpowers: `/reflect`

**Process:**
1. Review session work
2. Capture learnings:
   - **Patterns** - What worked well
   - **Mistakes** - What to avoid
   - **Decisions** - Key choices and rationale
3. Update learning files:
   - `.claude/learnings/insights.md`
   - `.claude/learnings/decisions.md`
   - `.claude/learnings/gotchas.md`

**Stop Hook:**
- 99-session-learning.sh prompts for `/reflect` if significant work done

---

#### Phase 4.3: Request Code Review

**Tools:**
- Superpowers: `/requesting-code-review`

**Process:**
1. Summarize changes made
2. Highlight key architectural decisions
3. List potential concerns for reviewer
4. Prepare PR description
5. Request human review

**Checkpoint:** Human final review before merge

---

#### Phase 4.4: Finishing the Branch

**Tools:**
- Superpowers: `/finishing-a-development-branch`

**Process:**
1. Present options: Merge, PR, or cleanup
2. Execute chosen workflow
3. Clean up temporary files
4. Archive artifacts

**Output:** Feature complete and integrated

---

## Stop Hook Architecture

### Hook Directory Structure

```
~/.claude/hooks/stop/              # Global hooks (all projects)
  ├── 01-ralph-loop.sh
  ├── 10-constitution-check.sh
  ├── 20-test-validation.sh
  ├── 30-artifact-gates.sh
  ├── 40-persona-handoff.sh
  ├── 50-security-audit.sh
  ├── 60-quality-gates.sh
  ├── 90-auto-commit.sh
  └── 99-session-learning.sh

.claude/hooks/stop/                # Project-specific hooks (override global)
  └── 15-custom-validation.sh
```

**Priority Order:**
- Hooks run in numerical order (01 before 10 before 20, etc.)
- Project hooks can override global hooks (same filename)
- Lower numbers = higher priority

---

### Hook Descriptions

#### 01-ralph-loop.sh (Priority: Highest)

**Purpose:** Ralph Loop control mechanism

**Logic:**
```bash
#!/bin/bash

RALPH_STATE=".claude/.ralph-loop.local.md"

if [ ! -f "$RALPH_STATE" ]; then
  exit 0  # No Ralph active, skip
fi

# Extract state
ITERATIONS=$(grep "iterations:" "$RALPH_STATE" | cut -d: -f2)
MAX_ITER=$(grep "max_iterations:" "$RALPH_STATE" | cut -d: -f2)
PROMISE_TEXT=$(grep "completion_promise:" "$RALPH_STATE" | cut -d: -f2-)

# Check for completion promise in last output
if grep -q "<promise>$PROMISE_TEXT</promise>" .claude/last-response.txt; then
  echo "✓ Ralph Loop complete (promise detected)"
  rm "$RALPH_STATE"
  exit 0  # Allow exit
fi

# Check max iterations
if [ "$ITERATIONS" -ge "$MAX_ITER" ]; then
  echo "✓ Ralph Loop complete (max iterations reached: $MAX_ITER)"
  rm "$RALPH_STATE"
  exit 0  # Allow exit
fi

# Continue Ralph - increment and feed prompt back
NEW_ITER=$((ITERATIONS + 1))
sed -i '' "s/iterations: $ITERATIONS/iterations: $NEW_ITER/" "$RALPH_STATE"

PROMPT=$(grep "prompt:" "$RALPH_STATE" | cut -d: -f2-)
echo "$PROMPT"
exit 1  # Block exit, continue loop
```

**When it blocks:** Ralph active and no completion promise detected

**When it allows:** Promise detected OR max iterations reached

---

#### 10-constitution-check.sh

**Purpose:** Validate code against CONSTITUTION.md rules

**Logic:**
```bash
#!/bin/bash

CONSTITUTION="CONSTITUTION.md"

if [ ! -f "$CONSTITUTION" ]; then
  exit 0  # No constitution, skip
fi

# Skip if Ralph not active (let Ralph handle iterations)
if [ -f ".claude/.ralph-loop.local.md" ]; then
  exit 0
fi

ERRORS=0

# Extract tech stack from constitution
PROHIBITED_TECH=$(grep -A 10 "### Prohibited Technologies" "$CONSTITUTION" | grep "^- ❌")

# Check for prohibited tech in code
if git diff --cached --name-only | grep -E '\.(js|ts|py|go)$'; then
  for tech in $PROHIBITED_TECH; do
    TECH_NAME=$(echo "$tech" | sed 's/- ❌ //' | cut -d'-' -f1 | xargs)
    if git diff --cached | grep -iq "$TECH_NAME"; then
      echo "❌ Constitution violation: Prohibited technology '$TECH_NAME' found"
      ERRORS=$((ERRORS + 1))
    fi
  done
fi

# Check naming conventions
JS_FILES=$(git diff --cached --name-only | grep -E '\.js$|\.ts$')
for file in $JS_FILES; do
  # Check for snake_case in JS/TS (should be camelCase)
  if git diff --cached "$file" | grep -E 'const [a-z]+_[a-z]+' | grep -v test; then
    echo "❌ Constitution violation in $file: Use camelCase, not snake_case"
    ERRORS=$((ERRORS + 1))
  fi
done

# Check error handling
for file in $JS_FILES; do
  # Check for bare try/catch (must have specific errors)
  if git diff --cached "$file" | grep -E 'catch\s*\(\s*\)' | grep -v '//'; then
    echo "❌ Constitution violation in $file: Empty catch blocks not allowed"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ $ERRORS -gt 0 ]; then
  echo ""
  echo "Fix constitution violations before proceeding."
  exit 1  # Block exit
fi

exit 0  # Allow exit
```

**When it blocks:** Constitution violations found

**When it allows:** No violations OR Ralph Loop active (let Ralph iterate)

---

#### 20-test-validation.sh

**Purpose:** Run tests, block on failure

**Logic:**
```bash
#!/bin/bash

# Skip if no code changes
if [ -z "$(git diff --name-only | grep -E '\.(js|ts|py|go)$')" ]; then
  exit 0
fi

# Skip if Ralph not active (let Ralph handle test failures)
if [ -f ".claude/.ralph-loop.local.md" ]; then
  # Ralph active - still run tests but allow iteration on failure
  npm test 2>&1 | tee .claude/test-output.txt
  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "❌ Tests failed (Ralph will iterate to fix)"
    exit 1  # Block, let Ralph continue
  fi
  exit 0
fi

# Not Ralph - run tests, block on failure
echo "Running tests before exit..."
npm test

if [ $? -ne 0 ]; then
  echo ""
  echo "❌ Tests failed. Fix tests before exiting."
  exit 1  # Block exit
fi

# Check coverage
COVERAGE=$(npm test -- --coverage 2>/dev/null | grep "All files" | awk '{print $10}' | tr -d '%')
if [ "$COVERAGE" -lt 70 ]; then
  echo "⚠️  Warning: Test coverage is $COVERAGE% (target: >70%)"
  # Warn but don't block
fi

echo "✓ Tests passing (coverage: $COVERAGE%)"
exit 0
```

**When it blocks:** Tests fail

**When it allows:** Tests pass

---

#### 30-artifact-gates.sh

**Purpose:** Verify required artifacts exist for each phase

**Logic:**
```bash
#!/bin/bash

PHASE=$(cat .claude/workflow-state.yaml 2>/dev/null | grep "current_phase:" | cut -d: -f2 | xargs)

if [ -z "$PHASE" ]; then
  exit 0  # No orchestration active, skip
fi

case "$PHASE" in
  "planning")
    # Must have PRD before tech spec
    if [ ! -f "docs/"*"-prd.md" ]; then
      echo "❌ Artifact Gate: Missing PRD (required for planning phase)"
      exit 1
    fi

    # If trying to advance, must have tech spec too
    if cat .claude/last-command.txt | grep -q "next phase"; then
      if [ ! -f "docs/"*"-tech-spec.md" ]; then
        echo "❌ Artifact Gate: Missing Tech Spec (required before implementation)"
        exit 1
      fi
    fi
    ;;

  "implementation")
    # Must have tech spec and task list
    if [ ! -f "docs/"*"-tech-spec.md" ]; then
      echo "❌ Artifact Gate: Missing Tech Spec"
      exit 1
    fi

    if [ ! -f "docs/"*"-tasks.md" ]; then
      echo "❌ Artifact Gate: Missing Task List"
      exit 1
    fi
    ;;

  "review")
    # Must have completed tasks
    INCOMPLETE=$(grep -c "^\- \[ \]" docs/*-tasks.md 2>/dev/null)
    if [ "$INCOMPLETE" -gt 0 ]; then
      echo "❌ Artifact Gate: $INCOMPLETE tasks incomplete"
      exit 1
    fi

    # Must have QA review before docs
    if cat .claude/last-command.txt | grep -q "documentation"; then
      if [ ! -f "docs/"*"-qa-review.md" ]; then
        echo "❌ Artifact Gate: Missing QA Review"
        exit 1
      fi
    fi
    ;;
esac

exit 0  # Gates passed
```

**When it blocks:** Required artifacts missing for current phase

**When it allows:** All artifacts exist

---

#### 40-persona-handoff.sh

**Purpose:** Auto-transition to next persona when artifacts complete

**Logic:**
```bash
#!/bin/bash

CURRENT_PERSONA=$(cat .claude/workflow-state.yaml 2>/dev/null | grep "current_persona:" | cut -d: -f2 | xargs)

if [ -z "$CURRENT_PERSONA" ]; then
  exit 0  # No orchestration active, skip
fi

# Define handoff chain
declare -A NEXT_PERSONA=(
  ["product-owner"]="solutions-architect"
  ["solutions-architect"]="specialist-developer"
  ["specialist-developer"]="qa-engineer"
  ["qa-engineer"]="technical-writer"
  ["technical-writer"]="complete"
)

# Check if current persona's artifacts are complete
ARTIFACT_COMPLETE=false

case "$CURRENT_PERSONA" in
  "product-owner")
    [ -f "docs/"*"-prd.md" ] && ARTIFACT_COMPLETE=true
    ;;
  "solutions-architect")
    [ -f "docs/"*"-tech-spec.md" ] && ARTIFACT_COMPLETE=true
    ;;
  "specialist-developer")
    INCOMPLETE=$(grep -c "^\- \[ \]" docs/*-tasks.md 2>/dev/null)
    [ "$INCOMPLETE" -eq 0 ] && ARTIFACT_COMPLETE=true
    ;;
  "qa-engineer")
    [ -f "docs/"*"-qa-review.md" ] && ARTIFACT_COMPLETE=true
    ;;
  "technical-writer")
    # Check README updated
    git diff HEAD README.md &>/dev/null && ARTIFACT_COMPLETE=true
    ;;
esac

if [ "$ARTIFACT_COMPLETE" = true ]; then
  NEXT="${NEXT_PERSONA[$CURRENT_PERSONA]}"

  if [ "$NEXT" = "complete" ]; then
    echo "✓ All personas complete!"
    exit 0
  fi

  # Update state
  sed -i '' "s/current_persona: $CURRENT_PERSONA/current_persona: $NEXT/" .claude/workflow-state.yaml

  echo "✓ Handoff: $CURRENT_PERSONA → $NEXT"
  echo ""
  echo "Next persona: $NEXT"
  echo "Loading persona definition from personas/*.md"

  # Could auto-feed next persona prompt here if desired
  # cat "personas/XX-$NEXT.md"
  # exit 1  # Block to feed prompt
fi

exit 0
```

**When it blocks:** Optionally blocks to feed next persona prompt

**When it allows:** Handoff complete or not yet ready

---

#### 50-security-audit.sh

**Purpose:** Security vulnerability scanning

**Logic:**
```bash
#!/bin/bash

# Skip if no dependency changes
if [ -z "$(git diff --name-only | grep -E 'package.json|requirements.txt|go.mod')" ]; then
  exit 0
fi

echo "Running security audit..."

# Check for language and run appropriate audit
if [ -f "package.json" ]; then
  npm audit --audit-level=high 2>&1 | tee .claude/audit-output.txt

  VULNS=$(cat .claude/audit-output.txt | grep -E "high|critical" | wc -l)
  if [ "$VULNS" -gt 0 ]; then
    echo "⚠️  Security: $VULNS high/critical vulnerabilities found"
    echo "Review .claude/audit-output.txt for details"
    # Warn but don't block (QA will catch)
  fi
fi

if [ -f "requirements.txt" ]; then
  pip-audit 2>&1 | tee .claude/audit-output.txt
fi

exit 0  # Warn only, don't block
```

**When it blocks:** Never (warns only)

**When it allows:** Always

---

#### 60-quality-gates.sh

**Purpose:** Code quality checks (linting, formatting, coverage)

**Logic:**
```bash
#!/bin/bash

# Skip if no code changes
if [ -z "$(git diff --name-only | grep -E '\.(js|ts|py|go)$')" ]; then
  exit 0
fi

ERRORS=0

# Linting
if [ -f "package.json" ]; then
  echo "Running linter..."
  npm run lint 2>&1 | tee .claude/lint-output.txt

  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "❌ Linting errors found"
    ERRORS=$((ERRORS + 1))
  fi
fi

# Formatting
if [ -f ".prettierrc" ]; then
  echo "Checking formatting..."
  npx prettier --check "src/**/*.{js,ts,tsx}" 2>&1 | tee .claude/format-output.txt

  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "⚠️  Formatting issues found (can auto-fix with prettier --write)"
    # Warn but don't block
  fi
fi

if [ $ERRORS -gt 0 ]; then
  echo ""
  echo "Fix quality issues before proceeding"
  exit 1  # Block
fi

exit 0
```

**When it blocks:** Linting errors found

**When it allows:** No errors (formatting warnings OK)

---

#### 90-auto-commit.sh

**Purpose:** Auto-commit changes if all checks pass

**Logic:**
```bash
#!/bin/bash

# Only commit if enabled in settings
AUTO_COMMIT=$(grep "autoCommit: true" ~/.claude/CLAUDE.md)
if [ -z "$AUTO_COMMIT" ]; then
  exit 0  # Not enabled, skip
fi

# Skip if Ralph active (Ralph commits per task)
if [ -f ".claude/.ralph-loop.local.md" ]; then
  exit 0
fi

# Skip if no changes
if [ -z "$(git status --porcelain)" ]; then
  exit 0
fi

echo "Auto-committing changes..."

# Determine commit type from files changed
if git diff --name-only | grep -q "test"; then
  TYPE="test"
elif git diff --name-only | grep -q "docs"; then
  TYPE="docs"
elif git diff --name-only | grep -qE '\.(js|ts|py|go)$'; then
  TYPE="feat"
else
  TYPE="chore"
fi

# Generate commit message
CHANGED=$(git diff --name-only | head -5 | xargs)
MESSAGE="$TYPE: Auto-commit (${CHANGED})"

git add .
git commit -m "$MESSAGE

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>" || {
  echo "⚠️  Commit failed (may have nothing to commit)"
}

echo "✓ Changes auto-committed"
exit 0
```

**When it blocks:** Never

**When it allows:** Always (commits if enabled)

---

#### 99-session-learning.sh

**Purpose:** Prompt for session reflection

**Logic:**
```bash
#!/bin/bash

# Only check at end of orchestration
if [ ! -f ".claude/workflow-state.yaml" ]; then
  exit 0  # No orchestration, skip
fi

PHASE=$(grep "current_phase:" .claude/workflow-state.yaml | cut -d: -f2 | xargs)

if [ "$PHASE" != "documentation" ]; then
  exit 0  # Not at end yet, skip
fi

# Check if significant work done
COMMITS=$(git log --since="2 hours ago" --oneline | wc -l)

if [ "$COMMITS" -lt 3 ]; then
  exit 0  # Not enough work to warrant reflection
fi

# Check if already reflected
if grep -q "last_updated: $(date +%Y-%m-%d)" .claude/learnings/insights.md 2>/dev/null; then
  exit 0  # Already reflected today
fi

echo ""
echo "📝 Session complete. Capturing learnings..."
echo ""
echo "Run /reflect to capture:"
echo "  - What worked well (patterns)"
echo "  - Mistakes to avoid"
echo "  - Architectural decisions"
echo ""
echo "(Skipped reflection? You can run /reflect later)"

exit 0  # Suggest only, don't block
```

**When it blocks:** Never (suggests only)

**When it allows:** Always

---

## Setup Guide

### Prerequisites

1. **Claude Code installed** and authenticated
2. **Git repository** initialized
3. **Test framework** configured (Jest, pytest, etc.)
4. **ai-dev-orchestrator** cloned or available

---

### Step 1: Install ai-dev-orchestrator Framework

```bash
# Clone the framework
cd ~/Projects
git clone https://github.com/[your-org]/ai-dev-orchestrator.git

# Or if already cloned, update
cd ~/Projects/ai-dev-orchestrator
git pull
```

---

### Step 2: Copy Constitution to Your Project

```bash
cd /path/to/your-project

# Copy constitution template
cp ~/Projects/ai-dev-orchestrator/CONSTITUTION-TEMPLATE.md CONSTITUTION.md

# Customize for your project
# Edit tech stack, coding standards, etc.
```

**Customize these sections:**
- Mandated Technologies (Frontend, Backend, Database)
- Prohibited Technologies
- Coding Standards (naming, comments, patterns)
- Testing thresholds
- Security requirements

---

### Step 3: Copy Personas

```bash
# Create personas directory
mkdir -p personas

# Copy persona files
cp ~/Projects/ai-dev-orchestrator/personas/*.md personas/

# Optional: Customize personas for your workflow
```

---

### Step 4: Create Stop Hooks Directory

```bash
# Create hooks directory
mkdir -p .claude/hooks/stop

# Or use global hooks
mkdir -p ~/.claude/hooks/stop
```

---

### Step 5: Install Stop Hooks

Create each hook file in `.claude/hooks/stop/` or `~/.claude/hooks/stop/`:

#### Required Hooks

**01-ralph-loop.sh:**
```bash
#!/bin/bash
# [Copy logic from "Stop Hook Architecture" section above]
chmod +x .claude/hooks/stop/01-ralph-loop.sh
```

**10-constitution-check.sh:**
```bash
#!/bin/bash
# [Copy logic from "Stop Hook Architecture" section above]
chmod +x .claude/hooks/stop/10-constitution-check.sh
```

**20-test-validation.sh:**
```bash
#!/bin/bash
# [Copy logic from "Stop Hook Architecture" section above]
chmod +x .claude/hooks/stop/20-test-validation.sh
```

#### Recommended Hooks

```bash
chmod +x .claude/hooks/stop/30-artifact-gates.sh
chmod +x .claude/hooks/stop/40-persona-handoff.sh
chmod +x .claude/hooks/stop/90-auto-commit.sh
```

#### Optional Hooks

```bash
chmod +x .claude/hooks/stop/50-security-audit.sh
chmod +x .claude/hooks/stop/60-quality-gates.sh
chmod +x .claude/hooks/stop/99-session-learning.sh
```

---

### Step 6: Install Superpowers Skills

```bash
# In Claude Code CLI
/plugin superpowers
```

This installs:
- `/brainstorming`
- `/test-driven-development`
- `/verification-before-completion`
- `/requesting-code-review`
- `/reflect`
- etc.

---

### Step 7: Install Ralph Loop Plugin

```bash
# In Claude Code CLI
/plugin ralph-loop
```

This adds:
- `/ralph-loop` command
- `/cancel-ralph` command
- Ralph state management

---

### Step 8: Copy Orchestrate Skill to Project

```bash
# Copy orchestrate skill
mkdir -p .claude/commands
cp ~/Projects/ai-dev-orchestrator/.claude/commands/orchestrate.md .claude/commands/

# Or install globally
cp ~/Projects/ai-dev-orchestrator/.claude/commands/orchestrate.md ~/.claude/commands/
```

---

### Step 9: Create Project CLAUDE.md

```bash
# Create project context file
cat > .claude/CLAUDE.md << 'EOF'
# Project: [Your Project Name]

## Overview
[Brief description]

## Tech Stack
- Frontend: [Framework]
- Backend: [Framework]
- Database: [Database]

## Key Files
- CONSTITUTION.md - Non-negotiable rules
- personas/ - AI persona definitions
- docs/ - Generated artifacts (PRD, Tech Spec, etc.)

## Workflow
This project uses ai-dev-orchestrator with:
- 5 Personas (Product Owner, Solutions Architect, Developer, QA, Writer)
- 4 Phases (Planning, Implementation, Review, Documentation)
- Ralph Loop for iterative implementation
- Stop hooks for quality gates

Use `/orchestrate` to run full workflow.

## Constitution
CONSTITUTION.md is law. All code must comply.

## Learning System
Session learnings captured in .claude/learnings/
EOF
```

---

### Step 10: Initialize Workflow State (Optional)

```bash
# Create workflow state file (will be created by /orchestrate)
mkdir -p .claude
cat > .claude/workflow-state.yaml << 'EOF'
# Orchestration state (managed automatically)
# Do not edit manually
EOF
```

---

### Step 11: Create Learning Directories

```bash
mkdir -p .claude/learnings
touch .claude/learnings/insights.md
touch .claude/learnings/decisions.md
touch .claude/learnings/gotchas.md
```

---

### Step 12: Test Setup

```bash
# Start Claude Code in your project
cd /path/to/your-project
claude-code

# Test orchestration
/orchestrate "Add a simple health check endpoint"
```

This will run through all 4 phases as a test.

---

## Usage Examples

### Example 1: Full Feature Build

```
User: /orchestrate "Build user authentication with email/password and OAuth (Google, GitHub)"

Claude:
  ✓ Reading CONSTITUTION.md
  ✓ Project: TypeScript + React + Express + PostgreSQL
  ✓ Starting Phase 1: Planning

  [Phase 1.1 - Product Owner]
  ✓ Creating PRD at docs/user-auth-prd.md

  PRD Preview:
  - User Story 1: As a new user, I want to sign up with email/password
  - User Story 2: As a user, I want to sign in with Google
  - User Story 3: As a user, I want to sign in with GitHub
  - ... (8 user stories total)

  → Review PRD at docs/user-auth-prd.md. Approve? [y/n]

User: y

Claude:
  [Phase 1.2 - Solutions Architect]
  ✓ Reading PRD
  ✓ Creating Tech Spec at docs/user-auth-tech-spec.md

  Tech Spec Highlights:
  - Database: Add users table with OAuth tokens
  - API: 5 new endpoints (signup, login, oauth-init, oauth-callback, logout)
  - Frontend: Login/Signup components, OAuth buttons
  - Dependencies: passport.js, bcrypt, jsonwebtoken
  - Estimated: 18 tasks, 2-3 days

  → Review Tech Spec. Approve? [y/n]

User: y

Claude:
  [Phase 2.1 - Task Generation]
  ✓ Breaking Tech Spec into tasks
  ✓ Created docs/user-auth-tasks.md (18 tasks)

  Tasks Preview:
  - Task 1: Create users table migration
  - Task 2: Add password hashing utility
  - Task 3: Implement POST /api/auth/signup
  - ... (18 tasks total)

  → Review task list. Start implementation? [y/n]

User: y

Claude:
  [Phase 2.2 - TDD Setup]
  ✓ Running /test-driven-development
  ✓ Created test files:
    - tests/auth/signup.test.ts
    - tests/auth/login.test.ts
    - tests/auth/oauth.test.ts
  ✓ All tests failing (expected)

  [Phase 2.3 - Ralph Loop Implementation]
  ✓ Starting Ralph Loop (max 50 iterations)
  ✓ Specialist Developer persona active

  [Iteration 1]
    → Task 1: Create users table migration
    → Created: migrations/001_create_users.sql
    → Tests: N/A (migration)
    → Committed: feat(auth): create users table migration

  [Iteration 2]
    → Task 2: Add password hashing utility
    → Created: src/utils/password.ts (bcrypt)
    → Tests: password.test.ts passing ✓
    → Coverage: 95%
    → Committed: feat(auth): add password hashing utility

  [Iteration 3]
    → Task 3: Implement POST /api/auth/signup
    → Created: src/api/auth/signup.ts
    → Tests: signup.test.ts passing ✓
    → Stop Hook: Constitution check ✓ (naming: camelCase ✓, error handling ✓)
    → Committed: feat(auth): implement signup endpoint

  ... [continues for 18 iterations] ...

  [Iteration 18]
    → Task 18: Add OAuth callback handling
    → Updated: src/api/auth/oauth.ts
    → Tests: oauth.test.ts passing ✓
    → All tasks complete ✓
    → Output: <promise>ALL TASKS COMPLETE</promise>

  ✓ Ralph Loop complete (18/18 tasks, 23 iterations total)
  ✓ Tests: 87% coverage
  ✓ Constitution: No violations

  [Phase 3.1 - QA Engineer Review]
  ✓ Reviewing 18 commits
  ✓ Running comprehensive analysis
  ✓ Created docs/user-auth-qa-review.md

  QA Summary:
  - Issues: 6 (0 CRITICAL, 2 HIGH, 3 MEDIUM, 1 LOW)
  - Security: 2 vulnerabilities found
  - Coverage: 87% (good)
  - Recommendation: Fix HIGH issues before shipping

  HIGH Issues:
  1. Missing rate limiting on /login endpoint
  2. OAuth tokens stored in plain text (should encrypt)

  → Fix HIGH issues now? [y/n]

User: y

Claude:
  [Fixing HIGH Issues]
  ✓ Added rate limiting (5 attempts/15 min, IP-based)
  ✓ Encrypted OAuth tokens (AES-256)
  ✓ Tests updated and passing
  ✓ Re-ran QA review: No HIGH issues remaining

  [Phase 3.3 - Verification]
  ✓ Running /verification-before-completion
  ✓ All acceptance criteria met
  ✓ No regressions detected
  ✓ Constitution compliant

  [Phase 4.1 - Technical Writer]
  ✓ Updating README.md
  ✓ Added authentication section with examples
  ✓ Documented all 5 API endpoints
  ✓ Added troubleshooting guide

  [Phase 4.2 - Session Reflection]
  ✓ Running /reflect

  Session Learnings:
  Patterns:
  - passport.js OAuth integration was smooth
  - Rate limiting pattern works well for auth endpoints

  Mistakes:
  - Initially forgot to encrypt OAuth tokens (QA caught it)

  Decisions:
  - Chose bcrypt over argon2 (CONSTITUTION mandated bcrypt)
  - Session storage: JWT in HTTP-only cookie

  ✓ Updated .claude/learnings/

  [Phase 4.3 - Request Code Review]
  ✓ Running /requesting-code-review

  Code Review Request:
  Feature: User Authentication (email/password + OAuth)
  Changes: 18 files, +1,200 lines
  Key Decisions:
  - JWT-based sessions
  - OAuth via passport.js
  - Encrypted token storage
  - Rate limiting on auth endpoints

  Review Focus:
  - Security implementation
  - OAuth flow correctness
  - Error handling completeness

  ✓ Orchestration Complete!

  Feature: user-authentication
  Artifacts: PRD, Tech Spec, Tasks, QA Review, README
  Tasks: 18/18 ✓
  Test Coverage: 87%
  Constitution: ✓
  Duration: ~1h 45m (Ralph: 23 iterations)

  Ready to merge. Run /finishing-a-development-branch for PR workflow.
```

---

### Example 2: Skip Planning (Existing Design)

If you already have PRD and Tech Spec:

```
User: /orchestrate --skip-planning --tasks-from docs/payment-processing-tasks.md

Claude:
  ✓ Skipping Phase 1 (planning artifacts already exist)
  ✓ Reading task list from docs/payment-processing-tasks.md
  ✓ Found 12 tasks

  [Phase 2 - Implementation]
  ✓ Starting Ralph Loop (max 50 iterations)

  [Iteration 1]
    → Task 1: Integrate Stripe SDK
    → ...

  [Continues from implementation phase]
```

---

### Example 3: Resume After Interruption

If orchestration was interrupted:

```
User: /orchestrate --resume user-authentication

Claude:
  ✓ Reading workflow state from .claude/workflow-state.yaml
  ✓ Found existing orchestration:
    - Feature: user-authentication
    - Phase: implementation
    - Progress: Task 12/18 complete
    - Last updated: 2 hours ago

  ✓ Resuming from Task 13

  [Phase 2.3 - Ralph Loop (resumed)]

  [Iteration 13]
    → Task 13: Add OAuth state validation
    → ...
```

---

### Example 4: Single Phase Execution

Run only Phase 3 (review):

```
User: /orchestrate --phase review

Claude:
  ✓ Single phase mode: review
  ✓ Skipping planning and implementation

  [Phase 3 - Review]
  ✓ Invoking QA Engineer persona
  ✓ Reviewing all commits since last review
  ✓ Creating docs/qa-review-[timestamp].md
  ...
```

---

## Troubleshooting

### Issue: "Constitution file not found"

**Cause:** CONSTITUTION.md doesn't exist in repo root

**Solution:**
```bash
cp ~/Projects/ai-dev-orchestrator/CONSTITUTION-TEMPLATE.md CONSTITUTION.md
# Then customize for your project
```

---

### Issue: "Persona files not found"

**Cause:** `personas/` directory missing or empty

**Solution:**
```bash
mkdir -p personas
cp ~/Projects/ai-dev-orchestrator/personas/*.md personas/
```

---

### Issue: "Stop hooks not running"

**Cause:** Hooks not created or not executable

**Solution:**
```bash
# Check hooks exist
ls -la .claude/hooks/stop/

# Make executable
chmod +x .claude/hooks/stop/*.sh

# Test hook manually
.claude/hooks/stop/10-constitution-check.sh
```

---

### Issue: "Ralph Loop not stopping"

**Cause:** No completion promise detected

**Solution:**
1. Check promise format: `<promise>EXACT_TEXT</promise>`
2. Verify promise text matches `--completion-promise` argument
3. Check max-iterations not exceeded
4. Inspect Ralph state: `cat .claude/.ralph-loop.local.md`

---

### Issue: "Tests failing during Ralph Loop"

**Cause:** Expected - Ralph iterates to fix

**Behavior:**
- Ralph sees test failure
- Attempts fix
- Re-runs tests
- Repeats until passing

**If stuck in loop:**
- Check test output: `cat .claude/test-output.txt`
- Ralph will pause after 3 consecutive failures
- Can cancel with `/cancel-ralph` and fix manually

---

### Issue: "Constitution violations not blocking"

**Cause:** Constitution hook not configured or skipped

**Solution:**
```bash
# Verify hook exists and is executable
test -x .claude/hooks/stop/10-constitution-check.sh && echo "Hook OK" || echo "Hook missing or not executable"

# Check hook runs
.claude/hooks/stop/10-constitution-check.sh

# Verify hook has correct logic (parse CONSTITUTION.md)
cat .claude/hooks/stop/10-constitution-check.sh
```

---

### Issue: "Artifacts not found during gates"

**Cause:** Artifacts created with wrong names or locations

**Expected Locations:**
- PRD: `docs/*-prd.md`
- Tech Spec: `docs/*-tech-spec.md`
- Task List: `docs/*-tasks.md`
- QA Review: `docs/*-qa-review.md`

**Solution:**
```bash
# Check artifact naming
ls docs/

# Rename if needed
mv docs/wrong-name.md docs/feature-name-prd.md
```

---

### Issue: "Auto-commit not working"

**Cause:** Auto-commit hook not installed or disabled in settings

**Solution:**
```bash
# Verify setting enabled in CLAUDE.md
grep "autoCommit: true" ~/.claude/CLAUDE.md

# If not enabled, add to CLAUDE.md
echo "autoCommit: true" >> ~/.claude/CLAUDE.md

# Verify hook exists
test -x .claude/hooks/stop/90-auto-commit.sh && echo "Hook OK"
```

---

### Issue: "Orchestration feels slow"

**Optimization Options:**

1. **Use Quick Mode:**
```
/orchestrate --skip-planning
```

2. **Increase Ralph max-iterations:**
```
# In orchestrate.md, change --max-iterations 50 to 100
```

3. **Skip optional phases:**
```
/orchestrate --phase implementation  # Only implement
```

4. **Use haiku for simple tasks:**
```
/model haiku
/orchestrate [simple task]
```

---

## Advanced Topics

### Custom Personas

Create custom personas for specialized needs:

**Example: DevOps Engineer Persona**

```markdown
# Persona: DevOps Engineer

## Role Definition
Handles deployment, infrastructure, and operational concerns.

## Core Responsibilities
1. Create Docker/Kubernetes configs
2. Set up CI/CD pipelines
3. Configure monitoring and logging
4. Optimize build and deployment

## When to Invoke
- After implementation phase
- Before production deployment
- When adding infrastructure

## Key Artifacts
- `docker-compose.yml` - Local development
- `.github/workflows/*.yml` - CI/CD
- `k8s/*.yaml` - Kubernetes manifests
- `docs/deployment-guide.md` - Runbook

## Critical Rules
- Follow 12-factor app principles
- All secrets in environment variables
- Health checks required for all services
- Monitoring on all critical paths
```

**Integrate into orchestration:**
1. Add to `personas/06-devops-engineer.md`
2. Update orchestrate.md to invoke after Phase 3
3. Create stop hook for deployment validation

---

### Custom Stop Hooks

Add project-specific validation:

**Example: API Schema Validation Hook**

```bash
#!/bin/bash
# .claude/hooks/stop/25-api-schema-validation.sh

# Only check if API changes
if [ -z "$(git diff --name-only | grep 'src/api')" ]; then
  exit 0
fi

echo "Validating API schemas..."

# Check OpenAPI spec exists and is valid
if [ ! -f "docs/api-spec.yaml" ]; then
  echo "❌ API changes detected but no docs/api-spec.yaml found"
  exit 1
fi

# Validate OpenAPI format
npx swagger-cli validate docs/api-spec.yaml

if [ $? -ne 0 ]; then
  echo "❌ OpenAPI spec validation failed"
  exit 1
fi

echo "✓ API schema valid"
exit 0
```

**Install:**
```bash
chmod +x .claude/hooks/stop/25-api-schema-validation.sh
```

---

### Multi-Project Orchestration

Coordinate changes across multiple repos:

**Example: Microservices Workflow**

```bash
# In parent directory
/orchestrate "Add payment processing feature across 3 services"

Claude:
  ✓ Detected multi-repo context
  ✓ Services: api-gateway, payment-service, notification-service

  [Phase 1 - Planning]
  ✓ Creating PRD for entire feature
  ✓ Creating Tech Spec for each service:
    - api-gateway: Add payment routes
    - payment-service: Stripe integration
    - notification-service: Payment confirmations

  [Phase 2 - Implementation]
  ✓ Running parallel orchestrations:
    - /orchestrate --service api-gateway
    - /orchestrate --service payment-service
    - /orchestrate --service notification-service

  [Uses /dispatching-parallel-agents for concurrent work]
```

---

### Integration with External Systems

#### Jira/Linear Integration

Hook to create tasks in project management:

```bash
#!/bin/bash
# .claude/hooks/stop/95-create-jira-tasks.sh

# After QA review, create Jira tickets for issues
if [ -f "docs/"*"-qa-review.md" ]; then
  HIGH_ISSUES=$(grep "### HIGH" docs/*-qa-review.md -A 10 | grep "^[0-9]")

  for issue in $HIGH_ISSUES; do
    # Create Jira ticket via API
    curl -X POST https://your-company.atlassian.net/rest/api/3/issue \
      -H "Content-Type: application/json" \
      -d "{
        \"fields\": {
          \"project\": {\"key\": \"PROJ\"},
          \"summary\": \"$issue\",
          \"issuetype\": {\"name\": \"Bug\"},
          \"priority\": {\"name\": \"High\"}
        }
      }"
  done
fi
```

#### Slack Notifications

Notify team of orchestration milestones:

```bash
#!/bin/bash
# .claude/hooks/stop/96-slack-notify.sh

PHASE=$(cat .claude/workflow-state.yaml | grep "current_phase:" | cut -d: -f2 | xargs)

if [ "$PHASE" = "review" ]; then
  FEATURE=$(cat .claude/workflow-state.yaml | grep "feature_name:" | cut -d: -f2 | xargs)

  curl -X POST https://hooks.slack.com/services/YOUR/WEBHOOK/URL \
    -H "Content-Type: application/json" \
    -d "{\"text\": \"🚀 Feature '$FEATURE' ready for QA review\"}"
fi
```

---

### Performance Optimization

#### Caching Persona Behavior

Cache persona files to reduce reads:

```bash
# In orchestrate.md, add caching logic
PERSONA_CACHE=".claude/.persona-cache"

if [ ! -d "$PERSONA_CACHE" ]; then
  mkdir -p "$PERSONA_CACHE"
  cp personas/*.md "$PERSONA_CACHE/"
fi

# Read from cache instead of personas/
```

#### Parallel Phase Execution

For independent changes, run phases in parallel:

```
User: /orchestrate "Add health check endpoint" --parallel

Claude:
  ✓ Analyzing dependencies: None (independent feature)
  ✓ Running phases in parallel:
    - Phase 1 (Planning) - Agent A
    - Phase 2 (Implementation) - Agent B (waits for Phase 1)
    - Phase 4 (Documentation) - Agent C (starts early)

  [Uses /dispatching-parallel-agents]
```

---

### Advanced Ralph Patterns

#### Ralph with Checkpoints

Pause Ralph for human review every N iterations:

```bash
# Modify 01-ralph-loop.sh to add checkpoint logic
ITERATIONS=$(grep "iterations:" "$RALPH_STATE" | cut -d: -f2)

if [ $((ITERATIONS % 5)) -eq 0 ]; then
  echo "Checkpoint: $ITERATIONS iterations complete"
  echo "Review progress before continuing? [y/n]"
  read -t 30 RESPONSE

  if [ "$RESPONSE" = "n" ]; then
    exit 1  # Continue Ralph
  fi
fi
```

#### Ralph with Dynamic Max-Iterations

Adjust max-iterations based on task complexity:

```bash
# In orchestrate.md
TASK_COUNT=$(grep -c "^\- \[ \]" docs/*-tasks.md)
MAX_ITER=$((TASK_COUNT * 3))  # 3 iterations per task

/ralph-loop "..." --max-iterations $MAX_ITER
```

---

### Constitutional Evolution

Version and evolve your CONSTITUTION.md:

```markdown
# CONSTITUTION.md

## Revision History

### v2.0.0 - 2026-01-28
**Changes:**
- Migrated from Express to Fastify (performance)
- Added GraphQL support
- Increased test coverage requirement (70% → 85%)

**Rationale:**
- Fastify 2x faster than Express in benchmarks
- GraphQL reduces API endpoints from 20 → 5
- Higher coverage needed as codebase matured

**Approved by:** @malcolm, @team
**Migration plan:** docs/fastify-migration.md

### v1.0.0 - 2025-11-15
**Initial Constitution**
- Tech stack: Express, React, PostgreSQL
- Standards: camelCase, 70% coverage
```

**Hook to enforce version:**
```bash
# Check constitution version in hook
CONST_VERSION=$(grep "### v" CONSTITUTION.md | head -1 | cut -d'v' -f2 | cut -d' ' -f1)
if [ "$CONST_VERSION" != "2.0.0" ]; then
  echo "⚠️  Constitution outdated (current: $CONST_VERSION, expected: 2.0.0)"
fi
```

---

## Conclusion

This integration creates a **fully autonomous AI development pipeline** that:

1. **Respects governance** (CONSTITUTION.md as law)
2. **Specializes work** (Personas for each phase)
3. **Iterates until success** (Ralph Loop self-correction)
4. **Enforces quality** (Stop hooks as gates)
5. **Structures key moments** (Superpowers skills)
6. **Learns continuously** (Session reflection)
7. **Requires human approval only at checkpoints** (not micro-decisions)

The result is **high-quality, consistent code** that follows your standards automatically, with AI handling the repetitive work while humans focus on strategic decisions.

---

**Questions?**

- Review this guide's examples
- Check ai-dev-orchestrator README
- Inspect your stop hooks
- Test with simple features first
- Iterate on your CONSTITUTION.md

**Happy orchestrating!** 🚀