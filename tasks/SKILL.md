---
name: tasks
description: |
  Breaks a work-package design or spec into tasks.md with EARS + Gherkin acceptance
  criteria. Default work/{wp}/tasks.md. Modes write, review, refine. Use after design
  or from a spec — not for product epics (use backlog). Do NOT implement — use feature.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: write|review|refine> <work-package-path> [--context <notes>]"
---

# Tasks

## Artefact

Default path: `work/{wp}/tasks.md` — implementable tasks or user stories for one work
package, with EARS + Gherkin acceptance criteria.

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
Deliverable, Design (section link), Acceptance (EARS), Acceptance (Gherkin).

- Every EARS statement: `WHEN/THE SYSTEM SHALL` or `WHEN … THE SYSTEM SHALL`
- Every Gherkin scenario: `Given / When / Then`
- Every task: at least two EARS statements and one Gherkin scenario

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
