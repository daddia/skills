---
name: write-backlog
description: |
  Drafts backlog.md (alias for backlog write mode). Use when the user mentions
  "backlog", "epic list", "stories", "decompose", or "write the backlog for
  {domain}". Prefer **backlog** with mode write. Domain scope defaults to Now
  phase only — use --depth full for all phases. Do NOT use for solution
  architecture — use write-solution. Do NOT use for roadmaps — use write-roadmap.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
argument-hint: "<scope: portfolio|product|domain|work-package> <name> [--depth full]"
---

# Write Backlog (alias)

Redirects to the **backlog** skill with mode `write`.

1. Read [../backlog/SKILL.md](../backlog/SKILL.md) and follow the router with mode **`write`**.
2. This skill's arguments are scope/name/flags only (no mode token): `$0` = scope, `$1` = name, `--depth` as in [../backlog/prompts/write.prompt.md](../backlog/prompts/write.prompt.md).
3. Read [../backlog/shared.md](../backlog/shared.md) and [../backlog/prompts/write.prompt.md](../backlog/prompts/write.prompt.md), then execute.

Install the canonical skill: `npx skills add daddia/skills/backlog`
