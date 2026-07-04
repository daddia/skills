# Changelog

All notable changes to this project are documented here. Version numbers match
Git tags and the `version` field in `.cursor-plugin/plugin.json` and
`.claude-plugin/plugin.json`.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.2.0] - 2026-07-04

### Changed

- **code-review** skill significantly restructured: sub-agents are now each in
  their own dedicated file under `agents/`, trigger conditions are explicit, and
  the skill routes to a single prompt per mode.
- Replaced `tasks-ac-reviewer` agent with `acceptance-criteria-reviewer` (format
  agnostic — works with any tracker or doc format, not just task files).
- `design-drift-reviewer` rewritten to resolve any discovered design/spec doc
  automatically rather than requiring an explicit path.
- `prompts/run.prompt.md` and `prompts/fix.prompt.md` updated to share context
  once up-front and pass it to every sub-agent, eliminating redundant fetches.

### Added

- `agents/acceptance-criteria-reviewer.md` — AC vs diff reviewer.
- `agents/architecture-reviewer.md` — architecture docs/ADR reviewer.
- `agents/best-practices-reviewer.md` — library/framework best-practices reviewer.
- `agents/bug-scan-reviewer.md` — shallow changes-only bug + git-history scanner.
- `agents/guideline-compliance-reviewer.md` — AGENTS.md/CLAUDE.md/rules reviewer.
- `references/context-resolution.md` — how to discover intent, AC, scope, and CI
  signal in any repo/tracker.
- `references/finding-classification.md` — category, severity, confidence, and
  risk matrix for findings.
- `references/quality-checklist.md` — timeless review checklist applied across
  all reviewers.
- `references/security-checklist.md` — condensed security pass reference.

### Removed

- `agents/tasks-ac-reviewer.md` (superseded by `acceptance-criteria-reviewer`).

## [1.1.0] - 2026-06-02

### Changed

- Renamed the **feature** skill to **implement**. Invoke with `/implement {task-id}`
  (e.g. `/implement CHK01-01`) instead of `/feature implement {task-id}`.
- Renamed the plugin identifier from `dskills` to `daddia-skills` in Cursor and
  Claude plugin manifests.
- Updated cross-references across README, skills-index, delivery conventions,
  and related skills to use **implement** and task terminology.

### Added

- **implement** skill (`skills/implement/`) with implementation prompt aligned to
  Task IDs in `docs/work/{epic}/tasks.md`.

### Removed

- **feature** skill directory (replaced by **implement**).

## [1.0.0] - 2026-06-01

### Added

- Initial release of the daddia skills plugin: product delivery skills for
  strategy, architecture, epic design, tasks, implementation, code review,
  validation, and sprint refinement.
- Cursor and Claude plugin manifests, skills.sh catalogue, and validation CI.
