---
name: tasks
description: |
  Breaks epic design or spec into work/{epic}/tasks.md with Gherkin AC (EARS when
  --ears or warranted). Modes write, review, refine. Use after design for an epic.
  Do NOT use for product backlog — use backlog. Do NOT implement — use feature.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: write|review|refine> <epic> [--ears] [--context <notes>]"
---

# Tasks

## Artefact

Default path: `work/{epic}/tasks.md` — tasks for one epic with Gherkin acceptance
criteria by default.

## Epic slug (`{epic}`)

Kebab-case from the epic **title or short title**, **max two words** (see **backlog** SKILL.md).
Examples: `checkout-foundation`, `payment-placement`.

The user may pass:

- The slug (`checkout-foundation`)
- The epic ID (`CHK01`) — resolve slug from `docs/product/backlog.md`
- A path (`work/checkout-foundation/` or `work/checkout-foundation/tasks.md`)

## Path resolution

If the user names a different file path, use that instead of the default under
`work/{epic}/`.

## Inputs

- **Preferred:** `work/{epic}/design.md` and the epic row in `docs/product/backlog.md`
- **Alternative:** a spec the user provides
- **Context:** `docs/architecture/solution.md`

## Canonical task schema

Each task: Status, Priority, Estimate, Epic, Labels, Depends on, Deliverable,
Design (section link), **Acceptance (Gherkin)**.

**Required:** ≥1 Gherkin scenario per task; observable `Then` clauses.

**Optional EARS:** with `--ears` or when rules warrant it (see write prompt).

## Cross-artifact boundaries

Do NOT put in `tasks.md`:

- New epics → `docs/product/backlog.md`
- Architecture → `docs/architecture/solution.md` or ADRs
- Full design narrative → `work/{epic}/design.md`

## Supporting files

- [assets/tasks.template.md](assets/tasks.template.md)
- [examples/checkout-foundation.md](examples/checkout-foundation.md)

## Related skills

- `backlog`, `design`, `feature`, `solution`, `sprint`

## Router

1. Mode: `write`, `review`, or `refine`.
2. Resolve `{epic}` and `work/{epic}/tasks.md`.
3. One prompt under [prompts/](prompts/).

**write** — `--ears` for EARS on every task.
