---
name: docs
description: |
  Pre-sprint alignment (review) or sprint-end documentation pass (refine) for an epic.
  Product and solution under docs/; epic artefacts under work/{epic}/.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: review|refine> <epic> [--context <notes>]"
---

# Docs

Pre-sprint and sprint-end passes on product, solution, and epic design.

## Default paths

| Artefact | Default |
| -------- | ------- |
| Product | `docs/product/product.md` |
| Solution | `docs/architecture/solution.md` |
| ADR register | `docs/architecture/decisions/register.md` |
| Epic design | `work/{epic}/design.md` |
| Refine session | `work/{epic}/refine-session.md` |

`{epic}` is the title or short title slug (max two words) — see **backlog** SKILL.md.

## Path resolution

User-named paths override defaults.

## Supporting files

- [assets/refine-session.template.md](assets/refine-session.template.md)

## Router

1. Mode: `review` or `refine`.
2. Resolve `{epic}` from argument or backlog.
3. One prompt under [prompts/](prompts/).
