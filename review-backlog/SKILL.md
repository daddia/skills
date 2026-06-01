---
name: review-backlog
description: |
  Reviews backlog.md (alias for backlog review mode). Use when the user mentions
  "review the backlog", "is this backlog ready", or "are these stories ready".
  Prefer **backlog** with mode review. Do NOT use for grooming — use refine-backlog
  or backlog refine. Do NOT use to write a backlog — use write-backlog or backlog write.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<scope: portfolio|product|domain|work-package> <name>"
---

# Review Backlog (alias)

Redirects to the **backlog** skill with mode `review`.

1. Read [../backlog/SKILL.md](../backlog/SKILL.md) and follow the router with mode **`review`**.
2. This skill's arguments are scope/name only: `$0` = scope, `$1` = name.
3. Read [../backlog/shared.md](../backlog/shared.md) and [../backlog/prompts/review.prompt.md](../backlog/prompts/review.prompt.md), then execute.

Install the canonical skill: `npx skills add daddia/skills/backlog`
