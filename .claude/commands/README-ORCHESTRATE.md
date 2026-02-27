# /orchestrate Quick Reference

**What it does:** Automates the full 4-phase ai-dev-orchestrator workflow with Ralph Loop + Superpowers integration.

---

## Basic Usage

```bash
/orchestrate "Build user authentication with email and password"
```

This runs:
1. **Phase 1:** Product Owner creates PRD → Solutions Architect creates Tech Spec
2. **Phase 2:** Generate tasks → Ralph Loop implements all tasks
3. **Phase 3:** QA Engineer reviews → Fix issues
4. **Phase 4:** Technical Writer documents → Session reflection

---

## Options

### Skip Planning (if PRD/Tech Spec exist)
```bash
/orchestrate --skip-planning --tasks-from docs/existing-tasks.md
```

### Resume Interrupted Orchestration
```bash
/orchestrate --resume feature-name
```

### Run Single Phase
```bash
/orchestrate --phase implementation   # Phase 2 only
/orchestrate --phase review          # Phase 3 only
/orchestrate --phase docs            # Phase 4 only
```

### Experimental Mode (Skip Constitution Checks)
```bash
/orchestrate --no-constitution-checks
```
⚠️ For prototyping only. Not recommended for production.

---

## What You Need

### Required
- ✅ `CONSTITUTION.md` in repo root
- ✅ `personas/` directory with persona files
- ✅ Stop hooks in `.claude/hooks/stop/`
- ✅ Git repository initialized
- ✅ Test framework configured

### Recommended
- 📋 Artifact templates in `templates/`
- 📚 Example outputs in `examples/`
- 📝 Project `CLAUDE.md`

---

## How It Works

```
You: /orchestrate "Feature request"
  ↓
[Phase 1: Planning]
  → Product Owner creates PRD
  → Human approves
  → Solutions Architect creates Tech Spec
  → Human approves
  ↓
[Phase 2: Implementation]
  → Generate task list
  → Human approves
  → Ralph Loop implements tasks iteratively
    - Specialist Developer persona
    - Stop hooks enforce quality
    - Auto-commits after each task
  → Continues until all tasks complete
  ↓
[Phase 3: Review]
  → QA Engineer reviews code
  → Identifies issues (CRITICAL, HIGH, MEDIUM, LOW)
  → Fix HIGH/CRITICAL issues
  → Verify acceptance criteria
  ↓
[Phase 4: Documentation]
  → Technical Writer updates README
  → /reflect captures learnings
  → /requesting-code-review prepares PR
  ↓
✓ Feature Complete
```

---

## Stop Hooks Used

The orchestration relies on these hooks:

| Hook | Purpose | Blocks? |
|------|---------|---------|
| `01-ralph-loop.sh` | Ralph Loop control | Yes (until promise) |
| `10-constitution-check.sh` | Validate CONSTITUTION.md | Yes (on violations) |
| `20-test-validation.sh` | Run tests | Yes (on failure) |
| `30-artifact-gates.sh` | Verify required artifacts | Yes (if missing) |
| `40-persona-handoff.sh` | Auto-transition personas | No |
| `50-security-audit.sh` | Security scanning | No (warns only) |
| `60-quality-gates.sh` | Linting, formatting | Yes (on errors) |
| `90-auto-commit.sh` | Auto-commit changes | No |
| `99-session-learning.sh` | Prompt /reflect | No |

---

## Human Checkpoints

You'll be asked to approve at these points:

1. **After PRD:** "Review PRD. Approve to continue?"
2. **After Tech Spec:** "Review Tech Spec. Approve to generate tasks?"
3. **After Task List:** "Review task list. Approve to start implementation?"
4. **After QA Review:** "Issues found. Review and approve fixes?"
5. **After Documentation:** "Review docs. Ready to merge?"

Between checkpoints, orchestration runs **autonomously** via Ralph Loop.

---

## Example Output

```
You: /orchestrate "Add password reset functionality"

Claude:
  ✓ Reading CONSTITUTION.md
  ✓ Invoking Product Owner persona
  ✓ Creating PRD at docs/password-reset-prd.md
  → Review PRD. Approve? [y/n]

You: y

Claude:
  ✓ Invoking Solutions Architect persona
  ✓ Creating Tech Spec at docs/password-reset-tech-spec.md
  → Review Tech Spec. Approve? [y/n]

You: y

Claude:
  ✓ Generating task list (12 tasks)
  → Review tasks. Start implementation? [y/n]

You: y

Claude:
  ✓ Starting Ralph Loop (max 50 iterations)

  [Iteration 1] Task 1: Add password_reset_tokens table
    → Tests passing ✓
    → Committed ✓

  [Iteration 2] Task 2: Implement POST /api/auth/reset-request
    → Tests passing ✓
    → Committed ✓

  ... [continues for 12 tasks] ...

  [Iteration 12] Task 12: Add email notification
    → Tests passing ✓
    → <promise>ALL TASKS COMPLETE</promise>

  ✓ Ralph Loop complete (12/12 tasks)

  ✓ QA Engineer review complete
  ✓ No CRITICAL/HIGH issues
  ✓ Documentation updated
  ✓ Learnings captured

  ✓ Orchestration Complete!
  Feature: password-reset
  Tasks: 12/12 ✓
  Coverage: 89%
  Time: ~45 min

  Ready to merge.
```

---

## Troubleshooting

### "Constitution file not found"
```bash
cp ~/Projects/ai-dev-orchestrator/CONSTITUTION-TEMPLATE.md CONSTITUTION.md
```

### "Persona files not found"
```bash
mkdir -p personas
cp ~/Projects/ai-dev-orchestrator/personas/*.md personas/
```

### "Stop hooks not configured"
```bash
mkdir -p .claude/hooks/stop
# Copy hooks from ai-dev-orchestrator/hooks/
chmod +x .claude/hooks/stop/*.sh
```

### "Ralph Loop not stopping"
- Check for completion promise: `<promise>TEXT</promise>`
- Verify max-iterations not exceeded
- Inspect: `cat .claude/.ralph-loop.local.md`

---

## Related Commands

- `/brainstorming` - Pre-planning exploration
- `/test-driven-development` - TDD setup before implementation
- `/verification-before-completion` - Extra verification in review
- `/reflect` - Session learning capture (auto-invoked)
- `/finishing-a-development-branch` - Post-orchestration merge workflow

---

## Documentation

**Full Guide:** See `docs/orchestration-integration.md` for:
- Complete workflow details
- Stop hook architecture
- Setup instructions
- Advanced topics
- Customization

**Skill Definition:** See `orchestrate.md` for:
- Implementation details
- Error handling
- State management
- Extension points

---

## Quick Setup (New Project)

```bash
# 1. Copy constitution
cp ~/Projects/ai-dev-orchestrator/CONSTITUTION-TEMPLATE.md CONSTITUTION.md

# 2. Copy personas
mkdir -p personas
cp ~/Projects/ai-dev-orchestrator/personas/*.md personas/

# 3. Create hooks directory
mkdir -p .claude/hooks/stop

# 4. Copy stop hooks (create these based on docs/orchestration-integration.md)
# Copy 01-ralph-loop.sh, 10-constitution-check.sh, 20-test-validation.sh at minimum

# 5. Make hooks executable
chmod +x .claude/hooks/stop/*.sh

# 6. Create learning directories
mkdir -p .claude/learnings
touch .claude/learnings/{insights,decisions,gotchas}.md

# 7. Test it
/orchestrate "Add health check endpoint"
```

---

## Tips

- **Start small:** Test with simple features first
- **Customize constitution:** Edit for your tech stack and standards
- **Review checkpoints:** Don't blindly approve - review artifacts
- **Trust Ralph:** Let Ralph iterate on failures, don't intervene too quickly
- **Capture learnings:** Use `/reflect` to improve future sessions
- **Iterate on hooks:** Adjust stop hooks based on your workflow

---

**Version:** 1.0.0
**Created:** 2026-01-28
**Dependencies:** Ralph Loop, Superpowers, ai-dev-orchestrator

**Happy orchestrating!** 🚀