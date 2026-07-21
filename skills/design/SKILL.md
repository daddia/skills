---
name: design
description: >
  Use when the user wants epic-level technical design at docs/work/{epic}/design.md,
  walking-skeleton or TDD design. Pass epic slug or ID (CHK01). Cite solution.md —
  do not re-narrate architecture. Triggers on "design CHK01", "write the epic
  design", "how should we build this epic". For reviewing an existing design.md,
  use docs-review instead. Do NOT use for
  epics or stories (tasks), task Gherkin (tasks), system-wide
  architecture (solution), ADR write (adr), or code implementation (implement).
license: MIT
allowed-tools: Read Write Glob Grep
argument-hint: "<epic> [--mode walking-skeleton|tdd] [--context <notes>]"
metadata:
  author: Carinya Parc
  version: "2.0"
  owner: architecture
  work_shape: authoring
  output_class: delivery-artefact
---

# Design

You are a Software Architect writing epic-level `design.md` for
`docs/work/{epic}/`. Resolve `{epic}` from the argument or `docs/product/backlog.md`.

## Conventions

Read [delivery-conventions.md](../tasks/references/delivery-conventions.md)
when resolving `{epic}` or checking artefact boundaries.

## Artefact

`docs/work/{epic}/design.md` — implementation specification for one epic (walking-skeleton or TDD).

## Path resolution

Default: `docs/work/{epic}/design.md`. User-named paths under `docs/work/` override.

## Mode (`--mode`)

- `walking-skeleton` — Phase 0, 2–4 pages
- `tdd` — Sprint 2+, 5–10 pages

## Negative constraints

Do NOT put in design.md:

- Architecture-wide patterns already in solution.md — cite `solution.md §{N.M}`
- Business strategy → `docs/product/product.md`
- Phase sequencing → `docs/product/roadmap.md`
- Task-level Gherkin → `docs/work/{epic}/tasks.md` via **tasks**

## Context

[Epic row in backlog.md, solution.md, existing design.md if updating, codebase]

## Steps (walking-skeleton)

1. Read solution.md and epic in backlog.md
2. Draft §1–§6 per template
3. §4 must list what this epic did **not** ship

## Steps (TDD)

1. Read all context
2. Draft §1–§12 per template

## Pre-save validation

- [ ] Path is `docs/work/{epic}/design.md` with correct slug (≤2 words, not Epic ID)
- [ ] Solution cited by section; no duplicated architecture narrative
- [ ] No Gherkin task scenarios (gates/slice only)
- [ ] Mode-appropriate sections only (walking-skeleton vs tdd)
- [ ] DRAFTING AIDE block removed

## Output format

Save to `docs/work/{epic}/design.md`. Use [assets/design.template.md](assets/design.template.md).

## Gotchas

- **Do not copy solution.md** — cite `solution.md §{N.M}` instead.
- **Task Gherkin** belongs in `tasks.md`, not design (gates/slice scope only).
- **`walking-skeleton`** is 2–4 pages; **`tdd`** is 5–10 — do not mix section sets.
- **§4 Out of scope** must list what this epic explicitly did not ship.

## ADR candidates

Decisions recorded in `design.md` do not reach the architecture register on
their own. After the epic ships, run `adr plan <epic>` to harvest them — it
triages each candidate into promote, inline, or defer, and hands the promoted
ones to **adr write**.

## Supporting files

- [assets/design.template.md](assets/design.template.md)
- [examples/checkout-foundation.md](examples/checkout-foundation.md)

## Related skills

- `tasks`, `solution`, `adr`
- `docs-review` — review or critique an existing design.md
