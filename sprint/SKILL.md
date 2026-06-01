---
name: sprint
description: |
  Sprint planning and retrospectives under work/sprint-{id}/. Modes: plan (sprint
  plan.md before the sprint), retrospective (honest retro after). Use for sprint
  plan, sprint retro, start sprint, end sprint. Do NOT update product strategy —
  use product refine. Do NOT break down tasks — use tasks.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: plan|retrospective> <sprint-id> [--context <notes>]"
---

# Sprint

## Artefacts

| Mode | Default path |
| ---- | ------------ |
| `plan` | `work/sprint-{id}/plan.md` |
| `retrospective` | `work/sprint-{id}/retrospective.md` |

Example: `work/sprint-3/plan.md`, `work/sprint-3/retrospective.md`.

## Path resolution

If the user names a different path under `work/`, use it. Resolve `{id}` from
the argument (e.g. `3`, `sprint-3`, `2026-W14`).

## Router

1. Mode: `plan` or `retrospective`.
2. Resolve sprint folder and output file.
3. [prompts/plan.prompt.md](prompts/plan.prompt.md) | [prompts/retrospective.prompt.md](prompts/retrospective.prompt.md).

## Supporting files

- [assets/sprint-plan.template.md](assets/sprint-plan.template.md)
- [assets/sprint-retrospective.template.md](assets/sprint-retrospective.template.md)

## Related skills

- `tasks`, `backlog`, `design`, `product`, `docs`
