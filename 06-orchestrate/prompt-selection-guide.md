# Prompt Selection Guide

**Quick reference:** Which prompt should I use right now?

---

## Decision Tree

```
START
  ↓
Do you have an idea for a feature?
  ├─ YES → Do you have a written PRD?
  │         ├─ NO  → Use 1.1 Product Owner (Create PRD)
  │         └─ YES → Do you have a Tech Spec?
  │                   ├─ NO  → Use 1.2 Solutions Architect (Create Tech Spec)
  │                   └─ YES → Do you have code written?
  │                             ├─ NO  → Use 2.1 Generate Task List
  │                             │        → Then 2.2 Iterative Implementation
  │                             └─ YES → Do you need review?
  │                                       ├─ YES → Use 3.1-3.6 (Review prompts)
  │                                       └─ NO  → Use 4.1-4.2 (Documentation)
  │
  └─ NO → What do you need?
          ├─ Review code         → See REVIEW section below
          ├─ Refactor code       → Use 3.6 Refactor Consultation
          ├─ Add comments        → Use 2.3 Code Commenter
          ├─ Write documentation → See DOCUMENTATION section below
          └─ Design database     → Use 1.3 Database Schema
```

---

## By Development Phase

### PHASE 1: PLANNING & DESIGN

**You have:** An idea or user request
**You need:** A formal plan

| Situation | Use This Prompt |
|-----------|----------------|
| "I have an idea for a feature" | 1.1 Product Owner - PRD |
| "I have a PRD, need technical design" | 1.2 Solutions Architect - Tech Spec |
| "I need to design a database" | 1.3 Database Schema |
| "I need to design API endpoints" | 1.4 API Design |

---

### PHASE 2: IMPLEMENTATION

**You have:** A tech spec
**You need:** Code

| Situation | Use This Prompt |
|-----------|----------------|
| "Ready to start coding" | 2.1 Generate Task List |
| "I have a task to implement" | 2.2 Iterative Implementation |
| "Code needs comments" | 2.3 Code Commenter |

---

### PHASE 3: REVIEW & REFACTORING

**You have:** Code
**You need:** Quality assurance or improvements

#### General Review

| Situation | Use This Prompt |
|-----------|----------------|
| "Review my code (general)" | 3.1 QA Comprehensive Review |

#### Specialized Reviews

| Specific Concern | Use This Prompt |
|-----------------|----------------|
| "Find bugs and edge cases" | 3.2 QA Bugs & Edge Cases |
| "Security audit" | 3.3 QA Security Audit |
| "Check coding standards" | 3.4 QA Style & Standards |
| "Is my code testable?" | 3.5 QA Testability |

#### Refactoring

| Situation | Use This Prompt |
|-----------|----------------|
| "I want to refactor, need options" | 3.6 Architect Refactor Consultation |

---

### PHASE 4: DOCUMENTATION

**You have:** Complete code
**You need:** Documentation

| Audience | Use This Prompt |
|----------|----------------|
| Developers (README) | 4.1 README Generator |
| End-users (Internal tool) | 4.2 User Guide Generator |

---

## By Question/Need

### "I want to..."

| Goal | Use This |
|------|----------|
| ...start a new feature | 1.1 Product Owner |
| ...design an API | 1.4 API Design |
| ...design a database | 1.3 Database Schema |
| ...write code for task #5 | 2.2 Iterative Implementation |
| ...find bugs in my code | 3.2 Bugs & Edge Cases |
| ...check if code is secure | 3.3 Security Audit |
| ...make code faster | 3.6 Refactor (goal: performance) |
| ...make code more readable | 3.6 Refactor (goal: readability) |
| ...add comments | 2.3 Code Commenter |
| ...document my project | 4.1 README or 4.2 User Guide |

---

## By Persona

| Persona | When to Invoke |
|---------|---------------|
| Product Owner | Start of new feature, unclear requirements |
| Solutions Architect | After PRD, before code; or for refactoring consultation |
| Specialist Developer | During implementation, one task at a time |
| QA Engineer | After implementation, before merge |
| Technical Writer | After feature complete, need docs |

---

## Comprehensive vs. Specialized Prompts

### When to use COMPREHENSIVE review (3.1)
- You want broad feedback
- First review of new code
- Pre-merge check
- Not sure what's wrong

### When to use SPECIALIZED reviews (3.2-3.5)
- You have a specific concern (security, performance, bugs)
- You want deep analysis on one dimension
- Comprehensive review identified an issue you want to explore deeper

**Tip:** Use comprehensive first, then specialized for deep dives.

---

## Linear Workflow (Recommended)

For a typical feature, use prompts in this order:

```
1. 1.1 Product Owner          (Create PRD)
    ↓
2. 1.2 Solutions Architect    (Create Tech Spec)
    ↓
3. 2.1 Generate Task List     (Break into tasks)
    ↓
4. 2.2 Iterative Implementation (Task #1)
    ↓
5. 2.2 Iterative Implementation (Task #2)
    ↓
   ... (repeat for each task)
    ↓
6. 3.1 QA Comprehensive Review (Review all code)
    ↓
7. (Optional) 3.2-3.5 Specialized Reviews
    ↓
8. (Optional) 3.6 Refactor Consultation
    ↓
9. 4.1 or 4.2 Documentation
    ↓
DONE
```

---

## Quick Reference Table

| # | Prompt | Phase | Persona | When |
|---|--------|-------|---------|------|
| 1.1 | PRD Generator | 1 | Product Owner | Have idea, need spec |
| 1.2 | Tech Spec | 1 | Solutions Architect | Have PRD, need design |
| 1.3 | Database Schema | 1 | Solutions Architect | Need database design |
| 1.4 | API Design | 1 | Solutions Architect | Need API design |
| 2.1 | Task List | 2 | Project Manager | Ready to code |
| 2.2 | Iterative Implementation | 2 | Specialist Developer | Implement one task |
| 2.3 | Code Commenter | 2 | Specialist Developer | Add comments |
| 3.1 | Comprehensive Review | 3 | QA Engineer | General code review |
| 3.2 | Bugs & Edge Cases | 3 | QA Engineer | Find bugs |
| 3.3 | Security Audit | 3 | QA Engineer | Security check |
| 3.4 | Style & Standards | 3 | QA Engineer | Standards compliance |
| 3.5 | Testability | 3 | QA Engineer | Check testability |
| 3.6 | Refactor Consultation | 3 | Solutions Architect | Refactor with trade-offs |
| 4.1 | README Generator | 4 | Technical Writer | Developer docs |
| 4.2 | User Guide | 4 | Technical Writer | End-user docs |

---

## Still Not Sure?

1. **Where are you in the development process?**
   - Not started → Phase 1
   - Planning done, ready to code → Phase 2
   - Code written → Phase 3
   - Code reviewed and working → Phase 4

2. **What do you have right now?**
   - Just an idea → 1.1
   - PRD → 1.2
   - Tech Spec → 2.1
   - Task List → 2.2
   - Code → 3.1
   - Reviewed code → 4.1 or 4.2

3. **What do you need next?**
   - Match your need to the table above

---

## Prompt Selection by Experience Level

Choose prompts based on your experience with AI-driven development:

### 🌱 Beginner (Week 1 - Learning the Basics)

**Your focus:** Learn the core workflow, build confidence, ship simple features

**Essential prompts (3-5 files):**

**Option A: Quick Start (Recommended for first 2-3 features)**
- `/quick-start/simple-workflow.md` - Combined PRD + planning
- `/quick-start/process-task-list.md` - Interactive task generation
- Manual testing only

**Start here:** [`/quick-start/README.md`](../quick-start/README.md)

**OR Option B: Standard Minimal Flow**
1. `1.1-product-owner-prd.md` (Simplified - keep it to 3-5 user stories)
2. `2.1-generate-task-list.md` (Use interactive mode)
3. `2.2-iterative-implementation.md` (With heavy guidance - ask questions)

**Skip for now:**
- ❌ Tech specs (1.2) - Not needed for simple features
- ❌ Database/API design (1.3, 1.4) - Keep it simple
- ❌ Formal reviews (3.x) - Manual testing is fine
- ❌ Documentation generation (4.x) - Write simple README yourself

**What success looks like:**
- ✅ Built 2-3 simple features (task tracker, expense log, basic CRUD)
- ✅ Understand PRD → Tasks → Implementation flow
- ✅ Comfortable with one-task-at-a-time approach
- ✅ Features work (even if not perfect)

---

### 📈 Intermediate (Week 2-4 - Adding Quality)

**Your focus:** Build for others, add quality controls, handle complexity

**Add to your toolkit (8 core prompts):**

**Phase 1 - Planning:**
1. `1.1-product-owner-prd.md` (Full PRDs now, 5-10 user stories)
2. `1.2-architect-tech-spec.md` (Before complex features)

**Phase 2 - Implementation:**
3. `2.1-generate-task-list.md` (Interactive mode)
4. `2.2-iterative-implementation.md`

**Phase 3 - Review (New!):**
5. `3.1-qa-comprehensive-review.md` ⭐ **Start using this before shipping**

**Phase 4 - Documentation (New!):**
6. `4.1-readme-generator.md` ⭐ **For projects you'll maintain**

**When to use what:**
- **Always:** PRD (1.1), Tasks (2.1), Implementation (2.2)
- **Before complex features:** Tech Spec (1.2)
- **Before shipping to others:** QA Review (3.1)
- **For maintained projects:** README (4.1)

**Optional but helpful:**
- `1.3-architect-database-design.md` - If database has >5 tables or complex relationships
- `1.4-architect-api-design.md` - If building a public API
- `2.3-code-commenter.md` - If code is hard to understand

**Skip for now:**
- Specialized reviews (3.2-3.5) - Comprehensive review (3.1) covers most cases
- Refactor consultation (3.6) - Only if you're rewriting significant code
- User guides (4.2) - Only if you have non-technical users

**What success looks like:**
- ✅ Built 5-10 features using the standard workflow
- ✅ Code passes QA review with minimal critical issues
- ✅ Comfortable creating tech specs for medium-complexity features
- ✅ Projects have clear README documentation
- ✅ Others can use what you've built

---

### 🎓 Advanced (Month 2+ - Full Arsenal)

**Your focus:** Production systems, high-risk features, complex architecture

**Use the full framework (All 15+ prompts):**

**Phase 1 - Planning:**
- `1.1-product-owner-prd.md` - Comprehensive PRDs (10+ user stories, edge cases)
- `1.2-architect-tech-spec.md` - Always for medium+ complexity
- `1.3-architect-database-design.md` - For any non-trivial schema
- `1.4-architect-api-design.md` - For public or partner APIs

**Phase 2 - Implementation:**
- `2.1-generate-task-list.md` - Detailed task breakdowns
- `2.2-iterative-implementation.md` - With rigorous testing
- `2.3-code-commenter.md` - For complex business logic

**Phase 3 - Review (Use multiple!):**
- `3.1-qa-comprehensive-review.md` - Always, as first pass
- `3.2-qa-bugs-edge-cases.md` - For features with complex logic
- `3.3-qa-security-audit.md` ⚠️ **Required for: Auth, payments, PII, regulated industries**
- `3.4-qa-style-standards.md` - For team projects or client work
- `3.5-qa-testability.md` - If building automated tests
- `3.6-architect-refactor-consultation.md` - Before major refactors

**Phase 4 - Documentation:**
- `4.1-readme-generator.md` - Always for maintained projects
- `4.2-user-guide-generator.md` - For non-technical users or customers

**Phase 0 - Setup (New!):**
- `/prompts/phase-0-setup/complexity-estimator.md` - Analyze feature complexity first

**When to use specialized reviews:**

| Feature Type | Required Reviews |
|--------------|------------------|
| Authentication | 3.1 + 3.2 + **3.3 (Security)** |
| Payments / Billing | 3.1 + 3.2 + **3.3 (Security)** |
| File Uploads | 3.1 + **3.3 (Security)** |
| Public API | 3.1 + **3.3 (Security)** + 3.4 |
| Complex Business Logic | 3.1 + **3.2 (Bugs)** + 3.5 (if testing) |
| Performance-Critical | 3.1 + **3.6 (Refactor)** for optimization |
| Healthcare / Finance | **All reviews (3.1-3.5)** + compliance check |

**What success looks like:**
- ✅ Built 10+ features with full framework
- ✅ Comfortable handling high-risk features (payments, auth, PII)
- ✅ Code passes comprehensive + specialized reviews
- ✅ Can make informed trade-off decisions (3.6)
- ✅ Production-ready code with proper documentation
- ✅ Can mentor others on AI-driven development

---

## Prompt Complexity by Feature Type

Use this table to choose the right workflow based on what you're building:

| Feature Type | Experience | Recommended Prompts |
|-------------|-----------|---------------------|
| **Internal CRUD tool** | Beginner | Quick Start OR 1.1 + 2.1 + 2.2 |
| **Dashboard with charts** | Intermediate | 1.1 + 1.2 + 2.1 + 2.2 + 3.1 |
| **User authentication** | Advanced | 1.1 + 1.2 + 1.3 + 2.1 + 2.2 + 3.1 + **3.3** |
| **Payment integration** | Advanced | 1.1 + 1.2 + 1.3 + 2.1 + 2.2 + 3.1 + 3.2 + **3.3** |
| **Public API** | Advanced | 1.1 + 1.2 + **1.4** + 2.1 + 2.2 + 3.1 + 3.3 + 4.1 |
| **Real-time features** | Advanced | 1.1 + 1.2 + 1.3 + 2.1 + 2.2 + 3.1 + 3.6 (perf) |
| **File uploads** | Intermediate | 1.1 + 1.2 + 2.1 + 2.2 + 3.1 + **3.3** (security) |
| **Reporting / Analytics** | Intermediate | 1.1 + 1.2 + **1.3** (complex queries) + 2.1 + 2.2 + 3.1 |
| **AI/LLM integration** | Advanced | 1.1 + 1.2 + 1.4 + 2.1 + 2.2 + 3.1 + 3.2 (edge cases) |

**Bold** = Critical (don't skip)

---

## Migration Path: Quick Start → Standard → Full

### Week 1-2: Quick Start
```
You: Use /quick-start/simple-workflow.md
Goal: Build 2-3 simple features, learn basics
Output: Working features (may have rough edges)
```

### Week 3-4: Transition to Standard
```
You: 1.1 (PRD) → 1.2 (Tech Spec - for complex features) → 2.1 → 2.2 → 3.1 (Review!)
Goal: Build for others, add quality controls
Output: Professional features that others can use
```

### Month 2+: Graduate to Full Framework
```
You: All prompts as needed, specialized reviews for high-risk
Goal: Production-ready systems, handle anything
Output: Enterprise-grade features
```

**Remember:** You can always go back to Quick Start for simple internal tools. Use the right tool for the job!

---

## See Also

- [Workflow Overview](./workflow-overview.md)
- [Phase Checklist](./phase-checklist.md)
- [Quick Start Guide](../quick-start/README.md)
- [Complexity Estimator](../prompts/phase-0-setup/complexity-estimator.md)
