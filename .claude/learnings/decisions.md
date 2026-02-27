# Architecture Decisions

Significant technical decisions and their rationale.

---

## 2025-01-05: Split Global vs Project Learnings
- **Decision:** Separate learnings into global (`~/.claude/learnings/`) and project-specific (`.claude/learnings/`)
- **Rationale:** Some learnings apply everywhere (TypeScript patterns), others are project-specific (this project uses Zustand)
- **Alternatives rejected:** Single global location (loses project context), single project location (can't share cross-project)

---

<!-- New decisions will be appended below -->

## 2026-02-27: Two Learnings Files Instead of Three
- **Decision:** Collapse insights.md + gotchas.md → learnings.md, keep decisions.md separate
- **Rationale:** Three files (insights/decisions/gotchas) creates categorization friction. Users have to decide which file something belongs in, which works against using the system. Decisions earn their own file because they need to record architectural WHY — that's a distinct concern. Everything else goes in learnings.md.
- **Alternatives rejected:** Single file (loses the architectural decision record), three files (too much overhead)

## 2026-02-27: setup.sh as Adoption Mechanism (Not npm CLI)
- **Decision:** A bash script that copies files + generates CLAUDE.md, rather than an npm package
- **Rationale:** npm adds dependency overhead, requires Node.js, and is overkill for what is essentially file copying. The smart work (configuring CONSTITUTION.md) is done by Claude on first launch, not by the script.
- **Alternatives rejected:** npm CLI (unnecessary complexity), manual instructions (too much friction for new users)

## 2026-02-27: Claude Code = Recommended Path, But Keep Tool-Agnostic Manual Path
- **Decision:** README presents two paths — Path A (Claude Code automated) and Path B (any AI tool manual). Claude Code is recommended but not required.
- **Rationale:** Target user is "AI-curious developers" using various tools. Forcing Claude Code-only would exclude legitimate users. But the manual path is clearly secondary.
- **Alternatives rejected:** Claude Code-only (too narrow), fully tool-agnostic (loses the automated workflow as a headline feature)
