# AI Personas: Your Development Team

This directory contains definitions for the 5 specialized AI personas that make up your AI development team. Each persona has specific responsibilities, expertise, and produces specific artifacts.

## The Five Core Personas

| Persona | Primary Role | When to Invoke | Key Artifacts |
|---------|--------------|----------------|---------------|
| [Product Owner](./01-product-owner.md) | Defines **what** to build and **why** | Start of every new feature or project | PRD, User Stories, Acceptance Criteria |
| [Solutions Architect](./02-solutions-architect.md) | Defines **how** to build it | After PRD approval, before coding | Tech Spec, Database Schema, API Design |
| [Specialist Developer](./03-specialist-developer.md) | **Implements** the solution | During coding phase, task-by-task | Source code, Comments |
| [QA Engineer](./04-qa-engineer.md) | **Validates** the implementation | After implementation, before merge | Code reviews, Bug reports, Test suggestions |
| [Technical Writer](./05-technical-writer.md) | **Documents** the solution | After feature completion | README, User guides, API docs |

## How Personas Work

Personas are not different AI models - they are **specialized prompt templates** that activate different modes of thinking and expertise.

### The Orchestrator Pattern

You, the developer, act as the **orchestrator** of this AI team:

1. **Assign tasks** to the right persona based on the phase of development
2. **Review outputs** from each persona before moving to the next
3. **Provide context** by referencing previous artifacts (PRD → Tech Spec → Code)
4. **Maintain quality** by using the CONSTITUTION.md as the governing law

### Workflow Integration

```
[User Need]
    ↓
┌─────────────────────────────────────────┐
│ Product Owner: Create PRD               │
│ Output: feature-prd.md                  │
└─────────────────────────────────────────┘
    ↓ (Review & Approve)
┌─────────────────────────────────────────┐
│ Solutions Architect: Create Tech Spec   │
│ Output: feature-tech-spec.md            │
└─────────────────────────────────────────┘
    ↓ (Review & Approve)
┌─────────────────────────────────────────┐
│ Specialist Developer: Implement         │
│ Output: Source code                     │
└─────────────────────────────────────────┘
    ↓ (Each completed task)
┌─────────────────────────────────────────┐
│ QA Engineer: Review & Test              │
│ Output: Review report, bug list         │
└─────────────────────────────────────────┘
    ↓ (Fix issues, iterate)
┌─────────────────────────────────────────┐
│ Technical Writer: Document              │
│ Output: README, User guide              │
└─────────────────────────────────────────┘
    ↓
[Feature Complete]
```

## Quick Reference: Which Persona Should I Use?

### "I have an idea for a feature..."
→ **Product Owner** - Start with a PRD

### "I have a PRD and need to figure out the architecture..."
→ **Solutions Architect** - Create a Tech Spec

### "I need to design a database schema..."
→ **Solutions Architect** (specialized prompt)

### "I need to design API endpoints..."
→ **Solutions Architect** (specialized prompt)

### "I'm ready to write code..."
→ **Specialist Developer** - Implement task-by-task

### "I need to add comments to existing code..."
→ **Specialist Developer** (code commenter prompt)

### "I need this code reviewed..."
→ **QA Engineer** - Comprehensive or specialized review

### "I want to refactor this code..."
→ **Solutions Architect** (refactoring consultation)

### "I need documentation..."
→ **Technical Writer** - README or user guide

## Best Practices

### 1. Always Provide the Constitution
Every persona should receive the `CONSTITUTION.md` file as context to ensure consistency.

### 2. One Task at a Time
Don't ask a persona to do multiple jobs. For example:
- ❌ "Product Owner: Create a PRD and implement the code"
- ✅ "Product Owner: Create a PRD" → Review → "Developer: Implement task 1"

### 3. Chain Outputs as Inputs
Each persona's output becomes the next persona's input:
- PRD → Tech Spec
- Tech Spec → Task List → Code
- Code → Review → Documentation

### 4. Review Before Advancing
Always review a persona's output before moving to the next phase. This is where you, as the orchestrator, add value:
- Does the PRD match what I actually want?
- Is the Tech Spec architecturally sound?
- Does the code follow our standards?

### 5. Iterate When Needed
If a persona's output isn't right, don't move forward:
- Ask clarifying questions
- Provide more context
- Request revisions

## Customizing Personas

Each persona file contains:
- **Role Definition**: What this persona does
- **Core Responsibilities**: Specific tasks
- **Expertise Areas**: What they're good at
- **Key Artifacts**: What they produce
- **Prompt Templates**: Ready-to-use prompts (cross-referenced to `/prompts/`)

You can customize these personas for your specific needs by editing the individual files.

## Learn More

- See `/prompts/` for all available prompt templates
- See `/workflow/` for detailed process documentation
- See `docs/research-origin.md` for the research behind this framework
