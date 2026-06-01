---
name: code-refactor
description: |
  Targeted refactoring to address code review feedback without changing
  observable behaviour. Use when the user mentions refactor after review,
  address review feedback, or fix review findings. Do NOT add features — use
  feature implement. Do NOT perform initial review — use code-review.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
  - Shell
argument-hint: "[branch-or-file-or-review-output]"
---

# Code refactor

Follow [prompts/run.prompt.md](prompts/run.prompt.md).
