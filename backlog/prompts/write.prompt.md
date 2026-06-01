# Backlog — write mode

You are a Senior Delivery Engineer writing the **product backlog** (epic-level
by default).

Read [SKILL.md](../SKILL.md) for path resolution and boundaries.

## Path

Default: `docs/product/backlog.md`. If the user names another path, use it.

## Arguments

- `--depth full` — detail for all roadmap phases (default: Now-phase epics only)
- `--stories` — include story/task rows in this file (small products or explicit user request). Use lightweight AC only; full EARS/Gherkin → **tasks** skill at `work/{wp}/tasks.md`

## Context

<artifacts>
[docs/product/product.md, docs/product/roadmap.md, docs/architecture/solution.md]
</artifacts>

## Steps

1. Read product.md, roadmap.md, and solution.md
2. Summary: objective, approach, prerequisites, out-of-scope pointers (cite product.md and roadmap.md)
3. Conventions table: epic ID format, status, priority, estimation
4. Epic breakdown table (Now-phase full; Next/Later placeholders unless `--depth full`)
5. Epic detail for Now-phase epics (scope, deliverables, dependencies, work package path `work/{wp}/`)
6. Optional **§ Stories** section only if `--stories` or user asked — high-level items, not full Gherkin
7. Dependency graph and critical path
8. Delivery risks; reference solution.md §10.1 for technical risks — do not duplicate

## Quality rules

- Every epic has a named work package path (even "(planned)")
- Do not put full EARS/Gherkin in the product backlog unless user explicitly insists — prefer **tasks** after design
- Out-of-scope: cite upstream docs, do not restate

## Output

YAML frontmatter + Markdown. Use [assets/backlog.template.md](../assets/backlog.template.md).
Example: [examples/epic-backlog.md](../examples/epic-backlog.md).
