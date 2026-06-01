---
name: backlog
description: |
  Product backlog at docs/product/backlog.md. Modes write, review, refine. Default
  is epic-level decomposition; may include stories for small products or when the
  user asks. For work-package task breakdown from design — use tasks.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: write|review|refine> [--depth full] [--stories] [--context <notes>]"
---

# Backlog

## Artefact

Default path: `docs/product/backlog.md` — product-level backlog (epics by default).

## Path resolution

If the user names a different file path in their request, read and write that
path instead of the default.

## Default shape

- **Epic-level (default):** epic breakdown table, Now-phase epic detail, dependency
  graph, delivery risks. Later phases are placeholders unless `--depth full`.
- **With stories:** when the user requests `--stories`, a small product, or
  explicitly asks for tasks/stories in the product backlog — include story rows
  or a story section **without** full EARS/Gherkin (that belongs in `tasks.md`
  at work-package time via the **tasks** skill).

## Cross-artifact boundaries

Do NOT put in the product backlog:

- Full EARS + Gherkin for work-package implementation → `work/{wp}/tasks.md` via **tasks**
- Architecture patterns or technical rationale → `docs/architecture/solution.md`
- Business strategy → `docs/product/product.md`
- Phase sequencing prose → `docs/product/roadmap.md`
- API shapes or code fences → `docs/architecture/solution.md`
- Work-package implementation detail → `work/{wp}/design.md`

## Supporting files

- [assets/backlog.template.md](assets/backlog.template.md)
- [examples/epic-backlog.md](examples/epic-backlog.md)

## Related skills

- `product`, `roadmap`, `solution`, `tasks`

## Router

1. Mode: `write`, `review`, or `refine`.
2. Resolve path (default `docs/product/backlog.md`).
3. One prompt under [prompts/](prompts/).

**write** — `--depth full` for all phases; `--stories` to include story-level items in the product backlog.
