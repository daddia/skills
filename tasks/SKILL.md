---
name: tasks
description: |
  Breaks design or spec into tasks.md with Gherkin acceptance criteria (EARS when
  --ears or warranted). Default work/{wp}/tasks.md. Modes write, review, refine.
  Use after design — not for product epics (use backlog). Do NOT implement — use feature.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: write|review|refine> <work-package-path> [--ears] [--context <notes>]"
---

# Tasks

## Artefact

Default path: `work/{wp}/tasks.md` — implementable tasks with **Gherkin** acceptance
criteria by default; **EARS** when `--ears` or selectively per task.

## Path resolution

If the user names a different file path in their request, read and write that path
instead of the default. The user may supply a work-package directory or id; resolve
to `work/{wp}/tasks.md` unless they give a full path.

## Inputs

- **Preferred:** `work/{wp}/design.md` plus the parent epic in `docs/product/backlog.md`
- **Alternative:** a spec or requirements document the user provides
- **Context:** `docs/architecture/solution.md` for patterns and terminology

## Canonical task schema

Each task includes: Status, Priority, Estimate, Epic, Labels, Depends on,
Deliverable, Design (section link), **Acceptance (Gherkin)**.

**Required (every task):**

- At least one Gherkin scenario with `Given` / `When` / `Then`
- Prefer two scenarios when there is a happy path and a meaningful alternate (error, auth, empty state)
- `Then` must describe observable outcomes, not implementation steps

**Optional — Acceptance (EARS):**

- Omit the EARS subsection when Gherkin is sufficient
- Include EARS when the user passes `--ears` (then ≥2 EARS per task, still keep Gherkin)
- Or add selectively when a rule is clearer as SHALL than as scenarios alone (error taxonomies, idempotency, cross-cutting invariants, audit/logging mandates)

EARS format: `WHEN … THE SYSTEM SHALL …` or `THE SYSTEM SHALL …`

## Cross-artifact boundaries

Do NOT put in `tasks.md`:

- New epics or product strategy → `docs/product/backlog.md`, `docs/product/product.md`
- Architecture decisions → `docs/architecture/solution.md` or ADRs
- Full design narrative → `work/{wp}/design.md` (cite sections only)

## Supporting files

- [assets/tasks.template.md](assets/tasks.template.md)
- [examples/wp01-tasks.md](examples/wp01-tasks.md)

## Related skills

- `backlog`, `design`, `feature`, `solution`

## Router

1. Mode: `write`, `review`, or `refine`.
2. Resolve work-package path and `tasks.md` location.
3. One prompt under [prompts/](prompts/).

**write** — `--ears` for EARS on every task.
