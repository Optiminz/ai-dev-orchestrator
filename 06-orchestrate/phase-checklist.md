# Phase Completion Checklist

Use these checklists to ensure you complete each phase before moving to the next.

---

## Phase 1: Planning & Design

### Product Owner: PRD Creation

- [ ] Feature idea is clearly described
- [ ] CONSTITUTION.md is attached
- [ ] Product Owner generated PRD with:
  - [ ] High-level description
  - [ ] User stories (As a [user], I want [action], so that [benefit])
  - [ ] Acceptance criteria for each story
  - [ ] Out of scope items (optional but recommended)
- [ ] You reviewed the PRD
- [ ] User stories solve the actual user problem
- [ ] Acceptance criteria are testable
- [ ] No technical implementation details in PRD (that's for tech spec)
- [ ] PRD saved to `docs/[feature-name]-prd.md`

**Ready to move on?** → Proceed to Solutions Architect

---

### Solutions Architect: Tech Spec Creation

- [ ] Approved PRD is attached
- [ ] CONSTITUTION.md is attached
- [ ] Relevant existing code is attached
- [ ] Solutions Architect generated Tech Spec with:
  - [ ] Proposed architecture (files to create/modify)
  - [ ] Data model / schema changes
  - [ ] API endpoints (if applicable)
  - [ ] Key components/functions
  - [ ] Integration points
  - [ ] Security considerations
  - [ ] Error handling
  - [ ] Testing strategy
  - [ ] Assumptions & constraints
- [ ] You reviewed the Tech Spec
- [ ] Architecture makes sense
- [ ] Follows CONSTITUTION.md principles (simplicity, standards)
- [ ] Not over-engineered or under-engineered
- [ ] Integration points are clear
- [ ] Tech Spec saved to `docs/[feature-name]-tech-spec.md`

**Optional:** If database/API is complex, use 1.3 or 1.4

**Ready to move on?** → Proceed to Implementation (Phase 2)

---

## Phase 2: Implementation

### Generate Task List

- [ ] Approved Tech Spec is attached
- [ ] CONSTITUTION.md is attached
- [ ] Task list generated with:
  - [ ] Tasks are granular (< 1 hour each)
  - [ ] Tasks are in logical order
  - [ ] Each task specifies files to create/modify
  - [ ] Dependencies are noted
  - [ ] Complexity is estimated
- [ ] You reviewed the task list
- [ ] Order makes sense
- [ ] Tasks are small enough
- [ ] You understand what each task means
- [ ] Task list saved to `docs/[feature-name]-tasks.md`

**Ready to move on?** → Start implementing tasks

---

### Iterative Implementation (Repeat for EACH Task)

For Task #[NUMBER]:

- [ ] Task description copied from task list
- [ ] CONSTITUTION.md attached
- [ ] All relevant existing code attached
- [ ] Specialist Developer generated code with:
  - [ ] Implements ONLY this task (not other tasks)
  - [ ] Follows CONSTITUTION.md standards
  - [ ] Includes meaningful comments
  - [ ] Includes error handling
  - [ ] Explained reasoning step-by-step
- [ ] You reviewed the code
- [ ] Code implements exactly this task
- [ ] Follows existing code patterns
- [ ] Comments explain "why", not "what"
- [ ] You understand every line
- [ ] Code passes linting
- [ ] You manually tested it
- [ ] Code committed (optional): `git commit -m "feat: [task description] (#[task number])"`

**Repeat for next task until all tasks complete**

**All tasks done?** → Proceed to Review (Phase 3)

---

## Phase 3: Review & Refactoring

### Comprehensive Code Review

- [ ] All code is complete (all tasks done)
- [ ] Code attached
- [ ] CONSTITUTION.md attached
- [ ] QA Engineer generated review covering:
  - [ ] Code quality & best practices
  - [ ] Potential bugs or edge cases
  - [ ] Performance optimizations
  - [ ] Readability & maintainability
  - [ ] Security concerns
- [ ] You reviewed the feedback
- [ ] All CRITICAL issues fixed
- [ ] All HIGH issues fixed
- [ ] MEDIUM issues fixed or scheduled
- [ ] Code re-tested after fixes

**Need deeper analysis?** → Use specialized reviews (3.2-3.5)

**Ready to move on?** → Proceed to Documentation (Phase 4)

---

### Specialized Reviews (Optional)

Use these for deep dives on specific concerns:

#### Bugs & Edge Cases (3.2)
- [ ] Code attached
- [ ] QA found all edge cases
- [ ] Test cases provided for each
- [ ] All bugs fixed

#### Security Audit (3.3)
- [ ] Code attached
- [ ] CONSTITUTION.md attached
- [ ] All CRITICAL security issues fixed
- [ ] All HIGH security issues fixed

#### Style & Standards (3.4)
- [ ] Code attached
- [ ] CONSTITUTION.md attached
- [ ] All violations fixed

#### Testability (3.5)
- [ ] Code attached
- [ ] Testability issues identified
- [ ] Refactorings applied (if needed)

---

### Refactor Consultation (Optional)

If code needs improvement:

- [ ] Code to refactor attached
- [ ] CONSTITUTION.md attached
- [ ] Primary goal stated (performance / readability / etc.)
- [ ] Architect generated 3+ strategies with trade-off analysis
- [ ] You reviewed all options
- [ ] You chose a strategy based on trade-offs
- [ ] Refactoring applied
- [ ] Code re-tested

---

## Phase 4: Documentation

### README.md (For Developers)

- [ ] All project files attached
- [ ] CONSTITUTION.md attached
- [ ] Technical Writer generated README with:
  - [ ] Project title & description
  - [ ] Key features
  - [ ] Installation & setup (step-by-step)
  - [ ] Usage examples
  - [ ] Configuration instructions
  - [ ] Links to detailed docs (not full specs)
  - [ ] License
  - [ ] Support/contact
- [ ] You reviewed the README
- [ ] A new developer can set up the project by following it
- [ ] No overly technical jargon (unless for dev audience)
- [ ] README saved to project root

---

### User Guide (For Non-Technical Users)

- [ ] Audience defined (who will use this)
- [ ] Tool description provided
- [ ] Technical Writer generated user guide with:
  - [ ] What is this tool (simple language)
  - [ ] How to access
  - [ ] How to do main task (step-by-step)
  - [ ] Common questions (FAQ)
  - [ ] Who to contact for help
- [ ] You reviewed the user guide
- [ ] Language is simple (no jargon)
- [ ] Steps are clear and numbered
- [ ] User guide saved to `docs/USER-GUIDE.md`

---

## Final Pre-Merge Checklist

Before merging to main:

- [ ] All phases complete (1, 2, 3, 4)
- [ ] All CRITICAL and HIGH issues fixed
- [ ] All tests pass
- [ ] Code passes linting
- [ ] Documentation is up to date
- [ ] Pull request created (if applicable)
- [ ] Code reviewed by human (if team project)
- [ ] No hardcoded secrets or API keys
- [ ] CONSTITUTION.md standards followed

**All checked?** → SHIP IT! 🚀

---

## Quick Reference: "Am I Done?"

| Phase | "I'm done when..." |
|-------|-------------------|
| Phase 1 | PRD + Tech Spec are written and approved |
| Phase 2 | All tasks implemented, code works |
| Phase 3 | All CRITICAL/HIGH issues fixed, code reviewed |
| Phase 4 | README and/or User Guide written |

---

## See Also

- [Workflow Overview](./workflow-overview.md)
- [Prompt Selection Guide](./prompt-selection-guide.md)
