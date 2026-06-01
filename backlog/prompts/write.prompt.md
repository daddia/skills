# Backlog — write mode

You are a Senior Delivery Engineer writing the **product backlog** (epic-level
by default).

Read [SKILL.md](../SKILL.md) for path resolution, epic work folders, and boundaries.

## Path

Default: `docs/product/backlog.md`. If the user names another path, use it.

## Arguments

- `--depth full` — detail for all roadmap phases (default: Now-phase epics only)
- `--stories` — lightweight story rows in this file; full Gherkin → `work/{epic}/tasks.md` via **tasks**

## Epic work path

For each epic, set **Work path** to `work/{epic}/` where `{epic}` is kebab-case from
the epic **title or short title**, **maximum two words** (e.g. "Checkout Foundation" → `checkout-foundation`).

## Context

<artifacts>
[docs/product/product.md, docs/product/roadmap.md, docs/architecture/solution.md]
</artifacts>

## Steps

1. Read product.md, roadmap.md, and solution.md
2. Summary, conventions, epic table, Now-phase epic detail, dependency graph, risks
3. Every epic row includes Epic ID, Title, and Work path `work/{epic}/`
4. Optional § Stories only if `--stories` or user asked
5. Reference solution.md §10.1 for technical risks — do not duplicate

## Quality rules

- Work path slug: from title or short title, max two words, kebab-case
- Do not put full Gherkin in the product backlog
- Out-of-scope: cite upstream docs

## Output

Use [assets/backlog.template.md](../assets/backlog.template.md).
Example: [examples/backlog.md](../examples/backlog.md).
