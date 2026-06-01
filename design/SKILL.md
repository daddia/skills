---
name: design
description: |
  Epic design at work/{epic}/design.md: write (walking-skeleton or TDD) or review.
  Use for technical design before tasks. Cite solution.md — do not re-narrate.
  Do NOT use for product backlog — use backlog. Do NOT write tasks.md — use tasks.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: write|review> <epic> [flags]"
---

# Design

## Artefact

`work/{epic}/design.md` — implementation specification for one epic (walking-skeleton or TDD).

## Epic slug (`{epic}`)

Kebab-case from epic title or short title, max two words (see **backlog** SKILL.md). User may pass slug, epic ID, or full path.

## Path resolution

Default: `work/{epic}/design.md`. User-named paths under `work/` override.

## Supporting files

- [assets/design.template.md](assets/design.template.md)
- [examples/checkout-foundation.md](examples/checkout-foundation.md)

## Router

1. Mode: `write` or `review`.
2. Resolve `{epic}`.
3. [prompts/write.prompt.md](prompts/write.prompt.md) | [prompts/review.prompt.md](prompts/review.prompt.md).

**write** — `--mode walking-skeleton|tdd`.
