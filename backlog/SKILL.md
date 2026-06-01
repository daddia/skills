---
name: backlog
description: |
  Product backlog at docs/product/backlog.md. Modes write, review, refine. Default
  is epic-level decomposition; may include stories for small products or when the
  user asks. Task breakdown per epic — use tasks at work/{epic}/.
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

## Epic work folders

Each epic has a work folder: `work/{epic}/` where `{epic}` is a **kebab-case slug**
from the epic **title** (or **short title** when the table provides one), using
**at most two words**:

| Epic title | Work path |
| ---------- | --------- |
| Checkout Foundation | `work/checkout-foundation/` |
| Payment and Placement | `work/payment-placement/` |
| Order Confirmation | `work/order-confirmation/` |

Epic ID format (e.g. `CHK01`) lives in the backlog table; `{epic}` in paths is
the title or short title slug, not the ID. Resolve by reading the epic row when
the user gives only an ID.

Under `work/{epic}/`: `design.md`, `tasks.md`, `refine-session.md` (and similar).

## Default shape

- **Epic-level (default):** epic breakdown table, Now-phase epic detail, dependency
  graph, delivery risks. Later phases are placeholders unless `--depth full`.
- **With stories:** when the user requests `--stories`, a small product, or
  explicitly asks — lightweight story rows only; full Gherkin → `work/{epic}/tasks.md`
  via **tasks**.

## Cross-artifact boundaries

Do NOT put in the product backlog:

- Full Gherkin in the product backlog → `work/{epic}/tasks.md` via **tasks**
- Architecture → `docs/architecture/solution.md`
- Business strategy → `docs/product/product.md`
- Phase sequencing → `docs/product/roadmap.md`
- API shapes or code fences → `docs/architecture/solution.md`
- Epic implementation detail → `work/{epic}/design.md`

## Supporting files

- [assets/backlog.template.md](assets/backlog.template.md)
- [examples/backlog.md](examples/backlog.md)

## Related skills

- `product`, `roadmap`, `solution`, `tasks`, `design`, `sprint`

## Router

1. Mode: `write`, `review`, or `refine`.
2. Resolve path (default `docs/product/backlog.md`).
3. One prompt under [prompts/](prompts/).

**write** — `--depth full` for all phases; `--stories` for story-level rows in the product backlog.
