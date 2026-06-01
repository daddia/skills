---
name: refine-backlog
description: |
  Refines backlog.md (alias for backlog refine mode). Use when the user mentions
  "refine the backlog", "groom the backlog", or "the backlog is stale". Prefer
  **backlog** with mode refine. Do NOT use to write from scratch — use write-backlog
  or backlog write. Do NOT use for a quality review — use review-backlog or backlog review.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<scope: portfolio|product|domain|work-package> <name> [--context <notes>]"
---

# Refine Backlog (alias)

Redirects to the **backlog** skill with mode `refine`.

1. Read [../backlog/SKILL.md](../backlog/SKILL.md) and follow the router with mode **`refine`**.
2. This skill's arguments are scope/name/flags only: `$0` = scope, `$1` = name, `--context` as in refine prompt.
3. Read [../backlog/shared.md](../backlog/shared.md) and [../backlog/prompts/refine.prompt.md](../backlog/prompts/refine.prompt.md), then execute.

Install the canonical skill: `npx skills add daddia/skills/backlog`
