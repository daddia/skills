---
name: feature
description: |
  Implements a story against approved design.md and backlog.md. Use when the
  user mentions implement story, build the feature, or feature implementation.
  Do NOT use for code review — use code-review. Do NOT use for refactor after
  review — use code-refactor.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
  - Shell
argument-hint: "<mode: implement> <story-id>"
---

# Feature

Implements a story with approved requirements and design, against `design.md`
and `backlog.md`.

## Router

1. Mode is `implement` (default when user says "feature implement").
2. Follow [prompts/implement.prompt.md](prompts/implement.prompt.md).

Pass story id and context after the mode token.
