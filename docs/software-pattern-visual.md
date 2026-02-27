# Software Development Pattern - Visual Guide

**The structured approach to AI-assisted software development**

> **Note:** This is the software-specific implementation of the universal AI orchestration pattern. For the cross-domain version (grants, content, design), see the [AI Workflow Orchestrator](https://github.com/Optiminz/ai-workflow-orchestrator/blob/main/core/universal-pattern-visual.md).

---

## The Core Pattern for Software

```
┌─────────────────────────────────────────────────────────────────┐
│                     CONSTITUTION.md                              │
│              Non-negotiable software principles                  │
│                                                                  │
│  • Tech Stack: What you use & what you don't                   │
│  • Security: Authentication, data handling, input validation    │
│  • Coding Standards: Naming, formatting, comments               │
│  • Testing: Coverage thresholds, test types                     │
│  • Performance: Response time targets, optimization rules       │
└─────────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│                   5 SPECIALIZED PERSONAS                         │
│         Each brings expertise, checks/balances others            │
│                                                                  │
│  Persona 1: PRODUCT OWNER    - Defines what and why (PRD)      │
│  Persona 2: ARCHITECT        - Defines how (Tech Spec)         │
│  Persona 3: DEVELOPER        - Implements code task-by-task    │
│  Persona 4: QA ENGINEER      - Reviews quality & security      │
│  Persona 5: TECH WRITER      - Creates documentation           │
└─────────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│                    4-PHASE WORKFLOW                              │
│                                                                  │
│  Phase 1: PLANNING                                              │
│    Input:  Feature request, user needs                          │
│    Output: PRD, Tech Spec, Database Schema, API Design          │
│    Gate:   ✅ Plan approved → advance                          │
│                                                                  │
│  Phase 2: IMPLEMENTATION                                        │
│    Input:  Phase 1 artifacts                                    │
│    Output: Source code, tests                                   │
│    Gate:   ✅ Code complete → advance                          │
│                                                                  │
│  Phase 3: REVIEW                                                │
│    Input:  Phase 2 artifacts                                    │
│    Output: QA reports, security audits, refactoring advice      │
│    Gate:   ✅ Critical issues fixed → advance                  │
│                                                                  │
│  Phase 4: DOCUMENTATION                                         │
│    Input:  Phase 3 artifacts                                    │
│    Output: README, user guides, API docs                        │
│    Gate:   ✅ Documentation complete → SHIP                    │
└─────────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│              ARTIFACT-DRIVEN ITERATION                           │
│        Version control enables methodical revisions              │
│                                                                  │
│  docs/                                                          │
│    ├── prds/                                                    │
│    │   ├── feature-name-prd-v1.md                             │
│    │   └── feature-name-prd-v2.md                             │
│    ├── tech-specs/                                             │
│    │   └── feature-name-spec.md                               │
│    └── tasks/                                                   │
│        └── feature-name-tasks.md                               │
│                                                                  │
│  src/                                                           │
│    └── [implementation code]                                    │
│                                                                  │
│  tests/                                                         │
│    └── [test files]                                            │
│                                                                  │
│  KEY: Every phase produces REVIEWABLE, VERSIONED files          │
│       Not just "AI said something" in chat                      │
└─────────────────────────────────────────────────────────────────┘
```

---

## The Software Development Personas

### 1. Product Owner (Strategist)
- **Phase:** 1 - Planning
- **Input:** Feature request, user needs
- **Output:** PRD (Product Requirements Document)
- **Key Questions:**
  - What problem does this solve?
  - Who are the users?
  - What defines "done"?
  - What are the acceptance criteria?

### 2. Solutions Architect (Designer)
- **Phase:** 1 - Planning
- **Input:** PRD, CONSTITUTION.md
- **Output:** Tech Spec, Database Schema, API Design
- **Key Decisions:**
  - How will this be built?
  - What patterns to use?
  - How does it integrate with existing code?
  - What are the technical constraints?

### 3. Specialist Developer (Builder)
- **Phase:** 2 - Implementation
- **Input:** Tech Spec, Task List, CONSTITUTION.md
- **Output:** Source code, tests
- **Key Practices:**
  - One task at a time
  - Test as you go
  - Follow coding standards
  - Commit after each completed task

### 4. QA Engineer (Critic)
- **Phase:** 3 - Review
- **Input:** Source code, tests, CONSTITUTION.md
- **Output:** QA Report with severity-rated issues
- **Review Areas:**
  - Bugs and edge cases
  - Security vulnerabilities
  - Performance issues
  - Code quality and standards
  - Test coverage

### 5. Technical Writer (Documenter)
- **Phase:** 4 - Documentation
- **Input:** All previous artifacts
- **Output:** README, user guides, API documentation
- **Key Content:**
  - Setup instructions
  - Usage examples
  - API reference
  - Troubleshooting guide

---

## Cross-Persona Dialogue Example

```markdown
## Task List: feature-name-tasks.md

### Developer Note (Phase 2)
> **Completed:** Task 2.3 - Implement POST /api/auth/login endpoint
> **Issue:** Need to decide on session vs JWT tokens
> **Question for Architect:** Which approach aligns with our tech stack?

### Architect Response
> **Decision:** Use JWT with httpOnly cookies
> **Rationale:**
> - More stateless (scales better)
> - Aligns with existing microservices approach
> - httpOnly cookies prevent XSS attacks
> **Action:** Updated tech spec section 3.2 with JWT implementation details

### Developer Confirmation
> ✅ Implemented JWT auth with httpOnly cookies
> ✅ Added refresh token rotation
> ✅ Updated task list: Task 2.3 complete, moving to 2.4

### QA Engineer Note (Phase 3)
> **Security Issue:** HIGH severity
> **Finding:** JWT expiry not validated on every request
> **Impact:** Expired tokens can still access protected routes
> **Fix Required:** Add expiry check middleware
```

**KEY INSIGHT:** Each interaction is documented in artifacts or task lists. This creates transparent, traceable development.

---

## Quality Metrics for Software

```
┌─────────────────────────────────────────────────────────────────┐
│  Define "DONE" for Software Features                            │
│                                                                  │
│  ✅ All tests pass (unit, integration, e2e)                     │
│  ✅ Code coverage ≥ 70% (business logic ≥ 85%)                  │
│  ✅ No CRITICAL/HIGH security issues                            │
│  ✅ Performance benchmarks met                                  │
│  ✅ Code follows CONSTITUTION.md standards                      │
│  ✅ Documentation complete (README, API docs)                   │
│  ✅ All acceptance criteria from PRD met                        │
│  ✅ QA review completed with all CRITICAL issues fixed          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Issue Severity (Software Context)

```
CRITICAL 🔴 - Must fix before shipping
- Security vulnerability (SQL injection, XSS, etc.)
- Data loss or corruption
- Application crashes
- Authentication/authorization bypass
- Breaking changes to public API

HIGH 🟠 - Should fix before shipping
- Performance degradation (>2s response time)
- Memory leaks
- Poor error handling
- Missing input validation
- Accessibility violations (WCAG AA)

MEDIUM 🟡 - Nice to fix if time permits
- Code organization issues
- Missing tests for edge cases
- Documentation gaps
- Non-critical UX issues
- Code style inconsistencies

LOW 🟢 - Address in future iterations
- Code style preferences
- Minor optimizations
- "Nice-to-have" features
- Optional refactoring opportunities
```

---

## Workflow Comparison

**Naive Approach (❌):**
```
You: "Build a user authentication system"
AI: [Generates 500 lines of code]
You: [Overwhelmed, hard to review, likely has security issues]
```

**Constitutional Workflow (✅):**
```
Phase 1: Product Owner → PRD (What features? What's secure enough?)
Phase 1: Architect → Tech Spec (JWT vs sessions? Where to store tokens?)
       → Review & approve both documents

Phase 2: Generate Task List (17 tasks identified)
Phase 2: Developer → Implement task 1.1 only
       → Review, test, commit
       → Implement task 1.2...
       → [Repeat for all tasks]

Phase 3: QA Review → Finds 2 CRITICAL, 3 HIGH issues
       → Fix CRITICAL issues
       → Re-test
       → Fix HIGH issues

Phase 4: Tech Writer → README with setup & usage
       → API documentation

Result: Secure, tested, documented authentication ✅
```

---

## The Key Insight

Instead of asking AI to "build everything," you:

1. **Break work into phases** (plan → implement → review → document)
2. **Use specialized personas** (each does one job well)
3. **Review artifacts at each step** (catch issues early)
4. **Follow your constitution** (consistent standards)
5. **Document everything** (traceable decisions)

**Result:** Professional-grade code that's planned, reviewed, tested, and documented.

---

## Integration with Session Learning System

The software development pattern works with the [session learning system](./guides/session-learning-system.md):

- **Global learnings** capture software patterns that work across projects
- **Project learnings** capture decisions specific to this codebase
- **Reflection** after sessions improves future development

**Example learning:**
```markdown
## 2025-01-06: JWT Implementation Pattern
- Pattern: Use httpOnly cookies for JWT storage (more secure than localStorage)
- When: Any authentication system using JWTs
- Gotcha: Must validate expiry on every request, not just at login
```

---

## Related Documentation

- **[AI Workflow Orchestrator](https://github.com/Optiminz/ai-workflow-orchestrator)** - The universal framework this is based on
- **[Universal Pattern Visual](https://github.com/Optiminz/ai-workflow-orchestrator/blob/main/core/universal-pattern-visual.md)** - Cross-domain version showing grants, content, design
- **[Session Learning System](./guides/session-learning-system.md)** - How to make your sessions self-improving
- **[Main README](./README.md)** - Full framework documentation

---

**This pattern works because:**
- ✅ Specialized personas prevent over-engineering
- ✅ Phase gates catch issues early
- ✅ Artifacts enable methodical review
- ✅ Constitution ensures consistency
- ✅ Learning system improves over time
