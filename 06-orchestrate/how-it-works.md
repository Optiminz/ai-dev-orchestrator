# AI-Dev-Orchestrator: Workflow Overview

This document provides a high-level overview of the AI-driven development workflow.

---

## The Four-Phase Workflow

```
Phase 1: PLANNING        Phase 2: IMPLEMENTATION     Phase 3: REVIEW           Phase 4: DOCUMENTATION
   & DESIGN                                        & REFACTORING

[User Need/Idea]
       ↓
┌──────────────────┐
│ Product Owner    │
│ Create PRD       │     ┌──────────────────┐
│ → feature-prd.md │     │ Generate         │      ┌──────────────────┐
└──────────────────┘     │ Task List        │      │ QA Engineer      │      ┌──────────────────┐
       ↓                 │ → tasks.md       │      │ Code Review      │      │ Technical Writer │
   Review/Approve        └──────────────────┘      │                  │      │ README.md        │
       ↓                        ↓                  └──────────────────┘      │ User Guide       │
┌──────────────────┐            ↓                          ↓                 └──────────────────┘
│ Solutions        │     ┌──────────────────┐              ↓
│ Architect        │     │ Specialist       │      ┌──────────────────┐
│ Create Tech Spec │     │ Developer        │      │ Solutions        │
│ → tech-spec.md   │     │ Task #1          │      │ Architect        │
└──────────────────┘     │ Task #2          │      │ Refactor         │
       ↓                 │ Task #3...       │      │ Consultation     │
   Review/Approve        └──────────────────┘      └──────────────────┘
       ↓                        ↓
┌──────────────────┐            ↓
│ (Optional)       │     Iterate: Implement
│ Database Schema  │     one task at a time
│ API Design       │
└──────────────────┘

   [Feature Complete]
```

---

## The Philosophy: Plan → Prompt → Validate → Refactor

### 1. PLAN (Phase 1)
- **Don't jump to code.** Start with requirements (PRD) and design (Tech Spec)
- **Validate the architecture** before writing a single line
- **Avoid over-engineering** by referencing CONSTITUTION.md

### 2. PROMPT (Phase 2)
- **One task at a time.** Implement iteratively, not all at once
- **Be specific.** Each prompt should have a clear, single focus
- **Provide context.** Always attach CONSTITUTION.md and relevant files

### 3. VALIDATE (Phase 3)
- **Review everything.** Don't merge without review
- **Use specialized reviews** for deep analysis (security, performance, etc.)
- **Fix CRITICAL/HIGH issues immediately**

### 4. REFACTOR (Phase 3 + Architect)
- **Understand trade-offs.** Every refactoring has pros and cons
- **Optimize with intent.** Don't refactor blindly
- **Keep it simple.** Prefer simplicity over cleverness

---

## Persona-Based Workflow

Instead of asking a single AI to "do everything," you assign tasks to specialized personas:

| Phase | Persona | What They Do | Output |
|-------|---------|--------------|--------|
| 1 | Product Owner | Define WHAT and WHY | PRD |
| 1 | Solutions Architect | Define HOW | Tech Spec, DB Schema, API Design |
| 2 | Specialist Developer | IMPLEMENT | Source Code |
| 3 | QA Engineer | VALIDATE | Code Review Reports |
| 3 | Solutions Architect | ANALYZE TRADE-OFFS | Refactoring Consultation |
| 4 | Technical Writer | EXPLAIN | README, User Guides |

---

## Key Principles

### 1. Constitution as Law
- Every persona must follow CONSTITUTION.md
- Non-negotiable standards prevent drift
- Consistency across all AI outputs

### 2. Incremental Progress
- Small tasks > Large tasks
- One task at a time > All at once
- Review early, review often

### 3. Explicit Over Implicit
- Written specs > Verbal ideas
- Documented trade-offs > Assumptions
- Clear acceptance criteria > Vague goals

### 4. Human as Orchestrator
- You review and approve each phase
- You make the final decisions
- AI provides expertise, you provide judgment

---

## When to Use Each Workflow Component

### Start a New Feature?
→ Use Product Owner (1.1-product-owner-prd.md)

### Have a PRD, Need Architecture?
→ Use Solutions Architect (1.2-architect-tech-spec.md)

### Complex Database Design?
→ Use Database Schema prompt (1.3-architect-database-schema.md)

### Ready to Code?
→ Generate Task List (2.1-generate-task-list.md)
→ Then Iterative Implementation (2.2-iterative-implementation.md)

### Code Done, Need Review?
→ Use QA Comprehensive Review (3.1-qa-comprehensive-review.md)
→ Or specialized reviews (3.2-3.5)

### Need to Refactor?
→ Use Architect Refactor Consultation (3.6-architect-refactor-consultation.md)

### Feature Complete?
→ Use Technical Writer (4.1-readme-generator.md or 4.2-user-guide-generator.md)

---

## Common Pitfalls to Avoid

### ❌ Skipping the Plan
- **Problem:** Jumping straight to code without PRD/Tech Spec
- **Result:** Over-engineering, scope creep, rework
- **Fix:** Always start with Phase 1

### ❌ Implementing Multiple Tasks at Once
- **Problem:** Asking AI to "build the entire feature"
- **Result:** Complex, hard-to-review code
- **Fix:** Use 2.2 prompt for ONE task at a time

### ❌ Ignoring Review Feedback
- **Problem:** Not fixing CRITICAL/HIGH issues
- **Result:** Security vulnerabilities, bugs in production
- **Fix:** Address all critical issues before merging

### ❌ Refactoring Without Understanding Trade-offs
- **Problem:** Optimizing for performance and sacrificing readability
- **Result:** Fast but unmaintainable code
- **Fix:** Use 3.6 to analyze trade-offs first

---

## See Also

- [Prompt Selection Guide](./prompt-selection-guide.md) - Decision tree for choosing prompts
- [Phase Checklist](./phase-checklist.md) - Ensure you complete each phase fully
- [Personas Overview](../personas/README.md) - Detailed persona definitions
