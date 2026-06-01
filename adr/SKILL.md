---
name: adr
description: |
  Architecture decisions under docs/architecture/decisions/. Modes: plan (update
  register.md proposed-ADR tables), write (ADR-NNNN.md), review (finalise draft ADR).
  Use for ADR plan, write an ADR, review this ADR. No separate plan files — proposals
  live as tables in register.md.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<mode: plan|write|review> <target> [flags]"
---

# ADR

## Paths

| Artefact | Path |
| -------- | ---- |
| Register (index + proposed ADR tables) | `docs/architecture/decisions/register.md` |
| ADR document | `docs/architecture/decisions/ADR-{NUMBER}-{short-title}.md` |

## Router

1. Mode: `plan`, `write`, or `review`.
2. [prompts/plan.prompt.md](prompts/plan.prompt.md) — updates **register.md** only.
3. [prompts/write.prompt.md](prompts/write.prompt.md) | [prompts/review.prompt.md](prompts/review.prompt.md).
