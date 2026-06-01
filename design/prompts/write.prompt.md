# Design — write mode

You are a Senior Software Architect writing epic-level `design.md` for
`work/{epic}/`. Resolve `{epic}` from the argument or `docs/product/backlog.md`.

Read [SKILL.md](../SKILL.md) and [backlog/SKILL.md](../../backlog/SKILL.md).

Parent solution: `docs/architecture/solution.md` — cite sections; do not re-narrate.

## Mode (`--mode`)

- `walking-skeleton` — Phase 0, 2–4 pages
- `tdd` — Sprint 2+, 5–10 pages

## Negative constraints

Do NOT put in design.md:

- Architecture-wide patterns already in solution.md — cite `solution.md §{N.M}`
- Business strategy → `docs/product/product.md`
- Phase sequencing → `docs/product/roadmap.md`
- Task-level Gherkin → `work/{epic}/tasks.md` via **tasks**

Delete the `DRAFTING AIDE` block before saving.

## Context

[Epic row in backlog.md, solution.md, existing design.md if updating, codebase]

## Steps (walking-skeleton)

1. Read solution.md and epic in backlog.md
2. §1 The slice, §2 Files shipped, §3 Acceptance gates, §4 Out of scope for this epic
3. §5 Open questions closed, §6 Handoff to next epic

## Steps (TDD)

1. Read all context
2. §1 Scope, §2 Architecture fit, §3 Files, §4 Data contracts, §5 Runtime view
3. §6 Cross-squad coordination (if applicable), §7 Error paths, §8 Observability
4. §9 Testing strategy, §10 Acceptance gates, §11 Handoff, §12 Open questions

## Output

Save to `work/{epic}/design.md`. Use [assets/design.template.md](../assets/design.template.md).
